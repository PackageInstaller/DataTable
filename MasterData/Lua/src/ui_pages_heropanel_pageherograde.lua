local this = class("pageHeroGrade", G_UIPageBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local _wordsTpl = L_GameTpl:getWordsTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _heroGradeTpl = L_GameTpl:getHeroGradeTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local pointPos = {
  {x = -322.2, y = -3},
  {x = 293, y = -5.9},
  {x = 63.3, y = 83.1},
  {x = -167, y = 163},
  {x = 195.3, y = 249},
  {x = 4.2, y = 380.6}
}

function this.bind()
  return {
    cellHeroStarItem = {
      moduleName = "pages/HeroPanel/hero/cellHeroStarItem"
    },
    skillDetails = false,
    skillDescribe = "",
    skillTitle = "",
    breakBtn = false,
    gradeItem = L_Const.ModuleInfo.CellIconBag,
    go_item = false,
    go_active = false,
    go_inactive = false,
    go_pureObjs = true,
    list_rewards = {
      moduleName = "modulePages/cellIconCircle"
    },
    go_rewards = true,
    pos_point1 = C_Vector3.zero,
    pos_point3 = C_Vector3.zero,
    pos_point5 = C_Vector3.zero,
    go_gapRewards = false,
    go_gapCellIcon = false,
    go_gapBoth = false,
    go_mask = false
  }
end

function this.methods()
  return {
    cellHeroStarItem = {
      showSkill = function(self, bool, skill, index, attr, rwd)
        self.skillIndex = index
        self:skillDetails(bool, skill, index, attr, rwd)
        self.bindComponents.canvas.gameObject:SetLayerWithChildren(Unity.LayerMask.NameToLayer("UI_TopLayer"))
      end
    },
    onClick_breakBtn = function(self)
      if self.modelController:isPreviewMode() then
        return
      end
      if self.skillIndex - self.heroStar == 1 then
      else
        L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_hero_lifeUnlock"))
        return
      end
      if self.upStar then
      else
        L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_common_lackItem"))
        return
      end
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroStarUpgrade))
        return
      end
      AzurWorld.heroMgr:ReqGradeUpHero(self.heroGuid, function(errCode, data)
        if errCode == L_Const.errorCode.ErrCodeSucc then
          self:setStarItemsPauseUpdate(true)
          local heroGradeTpl = _heroGradeTpl:getTplByHeroIdAndGrade(self.heroConfigId)[self.skillIndex]
          local rwdOrderList = _heroGradeTpl:getRwd(heroGradeTpl)
          local rwdTable = {}
          for i = 0, data.rewards.Count - 1 do
            table.insert(rwdTable, {
              itemid = data.rewards[i].itemid,
              itemtype = data.rewards[i].itemtype,
              itemnum = data.rewards[i].itemnum
            })
          end
          local rwd = L_DataUtil.parseRewardConfig(rwdTable, true, true, rwdOrderList)
          L_PlayerManager:playHeroVoice(self.heroConfigId, L_Const.cvType.StarUp)
          self:setDetailState(false)
          local openOptions = {
            heroId = self.heroGuid,
            describe = self.bind.skillDescribe,
            rwd = rwd,
            title = self.bind.skillTitle,
            index = self.skillIndex,
            closeCallback = function()
              if self.closed then
                return
              end
              local clipLength = self:playUnlockAnim()
              L_TimerManager:newOrResetTimer(self, "gradeLoopDelay", function()
                if self.closed then
                  return
                end
                self:upStarSet()
                self:setStarItemsPauseUpdate(false)
                if self.closed then
                  return
                end
                L_TimerManager:newOrResetTimer(self, "showRwdDelay", function()
                  if self.closed then
                    return
                  end
                  self:showReward(rwd)
                  self.bind.go_mask = false
                end, 0.3)
              end, clipLength)
            end
          }
          L_UI:open("pageHeroGradeAdvanceSuccess", openOptions)
          L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_NodeActivate")
          self.bind.go_mask = true
          self.bind.breakBtn = false
        end
      end)
    end,
    onClick_closeDetail = function(self)
      self:setDetailState(false)
    end,
    onClick_pure = function(self)
      self.pureState = true
      local animGrade = self.bindComponents.anim_grade
      if animGrade then
        animGrade:Stop()
        animGrade:Play(self.pureState and "anim_pageHeroGrade_conceal" or "anim_pageHeroGrade_show")
      end
      AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(not self.pureState)
    end,
    onClick_bg = function(self)
      if self.pureState then
        self.pureState = false
        local animGrade = self.bindComponents.anim_grade
        if animGrade then
          animGrade:Stop()
          animGrade:Play("anim_pageHeroGrade_show")
        end
        AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(not self.pureState)
      end
    end,
    onClick_pointBg = function(self)
      self:openGradePic(6)
    end,
    onClick_point1 = function(self)
      self:openGradePic(1)
    end,
    onClick_point3 = function(self)
      self:openGradePic(3)
    end,
    onClick_point5 = function(self)
      self:openGradePic(5)
    end
  }
