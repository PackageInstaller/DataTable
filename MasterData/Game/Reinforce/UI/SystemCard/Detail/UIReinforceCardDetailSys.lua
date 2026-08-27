local base = UIBaseWindow
local UIReinforceCardDetailSys = class("UIReinforceCardDetailSys", base)
local UINRfCardSysBig = require("Game.Reinforce.UI.SystemCard.UINRfCardSysBig")
local UINRfCdSysLvInfo = require("Game.Reinforce.UI.SystemCard.LvUp.UINRfCdSysLvInfo")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UIReinforceCardDetailSys:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.SetTopStatusBtnShow(false, false)
  UIUtil.AddButtonListener(self.ui.bg, self, self._OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self._OnClickCheck)
  self._card = UINRfCardSysBig.New()
  self._card:Init(self.ui.uINReinforceCardBig)
  self._resloader = CS.ResLoader.Create()
  self._lvInfo = UINRfCdSysLvInfo.New()
  self._lvInfo:Init(self.ui.lvInfo)
  self._OnSysCanrdChangeFunc = BindCallback(self, self._OnSysCanrdChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCanrdChangeFunc)
  ReinforceUtil.RfCdShowTween(self.ui.canvasGroup)
end

function UIReinforceCardDetailSys:InitReinforceCardDetailSys(rfCardData)
  self._rfCardData = rfCardData
  self._card:InitRfCardSysBig(rfCardData, self._resloader)
  self._lvInfo:SetRfCdRfCdSysLvInfoCardTransfrom(self._card.transform)
  self:_UpdState()
end

function UIReinforceCardDetailSys:InitReinforceCardDetailSysForHandBook(rfCardData)
  self._rfCardData = rfCardData
  self._card:InitRfCardSysBig(rfCardData, self._resloader)
  self.ui.obj_group:SetActive(false)
end

function UIReinforceCardDetailSys:_UpdState()
  self._lvInfo:InitRfCdSysLvInfo(self._rfCardData:GetRfCardStarCfg(), self._rfCardData)
  self.ui.tex_Check:SetIndex((self._rfCardData:IsRfCardStarMax() or self._rfCardData:GetRfCardSysNum() == nil) and 1 or 0)
end

function UIReinforceCardDetailSys:_OnSysCanrdChange()
  self:_UpdState()
  self._card:InitRfCdRoomSys()
end

function UIReinforceCardDetailSys:_OnClickCheck()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardLvUp, function(win)
    if win == nil then
      return
    end
    self:Hide()
    win:InitReinforceCardSysLvUp(self._rfCardData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.UIReinforceCardDetailSys)
    end)
  end)
end

function UIReinforceCardDetailSys:SetBkClose()
  self.ui.background:SetActive(false)
end

function UIReinforceCardDetailSys:_OnClickRoot()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReinforceCardDetailSys:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCanrdChangeFunc)
  self._card:Delete()
  self._lvInfo:Delete()
  self._resloader:Put2Pool()
  self._resloader = nil
  base.OnDelete(self)
end

return UIReinforceCardDetailSys
