local SkillInstanceLevelSelectCtrl = class("SkillInstanceLevelSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
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
SkillInstanceLevelSelectCtrl._mapNodeConfig = {
  bgLevelInfo = {sNodeName = "----Bg----"},
  rt_SkillInstanceSelect = {},
  rt_SkillInstanceInfo = {},
  animInfo = {
    sNodeName = "rt_SkillInstanceInfo",
    sComponentName = "Animator"
  },
  animBack = {sNodeName = "goBack", sComponentName = "Animator"},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_Goto"
  },
  btnLevelItem = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelItem"
  },
  goLevelItem = {nCount = 3},
  TMPInstanceDesc = {sComponentName = "TMP_Text"},
  TMPInstanceName = {sComponentName = "TMP_Text"},
  txtRecommendLevel = {
    sNodeName = "txtSuggestLevel",
    sComponentName = "TMP_Text"
  },
  imgRecommendBuild = {sComponentName = "Image"},
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
  imgLockMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTips",
    nCount = 8
  },
  rt_Targets = {nCount = 8},
  rt_LockMsg = {nCount = 8},
  txt_LockMsg = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_LevelUnLock",
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
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_Reward_Title"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardList"
  },
  txtBtnAllReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_Reward"
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
    sLanguageId = "Equipment_Instance_EnemyInfo"
  },
  txtTitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  imgElementInfo = {nCount = 4, sComponentName = "Image"},
  txtLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  txtBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
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
SkillInstanceLevelSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  SkillInstanceRaidOpen = "OnEvent_RaidOpen",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  RaidSuccess = "OnEvent_RaidSuccess"
}

function SkillInstanceLevelSelectCtrl:Awake()
  self.nEnergyRequire = 0
  self.mapLevelGrid = {}
  self:SetSprite_Coin(self._mapNode.imgTickets, AllEnum.CoinItemId.Energy)
end

function SkillInstanceLevelSelectCtrl:FadeIn()
end

function SkillInstanceLevelSelectCtrl:FadeOut()
end