end

function this:showReward(rwd)
  if 0 < #rwd then
    local rewards = {}
    for i, v in ipairs(rwd) do
      table.insert(rewards, {
        itemid = v.itemId,
        itemtype = v.itemType,
        itemnum = v.itemNum
      })
    end
    L_RewardManager:showPage(rewards)
  end
end

function this:playUnlockAnim()
  local idx = self.skillIndex
  local starItemModule = self.modules.cellHeroStarItem[idx]
  local cellClipLength = 0
  if starItemModule then
    cellClipLength = starItemModule:playUnlock()
  end
  local unlockClipLength = 0
  if idx % 2 == 1 then
    local animComp = self.bindComponents["anim_point" .. idx]
    if animComp then
      animComp:Stop()
      local clipName = "anim_pageHeroGrade_fate_" .. idx
      animComp:Play(clipName)
      local clip = animComp:GetClip(clipName)
      if clip then
        unlockClipLength = clip.length
      end
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_Activate_01")
  else
    local animComp = self.bindComponents.anim_point
    if animComp then
      animComp:Stop()
      local clipName = "anim_pageHeroGrade_content_root_" .. idx
      animComp:Play(clipName)
      local clip = animComp:GetClip(clipName)
      if clip then
        unlockClipLength = clip.length
      end
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_Activate_02")
  end
  local animLight = self.bindComponents.anim_light
  local lightClipName = 6 <= idx and "anim_pageHeroGrade_light_6" or "anim_pageHeroGrade_light_1-5"
  local lightClipLength = 2
  if animLight then
    animLight:Stop()
    animLight:Play(lightClipName)
    local clip = animLight:GetClip(lightClipName)
    if clip then
      lightClipLength = clip.length
    end
    L_TimerManager:newOrResetTimer(self, "lightLoopDelay", function()
      animLight:Play(lightClipName .. "_loop")
    end, 1.5)
  end
  return math.max(cellClipLength, unlockClipLength)
end

function this:open(options)
  self.closed = false
  self.modelController = options.modelController
  self.skillIndex = 0
  self.bindComponents.order_canvas.parentCanvas = self.bindComponents.gradeCanvas
  self:upStarSet(true)
end

function this:close()
  self.closed = true
  L_TimerManager:stopTimer(self, "gradeLoopDelay")
  L_TimerManager:stopTimer(self, "showRwdDelay")
  L_TimerManager:stopTimer(self, "gradeAdvanceDelay")
  L_TimerManager:stopTimer(self, "lightLoopDelay")
  if self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
  if L_CommonUtil.isValid(self.handle1) and self.handle1.IsValid then
    self.handle1:Dispose()
  end
  self.handle1 = nil
  if L_CommonUtil.isValid(self.handle2) and self.handle2.IsValid then
    self.handle2:Dispose()
  end
  self.handle2 = nil
end

function this:getModeController()
  return self.modelController
end

function this:upStarSet(refresList)
  if refresList then
    self.heroGuid = self:getModeController():getSelectGuid()
    local heroData = AzurWorld.heroMgr:GetHero(self.heroGuid)
    self.heroConfigId = heroData and heroData.configId or L_HeroStore:getHeroConfigId(self.modelController:getHero(self.heroGuid))
    self.skillId = 0
    local heroTpl = _heroTpl:getTplById(self.heroConfigId)
    local template = _heroTpl:getHeroGradeTemplate(heroTpl)
    table.clear(pointPos)
    for i = 1, 6 do
      local pos = self.bindComponents["type" .. template]:GetChild(i - 1).localPosition
      table.insert(pointPos, pos)
    end
    for i = 1, 3 do
      local pos = self.bindComponents["picType" .. template]:GetChild(i - 1).localPosition
      self.bind["pos_point" .. i * 2 - 1] = pos
    end
    local heroGradeTpl = _heroGradeTpl:getTplByHeroIdAndGrade(self.heroConfigId)
    local skillDataTemp = {}
    local heroGrad
    self.bind.cellHeroStarItem:clear()
    if heroGradeTpl then
      for i = 1, #heroGradeTpl do
        local skillDetail = {
          skill = heroGradeTpl[i].mainSkill,
          index = i,
          isPreview = self:getModeController():isPreviewMode(),
          heroId = self.heroGuid,
          toggle = false,
          pos = pointPos[i],
          attr = heroGradeTpl[i].mainAttr,
          title = _heroGradeTpl:getTitle(heroGradeTpl[i]),
          rwd = _heroGradeTpl:getRwd(heroGradeTpl[i])
        }
        table.insert(skillDataTemp, skillDetail)
      end
    end
    self.bindComponents.rect_frame:SetParent(self.bindComponents["frame_pos" .. template].transform)
    self.bindComponents.rect_frame.localPosition = C_Vector3.zero
    self:setDetailState(false, not refresList)
    self.bind.cellHeroStarItem:insert_array(skillDataTemp)
  end
  self:refreshHeroStar()
