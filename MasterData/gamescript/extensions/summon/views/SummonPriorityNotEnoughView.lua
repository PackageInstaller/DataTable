local BPLimitItem = DT.GetConstant("BPLimitItem")
local SeniroSummonItemTid = DT.GetConstant("SeniroSummonItemTid")
local SummonPriorityNotEnoughView, Super = NewClass("SummonPriorityNotEnoughView", BaseView)
SummonPriorityNotEnoughView.uiResCls = UI_Common_Popup_Tip_3Resource

function SummonPriorityNotEnoughView:ctor(viewData)
  Super.ctor(self)
  self.lackNum = viewData.lackNum
  self.confirmFunc = viewData.confirmFunc
  self.tipsTid = "SummonPriorityNotEnoughTips"
  self.tipsTypeCfg = DT.TipsType[self.tipsTid]
  self.isOn = false
  self.execFuncType = nil
end

function SummonPriorityNotEnoughView:RegisterNotifications()
end

function SummonPriorityNotEnoughView:RegisterEvents()
  self:AddToggleValueChangeListener(self.ui.Toggle_Screening, System.fn(self, self.OnToggle))
end

function SummonPriorityNotEnoughView:OnBuildView()
  Super.OnBuildView(self)
end

function SummonPriorityNotEnoughView:OnEnterView()
  Super.OnEnterView(self)
  local cfgDesc = self.tipsTypeCfg.Desc
  self:SetText(self.ui.Text_Tips, LT.Textf(cfgDesc, self.lackNum, ItemDataUtils.GetItemName(BPLimitItem), self.lackNum, ItemDataUtils.GetItemName(SeniroSummonItemTid)))
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      self.execFuncType = 1
      self:Close()
    end,
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    textTitleCN = LT.Text(self.tipsTypeCfg.Title),
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, viewData)
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, {BPLimitItem, SeniroSummonItemTid})
  self:SetActive(self.ui.Group_Need, true)
  self:SetText(self.ui.Text_Need, LT.Text("ItemNeed"))
  self:SetImage(self.ui.Image_icon_2, ItemDataUtils.GetIcon(SeniroSummonItemTid))
  self:SetText(self.ui.Text_coin, string.format("%s/%s", ItemDataUtils.GetItemNum(SeniroSummonItemTid), self.lackNum))
  local toggleTipsText = ""
  if self.tipsTypeCfg and self.tipsTypeCfg.DonotRemind then
    if 1 == self.tipsTypeCfg.DonotRemind then
      toggleTipsText = LT.Text("ConfirmationNoLongerPromptsText_1")
    elseif self.tipsTypeCfg.DonotRemind > 1 then
      toggleTipsText = LT.Textf("ConfirmationNoLongerPromptsText_2", self.tipsTypeCfg.DonotRemind)
    end
  end
  self:SetText(self.ui.Text_Screening, toggleTipsText)
  self:SetActive(self.ui.Toggle_Screening, self.tipsTypeCfg and self.tipsTypeCfg.DonotRemind ~= nil)
end

function SummonPriorityNotEnoughView:_OnClickConfirm()
  self.execFuncType = 2
  if self.confirmFunc then
    self.confirmFunc()
  end
  if self.isOn and self.execFuncType then
    UIPopTipsDataUtils.SetTipDontRemind(self.tipsTid, self.execFuncType, TimeUtils.GetServerTime())
  end
  self:Close()
end

function SummonPriorityNotEnoughView:OnToggle(isOn)
  self.isOn = isOn
end

return SummonPriorityNotEnoughView
