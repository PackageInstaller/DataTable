local UINLevelInfgoTypeTog = class("UINLevelInfgoTypeTog", UIBaseNode)
local base = UIBaseNode

function UINLevelInfgoTypeTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Type, self, self.OnValueChage)
end

function UINLevelInfgoTypeTog:InitTog(infoNodeTypeId, isLast, openNodeCallback)
  self.infoNodeTypeId = infoNodeTypeId
  self.ui.texInfo_Name:SetIndex(infoNodeTypeId)
  self.ui.obj_img_Line:SetActive(not isLast)
  self.openNodeCallback = openNodeCallback
end

function UINLevelInfgoTypeTog:OnValueChage(bool)
  if bool then
    self.ui.img_tog_Type.color = self.ui.color_white
    self.ui.tex_Name.color = self.ui.color_black
    if self.openNodeCallback ~= nil then
      self.openNodeCallback()
    end
  else
    self.ui.img_tog_Type.color = self.ui.color_black
    self.ui.tex_Name.color = self.ui.color_white
  end
  if self.ui.Img_ToggleBg ~= nil then
    self.ui.Img_ToggleBg:SetActive(bool)
  end
  if self.colorCallback ~= nil then
    self.colorCallback(self.ui.img_tog_Type.color)
  end
end

function UINLevelInfgoTypeTog:OnDelete()
  base.OnDelete(self)
end

return UINLevelInfgoTypeTog
