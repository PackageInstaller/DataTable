class = var_0_10000

local var_0_0 = var_0_10000("IslandInteractionConditionUntil")

var_0_0.SHOW_TYPE_CAN_ACCEPT_TASK = 1
var_0_0.SHOW_TYPE_EXIST_TASK = 2
var_0_0.SHOW_TYPE_CAN_SUBMIT_TASK = 3
var_0_0.SHOW_TYPE_FINISHED_TASK = 4
var_0_0.SHOW_TYPE_CAN_SIGNIN = 5
var_0_0.SHOW_TYPE_CAN_SELECT_GIFT = 6
var_0_0.SHOW_TYPE_CAN_INVITE_PLAYER = 7
var_0_0.SHOW_TYPE_CANT_SIGNIN = 8
var_0_0.SHOW_TYPE_CAN_WILD_GATHER = 9
var_0_0.SHOW_TYPE_CAN_WILD_SIGNIN = 10
var_0_0.SHOW_TYPE_ABILITY = 11
var_0_0.SHOW_TYPE_TASK_TARGET = 12
var_0_0.SHOW_TYPE_SELF_ABILITY = 13
var_0_0.SHOW_TYPE_ACTIVITY = 14

function var_0_0.Check(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1]
	local var_1_1 = arg_1_1[2]
	local var_1_2 = arg_1_1[3]

	switch = var_1_10005

	return var_1_10005(var_1_0, {
		[var_0_0.SHOW_TYPE_CAN_ACCEPT_TASK] = function()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.GetTaskAgency(var_2_0)

			return var_0.GetFutureTask(var_2_1, var_1_1) and var_0:IsUnlock()
		end,
		[var_0_0.SHOW_TYPE_EXIST_TASK] = function()
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.GetTaskAgency(var_3_0)

			return var_0.GetTask(var_3_1, var_1_1) and not var_0:IsFinish()
		end,
		[var_0_0.SHOW_TYPE_CAN_SUBMIT_TASK] = function()
			local var_4_0 = arg_1_0
			local var_4_1 = var_0.GetTaskAgency(var_4_0)

			return var_0.GetTask(var_4_1, var_1_1) and var_0:IsFinish()
		end,
		[var_0_0.SHOW_TYPE_FINISHED_TASK] = function()
			local var_5_0 = arg_1_0
			local var_5_1 = var_0.GetTaskAgency(var_5_0)

			return (var_0.IsFinishTask(var_5_1, var_1_1))
		end,
		[var_0_0.SHOW_TYPE_CAN_SIGNIN] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_6_0 = var_2_10000(var_2_10002)
			local var_6_3

			if var_0.GetIsland(var_6_0).id == arg_1_0.id then
				local var_6_1 = arg_1_0
				local var_6_2 = var_0.GetSignInAgency(var_6_1)

				var_6_3 = var_0.CanSignIn(var_6_2)
			else
				var_6_3 = false
			end

			if false then
				var_6_3 = true
			end

			return var_6_3
		end,
		[var_0_0.SHOW_TYPE_CAN_SELECT_GIFT] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_7_0 = var_2_10000(var_2_10002)

			if var_0.GetIsland(var_7_0).id == arg_1_0.id then
				local var_7_1 = arg_1_0
				local var_7_2 = var_1.GetSignInAgency(var_7_1)
				local var_7_3

				if not var_1.CanSelectGift(var_7_2) then
					var_7_3 = not var_0
				end

				return var_7_3
			end
		end,
		[var_0_0.SHOW_TYPE_CAN_INVITE_PLAYER] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_8_0 = var_2_10000(var_2_10002)
			local var_8_3

			if var_0.GetIsland(var_8_0).id == arg_1_0.id then
				local var_8_1 = arg_1_0
				local var_8_2 = var_0.GetSignInAgency(var_8_1)

				var_8_3 = var_0.CanInvite(var_8_2)
			else
				var_8_3 = false
			end

			if false then
				var_8_3 = true
			end

			return var_8_3
		end,
		[var_0_0.SHOW_TYPE_CANT_SIGNIN] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_9_0 = var_2_10000(var_2_10002)
			local var_9_3

			if var_0.GetIsland(var_9_0).id == arg_1_0.id then
				local var_9_1 = arg_1_0
				local var_9_2 = var_0.GetSignInAgency(var_9_1)

				var_9_3 = not var_0.CanSignIn(var_9_2)
			else
				var_9_3 = false
			end

			if false then
				var_9_3 = true
			end

			return var_9_3
		end,
		[var_0_0.SHOW_TYPE_ABILITY] = function()
			local var_10_0 = arg_1_0
			local var_10_1 = var_0.GetAblityAgency(var_10_0)

			return var_0.HasAbility(var_10_1, var_1_1)
		end,
		[var_0_0.SHOW_TYPE_SELF_ABILITY] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_11_0 = var_2_10000(var_2_10002)
			local var_11_1 = var_0.GetIsland(var_11_0)
			local var_11_2 = var_0.GetAblityAgency(var_11_1)

			return var_0.HasAbility(var_11_2, var_1_1)
		end,
		[var_0_0.SHOW_TYPE_TASK_TARGET] = function()
			local var_12_0 = arg_1_0
			local var_12_1 = var_0.GetTaskAgency(var_12_0)
			local var_12_3

			if var_0.GetTask(var_12_1, var_1_1) and var_0:GetTargetById(var_1_2) then
				local var_12_2 = var_0:GetTargetById(var_1_2)

				var_12_3 = not var_1.IsFinish(var_12_2)
			end

			return var_12_3
		end,
		[var_0_0.SHOW_TYPE_ACTIVITY] = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_13_0 = var_2_10000(var_2_10002)

			return var_0.IsActivityNotEnd(var_13_0, var_1_1)
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "非法显示条件类型:" .. var_1_0)

		return
	end)
end

return var_0_0
