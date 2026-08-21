local var_0_0 = class("ActivityQuizSceneResultView", ReduxView)
local var_0_1 = import("game.quiz.QuizFunction")

function var_0_0.UIName(arg_1_0)
	return ActivityQuizTools.GetResultUIName(arg_1_0.params_.activityId)
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

	arg_4_0.rankScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.RankIndexItem), arg_4_0.rankListGo_, ActivityQuizRankItem)
end

function var_0_0.RankIndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshData(arg_5_0.rankList_[arg_5_1], arg_5_0.rankIndexList_[arg_5_1])
	arg_5_2:SetMine(arg_5_0.rankList_[arg_5_1] == arg_5_0.userID_)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_6_0:SetShareItem(false)
		end, function()
			arg_6_0:SetShareItem(true)
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.quitBtn_, nil, function()
		QuitQuizScene()
	end)
	arg_6_0:AddBtnListener(arg_6_0.oneMoreBtn_, nil, function()
		ActivityQuizAction.StartMarch()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityId

	local var_12_0 = PlayerData:GetPlayerInfo()

	arg_12_0.userID_ = tostring(var_12_0.userID)

	arg_12_0:RefreshRank()
	arg_12_0:RefreshHero()
end

function var_0_0.RefreshRank(arg_13_0)
	arg_13_0.rankList_ = var_0_1:GetPlayerList()

	arg_13_0:SortRank()

	local var_13_0 = table.indexof(arg_13_0.rankList_, arg_13_0.userID_)
	local var_13_1 = var_0_1:GetRankData(arg_13_0.userID_)

	arg_13_0.numIndex_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), arg_13_0.rankIndexList_[var_13_0])
	arg_13_0.rankScore_.text = var_13_1.score
end

function var_0_0.SortRank(arg_14_0)
	table.sort(arg_14_0.rankList_, function(arg_15_0, arg_15_1)
		local var_15_0 = var_0_1:GetRankData(arg_15_0)
		local var_15_1 = var_0_1:GetRankData(arg_15_1)

		return var_15_0.score > var_15_1.score
	end)

	local var_14_0 = 1

	arg_14_0.rankIndexList_ = {}

	local var_14_1 = var_0_1:GetRankData(arg_14_0.rankList_[1]).score

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rankList_) do
		local var_14_2 = var_0_1:GetRankData(iter_14_1)

		if var_14_1 > var_14_2.score then
			var_14_1 = var_14_2.score
			var_14_0 = iter_14_0
		end

		table.insert(arg_14_0.rankIndexList_, var_14_0)
	end

	arg_14_0.rankScrollHelper_:StartScroll(#arg_14_0.rankList_)
end

function var_0_0.RefreshHero(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0 = 1, 3 do
		if arg_16_0.rankList_[iter_16_0] then
			table.insert(var_16_0, arg_16_0.rankList_[iter_16_0])
			table.insert(var_16_1, arg_16_0.rankIndexList_[iter_16_0])
		end
	end

	var_0_1:ShowModels(var_16_0, var_16_1)
end

function var_0_0.SetShareItem(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0:SetDefaultBar()
		SetActive(arg_17_0.shareBtn_.gameObject, true)
		SetActive(arg_17_0.quitBtn_.gameObject, true)
		SetActive(arg_17_0.oneMoreBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(arg_17_0.shareBtn_.gameObject, false)
		SetActive(arg_17_0.quitBtn_.gameObject, false)
		SetActive(arg_17_0.oneMoreBtn_.gameObject, false)
	end
end

function var_0_0.SetDefaultBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(arg_18_0.activityID_))
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_QUIZ_QUIT"),
			OkCallback = function()
				ActivityQuizAction.ExitRoom()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.OnActivityQuizStartMarch(arg_22_0)
	ActivityQuizTools.SetCurActivityID(arg_22_0.activityID_, ActivityQuizTools.GetCurActivityBackTo())
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = arg_22_0.activityID_
	})
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:SetShareItem(true)
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:RemoveAllListeners()
	arg_25_0.rankScrollHelper_:Dispose()
	arg_25_0.super.Dispose(arg_25_0)
end

return var_0_0
