local var_0_0 = class("ContinueBattleCostPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationContinuousPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rewardController_ = arg_3_0.controllerEx_:GetController("item")
	arg_3_0.btnController_ = arg_3_0.controllerEx_:GetController("btn")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, CommonItemView)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageType_ = arg_4_0.params_.stageType
	arg_4_0.stageID_ = arg_4_0.params_.stageID
	arg_4_0.callBack_ = arg_4_0.params_.callback
	arg_4_0.costList_, arg_4_0.nextStageCnt_ = StageTools.GetContinueBattleCost(arg_4_0.stageType_, arg_4_0.stageID_)

	local var_4_0 = arg_4_0.costList_[1].id
	local var_4_1 = ItemCfg[var_4_0]

	arg_4_0.descText_.text = string.format(GetTips("CONTINUE_BATTLE_COST_TIP"), arg_4_0.nextStageCnt_, ItemTools.getItemName(var_4_0), arg_4_0.costList_[1].num)

	local var_4_2 = BattleStageData:GetStageData()[arg_4_0.stageID_]

	if var_4_2 and var_4_2.clear_times > 0 then
		arg_4_0.btnController_:SetSelectedState("single")
	else
		arg_4_0.btnController_:SetSelectedState("out")
	end

	arg_4_0.stageList_ = StageTools.GetContinueBattleStageList(arg_4_0.stageType_, arg_4_0.stageID_)

	arg_4_0:RefreshReward()
	manager.windowBar:SwitchBar({
		var_4_0
	})
	manager.windowBar:SetBarCanAdd(var_4_0, true)
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.uiList_ then
		arg_6_0.uiList_:Dispose()

		arg_6_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.singleBtn_, nil, function()
		arg_7_0:Back()

		local var_9_0 = BattleStageData:GetStageData()[arg_7_0.stageID_]

		if var_9_0 and var_9_0.clear_times > 0 then
			BattleStageData:SetAutoNextBattle(false)
			arg_7_0.callBack_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		BattleStageData:SetAutoNextBattle(true)
		arg_7_0:Back()
		arg_7_0.callBack_()
	end)
end

function var_0_0.RefreshReward(arg_12_0)
	local var_12_0 = arg_12_0.stageList_
	local var_12_1 = var_12_0[#var_12_0]

	if ChapterTools.IsClearStage(var_12_1) then
		arg_12_0.rewardController_:SetSelectedState("none")
	else
		local var_12_2 = BattleStageData:GetStageData()
		local var_12_3 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_4 = true
			local var_12_5 = var_12_2[iter_12_1]

			if var_12_5 and var_12_5.clear_times > 0 then
				var_12_4 = false
			end

			local var_12_6 = BattleStageTools.GetStageCfg(arg_12_0.stageType_, iter_12_1)

			table.insertto(var_12_3, getRewardFromDropCfg(var_12_6.drop_lib_id, var_12_4))
		end

		arg_12_0.rewardIDList_ = mergeReward(var_12_3)

		arg_12_0.uiList_:StartScroll(#arg_12_0.rewardIDList_)

		local var_12_7, var_12_8 = BattleStageTools.GetChapterSectionIndex(arg_12_0.stageType_, var_12_1)

		arg_12_0.clearTipsText_.text = string.format(GetTips("CLEAR_STAGE_DROP_REWARD"), string.format("%s-%s", GetI18NText(var_12_7), var_12_8))

		arg_12_0.rewardController_:SetSelectedState("have")
	end
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0.canvasGroup_.alpha = 1
	arg_13_0.canvasGroup_.blocksRaycasts = true
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.rewardIDList_[arg_14_1]

	function var_14_0.clickFun(arg_15_0)
		ShowPopItem(POP_OTHER_ITEM, arg_15_0)

		arg_14_0.canvasGroup_.alpha = 0
		arg_14_0.canvasGroup_.blocksRaycasts = false
	end

	arg_14_2:SetData(var_14_0)
end

return var_0_0
