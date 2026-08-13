class = var_0_10000

local var_0_0 = "CombatUIStyle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AttireFrame"))

function var_0_1.GetIcon(arg_1_0)
	return "CombatUIStyle/" .. arg_1_0
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.item_data_battleui
end

function var_0_1.getType(arg_3_0)
	AttireConst = var_1_10001

	return var_1_10001.TYPE_COMBAT_UI_STYLE
end

function var_0_1.getDropType(arg_4_0)
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10001

	return var_1_10001
end

function var_0_1.getPrefabName(arg_5_0)
	return arg_5_0:getConfig("id")
end

function var_0_1.getIcon(arg_6_0)
	return var_0_1.GetIcon(arg_6_0:getPrefabName())
end

function var_0_1.updateData(arg_7_0)
	return
end

function var_0_1.isOwned(arg_8_0)
	return arg_8_0:bindConfigTable()[arg_8_0.id].is_unlock == 0 or arg_8_0.owned
end

function var_0_1.isNew(arg_9_0)
	return arg_9_0.new == true
end

function var_0_1.setNew(arg_10_0)
	arg_10_0.new = true

	return
end

function var_0_1.setUnlock(arg_11_0)
	arg_11_0.owned = true

	if arg_11_0.lock then
		arg_11_0.lock = false

		arg_11_0:setNew()
	end

	return
end

function var_0_1.setLock(arg_12_0)
	arg_12_0.lock = true

	return
end

return var_0_1
