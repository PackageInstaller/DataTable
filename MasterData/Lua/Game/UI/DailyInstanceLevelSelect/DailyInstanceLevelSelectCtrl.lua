local DailyInstanceLevelSelectCtrl = class("DailyInstanceLevelSelectCtrl", BaseCtrl)
local mapToggle = {
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4,
  [5] = GameEnum.diffculty.Diffculty_5,
  [6] = GameEnum.diffculty.Diffculty_6,
  [7] = GameEnum.diffculty.Diffculty_7,
  [8] = GameEnum.diffculty.Diffculty_8
}
DailyInstanceLevelSelectCtrl._mapNodeConfig = {
  rt_DailyInstanceSelect = {
    sNodeName = "goDailyInstanceSelect"
  },
  txtWindowTitleSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Reward_SelectTitle"
  },
  ani_DailyInstanceSelect = {
    sNodeName = "rt_DailyInstanceSelect",
    sComponentName = "Animator"
  },
  rt_DailyInstanceInfo = {},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  svSelect = {
    sComponentName = "LoopScrollView"
  },
  TMPInstanceDesc = {sComponentName = "TMP_Text"},
  TMPInstanceName = {sComponentName = "TMP_Text"},
  txtRecommendLevel = {
    sNodeName = "txtSuggestLevel",
    sComponentName = "TMP_Text"
  },
  imgLevelImg = {sComponentName = "Image"},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  ItemBtn = {
    sNodeName = "btn_item",
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_RewardItem"
  },
  tog = {
    sComponentName = "UIButton",
    nCount = 8,
    callback = "OnBtnClick_Tog"
  },
  rt_Targets = {nCount = 8},
  rt_LockMsg = {nCount = 8},
  txt_LockMsg = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_LevelUnLock",
    nCount = 8
  },
  imgLockMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTips",
    nCount = 8
  },
  txtLockCondition = {sComponentName = "TMP_Text", nCount = 8},
  rtToggles = {
    sComponentName = "UIScrollRect"
  },
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 8
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardList"
  },
  btnChange = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickChangeMode"
  },
  txtTicketsCount = {sComponentName = "TMP_Text"},
  imgTickets = {sComponentName = "Image"},
  Task = {sComponentName = "Transform", nCount = 3},
  btnRaid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Raid"
  },
  txtBtnRaid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  TMPRaidUnlockHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Cond"
  },
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  txtBtnEnemyInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MonsterInfo"
  },
  txtTitleReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtTitleChangeReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_ChangeReward"
  },
  txtBtnChange = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_ChangeBtn"
  },
  txtTitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  btnCloseInfo = {
    sNodeName = "btnCloseInfo",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseChangeMode"
  },
  got_fullscreen_select = {
    sNodeName = "t_fullscreen_select"
  },
  btnsnapshot = {
    sComponentName = "Button",
    callback = "OnBtn_ClickCloseChangeMode"
  },
  txtRewardTitle = {sComponentName = "TMP_Text"},
  imgFirstReward = {sComponentName = "Image"},
  txtFirstRewardNum = {sComponentName = "TMP_Text"},
  txt_buildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  img_buildRank = {sComponentName = "Image"},
  ListConditions = {},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  txtBtnLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_SatisfyConditions_UnLock"
  },
  Conditions_ = {nCount = 2},
  imgDoubleDrop = {},
  txtDoubleDrop = {sComponentName = "TMP_Text"},
  txtDoubleDropCount = {sComponentName = "TMP_Text"},
  imgReengagementDrop = {},
  txtReengagementDoubleDrop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_DoubleDrop_LevelTip"
  },
  txtReengagementDoubleDropCount = {sComponentName = "TMP_Text"}
}
DailyInstanceLevelSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  ChangeDailyInstanceRewardMode = "OnEvent_ChangeDailyInstanceRewardMode",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  RaidSuccess = "OnEvent_RaidSuccess"
}

function DailyInstanceLevelSelectCtrl:Awake()
  self.mapLevelGrid = {}
  self.curDailyType = GameEnum.dailyType.Common
  self:SetSprite_Coin(self._mapNode.imgTickets, AllEnum.CoinItemId.Energy)
end

function DailyInstanceLevelSelectCtrl:FadeIn()
end

function DailyInstanceLevelSelectCtrl:FadeOut()
end

