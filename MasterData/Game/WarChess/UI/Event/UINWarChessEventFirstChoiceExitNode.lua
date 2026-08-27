local base = require("Game.WarChess.UI.Event.UINWarChessEventTypeNodeBase")
local UINWarChessEventFirstChoiceExitNode = class("UINWarChessEventFirstChoiceExitNode", base)

function UINWarChessEventFirstChoiceExitNode:OnInit()
  base.OnInit(self)
end

function UINWarChessEventFirstChoiceExitNode:RefreshEntChoiceList()
  local choicePool = self.uiEvent:GetWCChoicePool()
  choicePool:HideAll()
  for index, choiceData in ipairs(self.choiceDatas) do
    if index ~= 1 then
      local choiceItem = choicePool:GetOne()
      choiceItem.transform:SetParent(self.ui.rect)
      choiceItem:InitWCEventChoiceItem(choiceData, self.onChoiceClick)
    end
  end
end

return UINWarChessEventFirstChoiceExitNode
