class = var_0_10000

local var_0_0 = "BaseResourceField"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.attrs = {}

	return
end

function var_0_1.SetLevel(arg_2_0, arg_2_1)
	arg_2_0._LV = arg_2_1
	arg_2_0.configId = arg_2_1
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.attrs) do
		iter_2_1:Update(arg_2_0._LV)
	end

	return
end

function var_0_1.SetUpgradeTimeStamp(arg_3_0, arg_3_1)
	arg_3_0._upgradeTimeStamp = arg_3_1

	return
end

function var_0_1.GetUpgradeTimeStamp(arg_4_0)
	return arg_4_0._upgradeTimeStamp
end

function var_0_1.GetDuration(arg_5_0)
	if arg_5_0._upgradeTimeStamp ~= 0 then
		local var_5_0 = arg_5_0._upgradeTimeStamp

		pg = var_1_10002

		local var_5_1 = var_1_10002.TimeMgr.GetInstance()

		return var_5_0 - var_2.GetServerTime(var_5_1)
	else
		return nil
	end

	return
end

function var_0_1.IsStarting(arg_6_0)
	local var_6_0 = arg_6_0._upgradeTimeStamp

	if 0 < var_6_0 then
		local var_6_1 = arg_6_0._upgradeTimeStamp

		pg = var_2

		local var_6_2 = var_2.TimeMgr.GetInstance()
		local var_6_3

		if not (var_6_1 > var_2.GetServerTime(var_6_2)) then
			var_6_3 = false
		else
			var_6_3 = true
		end

		return var_6_3
	end
end

function var_0_1.GetSpendTime(arg_7_0)
	return arg_7_0:getConfig("time")
end

function var_0_1.GetLevel(arg_8_0)
	return arg_8_0._LV
end

function var_0_1.IsMaxLevel(arg_9_0)
	local var_9_0 = arg_9_0:bindConfigTable()

	return arg_9_0._LV == var_9_0.all[#var_9_0.all]
end

function var_0_1.GetTargetLevel(arg_10_0)
	return arg_10_0:bindConfigTable()[arg_10_0:GetLevel()].user_level
end

function var_0_1.IsReachLevel(arg_11_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getRawData(var_11_0)
	local var_11_2 = arg_11_0:bindConfigTable()[arg_11_0:GetLevel()]

	return var_11_1.level >= var_11_2.user_level
end

function var_0_1.GetTargetRes(arg_12_0)
	return arg_12_0:bindConfigTable()[arg_12_0:GetLevel()].use[2]
end

function var_0_1.IsReachRes(arg_13_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getRawData(var_13_0)
	local var_13_2 = arg_13_0:bindConfigTable()[arg_13_0:GetLevel()]

	return var_13_1.gold >= var_13_2.use[2]
end

function var_0_1.CanUpgrade(arg_14_0)
	if arg_14_0:IsReachLevel() and arg_14_0:IsReachRes() and not arg_14_0:IsMaxLevel() and arg_14_0._upgradeTimeStamp == 0 then
		return true
	end

	return false
end

function var_0_1.isCommissionNotify(arg_15_0, arg_15_1)
	return arg_15_0:getHourProduct() > arg_15_0:getConfig("store") - arg_15_1
end

function var_0_1.GetCost(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getConfig(var_16_0, "use")
	local var_16_2 = {}

	DROP_TYPE_RESOURCE = var_16_0
	var_16_2.type = var_16_0
	var_16_2.id = var_16_1[1]
	var_16_2.count = var_16_1[2]

	return var_16_2
end

function var_0_1.GetEffectAttrs(arg_17_0)
	return arg_17_0.attrs
end

function var_0_1.GetName(arg_18_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.getHourProduct(arg_19_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetKeyWord(arg_20_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.bindConfigTable(arg_21_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetUpgradeType(arg_22_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetResourceType(arg_23_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetDesc(arg_24_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetPlayerRes(arg_25_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.HasRes(arg_26_0)
	return arg_26_0:GetPlayerRes() > 0
end

return var_0_1