function DailyInstanceLevelSelectCtrl:OnEnable()
  self.mapAllDailyInstance = {}
  self.tbDailyInstanceType = {}
  
  local function forEachDailyInstance(mapData)
    if self.curDailyType == mapData.DailyType then
      self.mapAllDailyInstance[mapData.Difficulty] = mapData
    end
  end
  
  ForEachTableLine(DataTable.DailyInstance, forEachDailyInstance)
  
  local function forEachDailyInstanceRewardGroup(mapData)
    if self.tbDailyInstanceType[mapData.GroupId] == nil then
      self.tbDailyInstanceType[mapData.GroupId] = {}
    end
    table.insert(self.tbDailyInstanceType[mapData.GroupId], mapData)
  end
  
  ForEachTableLine(DataTable.DailyInstanceRewardGroup, forEachDailyInstanceRewardGroup)
  for k, v in pairs(self.tbDailyInstanceType) do
    table.sort(v, function(a, b)
      return a.Id < b.Id
    end)
  end
  local tbParam = self:GetPanelParam()
  self.nJumpToGroup = PlayerData.DailyInstance:GetLastRewardType()
  local nMaxHard = PlayerData.DailyInstance:GetMaxDailyInstanceHard(self.curDailyType)
  self.nJumpToHard = nMaxHard
  if nil ~= next(tbParam) and tbParam[2] ~= nil and tbParam[2] ~= 0 then
    if tbParam[3] == nil then
    end
    self.bJumpTo = tbParam[3]
    self.nJumpToGroup = tbParam[2]
    local nJumpToHard = (nil == tbParam[1] or 0 == tbParam[1]) and nMaxHard or tbParam[1]
    if self.bJumpTo then
      self.nJumpToHard = nJumpToHard
    else
      local nLastMaxHard = PlayerData.DailyInstance:GetLastMaxHard(self.nJumpToGroup)
      if 0 == nLastMaxHard then
        self.nJumpToHard = nJumpToHard
      elseif nLastMaxHard == nMaxHard then
        self.nJumpToHard = nJumpToHard
      else
        self.nJumpToHard = nMaxHard
      end
    end
  end
  self._mapNode.rt_DailyInstanceSelect:SetActive(false)
  self._mapNode.rt_DailyInstanceInfo:SetActive(true)
  self.curState = 1
  self.curSelectHard = 1
  self.nCurGroupId = 0
  if self.nJumpToGroup ~= nil and self.nJumpToGroup ~= 0 then
    self:OpenJumpToGroup()
  end
end

function DailyInstanceLevelSelectCtrl:OnDisable()
  self:UnbindAllGrids()
end

function DailyInstanceLevelSelectCtrl:OnDestroy()
end

function DailyInstanceLevelSelectCtrl:OnRelease()
end

function DailyInstanceLevelSelectCtrl:RefreshGrid(goGrid, gridIndex)
  if self.mapLevelGrid[goGrid] == nil then
    self.mapLevelGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.DailyInstanceLevelSelect.DailyInstanceLevelSelectGridCtrl")
  end
  local nIdx = gridIndex + 1
  local mapDailyInstanceData = self.mapAllDailyInstance[self.nJumpToHard]
  local nType = self.tbDailyInstanceType[mapDailyInstanceData.AwardDropId][nIdx].Id
  self.mapLevelGrid[goGrid]:Refresh(nType)
end

