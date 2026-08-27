local UINCurrentChipCareerItem = class("UINCurrentChipCareerItem", UIBaseNode)
local base = UIBaseNode

function UINCurrentChipCareerItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCurrentChipCareerItem:InitCareerTag(careerId, count, OnValueChangeFunc)
  self.careerId = careerId
  self.count = count
  self.onValueChangeFunc = OnValueChangeFunc
  self.ui.img_Icon:SetIndex(self.careerId)
  self.ui.tex_Count.text = tostring(count)
  if careerId == 0 then
    self.ui.tex_Name.text = ConfigData:GetTipContent(5003)
  elseif careerId == 6 then
    self.ui.tex_Name.text = ConfigData:GetTipContent(59024)
  else
    local careerCfg = ConfigData.career[self.careerId]
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(careerCfg.name)
  end
  UIUtil.AddValueChangedListener(self.ui.tog_careerItem, self, self.OnValueChange)
end

function UINCurrentChipCareerItem:Select(flag)
  self.ui.tog_careerItem.isOn = flag
end

function UINCurrentChipCareerItem:OnValueChange(flag)
  if self.onValueChangeFunc ~= nil then
    self.onValueChangeFunc(self, flag)
  end
end

function UINCurrentChipCareerItem:SetSelectState()
  self.ui.tex_Name.color = self.ui.tog_careerItem.isOn and self.ui.color_selected_name or self.ui.color_unselect_name
  self.ui.tex_Count.color = self.ui.tog_careerItem.isOn and self.ui.color_selected_texCount or self.ui.color_unselect_texCount
  self.ui.img_count.color = self.ui.tog_careerItem.isOn and self.ui.color_selected_imgCount or self.ui.color_unselect_imgCount
  self.ui.img_careerItem:SetIndex(self.ui.tog_careerItem.isOn and 0 or 1)
end

return UINCurrentChipCareerItem
