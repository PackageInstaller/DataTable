local base = UIBaseNode
local UINRfCardSetSelectItemBase = class("UINRfCardSetSelectItemBase", base)

function UINRfCardSetSelectItemBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Details, self, self.OnClickDetails)
  UIUtil.AddButtonListener(self.ui.btn_Set, self, self.OnClickBtnSet)
  UIUtil.AddButtonListener(self.ui.btn_Remove, self, self.OnClickRemove)
  self.onClickRootCallback = BindCallback(self, self.OnClickRoot)
end

function UINRfCardSetSelectItemBase:InitRfCardSetSelectItemBase(cardData, resloader, isSelect, parWin, selectIndex)
  self.cardData = cardData
  self.parWin = parWin
  self.resloader = resloader
  self.isCheck = false
  self.isEquip = false
  self.equipId = 0
  if isSelect then
    self:SetCardCallback(selectIndex)
  end
  self:RefreshSelectItem()
end

function UINRfCardSetSelectItemBase:OnClickDetails()
  if self.isCheck then
    return
  end
  self.isCheck = true
  self:RefreshSelectItem()
end

function UINRfCardSetSelectItemBase:CloseCheck()
  if not self.isCheck then
    return
  end
  self.isCheck = false
  self:RefreshSelectItem()
end

function UINRfCardSetSelectItemBase:OnClickBtnSet()
  self.parWin:SetCardEquip(self.cardData, self)
end

function UINRfCardSetSelectItemBase:SetCardCallback(index)
  self.isEquip = true
  self.equipId = index
  self:RefreshSelectItem()
end

function UINRfCardSetSelectItemBase:OnClickRemove()
  self.parWin:RemoveCardEquip(self.cardData, self)
end

function UINRfCardSetSelectItemBase:RemoveCardCallback()
  self.isEquip = false
  self.equipId = 0
  self:RefreshSelectItem()
end

function UINRfCardSetSelectItemBase:OnClickSift()
  self.ui.sortDropDownList:SetActive(not self.ui.sortDropDownList.activeSelf)
end

function UINRfCardSetSelectItemBase:RefreshSelectItem()
  self.ui.btn_Set.gameObject:SetActive(not self.isEquip)
  self.ui.btn_Remove.gameObject:SetActive(self.isEquip)
  if not self.isEquip then
    self.ui.obj_Select:SetActive(false)
    self.ui.obj_Check:SetActive(self.isCheck)
    return
  end
  self.ui.obj_Select:SetActive(true)
  self.ui.obj_Check:SetActive(false)
  self.ui.img_select:SetIndex(self.isCheck and 1 or 0)
  self.ui.tex_select:SetIndex(self.isCheck and 1 or 0)
  self.ui.tex_Order.text = string.format("%02d", self.equipId)
end

function UINRfCardSetSelectItemBase:OnClickRoot()
  if not self.isEquip then
    self:OnClickBtnSet()
    return
  end
  if self.isEquip then
    self:OnClickRemove()
    return
  end
end

function UINRfCardSetSelectItemBase:PlaySelectItemTween(delay, constTime)
  self.ui.item_group.alpha = 1
  self.ui.item_group:DOFade(0, constTime):From():SetDelay(delay):SetLink(self.ui.item_group.gameObject)
end

function UINRfCardSetSelectItemBase:OnDelete()
end

return UINRfCardSetSelectItemBase
