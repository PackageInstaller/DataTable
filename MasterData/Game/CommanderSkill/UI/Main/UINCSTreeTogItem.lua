local UINCSTreeTogItem = class("UINCSTreeTogItem", UIBaseNode)
local base = UIBaseNode

function UINCSTreeTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINCSTreeTogItem:InitCSTreeTogItem(cstData, clickFunc)
  self.cstData = cstData
  self.clickFunc = clickFunc
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cstData:GetCSTName())
  self:SetCSTreeTogItemSelect(false)
  if cstData:IsCmdTreeUnlock() then
    self.ui.img_lock.color = self.ui.col_normal
    self.ui.tex_Name.color = self.ui.col_normal
    self.ui.img_lock.gameObject:SetActive(false)
  else
    self.ui.img_lock.gameObject:SetActive(true)
    self.ui.img_lock.color = self.ui.col_lockImg
    self.ui.tex_Name.color = self.ui.col_lockText
  end
  self.ui.obj_FairyUpgrade:SetActive(cstData:GetCSTFairyReplaceSkill())
end

function UINCSTreeTogItem:GetCSTTogTreeId()
  return self.cstData:GetCSTTreeId()
end

function UINCSTreeTogItem:SetCSTreeTogItemSelect(select)
  self.ui.obj_Select:SetActive(select)
end

function UINCSTreeTogItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.cstData:GetCSTTreeId())
  end
end

function UINCSTreeTogItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTreeTogItem
