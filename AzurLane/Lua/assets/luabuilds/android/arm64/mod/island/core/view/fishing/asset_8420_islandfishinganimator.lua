class = var_0_10000

local var_0_0 = var_0_10000("IslandFishingAnimator")

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

local var_0_1 = 1
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.player = arg_1_1
	arg_1_0.state = var_0_0.STATE_MOVEMENT
	arg_1_0.hooked4LoopMaxCnt = 1
	arg_1_0.hooked4LoopCnt = 0
	Animator = var_2

	local var_1_0 = var_2.StringToHash("UpperBase." .. var_0_0.STATE_THROW)
	local var_1_1 = arg_1_0.player._animator

	var_3.GetBehaviours(var_1_1, var_1_0, 0)[0].StateEnterFixComplete = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.OnStateEnterFixComplete(var_2_0, arg_2_0, arg_2_1)

		return
	end

	return
end

function var_0_0.SetFishRod(arg_3_0, arg_3_1)
	arg_3_0.fishRodAnimator = arg_3_1
	pg = var_1_10002

	local var_3_0 = var_1_10002.ViewUtils.SetLayer
	local var_3_1 = arg_3_0.fishRodAnimator.gameObject.transform

	Layer = var_1_10005

	var_3_0(var_3_1, var_1_10005.UIHidden)

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

	pg = var_3

	local var_5_0 = var_3.ViewUtils.SetLayer
	local var_5_1 = arg_5_0.fishRodAnimator.gameObject.transform

	Layer = var_1_10006

	var_5_0(var_5_1, var_1_10006.Default)

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

	local var_8_0 = arg_8_0.player

	var_4.PlayAnimation(var_8_0, arg_8_1, arg_8_2, function()
		local var_9_0 = arg_8_0

		var_0.OnStateFinish(var_9_0, arg_8_1, arg_8_2, arg_8_3)

		return
	end)

	if arg_8_0.fishRodAnimator then
		string = var_4

		local var_8_1 = var_4.gsub(arg_8_1, "fish_sub_state.", "")

		Animator = var_1_10005

		local var_8_2 = var_1_10005.StringToHash(var_8_1)
		local var_8_3 = arg_8_0.fishRodAnimator

		var_6.CrossFadeInFixedTime(var_8_3, var_8_2, arg_8_2, 0)
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
	Animator = var_1_10001

	local var_11_0 = var_1_10001.StringToHash("UpperBase." .. var_0_0.STATE_THROW)
	local var_11_1 = arg_11_0.player._animator

	var_2.GetBehaviours(var_11_1, var_11_0, 0)[0].StateEnterFixComplete = nil
	arg_11_0.fishRodAnimator = nil

	return
end

return var_0_0
