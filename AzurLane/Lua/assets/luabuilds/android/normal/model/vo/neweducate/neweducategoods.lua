class = var_0_10000

local var_0_0 = "NewEducateGoods"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE = {
	ATTR = 2,
	RES = 3,
	UP_ENTRY = 5,
	BENEFIT = 1,
	CHOOSE = 4
}
var_0_1.COST_TYPE = {
	GOLD = 1
}

local var_0_2 = {}
local var_0_3 = var_0_1.COST_TYPE.GOLD

NewEducateChar = var_3
var_0_2[var_0_3] = var_3.RES_TYPE.MONEY
var_0_1.COST_TYPE_2_RES_TYPE = var_0_2

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child2_shop
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id
	arg_2_0.buyCnt = arg_2_2 or 0

	return
end

function var_0_1.IsLimitTime(arg_3_0)
	return arg_3_0:getConfig("is_refresh") == 1
end

function var_0_1.GetLimitCnt(arg_4_0)
	return arg_4_0:getConfig("limit_num")
end

function var_0_1.IsLimitCnt(arg_5_0)
	return arg_5_0:GetLimitCnt() ~= -1
end

function var_0_1.GetRemainCnt(arg_6_0)
	local var_6_0

	if not arg_6_0:IsLimitCnt() or not (arg_6_0:GetLimitCnt() - arg_6_0.buyCnt) then
		var_6_0 = 9999
	end

	return var_6_0
end

function var_0_1.GetCostCondition(arg_7_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.GetCurChar(var_7_0)
	local var_7_2 = var_1.GetResIdByType(var_7_1, var_0_1.COST_TYPE_2_RES_TYPE[arg_7_0:getConfig("resource_type")])
	local var_7_3 = {
		operator = ">="
	}

	NewEducateConst = var_4
	var_7_3.type = var_4.DROP_TYPE.RES
	var_7_3.id = var_7_2
	var_7_3.number = arg_7_0:getConfig("resource_num")

	return var_7_3
end

function var_0_1.GetCostWithBenefit(arg_8_0, arg_8_1)
	Clone = var_1_10002

	if arg_8_1[var_1_10002(arg_8_0:GetCostCondition()).type] and arg_8_1[var_2.type][var_2.id] then
		NewEducateHelper = var_4
		var_2.number = var_4.GetBenefitValue(var_2.number, var_3)
	end

	return var_2
end

function var_0_1.AddBuyCnt(arg_9_0, arg_9_1)
	arg_9_0.buyCnt = arg_9_0.buyCnt + arg_9_1

	return
end

function var_0_1.IsBenefitType(arg_10_0)
	return arg_10_0:getConfig("goods_type") == var_0_1.TYPE.BENEFIT
end

function var_0_1.IsResType(arg_11_0)
	return arg_11_0:getConfig("goods_type") == var_0_1.TYPE.RES
end

return var_0_1
