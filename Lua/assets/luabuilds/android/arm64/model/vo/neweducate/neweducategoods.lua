local var_0_0 = class("NewEducateGoods", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	ATTR = 2,
	RES = 3,
	UP_ENTRY = 5,
	BENEFIT = 1,
	CHOOSE = 4
}
var_0_0.COST_TYPE = {
	GOLD = 1
}
var_0_0.COST_TYPE_2_RES_TYPE = {
	[var_0_0.COST_TYPE.GOLD] = NewEducateChar.RES_TYPE.MONEY
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child2_shop
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id
	arg_2_0.buyCnt = arg_2_2 or 0

	return
end

function var_0_0.IsLimitTime(arg_3_0)
	return arg_3_0:getConfig("is_refresh") == 1
end

function var_0_0.GetLimitCnt(arg_4_0)
	return arg_4_0:getConfig("limit_num")
end

function var_0_0.IsLimitCnt(arg_5_0)
	return arg_5_0:GetLimitCnt() ~= -1
end

function var_0_0.GetRemainCnt(arg_6_0)
	return arg_6_0:IsLimitCnt() and arg_6_0:GetLimitCnt() - arg_6_0.buyCnt or 9999
end

function var_0_0.GetCostCondition(arg_7_0)
	return {
		operator = ">=",
		type = NewEducateConst.DROP_TYPE.RES,
		id = getProxy(NewEducateProxy):GetCurChar():GetResIdByType(var_0_0.COST_TYPE_2_RES_TYPE[arg_7_0:getConfig("resource_type")]),
		number = arg_7_0:getConfig("resource_num")
	}
end

function var_0_0.GetCostWithBenefit(arg_8_0, arg_8_1)
	local var_8_0 = Clone(arg_8_0:GetCostCondition())

	if arg_8_1[var_8_0.type] then
		if arg_8_1[var_8_0.type][var_8_0.id] then
			var_8_0.number = NewEducateHelper.GetBenefitValue(var_8_0.number, arg_8_1[var_8_0.type][var_8_0.id])
		end
	end

	return var_8_0
end

function var_0_0.AddBuyCnt(arg_9_0, arg_9_1)
	arg_9_0.buyCnt = arg_9_0.buyCnt + arg_9_1

	return
end

function var_0_0.IsBenefitType(arg_10_0)
	return arg_10_0:getConfig("goods_type") == var_0_0.TYPE.BENEFIT
end

function var_0_0.IsResType(arg_11_0)
	return arg_11_0:getConfig("goods_type") == var_0_0.TYPE.RES
end

return var_0_0
