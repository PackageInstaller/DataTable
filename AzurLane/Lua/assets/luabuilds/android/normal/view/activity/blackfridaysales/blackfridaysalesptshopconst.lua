local var_0_0 = {}

NewServerPTShopConst = NewServerPTShopConst
pg = var_0_10001
var_0.ConfigTable = var_0_10001.newserver_shop_template

function var_0.GetActivity()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_1_0 = var_1_10000(var_1_10001)
	local var_1_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	if var_1_1(var_1_0, var_1_10003.ACTIVITY_TYPE_NEWSERVER_SHOP) and not var_1:isEnd() then
		return var_1
	end

	return
end

var_0.GoodStatu = {
	Locked = 2,
	OnSell = 1,
	SellOut = 3
}

function var_0.GetGoodStatu(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0.GetActivity()

	if var_0.isGoodOnSell(arg_2_0, arg_2_1) then
		return var_0.GoodStatu.OnSell
	elseif var_0.isGoodSellOut(arg_2_0, arg_2_1) then
		return var_0.GoodStatu.SellOut
	elseif var_0.isGoodLocked(arg_2_0, arg_2_1) then
		return var_0.GoodStatu.Locked
	end

	return
end

function var_0.isGoodOnSell(arg_3_0, arg_3_1)
	local var_3_0 = var_0.isGoodInTime(arg_3_0, arg_3_1)
	local var_3_1 = arg_3_0:isLeftCount()

	return var_3_0 and var_3_1
end

function var_0.isGoodSellOut(arg_4_0, arg_4_1)
	local var_4_0 = var_0.isGoodInTime(arg_4_0, arg_4_1)
	local var_4_1 = not arg_4_0:isLeftCount()

	return var_4_0 and var_4_1
end

function var_0.isGoodLocked(arg_5_0, arg_5_1)
	return not var_0.isGoodInTime(arg_5_0, arg_5_1)
end

function var_0.GetAllGoodVOList(arg_6_0)
	arg_6_0 = arg_6_0 or var_0.GetActivity()

	local var_6_0 = {}
	local var_6_1 = arg_6_0.data2KeyValueList

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_1) do
		NewServerPTGood = var_1_10008

		local var_6_2 = var_1_10008.New(iter_6_0)

		var_1_10008.updateAllInfo(var_6_2, arg_6_0)

		table = var_9

		var_9.insert(var_6_0, var_1_10008)
	end

	return var_6_0
end

function var_0.GetGoodVOListByIndex(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or var_0.GetActivity()
	arg_7_2 = arg_7_2 or var_0.GetAllGoodVOList()

	local var_7_0 = {}

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_2) do
		local var_7_1 = iter_7_1

		if iter_7_1.getUnlockIndex(var_7_1) == arg_7_0 then
			table = var_7_1

			var_7_1.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0.SortGoodVOList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or var_0.GetActivity()

	local function var_8_0(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getUnlockIndex()
		local var_9_1 = arg_9_1:getUnlockIndex()
		local var_9_2 = var_0.GetGoodStatu(arg_9_0, arg_8_1)
		local var_9_3 = var_0.GetGoodStatu(arg_9_1, arg_8_1)

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
	end

	table = var_1_10003

	var_1_10003.sort(arg_8_0, var_8_0)

	return arg_8_0
end

function var_0.GetStartTime(arg_10_0)
	arg_10_0 = arg_10_0 or var_0.GetActivity()

	return arg_10_0.stopTime - 0
end

function var_0.GetSecSinceStart(arg_11_0)
	arg_11_0 = arg_11_0 or var_0.GetActivity()
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_11_0) - var_0.GetStartTime(arg_11_0)
end

function var_0.isGoodInTime(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or var_0.GetActivity()

	return var_0.GetSecSinceStart(arg_12_1) >= arg_12_0:getConfig("unlock_time")
end

return var_0
