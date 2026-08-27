local base = UIBaseNode
local UINWarChessTimeRewindItem = class("UINWarChessTimeRewindItem", base)

function UINWarChessTimeRewindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_normal, self, self.__OnClickTurnItem)
end

function UINWarChessTimeRewindItem:InitWCTRTurnItem(turnNum, isCur, onSelectTurnItem)
  self.turnNum = turnNum
  self.onSelectTurnItem = onSelectTurnItem
  self.ui.tex_TurnNumber_n.text = tostring(turnNum)
  self.ui.tex_TurnNumber_s.text = tostring(turnNum)
  self.ui.obj_Current_n:SetActive(isCur)
  self.ui.obj_Current_s:SetActive(isCur)
end

function UINWarChessTimeRewindItem:__OnClickTurnItem()
  if self.onSelectTurnItem ~= nil then
    self.onSelectTurnItem(self)
  end
end

function UINWarChessTimeRewindItem:SetIsSelected(bool)
  self.ui.obj_normal:SetActive(not bool)
  self.ui.obj_selectedTurn:SetActive(bool)
end

function UINWarChessTimeRewindItem:OnDelete()
end

return UINWarChessTimeRewindItem
