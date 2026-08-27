local UINWarChessTeamNodeItem = class("UINWarChessTeamNodeItem", UIBaseNode)
local base = UIBaseNode
local UINWarChessStoreChipItem = require("Game.WarChess.UI.Store.UINWarChessStoreChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINWarChessTeamNodeItem:OnInit()
  base.OnInit(self, self.transform, self.ui)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipItemPool = UIItemPool.New(UINWarChessStoreChipItem, self.ui.storeChipItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
end

function UINWarChessTeamNodeItem:InitTeamNodeItem(chipDataList, teamData, moneyIconId, clickedAction)
  if 20 < #chipDataList then
    error("The num(chip + buff) greater than 20.")
    return
  end
  if teamData == nil then
    return
  end
  self.teamData = teamData
  self.ui.tex_GroupTitle.text = tostring(teamData:GetWCTeamName())
  self._clickedAction = clickedAction
  self.chipitemList = {}
  self.chipItemPool:HideAll()
  local buyPrice
  for k, chipData in ipairs(chipDataList) do
    if chipData ~= nil then
      local chipItem = self.chipItemPool:GetOne()
      chipItem.transform:SetParent(self.ui.groupItem_Chip.transform)
      chipItem.transform:SetAsLastSibling()
      chipItem:InitWCStoreChipItem(chipData, moneyIconId, self._OnClickChipItemFunc, true)
      local isHadChip = false
      local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
      chipItem:SetNewTagActive(false, chipShowState)
      table.insert(self.chipitemList, chipItem)
    end
  end
end

function UINWarChessTeamNodeItem:_OnClickChipItem(chipItem)
  if self._clickedAction ~= nil then
    self._clickedAction(chipItem, self.teamData)
  end
end

function UINWarChessTeamNodeItem:GetChipItemByIndex(idx)
  if self.chipitemList ~= nil and idx <= #self.chipitemList then
    return self.chipitemList[idx]
  end
  return
end

function UINWarChessTeamNodeItem:GetTeamData()
  return self.teamData
end

function UINWarChessTeamNodeItem:OnDelete()
  self.chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINWarChessTeamNodeItem
