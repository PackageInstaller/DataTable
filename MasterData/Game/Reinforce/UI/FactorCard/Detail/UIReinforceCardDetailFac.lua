local base = UIBaseWindow
local UIReinforceCardDetailFac = class("UIReinforceCardDetailFac", base)
local UINRfCardFacBig = require("Game.Reinforce.UI.FactorCard.UINRfCardFacBig")
local UINReinforceCardDetails = require("Game.Reinforce.UI.FactorCard.Detail.UINReinforceCardDetails")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UIReinforceCardDetailFac:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.SetTopStatusBtnShow(false, false)
  UIUtil.AddButtonListener(self.ui.bg, self, self._OnClickRoot)
  self._card = UINRfCardFacBig.New()
  self._card:Init(self.ui.uINReinforceCardBig)
  self._card:SetRfCardFacBigDetailFunc(BindCallback(self, self._ShowDetail))
  self._card:HideRfCardFacBigDetailBtn()
  self._card:SetRfCdFacSwitchNotTween()
  self._detailNode = UINReinforceCardDetails.New()
  self._detailNode:Init(self.ui.uINReinforceCardDetails)
  self._resloader = CS.ResLoader.Create()
  ReinforceUtil.RfCdShowTween(self.ui.canvasGroup)
end

function UIReinforceCardDetailFac:InitRfCardDetailFac(rfCardData, isFmt, hideSwitch)
  self._card:InitRfCardFacBig(rfCardData, self._resloader, isFmt, hideSwitch)
  self._detailNode:InitReinforceCardDetails(rfCardData, isFmt)
  self._detailNode:SetRfCdDetailsCardTransfrom(self._card.transform)
end

function UIReinforceCardDetailFac:_ShowDetail(rfCardData, isFmt, isUpd)
  if isUpd and self._detailNode.active == false then
    return
  end
  ReinforceUtil.SwitchRfCardTween(self.ui.canvasGroup, function()
    self._card:InitRfCardFacBig(rfCardData, self._resloader, isFmt)
    self._detailNode:InitReinforceCardDetails(rfCardData, isFmt, isUpd)
    self._detailNode:SetRfCdDetailsCardTransfrom(self._card.transform)
  end)
end

function UIReinforceCardDetailFac:_OnClickRoot()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReinforceCardDetailFac:SetBkClose()
  self.ui.bg.gameObject:SetActive(false)
end

function UIReinforceCardDetailFac:OnDelete()
  self._card:Delete()
  self._detailNode:Delete()
  self._resloader:Put2Pool()
  self._resloader = nil
  base.OnDelete(self)
end

return UIReinforceCardDetailFac
