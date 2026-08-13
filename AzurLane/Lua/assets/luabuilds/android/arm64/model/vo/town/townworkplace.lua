class = var_0_10000

local var_0_0 = "TownWorkplace"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	NUMBER = 1,
	RATIO = 2
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.startTime = arg_1_2
	arg_1_0.storedGold = 0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_town_work_level
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.GetGoldUnit(arg_4_0)
	local var_4_0

	if arg_4_0:GetType() ~= var_0_1.TYPE.NUMBER or not arg_4_0:getConfig("gold_gain") then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.GetGoldRatio(arg_5_0)
	local var_5_0

	if arg_5_0:GetType() ~= var_0_1.TYPE.RATIO or not arg_5_0:getConfig("gold_gain") then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.GetEffectStr(arg_6_0)
	local var_6_0 = arg_6_0:GetType()

	TownWorkplace = var_1_10002

	if var_6_0 == var_1_10002.TYPE.NUMBER then
		string = var_6_0
		var_6_0 = var_6_0.format

		local var_6_1 = "+%s/H"

		TownActivity = var_1_10004

		if not var_6_0(var_6_1, var_1_10004.GoldToShow(arg_6_0:GetGoldUnit() * 16)) then
			string = var_6_0
			var_6_0 = var_6_0.format("+%d%%", arg_6_0:GetGoldRatio() / 100)
		end

		return var_6_0
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

function var_0_1.GetIcon(arg_11_0)
	return arg_11_0:getConfig("pic")
end

function var_0_1.GetGroup(arg_12_0)
	return arg_12_0:getConfig("group")
end

function var_0_1.GetName(arg_13_0)
	return arg_13_0:getConfig("name")
end

function var_0_1.GetLevel(arg_14_0)
	return arg_14_0:getConfig("level")
end

function var_0_1.GetAddExp(arg_15_0)
	return arg_15_0:getConfig("exp_display")
end

function var_0_1.GetCostGold(arg_16_0)
	return arg_16_0:getConfig("gold")
end

function var_0_1.GetNeedTownLv(arg_17_0)
	return arg_17_0:getConfig("town_level")
end

function var_0_1.OnUpdateTime(arg_18_0, arg_18_1)
	arg_18_0.storedGold = arg_18_0:GetGoldUnit() * (arg_18_1 - arg_18_0.startTime)

	return
end

function var_0_1.GetStoredGold(arg_19_0)
	return arg_19_0.storedGold
end

function var_0_1.ResetStartTime(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 - arg_20_0.startTime

	arg_20_0.startTime = arg_20_1

	return arg_20_0:GetGoldUnit() * var_20_0
end

return var_0_1
