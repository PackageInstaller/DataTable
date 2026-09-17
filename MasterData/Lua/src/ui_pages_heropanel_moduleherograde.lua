local this = class("moduleHeroGrade", require("ui.pages.heroPanel.moduleHeroBase"))
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
local L_AreaName = {
  cellStarArea = "CellStarArea"
}
local L_Shortkey = {
  shortKeyR3 = "GamepadUI_R3",
  shortKeyL3 = "GamepadUI_L3"
}
local L_R3IconScale = {
  [1] = 1.0,
  [3] = 2.0,
  [5] = 1.5
}

function this.bind()
  return {
    cellHeroStarItem = {
      moduleName = "pages/HeroPanel/hero/cellHeroStarItem"
    },
    go_pureObjs = true,
    pos_point1 = C_Vector3.zero,
    pos_point3 = C_Vector3.zero,
    pos_point5 = C_Vector3.zero,
    go_mask = false
  }
end

function this.methods()
  return {
    cellHeroStarItem = {
      showSkill = function(self, bool, skill, index, attr, rwd)
        self.skillIndex = index
        L_UI:open("pageHeroGradeDetail", {
          heroGuid = self.heroGuid,
          heroConfigId = self.heroConfigId,
          heroStar = self.heroStar,
          index = index,
          gradeCount = self.gradeCount,
          isPreview = self:getModeController():isPreviewMode(),
          skill = skill,
          attr = attr,
          rwd = rwd,
          onUpgradeSuccess = handler(self, self.onUpgradeSuccess)
        })
      end,
      onStarSelected = function(self, index)
        self._selectedStarIndex = index
        self:updateStarGamepadIcon(index)
      end
    },
    onClick_pure = function(self)
      self.pureState = true
      local animGrade = self.bindComponents.anim_grade
      if animGrade then
        animGrade:Stop()
        animGrade:Play(self.pureState and "anim_pageHeroGrade_conceal" or "anim_pageHeroGrade_show")
      end
      AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(not self.pureState)
      self.parent:setDownBg(false)
      self.parent:refreshCanChangeHero(false)
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
        self.parent:setDownBg(true)
        self.parent:refreshCanChangeHero(false)
        self:popToCellStarArea()
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

function this:onUpgradeSuccess(skillIndex, rwd, describe, title)
  self.skillIndex = skillIndex
  self:setStarItemsPauseUpdate(true)
  L_PlayerManager:playHeroVoice(self.heroConfigId, L_Const.cvType.StarUp)
  local openOptions = {
    heroId = self.heroGuid,
    describe = describe,
    rwd = rwd,
    title = title,
    index = skillIndex,
    closeCallback = function()
      local clipLength = self:playUnlockAnim()
      L_TimerManager:newOrResetTimer(self, "gradeLoopDelay", function()
        self:upStarSet()
        self:setStarItemsPauseUpdate(false)
        L_TimerManager:newOrResetTimer(self, "showRwdDelay", function()
          self:showReward(rwd)
          self.bind.go_mask = false
        end, 0.3)
      end, clipLength)
    end
  }
  L_UI:open("pageHeroGradeAdvanceSuccess", openOptions)
  L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_NodeActivate")
  self.bind.go_mask = true
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

function this:open()
  self.bind.go_mask = false
  self.skillIndex = 0
  L_ShortCutManager:registerShortCut(self.parent.pageName, C_InputManager_KeyType.EGamepadUI_R3, function()
    self:onGamepadR3()
  end)
  L_ShortCutManager:registerShortCut(self.parent.pageName, C_InputManager_KeyType.EGamepadUI_L3, function()
    self:onGamepadL3()
  end)
end

function this:initPage(params, preOpenInit)
  this.super.initPage(self)
  self:upStarSet(true)
end

function this:closePage()
  if self.pureState then
    self.pureState = false
    local animGrade = self.bindComponents.anim_grade
    if animGrade then
      animGrade:Stop()
      animGrade:Play("anim_pageHeroGrade_show")
    end
    self.parent:setDownBg(true)
    self.parent:refreshCanChangeHero(false)
  end
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(true)
end

function this:close()
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
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(true)
  L_ShortCutManager:clearShortKeyFlag(self)
  self._selectedStarIndex = nil
  L_ShortCutManager:unregisterShortCut(self.parent.pageName, C_InputManager_KeyType.EGamepadUI_R3)
  L_ShortCutManager:unregisterShortCut(self.parent.pageName, C_InputManager_KeyType.EGamepadUI_L3)
end

function this:upStarSet(refresList)
  if refresList then
    self.heroGuid = self:getModeController():getSelectGuid()
    local heroData = AzurWorld.heroMgr:GetHero(self.heroGuid)
    self.heroConfigId = heroData and heroData.configId or L_HeroStore:getHeroConfigId(self:getModeController():getHero(self.heroGuid))
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
    self.gradeCount = heroGradeTpl and #heroGradeTpl or 6
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
    self.bind.cellHeroStarItem:insert_array(skillDataTemp)
  end
  self:refreshHeroStar()
end

function this:refreshHeroStar()
  self.heroGuid = self:getModeController():getSelectGuid()
  local heroData = AzurWorld.heroMgr:GetHero(self.heroGuid)
  self.heroConfigId = heroData and heroData.configId or L_HeroStore:getHeroConfigId(self:getModeController():getHero(self.heroGuid))
  local hero = self:getModeController():getHero(self.heroGuid)
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
  local hero = self:getModeController():getHero(self.heroGuid)
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
  self:updateDefaultNavIndex()
end

function this:setStarItemsPauseUpdate(pause)
  for _, starItem in pairs(self.modules.cellHeroStarItem) do
    starItem:setCloseReddot(pause)
  end
end

function this:onGamepadR3()
  local state = C_UIPageAreaStateMachine.instance.CurrentState
  if state == nil or state.pageName ~= self.parent.pageName or state.areaName ~= L_AreaName.cellStarArea then
    return
  end
  local index = self._selectedStarIndex
  if not index then
    return
  end
  if index % 2 == 1 and self.heroStar and index <= self.heroStar then
    self:openGradePic(index)
  end
end

function this:onGamepadL3()
  local state = C_UIPageAreaStateMachine.instance.CurrentState
  if state == nil or state.pageName ~= self.parent.pageName or state.areaName ~= L_AreaName.cellStarArea then
    return
  end
  local index = self._selectedStarIndex
  if self.heroStar and self.heroStar >= 6 then
    self:openGradePic(6)
  end
end

function this:updateDefaultNavIndex()
  local navbinding = self.bindComponents.UINavigationBinding
  if not navbinding then
    return
  end
  local heroId = self.heroGuid
  if not heroId then
    return
  end
  local defaultIdx = 0
  if L_ReddotManager.DotDef.HeroGrade then
    for i = 1, 6 do
      local dotKey = string.format(L_ReddotManager.DotDef.HeroGrade, heroId .. "_" .. i)
      local hasRedDot = AzurWorld.RedDotMgr:GetRedDotState(dotKey, false)
      if hasRedDot then
        defaultIdx = i - 1
        break
      end
    end
  end
  local area = navbinding:FindAreaByName(L_AreaName.cellStarArea)
  if area and area.bindingConfigs and 0 < area.bindingConfigs.Length then
    area.bindingConfigs[0].defaultSelectedIndex = defaultIdx
  end
end

function this:updateStarGamepadIcon(index)
  L_ShortCutManager:removeShortKeyFlag(self, L_Shortkey.shortKeyR3)
  if index % 2 == 1 and self.heroStar and index <= self.heroStar then
    local imgPoint = self.bindComponents["img_point" .. index]
    if imgPoint then
      L_ShortCutManager:addShortKeyFlag(self, L_Shortkey.shortKeyR3, L_Const.AnchorType.TopRight, imgPoint.transform, L_Vector3.new(-50, -50, 0), L_R3IconScale[index] or 1.0)
    end
  end
  L_ShortCutManager:removeShortKeyFlag(self, L_Shortkey.shortKeyL3)
  if self.heroStar and self.heroStar >= 6 then
    local imgBg = self.bindComponents.img_bg
    if imgBg then
      L_ShortCutManager:addShortKeyFlag(self, L_Shortkey.shortKeyL3, L_Const.AnchorType.Top, imgBg.transform, L_Vector3.new(0, -100, 0), 2.0)
    end
  end
end

function this:popToCellStarArea()
  local state = C_UIPageAreaStateMachine.instance.CurrentState
  if state and state.areaName ~= L_AreaName.cellStarArea then
    C_UIPageAreaStateMachine.instance:Pop()
  end
end

function this:getTimelineState()
  return L_Const.heroTimelineState.None
end

function this:getCanClose()
  return true
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
