local ActivityLevelsSelectCtrl = class("ActivityLevelsSelectCtrl", BaseCtrl)
local mapToggle = {
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4,
  [5] = GameEnum.diffculty.Diffculty_5,
  [6] = GameEnum.diffculty.Diffculty_6,
  [7] = GameEnum.diffculty.Diffculty_7,
  [8] = GameEnum.diffculty.Diffculty_8,
  [9] = GameEnum.diffculty.Diffculty_9,
  [10] = GameEnum.diffculty.Diffculty_10
}
ActivityLevelsSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  togTypeExplore = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeExplore"
  },
  togTypeExploreCtrl = {
    sNodeName = "togTypeExplore",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsToggleCtrl"
  },
  redExploreUnSelect = {},
  redExploreSelect = {},
  togTypeAdventure = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeAdventure"
  },
  togTypeAdventureCtrl = {
    sNodeName = "togTypeAdventure",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsToggleCtrl"
  },
  redAdventureUnSelect = {},
  redAdventureSelect = {},
  togTypeHard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeHard"
  },
  togTypeHardCtrl = {
    sNodeName = "togTypeHard",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsToggleCtrl"
  },
  redHardUnSelect = {},
  redHardSelect = {},
  ExploreRoot = {},
  ExploreLVList = {
    sNodeName = "ExploreLV_",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsLvCtrl",
    nCount = 8
  },
  AdventureRoot = {},
  AdventureLVList = {
    sNodeName = "AdventureLV_",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsLvCtrl",
    nCount = 4
  },
  txtRecommendLevel = {
    sNodeName = "txtSuggestLevel",
    sComponentName = "TMP_Text"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  txtBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgBuild = {sComponentName = "Image"},
  TMPName = {sComponentName = "TMP_Text"},
  detailDesc = {sComponentName = "TMP_Text"},
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  tex_EnemyInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_EnemyInfo"
  },
  txtTitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "RogueBoss_Pause_Target"
  },
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  Task = {sComponentName = "Transform", nCount = 3},
  rewardRoot = {sComponentName = "Transform"},
  btn_itemTemp = {},
  btnListRoot = {},
  btnRaid = {
    sComponentName = "UIButton",
    callback = "OnClickBtnRaid"
  },
  imgRaidUnlockMask = {},
  txtBtnRaid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  TMPRaidUnlockHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Cond"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnClickBtnGo"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  goCoin = {},
  txtTicketsCount = {sComponentName = "TMP_Text"},
  ListConditions = {},
  ListConditionsObj = {
    sNodeName = "Conditions_",
    nCount = 2
  }
}
ActivityLevelsSelectCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy"
}
ActivityLevelsSelectCtrl._mapRedDotConfig = {}

function ActivityLevelsSelectCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.nLevelType = GameEnum.ActivityLevelType.Explore
  self.tabRewardList = {}
  self.AniRoot = self.gameObject:GetComponent("Animator")
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
  if bInActGroup then
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Explore, {nActGroupId}, self._mapNode.redExploreUnSelect)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Explore, {nActGroupId}, self._mapNode.redExploreSelect)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Adventure, {nActGroupId}, self._mapNode.redAdventureUnSelect)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Adventure, {nActGroupId}, self._mapNode.redAdventureSelect)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Hard, {nActGroupId}, self._mapNode.redHardUnSelect)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Hard, {nActGroupId}, self._mapNode.redHardSelect)
  end
end

function ActivityLevelsSelectCtrl:OnEnable()
  self.timeTab = {}
  EventManager.Hit(EventId.SetTransition)
  self.SelectTogPreLvLock = nil
  self.AniRoot:Play("ActivityLevelsSelect_in")
  self:Init()
end

function ActivityLevelsSelectCtrl:OnDisable()
  self.timeTab = {}
  for i = 1, #self.tabRewardList do
    local go = self.tabRewardList[i].gameObject
    local btnSelect = self.tabRewardList[i].gameObject:GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    self:UnbindCtrlByNode(self.tabRewardList[i])
    destroy(go)
  end
  self.tabRewardList = {}
  self.SelectTogPreLvLock = nil
  if self.SelectObj ~= nil then
    self.SelectObj:SetActive(false)
  end
  self.SelectObj = nil
end

