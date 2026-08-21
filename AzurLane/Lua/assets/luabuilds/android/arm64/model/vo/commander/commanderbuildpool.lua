local var_0_0 = class("CommanderBuildPool", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.commander_data_create_material
end

function var_0_0.getName(arg_3_0)
	return arg_3_0:getConfig("name") or Item.New({
		id = arg_3_0:getConfig("use_item")
	}):getConfig("name") or ""
end

function var_0_0.getConsume(arg_4_0)
	return {
		{
			2,
			arg_4_0:getConfig("use_item"),
			(arg_4_0:getConfig("number_1"))
		}
	}
end

function var_0_0.getConsumeDesc(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("use_gold")

	return i18n("commander_build_pool_tip", Item.New({
		id = arg_5_0:getConfig("use_item")
	}):getConfig("name"), (arg_5_0:getConfig("number_1")))
end

function var_0_0.getPrint(arg_6_0)
	return Commander.rarity2Print(arg_6_0.id + 2)
end

function var_0_0.getItemCount(arg_7_0)
	return getProxy(BagProxy):getItemCountById((arg_7_0:getConfig("use_item")))
end

function var_0_0.getRarity(arg_8_0)
	return arg_8_0.id
end

return var_0_0
