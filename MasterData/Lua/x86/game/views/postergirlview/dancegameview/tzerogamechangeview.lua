local TZeroGameChangeView = class("TZeroGameChangeView", BaseView)
local TZeroGameChangeReduxView = class("TZeroGameChangeReduxView", ReduxView)
local var_0_2 = {}
local var_0_3 = "102003_GameInterludeUI"

function var_0_2:OnAnimationUpdate()
	local var_1_0 = self.animator:GetCurrentAnimatorStateInfo(0)

	if var_1_0:IsName(var_0_3) then
		if var_1_0.normalizedTime >= 1 then
			var_0_2.OnFinish(self)
			var_0_2.StopAnimationUpdate(self)
		elseif var_1_0.normalizedTime >= 0.2962962962962963 then
			var_0_2.OnScreenFullyBlocked(self)
		end
	end
end

function var_0_2:StopAnimationUpdate()
	if self.time then
		self.time:Stop()

		self.time = nil
	end
end

function var_0_2:StartAnimationUpdate()
	var_0_2.StopAnimationUpdate(self)

	self.time = FrameTimer.New(function()
		var_0_2.OnAnimationUpdate(self)
	end, 1, -1)

	self.time:Start()
end

function var_0_2:OnScreenFullyBlocked()
	if self.onScreenFullyBlockedCallback then
		self.onScreenFullyBlockedCallback = nil

		self.onScreenFullyBlockedCallback()
	end
end

function var_0_2:OnFinish()
	self.onFinishCallback = nil

	;(self.onFinishCallback or JumpTools.Back)()
end

function var_0_2:IsSchedulingUpdate()
	return self.time ~= nil
end

function TZeroGameChangeReduxView:UIName()
	return "Widget/System/Main_T0SceneGame/102003/102003_GameInterludeUI"
end

function TZeroGameChangeReduxView:UIParent()
	return manager.ui.uiPop.transform
end

function TZeroGameChangeReduxView:Init()
	TZeroGameChangeView.Init(self)
end

function TZeroGameChangeReduxView:OnEnter()
	self.onScreenFullyBlockedCallback = self.params_.onScreenFullyBlocked
	self.onFinishCallback = self.params_.onFinish

	TZeroGameChangeView.OnEnter(self)
end

function TZeroGameChangeReduxView:OnTop()
	return
end

function TZeroGameChangeReduxView:OnExit()
	TZeroGameChangeView.OnExit(self)
end

function TZeroGameChangeReduxView:Dispose()
	TZeroGameChangeReduxView.super.Dispose(self)
	self:RemoveAllEventListener()
end

function TZeroGameChangeView:Ctor(arg_15_1)
	TZeroGameChangeView.super.Ctor(self, arg_15_1)

	self.gameObject_ = arg_15_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TZeroGameChangeView:Init()
	self:BindCfgUI()

	self.animator = self.gameinterludeuiAni_
	self.colorControlller = self.gameinterludeuiControllerexcollection_:GetController("type")
end

function TZeroGameChangeView:OnEnter()
	self.gameObject_:SetActive(true)
	self.animator:Play("clipName", 0, 0)
	var_0_2.StartAnimationUpdate(self)
end

function TZeroGameChangeView:StartCutscene(arg_18_1, arg_18_2, arg_18_3)
	self.onScreenFullyBlockedCallback = arg_18_1

	function self.onFinishCallback()
		if arg_18_2 then
			arg_18_2()
		end

		var_0_2.StopAnimationUpdate(self)

		if not arg_18_3 then
			self.gameObject_:SetActive(false)
		end
	end

	self.gameObject_:SetActive(true)
	self.animator:Play("clipName", 0, 0)
	var_0_2.StartAnimationUpdate(self)
end

function TZeroGameChangeView:OnExit()
	var_0_2.StopAnimationUpdate(self)
	self.gameObject_:SetActive(false)
end

function TZeroGameChangeView:Dispose()
	TZeroGameChangeView.super.Dispose(self)
	self:RemoveAllEventListener()
end

function TZeroGameChangeView:GetPlayBackwardsAnimator(arg_22_1, arg_22_2)
	if gameContext:IsOpenRoute("login") then
		return {}, arg_22_1
	end

	return {
		{
			self.animator,
			var_0_3,
			false
		}
	}, function()
		manager.windowBar:HideBar()

		if arg_22_2 then
			arg_22_2()
		end

		self:StartCutscene(arg_22_1, function()
			var_0_2.StopAnimationUpdate(self)
		end, true)
	end
end

function TZeroGameChangeView:IsDuringCutscene()
	return var_0_2.IsSchedulingUpdate(self)
end

TZeroGameChangeReduxView.BaseView = TZeroGameChangeView

return TZeroGameChangeReduxView
