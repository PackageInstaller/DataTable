NewServerPTShopConst = {}

local var_0_0 = NewServerPTShopConst

NewServerPTShopConst.ConfigTable = pg.newserver_shop_template

function NewServerPTShopConst.GetActivity()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)

	if var_1_0 and not var_1_0:isEnd() then
		return var_1_0
	end

	return
end

NewServerPTShopConst.GoodStatu = {
	Locked = 2,
	OnSell = 1,
	SellOut = 3
}

function NewServerPTShopConst.GetGoodStatu(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_0.GetActivity()

	if var_0_0.isGoodOnSell(arg_2_0, arg_2_1) then
		return var_0_0.GoodStatu.OnSell
	elseif var_0_0.isGoodSellOut(arg_2_0, arg_2_1) then
		return var_0_0.GoodStatu.SellOut
	elseif var_0_0.isGoodLocked(arg_2_0, arg_2_1) then
		return var_0_0.GoodStatu.Locked
	end

	return
end

function NewServerPTShopConst:isGoodOnSell(arg_3_1)
	return var_0_0.isGoodInTime(self, arg_3_1) and self:isLeftCount()
end

function NewServerPTShopConst:isGoodSellOut(arg_4_1)
	return var_0_0.isGoodInTime(self, arg_4_1) and not self:isLeftCount()
end

function NewServerPTShopConst.isGoodLocked(arg_5_0, arg_5_1)
	return not var_0_0.isGoodInTime(arg_5_0, arg_5_1)
end

function NewServerPTShopConst:GetAllGoodVOList()
	self = self or var_0_0.GetActivity()

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.data2KeyValueList) do
		local var_6_1 = NewServerPTGood.New(iter_6_0)

		var_6_1:updateAllInfo(self)
		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function NewServerPTShopConst.GetGoodVOListByIndex(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or var_0_0.GetActivity()
	arg_7_2 = arg_7_2 or var_0_0.GetAllGoodVOList()

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		if iter_7_1:getUnlockIndex() == arg_7_0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function NewServerPTShopConst.SortGoodVOList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or var_0_0.GetActivity()

	table.sort(arg_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getUnlockIndex()
		local var_9_1 = arg_9_1:getUnlockIndex()
		local var_9_2 = var_0_0.GetGoodStatu(arg_9_0, arg_8_1)
		local var_9_3 = var_0_0.GetGoodStatu(arg_9_1, arg_8_1)

		if var_9_0 < var_9_1 then
			return true
		elseif var_9_1 < var_9_0 then
			return false
		elseif var_9_0 == var_9_1 then
			if var_9_2 < var_9_3 then
				return true
			elseif var_9_3 < var_9_2 then
				return false
			elseif var_9_2 == var_9_3 then
				return arg_9_0.configID < arg_9_1.configID
			end
		end

		return
	end)

	return arg_8_0
end

function NewServerPTShopConst:GetStartTime()
	self = self or var_0_0.GetActivity()

	return self.stopTime - 0
end

function NewServerPTShopConst.GetSecSinceStart(arg_11_0)
	arg_11_0 = arg_11_0 or var_0_0.GetActivity()

	return pg.TimeMgr.GetInstance():GetServerTime() - var_0_0.GetStartTime(arg_11_0)
end

function NewServerPTShopConst:isGoodInTime(arg_12_1)
	arg_12_1 = arg_12_1 or var_0_0.GetActivity()

	return var_0_0.GetSecSinceStart(arg_12_1) >= self:getConfig("unlock_time")
end

return NewServerPTShopConst
