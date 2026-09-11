local RaceTrialBattleItem_3_8 = class("RaceTrialBattleItem_3_8", RaceTrialBattleItem)

function RaceTrialBattleItem_3_8:InitUI()
	self:BindCfgUI()

	self.stateController = self.controllers_:GetController("state")
end

function RaceTrialBattleItem_3_8:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_3_0, var_3_1 = ActivityTools.GetActivityStatusWithTips(self.activityID)

		if var_3_0 ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
			if var_3_1 then
				ShowTips(var_3_1)
			end

			return
		end

		JumpTools.OpenPageByJump("/raceTrialReady", {
			activityID = self.activityID,
			mainActivityID = self.mainActivityID
		})
		RaceTrialData:SetBattleRedPointOn(false, self.activityID)
	end)
end

local var_0_1 = {
	Clear = 2,
	Lock = 0,
	NotClear = 1
}

function RaceTrialBattleItem_3_8:RefreshUI(arg_4_1, arg_4_2)
	self.mainActivityID = arg_4_2

	if self.activityID ~= arg_4_1 then
		self.ani_:Play("UI_stageItem_cx", 0, 0)
	end

	self.activityID = arg_4_1

	self:RefreshRace()

	local var_4_0, var_4_1 = ActivityTools.GetActivityStatusWithTips(arg_4_1)

	if var_4_0 ~= 1 then
		self:RefreshState(var_0_1.Lock, var_4_1 or "--")
	else
		self:RefreshScore()
	end

	if var_4_0 ~= 2 then
		self:StartTimer()
	end

	self:RefreshRedPoint()
end

function RaceTrialBattleItem_3_8:RefreshScore()
	local var_5_0 = (RaceTrialData:GetBattleData(self.activityID) or {}).point

	if not (RaceTrialData:GetBattleData(self.activityID) or {}).point then
		var_5_0 = 0
	end

	if var_5_0 > 0 then
		self:RefreshState(var_0_1.Clear, var_5_0)
	else
		self:RefreshState(var_0_1.NotClear)
	end
end

function RaceTrialBattleItem_3_8:StartTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		local var_7_0, var_7_1 = ActivityTools.GetActivityStatusWithTips(self.activityID)

		if var_7_0 == ActivityConst.ACTIVITY_STATE.OVER then
			self:RefreshState(var_0_1.Lock, var_7_1)
			self:StopTimer()
		elseif var_7_0 == ActivityConst.ACTIVITY_STATE.ACTIVING then
			self:RefreshScore()
		else
			self:RefreshState(var_0_1.Lock, var_7_1 or "--")
		end

		self:RefreshRedPoint()
	end, 0.99, -1)

	self.timer_:Start()
end

function RaceTrialBattleItem_3_8:RefreshRedPoint()
	manager.redPoint:SetRedPointIndependent(self.transform_, manager.redPoint:getTipValue(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self.mainActivityID, self.activityID)) > 0)
end

function RaceTrialBattleItem_3_8:RefreshRace()
	local var_9_0 = ActivityRaceTrialCfg[self.activityID].race

	self.name_.text = ActivityRaceTrialCfg[self.activityID].name

	for iter_9_0, iter_9_1 in ipairs(RaceEffectCfg.all) do
		local var_9_1 = self[string.format("raceBg%d_", iter_9_1)]

		if var_9_1 then
			SetActive(var_9_1, var_9_0 == iter_9_1)
		end
	end
end

function RaceTrialBattleItem_3_8:RefreshState(arg_10_1, arg_10_2)
	if arg_10_1 == var_0_1.Clear then
		self.stateController:SetSelectedState("clear")

		self.scoreText_.text = arg_10_2 or "--"
	elseif arg_10_1 == var_0_1.NotClear then
		self.stateController:SetSelectedState("notClear")
	else
		self.stateController:SetSelectedState("lock")

		self.lockMsg_.text = arg_10_2
	end
end

return RaceTrialBattleItem_3_8
