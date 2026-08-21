local var_0_0 = class("TownWorkplace", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	NUMBER = 1,
	RATIO = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.startTime = arg_1_2
	arg_1_0.storedGold = 0

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_town_work_level
end

function var_0_0.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_0.GetGoldUnit(arg_4_0)
	return arg_4_0:GetType() == var_0_0.TYPE.NUMBER and arg_4_0:getConfig("gold_gain") or 0
end

function var_0_0.GetGoldRatio(arg_5_0)
	return arg_5_0:GetType() == var_0_0.TYPE.RATIO and arg_5_0:getConfig("gold_gain") or 0
end

function var_0_0.GetEffectStr(arg_6_0)
	return arg_6_0:GetType() == TownWorkplace.TYPE.NUMBER and string.format("+%s/H", TownActivity.GoldToShow(arg_6_0:GetGoldUnit() * 16)) or string.format("+%d%%", arg_6_0:GetGoldRatio() / 100)
end

function var_0_0.GetNextId(arg_7_0)
	return underscore.detect(arg_7_0:bindConfigTable().all, function(arg_8_0)
		local var_8_0 = arg_7_0:bindConfigTable()[arg_8_0]

		return var_8_0.group == arg_7_0:GetGroup() and var_8_0.level == arg_7_0:GetLevel() + 1
	end)
end

function var_0_0.GetLastId(arg_9_0)
	if arg_9_0:GetLevel() == 0 then
		return nil
	end

	return underscore.detect(arg_9_0:bindConfigTable().all, function(arg_10_0)
		local var_10_0 = arg_9_0:bindConfigTable()[arg_10_0]

		return var_10_0.group == arg_9_0:GetGroup() and var_10_0.level == arg_9_0:GetLevel() - 1
	end)
end

function var_0_0.GetIcon(arg_11_0)
	return arg_11_0:getConfig("pic")
end

function var_0_0.GetGroup(arg_12_0)
	return arg_12_0:getConfig("group")
end

function var_0_0.GetName(arg_13_0)
	return arg_13_0:getConfig("name")
end

function var_0_0.GetLevel(arg_14_0)
	return arg_14_0:getConfig("level")
end

function var_0_0.GetAddExp(arg_15_0)
	return arg_15_0:getConfig("exp_display")
end

function var_0_0.GetCostGold(arg_16_0)
	return arg_16_0:getConfig("gold")
end

function var_0_0.GetNeedTownLv(arg_17_0)
	return arg_17_0:getConfig("town_level")
end

function var_0_0.OnUpdateTime(arg_18_0, arg_18_1)
	arg_18_0.storedGold = arg_18_0:GetGoldUnit() * (arg_18_1 - arg_18_0.startTime)

	return
end

function var_0_0.GetStoredGold(arg_19_0)
	return arg_19_0.storedGold
end

function var_0_0.ResetStartTime(arg_20_0, arg_20_1)
	arg_20_0.startTime = arg_20_1

	return arg_20_0:GetGoldUnit() * (arg_20_1 - arg_20_0.startTime)
end

return var_0_0
