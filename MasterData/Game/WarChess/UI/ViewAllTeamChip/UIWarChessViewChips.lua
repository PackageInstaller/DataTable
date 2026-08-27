local base = UIBaseWindow
local UIWarChessViewChips = class("UIWarChessViewChips", base)
local UINBaseChipDetail = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINWarChessViewChipsChipItem = require("Game.WarChess.UI.ViewAllTeamChip.UINWarChessViewChipsChipItem")
local UINWarChessViewChipsGroupItem = require("Game.WarChess.UI.ViewAllTeamChip.UINWarChessViewChipsGroupItem")

function UIWarChessViewChips:OnInit()
  UIUtil.AddButtonListener(self.ui.mask_Close, self, self.__OnClickBg)
  self.resloader = CS.ResLoader.Create()
  self.chipDetailPanel = UINBaseChipDetail.New()
  self.chipDetailPanel:Init(self.ui.chipItemDetail)
  self.chipItemPool = UIItemPool.New(UINWarChessViewChipsChipItem, self.ui.obj_chipItem)
  self.ui.obj_chipItem:SetActive(false)
  self.groupItemPool = UIItemPool.New(UINWarChessViewChipsGroupItem, self.ui.chipList)
  self.ui.chipList:SetActive(false)
  self.__onClickChip = BindCallback(self, self.__OnClickChip)
end

function UIWarChessViewChips:InitAllTeamChips()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl == nil then
    self:Delete()
  end
  self.chipItemPool:HideAll()
  self.groupItemPool:HideAll()
  local maxFmtNum = wcCtrl.teamCtrl:GetWCFmtNum()
  local isSelected = {isSelected = false}
  for index = 1, maxFmtNum do
    local teamData = wcCtrl.teamCtrl:GetTeamDataByTeamIndexIgnoreDead(index)
    if teamData ~= nil then
      local groupItem = self.groupItemPool:GetOne()
      groupItem:InitWCViewChipGroup(teamData, self.chipItemPool, self.__onClickChip, isSelected)
    end
  end
end

function UIWarChessViewChips:__OnClickChip(chipData)
  self.chipDetailPanel:InitBaseChipDetail(nil, chipData, nil, nil, true)
  for _, chipItem in pairs(self.chipItemPool.listItem) do
    chipItem:SetSelectUI(false)
  end
end

function UIWarChessViewChips:__OnClickBg()
  self:Delete()
end

function UIWarChessViewChips:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIWarChessViewChips
