local var_0_0 = class("AutoChessRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_RankUI"
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

	arg_4_0.commonPortrait = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.stageController = arg_4_0.controllers_:GetController("stage")
	arg_4_0.btnController = arg_4_0.controllers_:GetController("btn")
	arg_4_0.list = LuaList.New(function(...)
		arg_4_0:RenderRankItem(...)
	end, arg_4_0.list_, AutoChessRankItem)
	arg_4_0.title_.text = GetTips("AUTO_CHESS_LEADERBOARD_TITLE")
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.formationBtn_, nil, function()
		if arg_6_0.playerData and arg_6_0.playerData.score > 0 then
			AutoChessAction.OpenTeamnfoPopAfterFetch(arg_6_0:GetRankActivityID(), arg_6_0.playerData)
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_autochess_rank_team_touch",
				activity_id = AutoChessData:GetActivityID(),
				source = arg_6_0.playerData.user_id
			})
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:FetchRankData()

	arg_8_0.rankType = RankBaseConst.RANK_TYPE.ALL

	arg_8_0:UpdatePlayerPortrait()
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait:Dispose()
	arg_11_0.list:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.GetRankActivityID(arg_12_0)
	return 3740701
end

function var_0_0.FetchRankData(arg_13_0)
	local var_13_0 = arg_13_0:GetRankActivityID()

	RankAction.QueryActivityRankWitchCallBack(var_13_0, 0, function()
		manager.notify:CallUpdateFunc("OnRankUpdate")
	end)
end

function var_0_0.OnRankUpdate(arg_15_0)
	local var_15_0 = RankData:GetActivityRank(arg_15_0:GetRankActivityID(), 0)

	if var_15_0 == nil then
		return
	end

	arg_15_0.rankedPlayers = var_15_0.rankList or {}
	arg_15_0.playerData = var_15_0.curRank

	if arg_15_0.playerData.score > 0 then
		arg_15_0.btnController:SetSelectedState("normal")
	else
		arg_15_0.btnController:SetSelectedState("empty")
	end

	arg_15_0:UpdatePlayerRankInfo(var_15_0)
	arg_15_0:UpdateRankList(arg_15_0.rankedPlayers)
end

function var_0_0.UpdateRankList(arg_16_0, arg_16_1)
	arg_16_0.list:StartScroll(#arg_16_1)
end

function var_0_0.UpdatePlayerRankInfo(arg_17_0, arg_17_1)
	if arg_17_1 then
		local var_17_0, var_17_1 = arg_17_1:GetCurRankDes()

		arg_17_0.rank_.text = var_17_0
		arg_17_0.score_.text = var_17_1
	else
		arg_17_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		arg_17_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function var_0_0.UpdatePlayerPortrait(arg_18_0)
	local var_18_0 = PlayerData:GetPlayerInfo()

	arg_18_0.commonPortrait:RenderHead(var_18_0.portrait)
	arg_18_0.commonPortrait:RenderFrame(var_18_0.icon_frame)

	arg_18_0.nameTxt_.text = var_18_0.nick
end

function var_0_0.RenderRankItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.rankedPlayers[arg_19_1]

	arg_19_2:SetData(var_19_0)
end

return var_0_0
