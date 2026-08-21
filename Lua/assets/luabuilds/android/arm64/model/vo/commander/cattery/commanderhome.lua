local var_0_0 = class("CommanderHome", import("...BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.level = arg_1_1.level
	arg_1_0.configId = arg_1_0.level
	arg_1_0.exp = arg_1_1.exp
	arg_1_0.catterys = {}
	arg_1_0.unlockCatteryId = 1
	arg_1_0.clean = arg_1_1.clean or 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.slots) do
		arg_1_0.catterys[iter_1_1.id] = Cattery.New(arg_1_0, iter_1_1)

		if iter_1_1.id > arg_1_0.unlockCatteryId then
			arg_1_0.unlockCatteryId = iter_1_1.id
		end
	end

	for iter_1_2 = 1, pg.gameset.commander_home_number.key_value do
		arg_1_0.catterys[iter_1_2] = arg_1_0.catterys[iter_1_2] or Cattery.New(arg_1_0, {
			op_flag = 7,
			id = iter_1_2
		})
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.commander_home
end

function var_0_0.GetLevel(arg_3_0)
	return arg_3_0.level
end

function var_0_0.GetMaxLevel(arg_4_0)
	local var_4_0 = arg_4_0:bindConfigTable()

	return var_4_0.all[#var_4_0.all]
end

function var_0_0.IsMaxLevel(arg_5_0)
	return arg_5_0:GetMaxLevel() <= arg_5_0.level
end

function var_0_0.AddExp(arg_6_0, arg_6_1)
	arg_6_0.exp = arg_6_0.exp + arg_6_1

	while arg_6_0:CanUpgrade() do
		local var_6_0 = arg_6_0:GetNextLevelExp()

		arg_6_0:LevelUp(arg_6_0.level + 1)

		arg_6_0.exp = arg_6_0.exp - var_6_0
	end

	return
end

function var_0_0.UpdateExpAndLevel(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 > arg_7_0.level then
		arg_7_0:LevelUp(arg_7_1)
	end

	arg_7_0.exp = arg_7_2

	return
end

function var_0_0.LevelUp(arg_8_0, arg_8_1)
	arg_8_0.level = arg_8_1
	arg_8_0.configId = arg_8_1

	return
end

function var_0_0.CanUpgrade(arg_9_0)
	if arg_9_0:GetNextLevelExp() <= arg_9_0.exp and not arg_9_0:IsMaxLevel() then
		return true
	end

	return false
end

function var_0_0.GetNextLevelExp(arg_10_0)
	return arg_10_0:getConfig("home_exp")
end

function var_0_0.GetPrevLevelExp(arg_11_0)
	local var_11_0 = arg_11_0:bindConfigTable()

	if var_11_0[arg_11_0.level - 1] then
		return var_11_0[arg_11_0.level - 1].home_exp or 0
	end
end

function var_0_0.GetCatteries(arg_12_0)
	return arg_12_0.catterys
end

function var_0_0.GetCatteryById(arg_13_0, arg_13_1)
	return arg_13_0.catterys[arg_13_1]
end

function var_0_0.GetAllLevel(arg_14_0)
	return arg_14_0:bindConfigTable().all
end

function var_0_0.IsHeadLevel(arg_15_0, arg_15_1)
	return arg_15_0:GetAllLevel()[1] == arg_15_1
end

function var_0_0.isTailLevel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetAllLevel()
	local var_16_1 = #var_16_0

	return var_16_0[var_16_1] == arg_16_1
end

function var_0_0.GetLevelConfig(arg_17_0, arg_17_1)
	return arg_17_0:bindConfigTable()[arg_17_1]
end

function var_0_0.GetTargetExpForLevel(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = 1, arg_18_1 - 1 do
		var_18_0 = var_18_0 + arg_18_0:GetLevelConfig(iter_18_0).home_exp
	end

	return var_18_0
end

function var_0_0.GetClean(arg_19_0)
	return arg_19_0.clean
end

function var_0_0.IncCleanValue(arg_20_0)
	arg_20_0.clean = arg_20_0.clean + arg_20_0:getConfig("flower")[1]

	return
end

function var_0_0.ReduceClean(arg_21_0)
	local var_21_1 = arg_21_0:getConfig("flower")[2]

	for iter_21_0, iter_21_1 in pairs((arg_21_0:GetCatteries())) do
		if iter_21_1:IsDirty() then
			arg_21_0.clean = arg_21_0.clean - var_21_1

			break
		end
	end

	return
end

function var_0_0.GetCleanLevel(arg_22_0)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0:getConfig("flower")[3]) do
		if iter_22_1 <= arg_22_0.clean then
			var_22_0 = iter_22_0
		end
	end

	return var_22_0
end

function var_0_0.GetOwnStyles(arg_23_0)
	return arg_23_0:getConfig("nest_appearance")
end

function var_0_0.GetMaxCatteryCnt(arg_24_0)
	return arg_24_0:getConfig("nest_number")
end

function var_0_0.GetCatteriesCommanders(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0:GetCatteries()) do
		if iter_25_1:ExistCommander() then
			table.insert({}, iter_25_1:GetCommanderId())
		end
	end

	return {}
end

function var_0_0.ResetCatteryOP(arg_26_0)
	for iter_26_0, iter_26_1 in pairs((arg_26_0:GetCatteries())) do
		if iter_26_1:ExistCommander() then
			iter_26_1:ResetOP()
		end
	end

	return
end

function var_0_0.GetFeedCommanderExp(arg_27_0)
	return arg_27_0:getConfig("feed_level")[2]
end

function var_0_0.AnyCatteryExistOP(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0:GetCatteries()) do
		if not iter_28_1:IsLocked() and (iter_28_1:ExiseFeedOP() or iter_28_1:ExistPlayOP() or iter_28_1:ExistCleanOP()) then
			return true
		end
	end

	return false
end

function var_0_0.AnyCatteryCanUse(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0:GetCatteries()) do
		if iter_29_1:GetState() == Cattery.STATE_EMPTY then
			return true
		end
	end

	return false
end

function var_0_0.GetFeedLevel(arg_30_0)
	return arg_30_0:getConfig("feed_level")[1]
end

function var_0_0.GetPlayLevel(arg_31_0)
	return arg_31_0:getConfig("teast_level")[1]
end

function var_0_0.GetExistCommanderCattertCnt(arg_32_0)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs((arg_32_0:GetCatteries())) do
		if iter_32_1:ExistCommander() then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function var_0_0.CommanderInHome(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in pairs((arg_33_0:GetCatteries())) do
		if iter_33_1:GetCommanderId() == arg_33_1 then
			return true
		end
	end

	return false
end

function var_0_0.ShouldSettleCattery(arg_34_0)
	for iter_34_0, iter_34_1 in pairs((arg_34_0:GetCatteries())) do
		if iter_34_1:ExistCommander() and iter_34_1:ExistCacheExp() then
			return true
		end
	end

	return false
end

return var_0_0