function DailyInstanceLevelSelectCtrl:UnbindAllGrids()
  for go, mapCtrl in pairs(self.mapLevelGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapLevelGrid = {}
end

function DailyInstanceLevelSelectCtrl:OpenJumpToGroup()
  self.nCurGroupId = self.nJumpToGroup
  self.curState = 2
  self:RefreshDailyInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_DailyInstanceSelect:SetActive(false)
  self._mapNode.rt_DailyInstanceInfo:SetActive(true)
end

function DailyInstanceLevelSelectCtrl:OpenJumpToHard()
  self.curState = 2
  self.nCurGroupId = self.nJumpToGroup
  local nJumptoDuelId = self.mapAllDailyInstance[self.nJumpToHard].Id
  if not PlayerData.DailyInstance:GetDailyInstanceLevelUnlock(nJumptoDuelId) then
    self.nJumpToHard = 1
  end
  self:RefreshDailyInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_DailyInstanceSelect:SetActive(false)
  self._mapNode.rt_DailyInstanceInfo:SetActive(true)
end

function DailyInstanceLevelSelectCtrl:RefreshLevelUnlock()
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllDailyInstance[mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nLevelId = self.mapAllDailyInstance[mapToggle[index]].Id
      local bLock, nWorldClass = PlayerData.DailyInstance:GetDailyInstanceLevelUnlock(nLevelId)
      if not self.tbLockWorldClass then
        self.tbLockWorldClass = {}
      end
      self.tbLockWorldClass[index] = nWorldClass
      local tmpTitle = hardBtn.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_Select"):GetComponent("TMP_Text")
      local tmpTitleUnselect = hardBtn.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_unSelect"):GetComponent("TMP_Text")
      local sKey = "Diffculty_" .. mapToggle[index]
      NovaAPI.SetTMPText(tmpTitle, ConfigTable.GetUIText(sKey))
      NovaAPI.SetTMPText(tmpTitleUnselect, ConfigTable.GetUIText(sKey))
      self._mapNode.imgLockMask[index].gameObject:SetActive(false)
      self._mapNode.rt_Targets[index]:SetActive(bLock)
      self._mapNode.rt_LockMsg[index]:SetActive(not bLock)
      if not bLock then
        if self.tbLockWorldClass[index] then
          NovaAPI.SetTMPText(self._mapNode.txtLockCondition[index], orderedFormat(ConfigTable.GetUIText("RegusBoss_Unlock_LvHand"), nWorldClass))
        else
          NovaAPI.SetTMPText(self._mapNode.txtLockCondition[index], ConfigTable.GetUIText("Unlocked_By_PreLevel"))
        end
      end
      local curStar, tbTarget = PlayerData.DailyInstance:GetDailyInstanceStar(nLevelId)
      for j = 1, 3 do
        local btnStar = self._mapNode.rt_Targets[index].gameObject.transform:Find("btnTarget" .. j):GetComponent("Button")
        btnStar.interactable = tbTarget[j]
      end
    end
  end
end

function DailyInstanceLevelSelectCtrl:RefreshDailyInstanceInfo(nType, nHard, bLocation, bSetTog)
  if bLocation then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      NovaAPI.UIScrollRectScrollTo(self._mapNode.rtToggles, nHard, true)
    end
  end
  self:RefreshLevelUnlock()
  if bSetTog then
    for i = 1, 8 do
      self._mapNode.togCtrl[i]:SetDefault(i == nHard)
    end
  end
  self.curSelectHard = nHard
  self._panel._tbParam[1] = self.curSelectHard
  local mapDailyInstanceData = self.mapAllDailyInstance[nHard]
  if mapDailyInstanceData == nil then
    return
  end
  self.DailyInstance = mapDailyInstanceData.Id
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceName, mapDailyInstanceData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceDesc, mapDailyInstanceData.Desc)
  self:SetPngSprite(self._mapNode.imgLevelImg, mapDailyInstanceData.Icon)
  local curStar = PlayerData.DailyInstance:GetDailyInstanceStar(self.DailyInstance)
  self._mapNode.imgFirstReward.gameObject:SetActive(false)
  self._mapNode.txtBtnRaid.gameObject:SetActive(curStar == 3)
  local raidUnlockMask = self._mapNode.btnRaid.transform:Find("AnimRoot/imgUnlockMask")
  raidUnlockMask.gameObject:SetActive(curStar ~= 3)
  local cond = {
    mapDailyInstanceData.OneStarDesc,
    mapDailyInstanceData.TwoStarDesc,
    mapDailyInstanceData.ThreeStarDesc
  }
  for i = 1, 3 do
    local rtTask = self._mapNode.Task[i]
    local goDone = rtTask:Find("imgDone").gameObject
    local imgUnDone = rtTask:Find("imgUnDone").gameObject
    local Text = rtTask:Find("Text"):GetComponent("TMP_Text")
    goDone:SetActive(i <= curStar)
    imgUnDone:SetActive(i > curStar)
    if cond[i] == "" then
      rtTask.gameObject:SetActive(false)
    else
      rtTask.gameObject:SetActive(true)
      NovaAPI.SetTMPText(Text, cond[i])
    end
  end
  local nHas = PlayerData.Base:GetCurEnergy()
  local nRequire = mapDailyInstanceData.ThreeStarEnergyConsume
  self.curRequireEnergy = nRequire
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, nRequire)
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapDailyInstanceData.SuggestedPower)
  local sRank = "Icon/BuildRank/BuildRank_" .. mapDailyInstanceData.RecommendBuildRank
  self:SetPngSprite(self._mapNode.img_buildRank, sRank)
  local tbReward = {}
  if self.tbDailyInstanceType[mapDailyInstanceData.AwardDropId] ~= nil then
    for k, v in ipairs(self.tbDailyInstanceType[mapDailyInstanceData.AwardDropId]) do
      if v.DailyRewardType == nType then
        tbReward = decodeJson(v.BaseAwardPreview)
        NovaAPI.SetTMPText(self._mapNode.txtRewardTitle, v.RewardName)
      end
    end
  end
  self.tbReward = tbReward
  if curStar <= 0 then
    local firstReward = mapDailyInstanceData.FirstRewardPreview
    if firstReward ~= nil and 0 < #firstReward then
      table.insert(self.tbReward, 1, {
        firstReward[1],
        firstReward[2],
        1
      })
    end
  end
  local tbReceived = {}
  for index = 1, 5 do
    if self.tbReward[index] ~= nil then
      local bReceived = false
      if self.tbReward[index][#tbReward[index]] == 1 and 0 < curStar then
        bReceived = true
      end
      table.insert(self.tbReward[index], bReceived)
    end
  end
  self.tbAfterReward = {}
  for key, value in pairs(self.tbReward) do
    local lastIndex = #self.tbReward[key]
    if not self.tbReward[key][lastIndex] then
      table.remove(value)
      table.insert(self.tbAfterReward, value)
    end
  end
  for index = 1, 5 do
    self._mapNode.ItemBtn[index].interactable = self.tbAfterReward[index] ~= nil
    if self.tbAfterReward[index] ~= nil then
      local rewardItem = self.tbAfterReward[index]
      local nLastIndex = #rewardItem
      self._mapNode.item[index]:SetItem(rewardItem[1], nil, UTILS.ParseRewardItemCount(rewardItem), nil, false, rewardItem[nLastIndex] == 1, rewardItem[nLastIndex] == 2, true)
    else
      self._mapNode.item[index]:SetItem(nil)
    end
  end
  local isUnLock, isWorldClass, isPreLevelStar = PlayerData.DailyInstance:GetDailyInstanceUnlockMsg(self.DailyInstance)
  self._mapNode.btnRaid.gameObject:SetActive(isUnLock)
  self._mapNode.btnGo.gameObject:SetActive(isUnLock)
  self._mapNode.btnLock.gameObject:SetActive(not isUnLock)
  self._mapNode.ListConditions:SetActive(not isUnLock)
  self._mapNode.imgDoubleDrop:SetActive(false)
  self._mapNode.imgReengagementDrop:SetActive(false)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  self.actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
  local bShowNormalDouble = false
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.DailyInstance) then
    local nCurCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    bShowNormalDouble = 0 < nMaxCount - nCurCount
  end
  if bShowNormalDouble then
    self._mapNode.imgDoubleDrop:SetActive(isUnLock)
    self:RefreshDoubleDropCount()
  elseif 0 < nReengagementCount then
    self._mapNode.imgReengagementDrop:SetActive(true)
    self:RefreshReengagementCount()
  end
  if not isUnLock then
    local imgConditions_Lock_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("imgConditions_UnLock").gameObject
    local tex_ConditionsTips_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    imgConditions_Lock_WC:SetActive(not isWorldClass)
    imgConditions_UnLock_WC:SetActive(isWorldClass)
    local tempData = ConfigTable.GetData("DailyInstance", self.DailyInstance)
    NovaAPI.SetTMPText(tex_ConditionsTips_WC, orderedFormat(ConfigTable.GetUIText("RegusBoss_UnlockConditions_WorldClass"), tempData.NeedWorldClass))
    NovaAPI.SetTMPColor(tex_ConditionsTips_WC, isWorldClass and Color(0.3686274509803922, 0.5372549019607843, 0.7058823529411765) or Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764))
    local imgConditions_Lock_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("imgConditions_UnLock").gameObject
    local tex_ConditionsTips_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    local _sKey = "Diffculty_" .. nHard - 1
    imgConditions_Lock_PL:SetActive(not isPreLevelStar)
    imgConditions_UnLock_PL:SetActive(isPreLevelStar)
    NovaAPI.SetTMPText(tex_ConditionsTips_PL, orderedFormat(ConfigTable.GetUIText("RegusBoss_UnlockConditions_PreLevel"), ConfigTable.GetUIText(_sKey)))
    NovaAPI.SetTMPColor(tex_ConditionsTips_PL, isPreLevelStar and Color(0.3686274509803922, 0.5372549019607843, 0.7058823529411765) or Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764))
  end
  PlayerData.DailyInstance:SetRewardType(nType)
end

function DailyInstanceLevelSelectCtrl:RefreshDoubleDropCount()
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.DailyInstance) then
    local _, str = self.actData:GetDropString()
    local nCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDropCount, string.format("%s/%s", nMaxCount - nCount, nMaxCount))
  end
end

function DailyInstanceLevelSelectCtrl:RefreshReengagementCount()
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local str = ConfigTable.GetUIText("Reengagement_DoubleDrop_LevelTip") .. ":"
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDrop, str)
  local nMaxCount = PlayerData.Reengagement:GetMaxDoubleDropCount()
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDropCount, string.format("%s/%s", nReengagementCount, nMaxCount))
end

function DailyInstanceLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function DailyInstanceLevelSelectCtrl:OnEvent_ChangeDailyInstanceRewardMode()
  self.nCurGroupId = PlayerData.DailyInstance:GetLastRewardType()
  self:RefreshDailyInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_Go()
  local mapDailyInstanceData = self.mapAllDailyInstance[self.curSelectHard]
  local nNeedEnergy = mapDailyInstanceData.ThreeStarEnergyConsume
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  if nNeedEnergy > nCurEnergy then
    local function callback()
      EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
    return
  end
  
  local function OpenPanel()
    local nCurMaxHard = PlayerData.DailyInstance:GetMaxDailyInstanceHard(self.curDailyType)
    PlayerData.DailyInstance:SetLastMaxHard(self.nCurGroupId, nCurMaxHard)
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.DailyInstance, self.DailyInstance)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_Tog(btn)
  local nHard = table.indexof(self._mapNode.tog, btn:GetComponent("UIButton"))
  local togIdx = table.indexof(self._mapNode.tog, btn)
  if nHard == nil then
    return
  end
  if self.curSelectHard ~= nHard then
    for idx, value in pairs(mapToggle) do
      if value == self.curSelectHard then
        self._mapNode.togCtrl[idx]:SetTrigger(false)
      end
    end
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self.nJumpToHard = nHard
    self:RefreshDailyInstanceInfo(self.nCurGroupId, nHard)
  end
