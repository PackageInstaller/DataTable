local base = UIBaseNode
local UINWarChessChipBag = class("UINWarChessChipBag", base)
local UINWarChessChipBagItem = require("Game.WarChess.UI.Chip.UINWarChessChipBagItem")
local UINWCChipDetailCombat = require("Game.WarChess.UI.Common.UINWCChipDetailCombat")

function UINWarChessChipBag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnBtnClick)
  self.ui.wCChipItem:SetActive(false)
  self._chipItemPool = UIItemPool.New(UINWarChessChipBagItem, self.ui.wCChipItem)
  self._chipDetailItem = UINWCChipDetailCombat.New()
  self._chipDetailItem:Init(self.ui.wcChipDetailCombat)
  self._chipItemClickEvent = BindCallback(self, self._OnChipItemClicked)
end

function UINWarChessChipBag:InitWCTeamChipBag(teamData)
  self._teamData = teamData
  self.ui.tex_Team:SetIndex(0, teamData:GetWCTeamName())
  self:_RefreshTeamChipPanel()
end

function UINWarChessChipBag:_RefreshTeamChipPanel()
  local wcDynPlayer = self._teamData:GetTeamDynPlayer()
  local chipList = wcDynPlayer.chipList
  local num = wcDynPlayer.chipLimitInfo.count
  local limit = wcDynPlayer.chipLimitInfo.limit
  self.ui.tex_ChipLimit.text = tostring(num) .. "/" .. tostring(limit)
  self._chipItemPool:HideAll()
  for index, chipData in ipairs(chipList) do
    local chipItem = self._chipItemPool:GetOne()
    chipItem:InitWCChipBagItem(chipData, self._chipItemClickEvent)
  end
  if #chipList <= 0 then
    return
  end
  self._selectChipItem = nil
  local chipData = chipList[1]
  local chipItem = self._chipItemPool.listItem[1]
  self:_OnChipItemClicked(chipItem, chipData)
end

function UINWarChessChipBag:_OnChipItemClicked(chipBagItem, chipData)
  if self._selectChipItem == chipBagItem then
    return
  end
  self._selectChipItem = chipBagItem
  self.ui.img_Selected:SetParent(chipBagItem.transform)
  self.ui.img_Selected.anchoredPosition = Vector2.Temp(0, 0)
  local dynPlayer = self._teamData:GetTeamDynPlayer()
  self._chipDetailItem:InitWCChipDetailCombat(chipData, dynPlayer, nil, true)
end

function UINWarChessChipBag:SetWCCBCloseCallback(callback)
  self.callback = callback
end

function UINWarChessChipBag:_OnBtnClick()
  if self.callback ~= nil then
    self.callback()
    self.callback = nil
  end
  self:Hide()
end

function UINWarChessChipBag:OnDelete()
  base.OnDelete(self)
end

return UINWarChessChipBag
