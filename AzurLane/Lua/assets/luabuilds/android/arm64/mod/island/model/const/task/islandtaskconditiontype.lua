class = var_0_10000

local var_0_0 = var_0_10000("IslandTaskConditionType")

var_0_0.GOT_ACHIEVEMENT = 1
var_0_0.FINISH_TASK = 2
var_0_0.EXIST_ABILITY = 3
var_0_0.MUTEX_TASK = 4
var_0_0.EXIST_ANY_ITEM = 6
var_0_0.EXIST_ALL_ITEM = 7
var_0_0.EXIST_ANY_COMMANDER_DRESS = 8
var_0_0.EXIST_ALL_COMMANDER_DRESS = 9

function var_0_0.IsMatch(arg_1_0)
	local var_1_0 = arg_1_0[1]
	local var_1_1 = arg_1_0[2]

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_3.GetIsland(var_1_2)

	switch = var_1_10004

	return var_1_10004(var_1_0, {
		[var_0_0.GOT_ACHIEVEMENT] = function()
			local var_2_0 = var_1_3
			local var_2_1 = var_0.GetAchievementAgency(var_2_0)

			return var_0.IsGot(var_2_1, var_1_1)
		end,
		[var_0_0.FINISH_TASK] = function()
			local var_3_0 = var_1_3
			local var_3_1 = var_0.GetTaskAgency(var_3_0)

			return var_0.IsFinishTask(var_3_1, var_1_1)
		end,
		[var_0_0.EXIST_ABILITY] = function()
			local var_4_0 = var_1_3
			local var_4_1 = var_0.GetAblityAgency(var_4_0)

			return var_0.HasAbility(var_4_1, var_1_1)
		end,
		[var_0_0.MUTEX_TASK] = function()
			local var_5_0 = var_1_3
			local var_5_1 = var_0.GetTaskAgency(var_5_0)

			return not var_0.IsPassId(var_5_1, var_1_1)
		end,
		[var_0_0.EXIST_ANY_ITEM] = function()
			local var_6_0 = var_1_3
			local var_6_1 = var_0.GetInventoryAgency(var_6_0)

			underscore = var_2_10001

			return var_2_10001.any(var_1_1, function(arg_7_0)
				local var_7_0 = var_6_1

				return var_1.OwnItem(var_7_0, arg_7_0)
			end)
		end,
		[var_0_0.EXIST_ALL_ITEM] = function()
			local var_8_0 = var_1_3
			local var_8_1 = var_0.GetInventoryAgency(var_8_0)

			underscore = var_2_10001

			return var_2_10001.all(var_1_1, function(arg_9_0)
				local var_9_0 = var_8_1

				return var_1.OwnItem(var_9_0, arg_9_0)
			end)
		end,
		[var_0_0.EXIST_ANY_COMMANDER_DRESS] = function()
			local var_10_0 = var_1_3
			local var_10_1 = var_0.GetDressUpAgency(var_10_0)

			underscore = var_2_10001

			return var_2_10001.any(var_1_1, function(arg_11_0)
				local var_11_0 = var_10_1

				return var_1.CheckOwnDress(var_11_0, arg_11_0)
			end)
		end,
		[var_0_0.EXIST_ALL_COMMANDER_DRESS] = function()
			local var_12_0 = var_1_3
			local var_12_1 = var_0.GetDressUpAgency(var_12_0)

			underscore = var_2_10001

			return var_2_10001.all(var_1_1, function(arg_13_0)
				local var_13_0 = var_12_1

				return var_1.CheckOwnDress(var_13_0, arg_13_0)
			end)
		end
	}, function()
		return false
	end)
end

return var_0_0
