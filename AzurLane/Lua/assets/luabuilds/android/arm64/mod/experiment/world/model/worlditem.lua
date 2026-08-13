class = var_0_10000

local var_0_0 = "WorldItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".....model.vo.Item"))

var_0_1.UsageBuff = "usage_world_buff"
var_0_1.UsageDrop = "usage_drop"
var_0_1.UsageLoot = "usage_undefined"
var_0_1.UsageHPRegenerate = "usage_world_healing"
var_0_1.UsageHPRegenerateValue = "usage_world_healing_value"
var_0_1.UsageRecoverAp = "usage_world_recoverAP"
var_0_1.UsageWorldMap = "usage_world_map"
var_0_1.UsageWorldItem = "usage_world_item"
var_0_1.UsageWorldClean = "usage_world_clean"
var_0_1.UsageWorldBuff = "usage_worldSLGbuff"
var_0_1.UsageDropAppointed = "usage_drop_appointed"
var_0_1.UsageWorldFlag = "usage_world_flag"
var_0_1.MoneyId = 100
var_0_1.PortMoneyId = 101

function var_0_1.Ctor(arg_1_0, arg_1_1)
	DROP_TYPE_WORLD_ITEM = var_1_10002
	arg_1_0.type = var_1_10002
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.count

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.world_item_data_template
end

function var_0_1.getConfigTable(arg_3_0)
	BaseVO = var_1_10001

	return var_1_10001.getConfigTable(arg_3_0)
end

function var_0_1.getWorldItemType(arg_4_0)
	return arg_4_0:getConfig("usage")
end

function var_0_1.getWorldItemOpenDisplay(arg_5_0)
	return arg_5_0:getConfig("open_box")
end

function var_0_1.getItemQuota(arg_6_0)
	return arg_6_0:getConfig("usage_arg")[1]
end

function var_0_1.getItemBuffID(arg_7_0)
	return arg_7_0:getConfig("usage_arg")[2]
end

function var_0_1.getItemRegenerate(arg_8_0)
	return arg_8_0:getConfig("usage_arg")[2]
end

function var_0_1.getItemStaminaRecover(arg_9_0)
	return arg_9_0:getConfig("usage_arg")[1]
end

function var_0_1.getItemWorldBuff(arg_10_0)
	return arg_10_0:getConfig("usage_arg")[1], var_1[2]
end

function var_0_1.getItemFlagKey(arg_11_0)
	return arg_11_0:getConfig("usage_arg")[1]
end

function var_0_1.isDesignDrawing(arg_12_0)
	return false
end

return var_0_1
