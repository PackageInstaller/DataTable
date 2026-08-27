local UINAthOptAffixItem = class("UINAthOptAffixItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")

function UINAthOptAffixItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.rootToggle, self, self.OnSelectAthOptItem)
end

function UINAthOptAffixItem:InitAthOptAffixItem(index, affixElem, selectEvent, checkOptEnableEvent)
  self:SetAthAffixEnableSelect(true)
  self:SetAthAffixSelected(false)
  self.index = index
  self.selectEvent = selectEvent
  self.checkOptEnableEvent = checkOptEnableEvent
  self:RefreshAffix(affixElem)
end

function UINAthOptAffixItem:SetAthAffixEnableSelect(enableSelect)
  self.enableSelect = enableSelect
  self.ui.rootToggle.interactable = enableSelect
end

function UINAthOptAffixItem:SetAthAffixSelected(selected)
  self.ui.rootToggle.isOn = selected
end

function UINAthOptAffixItem:OnSelectAthOptItem(isOn)
  if not self.enableSelect then
    return
  end
  if self.selectEvent ~= nil then
    self.selectEvent(self.index, isOn)
  end
end

function UINAthOptAffixItem:RefreshAffix(affixElem)
  self.affixElem = affixElem
  local affixcfg = ConfigData.ath_affix_pool[affixElem.id]
  if affixcfg == nil then
    error("Cant't find ath_affix_pool, id = " .. tostring(affixElem.id))
    return
  end
  self.affixcfg = affixcfg
  local affixLevelCfg = ConfigData.ath_affix_lv[affixElem.level]
  if affixLevelCfg == nil then
    error("Cant get affixLevelCfg, level = " .. tostring(affixElem.level))
    return
  end
  self.affixLevelCfg = affixLevelCfg
  local name, valueStr, icon = ConfigData:GetAttribute(self.affixcfg.affix_para, affixElem.value)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.img_Icon.color = ArthmeticEnum.AthQualityColor[self.affixElem.quality]
  self.ui.tex_Level:SetIndex(0, tostring(affixElem.level))
  local attrId = self.affixcfg.affix_para
  local attrName, attrValue = ConfigData:GetAttribute(attrId, affixElem.value)
  self.ui.tex_Num:SetIndex(0, attrName, attrValue)
  self.ui.tex_Num.text.color = ArthmeticEnum.AthQualityColor[self.affixElem.quality]
  self.ui.tex_curProcess.gameObject:SetActive(true)
  self.ui.bar:SetActive(true)
  local fillAmount
  if self.affixElem.level >= ConfigData.ath_affix_lv.maxAffixLevel then
    self.ui.tex_curProcess:SetIndex(1)
    self:SetAthAffixEnableSelect(false)
    fillAmount = 1
  else
    local expMax = self.affixLevelCfg.exp
    local curExp = self.affixElem.exp
    fillAmount = curExp / expMax
    self.ui.tex_curProcess:SetIndex(0, tostring(curExp), tostring(expMax))
  end
  self.ui.img_Befor.fillAmount = fillAmount
  self.ui.img_After.fillAmount = fillAmount
end

function UINAthOptAffixItem:OptAffixChange(affixElem)
  self:RefreshAffix(affixElem)
  if self.affixElem.level >= ConfigData.ath_affix_lv.maxAffixLevel and self.checkOptEnableEvent ~= nil then
    self.checkOptEnableEvent()
  end
end

function UINAthOptAffixItem:OptimizeEnable()
  return self.enableSelect
end

function UINAthOptAffixItem:OnDelete()
  base.OnDelete(self)
end

return UINAthOptAffixItem
