local UINLevelNormalBuffItem = class("UINLevelNormalBuffItem", UIBaseNode)
local base = UIBaseNode

function UINLevelNormalBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_img_Buff.onPressDown:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn_img_Buff.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
end

function UINLevelNormalBuffItem:InitBuffByCfg(buffCfg, longPressFunc, pressUpFunc)
  self.buffCfg = buffCfg
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.ui.img_Buff.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
end

function UINLevelNormalBuffItem:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.buffCfg)
  end
end

function UINLevelNormalBuffItem:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
end

function UINLevelNormalBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINLevelNormalBuffItem
