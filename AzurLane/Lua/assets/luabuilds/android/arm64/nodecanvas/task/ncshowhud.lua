local var_0_0 = class("NcShowHud", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem))
	local var_1_1 = arg_1_0:GetStringArg("viewLuaName")

	if arg_1_0:GetBoolArg("show") then
		arg_1_0:SendEvent(ISLAND_EVT.SHOW_HUD, {
			id = tonumber(var_1_0.id),
			type = tonumber(var_1_0.type),
			unitTransform = arg_1_0:GetAgent().transform,
			viewLuaName = var_1_1,
			uiLuaName = arg_1_0:GetStringArg("uiLuaName"),
			positionX = tonumber((arg_1_0:GetStringArg("positionX"))),
			positionY = tonumber((arg_1_0:GetStringArg("positionY"))),
			param1 = arg_1_0:GetStringArg("param1"),
			param2 = arg_1_0:GetStringArg("param2"),
			param3 = arg_1_0:GetStringArg("param3")
		})
	else
		arg_1_0:SendEvent(ISLAND_EVT.HIDE_HUD, {
			id = tonumber(var_1_0.id),
			type = tonumber(var_1_0.type),
			viewLuaName = var_1_1
		})
	end

	arg_1_0:EndAction()

	return
end

return var_0_0
