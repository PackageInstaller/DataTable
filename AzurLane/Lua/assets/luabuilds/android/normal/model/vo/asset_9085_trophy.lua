class = var_0_10000

local var_0_0 = "Trophy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.INTAMACT_TYPE = 1043
var_0_1.COMPLEX_TROPHY_TYPE = 160
var_0_1.ALWAYS_SHOW = 0
var_0_1.ALWAYS_HIDE = 1
var_0_1.HIDE_BEFORE_UNLOCK = 2
var_0_1.COMING_SOON = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.subTrophyList = {}

	arg_1_0:update(arg_1_1)

	return
end

function var_0_1.generateDummyTrophy(arg_2_0)
	Trophy = var_1_10001

	return (var_1_10001.New({
		timestamp = -1,
		progress = 0,
		id = arg_2_0
	}))
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.medal_template
end

function var_0_1.update(arg_4_0, arg_4_1)
	arg_4_0.progress = arg_4_1.progress
	arg_4_0.timestamp = arg_4_1.timestamp
	arg_4_0.new = arg_4_1.new

	return
end

function var_0_1.isNew(arg_5_0)
	return arg_5_0.isNew == true
end

function var_0_1.clearNew(arg_6_0)
	arg_6_0.isNew = nil

	return
end

function var_0_1.updateTimeStamp(arg_7_0, arg_7_1)
	if arg_7_1 > 0 then
		arg_7_0.isNew = true
	end

	arg_7_0.timestamp = arg_7_1

	return
end

function var_0_1.isComplexTrophy(arg_8_0)
	return arg_8_0:getConfig("target_type") == arg_8_0.COMPLEX_TROPHY_TYPE
end

function var_0_1.bindTrophys(arg_9_0, arg_9_1)
	arg_9_0.subTrophyList[arg_9_1.id] = arg_9_1

	return
end

function var_0_1.getSubTrophy(arg_10_0)
	return arg_10_0.subTrophyList
end

function var_0_1.getTargetID(arg_11_0)
	return arg_11_0:getConfig("target_id")
end

function var_0_1.canClaimed(arg_12_0)
	return arg_12_0:getProgressRate() >= 1
end

function var_0_1.isClaimed(arg_13_0)
	return arg_13_0.timestamp > 0
end

function var_0_1.isDummy(arg_14_0)
	return arg_14_0.timestamp == -1
end

function var_0_1.getProgressRate(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:getProgress()

	return var_15_0 / var_15_1
end

function var_0_1.getProgress(arg_16_0)
	local var_16_0 = arg_16_0

	if arg_16_0.isComplexTrophy(var_16_0) then
		local var_16_1 = 0

		pairs = var_16_0

		for iter_16_0, iter_16_1 in var_16_0(arg_16_0.subTrophyList) do
			if iter_16_1:isClaimed() then
				var_16_1 = var_16_1 + 1
			end
		end

		local var_16_2 = var_16_1
		local var_16_3 = arg_16_0:getConfig("target_num")

		return
	else
		local var_16_4 = arg_16_0.progress
		local var_16_5 = arg_16_0:getConfig("target_num")

		return
	end

	return
end

function var_0_1.getHideType(arg_17_0)
	return arg_17_0:getConfig("hide")
end

function var_0_1.isHide(arg_18_0)
	if arg_18_0:getConfig("hide") == var_0_1.ALWAYS_HIDE then
		return true
	elseif var_1 == var_0_1.HIDE_BEFORE_UNLOCK and arg_18_0.timestamp <= 0 then
		return true
	else
		return false
	end

	return
end

function var_0_1.isMaxLevel(arg_19_0)
	local var_19_0 = arg_19_0:getConfig("next")
	local var_19_1 = arg_19_0:bindConfigTable()

	return var_19_0 == 0 or var_19_1[var_19_0] == nil
end

function var_0_1.getTargetType(arg_20_0)
	return arg_20_0:getConfig("target_type")
end

function var_0_1.isLoverLetter(arg_21_0)
	return arg_21_0.id > 0
end

function var_0_1.IsLoveLetterID(arg_22_0)
	return arg_22_0 > 0
end

return var_0_1
