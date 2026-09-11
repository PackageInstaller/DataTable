local SwimsuitBattleVoteRoundFinalItem = class("SwimsuitBattleVoteRoundFinalItem", ReduxView)

function SwimsuitBattleVoteRoundFinalItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SwimsuitBattleVoteRoundFinalItem:InitUI()
	self:BindCfgUI()

	self.roundIndex_ = 0
	self.curRoundIndex_ = 0
	self.voteData_ = {}
	self.winerData_ = {}
	self.preHeadItem_ = {}
	self.voteHeadItem_ = {}
	self.winerHeadItem_ = {}

	for iter_2_0 = 1, 6 do
		if self["pre" .. iter_2_0 .. "Go_"] then
			self.preHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(self["pre" .. iter_2_0 .. "Go_"])
		end

		if self["vote" .. iter_2_0 .. "Go_"] then
			self.voteHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(self["vote" .. iter_2_0 .. "Go_"])
		end

		if self["win" .. iter_2_0 .. "Go_"] then
			self.winerHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(self["win" .. iter_2_0 .. "Go_"])
		end
	end

	self.finalController_ = self.mainControllerEx_:GetController("final")
	self.roundController_ = self.roundControllerEx_:GetController("round")
end

function SwimsuitBattleVoteRoundFinalItem:SetData(arg_3_1)
	self.roundIndex_ = arg_3_1
	self.curRoundIndex_ = SwimsuitBattleData:GetCurVoteRound()

	local var_3_0 = SwimsuitBattleData:GetRoundTimerData(self.roundIndex_)

	self.timeText_.text = manager.time:STimeDescS(var_3_0.startTime, "!%m/%d %H:%M") .. "-" .. manager.time:STimeDescS(var_3_0.endTime, "!%m/%d %H:%M")

	if self.roundIndex_ > self.curRoundIndex_ then
		self.finalController_:SetSelectedState("1")
		self.roundController_:SetSelectedState("coming")

		for iter_3_0 = 1, 3 do
			local var_3_1 = SwimsuitBattleData:GetWinerListByRound(iter_3_0)

			if var_3_1[1] then
				self.preHeadItem_[iter_3_0 * 2 - 1]:SetData(var_3_1[1].ID)
			else
				self.preHeadItem_[iter_3_0 * 2 - 1]:SetData()
			end

			if var_3_1[2] then
				self.preHeadItem_[iter_3_0 * 2]:SetData(var_3_1[2].ID)
			else
				self.preHeadItem_[iter_3_0 * 2]:SetData()
			end
		end
	elseif self.roundIndex_ == self.curRoundIndex_ then
		self.finalController_:SetSelectedState("2")

		if manager.time:GetServerTime() > var_3_0.endTime then
			self.roundController_:SetSelectedState("settlement")
		else
			self.roundController_:SetSelectedState("voting")
		end

		self.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_1, iter_3_2 in ipairs(self.voteHeadItem_) do
			if self.voteData_[iter_3_1] then
				iter_3_2:SetData(self.voteData_[iter_3_1].ID)
			else
				iter_3_2:SetData()
			end
		end
	elseif self.roundIndex_ < self.curRoundIndex_ then
		self.finalController_:SetSelectedState("3")
		self.roundController_:SetSelectedState("done")

		self.voteData_ = SwimsuitBattleData:GetWinerListByRound(arg_3_1)

		for iter_3_3, iter_3_4 in ipairs(self.winerHeadItem_) do
			if self.voteData_[iter_3_3] then
				iter_3_4:SetData(self.voteData_[iter_3_3].ID)
			else
				iter_3_4:SetData()
			end
		end
	end
end

function SwimsuitBattleVoteRoundFinalItem:Dispose()
	SwimsuitBattleVoteRoundFinalItem.super.Dispose(self)

	for iter_4_0 = 1, 6 do
		if self.preHeadItem_[iter_4_0] then
			self.preHeadItem_[iter_4_0]:Dispose()

			self.preHeadItem_[iter_4_0] = nil
		end

		if self.voteHeadItem_[iter_4_0] then
			self.voteHeadItem_[iter_4_0]:Dispose()

			self.voteHeadItem_[iter_4_0] = nil
		end

		if self.winerHeadItem_[iter_4_0] then
			self.winerHeadItem_[iter_4_0]:Dispose()

			self.winerHeadItem_[iter_4_0] = nil
		end
	end
end

return SwimsuitBattleVoteRoundFinalItem
