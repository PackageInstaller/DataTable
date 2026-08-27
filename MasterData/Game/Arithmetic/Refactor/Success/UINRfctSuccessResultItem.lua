local base = UIBaseNode
local UINRfctSuccessResultItem = class("UINRfctSuccessResultItem", base)
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")

function UINRfctSuccessResultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_root, self, self._OnClickTog)
  self._attrItemPool = UIItemPool.New(UINAthDetailAttr, self.ui.attriItem, false)
end

function UINRfctSuccessResultItem:InitRfctSuccessResultItem(idx, affixList, selectFunc, isSelected)
  self._idx = idx
  self._selectFunc = selectFunc
  if isSelected then
    self.ui.tog_root.group:SetAllTogglesOff(false)
    self.ui.tog_root.isOn = true
  end
  self._attrItemPool:HideAll()
  for k, affix in ipairs(affixList) do
    local cfg = ConfigData.ath_affix_pool[affix.id]
    if cfg == nil then
      error("Can't find ath_affix_pool, id = " .. tostring(affix.id))
    else
      local color = ArthmeticEnum.AthQualityColor[affix.quality]
      local attrItem = self._attrItemPool:GetOne()
      attrItem:InitAthDetailAttr(cfg.affix_para, affix.value, color)
      attrItem:SetAthDetailAttrBtnActive(false)
    end
  end
end

function UINRfctSuccessResultItem:_OnClickTog(isOn)
  if not isOn then
    return
  end
  self.ui.obj_Selected:SetParent(self.transform)
  self.ui.obj_Selected.anchoredPosition = Vector2.zero
  if self._selectFunc ~= nil then
    self._selectFunc(self._idx)
  end
end

function UINRfctSuccessResultItem:OnDelete()
  self._attrItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINRfctSuccessResultItem
