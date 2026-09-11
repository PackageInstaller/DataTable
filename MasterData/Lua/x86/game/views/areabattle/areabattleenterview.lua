local AreaBattleEnterView = class("AreaBattleEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AreaBattleEnterView:GetUIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.activityID_) .. "NormalfightingEnterUI"
end

function AreaBattleEnterView:Init()
	self:InitUI()
	self:AddUIListener()

	if self.btnControllerEx_ then
		self.lockController = self.btnControllerEx_:GetController("statelock01")
	end
end

function AreaBattleEnterView:InitUI()
	self:BindCfgUI()
end

function AreaBattleEnterView:OnEnter()
	local var_4_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_4_0.startTime
	self.stopTime_ = var_4_0.stopTime
	self.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_NAME")

	self:AddTimer()

	self.descTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_DESC_TIPS")
	self.btnNameTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_BEGIN_BUTTON")

	self:BindRedPoint()
end

function AreaBattleEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
end

function AreaBattleEnterView:RefreshAcvanceStatus(arg_6_1)
	if self.lockController then
		self.lockController:SetSelectedState(arg_6_1 and "normal01" or "lock01")
	end
end

function AreaBattleEnterView:RefreshTimeText()
	if self.timeText_ then
		if not self:isHasLeftTimeDes() then
			local var_7_0, var_7_1 = self:CheckAdvanceOpenTime()

			self.timeText_.text = var_7_1

			self:RefreshAcvanceStatus(not var_7_0)
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		end
	end
end

function AreaBattleEnterView:OnExit()
	AreaBattleEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.INVITE_MAIN)
	self:UnbindRedPoint()
end

function AreaBattleEnterView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
end

function AreaBattleEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/AreaBattleAreaView", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AREA_BATTLE_DESCRIBE")
		})
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_13_0, var_13_1 = self:CheckAdvanceOpenTime()

		manager.tips:ShowTips(var_13_1)
	end)
end

return AreaBattleEnterView
