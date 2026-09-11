local KagutsuchiHomeView = class("KagutsuchiHomeView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function KagutsuchiHomeView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiUI"
end

function KagutsuchiHomeView:Ctor(arg_2_1, arg_2_2)
	KagutsuchiHomeView.super.Ctor(self, arg_2_1, self:GetActivityID())
end

function KagutsuchiHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function KagutsuchiHomeView:InitUI()
	self:BindCfgUI()
end

function KagutsuchiHomeView:AddUIListener()
	local var_5_0 = self:GetActivityID()
	local var_5_1 = ActivityTools.GetRedPointKey(var_5_0) .. var_5_0
	local var_5_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_5_1)
	local var_5_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_5_1)
	local var_5_4 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_HANAFUDA, var_5_1)

	self:AddBtnListener(self.rewardBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw1")

		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	self:AddBtnListener(self.workBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_2)
		JumpTools.OpenPageByJump("/kagutsuchiWork", {
			activityID = self:GetActivityID()
		})
	end)
	self:AddBtnListener(self.fishBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_3)
		DormMinigame.Launch("HZ07_diaoyu1")
	end)
	self:AddBtnListener(self.hanafudaBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_4)
		JumpTools.OpenPageByJump("/hanafudaGameView", {})
	end)
end

function KagutsuchiHomeView:OnEnter()
	KagutsuchiHomeView.super.OnEnter(self)
	self:RefreshUI()

	local var_10_0 = self:GetActivityID()
	local var_10_1 = ActivityTools.GetRedPointKey(var_10_0) .. var_10_0

	manager.redPoint:bindUIandKey(self.workBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_10_1)))
	manager.redPoint:bindUIandKey(self.hanafudaBtn_.transform, (string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, var_10_1)))
	manager.redPoint:bindUIandKey(self.fishBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_10_1)))
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, var_10_1)))
end

function KagutsuchiHomeView:OnExit()
	KagutsuchiHomeView.super.OnExit(self)

	local var_11_0 = self:GetActivityID()
	local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0

	manager.redPoint:unbindUIandKey(self.workBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_11_1)))
	manager.redPoint:unbindUIandKey(self.hanafudaBtn_.transform, (string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, var_11_1)))
	manager.redPoint:unbindUIandKey(self.fishBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_11_1)))
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, var_11_1)))
end

function KagutsuchiHomeView:GetActivityID()
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function KagutsuchiHomeView:RefreshUI()
	local var_13_0 = self:GetActivityID()
	local var_13_1 = ActivityData:GetActivityData(var_13_0)

	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)

	KagutsuchiWorkAction:UpdateRedPoint(var_13_0)
end

return KagutsuchiHomeView
