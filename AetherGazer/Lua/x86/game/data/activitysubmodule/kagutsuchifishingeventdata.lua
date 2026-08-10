local var_0_0 = singletonClass("KagutsuchiFishingEventData")
local var_0_1 = {
	S = {
		order = 3,
		name = "S"
	},
	A = {
		order = 2,
		name = "A"
	},
	B = {
		order = 1,
		name = "B"
	}
}

var_0_0.EnumFishRarity = var_0_1

local function var_0_2(arg_1_0)
	return GameSetting.activity_kagutsuchi_card_level_up_need.value[arg_1_0.order][2]
end

function var_0_0.InitFromServer(arg_2_0, arg_2_1)
	arg_2_0.activityID = arg_2_1.activity_id
	arg_2_0.dailyGameCount = arg_2_1.today_fish_num

	arg_2_0:UpdateFishRemain(arg_2_1.fish_list)
end

function var_0_0.UpdateFishRemain(arg_3_0, arg_3_1)
	arg_3_0.fishRemain = {}

	local var_3_0 = var_0_2(var_0_1.S)

	for iter_3_0, iter_3_1 in ipairs(HanafudaCardCfg.all) do
		arg_3_0.fishRemain[iter_3_1] = var_3_0
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1) do
		local var_3_1 = arg_3_0.fishRemain[iter_3_3.id] - iter_3_3.num

		arg_3_0.fishRemain[iter_3_3.id] = var_3_1 > 0 and var_3_1 or nil
	end
end

function var_0_0.OnFishingGameFinish(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		arg_4_0.dailyGameCount = arg_4_0.dailyGameCount + 1

		local var_4_0 = nullable(arg_4_0.fishRemain, arg_4_1)

		var_4_0 = var_4_0 and (var_4_0 > 1 and var_4_0 - 1 or nil)
		arg_4_0.fishRemain[arg_4_1] = var_4_0
	end
end

function var_0_0.TestRarity(arg_5_0)
	local var_5_0 = var_0_2(var_0_1.S) - arg_5_0

	if var_5_0 >= var_0_2(var_0_1.S) then
		return var_0_1.S
	elseif var_5_0 >= var_0_2(var_0_1.A) then
		return var_0_1.A
	else
		return var_0_1.B
	end
end

function var_0_0.GetRemainFishForUpgrade(arg_6_0, arg_6_1)
	return arg_6_0.fishRemain[arg_6_1] or 0
end

function var_0_0.GetRarity(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetRemainFishForUpgrade(arg_7_1)

	return var_0_0.TestRarity(var_7_0)
end

function var_0_0.FishNotYetGet(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetRemainFishForUpgrade(arg_8_1)

	return var_0_2(var_0_1.S) - var_8_0 == 0
end

function var_0_0.GetNextRarity(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetRemainFishForUpgrade(arg_9_1)
	local var_9_1 = var_0_2(var_0_1.S) - var_9_0

	if var_9_1 >= var_0_2(var_0_1.S) then
		return nil, nil
	elseif var_9_1 >= var_0_2(var_0_1.A) then
		return var_0_1.S, var_9_0
	else
		return var_0_1.A, var_0_2(var_0_1.A) - var_9_1
	end
end

function var_0_0.GetRestGameCount(arg_10_0)
	local var_10_0 = GameSetting.activity_kagutsuchi_fish_times_max.value[1]

	return math.max(0, var_10_0 - KagutsuchiFishingEventData.dailyGameCount)
end

return var_0_0
