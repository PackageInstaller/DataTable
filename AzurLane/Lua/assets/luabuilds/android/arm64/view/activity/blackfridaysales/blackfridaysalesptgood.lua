local var_0_0 = class("NewServerPTGood", import(".....model.vo.BaseVO"))

var_0_0.GoodType = {
	MultiTotalLimit = 2,
	SingleLimit = 1,
	MultiEachLimit = 4,
	RandomLimit = 3
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.newserver_shop_template
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_1
	arg_2_0.configID = arg_2_1
	arg_2_0.count = -1
	arg_2_0.multiEachInfoMap = {}
	arg_2_0.isMultiEachLimit = false

	return
end

function var_0_0.updateAllInfo(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_1.data2KeyValueList[arg_3_0.configId].value

	if arg_3_0:getConfig("goods_type") == var_0_0.GoodType.MultiEachLimit then
		arg_3_0.isMultiEachLimit = true

		for iter_3_0, iter_3_1 in pairs(arg_3_1.data2KeyValueList[arg_3_0.configId].dataMap) do
			arg_3_0.multiEachInfoMap[iter_3_0] = iter_3_1
		end
	end

	return
end

function var_0_0.updateCount(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_0.count - arg_4_1

	return
end

function var_0_0.isLeftCount(arg_5_0)
	return arg_5_0.count > 0
end

function var_0_0.getCount(arg_6_0)
	return arg_6_0.count
end

function var_0_0.isSelectable(arg_7_0)
	local var_7_0 = arg_7_0:getConfig("goods_type")

	return var_7_0 == var_0_0.GoodType.MultiTotalLimit or var_7_0 == var_0_0.GoodType.MultiEachLimit
end

function var_0_0.getContainIDList(arg_8_0)
	return arg_8_0:getConfig("goods")
end

function var_0_0.getUnlockIndex(arg_9_0)
	return arg_9_0:getConfig("unlock_time") / 0 + 1
end

return var_0_0
