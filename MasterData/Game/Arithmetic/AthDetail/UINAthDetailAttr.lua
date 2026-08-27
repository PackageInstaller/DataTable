local UINAthDetailAttr = class("UINAthDetailAttr", UIBaseNode)
local base = UIBaseNode

function UINAthDetailAttr:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__showAttrPopDetail = BindCallback(self, self.__showAttrWin)
  self.ui.button.onPressDown:AddListener(self.__showAttrPopDetail)
  self.__hideAttrPopDetail = BindCallback(self, self.__hideAttrWin)
  self.ui.button.onPressUp:AddListener(self.__hideAttrPopDetail)
end

function UINAthDetailAttr:InjectPressPopFunc(pressDownFunc, pressUpFunc)
  self.__pressDownFunc = pressDownFunc
  self.__pressUpFunc = pressUpFunc
end

function UINAthDetailAttr:__showAttrWin()
  if self.__pressDownFunc ~= nil then
    self.__pressDownFunc(self.attrId, self.iconSprite, self.transform)
  end
end

function UINAthDetailAttr:__hideAttrWin()
  if self.__pressUpFunc ~= nil then
    self.__pressUpFunc()
  end
end

function UINAthDetailAttr:SetAthDetailAttrBtnActive(active)
  self.ui.button.gameObject:SetActive(active)
end

function UINAthDetailAttr:InitAthDetailAttr(attrId, attrValue, color)
  self.attrId = attrId
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.iconSprite = CRH:GetSprite(icon)
  self.ui.img_Icon.sprite = self.iconSprite
  self.ui.tex_AttriNum.text = "+" .. valueStr
  self.ui.tex_Name.text = name
  self.ui.img_Icon.color = color
  self.ui.tex_AttriNum.color = color
  self.ui.tex_Name.color = color
end

function UINAthDetailAttr:OnDelete()
  if self.__showAttrPopDetail ~= nil then
    self.ui.button.onPressDown:RemoveListener(self.__showAttrPopDetail)
  end
  if self.__hideAttrPopDetail ~= nil then
    self.ui.button.onPressUp:RemoveListener(self.__hideAttrPopDetail)
  end
  base.OnDelete(self)
end

return UINAthDetailAttr
