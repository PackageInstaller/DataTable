local EquipmentInstanceLevelSelectCtrl = class("EquipmentInstanceLevelSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LocalData = require("GameCore.Data.LocalData")
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
EquipmentInstanceLevelSelectCtrl._mapNodeConfig = {
  bgLevelInfo = {sNodeName = "----Bg----"},
  rt_EquipmentInstanceSelect = {},
  rt_EquipmentInstanceInfo = {},
  animInfo = {
    sNodeName = "rt_EquipmentInstanceInfo",
    sComponentName = "Animator"
  },
  animBack = {sNodeName = "goBack", sComponentName = "Animator"},
  goLSV = {},
  listLSV = {
    sComponentName = "LoopScrollView"
  },
  contentTemp = {
    sComponentName = "RectTransform"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_Goto"
  },
  btnGridList = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelItem"
  },
  gridListItem = {nCount = 3},
  btnSwitchLeft = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Left"
  },
  btnSwitchRight = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Right"
  },
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
    nCount = 2,
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
  goNormal = {},
  goEnhance = {},
  txtRewardTypeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_ChangeReward"
  },
  txtRewardType = {sComponentName = "TMP_Text"},
  btnRewardType = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeMode"
  },
  txtBtnRewardType = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_ChangeBtn"
  },
  btnCloseInfo = {
    sNodeName = "btnCloseInfo",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseChangeMode"
  },
  got_fullscreen_select = {
    sNodeName = "t_fullscreen_select"
  },
  btnsnapshot = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseChangeMode"
  },
  goRewardSelect = {},
  txtWindowTitleSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Reward_SelectTitle"
  },
  ani_RewardSelect = {
    sNodeName = "rt_RewardSelect",
    sComponentName = "Animator"
  },
  svSelectReward = {
    sComponentName = "LoopScrollView"
  },
  reddotSwitch = {},
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
EquipmentInstanceLevelSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  ChangeEquipmentInstanceRewardMode = "OnEvent_ChangeEquipmentInstanceRewardMode",
  EquipmentInstanceRaidOpen = "OnEvent_RaidOpen",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  RaidSuccess = "OnEvent_RaidSuccess"
}

function EquipmentInstanceLevelSelectCtrl:Awake()
  self.nEnergyRequire = 0
  self.mapLevelGrid = {}
  self:SetSprite_Coin(self._mapNode.imgTickets, AllEnum.CoinItemId.Energy)
end

function EquipmentInstanceLevelSelectCtrl:FadeIn()
end

function EquipmentInstanceLevelSelectCtrl:FadeOut()
end

