local SwimsuitBattleVoteView = class("SwimsuitBattleVoteView", ReduxView)

function SwimsuitBattleVoteView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVoteUI"
end

function SwimsuitBattleVoteView:UIParent()
	return manager.ui.uiMain.transform
end

function SwimsuitBattleVoteView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SwimsuitBattleVoteView:InitUI()
	self:BindCfgUI()

	self.voteActivityID_ = 0
	self.voteRound_ = nil
	self.voteData_ = {}
	self.startTime_ = nil
	self.stopTime_ = nil
	self.rankTabItemList_ = {}
	self.rankBtnList_ = {}
	self.rankImgList_ = {}

	for iter_4_0 = 1, 7 do
		self.rankTabItemList_[iter_4_0] = SwimsuitBattleVoteRankItem.New(self["rank" .. iter_4_0 .. "Go_"])
		self.rankBtnList_[iter_4_0] = self["rank" .. iter_4_0 .. "Btn_"]
		self.rankImgList_[iter_4_0] = self["rank" .. iter_4_0 .. "Img_"]
	end

	self.stageController_ = self.mainControllerEx_:GetController("voteStage")
end

function SwimsuitBattleVoteView:AddUIListeners()
	for iter_5_0 = 1, 7 do
		self:AddBtnListener(self.rankBtnList_[iter_5_0], nil, function()
			local var_6_0

			if not SwimsuitBattleData:CheckInRoundTime() then
				do return end

				var_6_0 = {
					voteActivity = self.voteActivityID_
				}
			end

			var_6_0.item = SwimsuitBattleInfoCfg[self.params_.activity].voting_ticket_id
			var_6_0.id = self.voteData_[iter_5_0].ID
			var_6_0.vote = self.voteData_[iter_5_0].voteNum
			var_6_0.rank = iter_5_0

			JumpTools.OpenPageByJump("swimsuitBattleVotePop", var_6_0)
		end)
	end

	self:AddBtnListener(self.roundBtn_, nil, function()
		JumpTools.OpenPageByJump("/swimsuitBattleVoteRound")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("swimsuitVoteQuestPop")
	end)
end

function SwimsuitBattleVoteView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		SwimsuitBattleInfoCfg[self.params_.activity].voting_ticket_id
	})
	manager.windowBar:SetBarCanAdd(SwimsuitBattleInfoCfg[self.params_.activity].voting_ticket_id, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_VOTE")

	self.voteActivityID_ = SwimsuitBattleInfoCfg[self.params_.activity].vote_activity_id

	SwimsuitBattleAction.RequireVoteRoundInfo(self.voteActivityID_)

	local var_9_0 = ActivityData:GetActivityData(self.voteActivityID_)

	self.startTime_ = var_9_0.startTime
	self.stopTime_ = var_9_0.stopTime

	self:AddTimer()
	self:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(self, self.OnVoteRoundInfoUpdate))
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD)
end

function SwimsuitBattleVoteView:UpdateView()
	self.voteRound_ = SwimsuitBattleData:GetCurVoteRound()

	if self.voteRound_ == 5 then
		self.voteRound_ = 4
	end

	self.stageController_:SetSelectedState(tostring(self.voteRound_))

	self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(self.voteRound_)

	for iter_10_0 = 1, #self.voteData_ do
		if iter_10_0 > 7 then
			break
		end

		self.rankTabItemList_[iter_10_0]:SetData(self.voteData_[iter_10_0].ID, self.voteData_[iter_10_0].voteNum)

		self.rankImgList_[iter_10_0].spriteAsync = "TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[self.voteData_[iter_10_0].ID].show_image
	end
end

function SwimsuitBattleVoteView:CheckResultPop()
	if (getData("SwimsuitBattle", "lastVoteRound") or 0) < self.voteRound_ then
		saveData("SwimsuitBattle", "lastVoteRound", self.voteRound_)
		JumpTools.OpenPageByJump("swimsuitBattleResult")
	end
end

function SwimsuitBattleVoteView:AddTimer()
	self:StopTimer()

	self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end, 1, -1)

	self.timer_:Start()
end

function SwimsuitBattleVoteView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SwimsuitBattleVoteView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD)
end

function SwimsuitBattleVoteView:OnVoteRoundInfoUpdate()
	self:UpdateView()
	self:CheckResultPop()
end

function SwimsuitBattleVoteView:Dispose()
	self:RemoveAllListeners()

	for iter_17_0 = 1, 7 do
		if self.rankTabItemList_[iter_17_0] then
			self.rankTabItemList_[iter_17_0]:Dispose()

			self.rankTabItemList_[iter_17_0] = nil
		end
	end

	SwimsuitBattleVoteView.super.Dispose(self)
end

return SwimsuitBattleVoteView
