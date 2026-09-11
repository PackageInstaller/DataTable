local SummerRaceUnlockBannerView = class("SummerRaceUnlockBannerView", ReduxView)
local var_0_1 = "UI_Activity_SummerRace_StageUnlockPopUI_cx"
local var_0_2 = 0.05
local var_0_3 = 0.2

local function var_0_4(arg_1_0)
	return arg_1_0 == SummerRaceConst.SOURCE_TYPE.CHALLENGE and "challenge" or "practice"
end

local function var_0_5(arg_2_0, arg_2_1)
	if arg_2_0 == nil or arg_2_0.runtimeAnimatorController == nil then
		return nil
	end

	local var_2_0 = arg_2_0.runtimeAnimatorController.animationClips

	if arg_2_0.runtimeAnimatorController.animationClips == nil then
		return nil
	end

	local var_2_1 = tostring(arg_2_1 or "")

	for iter_2_0 = 0, var_2_0.Length - 1 do
		if var_2_0[iter_2_0] ~= nil then
			if tostring(var_2_0[iter_2_0].name or "") == var_2_1 then
				return tonumber(var_2_0[iter_2_0].length)
			end
		end
	end

	return nil
end

local function var_0_6(arg_3_0)
	arg_3_0:StopAutoCloseTimer_()
	JumpTools.Back()
	arg_3_0:ScheduleFollowupUnlock_()
end

function SummerRaceUnlockBannerView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_StageUnlockPopUI"
end

function SummerRaceUnlockBannerView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceUnlockBannerView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()

	self.followupUnlockTimer_ = nil

	self:AddUIListener()
end

function SummerRaceUnlockBannerView:BindViewRuntime()
	self.modeController_ = self.controllerEx_:GetController("mode")
	self.unlockBannerAnimator_ = self.transform_:GetComponent(typeof(Animator))
end

function SummerRaceUnlockBannerView:OnEnter()
	self:RefreshView()
	self:StopAutoCloseTimer_()

	local var_8_0 = var_0_5(self.unlockBannerAnimator_, var_0_1)

	if var_8_0 ~= nil then
		local var_8_1 = var_8_0 + var_0_3 or nil
	end

	local var_8_2 = 0

	if self.unlockBannerAnimator_ ~= nil then
		self.unlockBannerAnimator_:Play(var_0_1, -1, 0)
		self.unlockBannerAnimator_:Update(0)
	end

	self.autoCloseTimer_ = Timer.New(function()
		var_8_2 = var_8_2 + var_0_2

		if self.unlockBannerAnimator_ == nil then
			var_0_6(self)

			return
		end

		local var_9_0 = self.unlockBannerAnimator_:GetCurrentAnimatorStateInfo(0)

		if var_9_0 ~= nil and var_9_0:IsName(var_0_1) and var_9_0.normalizedTime >= 1 or var_8_1 ~= nil and var_8_2 >= var_8_1 then
			var_0_6(self)
		end
	end, var_0_2, -1)

	self.autoCloseTimer_:Start()
end

function SummerRaceUnlockBannerView:OnExit()
	self:StopAutoCloseTimer_()
	self:StopFollowupUnlockTimer_()
end

function SummerRaceUnlockBannerView:AddUIListener()
	return
end

function SummerRaceUnlockBannerView:RefreshView()
	local var_12_1 = self.params_ ~= nil and type(self.params_.unlockBannerModel) == "table" and self.params_.unlockBannerModel or SummerRaceData:GetUnlockBannerModel((self.params_ ~= nil and self.params_.sourceType ~= nil or nil) and self.params_.sourceType)
	local var_12_2 = GetI18NText(var_12_1.title)

	self.practiceText_.text = var_12_2
	self.challengeText_.text = var_12_2

	self.modeController_:SetSelectedState(var_0_4(var_12_1.sourceType))
end

function SummerRaceUnlockBannerView:StopAutoCloseTimer_()
	if self.autoCloseTimer_ then
		self.autoCloseTimer_:Stop()

		self.autoCloseTimer_ = nil
	end
end

function SummerRaceUnlockBannerView:ScheduleFollowupUnlock_()
	self:StopFollowupUnlockTimer_()

	self.followupUnlockTimer_ = Timer.New(function()
		self:StopFollowupUnlockTimer_()
		SummerRaceAction.TryContinuePendingUnlockFlow()
	end, 0.05, 1)

	self.followupUnlockTimer_:Start()
end

function SummerRaceUnlockBannerView:StopFollowupUnlockTimer_()
	if self.followupUnlockTimer_ then
		self.followupUnlockTimer_:Stop()

		self.followupUnlockTimer_ = nil
	end
end

function SummerRaceUnlockBannerView:Dispose()
	self:StopAutoCloseTimer_()
	self:StopFollowupUnlockTimer_()
	SummerRaceUnlockBannerView.super.Dispose(self)
end

return SummerRaceUnlockBannerView
