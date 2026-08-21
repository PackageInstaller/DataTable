local var_0_0 = class("DodgeBarrageMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_BarrageMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.stageDiff_ = 1
	arg_3_0.hardStageStartIndex_ = #ActivityDodgeBarrageCfg.get_id_list_by_diff[0] + 1
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.stageListGo_, DodgeBarrageStageItem)

	arg_4_0.stageScroll_:SetPageChangeHandler(handler(arg_4_0, arg_4_0.SelectStage))

	arg_4_0.lockController_ = arg_4_0.itemCon_:GetController("lock")
	arg_4_0.reachController_ = arg_4_0.itemCon_:GetController("reach")
	arg_4_0.bgController_ = arg_4_0.itemCon_:GetController("bg")
	arg_4_0.targetScoreController_ = arg_4_0.itemCon_:GetController("targetScore")
	arg_4_0.diffController_ = arg_4_0.diffCon_:GetController("difficulty")
	arg_4_0.targetScoreCon_ = {}
	arg_4_0.targetScoreText_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.targetScoreCon_[iter_4_0] = arg_4_0["scoreCon_" .. iter_4_0]:GetController("reach")
		arg_4_0.targetScoreText_[iter_4_0] = arg_4_0["scoreText_" .. iter_4_0]
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnDesc_, nil, function()
		local var_6_0 = "ACTIVITY_DODGE_BARRAGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnTask_, nil, function()
		JumpTools.OpenPageByJump("dodgeBarrageTaskView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnGoBattle_, nil, function()
		local var_8_0 = arg_5_0.selectItem_:GetStageData()

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = var_8_0.id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE,
			activityID = arg_5_0.activityId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnNormal_, nil, function()
		arg_5_0:RefreshScore(arg_5_0.hardStageStartIndex_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnHard_, nil, function()
		arg_5_0:RefreshScore(arg_5_0.hardStageStartIndex_ + 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnHardest_, nil, function()
		arg_5_0:RefreshScore(arg_5_0.hardStageStartIndex_ + 2)
	end)
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		if arg_5_0.selectItem_ then
			arg_5_0.selectItem_:UnSelectItem()

			arg_5_0.selectItem_ = nil
		end
	end))
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityId_ = DodgeBarrageData:GetActivityId()
	arg_13_0.redPointKey_ = DodgeBarrageData:GetRedPointKey()

	manager.redPoint:bindUIandKey(arg_13_0.btnTask_.transform, arg_13_0.redPointKey_)
	arg_13_0:RefreshLastStage()
	arg_13_0:RefreshData()
	arg_13_0:RefreshTime()
end

function var_0_0.RefreshLastStage(arg_14_0)
	local var_14_0 = DodgeBarrageData:GetLastStage()
	local var_14_1 = ActivityDodgeBarrageCfg[var_14_0].stage_id

	if var_14_0 ~= 0 then
		arg_14_0.stageIndex_ = var_14_0
	else
		arg_14_0.stageIndex_ = 1
	end
end

function var_0_0.RefreshData(arg_15_0)
	arg_15_0.stageList_ = clone(ActivityDodgeBarrageCfg.all)

	arg_15_0.stageScroll_:StartScroll(#arg_15_0.stageList_)
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[arg_16_0.activityId_].activity_theme)
	end)
end

function var_0_0.RefreshTime(arg_18_0)
	if arg_18_0.updateTimer_ then
		arg_18_0.updateTimer_:Stop()

		arg_18_0.updateTimer_ = nil
	end

	arg_18_0.remainTime = ActivityData:GetActivityData(arg_18_0.activityId_).stopTime
	arg_18_0.activityTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_18_0.remainTime)
	arg_18_0.updateTimer_ = Timer.New(function()
		arg_18_0.activityTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_18_0.remainTime)
	end, 1, arg_18_0.remainTime - manager.time:GetServerTime() + 1, 1)

	arg_18_0.updateTimer_:Start()
end

function var_0_0.IndexItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(arg_20_1, arg_20_0.stageList_[arg_20_1], arg_20_0.stageIndex_)
	arg_20_2:RegisterClick(function(arg_21_0)
		arg_20_0.stageScroll_:SwitchToPage(arg_21_0)
	end)

	if arg_20_1 == #arg_20_0.stageList_ then
		arg_20_0.stageScroll_:SwitchToPage(arg_20_0.stageIndex_)
		SetActive(arg_20_0.scoreGo_, true)
	end
end

function var_0_0.SelectStage(arg_22_0, arg_22_1)
	if arg_22_0.selectItem_ then
		arg_22_0.selectItem_:UnSelectItem()

		arg_22_0.selectItem_ = nil
	end

	arg_22_0.stageIndex_ = arg_22_1
	arg_22_0.selectItem_ = arg_22_0.stageScroll_:GetItemByIndex(arg_22_1)

	arg_22_0.selectItem_:SelectItem()

	arg_22_0.isNormal_ = arg_22_0.selectItem_:GetIsNormal()

	arg_22_0.bgController_:SetSelectedState(arg_22_0.isNormal_ and "normal" or "hard")

	arg_22_0.lockText_.text = arg_22_0.selectItem_:GetLockText()

	arg_22_0.lockController_:SetSelectedState(arg_22_0.selectItem_:GetIsLock() and "lock" or "unlock")
	arg_22_0:RefreshScore(arg_22_0.stageIndex_)
end

function var_0_0.RefreshScore(arg_23_0, arg_23_1)
	local var_23_0 = ActivityDodgeBarrageCfg[arg_23_1]
	local var_23_1 = var_23_0.stage_id
	local var_23_2 = DodgeBarrageData:GetStageScore(var_23_1) or 0

	arg_23_0.stageMaxScore_.text = var_23_2 or 0

	arg_23_0.targetScoreController_:SetSelectedState(#var_23_0.targetScore)

	for iter_23_0, iter_23_1 in ipairs(var_23_0.targetScore) do
		arg_23_0.targetScoreText_[iter_23_0].text = iter_23_1

		arg_23_0.targetScoreCon_[iter_23_0]:SetSelectedState(iter_23_1 <= var_23_2 and "show" or "hide")
	end

	arg_23_0.reachController_:SetSelectedState(var_23_2 >= var_23_0.targetScore[#var_23_0.targetScore] and "show" or "hide")
end

function var_0_0.OnExit(arg_24_0)
	manager.redPoint:unbindUIandKey(arg_24_0.btnTask_.transform, arg_24_0.redPointKey_)

	arg_24_0.selectItem_ = nil
	arg_24_0.stageDiff_ = 1

	manager.windowBar:HideBar()
	SetActive(arg_24_0.scoreGo_, false)
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)

	if arg_25_0.stageScroll_ then
		arg_25_0.stageScroll_:Dispose()

		arg_25_0.stageScroll_ = nil
	end

	if arg_25_0.updateTimer_ then
		arg_25_0.updateTimer_:Stop()

		arg_25_0.updateTimer_ = nil
	end
end

return var_0_0
