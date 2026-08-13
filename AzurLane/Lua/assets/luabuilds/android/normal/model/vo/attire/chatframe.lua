class = var_0_10000

local var_0_0 = "ChatFrame"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AttireFrame"))

function var_0_1.GetIcon(arg_1_0)
	return "ChatFrame/" .. arg_1_0
end

function var_0_1.getType(arg_2_0)
	AttireConst = var_1_10001

	return var_1_10001.TYPE_CHAT_FRAME
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.item_data_chat
end

function var_0_1.getPrefabName(arg_4_0)
	if arg_4_0:getConfig("id") == 0 then
		return arg_4_0:getConfig("id") .. "_self"
	else
		return arg_4_0:getConfig("id") .. "_self"
	end

	return
end

function var_0_1.getDropType(arg_5_0)
	DROP_TYPE_CHAT_FRAME = var_1_10001

	return var_1_10001
end

function var_0_1.getIcon(arg_6_0)
	return var_0_1.GetIcon(arg_6_0:getPrefabName())
end

return var_0_1
