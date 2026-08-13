class = var_0_10000

local var_0_0 = "ActivityBossBristolScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ActivityBossSceneTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossBristolUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.top
	local var_2_1 = var_3.Find(var_2_0, "ticket/Desc")

	i18n = var_1_10004

	var_1(var_2_1, var_1_10004("word_special_challenge_ticket"))

	return
end

function var_0_1.UpdateDropItems(arg_3_0)
	ipairs = var_1_10001

	local var_3_0

	if not arg_3_0.contextData.DisplayItems then
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in var_1_10001(var_3_0) do
		local var_3_1 = arg_3_0.barList[iter_3_0]
		local var_3_2 = var_6.Find(var_3_1, "milestone/item/IconTpl")
		local var_3_3 = {
			type = arg_3_0.contextData.DisplayItems[5 - iter_3_0][1],
			id = arg_3_0.contextData.DisplayItems[5 - iter_3_0][2],
			count = arg_3_0.contextData.DisplayItems[5 - iter_3_0][3]
		}

		updateDrop = var_8

		var_8(var_3_2, var_3_3)

		onButton = var_8

		local var_3_4 = arg_3_0
		local var_3_5 = var_3_2

		local function var_3_6()
			local var_4_0 = arg_3_0

			var_0.emit(var_4_0, var_0_1.ON_DROP, var_3_3)

			return
		end

		SFX_PANEL = var_1_10013

		var_8(var_3_4, var_3_5, var_3_6, var_1_10013)
	end

	return
end

return var_0_1
