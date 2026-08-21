local var_0_0 = class("IslandTaskConditionType")

var_0_0.GOT_ACHIEVEMENT = 1
var_0_0.FINISH_TASK = 2
var_0_0.EXIST_ABILITY = 3
var_0_0.MUTEX_TASK = 4
var_0_0.EXIST_ANY_ITEM = 6
var_0_0.EXIST_ALL_ITEM = 7
var_0_0.EXIST_ANY_COMMANDER_DRESS = 8
var_0_0.EXIST_ALL_COMMANDER_DRESS = 9

function var_0_0.IsMatch(arg_1_0)
	local var_1_0 = arg_1_0[2]
	local var_1_1 = getProxy(IslandProxy):GetIsland()

	return switch(arg_1_0[1], {
		[var_0_0.GOT_ACHIEVEMENT] = function()
			return var_1_1:GetAchievementAgency():IsGot(var_1_0)
		end,
		[var_0_0.FINISH_TASK] = function()
			return var_1_1:GetTaskAgency():IsFinishTask(var_1_0)
		end,
		[var_0_0.EXIST_ABILITY] = function()
			return var_1_1:GetAblityAgency():HasAbility(var_1_0)
		end,
		[var_0_0.MUTEX_TASK] = function()
			return not var_1_1:GetTaskAgency():IsPassId(var_1_0)
		end,
		[var_0_0.EXIST_ANY_ITEM] = function()
			local var_6_0 = var_1_1:GetInventoryAgency()

			return underscore.any(var_1_0, function(arg_7_0)
				return var_6_0:OwnItem(arg_7_0)
			end)
		end,
		[var_0_0.EXIST_ALL_ITEM] = function()
			local var_8_0 = var_1_1:GetInventoryAgency()

			return underscore.all(var_1_0, function(arg_9_0)
				return var_8_0:OwnItem(arg_9_0)
			end)
		end,
		[var_0_0.EXIST_ANY_COMMANDER_DRESS] = function()
			local var_10_0 = var_1_1:GetDressUpAgency()

			return underscore.any(var_1_0, function(arg_11_0)
				return var_10_0:CheckOwnDress(arg_11_0)
			end)
		end,
		[var_0_0.EXIST_ALL_COMMANDER_DRESS] = function()
			local var_12_0 = var_1_1:GetDressUpAgency()

			return underscore.all(var_1_0, function(arg_13_0)
				return var_12_0:CheckOwnDress(arg_13_0)
			end)
		end
	}, function()
		return false
	end)
end

return var_0_0
