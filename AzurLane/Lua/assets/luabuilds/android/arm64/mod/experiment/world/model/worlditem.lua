local var_0_0 = class("WorldItem", import(".....model.vo.Item"))

var_0_0.UsageBuff = "usage_world_buff"
var_0_0.UsageDrop = "usage_drop"
var_0_0.UsageLoot = "usage_undefined"
var_0_0.UsageHPRegenerate = "usage_world_healing"
var_0_0.UsageHPRegenerateValue = "usage_world_healing_value"
var_0_0.UsageRecoverAp = "usage_world_recoverAP"
var_0_0.UsageWorldMap = "usage_world_map"
var_0_0.UsageWorldItem = "usage_world_item"
var_0_0.UsageWorldClean = "usage_world_clean"
var_0_0.UsageWorldBuff = "usage_worldSLGbuff"
var_0_0.UsageDropAppointed = "usage_drop_appointed"
var_0_0.UsageWorldFlag = "usage_world_flag"
var_0_0.MoneyId = 100
var_0_0.PortMoneyId = 101

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = DROP_TYPE_WORLD_ITEM
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.count

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.world_item_data_template
end

function var_0_0.getConfigTable(arg_3_0)
	return BaseVO.getConfigTable(arg_3_0)
end

function var_0_0.getWorldItemType(arg_4_0)
	return arg_4_0:getConfig("usage")
end

function var_0_0.getWorldItemOpenDisplay(arg_5_0)
	return arg_5_0:getConfig("open_box")
end

function var_0_0.getItemQuota(arg_6_0)
	return arg_6_0:getConfig("usage_arg")[1]
end

function var_0_0.getItemBuffID(arg_7_0)
	return arg_7_0:getConfig("usage_arg")[2]
end

function var_0_0.getItemRegenerate(arg_8_0)
	return arg_8_0:getConfig("usage_arg")[2]
end

function var_0_0.getItemStaminaRecover(arg_9_0)
	return arg_9_0:getConfig("usage_arg")[1]
end

function var_0_0.getItemWorldBuff(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("usage_arg")

	return var_10_0[1], var_10_0[2]
end

function var_0_0.getItemFlagKey(arg_11_0)
	return arg_11_0:getConfig("usage_arg")[1]
end

function var_0_0.isDesignDrawing(arg_12_0)
	return false
end

return var_0_0
