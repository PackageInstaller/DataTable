class = var_0_10000

local var_0_0 = "NcInteraction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetBoolArg("show")
	local var_1_1 = arg_1_0:GetAgent().gameObject
	local var_1_2 = var_2.GetComponent

	typeof = var_1_10004
	WorldObjectItem = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_1_10004(var_1_10005)).id

	if var_1_0 then
		local function var_1_4()
			local var_2_0 = arg_1_0

			var_0.EndAction(var_2_0)

			return
		end

		var_1_10006 = arg_1_0

		local var_1_5 = arg_1_0.GetStringArg(var_1_10006, "type")
		local var_1_6 = arg_1_0

		var_1_10006 = arg_1_0.SendEvent
		ISLAND_EVT = var_1_10008
		var_1_10008 = var_1_10008.APPROACH_UNIT

		local var_1_7 = {}

		tonumber = var_1_10010
		var_1_7.id = var_1_10010(var_1_3)
		tonumber = var_10
		var_1_7.type = var_10(var_1_5)
		var_1_7.callback = var_1_4

		var_1_10006(var_1_6, var_1_10008, var_1_7)
	else
		local var_1_8 = arg_1_0
		local var_1_9 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10006

		local var_1_10 = var_1_10006.LEAVE_UNIT
		local var_1_11 = {}

		tonumber = var_1_10008
		var_1_11.id = var_1_10008(var_1_3)

		var_1_9(var_1_8, var_1_10, var_1_11)
		arg_1_0:EndAction()
	end

	return
end

return var_0_1
