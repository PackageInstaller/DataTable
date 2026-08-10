local var_0_0 = class("SwimsuitBattleVoteRoundFinalItem", ReduxView)

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
	arg_2_0.preHeadItem_ = {}
	arg_2_0.voteHeadItem_ = {}
	arg_2_0.winerHeadItem_ = {}

	for iter_2_0 = 1, 6 do
		if arg_2_0["pre" .. iter_2_0 .. "Go_"] then
			arg_2_0.preHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(arg_2_0["pre" .. iter_2_0 .. "Go_"])
		end

		if arg_2_0["vote" .. iter_2_0 .. "Go_"] then
			arg_2_0.voteHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(arg_2_0["vote" .. iter_2_0 .. "Go_"])
		end

		if arg_2_0["win" .. iter_2_0 .. "Go_"] then
			arg_2_0.winerHeadItem_[iter_2_0] = SwimsuitBattleVoteRoundHead.New(arg_2_0["win" .. iter_2_0 .. "Go_"])
		end
	end

	arg_2_0.finalController_ = arg_2_0.mainControllerEx_:GetController("final")
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
		arg_3_0.finalController_:SetSelectedState("1")
		arg_3_0.roundController_:SetSelectedState("coming")

		for iter_3_0 = 1, 3 do
			local var_3_3 = SwimsuitBattleData:GetWinerListByRound(iter_3_0)

			if var_3_3[1] then
				arg_3_0.preHeadItem_[iter_3_0 * 2 - 1]:SetData(var_3_3[1].ID)
			else
				arg_3_0.preHeadItem_[iter_3_0 * 2 - 1]:SetData()
			end

			if var_3_3[2] then
				arg_3_0.preHeadItem_[iter_3_0 * 2]:SetData(var_3_3[2].ID)
			else
				arg_3_0.preHeadItem_[iter_3_0 * 2]:SetData()
			end
		end
	elseif arg_3_0.roundIndex_ == arg_3_0.curRoundIndex_ then
		arg_3_0.finalController_:SetSelectedState("2")

		if manager.time:GetServerTime() > var_3_0.endTime then
			arg_3_0.roundController_:SetSelectedState("settlement")
		else
			arg_3_0.roundController_:SetSelectedState("voting")
		end

		arg_3_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsDataByID(arg_3_1)

		for iter_3_1, iter_3_2 in ipairs(arg_3_0.voteHeadItem_) do
			if arg_3_0.voteData_[iter_3_1] then
				iter_3_2:SetData(arg_3_0.voteData_[iter_3_1].ID)
			else
				iter_3_2:SetData()
			end
		end
	elseif arg_3_0.roundIndex_ < arg_3_0.curRoundIndex_ then
		arg_3_0.finalController_:SetSelectedState("3")
		arg_3_0.roundController_:SetSelectedState("done")

		arg_3_0.voteData_ = SwimsuitBattleData:GetWinerListByRound(arg_3_1)

		for iter_3_3, iter_3_4 in ipairs(arg_3_0.winerHeadItem_) do
			if arg_3_0.voteData_[iter_3_3] then
				iter_3_4:SetData(arg_3_0.voteData_[iter_3_3].ID)
			else
				iter_3_4:SetData()
			end
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0 = 1, 6 do
		if arg_4_0.preHeadItem_[iter_4_0] then
			arg_4_0.preHeadItem_[iter_4_0]:Dispose()

			arg_4_0.preHeadItem_[iter_4_0] = nil
		end

		if arg_4_0.voteHeadItem_[iter_4_0] then
			arg_4_0.voteHeadItem_[iter_4_0]:Dispose()

			arg_4_0.voteHeadItem_[iter_4_0] = nil
		end

		if arg_4_0.winerHeadItem_[iter_4_0] then
			arg_4_0.winerHeadItem_[iter_4_0]:Dispose()

			arg_4_0.winerHeadItem_[iter_4_0] = nil
		end
	end
end

return var_0_0