function EquipmentInstanceLevelSelectCtrl:OnEnable()
  self.mapAllEquipmentInstance = {}
  self.tbEquipmentInstanceType = {}
  self.tbCharGemRewardGroup = {}
  
  local function foreachEquipmentInstance(mapData)
    if self.mapAllEquipmentInstance[mapData.Type] == nil then
      self.mapAllEquipmentInstance[mapData.Type] = {}
      table.insert(self.tbEquipmentInstanceType, mapData.Type)
    end
    self.mapAllEquipmentInstance[mapData.Type][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(ConfigTable.Get("CharGemInstance"), foreachEquipmentInstance)
  
  local function sortEquipmentInstance(a, b)
    local mapTypeA = ConfigTable.GetData("CharGemInstanceType", a)
    local mapTypeB = ConfigTable.GetData("CharGemInstanceType", b)
    return mapTypeA.Sort < mapTypeB.Sort
  end
  
  table.sort(self.tbEquipmentInstanceType, sortEquipmentInstance)
  
  local function forEachCharGemInstanceRewardGroup(mapData)
    if self.tbCharGemRewardGroup[mapData.GroupId] == nil then
      self.tbCharGemRewardGroup[mapData.GroupId] = {}
    end
    table.insert(self.tbCharGemRewardGroup[mapData.GroupId], mapData)
  end
  
  ForEachTableLine(DataTable.CharGemInstanceRewardGroup, forEachCharGemInstanceRewardGroup)
  for k, v in pairs(self.tbCharGemRewardGroup) do
    table.sort(v, function(a, b)
      return a.Id < b.Id
    end)
  end
  self.nRewardType = PlayerData.EquipmentInstance:GetLastRewardType()
  local tbParam = self:GetPanelParam()
  if nil ~= next(tbParam) then
    if tbParam[3] == nil then
    end
    self.bJumpTo = tbParam[3]
    self.nJumpToGroup = tbParam[2] == nil and 0 or tbParam[2]
    if tbParam[4] ~= nil then
      self.nRewardType = tbParam[4]
      PlayerData.EquipmentInstance:SetRewardType(self.nRewardType)
    end
    if 0 ~= self.nJumpToGroup then
      local nMaxHard = PlayerData.EquipmentInstance:GetMaxEquipmentInstanceHard(self.nJumpToGroup)
      local nJumpToHard = (nil == tbParam[1] or 0 == tbParam[1]) and nMaxHard or tbParam[1]
      if self.bJumpTo then
        self.nJumpToHard = nJumpToHard
      else
        local nLastMaxHard = PlayerData.EquipmentInstance:GetLastMaxHard(self.nJumpToGroup)
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
  self._mapNode.rt_EquipmentInstanceSelect:SetActive(true)
  self._mapNode.rt_EquipmentInstanceInfo:SetActive(false)
  self.curState = 1
  self.curSelectHard = 1
  self.nCurGroupId = 0
  self:RefreshLevelList()
  if self.nJumpToGroup ~= 0 and self.nJumpToGroup ~= nil then
    self:OpenJumpToGroup()
  end
end

function EquipmentInstanceLevelSelectCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
  self:UnbindAllGrids()
end

function EquipmentInstanceLevelSelectCtrl:OnDestroy()
end

function EquipmentInstanceLevelSelectCtrl:OnRelease()
end

function EquipmentInstanceLevelSelectCtrl:RefreshGrid(goGrid, gridIndex)
  if self.mapLevelGrid[goGrid] == nil then
    self.mapLevelGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.EquipmentInstanceLevelSelect.EquipmentInstanceRewardSelectGridCtrl")
  end
  local nIdx = gridIndex + 1
  local mapData = self.mapAllEquipmentInstance[self.nCurGroupId][self.curSelectHard]
  local nType = self.tbCharGemRewardGroup[mapData.DropId][nIdx].Id
  self.mapLevelGrid[goGrid]:Refresh(nType)
end

function EquipmentInstanceLevelSelectCtrl:UnbindAllGrids()
  for go, mapCtrl in pairs(self.mapLevelGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapLevelGrid = {}
end

function EquipmentInstanceLevelSelectCtrl:OpenJumpToGroup()
  self.nCurGroupId = self.nJumpToGroup
  local equipmentInstanceData = self.mapAllEquipmentInstance[self.nCurGroupId]
  if equipmentInstanceData == nil then
    printError("EquipmentInstance Type Data Missing:" .. self.nCurGroupId)
    return
  end
  self.curState = 2
  self:RefreshEquipmentInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_EquipmentInstanceSelect:SetActive(false)
  self._mapNode.rt_EquipmentInstanceInfo:SetActive(true)
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenEquipmentInsInfo")
end

function EquipmentInstanceLevelSelectCtrl:OpenJumpToHard()
  self.curState = 2
  self.nCurGroupId = self.nJumpToGroup
  local nJumptoDuelId = self.mapAllEquipmentInstance[self.nCurGroupId][self.nJumpToHard].Id
  if not PlayerData.EquipmentInstance:GetEquipmentInstanceLevelUnlock(nJumptoDuelId) then
    self.nJumpToHard = 1
  end
  self:RefreshEquipmentInstanceInfo(self.nCurGroupId, self.nJumpToHard, true, true)
  self._mapNode.rt_EquipmentInstanceSelect:SetActive(false)
  self._mapNode.rt_EquipmentInstanceInfo:SetActive(true)
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenEquipmentInsInfo")
end

function EquipmentInstanceLevelSelectCtrl:RefreshLevelUnlock()
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllEquipmentInstance[self.nCurGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nLevelId = self.mapAllEquipmentInstance[self.nCurGroupId][mapToggle[index]].Id
      local bLock, nWorldClass = PlayerData.EquipmentInstance:GetEquipmentInstanceLevelUnlock(nLevelId)
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
      local curStar, tbTarget = PlayerData.EquipmentInstance:GetEquipmentInstanceStar(nLevelId)
      for j = 1, 3 do
        local btnStar = self._mapNode.rt_Targets[index].gameObject.transform:Find("btnTarget" .. j):GetComponent("Button")
        btnStar.interactable = tbTarget[j]
      end
    end
  end
end

function EquipmentInstanceLevelSelectCtrl:RefreshLevelList()
  self._mapNode.contentTemp.gameObject:SetActive(#self.tbEquipmentInstanceType <= 3)
  self._mapNode.goLSV.gameObject:SetActive(#self.tbEquipmentInstanceType > 3)
  if #self.tbEquipmentInstanceType <= 3 then
    for k, v in ipairs(self._mapNode.gridListItem) do
      v.gameObject:SetActive(k <= #self.tbEquipmentInstanceType)
      if k <= #self.tbEquipmentInstanceType then
        self:RefreshListGrid(v, k - 1, true)
      end
    end
  else
    self._mapNode.listLSV:Init(#self.tbEquipmentInstanceType, self, self.RefreshListGrid, self.OnGridClick, false, nil, true)
  end
end

function EquipmentInstanceLevelSelectCtrl:RefreshListGrid(goGrid, gridIndex, bStationary)
  local nIndex = gridIndex + 1
  local nType = self.tbEquipmentInstanceType[nIndex]
  if nType ~= nil then
    local mapCfg = ConfigTable.GetData("CharGemInstanceType", nType)
    if mapCfg ~= nil then
      local goItem
      if bStationary then
        goItem = goGrid.transform:Find(string.format("btnGridList%s/AnimRoot/goLevelItem", nIndex))
      else
        goItem = goGrid.transform:Find("btnGrid/AnimRoot/goLevelItem")
      end
      local imgLevelBg = goItem:Find("imgLevelBg"):GetComponent("Image")
      local TMPInstanceName = goItem.transform:Find("TMPInstanceName"):GetComponent("TMP_Text")
      local rtElementsInfo = goItem.transform:Find("rtElementsInfo")
      if #mapCfg.EET == 0 then
        rtElementsInfo.gameObject:SetActive(false)
      else
        rtElementsInfo.gameObject:SetActive(true)
        for i = 1, 4 do
          local imgElementInfo = rtElementsInfo:Find("imgRecommend/imgElementInfo" .. i):GetComponent("Image")
          if mapCfg.EET ~= nil and mapCfg.EET[i] ~= nil then
            imgElementInfo.gameObject:SetActive(true)
            self:SetAtlasSprite(imgElementInfo, "12_rare", AllEnum.ElementIconType.Icon .. mapCfg.EET[i])
          else
            imgElementInfo.gameObject:SetActive(false)
          end
        end
      end
      NovaAPI.SetTMPText(TMPInstanceName, mapCfg.Name)
      self:SetSprite(imgLevelBg, "UI/EquipmentInstanceLevelSelect/Sprite/" .. mapCfg.Episode)
    end
  end
end

function EquipmentInstanceLevelSelectCtrl:OnGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nType = self.tbEquipmentInstanceType[nIndex]
  if nType ~= nil then
    self:OnBtnClick_LevelItem(nil, nIndex)
  end
end

function EquipmentInstanceLevelSelectCtrl:RefreshEquipmentInstanceInfo(nGroupId, nHard, bLocation, bSetTog)
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
  local mapEquipmentInstanceData = self.mapAllEquipmentInstance[nGroupId][nHard]
  self.equipmentInstanceId = mapEquipmentInstanceData.Id
  if mapEquipmentInstanceData == nil then
    return
  end
  local bEnhance = mapEquipmentInstanceData.DropId and mapEquipmentInstanceData.DropId > 0
  self._mapNode.goNormal:SetActive(not bEnhance)
  self._mapNode.goEnhance:SetActive(bEnhance)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceName, mapEquipmentInstanceData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceDesc, mapEquipmentInstanceData.Desc)
  self:SetPngSprite(self._mapNode.imgLevelImg, mapEquipmentInstanceData.Icon)
  local nType = mapEquipmentInstanceData.Type
  local mapLevelCfgData = ConfigTable.GetData("CharGemInstanceType", nType)
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
  local curStar = PlayerData.EquipmentInstance:GetEquipmentInstanceStar(self.equipmentInstanceId)
  self._mapNode.txtBtnRaid.gameObject:SetActive(3 <= curStar)
  local raidUnlockMask = self._mapNode.btnRaid.transform:Find("AnimRoot/imgUnlockMask")
  raidUnlockMask.gameObject:SetActive(not (3 <= curStar))
  local tbCond = {}
  table.insert(tbCond, decodeJson(mapEquipmentInstanceData.OneStarCondition))
  table.insert(tbCond, decodeJson(mapEquipmentInstanceData.TwoStarCondition))
  table.insert(tbCond, decodeJson(mapEquipmentInstanceData.ThreeStarCondition))
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
      local _floorData = ConfigTable.GetData("SkillInstanceFloor", mapEquipmentInstanceData.FloorId)
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
  self.nEnergyRequire = mapEquipmentInstanceData.EnergyConsume
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, self.nEnergyRequire)
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.nEnergyRequire and Red_Unable or Blue_Normal)
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapEquipmentInstanceData.SuggestedPower)
  local sScoreIcon = "Icon/BuildRank/BuildRank_" .. mapEquipmentInstanceData.SuggestedBuild
  self:SetPngSprite(self._mapNode.imgRecommendBuild, sScoreIcon)
  local tbReward = {}
  if bEnhance then
    if self.tbCharGemRewardGroup[mapEquipmentInstanceData.DropId] ~= nil then
      for k, v in ipairs(self.tbCharGemRewardGroup[mapEquipmentInstanceData.DropId]) do
        if v.RewardType == self.nRewardType then
          tbReward = decodeJson(v.BaseAwardPreview)
          NovaAPI.SetTMPText(self._mapNode.txtRewardType, v.RewardName)
        end
      end
      if curStar <= 0 then
        local firstReward = mapEquipmentInstanceData.FirstRewardPreview
        if firstReward ~= nil and 0 < #firstReward then
          table.insert(tbReward, 1, {
            firstReward[1],
            firstReward[2],
            1
          })
        end
      end
    end
  else
    tbReward = decodeJson(mapEquipmentInstanceData.BaseAwardPreview)
  end
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
  local isUnLock, isWorldClass, isPreLevelStar = PlayerData.EquipmentInstance:GetEquipmentInstanceUnlockMsg(self.equipmentInstanceId)
  self._mapNode.btnRaid.gameObject:SetActive(isUnLock)
  self._mapNode.btnGo.gameObject:SetActive(isUnLock)
  self._mapNode.btnLock.gameObject:SetActive(not isUnLock)
  self._mapNode.ListConditions:SetActive(not isUnLock)
  self._mapNode.imgDoubleDrop:SetActive(false)
  self._mapNode.imgReengagementDrop:SetActive(false)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  self.actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
  local bShowNormalDouble = false
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.CharGemInstance) then
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
    local tempData = ConfigTable.GetData("CharGemInstance", self.equipmentInstanceId)
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
  RedDotManager.RegisterNode(RedDotDefine.CharGemInstanceSwitch, {nGroupId}, self._mapNode.reddotSwitch)
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_Back(nPanelId)
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
    self._mapNode.rt_EquipmentInstanceSelect:SetActive(true)
    self._mapNode.rt_EquipmentInstanceInfo:SetActive(false)
  end
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_ChangeEquipmentInstanceRewardMode()
  self.nRewardType = PlayerData.EquipmentInstance:GetLastRewardType()
  self:RefreshEquipmentInstanceInfo(self.nCurGroupId, self.curSelectHard, true, true)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_LevelItem(btn, nIdx)
  WwiseAudioMgr:PlaySound("ui_common_button_select")
  local nType = self.tbEquipmentInstanceType[nIdx]
  local bOpen = PlayerData.EquipmentInstance:CheckLevelOpen(nType, nil, true)
  if bOpen then
    self.curState = 2
    self.nCurGroupId = nType
    local nHard = PlayerData.EquipmentInstance:GetMaxEquipmentInstanceHard(nType)
    self._panel._tbParam[2] = nType
    self:RefreshEquipmentInstanceInfo(self.nCurGroupId, nHard, true, true)
    self._mapNode.rt_EquipmentInstanceSelect:SetActive(false)
    self._mapNode.rt_EquipmentInstanceInfo:SetActive(true)
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenEquipmentInsInfo")
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Left()
  local index = self._mapNode.listLSV:GetFirsetGridIndex()
  self._mapNode.listLSV:SetScrollGridPos(index - 1, 0.2, 0)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Right()
  local index = self._mapNode.listLSV:GetFirsetGridIndex()
  self._mapNode.listLSV:SetScrollGridPos(index + 1, 0.2, 0)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Go()
  local mapEquipmentInstanceData = self.mapAllEquipmentInstance[self.nCurGroupId][self.curSelectHard]
  local nNeedEnergy = mapEquipmentInstanceData.EnergyConsume
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
    local nCurMaxHard = PlayerData.EquipmentInstance:GetMaxEquipmentInstanceHard(self.nCurGroupId)
    PlayerData.EquipmentInstance:SetLastMaxHard(self.nCurGroupId, nCurMaxHard)
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.EquipmentInstance, self.equipmentInstanceId)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Tog(btn)
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
    self:RefreshEquipmentInstanceInfo(self.nCurGroupId, nHard, nil, false)
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_RewardList(btn)
  self._mapNode.goRewardList:OpenPanel(self.tbReward)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  local rtBtn = self._mapNode.item[nIdx].gameObject.transform
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, rtBtn, true, true, false)
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_ChangeMode(btn)
  self._mapNode.goRewardSelect:SetActive(true)
  self._mapNode.got_fullscreen_select:SetActive(true)
  self._mapNode.ani_RewardSelect:Play("t_window_04_t_in")
  local mapData = self.mapAllEquipmentInstance[self.nCurGroupId][self.curSelectHard]
  self._mapNode.svSelectReward:SetAnim(0.07)
  self._mapNode.svSelectReward:Init(#self.tbCharGemRewardGroup[mapData.DropId], self, self.RefreshGrid)
  local bNew = RedDotManager.GetValid(RedDotDefine.CharGemInstanceSwitch, {
    self.nCurGroupId
  })
  if bNew then
    LocalData.SetPlayerLocalData("CharGemInstanceSwitch" .. self.nCurGroupId, false)
    PlayerData.EquipmentInstance:UpdateNewRewardSwitch(self.nCurGroupId)
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_CloseChangeMode(btn)
  self._mapNode.ani_RewardSelect:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen_select:SetActive(false)
  self:AddTimer(1, 0.2, function()
    self._mapNode.goRewardSelect:SetActive(false)
  end, true, true, true)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_TogTips(btn, nIndex)
  if self.tbLockWorldClass[nIndex] then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("LevelSelect_LimitTipsWorldClass"), self.tbLockWorldClass[nIndex]))
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_LimitTips"))
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Skill(btn, nidx)
  local mapEquipmentInstanceData = self.mapAllEquipmentInstance[self.nCurGroupId][self.curSelectHard]
  local nSkillId = mapEquipmentInstanceData.SkillShow[nidx]
  if nSkillId ~= 0 then
    local mapData = {nSkillId = nSkillId, bTravelerDuel = true}
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Raid()
  local curStar = PlayerData.EquipmentInstance:GetEquipmentInstanceStar(self.equipmentInstanceId)
  if curStar < 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  local mapEquipmentInstanceData = self.mapAllEquipmentInstance[self.nCurGroupId][self.curSelectHard]
  local nNeedEnergy = mapEquipmentInstanceData.EnergyConsume
  EventManager.Hit(EventId.OpenPanel, PanelId.Raid, mapEquipmentInstanceData.Id, nNeedEnergy, GameEnum.instanceType.CharGemInstance)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_Lock()
  self:OnBtnClick_TogTips(nil, self.curSelectHard)
