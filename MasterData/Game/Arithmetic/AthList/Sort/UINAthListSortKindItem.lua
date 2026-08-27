local UINAthListSortKindItem = class("UINAthListSortKindItem", UIBaseNode)
local base = UIBaseNode
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")

function UINAthListSortKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnClickToggleRoot)
end

function UINAthListSortKindItem:InitAthListSortKindItem(kindType, kindValue, selectFunc)
  self.kindType = kindType
  self.kindValue = kindValue
  self.selectFunc = selectFunc
  if kindType == AthSortEnum.eKindType.GetOrder then
    self.ui.tex_KindName:SetIndex(0)
  elseif kindType == AthSortEnum.eKindType.Quality then
    self.ui.tex_KindName:SetIndex(1)
  elseif kindType == AthSortEnum.eKindType.SignHero then
    self.ui.tex_KindName:SetIndex(2)
  elseif kindType == AthSortEnum.eKindType.Attribute then
    local attrId = ConfigData.game_config.athSortAttrList[kindValue]
    local name = ConfigData:GetAttribute(attrId, 0)
    self.ui.tex_KindName.text.text = name
  else
    error("Unsupported AthSortEnum.eKindType , id:" .. tostring(kindType))
  end
end

function UINAthListSortKindItem:SetAthListSortKindItemTogOn()
  self.ui.tog_Root.group:SetAllTogglesOff()
  self.ui.tog_Root.isOn = true
end

function UINAthListSortKindItem:_OnClickToggleRoot(isOn)
  if isOn then
    self.ui.tex_KindName.text.color = Color.black
    if self.selectFunc ~= nil then
      self.selectFunc(self.kindType, self.kindValue, self.ui.tex_KindName.text.text)
    end
  else
    self.ui.tex_KindName.text.color = Color.white
  end
end

function UINAthListSortKindItem:OnDelete()
  base.OnDelete(self)
end

return UINAthListSortKindItem
