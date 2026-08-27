local base = UIBaseNode
local UINWarChessViewChipsGroupItem = class("UINWarChessViewChipsGroupItem", base)

function UINWarChessViewChipsGroupItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessViewChipsGroupItem:InitWCViewChipGroup(teamData, chipItemPool, onClickFunc, isSelected)
  self.ui.tex_GroupTitle.text = teamData:GetWCTeamName()
  local chipList = teamData:GetWCTeamChipList()
  for _, chipData in ipairs(chipList) do
    local chipItem = chipItemPool:GetOne()
    chipItem:InitWCViewChipChipItem(chipData, onClickFunc)
    chipItem.transform:SetParent(self.transform)
    if not isSelected.isSelected then
      chipItem:__OnClickItem()
      isSelected.isSelected = true
    end
  end
end

function UINWarChessViewChipsGroupItem:OnDelete()
end

return UINWarChessViewChipsGroupItem
