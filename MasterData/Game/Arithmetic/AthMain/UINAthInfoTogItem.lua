local UINAthInfoTogItem = class("UINAthInfoTogItem", UIBaseNode)
local base = UIBaseNode

function UINAthInfoTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnTogValuieChange)
end

function UINAthInfoTogItem:InitAthInfoTogItem(index, selectTogFunc)
  self.index = index
  self.selectTogFunc = selectTogFunc
end

function UINAthInfoTogItem:SetAthInfoTogOn()
  self.ui.tog_Root.group:SetAllTogglesOff()
  self.ui.tog_Root.isOn = true
end

function UINAthInfoTogItem:_OnTogValuieChange(isOn)
  if isOn then
    if self.selectTogFunc ~= nil then
      self.selectTogFunc(self.index)
    end
    self.ui.text.color = Color.black
  else
    self.ui.text.color = self.ui.color_Normal
  end
end

function UINAthInfoTogItem:OnDelete()
  base.OnDelete(self)
end

return UINAthInfoTogItem
