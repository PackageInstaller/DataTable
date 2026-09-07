local IslandFishingAnimator = class("IslandFishingAnimator")

IslandFishingAnimator.STATE_MOVEMENT = "movement"
IslandFishingAnimator.STATE_THROW = "fish_sub_state.fishthrow"
IslandFishingAnimator.STATE_IDLE = "fish_sub_state.fishidle"
IslandFishingAnimator.STATE_HOOKED = "fish_sub_state.fishon"
IslandFishingAnimator.STATE_HOOKED_2_LOOP = "fish_sub_state.fishon_2loop"
IslandFishingAnimator.STATE_HOOKED_3 = "fish_sub_state.fishon_3"
IslandFishingAnimator.STATE_HOOKED_4_LOOP = "fish_sub_state.fishon_4loop"
IslandFishingAnimator.STATE_HOOKED_5 = "fish_sub_state.fishon_5"
IslandFishingAnimator.STATE_SUCCESS = "fish_sub_state.fishsucced"
IslandFishingAnimator.STATE_CANCEL = "fish_sub_state.fishcancel"
IslandFishingAnimator.STATE_FAIL = "fish_sub_state.fishfail"

function IslandFishingAnimator:Ctor(arg_1_1)
	self.player = arg_1_1
	self.state = IslandFishingAnimator.STATE_MOVEMENT
	self.hooked4LoopMaxCnt = 1
	self.hooked4LoopCnt = 0
	self.player._animator:GetBehaviours(Animator.StringToHash("UpperBase." .. IslandFishingAnimator.STATE_THROW), 0)[0].StateEnterFixComplete = function(arg_2_0, arg_2_1)
		self:OnStateEnterFixComplete(arg_2_0, arg_2_1)

		return
	end

	return
end

function IslandFishingAnimator:SetFishRod(arg_3_1)
	self.fishRodAnimator = arg_3_1

	pg.ViewUtils.SetLayer(self.fishRodAnimator.gameObject.transform, Layer.UIHidden)

	return
end

function IslandFishingAnimator:ClearFishRod()
	self.fishRodAnimator = nil

	return
end

function IslandFishingAnimator:OnStateEnterFixComplete(arg_5_1, arg_5_2)
	if not self.fishRodAnimator then
		return
	end

	pg.ViewUtils.SetLayer(self.fishRodAnimator.gameObject.transform, Layer.Default)

	return
end

function IslandFishingAnimator:Trigger(arg_6_1, arg_6_2, arg_6_3)
	if self.state == arg_6_1 then
		return
	end

	self.state = arg_6_1
	self.isLoopHooked = self:IsLoopHookedAction(arg_6_1)

	self:TriggerState(arg_6_1, arg_6_2, arg_6_3)

	return
end

function IslandFishingAnimator:IsLoopHookedAction(arg_7_1)
	if arg_7_1 == IslandFishingAnimator.STATE_HOOKED or arg_7_1 == IslandFishingAnimator.STATE_HOOKED_2_LOOP or arg_7_1 == IslandFishingAnimator.STATE_HOOKED_3 or arg_7_1 == IslandFishingAnimator.STATE_HOOKED_4_LOOP then
		return true
	end

	return false
end

function IslandFishingAnimator:TriggerState(arg_8_1, arg_8_2, arg_8_3)
	if self:IsLoopHookedAction(arg_8_1) and not self.isLoopHooked then
		return
	end

	self.player:PlayAnimation(arg_8_1, arg_8_2, function()
		self:OnStateFinish(arg_8_1, arg_8_2, arg_8_3)

		return
	end)

	if self.fishRodAnimator then
		self.fishRodAnimator:CrossFadeInFixedTime(Animator.StringToHash((string.gsub(arg_8_1, "fish_sub_state.", ""))), arg_8_2, 0)
	end

	return
end

function IslandFishingAnimator:OnStateFinish(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == IslandFishingAnimator.STATE_THROW then
		self:TriggerState(IslandFishingAnimator.STATE_IDLE, arg_10_2, arg_10_3)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == IslandFishingAnimator.STATE_IDLE then
		-- block empty
	elseif arg_10_1 == IslandFishingAnimator.STATE_HOOKED then
		self.isLoopHooked = true

		self:TriggerState(IslandFishingAnimator.STATE_HOOKED_2_LOOP, 0)
	elseif arg_10_1 == IslandFishingAnimator.STATE_HOOKED_2_LOOP then
		self:TriggerState(IslandFishingAnimator.STATE_HOOKED_2_LOOP, 0)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == IslandFishingAnimator.STATE_HOOKED_3 then
		self.isLoopHooked = true

		self:TriggerState(IslandFishingAnimator.STATE_HOOKED_4_LOOP, 0)
	elseif arg_10_1 == IslandFishingAnimator.STATE_HOOKED_4_LOOP then
		self:TriggerState(IslandFishingAnimator.STATE_HOOKED_4_LOOP, 0)
	elseif arg_10_1 == IslandFishingAnimator.STATE_HOOKED_5 then
		self:TriggerState(IslandFishingAnimator.STATE_SUCCESS, arg_10_2, arg_10_3)

		if arg_10_3 then
			arg_10_3()
		end
	elseif arg_10_1 == IslandFishingAnimator.STATE_SUCCESS then
		-- block empty
	elseif arg_10_1 == IslandFishingAnimator.STATE_CANCEL or arg_10_1 == IslandFishingAnimator.STATE_FAIL then
		self:TriggerState(IslandFishingAnimator.STATE_MOVEMENT, 0.25)

		if arg_10_3 then
			arg_10_3()
		end
	end

	return
end

function IslandFishingAnimator:Dispose()
	self.player._animator:GetBehaviours(Animator.StringToHash("UpperBase." .. IslandFishingAnimator.STATE_THROW), 0)[0].StateEnterFixComplete = nil
	self.fishRodAnimator = nil

	return
end

return IslandFishingAnimator
