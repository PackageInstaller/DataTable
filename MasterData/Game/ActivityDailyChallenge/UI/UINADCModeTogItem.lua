local UINADCModeTogItem = class("UINADCModeTogItem", UIBaseNode)
local base = UIBaseNode

function UINADCModeTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Mode, self, self.OnToggleValueChanged)
end

function UINADCModeTogItem:InitADCModeTogItem(isNormal, clickFunc)
  self.isNormal = isNormal
  self.clickFunc = clickFunc
  self.__isOn = false
  self:RefreshModeTogShow()
  self.ui.blueDotObject:SetActive(false)
end

function UINADCModeTogItem:UpdateBlueDotUI(bValue)
  if self.isNormal then
    bValue = false
    return
  end
  if self.ui.blueDotObject.activeSelf ~= bValue then
    self.ui.blueDotObject:SetActive(bValue)
  end
end

function UINADCModeTogItem:OnToggleValueChanged(isOn)
  self.__isOn = isOn
  if self.clickFunc and isOn then
    self.clickFunc(self.isNormal)
  end
  self:RefreshModeTogShow()
end

function UINADCModeTogItem:SetToggleOpen()
  self.ui.tog_Mode.isOn = true
end

function UINADCModeTogItem:RefreshModeTogShow()
  if self.isNormal then
    self.ui.img_icon:SetIndex(0)
    self.ui.tex_info:SetIndex(0)
    if self.__isOn then
      self.ui.tex_info.text.color = self.ui.col_fontClick
      self.ui.img_bk.color = self.ui.col_normalClick
      self.ui.img_iconCo.color = self.ui.col_iconClick
    else
      self.ui.tex_info.text.color = self.ui.col_fontNormal
      self.ui.img_bk.color = self.ui.col_normal
      self.ui.img_iconCo.color = self.ui.col_iconNormal
    end
  else
    self.ui.img_icon:SetIndex(1)
    self.ui.tex_info:SetIndex(1)
    if self.__isOn then
      self.ui.tex_info.text.color = self.ui.col_fontClick
      self.ui.img_bk.color = self.ui.col_hardClick
      self.ui.img_iconCo.color = self.ui.col_iconClick
    else
      self.ui.tex_info.text.color = self.ui.col_fontNormal
      self.ui.img_bk.color = self.ui.col_normal
      self.ui.img_iconCo.color = self.ui.col_iconNormal
    end
  end
end

function UINADCModeTogItem:OnDelete()
  base.OnDelete(self)
end

return UINADCModeTogItem