end

function DailyInstanceLevelSelectCtrl:OnBtn_ClickChangeMode()
  self._mapNode.rt_DailyInstanceSelect.gameObject:SetActive(true)
  self._mapNode.got_fullscreen_select:SetActive(true)
  self._mapNode.ani_DailyInstanceSelect:Play("t_window_04_t_in")
  local mapDailyInstanceData = self.mapAllDailyInstance[self.nJumpToHard]
  self._mapNode.svSelect:SetAnim(0.07)
  self._mapNode.svSelect:Init(#self.tbDailyInstanceType[mapDailyInstanceData.AwardDropId], self, self.RefreshGrid)
end

function DailyInstanceLevelSelectCtrl:OnBtn_ClickCloseChangeMode()
  self._mapNode.ani_DailyInstanceSelect:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen_select:SetActive(false)
  self:AddTimer(1, 0.2, function()
    self._mapNode.rt_DailyInstanceSelect.gameObject:SetActive(false)
  end, true, true, true)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_RewardList(btn)
  self._mapNode.goRewardList:OpenPanel(self.tbReward)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  local rtBtn = self._mapNode.item[nIdx].gameObject.transform
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
  end
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_TogTips(btn, nIndex)
  if self.tbLockWorldClass[nIndex] then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("LevelSelect_LimitTipsWorldClass"), self.tbLockWorldClass[nIndex]))
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_LimitTips"))
  end
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_Skill(btn, nidx)
  local mapDailyInstanceData = self.mapAllDailyInstance[self.curSelectHard]
  local nSkillId = mapDailyInstanceData.SkillShow[nidx]
  if nSkillId ~= 0 then
    local mapData = {nSkillId = nSkillId, bTravelerDuel = true}
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_Raid()
  local curStar = PlayerData.DailyInstance:GetDailyInstanceStar(self.DailyInstance)
  if curStar ~= 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  local mapDailyInstanceData = self.mapAllDailyInstance[self.curSelectHard]
  local nNeedEnergy = mapDailyInstanceData.ThreeStarEnergyConsume
  EventManager.Hit(EventId.OpenPanel, PanelId.Raid, mapDailyInstanceData.Id, nNeedEnergy, GameEnum.instanceType.DailyInstance)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_Lock()
  self:OnBtnClick_TogTips(nil, self.curSelectHard)
end

function DailyInstanceLevelSelectCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenDailyInstanceMonsterInfo", self.DailyInstance)
end

function DailyInstanceLevelSelectCtrl:OnEvent_UpdateWorldClass()
  self:RefreshLevelUnlock()
end

function DailyInstanceLevelSelectCtrl:OnEvent_UpdateEnergy()
  local nHas = PlayerData.Base:GetCurEnergy()
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.curRequireEnergy and Red_Unable or Blue_Normal)
end

function DailyInstanceLevelSelectCtrl:OnEvent_RaidSuccess()
  self:RefreshDoubleDropCount()
  self:RefreshReengagementCount()
end

return DailyInstanceLevelSelectCtrl