function ActivityLevelsSelectCtrl:OnDestroy(...)
end

function ActivityLevelsSelectCtrl:Init()
  self.activityLevelsData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.nLevelType = self.activityLevelsData:GetDefaultSelectionType()
  self:RefreshTogTypeCount()
  self:Refresh()
end

function ActivityLevelsSelectCtrl:Refresh()
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
end

function ActivityLevelsSelectCtrl:RefreshTogTypeCount()
  self._mapNode.togTypeExploreCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Explore"))
  self._mapNode.togTypeAdventureCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Adventure"))
  self._mapNode.togTypeHardCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Hard"))
  self._mapNode.togTypeExploreCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.HARD)
  local totalExplore, exploreCount = self.activityLevelsData:GetLevelStarMsg(GameEnum.ActivityLevelType.Explore)
  local totalAdventure, adventureCount = self.activityLevelsData:GetLevelStarMsg(GameEnum.ActivityLevelType.Adventure)
  local totalHard, hardCount = self.activityLevelsData:GetLevelStarMsg(GameEnum.ActivityLevelType.HARD)
  local str = "%s/%s"
  self.firstExploreLevel = self.activityLevelsData.levelTabExploreDifficulty[1]
  local isOpenExplore = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Explore, self.firstExploreLevel)
  self._mapNode.togTypeExploreCtrl:SetTogIsOpen(isOpenExplore)
  if isOpenExplore then
    self._mapNode.togTypeExploreCtrl:SetCount(string.format(str, exploreCount, totalExplore))
  else
    self._mapNode.togTypeExploreCtrl:SetCount("")
  end
  self.firstAdventureLevel = self.activityLevelsData.levelTabAdventureDifficulty[1]
  local isOpenAdventure = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Adventure, self.firstAdventureLevel)
  self._mapNode.togTypeAdventureCtrl:SetTogIsOpen(isOpenAdventure)
  if isOpenAdventure then
    self._mapNode.togTypeAdventureCtrl:SetCount(string.format(str, adventureCount, totalAdventure))
  else
    self._mapNode.togTypeAdventureCtrl:SetCount("")
  end
  if self.activityLevelsData.hardLevelCount > 0 then
    self.firstHardLevel = self.activityLevelsData.levelTabHardDifficulty[1]
    local isOpenHard = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.HARD, self.firstHardLevel)
    self._mapNode.togTypeHardCtrl:SetTogIsOpen(isOpenHard)
    if isOpenHard then
      self._mapNode.togTypeHardCtrl:SetCount(string.format(str, hardCount, totalHard))
    else
      self._mapNode.togTypeHardCtrl:SetCount("")
    end
  else
    self._mapNode.togTypeHard.gameObject:SetActive(false)
  end
  self:ShowTogLock()
end

function ActivityLevelsSelectCtrl:ShowTogLock()
  local isOpenExplore = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Explore, self.firstExploreLevel)
  self._mapNode.togTypeExploreCtrl:ShowTogLock(not isOpenExplore and self.nLevelType ~= GameEnum.ActivityLevelType.Explore, not isOpenExplore and self.nLevelType == GameEnum.ActivityLevelType.Explore)
  local isOpenAdventure = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Adventure, self.firstAdventureLevel)
  self._mapNode.togTypeAdventureCtrl:ShowTogLock(not isOpenAdventure and self.nLevelType ~= GameEnum.ActivityLevelType.Adventure, not isOpenAdventure and self.nLevelType == GameEnum.ActivityLevelType.Adventure)
  if self.activityLevelsData.hardLevelCount > 0 then
    local isOpenHard = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.HARD, self.firstHardLevel)
    self._mapNode.togTypeHardCtrl:ShowTogLock(not isOpenHard and self.nLevelType ~= GameEnum.ActivityLevelType.HARD, not isOpenHard and self.nLevelType == GameEnum.ActivityLevelType.HARD)
  end
end

