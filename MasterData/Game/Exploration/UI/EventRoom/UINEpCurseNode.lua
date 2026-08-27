local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpCurseNode = class("UINEpEventNode", base)

function UINEpCurseNode:OnInit()
  base.OnInit(self)
end

function UINEpCurseNode:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpEventRoom) then
  end
end

function UINEpCurseNode:RefreshBranchPage()
  base.RefreshBranchPage(self)
end

function UINEpCurseNode:OnDelete()
  base.OnDelete(self)
end

return UINEpCurseNode
