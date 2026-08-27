local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpEventNode = class("UINEpEventNode", base)

function UINEpEventNode:OnInit()
  base.OnInit(self)
end

function UINEpEventNode:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpEventRoom) then
  end
end

function UINEpEventNode:RefreshBranchPage()
  base.RefreshBranchPage(self)
end

function UINEpEventNode:OnDelete()
  base.OnDelete(self)
end

return UINEpEventNode
