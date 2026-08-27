local UINAthDcmpFilterItem = class("UINAthDcmpFilterItem", UIBaseNode)
local base = UIBaseNode
local AthDcmpFilterUtil = require("Game.Arithmetic.Decompose.Filter.AthDcmpFilterUtil")
local GetFilterNameFuncDic = {
  [AthDcmpFilterUtil.FilterType.Area] = function(self, filterValue)
    local areaCfg = ConfigData.ath_area[filterValue]
    if areaCfg == nil then
      error("Cant get ConfigData.ath_area, id = " .. tostring(filterValue))
      return
    end
    self.ui.tex_ItemName:SetIndex(0, LanguageUtil.GetLocaleText(areaCfg.name2))
  end,
  [AthDcmpFilterUtil.FilterType.Quality] = function(self, filterValue)
    local idx = filterValue - 3
    self.ui.tex_ItemName:SetIndex(idx)
  end,
  [AthDcmpFilterUtil.FilterType.Size] = function(self, filterValue)
    local idx = filterValue - 1
    self.ui.tex_ItemName:SetIndex(idx)
  end,
  [AthDcmpFilterUtil.FilterType.Suit] = function(self, filterValue)
    if filterValue == 0 then
      self.ui.tex_ItemName:SetIndex(1)
      return
    end
    local suitCfg = ConfigData.ath_suit.suitParamDic[filterValue]
    if suitCfg == nil then
      error("Cant get ConfigData.ath_suit.suitParamDic, id = " .. tostring(filterValue))
    end
    self.ui.tex_ItemName:SetIndex(0, LanguageUtil.GetLocaleText(suitCfg.name))
  end,
  [AthDcmpFilterUtil.FilterType.MainAttri] = function(self, filterValue)
    local attrCfg = ConfigData.attribute[filterValue]
    local isPercent = attrCfg.num_type == 2
    local showAttrId = filterValue
    if attrCfg.merge_attribute ~= 0 then
      showAttrId = attrCfg.merge_attribute
    end
    local name = ConfigData:GetAttribute(showAttrId)
    if isPercent then
      name = name .. "%"
    end
    self.ui.tex_ItemName:SetIndex(0, name)
  end
}

function UINAthDcmpFilterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnChangeValue)
end

function UINAthDcmpFilterItem:InitAthDcmpFilterItem(filterType, filterValue, changeValueFunc, isOn)
  self.filterType = filterType
  self.filterValue = filterValue
  self.changeValueFunc = changeValueFunc
  self:SetAthDcmpFilterItemIsOn(isOn, true)
  self:_UpdName()
end

function UINAthDcmpFilterItem:_UpdName()
  local getFilterNameFunc = GetFilterNameFuncDic[self.filterType]
  if getFilterNameFunc == nil then
    error("Unsupported filterType : " .. tostring(self.filterType))
    return
  end
  getFilterNameFunc(self, self.filterValue)
end

function UINAthDcmpFilterItem:SetAthDcmpFilterItemIsOn(isOn, isReset)
  self.isReset = isReset
  self.ui.tog_Root.isOn = isOn
  self.isReset = false
end

function UINAthDcmpFilterItem:_OnChangeValue(isOn)
  self.ui.img_Select:SetIndex(isOn and 1 or 0)
  if self.isReset then
    return
  end
  if self.changeValueFunc ~= nil then
    self.changeValueFunc(self.filterType, self.filterValue, isOn)
  end
end

function UINAthDcmpFilterItem:OnDelete()
  base.OnDelete(self)
end

return UINAthDcmpFilterItem
