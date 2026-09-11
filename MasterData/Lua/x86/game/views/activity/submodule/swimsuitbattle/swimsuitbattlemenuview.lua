ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SwimsuitBattleMenuView = class("SwimsuitBattleMenuView", ActivityMainBasePanel)

function SwimsuitBattleMenuView:GetUIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitMenuUI"
end

function SwimsuitBattleMenuView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SwimsuitBattleMenuView:InitUI()
	self:BindCfgUI()

	self.waterController_ = self.waterControllerEx_:GetController("state")
	self.battleController_ = self.battleControllerEx_:GetController("state")
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list
end

function SwimsuitBattleMenuView:AddUIListener()
	self:AddBtnListener(self.waterBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.subActivityList_[3]) or not ActivityTools.ActivityOpenCheck((ActivitySummerWaterData:GetActivityID())) then
			return
		end

		JumpTools.OpenPageByJump("/summerWaterMain", {
			activity = self.subActivityList_[3]
		})
	end)
	self:AddBtnListener(self.swimBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.subActivityList_[1]) then
			return
		end

		JumpTools.OpenPageByJump("/swimsuitBattleMain", {
			activity = self.subActivityList_[1]
		})
	end)
	self:AddBtnListener(self.voteBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.subActivityList_[2]) then
			return
		end

		JumpTools.OpenPageByJump("/swimsuitBattleVote", {
			activity = self.subActivityList_[1]
		})

		if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET) == 1 and not SwimsuitBattleData:GetRedPointClickTag() then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET, 0)
			SwimsuitBattleData:SetRedPointClickTag()
		end
	end)
end

function SwimsuitBattleMenuView:Dispose()
	SwimsuitBattleMenuView.super.Dispose(self)
end

function SwimsuitBattleMenuView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SwimsuitBattleMenuView:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.swimBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[1]), self.subActivityList_[1]))
		manager.redPoint:bindUIandKey(self.voteBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[2]), self.subActivityList_[2]))
		manager.redPoint:bindUIandKey(self.waterBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[3]), self.subActivityList_[3]))
		self:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(self, self.OnVoteRoundInfoUpdate))
	else
		manager.redPoint:unbindUIandKey(self.swimBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[1]), self.subActivityList_[1]))
		manager.redPoint:unbindUIandKey(self.voteBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[2]), self.subActivityList_[2]))
		manager.redPoint:unbindUIandKey(self.waterBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.subActivityList_[3]), self.subActivityList_[3]))
		self:RemoveAllEventListener()
	end
end

function SwimsuitBattleMenuView:RefreshUI()
	SwimsuitBattleAction.RequireVoteRoundInfo(self.subActivityList_[2])
end

function SwimsuitBattleMenuView:OnVoteRoundInfoUpdate()
	self.voteRound_ = SwimsuitBattleData:GetCurVoteRound()

	if self.voteRound_ == 5 then
		self.voteRound_ = 4
	end

	self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(self.voteRound_)

	for iter_12_0 = 1, 3 do
		self["voteName" .. iter_12_0 .. "Text_"].text = HeroTools.GetHeroFullName(SwimsuitVoteHeroCfg[self.voteData_[iter_12_0].ID].hero_id)
		self["voteScore" .. iter_12_0 .. "Text_"].text = self.voteData_[iter_12_0].voteNum
	end

	local var_12_0, var_12_1, var_12_2 = SwimsuitBattleData:GetVoteTicketInfo(self.subActivityList_[1])
	local var_12_3 = ActivityData:GetActivityData(self.subActivityList_[1])

	if not var_12_3 then
		self.battleController_:SetSelectedState("lock")
	elseif manager.time:GetServerTime() < var_12_3.startTime then
		self.battleController_:SetSelectedState("lock")

		self.battleOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_3.startTime))
	elseif manager.time:GetServerTime() >= var_12_3.stopTime then
		self.battleController_:SetSelectedState("over")
	else
		self.battleController_:SetSelectedState("unlock")

		self.swimItemImg_.sprite = ItemTools.getItemSprite(var_12_0)
		self.swimItemNum_.text = var_12_1 .. "/" .. var_12_2
	end

	local var_12_4 = ActivityData:GetActivityData(self.subActivityList_[3])
	local var_12_5 = ActivitySummerWaterData:GetActivityID()
	local var_12_6

	if var_12_5 then
		var_12_6 = ActivityData:GetActivityData(var_12_5)
	end

	if not var_12_4 then
		self.waterController_:SetSelectedState("lock")
	elseif manager.time:GetServerTime() < var_12_4.startTime then
		self.waterController_:SetSelectedState("lock")

		self.waterOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_4.startTime))
	elseif manager.time:GetServerTime() >= var_12_4.stopTime then
		self.waterController_:SetSelectedState("over")
	elseif var_12_6 and manager.time:GetServerTime() < var_12_6.startTime then
		self.waterController_:SetSelectedState("lock")

		self.waterOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_6.startTime))
	else
		self.waterController_:SetSelectedState("unlock")

		self.waterItemNum_.text = ActivitySummerWaterData:GetTotalGainCurrenyNum() .. "/" .. ActivitySummerWaterData:GetCurrentScheduleCfg().voting_ticket_limit
		self.waterItemImg_.sprite = ItemTools.getItemSprite(var_12_0)
	end
end

function SwimsuitBattleMenuView:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
end

function SwimsuitBattleMenuView:UpdateData()
	self:RefreshUI()
end

return SwimsuitBattleMenuView
