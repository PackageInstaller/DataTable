local UINAthListSuitPartTog = class("UINAthListSuitPartTog", UIBaseNode)
local base = UIBaseNode

function UINAthListSuitPartTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnClickToggleRoot)
end

function UINAthListSuitPartTog:InitAthListSuitPartTog(partId, selectPartFunc)
  self.partId = partId
  self.selectPartFunc = selectPartFunc
  if partId == 0 then
    self.ui.tex_Name:SetIndex(1)
  else
    self.ui.tex_Name:SetIndex(0, tostring(partId))
  end
end

function UINAthListSuitPartTog:SetAthListSuitPartTogIsOn()
  self.ui.tog_Root.isOn = true
end

function UINAthListSuitPartTog:_OnClickToggleRoot(isOn)
  if isOn then
    self.ui.tex_Name.text.color = Color.black
    if self.selectPartFunc ~= nil then
      self.selectPartFunc(self.partId)
    end
  else
    self.ui.tex_Name.text.color = self.ui.color_Normal
  end
end

function UINAthListSuitPartTog:OnDelete()
  base.OnDelete(self)
end

return UINAthListSuitPartTog
