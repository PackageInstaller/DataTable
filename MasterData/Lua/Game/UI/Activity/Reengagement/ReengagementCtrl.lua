local ReengagementCtrl = class("ReengagementCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local nTogCount = 5
ReengagementCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  svTog = {
    sComponentName = "LoopScrollView"
  },
  trSvTog = {sNodeName = "svTog", sComponentName = "Transform"},
  rtSignin = {
    sComponentName = "RectTransform"
  },
  ctrlSignin = {
    sNodeName = "rtSignin",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementSigninCtrl"
  },
  rtTask = {
    sComponentName = "RectTransform"
  },
  ctrlTask = {
    sNodeName = "rtTask",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementTaskCtrl"
  },
  rtDoubleDrop = {
    sComponentName = "RectTransform"
  },
  ctrlDoubleDrop = {
    sNodeName = "rtDoubleDrop",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementDoubleDropCtrl"
  },
  rtShopMall = {
    sComponentName = "RectTransform"
  },
  ctrlShopMall = {
    sNodeName = "rtShopMall",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementMallCtrl"
  },
  rtBDTrial = {
    sComponentName = "RectTransform"
  },
  ctrlBDTrial = {
    sNodeName = "rtBDTrial",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementBDTrialCtrl"
  },
  txtEnergyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Title"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  imgEnergyBarFill = {
    sComponentName = "RectTransform"
  },
  btnTrialDetail = {
    sComponentName = "UIButton",
    callback = "OnClickTrialDetail"
  },
  ReengagementPreviewPanel = {
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementBDPreviewCtrl"
  }
}
ReengagementCtrl._mapEventConfig = {
  [EventId.IsNewDay] = "OnEvent_NewDay"
}
local mapReddotKey = {
  [1] = RedDotDefine.Activity_Reengagement_LoginReward,
  [2] = RedDotDefine.Activity_Reengagement_Task,
  [4] = RedDotDefine.Activity_Reengagement_WeeklyCard
}

function ReengagementCtrl:ClearTogCtrl()
  if self.ctrlTog == nil then
    self.ctrlTog = {}
    return
  end
  for nInstanceID, objCtrl in pairs(self.ctrlTog) do
    objCtrl:UnRegisterReddot()
    self:UnbindCtrlByNode(objCtrl)
    self.ctrlTog[nInstanceID] = nil
  end
end

