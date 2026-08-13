class = var_0_10000

local var_0_0 = "NcHudDisplay"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetBoolArg("show")
	local var_1_1 = arg_1_0:GetAgent().gameObject
	local var_1_2 = var_2.GetComponent

	typeof = var_1_10004
	WorldObjectItem = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_1_10004(var_1_10005)).id
	local var_1_4 = var_2.type

	if var_1_0 then
		local function var_1_5()
			local var_2_0 = arg_1_0

			var_0.EndAction(var_2_0)

			return
		end

		var_1_10007 = arg_1_0

		local var_1_6 = arg_1_0.GetStringArg(var_1_10007, "type")

		var_1_10007 = arg_1_0:GetStringArg("height")
		var_1_10009 = arg_1_0

		local var_1_7 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10010

		local var_1_8 = var_1_10010.SHOW_UNIT_HUD_OP
		local var_1_9 = {}

		tonumber = var_1_10012
		var_1_9.id = var_1_10012(var_1_3)
		tonumber = var_12
		var_1_9.height = var_12(var_1_10007)
		tonumber = var_12
		var_1_9.operationType = var_12(var_1_6)
		var_1_9.type = var_1_4

		var_1_7(var_1_10009, var_1_8, var_1_9)
	else
		local var_1_10 = arg_1_0
		local var_1_11 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10007

		local var_1_12 = var_1_10007.HIDE_UNIT_HUD_OP
		local var_1_13 = {}

		tonumber = var_1_10009
		var_1_13.id = var_1_10009(var_1_3)
		var_1_13.type = var_1_4

		var_1_11(var_1_10, var_1_12, var_1_13)
		arg_1_0:EndAction()
	end

	return
end

return var_0_1
