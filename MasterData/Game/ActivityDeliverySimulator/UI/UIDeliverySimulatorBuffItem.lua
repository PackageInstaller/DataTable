local base = UIBaseNode
local UIDeliverySimulatorBuffItem = class("UIDeliverySimulatorBuffItem", base)

function UIDeliverySimulatorBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDeliverySimulatorBuffItem:InitDeliverySimulatorBuffItem(buff, atlas, buffColorList)
  self.buff = buff
  self.atlas = atlas
  self.buffColorList = buffColorList
  self:Refresh(buff)
end

function UIDeliverySimulatorBuffItem:Refresh(buff)
  self:UpdateBuffProgress()
  self:UpdateBuffIcon(buff.buffCfg.icon, buff.buffCfg.buff_type)
  self:UpdateBuffName(buff:GetName())
end

function UIDeliverySimulatorBuffItem:UpdateBuffProgress()
  local value = self.buff:GetRemainingTimeProgress()
  self.ui.img_Fill.fillAmount = value
end

function UIDeliverySimulatorBuffItem:UpdateBuffIcon(iconName, colorIndex)
  local sprite = AtlasUtil.GetResldSprite(self.atlas, iconName)
  self.ui.img_Icon.sprite = sprite
  self.ui.img_Fill.color = self.buffColorList[colorIndex]
end

function UIDeliverySimulatorBuffItem:UpdateBuffName(name)
  self.ui.tex_BuffDes.text = name
end

function UIDeliverySimulatorBuffItem:OnDelete()
  base.OnDelete(self)
  self.buff = nil
  self.atlas = nil
  self.buffColorList = nil
end

return UIDeliverySimulatorBuffItem
