local ActivityListCtrl = class("ActivityListCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local LocalData = require("GameCore.Data.LocalData")
ActivityListCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  loopSv = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  rtContent = {
    sNodeName = "---Content---",
    sComponentName = "RectTransform"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  }
}
ActivityListCtrl._mapEventConfig = {
  ShowActRewardList = "OnEvent_ShowActRewardList"
}
local sEntranceFolder_old = "UI_Activity/%s/%s.prefab"
local sEntranceFolder = "UI_Activity/%s.prefab"
local sActTypePath = {
  [GameEnum.activityType.PeriodicQuest] = "PeriodicQuest",
  [GameEnum.activityType.LoginReward] = "LoginReward",
  [GameEnum.activityType.SignIn] = "LoginReward",
  [GameEnum.activityType.Mining] = "Mining",
  [GameEnum.activityType.Trial] = "Trial",
  [GameEnum.activityType.Cookie] = "Cookie",
  [GameEnum.activityType.TowerDefense] = "TowerDefense",
  [GameEnum.activityType.JointDrill] = "JointDrill",
  [GameEnum.activityType.Advertise] = "Advertise",
  [GameEnum.activityType.Task] = "ActivityTask",
  [GameEnum.activityType.PenguinCard] = "PenguinCard",
  [GameEnum.activityType.Double] = "DoubleDrop",
  [GameEnum.activityType.FollowSocialMedia] = "FollowSocialMedia",
  [GameEnum.activityType.Soldier] = "Soldier",
  [GameEnum.activityType.MailBind] = "MailBind"
}

function ActivityListCtrl:GetEntranceId()
  if self.nInitActId ~= nil and self.nInitActId ~= 0 then
    local actCfg = ConfigTable.GetData("Activity", self.nInitActId)
    if actCfg ~= nil then
      return actCfg.EntranceId or 0
    end
    local actGroupCfg = ConfigTable.GetData("ActivityGroup", self.nInitActId)
    if actGroupCfg ~= nil then
      return actGroupCfg.EntranceId or 0
    end
  end
  return self.nEntranceId or 0
end

function ActivityListCtrl:InitActivityList(nCurActId)
  local tbActList = PlayerData.Activity:GetSortedActList()
  local tbActGroupList = PlayerData.Activity:GetSortedActGroupList()
  self.tbActList = {}
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local nCurEntranceId = self:GetEntranceId()
  for k, v in ipairs(tbActList) do
    if not v.actCfg.HideFromActivityList and (v.actCfg.EntranceId or 0) == nCurEntranceId then
      table.insert(self.tbActList, {
        nType = AllEnum.ActivityMainType.Activity,
        actData = v
      })
    end
  end
  for k, v in ipairs(tbActGroupList) do
    if (v.actGroupCfg.EntranceId or 0) == nCurEntranceId then
      table.insert(self.tbActList, {
        nType = AllEnum.ActivityMainType.ActivityGroup,
        actData = v
      })
    end
  end
  if nil ~= self.tbActList then
    if nil ~= self._panel.nSelectActId and nil ~= self.nSelectActMainType then
      local actData
      if self.nSelectActMainType == AllEnum.ActivityMainType.Activity then
        actData = PlayerData.Activity:GetActivityDataById(self._panel.nSelectActId)
      elseif self.nSelectActMainType == AllEnum.ActivityMainType.ActivityGroup then
        actData = PlayerData.Activity:GetActivityGroupDataById(self._panel.nSelectActId)
      end
      local bOpen = false
      if nil ~= actData then
        if self.nSelectActMainType == AllEnum.ActivityMainType.Activity then
          bOpen = actData:CheckActivityOpen()
        elseif self.nSelectActMainType == AllEnum.ActivityMainType.ActivityGroup then
          bOpen = actData:CheckActGroupShow()
        end
      end
      if nil == actData or not bOpen then
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_2")
        })
        self._panel.nSelectActId = nil
      end
    end
    self.nSelectIndex = 1
    if self._panel.nSelectActId ~= nil or nCurActId ~= nil then
      local nActId = self._panel.nSelectActId == nil and nCurActId or self._panel.nSelectActId
      for k, actData in ipairs(self.tbActList) do
        local actId = actData.nType == AllEnum.ActivityMainType.Activity and actData.actData:GetActId() or actData.actData:GetActGroupId()
        if nil ~= nActId and actId == nActId then
          self.nSelectIndex = k
        end
      end
    end
    self.nPageCount = 0
    self._mapNode.loopSv:Init(#self.tbActList, self, self.OnRefreshGrid, self.OnGridBtnClick, true, self.GetGridPageCount)
    self._mapNode.loopSv:SetScrollGridPos(self.nSelectIndex - 1, 0.5)
    self.bPlayAnim = false
    self:RefreshSelectActivity(false)
  end
end

function ActivityListCtrl:GetGridPageCount(nPageCount)
  self.nPageCount = nPageCount >= #self.tbActList and #self.tbActList or nPageCount
end

function ActivityListCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nPageCount > 0 and self.bPlayAnim then
    local trans = goGrid.transform:Find("btnGrid")
    local doTweenTime = 0.25
    local delayTime = (nIndex - 1) * 0.05
    trans.anchoredPosition = Vector2(0, -200)
    local sequence = DOTween.Sequence()
    sequence:Append(trans:DOAnchorPosY(0, doTweenTime):SetUpdate(true))
    sequence:SetUpdate(true):SetDelay(delayTime)
    self.nPageCount = self.nPageCount - 1
  end
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.ActivityList.ActivityTabCtrl")
  end
  goGrid.gameObject:SetActive(true)
  self.tbGridCtrl[nInstanceId]:Init(self.tbActList[nIndex])
  self.tbGridCtrl[nInstanceId]:SetSelect(nIndex == self.nSelectIndex)
end

function ActivityListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nSelectIndex then
    return
  end
  local actData = self.tbActList[nIndex].actData
  local bOpen = false
  if actData == nil then
    printError("活动列表中该活动数据为空")
  elseif self.tbActList[nIndex].nType == AllEnum.ActivityMainType.Activity and actData:CheckActivityOpen() or self.tbActList[nIndex].nType == AllEnum.ActivityMainType.ActivityGroup and actData:CheckActGroupShow() then
    bOpen = true
  end
  if not bOpen then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1")
    })
    EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
    return
  end
  local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  local nInstanceID = goGrid:GetInstanceID()
  self.nSelectIndex = nIndex
  self.tbGridCtrl[nInstanceID]:SetSelect(true)
  if self.tbActList[nIndex].nType == AllEnum.ActivityMainType.Activity then
    EventManager.Hit("ActivityListChangeTab", actData:GetActId())
  else
    EventManager.Hit("ActivityListChangeTab", actData:GetActGroupId())
  end
  self.tbInitActIds = {}
  self:RefreshSelectActivity(true)
