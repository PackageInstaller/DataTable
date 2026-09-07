local NcSendEvent = class("NcSendEvent", import("..base.NodeCanvasBaseTask"))

function NcSendEvent:OnExecute()
	self:SendEvent(ISLAND_EVT[self:GetStringArg("eventName")], {
		node = self
	})
	self:EndAction()

	return
end

return NcSendEvent
