local UIReport = class("UIReport", UIBaseWindow)
local base = UIBaseWindow
local UIReportReasonItemGroup = require("Game.Report.UI.UIReportReasonItemGroup")
local CS_MessageCommon = CS.MessageCommon

function UIReport:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  self.canConfirm = false
  self.itemDic = {}
  self.colorDic = {}
  self.CheckFunc = BindCallback(self, self.CheckBtnConfirmCanClick)
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  PlayerDataCenter.friendDataCenter:SetLastReportDesc(nil)
  UIUtil.AddButtonListener(self.ui.btn_cancel, self, self.__OnBtnCancel)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnBtnCancel)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.__OnBtnCancel)
  UIUtil.AddButtonListener(self.ui.btn_confirm, self, self.__OnBtnConfirm)
  UIUtil.AddValueChangedListener(self.ui.input_reportDesc, self, self.__OnInputValueChanged)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  self.reportWordMax = userChatCtrl:GetChatSystemMainCfg().report_word_max
  self.reportDailyMax = userChatCtrl:GetChatSystemMainCfg().report_daily_max
end

function UIReport:InitReport(userInfoData)
  self.userIndoData = userInfoData
  self:RefreshReportView(userInfoData)
  self:InitReportItems(self.CheckFunc)
  self:CacheBtnConfirmColor()
  self:CheckBtnConfirmCanClick()
  local chatWin = UIManager:GetWindow(UIWindowTypeID.ChatSystem)
  if chatWin ~= nil then
    chatWin:OnClickUserInfoBackGround()
  end
end

function UIReport:InitReportItems(checkFunc)
  local group = UIReportReasonItemGroup.New()
  group:Init(self.ui.obj_reasonGroup)
  group:InitItemGroup(checkFunc)
  self.itemGroup = group
end

function UIReport:RefreshReportView(userInfoData)
  self.ui.tex_userName:SetIndex(0, userInfoData:GetAlias())
  self.ui.textItem_descNum:SetIndex(0, tostring(self.reportWordMax))
  local timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local counterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleChatReport, 0)
  local reportTimes = 0
  if counterEl ~= nil and counterEl.nextExpiredTm > PlayerDataCenter.timestamp then
    reportTimes = counterEl.times
  end
  self.ui.tex_reportTimes.text = reportTimes .. "/" .. self.reportDailyMax
end

function UIReport:CacheBtnConfirmColor()
  self.colorDic.cancel = self.ui.img_cancel.color
  self.colorDic.confirm = self.ui.img_confirm.color
end

function UIReport:CheckBtnConfirmCanClick()
  local index = self.itemGroup:GetCurSelectItemIndex()
  local desc = PlayerDataCenter.friendDataCenter:GetLastReportDesc()
  self.canConfirm = 0 < index and not string.IsNullOrEmpty(desc)
  if self.canConfirm then
    self.ui.img_confirm.color = self.colorDic.confirm
  else
    self.ui.img_confirm.color = self.colorDic.cancel
  end
end

function UIReport:__BackAction()
  self:Delete()
end

function UIReport:__OnBtnCancel()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReport:__OnBtnConfirm()
  if not self.canConfirm then
    return
  end
  local uid = self.userIndoData:GetUserUID()
  local index = self.itemGroup:GetCurSelectItemIndex()
  local desc = PlayerDataCenter.friendDataCenter:GetLastReportDesc()
  self.friendNetworkCtrl:CS_Report(uid, index, desc, function()
    PlayerDataCenter.friendDataCenter:SetLastReportDesc(nil)
    self.ui.input_reportDesc.text = nil
    self:RefreshReportView(self.userIndoData)
  end)
end

function UIReport:__OnInputValueChanged(value)
  local str = string.sub(value, 1, self.reportWordMax)
  self.ui.input_reportDesc.text = str
  local curDescNum = string.len(str)
  PlayerDataCenter.friendDataCenter:SetLastReportDesc(str)
  self.ui.textItem_descNum:SetIndex(0, tostring(self.reportWordMax - curDescNum))
  self:CheckBtnConfirmCanClick()
end

function UIReport:OnReportInvalidInput()
  PlayerDataCenter.friendDataCenter:SetLastReportDesc(nil)
  self.ui.input_reportDesc.text = nil
  self:RefreshReportView(self.userIndoData)
end

function UIReport:OnDelete()
  self.itemGroup:Delete()
  self.colorDic = nil
  base.OnDelete(self)
end

return UIReport
