local SummerRaceCutScenesPopView = class("SummerRaceCutScenesPopView", ReduxView)
local var_0_1 = "UI_Activity_OsirisHorus_CutScenesPopUI_xs"
local var_0_2 = "UI_Activity_OsirisHorus_CutScenesPopUI_cx"
local var_0_3 = 0.033

function SummerRaceCutScenesPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_CutScenesPopUI"
end

function SummerRaceCutScenesPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceCutScenesPopView:Init()
	self:BindCfgUI()
end

function SummerRaceCutScenesPopView:OnExitInput()
	return true
end

function SummerRaceCutScenesPopView:BackAndFinish(arg_5_1)
	self:Back()

	if arg_5_1 == nil then
		return
	end

	if self.isExited_ == true then
		arg_5_1()

		return
	end

	GlobalCall.register("AfterGo", function()
		JumpTools.RefreshGaussianBg()
		arg_5_1()
	end)
end

function SummerRaceCutScenesPopView:OnEnter()
	self.isExited_ = false

	if self.params_ then
		self.mode_ = self.params_.mode or "enter"
	end

	if self.params_ then
		self.finishCb_ = self.params_.finishCb or nil
	end

	if self.mode_ == "exit" then
		self:PlayExitAnimation()
	else
		self:PlayEnterAnimation()
	end
end

function SummerRaceCutScenesPopView:PlayEnterAnimation()
	if self.isExited_ then
		return
	end

	self:StopAnimTimer()

	self.enterAnimStarted_ = nil

	self.animator_:Play(var_0_1, 0, 0)
	self.animator_:Update(0)

	self.animTimer_ = Timer.New(function()
		self:CheckEnterAnimationFinished()
	end, var_0_3, -1)

	self.animTimer_:Start()
end

function SummerRaceCutScenesPopView:CheckEnterAnimationFinished()
	if self.isExited_ then
		self:StopAnimTimer()

		return
	end

	local var_10_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

	if var_10_0 == nil or var_10_0:IsName(var_0_1) ~= true then
		return
	end

	self.enterAnimStarted_ = true

	if var_10_0.normalizedTime < 1 then
		return
	end

	self:StopAnimTimer()

	self.enterAnimStarted_ = nil
	self.finishCb_ = nil

	self:BackAndFinish(self.finishCb_)
end

function SummerRaceCutScenesPopView:PlayExitAnimation()
	if self.isExited_ then
		return
	end

	self:StopAnimTimer()

	self.exitAnimStarted_ = nil

	self.animator_:Play(var_0_2, 0, 0)
	self.animator_:Update(0)

	self.animTimer_ = Timer.New(function()
		self:CheckExitAnimationFinished()
	end, var_0_3, -1)

	self.animTimer_:Start()
end

function SummerRaceCutScenesPopView:CheckExitAnimationFinished()
	if self.isExited_ then
		self:StopAnimTimer()

		return
	end

	local var_13_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

	if var_13_0 == nil or var_13_0:IsName(var_0_2) ~= true then
		return
	end

	self.exitAnimStarted_ = true

	if var_13_0.normalizedTime < 1 then
		return
	end

	self:StopAnimTimer()

	self.exitAnimStarted_ = nil
	self.finishCb_ = nil

	self:BackAndFinish(self.finishCb_)
end

function SummerRaceCutScenesPopView:StopAnimTimer()
	if self.animTimer_ ~= nil then
		self.animTimer_:Stop()

		self.animTimer_ = nil
	end
end

function SummerRaceCutScenesPopView:OnExit()
	self.isExited_ = true
	self.mode_ = nil
	self.finishCb_ = nil
	self.enterAnimStarted_ = nil
	self.exitAnimStarted_ = nil

	self:StopAnimTimer()
	AnimatorTools.Stop()
end

function SummerRaceCutScenesPopView:Dispose()
	self:StopAnimTimer()
	AnimatorTools.Stop()
	SummerRaceCutScenesPopView.super.Dispose(self)
end

return SummerRaceCutScenesPopView
