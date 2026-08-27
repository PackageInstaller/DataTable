local base = UIBaseNode
local UINRfCardFacSupport = class("UINRfCardFacSupport", base)
local UINRfCardFacBig = require("Game.Reinforce.UI.FactorCard.UINRfCardFacBig")

function UINRfCardFacSupport:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.cardFacBigItem = UINRfCardFacBig.New()
  self.cardFacBigItem:Init(self.ui.UINRfCardFacBig)
  UIUtil.AddButtonListener(self.ui.btn_Sup, self, self.OnClickSelect)
  self.cardFacBigItem:SetRfCardFacBigDetailFunc(BindCallback(self, self._ShowDetail))
end

function UINRfCardFacSupport:InitNRfCardFacSupport(rfCardData, resLoader, btnColor, isSelectedFunc, selectCallback, isSelectMode)
  self.btnColor = btnColor
  self._rfCardData = rfCardData
  self.isSelectedFunc = isSelectedFunc
  self.selectCallback = selectCallback
  self.isSelectMode = isSelectMode
  self.cardFacBigItem:InitRfCardFacBig(rfCardData, resLoader, false)
  self:RefreshSelectState()
end

function UINRfCardFacSupport:RefreshSelectState()
  local isSelect = self.isSelectedFunc(self._rfCardData)
  self.ui.img_Selected.gameObject:SetActive(isSelect)
  self.ui.img_Sup.color = isSelect and self.btnColor.selectBtnColor or self.btnColor.unSelectBtnColor
  if self.isSelectMode then
    self.ui.tex_Sup:SetIndex(isSelect and 2 or 3)
  else
    self.ui.tex_Sup:SetIndex(isSelect and 0 or 1)
  end
end

function UINRfCardFacSupport:OnClickSelect()
  local isSelect = self.isSelectedFunc(self._rfCardData)
  self.selectCallback(self._rfCardData, not isSelect)
end

function UINRfCardFacSupport:_ShowDetail(rfCardData, isFmt, isUpd)
  if isUpd then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(rfCardData, isFmt)
  end)
end

function UINRfCardFacSupport:OnDelete()
  base.OnDelete(self)
end

return UINRfCardFacSupport
