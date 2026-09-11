ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local IdolCompetitionMenuView = class("IdolCompetitionMenuView", ActivityMainBasePanel)

function IdolCompetitionMenuView:GetUIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionEntranceUI"
end

function IdolCompetitionMenuView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionMenuView:InitUI()
	self:BindCfgUI()

	self.raceTime_ = nil
	self.raceTimeCurShow_ = true
	self.timeShowController_ = self.mainControllerEx_:GetController("timeShow")
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list
end

function IdolCompetitionMenuView:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			ShowTips("IDOL_COMPETITION_UNLOCK")

			return
		end

		DormMinigame.Launch("WT_RK", nil, "idolCompetitionMain")
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_6_0 = {
			content = GetTips("IDOL_COMPETITION_MAIN_DESC")
		}

		var_6_0.key = "IDOL_COMPETITION_MAIN_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_6_0)
	end)
end

function IdolCompetitionMenuView:Dispose()
	IdolCompetitionMenuView.super.Dispose(self)
end

function IdolCompetitionMenuView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function IdolCompetitionMenuView:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)

	if arg_9_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.mainBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	else
		manager.redPoint:unbindUIandKey(self.mainBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	end
end

function IdolCompetitionMenuView:RefreshUI()
	for iter_10_0 = 1, 2 do
		local var_10_0 = IdolCompetitionData:GetRacePhase(self.subActivityList_[iter_10_0])

		if var_10_0 and var_10_0 == 1 then
			self.raceTime_ = IdolCompetitionData:GetRaceRefreshTime(self.subActivityList_[iter_10_0])[1]
		end
	end

	self:RefreshTimeText()
end

function IdolCompetitionMenuView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end

	if self.raceTimeCurShow_ then
		if not self.raceTime_ or manager.time:GetServerTime() >= self.raceTime_ then
			self.raceTime_ = nil
			self.raceTimeCurShow_ = false

			self.timeShowController_:SetSelectedState("false")
		else
			self.signText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_, true) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end
	elseif self.raceTime_ and manager.time:GetServerTime() < self.raceTime_ then
		self.raceTimeCurShow_ = true

		self.timeShowController_:SetSelectedState("true")

		self.signText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_, true) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end
end

function IdolCompetitionMenuView:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
end

function IdolCompetitionMenuView:UpdateData()
	self:RefreshUI()
end

return IdolCompetitionMenuView
