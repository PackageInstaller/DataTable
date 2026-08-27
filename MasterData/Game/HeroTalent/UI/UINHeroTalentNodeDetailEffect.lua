local UINHeroTalentNodeDetailEffect = class("UINHeroTalentNodeDetailEffect", UIBaseNode)
local base = UIBaseNode

function UINHeroTalentNodeDetailEffect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._defaultColor = self.ui.tex_Att.color
end

function UINHeroTalentNodeDetailEffect:RefreshDetailEffectByAttriId(attributeId, curVal, nextVal, showAddSign, showColor)
  local name, curValStr, icon = ConfigData:GetAttribute(attributeId, curVal)
  local _, nextValStr, _ = ConfigData:GetAttribute(attributeId, nextVal)
  self.ui.img_Icon.gameObject:SetActive(true)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_Att.text = LanguageUtil.GetLocaleText(name)
  if nextValStr ~= nil then
    if showAddSign then
      curValStr = "+" .. curValStr
      nextValStr = "+" .. nextValStr
    end
    self.ui.tex_Addition:SetIndex(0, curValStr, nextValStr)
  else
    if showAddSign then
      curValStr = "+" .. curValStr
    end
    self.ui.tex_Addition:SetIndex(1, curValStr)
  end
  if showColor ~= nil then
    self.ui.tex_Att.color = showColor
  else
    self.ui.tex_Att.color = self._defaultColor
  end
end

function UINHeroTalentNodeDetailEffect:RefreshDetailEffect(textDes, curValDes, nextValDes, iconName)
  if iconName == nil then
    self.ui.img_Icon.gameObject:SetActive(false)
  else
    self.ui.img_Icon.gameObject:SetActive(true)
    self.ui.img_Icon.sprite = CRH:GetSprite(iconName)
  end
  self.ui.tex_Att.text = textDes
  if string.IsNullOrEmpty(nextValDes) then
    self.ui.tex_Addition:SetIndex(1, curValDes)
  else
    self.ui.tex_Addition:SetIndex(0, curValDes, nextValDes)
  end
  self.ui.tex_Att.color = self._defaultColor
end

return UINHeroTalentNodeDetailEffect