function ActivityLevelsSelectCtrl:FirstLevelLockTips(nType, nLevel)
  local day = self.activityLevelsData:GetUnLockDay(nType, nLevel)
  local strTips = ""
  if day == 0 then
    local hour, min, sec = self.activityLevelsData:GetUnLockHour(nType, nLevel)
    if 0 < hour then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour"), hour)
    elseif 0 < min then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min"), min)
    elseif 0 < sec then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec"), sec)
    end
  else
    strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day"), day)
  end
  EventManager.Hit(EventId.OpenMessageBox, strTips)
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeExplore()
  if self.nLevelType == GameEnum.ActivityLevelType.Explore then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_Switch")
  self.nLevelType = GameEnum.ActivityLevelType.Explore
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
  self:ShowTogLock()
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeAdventure()
  if self.nLevelType == GameEnum.ActivityLevelType.Adventure then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_Switch")
  self.nLevelType = GameEnum.ActivityLevelType.Adventure
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
  self:ShowTogLock()
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeHard()
  if self.nLevelType == GameEnum.ActivityLevelType.HARD then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_Switch")
  self.nLevelType = GameEnum.ActivityLevelType.HARD
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
  self:ShowTogLock()
end

function ActivityLevelsSelectCtrl:CloseAllTimer()
  for i, v in pairs(self.timeTab) do
    v:Pause(true)
  end
  self.timeTab = {}
end

function ActivityLevelsSelectCtrl:RefreshTogType(nType)
  self._mapNode.togTypeExploreCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.HARD)
  self._mapNode.togTypeExploreCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.HARD)
end

