local UINDmFntCategoryTog = class("UINDmFntCategoryTog", UIBaseNode)
local base = UIBaseNode
local DormEnum = require("Game.Dorm.DormEnum")

function UINDmFntCategoryTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.rootTog, self, self._OnClickTogRoot)
end

function UINDmFntCategoryTog:InitDmFntCategoryTog(fntCatgCfg, sprite, selectFunc)
  self.fntCatgCfg = fntCatgCfg
  self.selectFunc = selectFunc
  self.ui.img_Icon.sprite = sprite
  self.ui.tex_typeName.text = LanguageUtil.GetLocaleText(fntCatgCfg.name)
end

function UINDmFntCategoryTog:SetDmFntCategoryTogOn(isOn)
  self.ui.rootTog.isOn = isOn
end

function UINDmFntCategoryTog:_OnClickTogRoot(isOn)
  local col = isOn and Color.black or Color.gray
  if isOn then
    self.ui.img_SelFurnType.transform:SetParent(self.transform)
    self.ui.img_SelFurnType.transform.anchoredPosition = Vector2.zero
    self.ui.img_SelFurnType.transform:SetAsFirstSibling()
    local isTheme = self.fntCatgCfg.id == DormEnum.ThemeCatId
    self.ui.img_SelFurnType:SetIndex(isTheme and 1 or 0)
    if isTheme then
      col = Color.white
    end
    if self.selectFunc ~= nil then
      self.selectFunc(self.fntCatgCfg.id)
    end
  end
  self.ui.tex_typeName.color = col
  self.ui.img_Icon.color = col
end

function UINDmFntCategoryTog:OnDelete()
  base.OnDelete(self)
end

return UINDmFntCategoryTog
