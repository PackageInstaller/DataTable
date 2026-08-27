local UINAthListAreaTog = class("UINAthListAreaTog", UIBaseNode)
local base = UIBaseNode

function UINAthListAreaTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnClickToggleRoot)
end

function UINAthListAreaTog:InitAthListAreaTog(areaId, selectAreaFunc)
  self.areaId = areaId
  self.selectAreaFunc = selectAreaFunc
  self.ui.img_Icon:SetIndex(areaId)
  if areaId == 0 then
    self.ui.tex_Name:SetIndex(0)
  else
    local areaCfg = ConfigData.ath_area[areaId]
    if areaCfg == nil then
      error("Can't find ath areaCfg, areaId = " .. tostring(areaId))
      return
    end
    self.ui.tex_Name.text.text = LanguageUtil.GetLocaleText(areaCfg.name2)
  end
end

function UINAthListAreaTog:SetAthListAreaTogIsOn()
  self.ui.tog_Root.isOn = true
end

function UINAthListAreaTog:_OnClickToggleRoot(isOn)
  if isOn then
    self.ui.img_Icon.image.color = Color.black
    self.ui.tex_Name.text.color = Color.black
    if self.selectAreaFunc ~= nil then
      self.selectAreaFunc(self.areaId)
    end
  else
    self.ui.img_Icon.image.color = self.ui.color_Normal
    self.ui.tex_Name.text.color = self.ui.color_Normal
  end
end

function UINAthListAreaTog:OnDelete()
  base.OnDelete(self)
end

return UINAthListAreaTog
