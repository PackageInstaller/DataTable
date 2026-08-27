local UINAthDcmpFilterDynamicTitleGroup = class("UINAthDcmpFilterDynamicTitleGroup", UIBaseNode)
local base = UIBaseNode

function UINAthDcmpFilterDynamicTitleGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthDcmpFilterDynamicTitleGroup:InitAthDcmpFilterDynamicTitleGroup(scrollData, isSelectBasic)
  local tileIdx = scrollData.tileIdx
  self.ui.tex_GroupName:SetIndex(tileIdx)
  local showExtraText = not isSelectBasic or scrollData.isEmpty
  self.ui.tex_Empty.gameObject:SetActive(showExtraText)
  if not isSelectBasic then
    self.ui.tex_Empty:SetIndex(0)
  elseif scrollData.isEmpty then
    self.ui.tex_Empty:SetIndex(1)
  end
  local sizeDelta = self.transform.sizeDelta
  sizeDelta.y = showExtraText and self.ui.noneHeight or self.ui.normalHeight
  self.transform.sizeDelta = sizeDelta
end

function UINAthDcmpFilterDynamicTitleGroup:OnDelete()
  base.OnDelete(self)
end

return UINAthDcmpFilterDynamicTitleGroup
