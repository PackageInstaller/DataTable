local RaceTrialBattleItem = class("RaceTrialBattleItem", ReduxView)

function RaceTrialBattleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RaceTrialBattleItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialBattleItem:InitUI()
	self:BindCfgUI()

	self.raceCon_ = ControllerUtil.GetController(self.transform_, "race")
	self.viewCon_ = ControllerUtil.GetController(self.transform_, "view")
end

function RaceTrialBattleItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if manager.time:GetServerTime() < self.openTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), self:GetTimeText(self.openTime_ - manager.time:GetServerTime())))

			return
		end

		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/raceTrialReady", {
			activityID = self.activityID_,
			mainActivityID = self.mainActivityID_
		})
		RaceTrialData:SetBattleRedPointOn(false, self.activityID_)
	end)
end

function RaceTrialBattleItem:OnEnter()
	return
end

function RaceTrialBattleItem:RefreshUI(arg_7_1, arg_7_2)
	self.activityID_ = arg_7_1
	self.cfg_ = ActivityRaceTrialCfg[self.activityID_]
	self.data_ = RaceTrialData:GetBattleData(self.activityID_) or {}
	self.mainActivityID_ = arg_7_2

	local var_7_0 = ActivityData:GetActivityData(self.activityID_)

	self.openTime_ = var_7_0.startTime
	self.endTime_ = var_7_0.stopTime

	if self.nameText_ then
		self.nameText_.text = GetI18NText(self.cfg_.name)
	end

	local var_7_1 = manager.time:GetServerTime()

	if var_7_1 >= self.openTime_ and var_7_1 < self.endTime_ then
		self:RefreshOpen()
	else
		self:RefreshClose()
	end

	self:RefreshRedPoint()
	self:RefreshRace()
end

function RaceTrialBattleItem:RefreshRedPoint()
	if manager.redPoint:getTipValue(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self.mainActivityID_, self.activityID_)) > 0 then
		SetActive(self.redGo_, true)
	else
		SetActive(self.redGo_, false)
	end
end

function RaceTrialBattleItem:RefreshRace()
	if self.raceCon_ then
		self.raceCon_:SetSelectedState(tostring(self.cfg_.race))
	end

	self.raceIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/OsirisUI/RaceTrial/" .. self.cfg_.race)
end

function RaceTrialBattleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RaceTrialBattleItem:StartTimer()
	self:StopTimer()

	if self.endTime_ <= manager.time:GetServerTime() then
		self.timeCntText_.text = GetTips("TIME_OVER")

		return
	end

	local var_11_0 = self.openTime_ - manager.time:GetServerTime()

	self.timeCntText_.text = string.format(GetTips("OPEN_TIME"), self:GetTimeText(var_11_0))

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.lockRect_)

	self.timer_ = Timer.New(function()
		var_11_0 = self.openTime_ - manager.time:GetServerTime()

		if var_11_0 <= 0 then
			self.timer_:Stop()

			self.timer_ = nil

			self:RefreshUI(self.activityID_, self.mainActivityID_)
		end

		self.timeCntText_.text = string.format(GetTips("OPEN_TIME"), self:GetTimeText(var_11_0))
	end, 1, -1)

	self.timer_:Start()
end

function RaceTrialBattleItem:RefreshOpen()
	if self.data_.point > 0 then
		self.viewCon_:SetSelectedState("open")

		self.scoreText_.text = self.data_.point
	else
		self.viewCon_:SetSelectedState("none")
	end
end

function RaceTrialBattleItem:RefreshClose()
	self.viewCon_:SetSelectedState("close")
	self:StartTimer()
end

function RaceTrialBattleItem:GetTimeText(arg_15_1)
	return arg_15_1 / 86400 >= 1 and math.ceil(arg_15_1 / 86400) .. GetTips("DAY") or arg_15_1 / 3600 >= 1 and math.ceil(arg_15_1 / 3600) .. GetTips("HOUR") or arg_15_1 / 60 >= 1 and math.ceil(arg_15_1 / 60) .. GetTips("MINUTE") or 1 .. GetTips("MINUTE")
end

function RaceTrialBattleItem:OnExit()
	self:StopTimer()
end

function RaceTrialBattleItem:Dispose()
	self:StopTimer()
	self:RemoveAllListeners()
	RaceTrialBattleItem.super.Dispose(self)
end

return RaceTrialBattleItem