function ReengagementCtrl:InitTog()
  self:ClearTogCtrl()
  if self.nCurTog == nil or self.nCurTog < 1 or self.nCurTog > nTogCount then
    self.nCurTog = self:GetDefaultTog()
  end
  self._mapNode.svTog:Init(nTogCount, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function ReengagementCtrl:GetDefaultTog()
  for nIndex = 1, nTogCount do
    local sReddotKey = mapReddotKey[nIndex]
    if sReddotKey ~= nil and RedDotManager.GetValid(sReddotKey, {
      self.nActId
    }) then
      return nIndex
    end
  end
  local mapLoginReward = PlayerData.Reengagement:GetActLoginRewardList()
  if mapLoginReward == nil or (tonumber(mapLoginReward.Actual) or 0) < 7 then
    return 1
  end
  for nDay = 1, 7 do
    local tbQuestConfig = PlayerData.Reengagement:GetQuestConfigDataByGroup(100 + nDay)
    if #tbQuestConfig == 0 then
      return 2
    end
    for _, mapQuestConfig in ipairs(tbQuestConfig) do
      local mapQuest = PlayerData.Reengagement:GetQuestDataById(mapQuestConfig.Id)
      if mapQuest == nil or mapQuest.nStatus ~= 1 and mapQuest.nStatus ~= 2 then
        return 2
      end
    end
  end
  if 0 < PlayerData.Reengagement:GetDoubleDropCount() then
    return 3
  end
  return 1
end

function ReengagementCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.ctrlTog[nInstanceID] then
    self.ctrlTog[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.Reengagement.TemplateToggleReengagementCtrl")
  end
  local mapCfg = ConfigTable.GetUIText("ReengagementTog_" .. nIndex)
  if mapCfg then
    self.ctrlTog[nInstanceID]:SetText(mapCfg)
  end
  self.ctrlTog[nInstanceID]:SetDefault(nIndex == self.nCurTog)
  local sReddotKey = mapReddotKey[nIndex]
  self.ctrlTog[nInstanceID]:SetReddot(sReddotKey, {
    self.nActId
  })
  if self.nCurTog == nIndex then
    self.ctrlTog[nInstanceID]:SetTrigger(true)
  end
end

function ReengagementCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if nIndex == self.nCurTog then
    return
  end
  if self.ctrlTog[nInstanceID] ~= nil then
    self.ctrlTog[nInstanceID]:SetTrigger(true)
  end
  if self.nCurTog ~= nil and self.nCurTog > 0 then
    local goSelect = self._mapNode.trSvTog:Find("Viewport/Content/" .. self.nCurTog - 1)
    if goSelect then
      local objCurTog = self.ctrlTog[goSelect.gameObject:GetInstanceID()]
      if objCurTog ~= nil then
        objCurTog:SetTrigger(false)
      end
    end
  end
  self.nCurTog = nIndex
  self:SwitchTog(self._bInfoReady == true)
end

function ReengagementCtrl:SwitchTog(bRefreshData)
  self._mapNode.rtSignin.gameObject:SetActive(self.nCurTog == 1)
  self._mapNode.rtTask.gameObject:SetActive(self.nCurTog == 2)
  self._mapNode.rtDoubleDrop.gameObject:SetActive(self.nCurTog == 3)
  self._mapNode.rtShopMall.gameObject:SetActive(self.nCurTog == 4)
  self._mapNode.rtBDTrial.gameObject:SetActive(self.nCurTog == 5)
  if bRefreshData ~= true then
    return
  end
  self._mapNode.ctrlSignin:Refresh(self.nCurTog)
  self._mapNode.ctrlTask:Refresh(self.nCurTog)
  self._mapNode.ctrlDoubleDrop:Refresh(self.nCurTog)
  self._mapNode.ctrlShopMall:Refresh(self.nCurTog)
  self._mapNode.ctrlBDTrial:Refresh(self.nCurTog)
end

local nMaxEnergyBatteryFillerLength = 252
local nMinEnergyBatteryFillerLength = 15

function ReengagementCtrl:RefreshEnergyBattery()
  local nEnergyBattery = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  local nMaxEnergyBattery = ConfigTable.GetConfigNumber("EnergyBatteryMax")
  NovaAPI.SetTMPText(self._mapNode.txtProgress, nEnergyBattery .. "/" .. nMaxEnergyBattery)
  local nFillerLength = nEnergyBattery / nMaxEnergyBattery * nMaxEnergyBatteryFillerLength
  if nFillerLength > nMaxEnergyBatteryFillerLength then
    nFillerLength = nMaxEnergyBatteryFillerLength
  elseif nFillerLength < nMinEnergyBatteryFillerLength then
    nFillerLength = nMinEnergyBatteryFillerLength
  end
  self._mapNode.imgEnergyBarFill.sizeDelta = Vector2(nFillerLength, self._mapNode.imgEnergyBarFill.sizeDelta.y)
end

function ReengagementCtrl:Awake()
  self.ctrlTog = {}
  if self._bInfoReady == nil then
    self._bInfoReady = false
  end
end

function ReengagementCtrl:FadeIn()
end

function ReengagementCtrl:FadeOut()
end

function ReengagementCtrl:OnEnable()
  local nActId = PlayerData.Reengagement:GetActId()
  local nOpenTime = PlayerData.Reengagement:GetReengagementOpenTime()
  if self.nActId ~= nActId or self._nActOpenTime ~= nOpenTime then
    self._bInfoReady = false
    self.nCurTog = 0
    self._panel.nSelectGroup = nil
  end
  self.nActId = nActId
  self._nActOpenTime = nOpenTime
  self.nCurTog = self.nCurTog or 0
  self._mapNode.svTog.gameObject:SetActive(false)
  self:SwitchTog(false)
  self:RefreshEnergyBattery()
  
  local function init()
    self._bInfoReady = true
    if self._panel == nil or self._panel._bIsActive ~= true then
      return
    end
    self._mapNode.svTog.gameObject:SetActive(true)
    self:InitTog()
    self:SwitchTog(true)
  end
  
  if self._bInfoReady == false then
    PlayerData.Reengagement:RequestReengagementInfo(init)
  else
    init()
  end
end

function ReengagementCtrl:OnDisable()
  self:ClearTogCtrl()
end

function ReengagementCtrl:OnDestroy()
end

function ReengagementCtrl:OnRelease()
end

function ReengagementCtrl:OnClickTrialDetail()
  self._mapNode.ReengagementPreviewPanel:OpenPanel()
end

function ReengagementCtrl:OnEvent_NewDay()
  if PanelManager.GetCurPanelId() == PanelId.MainView then
    EventManager.Hit("NewDay_Clear_Guide")
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Alert_NextDay"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

return ReengagementCtrl