function ActivityLevelsSelectCtrl:RefreshTogList(nType, nDifficulty)
  local tabLevelInfo, tabLevelInfoDifficulty
  self._mapNode.ExploreRoot:SetActive(nType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.AdventureRoot:SetActive(nType ~= GameEnum.ActivityLevelType.Explore)
  if nType == GameEnum.ActivityLevelType.Explore then
    tabLevelInfo = self.activityLevelsData.levelTabExplore
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabExploreDifficulty
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    tabLevelInfo = self.activityLevelsData.levelTabAdventure
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabAdventureDifficulty
  elseif nType == GameEnum.ActivityLevelType.HARD then
    tabLevelInfo = self.activityLevelsData.levelTabHard
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabHardDifficulty
  end
  for i = 1, #tabLevelInfoDifficulty do
    local tmpId = tabLevelInfoDifficulty[i]
    local tmpData = tabLevelInfo[tmpId]
    local isOpen = self.activityLevelsData:GetLevelDayOpen(nType, tmpData.baseData.Id)
    local isLevelUnLock = self.activityLevelsData:GetLevelUnLock(nType, tmpData.baseData.Id)
    if nType == GameEnum.ActivityLevelType.Explore then
      self._mapNode.ExploreLVList[i]:InitData(self, nType, self.activityLevelsData, tmpData, isOpen, isLevelUnLock)
      if nDifficulty == i then
        local obj = self._mapNode.ExploreLVList[i].gameObject.transform:Find("select").gameObject
        obj:SetActive(true)
        self:SetSelectObj(obj)
      end
    else
      self._mapNode.AdventureLVList[i]:InitData(self, nType, self.activityLevelsData, tmpData, isOpen, isLevelUnLock)
      if nDifficulty == i then
        local obj = self._mapNode.AdventureLVList[i].gameObject.transform:Find("select").gameObject
        self:SetSelectObj(obj)
        obj:SetActive(true)
      end
    end
    if i == nDifficulty then
      self:RefreshInstanceInfo(nType, nDifficulty, true, true)
    end
  end
end

function ActivityLevelsSelectCtrl:SetSelectObj(obj)
  if self.SelectObj ~= nil then
    self.SelectObj:SetActive(false)
  end
  self.SelectObj = obj
end

function ActivityLevelsSelectCtrl:RefreshInstanceInfo(nType, nHard, bLocation, bSetTog)
  self.curSelectHard = nHard
  if self.tmpLockInfoDay ~= nil then
    NovaAPI.SetImageColor(self.tmpLockInfoDay, Color(0.14901960784313725, 0.10196078431372549, 0.47058823529411764, 1))
    self.tmpLockInfoDay = false
  end
  local levelId = 0
  self.selectLevelData = nil
  if nType == GameEnum.ActivityLevelType.Explore then
    levelId = self.activityLevelsData.levelTabExploreDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabExplore[levelId]
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    levelId = self.activityLevelsData.levelTabAdventureDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabAdventure[levelId]
  elseif nType == GameEnum.ActivityLevelType.HARD then
    levelId = self.activityLevelsData.levelTabHardDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabHard[levelId]
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, self.selectLevelData.baseData.SuggestedPower)
  local sRank = "Icon/BuildRank/BuildRank_" .. self.selectLevelData.baseData.RecommendBuildRank
  self:SetPngSprite(self._mapNode.imgBuild, sRank)
  NovaAPI.SetTMPText(self._mapNode.TMPName, self.selectLevelData.baseData.Name)
  NovaAPI.SetTMPText(self._mapNode.detailDesc, self.selectLevelData.baseData.Desc)
  self.curStar = self.selectLevelData.Star
  local tbCond = {
    self.selectLevelData.baseData.OneStarDesc,
    self.selectLevelData.baseData.TwoStarDesc,
    self.selectLevelData.baseData.ThreeStarDesc
  }
  for i = 1, 3 do
    local rtTask = self._mapNode.Task[i]
    local goDone = rtTask:Find("imgDone").gameObject
    local imgUnDone = rtTask:Find("imgUnDone").gameObject
    local Text = rtTask:Find("Text"):GetComponent("TMP_Text")
    goDone:SetActive(i <= self.curStar)
    imgUnDone:SetActive(i > self.curStar)
    local cond = tbCond[i]
    if cond == nil then
      rtTask.gameObject:SetActive(false)
      return
    else
      rtTask.gameObject:SetActive(true)
      NovaAPI.SetTMPText(Text, cond)
    end
  end
  self.PreviewMonsterGroupId = self.selectLevelData.baseData.PreviewMonsterGroupId
  local isOpen = self.activityLevelsData:GetLevelDayOpen(nType, self.selectLevelData.baseData.Id)
  local isLevelUnLock = self.activityLevelsData:GetLevelUnLock(nType, self.selectLevelData.baseData.Id)
  local isNeedEnergyConsume = true
  if not self.selectLevelData.baseData.EnergyConsumeOnRetry and 0 < self.selectLevelData.Star then
    isNeedEnergyConsume = false
  end
  if isOpen and isLevelUnLock then
    self._mapNode.btnListRoot:SetActive(true)
    self._mapNode.ListConditions:SetActive(false)
    if self.selectLevelData.baseData.ThreeStarSweep then
      self._mapNode.btnRaid.gameObject:SetActive(true)
      self._mapNode.txtBtnRaid.gameObject:SetActive(self.curStar == 3)
      self._mapNode.imgRaidUnlockMask.gameObject:SetActive(self.curStar ~= 3)
    else
      self._mapNode.btnRaid.gameObject:SetActive(false)
    end
    local nHas = PlayerData.Base:GetCurEnergy()
    local nRequire = self.selectLevelData.baseData.EnergyConsume
    if not isNeedEnergyConsume then
      nRequire = 0
    end
    self.curRequireEnergy = nRequire
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, nRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
    self._mapNode.goCoin:SetActive(isNeedEnergyConsume)
  elseif isOpen and not isLevelUnLock then
    self._mapNode.btnListRoot:SetActive(false)
    self._mapNode.ListConditions:SetActive(true)
    local preLevelId = self.selectLevelData.baseData.PreLevelId
    if preLevelId ~= 0 then
      local lvPreNeedStar = self.selectLevelData.baseData.PreLevelStar
      local lvPreStar = self.activityLevelsData:GetPreLevelStar(nType, self.selectLevelData.baseData.Id)
      local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      local tmpData = ConfigTable.GetData("ActivityLevelsLevel", preLevelId)
      imgConditions_Lock_1:SetActive(lvPreNeedStar > lvPreStar)
      imgConditions_UnLock_1:SetActive(lvPreNeedStar <= lvPreStar)
      NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_PreLevel"), tmpData.Name))
    else
      local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      imgConditions_Lock_1:SetActive(true)
      imgConditions_UnLock_1:SetActive(false)
      NovaAPI.SetTMPText(txt, ConfigTable.GetUIText("Unlocked_By_PreLevel"))
    end
    local preActivityStory = self.selectLevelData.baseData.PreActivityStory
    if preActivityStory ~= nil and preActivityStory[1] ~= nil then
      local isRead = PlayerData.ActivityAvg:IsStoryReaded(preActivityStory[2])
      local imgConditions_Lock_2 = self._mapNode.ListConditionsObj[2].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_2 = self._mapNode.ListConditionsObj[2].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[2].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      imgConditions_Lock_2:SetActive(not isRead)
      imgConditions_UnLock_2:SetActive(isRead)
      local cfgdata = ConfigTable.GetData("ActivityStory", preActivityStory[2])
      if cfgdata ~= nil then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Avg"), cfgdata.Title))
        self._mapNode.ListConditionsObj[2]:SetActive(true)
      else
        self._mapNode.ListConditionsObj[2]:SetActive(false)
      end
    else
      self._mapNode.ListConditionsObj[2]:SetActive(false)
    end
  elseif not isOpen then
    self._mapNode.btnListRoot:SetActive(false)
    self._mapNode.ListConditions:SetActive(true)
    self._mapNode.ListConditionsObj[2]:SetActive(false)
    local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
    imgConditions_Lock_1:SetActive(true)
    imgConditions_UnLock_1:SetActive(false)
    local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    local day = self.activityLevelsData:GetUnLockDay(nType, self.selectLevelData.baseData.Id)
    if day == 0 then
      local hour, min, sec = self.activityLevelsData:GetUnLockHour(nType, self.selectLevelData.baseData.Id)
      if 0 < hour then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour"), hour))
      elseif 0 < min then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min"), min))
      elseif 0 < sec then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec"), sec))
      end
    else
      local _day, _hour = self.activityLevelsData:GetUnLockDayHour(nType, self.selectLevelData.baseData.Id)
      NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_DayHourOpen"), _day, _hour))
    end
  end
  for i = 1, #self.tabRewardList do
    self.tabRewardList[i].gameObject:SetActive(false)
  end
  local tbReward = decodeJson(self.selectLevelData.baseData.CompleteRewardPreview)
  for i = 1, #tbReward do
    if i > #self.tabRewardList then
      local obj = instantiate(self._mapNode.btn_itemTemp, self._mapNode.rewardRoot)
      self.tabRewardList[i] = self:BindCtrlByNode(obj, "Game.UI.TemplateEx.TemplateItemCtrl")
    end
    local itemCtrl = self.tabRewardList[i]
    itemCtrl.gameObject:SetActive(true)
    if tbReward[i] ~= nil then
      local bReceived = 0 < self.selectLevelData.Star and tbReward[i][3] == 1
      local bFirstPass = tbReward[i][3] == 1
      itemCtrl:SetItem(tbReward[i][1], nil, UTILS.ParseRewardItemCount(tbReward[i]), nil, bReceived, bFirstPass, false, true)
      local btnItem = itemCtrl.gameObject:GetComponent("UIButton")
      btnItem.onClick:RemoveAllListeners()
      
      local function clickCb()
        self:OnBtnClick_RewardItem(tbReward[i][1], btnItem.gameObject)
      end
      
      btnItem.onClick:AddListener(clickCb)
    end
  end
