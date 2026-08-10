local var_0_0 = class("SwimsuitBattleVoteView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVoteUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.voteActivityID_ = 0
	arg_4_0.voteRound_ = nil
	arg_4_0.voteData_ = {}
	arg_4_0.startTime_ = nil
	arg_4_0.stopTime_ = nil
	arg_4_0.rankTabItemList_ = {}
	arg_4_0.rankBtnList_ = {}
	arg_4_0.rankImgList_ = {}

	for iter_4_0 = 1, 7 do
		arg_4_0.rankTabItemList_[iter_4_0] = SwimsuitBattleVoteRankItem.New(arg_4_0["rank" .. iter_4_0 .. "Go_"])
		arg_4_0.rankBtnList_[iter_4_0] = arg_4_0["rank" .. iter_4_0 .. "Btn_"]
		arg_4_0.rankImgList_[iter_4_0] = arg_4_0["rank" .. iter_4_0 .. "Img_"]
	end

	arg_4_0.stageController_ = arg_4_0.mainControllerEx_:GetController("voteStage")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0 = 1, 7 do
		arg_5_0:AddBtnListener(arg_5_0.rankBtnList_[iter_5_0], nil, function()
			if not SwimsuitBattleData:CheckInRoundTime() then
				return
			end

			local var_6_0 = SwimsuitBattleInfoCfg[arg_5_0.params_.activity].voting_ticket_id

			JumpTools.OpenPageByJump("swimsuitBattleVotePop", {
				voteActivity = arg_5_0.voteActivityID_,
				item = var_6_0,
				id = arg_5_0.voteData_[iter_5_0].ID,
				vote = arg_5_0.voteData_[iter_5_0].voteNum,
				rank = iter_5_0
			})
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.roundBtn_, nil, function()
		JumpTools.OpenPageByJump("/swimsuitBattleVoteRound")
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("swimsuitVoteQuestPop")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	local var_9_0 = SwimsuitBattleInfoCfg[arg_9_0.params_.activity].voting_ticket_id

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_9_0
	})
	manager.windowBar:SetBarCanAdd(var_9_0, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_VOTE")

	arg_9_0.voteActivityID_ = SwimsuitBattleInfoCfg[arg_9_0.params_.activity].vote_activity_id

	SwimsuitBattleAction.RequireVoteRoundInfo(arg_9_0.voteActivityID_)

	local var_9_1 = ActivityData:GetActivityData(arg_9_0.voteActivityID_)

	arg_9_0.startTime_ = var_9_1.startTime
	arg_9_0.stopTime_ = var_9_1.stopTime

	arg_9_0:AddTimer()
	arg_9_0:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(arg_9_0, arg_9_0.OnVoteRoundInfoUpdate))
	manager.redPoint:bindUIandKey(arg_9_0.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD)
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.voteRound_ = SwimsuitBattleData:GetCurVoteRound()

	if arg_10_0.voteRound_ == 5 then
		arg_10_0.voteRound_ = 4
	end

	arg_10_0.stageController_:SetSelectedState(tostring(arg_10_0.voteRound_))

	arg_10_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(arg_10_0.voteRound_)

	for iter_10_0 = 1, #arg_10_0.voteData_ do
		if iter_10_0 > 7 then
			break
		end

		arg_10_0.rankTabItemList_[iter_10_0]:SetData(arg_10_0.voteData_[iter_10_0].ID, arg_10_0.voteData_[iter_10_0].voteNum)

		local var_10_0 = SwimsuitVoteHeroCfg[arg_10_0.voteData_[iter_10_0].ID]

		arg_10_0.rankImgList_[iter_10_0].spriteAsync = "TextureConfig/Character/Icon/" .. var_10_0.show_image
	end
end

function var_0_0.CheckResultPop(arg_11_0)
	if (getData("SwimsuitBattle", "lastVoteRound") or 0) < arg_11_0.voteRound_ then
		saveData("SwimsuitBattle", "lastVoteRound", arg_11_0.voteRound_)
		JumpTools.OpenPageByJump("swimsuitBattleResult")
	end
end

function var_0_0.AddTimer(arg_12_0)
	arg_12_0:StopTimer()

	arg_12_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_12_0.stopTime_, true)
	arg_12_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_12_0.stopTime_ then
			return
		end

		arg_12_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_12_0.stopTime_, true)
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:StopTimer()
	arg_15_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_15_0.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD)
end

function var_0_0.OnVoteRoundInfoUpdate(arg_16_0)
	arg_16_0:UpdateView()
	arg_16_0:CheckResultPop()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	for iter_17_0 = 1, 7 do
		if arg_17_0.rankTabItemList_[iter_17_0] then
			arg_17_0.rankTabItemList_[iter_17_0]:Dispose()

			arg_17_0.rankTabItemList_[iter_17_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