end

function this:refreshHeroStar()
  self.heroGuid = self:getModeController():getSelectGuid()
  local heroData = AzurWorld.heroMgr:GetHero(self.heroGuid)
  self.heroConfigId = heroData and heroData.configId or L_HeroStore:getHeroConfigId(self.modelController:getHero(self.heroGuid))
  local hero = self.modelController:getHero(self.heroGuid)
  self.heroStar = L_HeroStore:getHeroStar(hero)
  for i = 1, #self.bind.cellHeroStarItem do
    local bool = false
    if i > self.heroStar then
      bool = true
    end
    self.bind.cellHeroStarItem:change(i, {unLock = bool})
    local starItem = self.modules.cellHeroStarItem[i]
    if starItem then
      starItem:setUnlockState(i <= self.heroStar)
    end
    if i % 2 == 1 then
      local animComp = self.bindComponents["anim_point" .. i]
      if animComp then
        local clipName = "anim_pageHeroGrade_fate_" .. i .. "_unlock"
        if i <= self.heroStar then
          animComp:Play(clipName)
        end
      end
    end
  end
  local hero = self.modelController:getHero(self.heroGuid)
  self.heroStar = L_HeroStore:getHeroStar(hero)
  local defaultCfgId = 108003
  local cfgId = self.heroConfigId or defaultCfgId
  local folder = "Assets/ResourcesAssets/UI/Texture/HeroGrade/"
  local suffix = ".png"
  
  local function resolveGradeAssetCfgId(assetSuffix)
    local assetPath = folder .. "tex_hero_grade_" .. cfgId .. assetSuffix .. suffix
    return C_LuaUtility.ExistsAsset(assetPath) and cfgId or defaultCfgId
  end
  
  for i = 1, 6, 2 do
    local assetSuffix = "_illustration_0" .. i .. "_unlock"
    local assetCfgId = resolveGradeAssetCfgId(assetSuffix)
    local imgPath = "tex_hero_grade_" .. assetCfgId .. assetSuffix
    self.bindComponents["img_point" .. i]:LoadSprite(folder .. imgPath .. suffix, false)
    local canvasGroup = self.bindComponents["img_point" .. i]:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if canvasGroup then
      canvasGroup.alpha = i <= self.heroStar and 1 or 0
    end
    local assetSuffixGray = "_illustration_0" .. i .. "_lock"
    local imgPathGray = "tex_hero_grade_" .. assetCfgId .. assetSuffixGray
    self.bindComponents["img_point" .. i .. "_gray"]:LoadSprite(folder .. imgPathGray .. suffix, false)
  end
  local bgCfgId = resolveGradeAssetCfgId("_bg_lock")
  self.bindComponents.img_bg:LoadSprite(folder .. "tex_hero_grade_" .. bgCfgId .. "_bg_lock.png", false)
  local heroTpl = _heroTpl:getTplById(self.heroConfigId)
  local template = _heroTpl:getHeroGradeTemplate(heroTpl)
  self.handle2 = C_LuaUtility.LoadTexture("Assets/Arts/UI_FX/Heroes/Grade/tex_hero_grade_mask_0" .. template .. ".png", function(tex)
    self.bindComponents.img_bg.material:SetTexture("_MaskTex", tex)
  end)
  local bgCfgId1 = resolveGradeAssetCfgId("_bg_unlock")
  self.handle1 = C_LuaUtility.LoadTexture(folder .. "tex_hero_grade_" .. bgCfgId1 .. "_bg_unlock.png", function(tex1)
    self.bindComponents.img_bg.material:SetTexture("_BaseMap02", tex1)
  end)
  if self.heroStar > 1 then
    local animComp = self.bindComponents.anim_point
    if animComp then
      animComp:Stop()
      animComp:Play("anim_pageHeroGrade_content_root_" .. self.heroStar - self.heroStar % 2 .. "_unlock")
    end
  end
  local animLight = self.bindComponents.anim_light
  if animLight then
    animLight:Stop()
    if self.heroStar >= 6 then
      animLight:Play("anim_pageHeroGrade_light_6_loop")
    else
      animLight:Play("anim_pageHeroGrade_light_1-5_loop")
    end
  end
end

function this:setStarItemsPauseUpdate(pause)
  for _, starItem in pairs(self.modules.cellHeroStarItem) do
    starItem:setCloseReddot(pause)
  end
end

