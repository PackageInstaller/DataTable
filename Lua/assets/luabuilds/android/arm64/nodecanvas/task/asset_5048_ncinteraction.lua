local NcInteraction = class("NcInteraction", import("..base.NodeCanvasBaseTask"))

function NcInteraction:OnExecute()
	local var_1_0 = self:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem)).id

	if self:GetBoolArg("show") then
		self:SendEvent(ISLAND_EVT.APPROACH_UNIT, {
			id = tonumber(var_1_0),
			type = tonumber((self:GetStringArg("type"))),
			callback = function()
				self:EndAction()

				return
			end
		})
	else
		self:SendEvent(ISLAND_EVT.LEAVE_UNIT, {
			id = tonumber(var_1_0)
		})
		self:EndAction()
	end

	return
end

return NcInteraction
