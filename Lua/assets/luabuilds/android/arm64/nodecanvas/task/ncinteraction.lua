local var_0_0 = class("NcInteraction", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem)).id

	if arg_1_0:GetBoolArg("show") then
		arg_1_0:SendEvent(ISLAND_EVT.APPROACH_UNIT, {
			id = tonumber(var_1_0),
			type = tonumber((arg_1_0:GetStringArg("type"))),
			callback = function()
				arg_1_0:EndAction()

				return
			end
		})
	else
		arg_1_0:SendEvent(ISLAND_EVT.LEAVE_UNIT, {
			id = tonumber(var_1_0)
		})
		arg_1_0:EndAction()
	end

	return
end

return var_0_0
