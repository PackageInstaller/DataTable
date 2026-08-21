local var_0_0 = class("BaseResourceField", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.attrs = {}

	return
end

function var_0_0.SetLevel(arg_2_0, arg_2_1)
	arg_2_0._LV = arg_2_1
	arg_2_0.configId = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.attrs) do
		iter_2_1:Update(arg_2_0._LV)
	end

	return
end

function var_0_0.SetUpgradeTimeStamp(arg_3_0, arg_3_1)
	arg_3_0._upgradeTimeStamp = arg_3_1

	return
end

function var_0_0.GetUpgradeTimeStamp(arg_4_0)
	return arg_4_0._upgradeTimeStamp
end

function var_0_0.GetDuration(arg_5_0)
	if arg_5_0._upgradeTimeStamp ~= 0 then
		return arg_5_0._upgradeTimeStamp - pg.TimeMgr.GetInstance():GetServerTime()
	else
		return nil
	end

	return
end

function var_0_0.IsStarting(arg_6_0)
	if arg_6_0._upgradeTimeStamp > 0 then
		local var_6_0 = arg_6_0._upgradeTimeStamp > pg.TimeMgr.GetInstance():GetServerTime()

		return var_6_0
	end
end

function var_0_0.GetSpendTime(arg_7_0)
	return arg_7_0:getConfig("time")
end

function var_0_0.GetLevel(arg_8_0)
	return arg_8_0._LV
end

function var_0_0.IsMaxLevel(arg_9_0)
	local var_9_0 = arg_9_0:bindConfigTable()

	return arg_9_0._LV == var_9_0.all[#var_9_0.all]
end

function var_0_0.GetTargetLevel(arg_10_0)
	return arg_10_0:bindConfigTable()[arg_10_0:GetLevel()].user_level
end

function var_0_0.IsReachLevel(arg_11_0)
	local var_11_0 = getProxy(PlayerProxy)

	return var_11_0:getRawData().level >= arg_11_0:bindConfigTable()[arg_11_0:GetLevel()].user_level
end

function var_0_0.GetTargetRes(arg_12_0)
	return arg_12_0:bindConfigTable()[arg_12_0:GetLevel()].use[2]
end

function var_0_0.IsReachRes(arg_13_0)
	local var_13_0 = getProxy(PlayerProxy)

	return var_13_0:getRawData().gold >= arg_13_0:bindConfigTable()[arg_13_0:GetLevel()].use[2]
end

function var_0_0.CanUpgrade(arg_14_0)
	if arg_14_0:IsReachLevel() and arg_14_0:IsReachRes() and not arg_14_0:IsMaxLevel() and arg_14_0._upgradeTimeStamp == 0 then
		return true
	end

	return false
end

function var_0_0.isCommissionNotify(arg_15_0, arg_15_1)
	return arg_15_0:getHourProduct() > arg_15_0:getConfig("store") - arg_15_1
end

function var_0_0.GetCost(arg_16_0)
	local var_16_0 = arg_16_0:getConfig("use")

	return {
		type = DROP_TYPE_RESOURCE,
		id = var_16_0[1],
		count = var_16_0[2]
	}
end

function var_0_0.GetEffectAttrs(arg_17_0)
	return arg_17_0.attrs
end

function var_0_0.GetName(arg_18_0)
	assert(false)

	return
end

function var_0_0.getHourProduct(arg_19_0)
	assert(false)

	return
end

function var_0_0.GetKeyWord(arg_20_0)
	assert(false)

	return
end

function var_0_0.bindConfigTable(arg_21_0)
	assert(false)

	return
end

function var_0_0.GetUpgradeType(arg_22_0)
	assert(false)

	return
end

function var_0_0.GetResourceType(arg_23_0)
	assert(false)

	return
end

function var_0_0.GetDesc(arg_24_0)
	assert(false)

	return
end

function var_0_0.GetPlayerRes(arg_25_0)
	assert(false)

	return
end

function var_0_0.HasRes(arg_26_0)
	return arg_26_0:GetPlayerRes() > 0
end

return var_0_0
