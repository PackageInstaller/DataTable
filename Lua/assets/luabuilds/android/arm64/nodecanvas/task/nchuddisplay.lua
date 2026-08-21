local var_0_0 = class("NcHudDisplay", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem))

	if arg_1_0:GetBoolArg("show") then
		arg_1_0:SendEvent(ISLAND_EVT.SHOW_UNIT_HUD_OP, {
			id = tonumber(var_1_0.id),
			height = tonumber((arg_1_0:GetStringArg("height"))),
			operationType = tonumber((arg_1_0:GetStringArg("type"))),
			type = var_1_0.type
		})
	else
		arg_1_0:SendEvent(ISLAND_EVT.HIDE_UNIT_HUD_OP, {
			id = tonumber(var_1_0.id),
			type = var_1_0.type
		})
		arg_1_0:EndAction()
	end

	return
end

return var_0_0
