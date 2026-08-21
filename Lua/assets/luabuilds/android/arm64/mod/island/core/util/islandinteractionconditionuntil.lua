local var_0_0 = class("IslandInteractionConditionUntil")

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
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	return switch(arg_1_1[1], {
		[var_0_0.SHOW_TYPE_CAN_ACCEPT_TASK] = function()
			local var_2_0 = arg_1_0:GetTaskAgency():GetFutureTask(var_1_0)

			return var_2_0 and var_2_0:IsUnlock()
		end,
		[var_0_0.SHOW_TYPE_EXIST_TASK] = function()
			local var_3_0 = arg_1_0:GetTaskAgency():GetTask(var_1_0)

			return var_3_0 and not var_3_0:IsFinish()
		end,
		[var_0_0.SHOW_TYPE_CAN_SUBMIT_TASK] = function()
			local var_4_0 = arg_1_0:GetTaskAgency():GetTask(var_1_0)

			return var_4_0 and var_4_0:IsFinish()
		end,
		[var_0_0.SHOW_TYPE_FINISHED_TASK] = function()
			return (arg_1_0:GetTaskAgency():IsFinishTask(var_1_0))
		end,
		[var_0_0.SHOW_TYPE_CAN_SIGNIN] = function()
			local var_6_0 = getProxy(IslandProxy)

			return var_6_0:GetIsland().id == arg_1_0.id and arg_1_0:GetSignInAgency():CanSignIn()
		end,
		[var_0_0.SHOW_TYPE_CAN_SELECT_GIFT] = function()
			local var_7_0 = getProxy(IslandProxy):GetIsland().id == arg_1_0.id

			if var_7_0 then
				return arg_1_0:GetSignInAgency():CanSelectGift() or not var_7_0
			end
		end,
		[var_0_0.SHOW_TYPE_CAN_INVITE_PLAYER] = function()
			local var_8_0 = getProxy(IslandProxy)

			return var_8_0:GetIsland().id == arg_1_0.id and arg_1_0:GetSignInAgency():CanInvite()
		end,
		[var_0_0.SHOW_TYPE_CANT_SIGNIN] = function()
			local var_9_0 = getProxy(IslandProxy):GetIsland().id == arg_1_0.id and not arg_1_0:GetSignInAgency():CanSignIn() or false

			if false then
				var_9_0 = true
			end

			return var_9_0
		end,
		[var_0_0.SHOW_TYPE_ABILITY] = function()
			return arg_1_0:GetAblityAgency():HasAbility(var_1_0)
		end,
		[var_0_0.SHOW_TYPE_SELF_ABILITY] = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_1_0)
		end,
		[var_0_0.SHOW_TYPE_TASK_TARGET] = function()
			local var_12_0 = arg_1_0:GetTaskAgency():GetTask(var_1_0)
			local var_12_1

			if var_12_0 then
				::label_12_0::

				var_12_1 = var_12_0:GetTargetById(var_1_1)

				if var_12_1 then
					var_12_1 = not var_12_0:GetTargetById(var_1_1):IsFinish()
				end
			end

			return var_12_1
		end,
		[var_0_0.SHOW_TYPE_ACTIVITY] = function()
			return getProxy(ActivityProxy):IsActivityNotEnd(var_1_0)
		end
	}, function()
		assert(false, "非法显示条件类型:" .. var_0)

		return
	end)
end

return var_0_0
