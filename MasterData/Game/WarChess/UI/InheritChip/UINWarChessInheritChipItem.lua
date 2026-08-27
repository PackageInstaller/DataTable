local base = UIBaseNode
local UINWarChessInheritChipItem = class("UINWarChessInheritChipItem", UIBaseNode)
local UINChipSmallItem = require("Game.CommonUI.Chip.UINChipSmallItem")

function UINWarChessInheritChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Inherit, self, self.__OnClickHerit)
  UIUtil.AddButtonListener(self.ui.btn_Chip, self, self.__OnClickShowChipDetail)
  self._smallChipPool = UIItemPool.New(UINChipSmallItem, self.ui.obj_uINChipSmallItem, false)
end

function UINWarChessInheritChipItem:InitWCInheritChipItem(teamData, resloader, onClickHerit)
  self.teamData = teamData
  self.resloader = resloader
  self.onClickHerit = onClickHerit
  self._smallChipPool:HideAll()
  local chipList = teamData:GetWCTeamChipList()
  for index, chipData in ipairs(chipList) do
    local chipItem = self._smallChipPool:GetOne()
    chipItem:InitChipSmallItem(chipData)
  end
  local dynPlayer = teamData:GetTeamDynPlayer()
  local _, count, limit = dynPlayer:IsChipOverLimitNum()
  if limit <= count then
    self.ui.tex_ChipCount:SetIndex(1, tostring(count), tostring(limit))
  else
    self.ui.tex_ChipCount:SetIndex(0, tostring(count), tostring(limit))
  end
end

function UINWarChessInheritChipItem:__OnClickShowChipDetail()
  print("--TODO 战棋 显示继承芯片详情")
end

function UINWarChessInheritChipItem:__OnClickHerit()
  if self.onClickHerit ~= nil then
    self.onClickHerit()
  end
end

return UINWarChessInheritChipItem
