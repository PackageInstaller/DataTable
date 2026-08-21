local var_0_0 = class("SwimsuitBattleVoteRoundItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.roundIndex_ = 0
	arg_2_0.curRoundIndex_ = 0
	arg_2_0.voteData_ = {}
	arg_2_0.winerData_ = {}
	arg_2_0.voteHeadItem_ = {}

	for iter_2_0 = 1, 8 do
		if arg_2_0["vote" .. iter_2_0 .. "Go_"] then
			arg_2_0.voteHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(arg_2_0["vote" .. iter_2_0 .. "Go_"])
		end
	end

	arg_2_0.roundController_ = arg_2_0.roundControllerEx_:GetController("round")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.roundIndex_ = arg_3_1
	arg_3_0.curRoundIndex_ = SwimsuitBattleData:GetCurVoteRound()

	local var_3_0 = SwimsuitBattleData:GetRoundTimerData(arg_3_0.roundIndex_)
	local var_3_1 = manager.time:STimeDescS(var_3_0.startTime, "!%m/%d %H:%M")
	local var_3_2 = manager.time:STimeDescS(var_3_0.endTime, "!%m/%d %H:%M")

	arg_3_0.timeText_.text = var_3_1 .. "-" .. var_3_2

	if arg_3_0.roundIndex_ > arg_3_0.curRoundIndex_ then
		arg_3_0.roundController_:SetSelectedState("coming")

		arg_3_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.voteHeadItem_) do
			if arg_3_0.voteData_[iter_3_0] then
				iter_3_1:SetData(arg_3_0.voteData_[iter_3_0].ID)
			else
				iter_3_1:SetData()
			end
		end
	elseif arg_3_0.roundIndex_ == arg_3_0.curRoundIndex_ then
		if manager.time:GetServerTime() > var_3_0.endTime then
			arg_3_0.roundController_:SetSelectedState("settlement")
		else
			arg_3_0.roundController_:SetSelectedState("voting")
		end

		arg_3_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_2, iter_3_3 in ipairs(arg_3_0.voteHeadItem_) do
			if arg_3_0.voteData_[iter_3_2] then
				iter_3_3:SetData(arg_3_0.voteData_[iter_3_2].ID)
			else
				iter_3_3:SetData()
			end
		end
	elseif arg_3_0.roundIndex_ < arg_3_0.curRoundIndex_ then
		arg_3_0.roundController_:SetSelectedState("done")

		arg_3_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)
		arg_3_0.winerData_ = SwimsuitBattleData:GetWinerMapByRound(arg_3_1)

		for iter_3_4, iter_3_5 in ipairs(arg_3_0.voteHeadItem_) do
			local var_3_3 = arg_3_0.winerData_[arg_3_0.voteData_[iter_3_4].ID]

			if arg_3_0.voteData_[iter_3_4] then
				iter_3_5:SetData(arg_3_0.voteData_[iter_3_4].ID, var_3_3)
			else
				iter_3_5:SetData()
			end
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0 = 1, 8 do
		if arg_4_0.voteHeadItem_[iter_4_0] then
			arg_4_0.voteHeadItem_[iter_4_0]:Dispose()

			arg_4_0.voteHeadItem_[iter_4_0] = nil
		end
	end
end

return var_0_0
