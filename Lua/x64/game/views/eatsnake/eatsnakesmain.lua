local var_0_0 = class("EatSnakesMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnController_ = arg_4_0.btnCon_:GetController("lock")
	arg_4_0.targetController_ = {}
	arg_4_0.targetText_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.targetText_[iter_4_0] = arg_4_0["condition" .. iter_4_0 .. "Txt_"]
		arg_4_0.targetController_[iter_4_0] = arg_4_0["condition" .. iter_4_0 .. "Controller_"]:GetController("lock")
	end

	arg_4_0.stageItemList_ = {}

	for iter_4_1 = 1, 7 do
		arg_4_0.stageItemList_[iter_4_1] = EatSnakeStageItem.New(arg_4_0["stage_" .. iter_4_1])
	end

	arg_4_0:InitScrollView()
end

function var_0_0.InitScrollView(arg_5_0)
	arg_5_0.scrollView_ = StageScrollView.New(arg_5_0.scrollViewGo_)

	arg_5_0.scrollView_:RegistPointerUp(handler(arg_5_0, arg_5_0.CloseStageView))
	arg_5_0.scrollView_:RegistBeginDrag(handler(arg_5_0, arg_5_0.CloseStageView))
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.viewBtn_, nil, function()
		if arg_6_0.isOpen then
			arg_6_0:CloseStageView()
		end

		JumpTools.GoToSystem("/eatSnakesShow", {
			activityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.studyBtn_, nil, function()
		if arg_6_0.isOpen then
			arg_6_0:CloseStageView()
		end

		JumpTools.GoToSystem("eatSnakesTask", {
			activityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		EatSnakeAction.PlayEatSnakeGame(ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[arg_6_0.selectIndex]].id)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:CloseStageView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:CloseStageView()
	end)
end

function var_0_0.callbackFunction(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.selectIndex = arg_12_1

	if arg_12_0.selectItem_ then
		arg_12_0.selectItem_.selectController:SetSelectedState("off")
	end

	arg_12_0.selectItem_ = arg_12_2

	arg_12_0.selectItem_.selectController:SetSelectedState("on")
	SetActive(arg_12_0.chapterGo_, true)
	arg_12_0:MoveStageContent(arg_12_2.transform_.position)
	arg_12_0:UpdateStageView()
end

function var_0_0.MoveStageContent(arg_13_0, arg_13_1)
	local var_13_0 = UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_13_1).x - Screen.width / 2

	arg_13_0.scrollView_:MoveContentScreenPosXDelta(var_13_0, 0.09)
end

function var_0_0.UpdateStageView(arg_14_0)
	arg_14_0.isOpen = true

	local var_14_0 = ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[arg_14_0.selectIndex]]
	local var_14_1 = arg_14_0.stageData[arg_14_0.selectIndex]

	for iter_14_0 = 1, 3 do
		local var_14_2 = ConditionCfg[var_14_0.target_list[iter_14_0]]

		arg_14_0.targetText_[iter_14_0].text = var_14_2.desc

		arg_14_0.targetController_[iter_14_0]:SetSelectedState((not var_14_1 or iter_14_0 > var_14_1.target) and "lock" or "unlock")
	end

	arg_14_0.stageTxt_.text = GetI18NText(var_14_0.name)

	if arg_14_0.openTimer_ then
		arg_14_0.openTimer_:Stop()

		arg_14_0.openTimer_ = nil
	end

	local var_14_3 = ActivityData:GetActivityData(var_14_0.activity_id).startTime

	local function var_14_4()
		if not ActivityData:GetActivityIsOpen(var_14_0.activity_id) then
			arg_14_0.btnController_:SetSelectedState("true")

			if var_14_3 < manager.time:GetServerTime() then
				arg_14_0.lockText_.text = GetTips("TIME_OUT")
			else
				arg_14_0.lockText_.text = string.format(GetTips("SNAKEGAME_STAGE_LOCK_2"), manager.time:GetLostTimeStr(var_14_3))
			end
		elseif arg_14_0.selectIndex > 1 and arg_14_0.stageData[arg_14_0.selectIndex - 1] == nil then
			arg_14_0.btnController_:SetSelectedState("true")

			arg_14_0.lockText_.text = GetTips("SNAKEGAME_STAGE_LOCK")
		else
			arg_14_0.btnController_:SetSelectedState("false")
		end
	end

	var_14_4()

	arg_14_0.openTimer_ = Timer.New(function()
		var_14_4()
	end, 1, -1, 1)

	arg_14_0.openTimer_:Start()
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:UpdateData()
	arg_17_0:UpdateView()
	arg_17_0:UpdateStageItem()
	arg_17_0:BindRedPoint()
end

function var_0_0.UpdateData(arg_18_0)
	arg_18_0.stageData = EatSnakeData:GetDataByPara("stageList")
	arg_18_0.activityId = EatSnakeData:GetDataByPara("activityID")
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.contentTrans_.anchoredPosition = EatSnakeData:GetEnterPos() or Vector2(0, 0)

	if arg_19_0.updateTimer_ then
		arg_19_0.updateTimer_:Stop()

		arg_19_0.updateTimer_ = nil
	end

	SetActive(arg_19_0.chapterGo_, false)

	local var_19_0 = ActivityData:GetActivityData(arg_19_0.activityId).stopTime

	arg_19_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_19_0, true)
	arg_19_0.updateTimer_ = Timer.New(function()
		if manager.time:GetServerTime() < var_19_0 then
			arg_19_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_19_0, true)
		else
			arg_19_0.remainTxt_.text = GetTips("TIME_OUT")
		end
	end, 1, -1, 1)
	arg_19_0.activityTitle_.text = GetI18NText(ActivityCfg[arg_19_0.activityId].remark)

	arg_19_0.updateTimer_:Start()
end

function var_0_0.UpdateStageItem(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.stageItemList_) do
		iter_21_1:SetData(iter_21_0, arg_21_0.stageData[iter_21_0], #arg_21_0.stageData, arg_21_0, ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[iter_21_0]], handler(arg_21_0, arg_21_0.callbackFunction))
	end
end

function var_0_0.BindRedPoint(arg_22_0)
	manager.redPoint:bindUIandKey(arg_22_0.studyBtn_.transform, RedPointConst.EAT_SNAKE_TASK)
end

function var_0_0.UnbindRedPoint(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.studyBtn_.transform, RedPointConst.EAT_SNAKE_TASK)
end

function var_0_0.CloseStageView(arg_24_0)
	if arg_24_0.isOpen then
		arg_24_0.isOpen = false

		SetActive(arg_24_0.chapterGo_, false)

		if arg_24_0.selectItem_ then
			arg_24_0.selectItem_.selectController:SetSelectedState("off")
		end

		arg_24_0.scrollView_:Recover()
	end

	if arg_24_0.openTimer_ then
		arg_24_0.openTimer_:Stop()

		arg_24_0.openTimer_ = nil
	end
end

function var_0_0.RemoveTween(arg_25_0)
	if arg_25_0.tween_ then
		arg_25_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_25_0.content_.gameObject)

		arg_25_0.tween_ = nil
	end
end

function var_0_0.OnExit(arg_26_0)
	EatSnakeData:SetEnterPos(arg_26_0.contentTrans_.anchoredPosition)

	if arg_26_0.updateTimer_ then
		arg_26_0.updateTimer_:Stop()

		arg_26_0.updateTimer_ = nil
	end

	if arg_26_0.openTimer_ then
		arg_26_0.openTimer_:Stop()

		arg_26_0.openTimer_ = nil
	end

	arg_26_0.isOpen = false

	arg_26_0:UnbindRedPoint()
	arg_26_0.scrollView_:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SNAKEGAME_GAMEPLAY_DESC")
	arg_27_0.scrollView_:Recover()
end

function var_0_0.Dispose(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.stageItemList_) do
		iter_28_1:Dispose()

		iter_28_1 = nil
	end

	arg_28_0.stageItemList_ = nil

	if arg_28_0.updateTimer_ then
		arg_28_0.updateTimer_:Stop()

		arg_28_0.updateTimer_ = nil
	end

	if arg_28_0.openTimer_ then
		arg_28_0.openTimer_:Stop()

		arg_28_0.openTimer_ = nil
	end

	arg_28_0.scrollView_:Dispose()

	arg_28_0.scrollView_ = nil

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
