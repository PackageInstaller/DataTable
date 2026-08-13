class = var_0_10000

local var_0_0 = "NcHudDisplay"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetBoolArg("show")
	local var_1_1 = arg_1_0:GetAgent().gameObject
	local var_1_2 = var_2.GetComponent

	typeof = var_1_10005
	WorldObjectItem = var_1_10007

	local var_1_3 = var_1_2(var_1_1, var_1_10005(var_1_10007)).id
	local var_1_4 = var_2.type

	if var_1_0 then
		local function var_1_5()
			local var_2_0 = arg_1_0

			var_0.EndAction(var_2_0)

			return
		end

		var_1_10008 = arg_1_0

		local var_1_6 = arg_1_0.GetStringArg(var_1_10008, "type")
		local var_1_7 = arg_1_0:GetStringArg("height")

		var_1_10010 = arg_1_0
		var_1_10008 = arg_1_0.SendEvent
		ISLAND_EVT = var_1_10011

		local var_1_8 = var_1_10011.SHOW_UNIT_HUD_OP
		local var_1_9 = {}

		tonumber = var_1_10013
		var_1_9.id = var_1_10013(var_1_3)
		tonumber = var_13
		var_1_9.height = var_13(var_1_7)
		tonumber = var_13
		var_1_9.operationType = var_13(var_1_6)
		var_1_9.type = var_1_4

		var_1_10008(var_1_10010, var_1_8, var_1_9)
	else
		local var_1_10 = arg_1_0
		local var_1_11 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10008

		local var_1_12 = var_1_10008.HIDE_UNIT_HUD_OP
		local var_1_13 = {}

		tonumber = var_1_10010
		var_1_13.id = var_1_10010(var_1_3)
		var_1_13.type = var_1_4

		var_1_11(var_1_10, var_1_12, var_1_13)
		arg_1_0:EndAction()
	end

	return
end

return var_0_1
