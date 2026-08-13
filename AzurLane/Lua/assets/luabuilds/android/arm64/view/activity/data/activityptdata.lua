class = var_0_10000

local var_0_0 = var_0_10000("ActivityPtData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.dropList = arg_1_1:getDataConfig("drop_client")
	arg_1_0.targets = arg_1_1:getDataConfig("target")
	arg_1_0.resId = arg_1_1:getDataConfig("pt")
	arg_1_0.bindActId = arg_1_1:getDataConfig("id_2")
	arg_1_0.unlockDay = arg_1_1:getDataConfig("day_unlock")
	arg_1_0.type = arg_1_1:getDataConfig("type")

	arg_1_0:Update(arg_1_1)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1
	arg_2_0.count = arg_2_1.data1
	arg_2_0.level = 0

	local var_2_0 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_1.data1_list) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, iter_2_1)
	end

	table = var_3

	var_3.sort(var_2_0)

	ipairs = var_3

	for iter_2_2, iter_2_3 in var_3(var_2_0) do
		if iter_2_3 == arg_2_0.targets[iter_2_2] then
			arg_2_0.level = iter_2_2
		else
			break
		end
	end

	arg_2_0.startTime = arg_2_1.data2
	arg_2_0.value2 = arg_2_1.data3
	arg_2_0.isDayUnlock = arg_2_0:CheckDayUnlock() and 1 or 0
	arg_2_0.curHasBuffs = arg_2_1.data2_list
	arg_2_0.curBuffs = arg_2_1.data3_list

	return
end

