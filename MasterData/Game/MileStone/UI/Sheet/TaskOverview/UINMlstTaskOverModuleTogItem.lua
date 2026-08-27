local base = UIBaseNode
local UINMlstTaskOverModuleTogItem = class("UINMlstTaskOverModuleTogItem", base)

function UINMlstTaskOverModuleTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_root, self, self._OnClickTog)
end

function UINMlstTaskOverModuleTogItem:InitMlstTaskOverModuleTogItem(mlstDemitionData, clickFunc, isSelect)
  self._mlstDemitionData = mlstDemitionData
  self._clickFunc = clickFunc
  self.ui.tex_TitleName.text = mlstDemitionData:GetMlstDimensionName()
  self:_UpdSelectUI(isSelect)
  if isSelect then
    self.ui.tog_root.isOn = true
  end
end

function UINMlstTaskOverModuleTogItem:_UpdSelectUI(isOn)
  self.ui.tex_TitleName.color = self.ui.color_name[isOn and 1 or 2]
  self.ui.img_root:SetIndex(isOn and 0 or 1)
end

function UINMlstTaskOverModuleTogItem:_OnClickTog(isOn)
  self:_UpdSelectUI(isOn)
  if isOn and self._clickFunc ~= nil then
    self._clickFunc(self._mlstDemitionData)
  end
end

function UINMlstTaskOverModuleTogItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstTaskOverModuleTogItem
