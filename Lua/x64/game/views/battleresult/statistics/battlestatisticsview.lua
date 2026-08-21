local var_0_0 = class("BattleStatisticsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/BattleStatisticsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
	SetActive(arg_3_0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData = arg_4_0.params_.stageData
	arg_4_0.statisticsHeroItem_ = {}

	local var_4_0, var_4_1, var_4_2 = BattleTools.GetBattleStatisticsData()
	local var_4_3 = LuaExchangeHelper.GetBattleStatisticsData()
	local var_4_4 = var_4_3 and var_4_3.dataForLua.currentHPHero or {}
	local var_4_5 = arg_4_0.stageData:GetHeroTeam()
	local var_4_6 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_5) do
		if iter_4_1 ~= 0 then
			var_4_6 = var_4_6 + 1
		end
	end

	local var_4_7 = var_4_4.Count or 0

	if var_4_7 ~= var_4_6 then
		print("special handling Battle Statistics")

		for iter_4_2 = 1, 3 do
			if iter_4_2 <= var_4_7 then
				local var_4_8 = var_4_4[iter_4_2 - 1]
				local var_4_9 = table.indexof(var_4_5, var_4_8)
				local var_4_10 = arg_4_0.stageData:GetHeroDataByPos(var_4_9)

				arg_4_0.statisticsHeroItem_[iter_4_2] = arg_4_0:GetStatisticsItem().New(arg_4_0.heroItem_[iter_4_2], var_4_10, var_4_1, var_4_2, var_4_0[iter_4_2])
			else
				arg_4_0.statisticsHeroItem_[iter_4_2] = arg_4_0:GetStatisticsItem().New(arg_4_0.heroItem_[iter_4_2], nil, var_4_1, var_4_2, var_4_0[iter_4_2])
			end
		end
	else
		for iter_4_3 = 1, 3 do
			local var_4_11 = arg_4_0.stageData:GetHeroDataByPos(iter_4_3)

			arg_4_0.statisticsHeroItem_[iter_4_3] = arg_4_0:GetStatisticsItem().New(arg_4_0.heroItem_[iter_4_3], var_4_11, var_4_1, var_4_2, var_4_0[iter_4_3])
		end
	end

	arg_4_0:SetLevelTitle()
	arg_4_0:RefreshTimeText()

	if arg_4_0.params_.battleResult ~= nil and arg_4_0.params_.battleResult.errorCode ~= nil and arg_4_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_4_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_6_0)
	BattleInstance.QuitBattle(arg_6_0.stageData)
end

function var_0_0.OnExit(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.statisticsHeroItem_) do
		iter_7_1:Dispose()
	end

	arg_7_0.statisticsHeroItem_ = nil
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveListeners()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.heroItem_ = {}

	for iter_9_0 = 1, 3 do
		arg_9_0.heroItem_[iter_9_0] = arg_9_0["hero" .. iter_9_0]
	end
end

function var_0_0.GetStatisticsItem(arg_10_0)
	return BattleStatisticsHeroItem
end

function var_0_0.SetLevelTitle(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.stageData:GetStageId()
	local var_11_1 = arg_11_0.stageData:GetType()

	arg_11_0.lvText_.text = BattleStageTools.GetStageName(var_11_1, var_11_0)

	local var_11_2, var_11_3 = BattleStageTools.GetChapterSectionIndex(var_11_1, var_11_0)

	if var_11_2 ~= "" then
		arg_11_0.stareText_.text = string.format("%s-%s", GetI18NText(var_11_2), GetI18NText(var_11_3))
	else
		arg_11_0.stareText_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.titleTransform_)
end

function var_0_0.RefreshTimeText(arg_12_0)
	SetActive(arg_12_0.battleTimeGo_, arg_12_0.params_.battleTime ~= nil)

	if not arg_12_0.params_.battleTime then
		return
	end

	arg_12_0.battleTimeText_.text = arg_12_0.params_.battleTime
end

function var_0_0.AddListeners(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.backBtn_, nil, function()
		arg_13_0:Back()
	end)
	arg_13_0:AddBtnListener(arg_13_0.buttonShare_, nil, function()
		manager.share:Share(function()
			SetActive(arg_13_0.goShare_, false)
			SetActive(arg_13_0.goBack_, false)
		end, function()
			SetActive(arg_13_0.goShare_, true)
			SetActive(arg_13_0.goBack_, true)
		end)
	end)
end

function var_0_0.RemoveListeners(arg_18_0)
	arg_18_0.backBtn_.onClick:RemoveAllListeners()
end

return var_0_0
