local UINAvgNounTypeTog = class("UINAvgNounTypeTog", UIBaseNode)
local base = UIBaseNode

function UINAvgNounTypeTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_NounType, self, self.OnClickAvgNounTypeTog)
  self:__SetNounTypeSelected(false)
end

function UINAvgNounTypeTog:InitAvgNounTypeTog(cfg, clickCallback, typeId, desId)
  self.noun_des_typeCfg = cfg
  self.clickCallback = clickCallback
  self.typeId = typeId
  self.desId = desId
  self.ui.tex_TypeName.text = LanguageUtil.GetLocaleText(cfg.type_name)
end

function UINAvgNounTypeTog:SetAvgNonTypeTogIsOn(isOn)
  self.ui.tog_NounType.group:SetAllTogglesOff()
  self.ui.tog_NounType.isOn = isOn
end

function UINAvgNounTypeTog:OnClickAvgNounTypeTog(bool)
  self:__SetNounTypeSelected(bool)
  if self.clickCallback ~= nil then
    self.clickCallback(self, bool, self.typeId, self.desId)
  end
end

function UINAvgNounTypeTog:__SetNounTypeSelected(bool)
  if bool then
    local cor = Color.New(1, 1, 1, 1)
    self.ui.img_tog.color = cor
    self.ui.tex_TypeName.color = Color.black
  else
    local cor = Color.New(1, 1, 1, 0)
    self.ui.img_tog.color = cor
    self.ui.tex_TypeName.color = Color.white
  end
end

function UINAvgNounTypeTog:OnDelete()
  base.OnDelete(self)
end

return UINAvgNounTypeTog
