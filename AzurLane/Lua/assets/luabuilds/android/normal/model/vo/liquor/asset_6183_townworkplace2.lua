class = var_0_10000

local var_0_0 = "TownWorkplace2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE = {
	ROLE = 3,
	RATIO = 2,
	NUMBER = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.startTime = arg_1_2
	arg_1_0.storedGold = 0
	pg = var_3

	local var_1_0 = var_3.activity_town_2

	ActivityConst = var_1_10004
	arg_1_0.gold_time_limit = var_1_0[var_1_10004.LiquorFloor_ACT_ID].gold_time_limit

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_town_work_level_2
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.GetGoldUnit(arg_4_0)
	local var_4_0

	if arg_4_0:GetType() ~= var_0_1.TYPE.NUMBER or not arg_4_0:GetTypeParam() then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.GetGoldRatio(arg_5_0)
	local var_5_0

	if arg_5_0:GetType() ~= var_0_1.TYPE.UPPER or not arg_5_0:GetTypeParam() then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.GetEffectStr(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetType(var_6_0)

	TownWorkplace2 = var_6_0

	if var_6_1 == var_6_0.TYPE.NUMBER then
		string = var_6_1
		var_6_1 = var_6_1.format

		local var_6_2 = "+%s/H"

		TownActivity2 = var_1_10003

		if not var_6_1(var_6_2, var_1_10003.GoldToShow(arg_6_0:GetGoldUnit() * 16)) then
			string = var_6_1
			var_6_1 = var_6_1.format("+%d%%", arg_6_0:GetGoldRatio() / 100)
		end

		return var_6_1
	end
end

function var_0_1.GetNextId(arg_7_0)
	underscore = var_1_10001

	return var_1_10001.detect(arg_7_0:bindConfigTable().all, function(arg_8_0)
		local var_8_0 = arg_7_0
		local var_8_1 = var_1.bindConfigTable(var_8_0)[arg_8_0].group
		local var_8_2 = arg_7_0

		if var_8_1 == var_3.GetGroup(var_8_2) then
			local var_8_3 = var_1.level
			local var_8_4 = arg_7_0
			local var_8_5

			if var_8_3 ~= var_3.GetLevel(var_8_4) + 1 then
				var_8_5 = false
			else
				var_8_5 = true
			end

			return var_8_5
		end
	end)
end

function var_0_1.GetLastId(arg_9_0)
	if arg_9_0:GetLevel() == 0 then
		return nil
	end

	underscore = var_1

	return var_1.detect(arg_9_0:bindConfigTable().all, function(arg_10_0)
		local var_10_0 = arg_9_0
		local var_10_1 = var_1.bindConfigTable(var_10_0)[arg_10_0].group
		local var_10_2 = arg_9_0

		if var_10_1 == var_3.GetGroup(var_10_2) then
			local var_10_3 = var_1.level
			local var_10_4 = arg_9_0
			local var_10_5

			if var_10_3 ~= var_3.GetLevel(var_10_4) - 1 then
				var_10_5 = false
			else
				var_10_5 = true
			end

			return var_10_5
		end
	end)
end

function var_0_1.GetId(arg_11_0)
	return arg_11_0:getConfig("id")
end

function var_0_1.GetDesc(arg_12_0)
	return arg_12_0:getConfig("desc")
end

function var_0_1.GetIcon(arg_13_0)
	return arg_13_0:getConfig("pic")
end

function var_0_1.GetGroup(arg_14_0)
	return arg_14_0:getConfig("group")
end

function var_0_1.GetName(arg_15_0)
	return arg_15_0:getConfig("name")
end

function var_0_1.GetLevel(arg_16_0)
	return arg_16_0:getConfig("level")
end

function var_0_1.GetNeedTownLv(arg_17_0)
	return arg_17_0:getConfig("town_level")
end

function var_0_1.GetTypeParam(arg_18_0)
	return arg_18_0:getConfig("type_param")
end

function var_0_1.GetUpgrade(arg_19_0)
	return arg_19_0:getConfig("upgrade")
end

function var_0_1.OnUpdateTime(arg_20_0, arg_20_1)
	arg_20_0.storedGold = arg_20_0:GetGoldUnit() * (arg_20_1 - arg_20_0.startTime)

	return
end

function var_0_1.GetStoredGold(arg_21_0)
	return arg_21_0.storedGold
end

function var_0_1.ResetStartTime(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 - arg_22_0.startTime

	arg_22_0.startTime = arg_22_1
	arg_22_0.gold_time_limit = arg_22_0.gold_time_limit - arg_22_1

	return arg_22_0:GetGoldUnit() * var_22_0
end

function var_0_1.OnStartTime(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.TimeMgr.GetInstance()
	local var_23_1

	if var_1.GetServerTime(var_23_0) - arg_23_0.startTime >= arg_23_0.gold_time_limit then
		var_23_1 = arg_23_0.gold_time_limit
	end

	return arg_23_0:GetGoldUnit() * var_23_1
end

return var_0_1
