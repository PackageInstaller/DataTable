local this = class("pageHeroGradeDetail", G_UIPageBase)
local _wordsTpl = L_GameTpl:getWordsTpl()
local _heroGradeTpl = L_GameTpl:getHeroGradeTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    skillDescribe = "",
    skillTitle = "",
    breakBtn = false,
    gradeItem = L_Const.ModuleInfo.CellIconBag,
    go_item = false,
    btnRoot = true,
    go_active = false,
    go_inactive = false,
    list_rewards = {
      moduleName = "modulePages/cellIconCircle"
    },
    go_rewards = true,
    go_gapRewards = false,
    go_gapCellIcon = false,
    go_gapBoth = false
  }
end

function this.methods()
  return {
    onClick_breakBtn = function(self)
      if self.isPreview then
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
          AzurWorld.RedDotMgr:MarkDirty(string.format("HeroGrade_%s", self.heroGuid))
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
          self.bind.breakBtn = false
          if self.onUpgradeSuccess then
            self.onUpgradeSuccess(self.skillIndex, rwd, self.bind.skillDescribe, self.bind.skillTitle)
          end
          L_UI:close("pageHeroGradeDetail")
        end
      end)
    end,
    onClick_closeDetail = function(self)
      self:setDetailState(false)
    end
  }
end

function this:preOpen(options)
  self.heroGuid = options.heroGuid
  self.heroConfigId = options.heroConfigId
  self.heroStar = options.heroStar
  self.skillIndex = options.index
  self.gradeCount = options.gradeCount
  self.isPreview = options.isPreview
  self.onUpgradeSuccess = options.onUpgradeSuccess
  self:skillDetails(self.heroStar < options.index, options.skill, options.index, options.attr, options.rwd)
end

function this:close()
  L_TimerManager:stopTimer(self, "hideDetail")
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarVisible(true)
end

function this:setDetailState(show, immediate)
  if not show then
    L_UI:close("pageHeroGradeDetail")
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_StringTuning_Activate" .. (show and "Open" or "Close"))
end

function this:switchDetail(index)
  self.skillIndex = index
  local heroGradeTpl = _heroGradeTpl:getTplByHeroIdAndGrade(self.heroConfigId)
  if not heroGradeTpl or not heroGradeTpl[index] then
    return
  end
  local gradeTpl = heroGradeTpl[index]
  self:skillDetails(index > self.heroStar, gradeTpl.mainSkill, index, gradeTpl.mainAttr, _heroGradeTpl:getRwd(gradeTpl))
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
  self.bind.go_item = hasItem
  if self.isPreview then
    bool = true
    self.bind.btnRoot = false
    self.bind.go_item = false
  end
  self.bind.go_active = self.heroStar >= self.skillIndex
  self.bind.go_inactive = self.heroStar < self.skillIndex - 1
  if bool then
    self.bind.breakBtn = false
  else
    self.bind.breakBtn = true
  end
  local heroTpl = _heroTpl:getTplById(self.heroConfigId)
  if heroTpl and self.heroStar < #heroTpl.gradeUpItem then
    local gradeUpItem = heroTpl.gradeUpItem[self.heroStar + 1]
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

return this
