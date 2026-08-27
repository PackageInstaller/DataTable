local base = UIBaseNode
local UINRfCdSaveSCardItem = class("UINRfCdSaveSCardItem", base)
local UINRfCardFacSmall = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSmall")

function UINRfCdSaveSCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Switch, self, self._OnClickSwitch)
  UIUtil.AddButtonListener(self.ui.btn_Details, self, self._OnClickDetail)
  self._smallCard = UINRfCardFacSmall.New()
  self._smallCard:Init(self.ui.uINRfCardFacSmall)
  self._smallCard:SetRfCardFacSmallClickFunc(BindCallback(self, self._OnClickCard))
end

function UINRfCdSaveSCardItem:InitRfCdSaveSCardItem(facCardData, resloader, clickFunc, detailFunc)
  self._facCardData = facCardData
  self._resloader = resloader
  self._clickFunc = clickFunc
  self._detailFunc = detailFunc
  self:_UpdCard(false)
end

function UINRfCdSaveSCardItem:_UpdCard(isFmt)
  self._isFmt = isFmt
  self._smallCard:InitRfCardFacSmall(self._facCardData, self._resloader, self._isFmt)
  self.ui.tex_Switch:SetIndex(self._isFmt and 0 or 1)
end

function UINRfCdSaveSCardItem:SetRfCdIsSupport(isSpt)
  self.ui.obj_FriendSup:SetActive(isSpt)
end

function UINRfCdSaveSCardItem:_OnClickCard()
  local idx = self._facCardData:GetRfCdFactorOrder()
  if self._clickFunc then
    self._clickFunc(idx, self.transform)
  end
end

function UINRfCdSaveSCardItem:_OnClickSwitch()
  self:_UpdCard(not self._isFmt)
end

function UINRfCdSaveSCardItem:_OnClickDetail()
  if self._detailFunc then
    self._detailFunc(self, self._facCardData, self._isFmt)
  end
end

function UINRfCdSaveSCardItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdSaveSCardItem
