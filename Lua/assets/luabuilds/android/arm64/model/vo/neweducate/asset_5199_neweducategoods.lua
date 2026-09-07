local NewEducateGoods = class("NewEducateGoods", import("model.vo.BaseVO"))

NewEducateGoods.TYPE = {
	ATTR = 2,
	RES = 3,
	UP_ENTRY = 5,
	BENEFIT = 1,
	CHOOSE = 4
}
NewEducateGoods.COST_TYPE = {
	GOLD = 1
}
NewEducateGoods.COST_TYPE_2_RES_TYPE = {
	[NewEducateGoods.COST_TYPE.GOLD] = NewEducateChar.RES_TYPE.MONEY
}

function NewEducateGoods:bindConfigTable()
	return pg.child2_shop
end

function NewEducateGoods:Ctor(arg_2_1, arg_2_2)
	self.id = arg_2_1
	self.configId = self.id
	self.buyCnt = arg_2_2 or 0

	return
end

function NewEducateGoods:IsLimitTime()
	return self:getConfig("is_refresh") == 1
end

function NewEducateGoods:GetLimitCnt()
	return self:getConfig("limit_num")
end

function NewEducateGoods:IsLimitCnt()
	return self:GetLimitCnt() ~= -1
end

function NewEducateGoods:GetRemainCnt()
	return self:IsLimitCnt() and self:GetLimitCnt() - self.buyCnt or 9999
end

function NewEducateGoods:GetCostCondition()
	return {
		operator = ">=",
		type = NewEducateConst.DROP_TYPE.RES,
		id = getProxy(NewEducateProxy):GetCurChar():GetResIdByType(NewEducateGoods.COST_TYPE_2_RES_TYPE[self:getConfig("resource_type")]),
		number = self:getConfig("resource_num")
	}
end

function NewEducateGoods:GetCostWithBenefit(arg_8_1)
	local var_8_0 = Clone(self:GetCostCondition())

	if arg_8_1[var_8_0.type] then
		if arg_8_1[var_8_0.type][var_8_0.id] then
			var_8_0.number = NewEducateHelper.GetBenefitValue(var_8_0.number, arg_8_1[var_8_0.type][var_8_0.id])
		end
	end

	return var_8_0
end

function NewEducateGoods:AddBuyCnt(arg_9_1)
	self.buyCnt = self.buyCnt + arg_9_1

	return
end

function NewEducateGoods:IsBenefitType()
	return self:getConfig("goods_type") == NewEducateGoods.TYPE.BENEFIT
end

function NewEducateGoods:IsResType()
	return self:getConfig("goods_type") == NewEducateGoods.TYPE.RES
end

return NewEducateGoods