function SkillInstanceLevelSelectCtrl:OnEnable()
  self.mapAllSkillInstance = {}
  self.tbSkillInstanceType = {}
  
  local function foreachSkillInstance(mapData)
    if self.mapAllSkillInstance[mapData.Type] == nil then
      self.mapAllSkillInstance[mapData.Type] = {}
      table.insert(self.tbSkillInstanceType, mapData.Type)
    end
    self.mapAllSkillInstance[mapData.Type][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(ConfigTable.Get("SkillInstance"), foreachSkillInstance)
  
  local function sortSkillInstance(a, b)
    local mapTypeA = ConfigTable.GetData("SkillInstanceType", a)
    local mapTypeB = ConfigTable.GetData("SkillInstanceType", b)
    return mapTypeA.Sort < mapTypeB.Sort
  end
  
  table.sort(self.tbSkillInstanceType, sortSkillInstance)
  local tbParam = self:GetPanelParam()
  if nil ~= next(tbParam) then
    if tbParam[3] == nil then
    end
    self.bJumpTo = tbParam[3]
    self.nJumpToGroup = tbParam[2] == nil and 0 or tbParam[2]
    if 0 ~= self.nJumpToGroup then
      local nMaxHard = PlayerData.SkillInstance:GetMaxSkillInstanceHard(self.nJumpToGroup)
      local nJumpToHard = (nil == tbParam[1] or 0 == tbParam[1]) and nMaxHard or tbParam[1]
      if self.bJumpTo then
        self.nJumpToHard = nJumpToHard
      else
        local nLastMaxHard = PlayerData.SkillInstance:GetLastMaxHard(self.nJumpToGroup)
        if 0 == nLastMaxHard then
          self.nJumpToHard = nJumpToHard
        elseif nLastMaxHard == nMaxHard then
          self.nJumpToHard = nJumpToHard
        else
          self.nJumpToHard = nMaxHard
        end
      end
    end
  end
  self._mapNode.rt_SkillInstanceSelect:SetActive(true)
  self._mapNode.rt_SkillInstanceInfo:SetActive(false)
  self.curState = 1
  self.curSelectHard = 1
  self.nCurGroupId = 0
  for k, v in ipairs(self._mapNode.goLevelItem) do
    if nil ~= self.tbSkillInstanceType[k] then
      local nType = self.tbSkillInstanceType[k]
      local imgBg = v.transform:Find("imgBg"):GetComponent("Image")
      local txtInstanceName = v.transform:Find("TMPInstanceName"):GetComponent("TMP_Text")
      local mapLevelCfgData = ConfigTable.GetData("SkillInstanceType", nType)
      for i = 1, 4 do
        local imgElementInfo = v.transform:Find("goElement/imgElementInfo" .. i):GetComponent("Image")
        if mapLevelCfgData.EET ~= nil and mapLevelCfgData.EET[i] ~= nil then
          imgElementInfo.gameObject:SetActive(true)
          self:SetAtlasSprite(imgElementInfo, "12_rare", AllEnum.ElementIconType.Icon .. mapLevelCfgData.EET[i])
        else
          imgElementInfo.gameObject:SetActive(false)
        end
      end
      NovaAPI.SetTMPText(txtInstanceName, mapLevelCfgData.Name)
      self:SetPngSprite(imgBg, "UI/big_sprites/" .. mapLevelCfgData.Episode)
    end
  end
  if self.nJumpToGroup ~= 0 and self.nJumpToGroup ~= nil then
    self:OpenJumpToGroup()
  end
end

function SkillInstanceLevelSelectCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
end

function SkillInstanceLevelSelectCtrl:OnDestroy()
end

function SkillInstanceLevelSelectCtrl:OnRelease()
end

function SkillInstanceLevelSelectCtrl:OpenJumpToGroup()
  self.nCurGroupId = self.nJumpToGroup
  local skillInstanceData = self.mapAllSkillInstance[self.nCurGroupId]
  if skillInstanceData == nil then
    printError("SkillInstance Type Data Missing:" .. self.nCurGroupId)
    return
  end
  self.curState = 2
  self:RefreshSkillInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_SkillInstanceSelect:SetActive(false)
  self._mapNode.rt_SkillInstanceInfo:SetActive(true)
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenSkillInsInfo")
end

function SkillInstanceLevelSelectCtrl:OpenJumpToHard()
  self.curState = 2
  self.nCurGroupId = self.nJumpToGroup
  local nJumptoDuelId = self.mapAllSkillInstance[self.nCurGroupId][self.nJumpToHard].Id
  if not PlayerData.SkillInstance:GetSkillInstanceLevelUnlock(nJumptoDuelId) then
    self.nJumpToHard = 1
  end
  self:RefreshSkillInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_SkillInstanceSelect:SetActive(false)
  self._mapNode.rt_SkillInstanceInfo:SetActive(true)
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenSkillInsInfo")
end

function SkillInstanceLevelSelectCtrl:RefreshLevelUnlock()
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllSkillInstance[self.nCurGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nLevelId = self.mapAllSkillInstance[self.nCurGroupId][mapToggle[index]].Id
      local bLock, nWorldClass = PlayerData.SkillInstance:GetSkillInstanceLevelUnlock(nLevelId)
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
      local curStar, tbTarget = PlayerData.SkillInstance:GetSkillInstanceStar(nLevelId)
      for j = 1, 3 do
        local btnStar = self._mapNode.rt_Targets[index].gameObject.transform:Find("btnTarget" .. j):GetComponent("Button")
        btnStar.interactable = tbTarget[j]
      end
    end
  end
end

function SkillInstanceLevelSelectCtrl:RefreshSkillInstanceInfo(nGroupId, nHard, bLocation, bSetTog)
  if bLocation then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      NovaAPI.UIScrollRectScrollTo(self._mapNode.rtToggles, nHard, true)
    end
    
    cs_coroutine.start(wait)
  end
  self:RefreshLevelUnlock()
  if bSetTog then
    for i = 1, 8 do
      self._mapNode.togCtrl[i]:SetDefault(i == nHard)
    end
  end
  self.curSelectHard = nHard
  self._panel._tbParam[1] = self.curSelectHard
  local mapSkillInstanceData = self.mapAllSkillInstance[nGroupId][nHard]
  self.skillInstanceId = mapSkillInstanceData.Id
  if mapSkillInstanceData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceName, mapSkillInstanceData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceDesc, mapSkillInstanceData.Desc)
  self:SetPngSprite(self._mapNode.imgLevelImg, mapSkillInstanceData.Icon)
  local nType = mapSkillInstanceData.Type
  local mapLevelCfgData = ConfigTable.GetData("SkillInstanceType", nType)
  if mapLevelCfgData ~= nil then
    for i = 1, 4 do
      local imgElementInfo = self._mapNode.imgElementInfo[i]
      if mapLevelCfgData.EET ~= nil and mapLevelCfgData.EET[i] ~= nil then
        imgElementInfo.gameObject:SetActive(true)
        self:SetAtlasSprite(imgElementInfo, "12_rare", AllEnum.ElementIconType.Icon .. mapLevelCfgData.EET[i])
      else
        imgElementInfo.gameObject:SetActive(false)
      end
    end
  end
  local curStar = PlayerData.SkillInstance:GetSkillInstanceStar(self.skillInstanceId)
  self._mapNode.txtBtnRaid.gameObject:SetActive(3 <= curStar)
  local raidUnlockMask = self._mapNode.btnRaid.transform:Find("AnimRoot/imgUnlockMask")
  raidUnlockMask.gameObject:SetActive(not (3 <= curStar))
  local tbCond = {}
  table.insert(tbCond, decodeJson(mapSkillInstanceData.OneStarCondition))
  table.insert(tbCond, decodeJson(mapSkillInstanceData.TwoStarCondition))
  table.insert(tbCond, decodeJson(mapSkillInstanceData.ThreeStarCondition))
  for i = 1, 3 do
    local rtTask = self._mapNode.Task[i]
    local goDone = rtTask:Find("imgDone").gameObject
    local imgUnDone = rtTask:Find("imgUnDone").gameObject
    local Text = rtTask:Find("Text"):GetComponent("TMP_Text")
    goDone:SetActive(curStar >= i)
    imgUnDone:SetActive(curStar < i)
    local cond = tbCond[i]
    if cond == nil then
      rtTask.gameObject:SetActive(false)
    else
      rtTask.gameObject:SetActive(true)
      local _floorData = ConfigTable.GetData("SkillInstanceFloor", mapSkillInstanceData.FloorId)
      if _floorData then
        if cond[1] == 1 then
          NovaAPI.SetTMPText(Text, orderedFormat(ConfigTable.GetUIText("SkillInstance_PassConfition_1"), _floorData.LevelTotalTime))
        else
          NovaAPI.SetTMPText(Text, orderedFormat(ConfigTable.GetUIText("SkillInstance_PassConfition_2"), _floorData.LevelTotalTime - cond[2]))
        end
      end
    end
  end
  local nHas = PlayerData.Base:GetCurEnergy()
  self.nEnergyRequire = mapSkillInstanceData.EnergyConsume
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, self.nEnergyRequire)
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.nEnergyRequire and Red_Unable or Blue_Normal)
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapSkillInstanceData.SuggestedPower)
  local sScoreIcon = "Icon/BuildRank/BuildRank_" .. mapSkillInstanceData.SuggestedBuild
  self:SetPngSprite(self._mapNode.imgRecommendBuild, sScoreIcon)
  local tbReward = decodeJson(mapSkillInstanceData.BaseAwardPreview)
  self.tbReward = tbReward
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
  local isUnLock, isWorldClass, isPreLevelStar = PlayerData.SkillInstance:GetSkillInstanceUnlockMsg(self.skillInstanceId)
  self._mapNode.btnRaid.gameObject:SetActive(isUnLock)
  self._mapNode.btnGo.gameObject:SetActive(isUnLock)
  self._mapNode.btnLock.gameObject:SetActive(not isUnLock)
  self._mapNode.ListConditions:SetActive(not isUnLock)
  self._mapNode.imgDoubleDrop:SetActive(false)
  self._mapNode.imgReengagementDrop:SetActive(false)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  self.actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
  local bShowNormalDouble = false
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.SkillInstance) then
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
    local tempData = ConfigTable.GetData("SkillInstance", self.skillInstanceId)
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
end

function SkillInstanceLevelSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bJumpTo then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if self.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    self.curSelectHard = 1
    self.nCurGroupId = 0
    self.curState = 1
    self._panel._tbParam[2] = 0
    self._panel._tbParam[1] = 0
    self._mapNode.rt_SkillInstanceSelect:SetActive(true)
    self._mapNode.rt_SkillInstanceInfo:SetActive(false)
  end
end

function SkillInstanceLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_LevelItem(btn, nIdx)
  local nType = self.tbSkillInstanceType[nIdx]
  local bOpen = PlayerData.SkillInstance:CheckLevelOpen(nType, nil, true)
  if bOpen then
    self.curState = 2
    self.nCurGroupId = nType
    local nHard = PlayerData.SkillInstance:GetMaxSkillInstanceHard(nType)
    self._panel._tbParam[2] = nType
    self:RefreshSkillInstanceInfo(self.nCurGroupId, nHard, true, true)
    self._mapNode.rt_SkillInstanceSelect:SetActive(false)
    self._mapNode.rt_SkillInstanceInfo:SetActive(true)
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenSkillInsInfo")
  end
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_Go()
  local mapSkillInstanceData = self.mapAllSkillInstance[self.nCurGroupId][self.curSelectHard]
  local nNeedEnergy = mapSkillInstanceData.EnergyConsume
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
    local nCurMaxHard = PlayerData.SkillInstance:GetMaxSkillInstanceHard(self.nCurGroupId)
    PlayerData.SkillInstance:SetLastMaxHard(self.nCurGroupId, nCurMaxHard)
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.SkillInstance, self.skillInstanceId)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_Tog(btn)
  local nHard = table.indexof(self._mapNode.tog, btn:GetComponent("UIButton"))
  local togIdx = table.indexof(self._mapNode.tog, btn)
  if nHard == nil then
    return
  end
  if self.curSelectHard ~= nHard then
    for idx, value in pairs(mapToggle) do
      if value == self.curSelectHard then
        self._mapNode.togCtrl[idx]:SetTrigger(false)
        break
      end
    end
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self:RefreshSkillInstanceInfo(self.nCurGroupId, nHard, nil, false)
  end
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_RewardList(btn)
  self._mapNode.goRewardList:OpenPanel(self.tbReward)
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  local rtBtn = self._mapNode.item[nIdx].gameObject.transform
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, rtBtn, true, true, false)
  end
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_TogTips(btn, nIndex)
  if self.tbLockWorldClass[nIndex] then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("LevelSelect_LimitTipsWorldClass"), self.tbLockWorldClass[nIndex]))
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_LimitTips"))
  end
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_Skill(btn, nidx)
  local mapSkillInstanceData = self.mapAllSkillInstance[self.nCurGroupId][self.curSelectHard]
  local nSkillId = mapSkillInstanceData.SkillShow[nidx]
  if nSkillId ~= 0 then
    local mapData = {nSkillId = nSkillId, bTravelerDuel = true}
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_Raid()
  local curStar = PlayerData.SkillInstance:GetSkillInstanceStar(self.skillInstanceId)
  if curStar < 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  local mapSkillInstanceData = self.mapAllSkillInstance[self.nCurGroupId][self.curSelectHard]
  local nNeedEnergy = mapSkillInstanceData.EnergyConsume
  EventManager.Hit(EventId.OpenPanel, PanelId.Raid, mapSkillInstanceData.Id, nNeedEnergy, GameEnum.instanceType.SkillInstance)
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_Lock()
  self:OnBtnClick_TogTips(nil, self.curSelectHard)
