local IslandInteractionConditionUntil = class("IslandInteractionConditionUntil")

IslandInteractionConditionUntil.SHOW_TYPE_CAN_ACCEPT_TASK = 1
IslandInteractionConditionUntil.SHOW_TYPE_EXIST_TASK = 2
IslandInteractionConditionUntil.SHOW_TYPE_CAN_SUBMIT_TASK = 3
IslandInteractionConditionUntil.SHOW_TYPE_FINISHED_TASK = 4
IslandInteractionConditionUntil.SHOW_TYPE_CAN_SIGNIN = 5
IslandInteractionConditionUntil.SHOW_TYPE_CAN_SELECT_GIFT = 6
IslandInteractionConditionUntil.SHOW_TYPE_CAN_INVITE_PLAYER = 7
IslandInteractionConditionUntil.SHOW_TYPE_CANT_SIGNIN = 8
IslandInteractionConditionUntil.SHOW_TYPE_CAN_WILD_GATHER = 9
IslandInteractionConditionUntil.SHOW_TYPE_CAN_WILD_SIGNIN = 10
IslandInteractionConditionUntil.SHOW_TYPE_ABILITY = 11
IslandInteractionConditionUntil.SHOW_TYPE_TASK_TARGET = 12
IslandInteractionConditionUntil.SHOW_TYPE_SELF_ABILITY = 13
IslandInteractionConditionUntil.SHOW_TYPE_ACTIVITY = 14

function IslandInteractionConditionUntil:Check(arg_1_1)
	local var_1_0 = arg_1_1[1]
	local var_1_1 = arg_1_1[2]
	local var_1_2 = arg_1_1[3]

	return switch(arg_1_1[1], {
		[IslandInteractionConditionUntil.SHOW_TYPE_CAN_ACCEPT_TASK] = function()
			local var_2_0 = self:GetTaskAgency():GetFutureTask(var_1_1)

			return var_2_0 and var_2_0:IsUnlock()
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_EXIST_TASK] = function()
			local var_3_0 = self:GetTaskAgency():GetTask(var_1_1)

			return var_3_0 and not var_3_0:IsFinish()
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_CAN_SUBMIT_TASK] = function()
			local var_4_0 = self:GetTaskAgency():GetTask(var_1_1)

			return var_4_0 and var_4_0:IsFinish()
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_FINISHED_TASK] = function()
			return (self:GetTaskAgency():IsFinishTask(var_1_1))
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_CAN_SIGNIN] = function()
			return getProxy(IslandProxy):GetIsland().id == self.id and self:GetSignInAgency():CanSignIn()
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_CAN_SELECT_GIFT] = function()
			local var_7_0 = getProxy(IslandProxy):GetIsland().id == self.id

			return (var_7_0 or nil) and (self:GetSignInAgency():CanSelectGift() or not var_7_0)
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_CAN_INVITE_PLAYER] = function()
			return getProxy(IslandProxy):GetIsland().id == self.id and self:GetSignInAgency():CanInvite()
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_CANT_SIGNIN] = function()
			local var_9_0 = getProxy(IslandProxy):GetIsland().id == self.id and not self:GetSignInAgency():CanSignIn() or false

			return (false or nil) and true
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_ABILITY] = function()
			return self:GetAblityAgency():HasAbility(var_1_1)
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_SELF_ABILITY] = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_1_1)
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_TASK_TARGET] = function()
			local var_12_0 = self:GetTaskAgency():GetTask(var_1_1)
			local var_12_1

			if var_12_0 then
				::label_12_0::

				var_12_1 = var_12_0:GetTargetById(var_1_2)

				if var_12_1 then
					var_12_1 = not var_12_0:GetTargetById(var_1_2):IsFinish()
				end
			end

			return var_12_1
		end,
		[IslandInteractionConditionUntil.SHOW_TYPE_ACTIVITY] = function()
			return getProxy(ActivityProxy):IsActivityNotEnd(var_1_1)
		end
	}, function()
		assert(false, "非法显示条件类型:" .. var_1_0)

		return
	end)
end

return IslandInteractionConditionUntil
