local var_0_0 = import("game.views.autoChess.view.rank.AutoChessRankView")
local var_0_1 = class("AutoChessRankView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_RankUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait = CommonHeadPortrait.New(arg_2_0.headItem_)
	arg_2_0.tabController = arg_2_0.controllers_:GetController("tab")
	arg_2_0.btnController = arg_2_0.controllers_:GetController("btn")
	arg_2_0.scoreTabController = arg_2_0.controllers_:GetController("scoreTab")
	arg_2_0.list = LuaList.New(function(...)
		arg_2_0:RenderRankItem(...)
	end, arg_2_0.list_, AutoChessRankItem_4_8)
	arg_2_0.title_.text = GetTips("AUTO_CHESS_LEADERBOARD_TITLE")
end

function var_0_1.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.levelBtn_, nil, function()
		if arg_4_0.isLevelRank_ then
			return
		end

		arg_4_0.isLevelRank_ = true

		arg_4_0.tabController:SetSelectedIndex(0)
		arg_4_0:FetchRankData()
	end)
	arg_4_0:AddBtnListener(arg_4_0.scoreBtn_, nil, function()
		if not arg_4_0.isLevelRank_ then
			return
		end

		arg_4_0.isLevelRank_ = false

		arg_4_0.tabController:SetSelectedIndex(1)
		arg_4_0:FetchRankData()
	end)
	arg_4_0:AddBtnListener(arg_4_0.formationBtn_, nil, function()
		if arg_4_0.playerData and arg_4_0.playerData.score > 0 then
			AutoChessMatchAction.OpenTeamnfoPopAfterFetch(arg_4_0:GetRankActivityID(), arg_4_0.playerData)
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_autochess_rank_team_touch",
				activity_id = AutoChessData:GetActivityID(),
				source = arg_4_0.playerData.user_id
			})
		end
	end)
end

function var_0_1.OnEnter(arg_8_0)
	local var_8_0 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK)

	arg_8_0.isLevelRank_ = not var_8_0

	arg_8_0.scoreTabController:SetSelectedState(var_8_0 and "show" or "hide")
	arg_8_0.tabController:SetSelectedIndex(var_8_0 and 1 or 0)
	arg_8_0:FetchRankData()
	arg_8_0:UpdatePlayerPortrait()
end

function var_0_1.Dispose(arg_9_0)
	var_0_1.super.Dispose(arg_9_0)
end

function var_0_1.GetRankActivityID(arg_10_0)
	if arg_10_0.isLevelRank_ then
		return ActivityConst.ACTIVITY_AUTO_CHESS_LEVEL_RANK
	else
		return ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK
	end
end

function var_0_1.OnRankUpdate(arg_11_0)
	local var_11_0 = RankData:GetActivityRank(arg_11_0:GetRankActivityID(), 0)

	if var_11_0 == nil then
		return
	end

	arg_11_0.rankedPlayers = var_11_0.rankList or {}
	arg_11_0.playerData = var_11_0.curRank

	if arg_11_0.playerData.score > 0 then
		arg_11_0.btnController:SetSelectedState("normal")
	else
		arg_11_0.btnController:SetSelectedState("empty")
	end

	arg_11_0:UpdatePlayerRankInfo(var_11_0)
	arg_11_0:UpdateRankList(arg_11_0.rankedPlayers)
end

function var_0_1.RenderRankItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.rankedPlayers[arg_12_1], arg_12_0.isLevelRank_)
end

function var_0_1.UpdatePlayerRankInfo(arg_13_0, arg_13_1)
	SetActive(arg_13_0.formationBtn_.gameObject, false)

	if arg_13_1 then
		local var_13_0, var_13_1 = arg_13_1:GetCurRankDes()

		arg_13_0.rank_.text = var_13_0

		if arg_13_0.isLevelRank_ then
			local var_13_2 = AutoChessCardData:GetRankScore()

			arg_13_0.score_.text = var_13_2 > arg_13_0.playerData.score and var_13_2 or var_13_1
		else
			arg_13_0.score_.text = arg_13_0.playerData and arg_13_0.playerData.score > 0 and arg_13_0.historyScore_ or var_13_1

			SetActive(arg_13_0.formationBtn_.gameObject, arg_13_0.playerData.score > 0)
		end
	else
		arg_13_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		arg_13_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

return var_0_1
