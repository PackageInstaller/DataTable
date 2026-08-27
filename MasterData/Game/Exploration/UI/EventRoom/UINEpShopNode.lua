local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpShopNode = class("UINEpEventNode", base)

function UINEpShopNode:OnInit()
  base.OnInit(self)
end

function UINEpShopNode:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
  uiEvent:SetRefreshBtn(true)
  uiEvent:SetSkipBtnActive(true)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpEventRoom) then
  end
end

function UINEpShopNode:RefreshBranchPage()
  base.RefreshBranchPage(self)
end

function UINEpShopNode:OnDelete()
  base.OnDelete(self)
end

return UINEpShopNode