function var_0_0.CheckDayUnlock(arg_3_0)
	math = var_1_10001

	local var_3_0 = var_1_10001.min(arg_3_0.level + 1, #arg_3_0.targets)

	pg = var_1_10002

	local var_3_1 = var_1_10002.TimeMgr.GetInstance()
	local var_3_2 = var_2.DiffDay(var_3_1, arg_3_0.startTime, var_2:GetServerTime()) + 1
	local var_3_3

	if not arg_3_0.unlockDay[var_3_0] then
		var_3_3 = 0
	end

	return var_3_3 <= var_3_2
end

function var_0_0.GetDayUnlockStamps(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()
	local var_4_1 = {}

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.unlockDay) do
		local var_4_2 = arg_4_0.startTime + (iter_4_1 - 1) * 0

		table = var_9

		var_9.insert(var_4_1, var_4_2)
	end

	return var_4_1
end

function var_0_0.GetLevelProgress(arg_5_0)
	return arg_5_0:getTargetLevel(), #arg_5_0.targets, var_1 / #arg_5_0.targets
end

function var_0_0.GetResProgress(arg_6_0)
	local var_6_0 = arg_6_0:getTargetLevel()

	return arg_6_0.count, arg_6_0.targets[var_6_0], arg_6_0.count / arg_6_0.targets[var_6_0]
end

function var_0_0.GetUnlockedMaxResRequire(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()
	local var_7_1 = var_1.DiffDay(var_7_0, arg_7_0.startTime, var_1:GetServerTime()) + 1

	for iter_7_0 = #arg_7_0.targets, 1, -1 do
		if var_7_1 >= arg_7_0.unlockDay[iter_7_0] then
			return arg_7_0.targets[iter_7_0]
		end
	end

	return 1
end

function var_0_0.GetTotalResRequire(arg_8_0)
	return arg_8_0.targets[#arg_8_0.targets]
end

function var_0_0.GetId(arg_9_0)
	return arg_9_0.activity.id
end

function var_0_0.GetRes(arg_10_0)
	return {
		type = 1,
		id = arg_10_0.resId
	}
end

function var_0_0.GetAward(arg_11_0)
	local var_11_0 = arg_11_0.dropList[arg_11_0:getTargetLevel()]

	Drop = var_2

	return var_2.New({
		type = var_11_0[1],
		id = var_11_0[2],
		count = var_11_0[3]
	})
end

function var_0_0.GetResItemId(arg_12_0)
	return arg_12_0:GetAward().id
end

function var_0_0.GetValue2(arg_13_0)
	return arg_13_0.value2
end

function var_0_0.getTargetLevel(arg_14_0)
	math = var_1_10001

	return var_1_10001.min(arg_14_0.level + arg_14_0.isDayUnlock, #arg_14_0.targets)
end

function var_0_0.GetLevel(arg_15_0)
	return arg_15_0.level
end

function var_0_0.CanGetAward(arg_16_0)
	local function var_16_0()
		local var_17_0 = arg_16_0
		local var_17_1, var_17_2, var_17_3 = var_0.GetResProgress(var_17_0)

		return var_17_3 >= 1
	end

	local var_16_1

	if arg_16_0:CanGetNextAward() then
		var_16_1 = var_16_0()
	end

	return var_16_1
end

function var_0_0.CanGetNextAward(arg_18_0)
	return arg_18_0.isDayUnlock > 0 and arg_18_0.level < #arg_18_0.targets
end

function var_0_0.CanGetMorePt(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)

	return var_1.getActivityById(var_19_0, arg_19_0.bindActId) and not var_1:isEnd()
end

function var_0_0.CanTrain(arg_20_0)
	if not arg_20_0:isInBuffTime() then
		return false
	end

	local function var_20_0(arg_21_0)
		ipairs = var_2_10001

		for iter_21_0, iter_21_1 in var_2_10001(arg_20_0.curHasBuffs) do
			if arg_21_0 == iter_21_1 then
				return false
			end
		end

		return true
	end

	ipairs = var_1_10002

	local var_20_1 = arg_20_0.activity

	for iter_20_0, iter_20_1 in var_1_10002(var_4.getDataConfig(var_20_1, "target_buff")) do
		if var_20_0(iter_20_1) and iter_20_1 <= arg_20_0.level + 1 then
			return iter_20_1
		end
	end

	return false
end

function var_0_0.GetCurBuffInfos(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = arg_22_0.activity
	local var_22_2 = #var_2.getDataConfig(var_22_1, "buff_group")

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0.curBuffs) do
		ipairs = var_1_10008

		local var_22_3 = arg_22_0.activity

		for iter_22_2, iter_22_3 in var_1_10008(var_10.getDataConfig(var_22_3, "buff_group")) do
			ipairs = var_13

			for iter_22_4, iter_22_5 in var_13(iter_22_3) do
				if iter_22_1 == iter_22_5 then
					local var_22_4 = {
						id = iter_22_5,
						lv = iter_22_4,
						group = iter_22_2,
						next = iter_22_3[iter_22_4 + 1],
						award = arg_22_0:GetBuffAwardInfo(iter_22_3[#iter_22_3])
					}

					table = var_19

					var_19.insert(var_22_0, var_22_4)
				end
			end
		end
	end

	return var_22_0
end

function var_0_0.GetBuffAwardInfo(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.activity

	if var_2.getDataConfig(var_23_0, "drop_display") == "" then
		return nil
	end

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_2) do
		if arg_23_1 == iter_23_1[1] then
			local var_23_1 = iter_23_1[2]

			return {
				type = var_23_1[1],
				id = var_23_1[2],
				count = var_23_1[3]
			}
		end
	end

	return nil
end

function var_0_0.GetBuffLevelProgress(arg_24_0)
	local var_24_0 = false
	local var_24_1, var_24_2 = (function()
		ipairs = var_2_10000

		local var_25_0 = arg_24_0.activity

		for iter_25_0, iter_25_1 in var_2_10000(var_2.getDataConfig(var_25_0, "target_buff")) do
			if iter_25_1 > arg_24_0.level then
				return iter_25_0, iter_25_1
			end
		end

		var_24_0 = true

		local var_25_1 = arg_24_0.activity

		return #var_0.getDataConfig(var_25_1, "target_buff") + 1, 1
	end)()
	local var_24_3

	if var_24_1 == 1 and true or false then
		var_24_3 = 0
	else
		local var_24_4 = arg_24_0.activity

		var_24_3 = var_6.getDataConfig(var_24_4, "target_buff")[var_24_1 - 1]
	end

	return var_24_1, var_24_0 and 1 or (arg_24_0.level - var_24_3) / (var_24_2 - var_24_3)
end

function var_0_0.isInBuffTime(arg_26_0)
	local var_26_0 = arg_26_0.activity
	local var_26_1 = var_1.getDataConfig(var_26_0, "buff_time")

	type = var_1_10002

	if var_1_10002(var_26_1) == "table" then
		pg = var_2

		local var_26_2 = var_2.TimeMgr.GetInstance()
		local var_26_3 = var_2.GetServerTime(var_26_2)
		local var_26_4 = {
			year = var_26_1[1][1],
			month = var_26_1[1][2],
			day = var_26_1[1][3],
			hour = var_26_1[2][1],
			min = var_26_1[2][2],
			sec = var_26_1[2][3]
		}

		pg = var_4

		local var_26_5 = var_4.TimeMgr.GetInstance()

		return var_26_3 < var_4.Table2ServerTime(var_26_5, var_26_4) and true or false
	elseif var_26_1 == "always" then
		return true
	elseif var_26_1 == "stop" then
		return false
	end

	return false
end

function var_0_0.GetDrop(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.dropList[arg_27_1]

	return {
		type = var_27_0[1],
		id = var_27_0[2],
		count = var_27_0[3]
	}
end

function var_0_0.GetPtTarget(arg_28_0, arg_28_1)
	if arg_28_1 <= 0 then
		return 0
	elseif arg_28_1 > #arg_28_0.targets then
		return arg_28_0.targets[#arg_28_0.targets]
	else
		return arg_28_0.targets[arg_28_1]
	end

	return
end

function var_0_0.GetCurrLevel(arg_29_0)
	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.targets) do
		if iter_29_1 > arg_29_0.count then
			return iter_29_0 - 1
		end
	end

	return #arg_29_0.targets
end

function var_0_0.IsMaxLevel(arg_30_0)
	return arg_30_0:GetCurrLevel() == #arg_30_0.targets
end

function var_0_0.GetNextLevel(arg_31_0)
	ipairs = var_1_10001

	for iter_31_0, iter_31_1 in var_1_10001(arg_31_0.targets) do
		if iter_31_1 > arg_31_0.count then
			return iter_31_0
		end
	end

	return #arg_31_0.targets
end

function var_0_0.GetCurrTarget(arg_32_0)
	local var_32_0 = arg_32_0:GetCurrLevel()

	return arg_32_0:GetPtTarget(var_32_0)
end

function var_0_0.GetNextLevelTarget(arg_33_0)
	local var_33_0 = arg_33_0:GetNextLevel()

	return arg_33_0:GetPtTarget(var_33_0)
end

function var_0_0.IsGotLevelAward(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetPtTarget(arg_34_1)

	ipairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_0.activity.data1_list) do
		if iter_34_1 == var_34_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetLastAward(arg_35_0)
	local var_35_0 = arg_35_0.dropList[#arg_35_0.targets]

	return {
		type = var_35_0[1],
		id = var_35_0[2],
		count = var_35_0[3]
	}
end

function var_0_0.GetMaxAvailableTargetIndex(arg_36_0)
	local var_36_0

	if not arg_36_0.availableTargetIndex then
		var_36_0 = 1
	end

	for iter_36_0 = var_36_0, #arg_36_0.targets do
		if arg_36_0.count >= arg_36_0.targets[iter_36_0] then
			arg_36_0.availableTargetIndex = iter_36_0
		else
			break
		end
	end

	local var_36_1

	if not arg_36_0.availableTargetIndex then
		var_36_1 = 0
	end

	return var_36_1
end

function var_0_0.GetAllAvailableAwards(arg_37_0)
	_ = var_1_10001

	local var_37_0 = var_1_10001.slice
	local var_37_1 = arg_37_0.dropList

	math = var_1_10004

	return var_37_0(var_37_1, var_1_10004.min(arg_37_0:GetLevel() + 1, arg_37_0:GetMaxAvailableTargetIndex()), arg_37_0:GetMaxAvailableTargetIndex() - arg_37_0:GetLevel())
end

var_0_0.STATE_LOCK = 1
var_0_0.STATE_CAN_GET = 2
var_0_0.STATE_GOT = 3

function var_0_0.GetDroptItemState(arg_38_0, arg_38_1)
	if arg_38_1 > arg_38_0:GetCurrLevel() then
		return var_0_0.STATE_LOCK
	elseif arg_38_0:IsGotLevelAward(arg_38_1) then
		return var_0_0.STATE_GOT
	else
		return var_0_0.STATE_CAN_GET
	end

	return
end

function var_0_0.AnyAwardCanGet(arg_39_0)
	ipairs = var_1_10001

	for iter_39_0, iter_39_1 in var_1_10001(arg_39_0.targets) do
		if arg_39_0:GetDroptItemState(iter_39_0) == var_0_0.STATE_CAN_GET then
			return true
		end
	end

	return false
end

return var_0_0
