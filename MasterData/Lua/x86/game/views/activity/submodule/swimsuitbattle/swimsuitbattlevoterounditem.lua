local SwimsuitBattleVoteRoundItem = class("SwimsuitBattleVoteRoundItem", ReduxView)

function SwimsuitBattleVoteRoundItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SwimsuitBattleVoteRoundItem:InitUI()
	self:BindCfgUI()

	self.roundIndex_ = 0
	self.curRoundIndex_ = 0
	self.voteData_ = {}
	self.winerData_ = {}
	self.voteHeadItem_ = {}

	for iter_2_0 = 1, 8 do
		if self["vote" .. iter_2_0 .. "Go_"] then
			self.voteHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(self["vote" .. iter_2_0 .. "Go_"])
		end
	end

	self.roundController_ = self.roundControllerEx_:GetController("round")
end

function SwimsuitBattleVoteRoundItem:SetData(arg_3_1)
	self.roundIndex_ = arg_3_1
	self.curRoundIndex_ = SwimsuitBattleData:GetCurVoteRound()

	local var_3_0 = SwimsuitBattleData:GetRoundTimerData(self.roundIndex_)

	self.timeText_.text = manager.time:STimeDescS(var_3_0.startTime, "!%m/%d %H:%M") .. "-" .. manager.time:STimeDescS(var_3_0.endTime, "!%m/%d %H:%M")

	if self.roundIndex_ > self.curRoundIndex_ then
		self.roundController_:SetSelectedState("coming")

		self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(self.voteHeadItem_) do
			if self.voteData_[iter_3_0] then
				iter_3_1:SetData(self.voteData_[iter_3_0].ID)
			else
				iter_3_1:SetData()
			end
		end
	elseif self.roundIndex_ == self.curRoundIndex_ then
		if manager.time:GetServerTime() > var_3_0.endTime then
			self.roundController_:SetSelectedState("settlement")
		else
			self.roundController_:SetSelectedState("voting")
		end

		self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_2, iter_3_3 in ipairs(self.voteHeadItem_) do
			if self.voteData_[iter_3_2] then
				iter_3_3:SetData(self.voteData_[iter_3_2].ID)
			else
				iter_3_3:SetData()
			end
		end
	elseif self.roundIndex_ < self.curRoundIndex_ then
		self.roundController_:SetSelectedState("done")

		self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)
		self.winerData_ = SwimsuitBattleData:GetWinerMapByRound(arg_3_1)

		for iter_3_4, iter_3_5 in ipairs(self.voteHeadItem_) do
			if self.voteData_[iter_3_4] then
				iter_3_5:SetData(self.voteData_[iter_3_4].ID, self.winerData_[self.voteData_[iter_3_4].ID])
			else
				iter_3_5:SetData()
			end
		end
	end
end

function SwimsuitBattleVoteRoundItem:Dispose()
	SwimsuitBattleVoteRoundItem.super.Dispose(self)

	for iter_4_0 = 1, 8 do
		if self.voteHeadItem_[iter_4_0] then
			self.voteHeadItem_[iter_4_0]:Dispose()

			self.voteHeadItem_[iter_4_0] = nil
		end
	end
end

return SwimsuitBattleVoteRoundItem
