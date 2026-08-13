class = var_0_10000

local var_0_0 = "ActivityBossKuybyshevScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityBossSceneTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossKuybyshevUI"
end

function var_0_1.UpdateDropItems(arg_2_0)
	ipairs = var_1_10001

	local var_2_0

	if not arg_2_0.contextData.DisplayItems then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_1_10001(var_2_0) do
		local var_2_1 = arg_2_0.barList[iter_2_0]
		local var_2_2 = var_6.Find(var_2_1, "milestone/item")
		local var_2_3 = {
			type = arg_2_0.contextData.DisplayItems[5 - iter_2_0][1],
			id = arg_2_0.contextData.DisplayItems[5 - iter_2_0][2],
			count = arg_2_0.contextData.DisplayItems[5 - iter_2_0][3]
		}

		updateDrop = var_8

		var_8(var_2_2:GetChild(0), var_2_3)

		onButton = var_8

		local var_2_4 = arg_2_0
		local var_2_5 = var_2_2

		local function var_2_6()
			local var_3_0 = arg_2_0

			var_0.emit(var_3_0, var_0_1.ON_DROP, var_2_3)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_2_4, var_2_5, var_2_6, var_1_10012)
	end

	return
end

return var_0_1