end

function SkillInstanceLevelSelectCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenSkillMonsterInfo", self.skillInstanceId)
end

function SkillInstanceLevelSelectCtrl:OnEvent_RaidOpen()
  self._mapNode.animInfo:Play("EquipmentInstanceInfo_in", 0, 1)
  self._mapNode.animBack:Play("tc_top_back_01_t_in", 0, 1)
end

function SkillInstanceLevelSelectCtrl:RefreshDoubleDropCount()
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.SkillInstance) then
    local _, str = self.actData:GetDropString()
    local nCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDropCount, string.format("%s/%s", nMaxCount - nCount, nMaxCount))
  end
end

function SkillInstanceLevelSelectCtrl:RefreshReengagementCount()
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local str = ConfigTable.GetUIText("Reengagement_DoubleDrop_LevelTip") .. ":"
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDrop, str)
  local nMaxCount = PlayerData.Reengagement:GetMaxDoubleDropCount()
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDropCount, string.format("%s/%s", nReengagementCount, nMaxCount))
end

function SkillInstanceLevelSelectCtrl:OnEvent_RaidSuccess()
  self:RefreshDoubleDropCount()
  self:RefreshReengagementCount()
end

function SkillInstanceLevelSelectCtrl:OnEvent_UpdateWorldClass()
  self:RefreshLevelUnlock()
end

function SkillInstanceLevelSelectCtrl:OnEvent_UpdateEnergy()
  if self.curState == 2 then
    local nHas = PlayerData.Base:GetCurEnergy()
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, self.nEnergyRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.nEnergyRequire and Red_Unable or Blue_Normal)
  end
end

return SkillInstanceLevelSelectCtrl