end

function ActivityLevelsSelectCtrl:OnBtnClick_RewardItem(nTid, btn)
  local rtBtn = btn.transform
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function ActivityLevelsSelectCtrl:OnClickBtnGo()
  local nEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  if nEnergy < self.curRequireEnergy then
    local function callback()
      EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
    return
  end
  self.activityLevelsData:ChangeRedDot(self.selectLevelData.baseData.Type, self.selectLevelData.baseData.Id)
  PlayerData.Activity:SetActivityLevelActId(self.nActId)
  EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityLevels, self.selectLevelData.baseData.Id, {
    self.nActId
  })
end

function ActivityLevelsSelectCtrl:OnClickBtnRaid()
  if self.curStar ~= 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  local nNeedEnergy = self.curRequireEnergy
  EventManager.Hit(EventId.OpenPanel, PanelId.Raid, self.selectLevelData.baseData.Id, nNeedEnergy, 0, self.nActId)
end

function ActivityLevelsSelectCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenActivityLevelsMonsterInfo", self.PreviewMonsterGroupId)
end

function ActivityLevelsSelectCtrl:OnEvent_UpdateEnergy()
  local nHas = PlayerData.Base:GetCurEnergy()
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.curRequireEnergy and Red_Unable or Blue_Normal)
end

return ActivityLevelsSelectCtrl
