local var_0_0 = class("IslandFishingAnimator")

var_0_0.STATE_MOVEMENT = "movement"
var_0_0.STATE_THROW = "fish_sub_state.fishthrow"
var_0_0.STATE_IDLE = "fish_sub_state.fishidle"
var_0_0.STATE_HOOKED = "fish_sub_state.fishon"
var_0_0.STATE_HOOKED_2_LOOP = "fish_sub_state.fishon_2loop"
var_0_0.STATE_HOOKED_3 = "fish_sub_state.fishon_3"
var_0_0.STATE_HOOKED_4_LOOP = "fish_sub_state.fishon_4loop"
var_0_0.STATE_HOOKED_5 = "fish_sub_state.fishon_5"
var_0_0.STATE_SUCCESS = "fish_sub_state.fishsucced"
var_0_0.STATE_CANCEL = "fish_sub_state.fishcancel"
var_0_0.STATE_FAIL = "fish_sub_state.fishfail"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.player = arg_1_1
	arg_1_0.state = var_0_0.STATE_MOVEMENT
	arg_1_0.hooked4LoopMaxCnt = 1
	arg_1_0.hooked4LoopCnt = 0
	arg_1_0.player._animator:GetBehaviours(Animator.StringToHash("UpperBase." .. var_0_0.STATE_THROW), 0)[0].StateEnterFixComplete = function(arg_2_0, arg_2_1)
		arg_1_0:OnStateEnterFixComplete(arg_2_0, arg_2_1)

		return
	end

	return
end

function var_0_0.SetFishRod(arg_3_0, arg_3_1)
	arg_3_0.fishRodAnimator = arg_3_1

	pg.ViewUtils.SetLayer(arg_3_0.fishRodAnimator.gameObject.transform, Layer.UIHidden)

	return
end

function var_0_0.ClearFishRod(arg_4_0)
	arg_4_0.fishRodAnimator = nil

	return
end

function var_0_0.OnStateEnterFixComplete(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.fishRodAnimator then
		return
	end

	pg.ViewUtils.SetLayer(arg_5_0.fishRodAnimator.gameObject.transform, Layer.Default)

	return
end

function var_0_0.Trigger(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.state == arg_6_1 then
		return
	end

	arg_6_0.state = arg_6_1
	arg_6_0.isLoopHooked = arg_6_0:IsLoopHookedAction(arg_6_1)

	arg_6_0:TriggerState(arg_6_1, arg_6_2, arg_6_3)

	return
end

function var_0_0.IsLoopHookedAction(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_0.STATE_HOOKED or arg_7_1 == var_0_0.STATE_HOOKED_2_LOOP or arg_7_1 == var_0_0.STATE_HOOKED_3 or arg_7_1 == var_0_0.STATE_HOOKED_4_LOOP then
		return true
	end

	return false
end

function var_0_0.TriggerState(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0:IsLoopHookedAction(arg_8_1) and not arg_8_0.isLoopHooked then
		return
	end

	arg_8_0.player:PlayAnimation(arg_8_1, arg_8_2, function()
		arg_8_0:OnStateFinish(arg_8_1, arg_8_2, arg_8_3)

		return
	end)

	if arg_8_0.fishRodAnimator then
		arg_8_0.fishRodAnimator:CrossFadeInFixedTime(Animator.StringToHash((string.gsub(arg_8_1, "fish_sub_state.", ""))), arg_8_2, 0)
	end

	return
end

function var_0_0.OnStateFinish(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == var_0_0.STATE_THROW then
		arg_10_0:TriggerState(var_0_0.STATE_IDLE, arg_10_2, arg_10_3)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == var_0_0.STATE_IDLE then
		-- block empty
	elseif arg_10_1 == var_0_0.STATE_HOOKED then
		arg_10_0.isLoopHooked = true

		arg_10_0:TriggerState(var_0_0.STATE_HOOKED_2_LOOP, 0)
	elseif arg_10_1 == var_0_0.STATE_HOOKED_2_LOOP then
		arg_10_0:TriggerState(var_0_0.STATE_HOOKED_2_LOOP, 0)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == var_0_0.STATE_HOOKED_3 then
		arg_10_0.isLoopHooked = true

		arg_10_0:TriggerState(var_0_0.STATE_HOOKED_4_LOOP, 0)
	elseif arg_10_1 == var_0_0.STATE_HOOKED_4_LOOP then
		arg_10_0:TriggerState(var_0_0.STATE_HOOKED_4_LOOP, 0)
	elseif arg_10_1 == var_0_0.STATE_HOOKED_5 then
		arg_10_0:TriggerState(var_0_0.STATE_SUCCESS, arg_10_2, arg_10_3)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == var_0_0.STATE_SUCCESS then
		-- block empty
	elseif arg_10_1 == var_0_0.STATE_CANCEL or arg_10_1 == var_0_0.STATE_FAIL then
		arg_10_0:TriggerState(var_0_0.STATE_MOVEMENT, 0.25)

		if arg_10_3 then
			arg_10_3()
		end
	end

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.player._animator:GetBehaviours(Animator.StringToHash("UpperBase." .. var_0_0.STATE_THROW), 0)[0].StateEnterFixComplete = nil
	arg_11_0.fishRodAnimator = nil

	return
end

return var_0_0