end

function EquipmentInstanceLevelSelectCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenEquipmentMonsterInfo", self.equipmentInstanceId)
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_RaidOpen()
  self._mapNode.animInfo:Play("EquipmentInstanceInfo_in", 0, 1)
  self._mapNode.animBack:Play("tc_top_back_01_t_in", 0, 1)
end

function EquipmentInstanceLevelSelectCtrl:RefreshDoubleDropCount()
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.CharGemInstance) then
    local _, str = self.actData:GetDropString()
    local nCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDropCount, string.format("%s/%s", nMaxCount - nCount, nMaxCount))
  end
end

function EquipmentInstanceLevelSelectCtrl:RefreshReengagementCount()
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local str = ConfigTable.GetUIText("Reengagement_DoubleDrop_LevelTip") .. ":"
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDrop, str)
  local nMaxCount = PlayerData.Reengagement:GetMaxDoubleDropCount()
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDropCount, string.format("%s/%s", nReengagementCount, nMaxCount))
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_RaidSuccess()
  self:RefreshDoubleDropCount()
  self:RefreshReengagementCount()
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_UpdateWorldClass()
  self:RefreshLevelUnlock()
end

function EquipmentInstanceLevelSelectCtrl:OnEvent_UpdateEnergy()
  if self.curState == 2 then
    local nHas = PlayerData.Base:GetCurEnergy()
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, self.nEnergyRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.nEnergyRequire and Red_Unable or Blue_Normal)
  end
end

return EquipmentInstanceLevelSelectCtrl