function this:setDetailState(show, immediate)
  if show then
    self.bind.skillDetails = true
  elseif immediate then
    self.bind.skillDetails = false
  else
    self.bindComponents.anim_detail:Play("anim_pageHeroGrade_go_detail_out")
    L_TimerManager:newOrResetTimer(self, "hideDetail", function()
      self.bind.skillDetails = false
    end, 0.1)
  end
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(not show)
  L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_Activate" .. (show and "Open" or "Close"))
end

function this:skillDetails(bool, skills, index, attrs, rwd)
  self:setDetailState(true)
  self.bind.skillDescribe = ""
  self.bind.list_rewards:clear()
  local reward = L_DataUtil.parseRewardConfig(rwd)
  self.bind.list_rewards:insert_array(reward)
  for _, v in pairs(self.modules.list_rewards) do
    v:setClaimedState(self.heroStar >= self.skillIndex)
  end
  local hasRewards = reward and 0 < #reward
  local hasItem = self.heroStar < self.skillIndex
  self.bind.go_gapBoth = false
  self.bind.go_gapRewards = false
  self.bind.go_gapCellIcon = false
  if not hasRewards and not hasItem then
    self.bind.go_gapBoth = true
  elseif not hasRewards then
    self.bind.go_gapRewards = true
  elseif not hasItem then
    self.bind.go_gapCellIcon = true
  end
  self.bind.go_rewards = hasRewards
  self.bindComponents.img_grade:LoadSprite("Assets/Arts/UI/Page/HeroPanel/HeroGradeFate/tex_hero_grade_icon_0" .. index .. "_illustration.png", false)
  local heroGradeTpl = _heroGradeTpl:getTplByHeroIdAndGrade(self.heroConfigId)[index]
  local desc = _heroGradeTpl:getDesc(heroGradeTpl)
  local descParams = {}
  local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
  for i = 1, #attrs do
    local attr = attrs[i]
    if #attr == 2 then
      local attrName = battleInfoTpl:getName(battleInfoTpl:getTplById(attr[1]))
      descParams[(i - 1) * 2] = attrName
      descParams[(i - 1) * 2 + 1] = battleInfoTpl:getShowTxt(attr[1], attr[2])
    else
      C_MJLog.LogError("属性配置错误,长度不为2")
    end
  end
  self.bind.skillTitle = _heroGradeTpl:getTitle(heroGradeTpl)
  self.bind.skillDescribe = L_Lang:fmt(desc, descParams)
  bool = self.heroStar ~= self.skillIndex - 1
  if self.modelController:isPreviewMode() then
    bool = true
  end
  self.bind.go_item = hasItem
  self.bind.go_active = self.heroStar >= self.skillIndex
  self.bind.go_inactive = self.heroStar < self.skillIndex - 1
  if bool then
    self.bind.breakBtn = false
  else
    self.bind.breakBtn = true
    local hero = self.modelController:getHero(self.heroGuid)
    local heroItem = L_ItemManager:parseHeroItem(L_HeroStore:getHeroConfigId(hero))
    local heroIconAvatar = L_GameUtil.getAvatarTexturePath(L_HeroStore:getHeroConfigId(hero), L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
  end
  local heroTpl = _heroTpl:getTplById(self.heroConfigId)
  local hero = self.modelController:getHero(self.heroGuid)
  local heroStar = L_HeroStore:getHeroStar(hero)
  if heroTpl and heroStar < #heroTpl.gradeUpItem then
    local gradeUpItem = heroTpl.gradeUpItem[heroStar + 1]
    if #gradeUpItem == 2 then
      local itemId = gradeUpItem[1]
      local itemNum = gradeUpItem[2]
      local txt
      if 1 <= C_BagMgr:getItemNumByItemId(itemId) then
        txt = string.format("%s/%s", C_BagMgr:getItemNumByItemId(itemId), gradeUpItem[2])
        self.upStar = true
      else
        txt = string.format("<color=#fc2b2c>%s</color>/%s", C_BagMgr:getItemNumByItemId(itemId), itemNum)
        self.upStar = false
      end
      local cellIcon = self.modules.gradeItem
      cellIcon:setGeneralContent(L_Const.resType.commonItem, itemId, {itemNumTxt = txt})
    else
      C_MJLog.LogError("消耗长度不为2，hero表id:" .. self.heroConfigId)
    end
  end
end

function this:getTimelineState()
  return L_Const.heroTimelineState.Skill
end

function this:escHandle()
  if self.bind.skillDetails then
    self:setDetailState(false)
  else
    L_UI:close("pageHeroGrade")
  end
end

function this:openGradePic(index)
  if index <= self.heroStar then
    L_UI:open("pageHeroGradePic", {
      heroId = self.heroConfigId,
      index = index
    })
  else
    self.methods.onClick_bg(self)
  end
end

return this