end

function ActivityListCtrl:AddPeriodicActivityCtrl(actData, bResetDay)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local perActCfg = actData:GetPerQuestCfg()
    local sCtrlFolder = sActTypePath[GameEnum.activityType.PeriodicQuest]
    if sCtrlFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, perActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sCtrlFolder, perActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData, bResetDay)
end

function ActivityListCtrl:AddLoginRewardActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local mapActCfg = actData:GetLoginRewardControlCfg()
    local sCtrlFolder = sActTypePath[GameEnum.activityType.LoginReward] or sActTypePath[GameEnum.activityType.SignIn]
    if sCtrlFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sCtrlFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddMiningActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local miningActCfg = actData:GetMiningCfg()
    local sFolder = sActTypePath[GameEnum.activityType.Mining]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, miningActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, miningActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddTrialActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local mapActCfg = actData:GetTrialControlCfg()
    local sFolder = mapActCfg.UIAssets
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format("UI_Activity/%s/Entrance.prefab", sFolder)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddCookieActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local mapActCfg = actData:GetCookieControlCfg()
    if mapActCfg == nil then
      return
    end
    local sFolder = sActTypePath[GameEnum.activityType.Cookie]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder_old, sFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddTowerDefenseActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local towerDefenseActCfg = actData:GetActConfig()
    local sFolder = sActTypePath[GameEnum.activityType.TowerDefense]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder_old, sFolder, towerDefenseActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, towerDefenseActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddJointDrillActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local jointDrillActCfg = actData:GetJointDrillActCfg()
    local sFolder = sActTypePath[GameEnum.activityType.JointDrill]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, jointDrillActCfg.DrillPrefab)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, jointDrillActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddActivityGroupCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActGroupId()]
  if nil == actCtrl then
    local actGroupCfg = actData:GetActGroupCfgData()
    local sFolder = actGroupCfg.UIAssetsPrefab
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format("UI_Activity/%s/Entrance.prefab", sFolder)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.ActivityTheme.%s.%s", sFolder, actGroupCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActGroupId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData, table.indexof(self.tbInitActIds, actData:GetActGroupId()) > 0)
  table.insert(self.tbInitActIds, actData:GetActGroupId())
end

function ActivityListCtrl:AddAdvertisingActCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local sFolder = sActTypePath[GameEnum.activityType.Advertise]
    if sFolder == nil then
      return
    end
    local adControlCfg = ConfigTable.GetData("AdControl", actData.nActId)
    local uiAssetPath = adControlCfg.UIAssets
    local sPrefabPath = string.format(sEntranceFolder, uiAssetPath)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local ctrlPath = adControlCfg.CtrlName
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, ctrlPath)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddActivityTaskActCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local sAssetsFolder = "_" .. actData:GetActId()
    local sCtrlFolder = sActTypePath[GameEnum.activityType.Task]
    if sCtrlFolder == nil then
      return
    end
    local adControlCfg = CacheTable.GetData("_ActivityTaskControl", actData.nActId)
    if adControlCfg == nil then
      return
    end
    local uiAssetPath = adControlCfg.UIAssets
    if uiAssetPath == "" then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder_old, sAssetsFolder, uiAssetPath)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local ctrlPath = adControlCfg.CtrlName
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sCtrlFolder, ctrlPath)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddBdConvertActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local BdConvertActCfg = actData:GetActConfig()
    local sPrefabPath = string.format(sEntranceFolder, BdConvertActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", "BdConvert", BdConvertActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddPenguinCardActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local mapActCfg = ConfigTable.GetData("PenguinCardControl", actData:GetActId())
    if not mapActCfg then
      return
    end
    local sFolder = sActTypePath[GameEnum.activityType.PenguinCard]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddDoubleDropActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local mapActCfg = ConfigTable.GetData("ActivityDouble", actData:GetActId())
    if not mapActCfg then
      return
    end
    local sFolder = sActTypePath[GameEnum.activityType.Double]
    if sFolder == nil then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddFollowSocialMediaActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local sFolder = sActTypePath[GameEnum.activityType.FollowSocialMedia]
    if sFolder == nil then
      return
    end
    local mapActCfg = ConfigTable.GetData("FollowSocialMediaControl", actData:GetActId())
    if not mapActCfg then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddSoldierActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local sFolder = sActTypePath[GameEnum.activityType.Soldier]
    if sFolder == nil then
      return
    end
    local mapActCfg = ConfigTable.GetData("SoldierControl", actData:GetActId())
    if not mapActCfg then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:AddMailBindActivityCtrl(actData)
  local actCtrl = self.tbActCtrlObj[actData:GetActId()]
  if nil == actCtrl then
    local sFolder = sActTypePath[GameEnum.activityType.MailBind]
    if sFolder == nil then
      return
    end
    local mapActCfg = ConfigTable.GetData("ActivityMailBindControl", actData:GetActId())
    if not mapActCfg then
      return
    end
    local sPrefabPath = string.format(sEntranceFolder, mapActCfg.UIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.%s.%s", sFolder, mapActCfg.CtrlName)
    actCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.tbActCtrlObj[actData:GetActId()] = actCtrl
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function ActivityListCtrl:RefreshSelectActivity(bResetDay)
  for _, v in pairs(self.tbActCtrlObj) do
    v.gameObject:SetActive(false)
  end
  local actData = self.tbActList[self.nSelectIndex]
  if nil == actData then
    return
  end
  self.nSelectActMainType = actData.nType
  if actData.nType == AllEnum.ActivityMainType.Activity then
    self._panel.nSelectActId = actData.actData:GetActId()
    local actType = actData.actData:GetActType()
    if actType == GameEnum.activityType.PeriodicQuest then
      self:AddPeriodicActivityCtrl(actData.actData, bResetDay)
    elseif actType == GameEnum.activityType.LoginReward or actType == GameEnum.activityType.SignIn then
      self:AddLoginRewardActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Mining then
      self:AddMiningActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Trial then
      self:AddTrialActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Cookie then
      self:AddCookieActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.TowerDefense then
      self:AddTowerDefenseActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.JointDrill then
      self:AddJointDrillActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Advertise then
      self:AddAdvertisingActCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Task then
      self:AddActivityTaskActCtrl(actData.actData)
    elseif actType == GameEnum.activityType.BDConvert then
      self:AddBdConvertActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.PenguinCard then
      self:AddPenguinCardActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Double then
      self:AddDoubleDropActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.FollowSocialMedia then
      self:AddFollowSocialMediaActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.Soldier then
      self:AddSoldierActivityCtrl(actData.actData)
    elseif actType == GameEnum.activityType.MailBind then
      self:AddMailBindActivityCtrl(actData.actData)
    end
  elseif actData.nType == AllEnum.ActivityMainType.ActivityGroup then
    self._panel.nSelectActId = actData.actData:GetActGroupId()
    self:AddActivityGroupCtrl(actData.actData)
  end
  if self._panel.nSelectActId ~= nil then
    LocalData.SetPlayerLocalData("Activity_Tab_New_" .. self._panel.nSelectActId, 1)
    RedDotManager.SetValid(RedDotDefine.Activity_New_Tab, self._panel.nSelectActId, false)
  end
end

function ActivityListCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.animRoot:Play("ActivityPanel_in")
end

function ActivityListCtrl:Awake()
  self.nSelectIndex = nil
  self.nInitActId = nil
  self.nEntranceId = nil
  self.bPlayAnim = true
  self.tbInitActIds = {}
  local tbParams = self:GetPanelParam()
  if type(tbParams) == "table" then
    self.nInitActId = tbParams[1]
    self.nEntranceId = tbParams[2]
  end
  self._mapNode.goRewardList.gameObject:SetActive(false)
end

function ActivityListCtrl:OnEnable()
  self.tbActCtrlObj = {}
  self.tbActList = {}
  self.tbGridCtrl = {}
  self:InitActivityList(self.nInitActId)
end

function ActivityListCtrl:OnDisable()
  self.tbActList = {}
  for _, v in pairs(self.tbActCtrlObj) do
    if v.ClearActivity ~= nil then
      v:ClearActivity()
    end
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbActCtrlObj = {}
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ActivityListCtrl:OnDestroy()
end

function ActivityListCtrl:OnEvent_ShowActRewardList(tbReward)
  self._mapNode.goRewardList:OpenPanel(tbReward)
end

return ActivityListCtrl
