class = var_0_10000

local var_0_0 = "NewServerPTGood"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".....model.vo.BaseVO"))

var_0_1.GoodType = {
	MultiTotalLimit = 2,
	SingleLimit = 1,
	MultiEachLimit = 4,
	RandomLimit = 3
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.newserver_shop_template
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_1
	arg_2_0.configID = arg_2_1
	arg_2_0.count = -1
	arg_2_0.multiEachInfoMap = {}
	arg_2_0.isMultiEachLimit = false

	return
end

function var_0_1.updateAllInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.data2KeyValueList[arg_3_0.configId].dataMap

	arg_3_0.count = var_2.value

	if arg_3_0:getConfig("goods_type") == var_0_1.GoodType.MultiEachLimit then
		arg_3_0.isMultiEachLimit = true
		pairs = var_5

		for iter_3_0, iter_3_1 in var_5(var_3_0) do
			arg_3_0.multiEachInfoMap[iter_3_0] = iter_3_1
		end
	end

	return
end

function var_0_1.updateCount(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_0.count - arg_4_1

	return
end

function var_0_1.isLeftCount(arg_5_0)
	return arg_5_0.count > 0
end

function var_0_1.getCount(arg_6_0)
	return arg_6_0.count
end

function var_0_1.isSelectable(arg_7_0)
	return arg_7_0:getConfig("goods_type") == var_0_1.GoodType.MultiTotalLimit or var_1 == var_0_1.GoodType.MultiEachLimit
end

function var_0_1.getContainIDList(arg_8_0)
	return arg_8_0:getConfig("goods")
end

function var_0_1.getUnlockIndex(arg_9_0)
	return arg_9_0:getConfig("unlock_time") / 0 + 1
end

return var_0_1
