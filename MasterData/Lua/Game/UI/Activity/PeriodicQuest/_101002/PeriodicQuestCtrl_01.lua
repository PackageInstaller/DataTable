local PeriodicQuestCtrl_01 = class("PeriodicQuestCtrl_01", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
PeriodicQuestCtrl_01._mapNodeConfig = {
  goCommon = {
    sNodeName = "---Common---"
  },
  goQuestProcess = {},
  txtProcess = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Process"
  },
  txtQuestProcess = {sComponentName = "TMP_Text"},
  btnReceiveFinal = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceiveFinal = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Receive"
  },
  imgCompleteFinal = {},
  txtComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Received"
  },
  btnUnComplete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UnComplete"
  },
  txtBtnUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Receive"
  },
  btnRewardPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardPreview"
  },
  txtRewardName = {sComponentName = "TMP_Text"},
  btnCharDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharPreview"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"}
}
PeriodicQuestCtrl_01._mapEventConfig = {
  RefreshPeriodicAct = "OnEvent_RefreshPeriodicAct"
}

function PeriodicQuestCtrl_01:OnDisable()
  self:UnbindCtrl()
end

function PeriodicQuestCtrl_01:RefreshActInfo()
  if self.activityCtrl ~= nil then
    self.activityCtrl:RefreshQuestList()
  end
  self:RefreshQuestProgress()
  self:RefreshQuestReward()
  local perQuestActCfg = self.actData:GetPerQuestCfg()
  self.nShowType = perQuestActCfg.PreviewType
  self.nRewardId = 0
  if self.nShowType == GameEnum.itemType.Char then
    self.nRewardId = perQuestActCfg.FinalReward1
    if 0 ~= self.nRewardId then
      self._mapNode.btnCharDetail.gameObject:SetActive(true)
      local charConfig = ConfigTable.GetData_Character(self.nRewardId)
      if charConfig ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtRewardName, charConfig.Name)
      end
    end
  elseif self.nShowType == GameEnum.itemType.Disc then
    self.nRewardId = perQuestActCfg.FinalReward1
    if 0 ~= self.nRewardId then
      self._mapNode.btnCharDetail.gameObject:SetActive(true)
      local itemCfg = ConfigTable.GetData_Item(self.nRewardId)
      if itemCfg ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtRewardName, itemCfg.Title)
      end
    end
  elseif self.nShowType == GameEnum.itemType.Item then
    self.nRewardId = perQuestActCfg.FinalReward1
    if 0 ~= self.nRewardId then
      self._mapNode.btnCharDetail.gameObject:SetActive(true)
      local itemCfg = ConfigTable.GetData_Item(self.nRewardId)
      if itemCfg ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtRewardName, itemCfg.Title)
      end
    end
  else
    self._mapNode.btnCharDetail.gameObject:SetActive(false)
  end
end

function PeriodicQuestCtrl_01:UnbindCtrl()
  if self.activityCtrl ~= nil then
    self:UnbindCtrlByNode(self.activityCtrl)
    self.activityCtrl = nil
  end
end

function PeriodicQuestCtrl_01:RefreshQuestProgress()
  local curProgress, allProgress, canReceive = self.actData:GetQuestProgress()
  NovaAPI.SetTMPText(self._mapNode.txtQuestProcess, string.format("%s/%s", curProgress, allProgress))
  self.bAllReceive = curProgress == allProgress
end

function PeriodicQuestCtrl_01:RefreshQuestReward()
  self._mapNode.btnReceiveFinal.gameObject:SetActive(not self.actData:CheckFinalReward() and self.bAllReceive)
  self._mapNode.btnUnComplete.gameObject:SetActive(not self.bAllReceive)
  self._mapNode.imgCompleteFinal.gameObject:SetActive(self.actData:CheckFinalReward())
  local perQuestActCfg = self.actData:GetPerQuestCfg()
end

function PeriodicQuestCtrl_01:InitActData(actData, bResetGroup)
  if self.activityCtrl == nil then
    self.activityCtrl = self:BindCtrlByNode(self._mapNode.goCommon, "Game.UI.Activity.PeriodicQuest.PeriodicQuestCtrl")
  end
  self.actData = actData
  self.nActId = actData:GetActId()
  self.activityCtrl:InitActData(actData, bResetGroup)
  self:RefreshActInfo()
  self:SetTime()
end

function PeriodicQuestCtrl_01:ClearActivity()
  self:UnbindCtrl()
end

function PeriodicQuestCtrl_01:SetTime()
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
    end
  end
end

function PeriodicQuestCtrl_01:OnBtnClick_Receive()
  local function callback()
    self:RefreshQuestReward()
    
    PlayerData.Base:TryOpenWorldClassUpgrade()
  end
  
  PlayerData.Activity:SendReceiveFinalReward(self.nActId, callback)
end

function PeriodicQuestCtrl_01:OnBtnClick_UnComplete()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PerActivity_UnComplete"))
end

function PeriodicQuestCtrl_01:OnBtnClick_RewardPreview()
  local perQuestActCfg = self.actData:GetPerQuestCfg()
  local nShowType = perQuestActCfg.PreviewType
  if nShowType == GameEnum.itemType.Char then
    local nCharId = perQuestActCfg.FinalReward1
    if 0 ~= nCharId then
      EventManager.Hit(EventId.OpenPanel, PanelId.GachaPreview, nCharId)
    end
  end
end

function PeriodicQuestCtrl_01:OnEvent_RefreshPeriodicAct(nActId)
  if nActId == self.nActId then
    self.bQuestAnim = false
    self:RefreshActInfo()
  end
end

function PeriodicQuestCtrl_01:OnBtnClick_CharPreview()
  if self.nRewardId == nil then
    return
  end
  if self.nShowType == GameEnum.itemType.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.nRewardId)
  elseif self.nShowType == GameEnum.itemType.Item then
    local itemCfg = ConfigTable.GetData_Item(self.nRewardId)
    if itemCfg ~= nil then
      local sType = itemCfg.Stype
      if sType == GameEnum.itemStype.OutfitCYO then
        EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, self.nRewardId, true)
      end
    end
  end
end

function PeriodicQuestCtrl_01:OnBtnClick_Detail()
  local perQuestActCfg = self.actData:GetPerQuestCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = perQuestActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function PeriodicQuestCtrl_01:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
      end
    })
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, orderedFormat(ConfigTable.GetUIText("PerActivity_Remain_Time") or "", sTimeStr))
end

return PeriodicQuestCtrl_01
