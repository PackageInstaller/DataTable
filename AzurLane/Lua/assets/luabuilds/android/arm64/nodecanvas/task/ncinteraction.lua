class = var_0_10000

local var_0_0 = "NcInteraction"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetBoolArg("show")
	local var_1_1 = arg_1_0:GetAgent().gameObject
	local var_1_2 = var_2.GetComponent

	typeof = var_1_10005
	WorldObjectItem = var_1_10007

	local var_1_3 = var_1_2(var_1_1, var_1_10005(var_1_10007)).id

	if var_1_0 then
		local function var_1_4()
			local var_2_0 = arg_1_0

			var_0.EndAction(var_2_0)

			return
		end

		var_1_10007 = arg_1_0

		local var_1_5 = arg_1_0.GetStringArg(var_1_10007, "type")
		local var_1_6 = arg_1_0
		local var_1_7 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10009
		var_1_10009 = var_1_10009.APPROACH_UNIT

		local var_1_8 = {}

		tonumber = var_1_10011
		var_1_8.id = var_1_10011(var_1_3)
		tonumber = var_11
		var_1_8.type = var_11(var_1_5)
		var_1_8.callback = var_1_4

		var_1_7(var_1_6, var_1_10009, var_1_8)
	else
		local var_1_9 = arg_1_0
		local var_1_10 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10007

		local var_1_11 = var_1_10007.LEAVE_UNIT
		local var_1_12 = {}

		tonumber = var_1_10009
		var_1_12.id = var_1_10009(var_1_3)

		var_1_10(var_1_9, var_1_11, var_1_12)
		arg_1_0:EndAction()
	end

	return
end

return var_0_1
