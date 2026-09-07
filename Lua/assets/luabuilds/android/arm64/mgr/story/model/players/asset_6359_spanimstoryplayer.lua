local SpAnimStoryPlayer = class("SpAnimStoryPlayer", import(".StoryPlayer"))

function SpAnimStoryPlayer:OnReset(arg_1_1, arg_1_2, arg_1_3)
	setActive(self.spAnimPanel, true)

	local var_1_0 = pg.NewStoryMgr.GetInstance().skipBtn
	local var_1_1 = pg.NewStoryMgr.GetInstance().autoBtn
	local var_1_2 = pg.NewStoryMgr.GetInstance().recordBtn

	self.hideBtns = {}

	if isActive(var_1_0) and arg_1_1:ShouldHideSkipBtn() then
		setActive(var_1_0, false)
		table.insert(self.hideBtns, var_1_0)
	end

	if isActive(var_1_1) then
		setActive(var_1_1, false)
		table.insert(self.hideBtns, var_1_1)
	end

	if isActive(var_1_2) then
		setActive(var_1_2, false)
		table.insert(self.hideBtns, var_1_2)
	end

	arg_1_3()

	return
end

function SpAnimStoryPlayer:OnEnter(arg_2_1, arg_2_2, arg_2_3)
	seriesAsync({
		function(arg_3_0)
			self:GetSpine(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			self:PlaySpAnim(arg_2_1, arg_4_0)

			return
		end
	}, arg_2_3)

	return
end

function SpAnimStoryPlayer:GetSpine(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetSpineName()

	self.spineChar = SpineAnimChar.New()

	self.spineChar:SetPaint(var_5_0)
	self.spineChar:Load(true, function(arg_6_0)
		arg_6_0:SetParent(self.spAnimPanel)
		arg_6_0:SetLocalPosition(Vector3(0, 0, 0))
		arg_5_2()

		return
	end)

	self.prefab = var_5_0

	return
end

function SpAnimStoryPlayer:PlaySpAnim(arg_7_1, arg_7_2)
	self.spineChar:SetActionCallBack(nil)

	if arg_7_1:HasStopTime() then
		self:DelayCall(arg_7_1:GetStopTime(), arg_7_2)
	else
		self.spineChar:SetActionCallBack(function(arg_8_0)
			if arg_8_0 == "finish" then
				self.spineChar:SetActionCallBack(nil)
				arg_7_2()
			end

			return
		end)
	end

	self.spineChar:SetAction(arg_7_1:GetActionName(), 0)

	if arg_7_1:ShouldAdjustSpeed() then
		self:AdjustSpeed(arg_7_1:GetSpeed())
	end

	return
end

function SpAnimStoryPlayer:AdjustSpeed(arg_9_1)
	local var_9_0 = self:GetAnimationState()

	var_9_0.TimeScale = var_9_0.TimeScale * arg_9_1

	return
end

function SpAnimStoryPlayer:GetAnimationState()
	return self.spineChar:GetSkeletonGraphic().AnimationState
end

function SpAnimStoryPlayer:ReturnSpine()
	if self.spineChar == nil or self.prefab == nil then
		return
	end

	self:GetAnimationState().TimeScale = 1

	self.spineChar:Dispose()

	self.spineChar = nil
	self.prefab = nil

	return
end

function SpAnimStoryPlayer:ClearSp()
	self:ReturnSpine()

	for iter_12_0, iter_12_1 in pairs(self.hideBtns or {}) do
		setActive(iter_12_1, true)
	end

	self.hideBtns = {}

	return
end

function SpAnimStoryPlayer:OnWillExit(arg_13_1, arg_13_2, arg_13_3)
	self:ClearSp()
	arg_13_3()

	return
end

function SpAnimStoryPlayer:OnEnd()
	self:ClearSp()

	return
end

function SpAnimStoryPlayer:RegisetEvent(arg_15_1, arg_15_2)
	SpAnimStoryPlayer.super.RegisetEvent(self, arg_15_1, arg_15_2)
	triggerButton(self._go)

	return
end

return SpAnimStoryPlayer
