local NcHudDisplay = class("NcHudDisplay", import("..base.NodeCanvasBaseTask"))

function NcHudDisplay:OnExecute()
	local var_1_0 = self:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem))

	if self:GetBoolArg("show") then
		self:SendEvent(ISLAND_EVT.SHOW_UNIT_HUD_OP, {
			id = tonumber(var_1_0.id),
			height = tonumber((self:GetStringArg("height"))),
			operationType = tonumber((self:GetStringArg("type"))),
			type = var_1_0.type
		})
	else
		self:SendEvent(ISLAND_EVT.HIDE_UNIT_HUD_OP, {
			id = tonumber(var_1_0.id),
			type = var_1_0.type
		})
		self:EndAction()
	end

	return
end

return NcHudDisplay
