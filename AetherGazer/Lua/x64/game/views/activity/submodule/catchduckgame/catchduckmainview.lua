local var_0_0 = class("CatchDuckMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Duck/DuckPartyEntranceUI"
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

	arg_4_0.stateController_ = arg_4_0.controllerEx_:GetController("state")
	arg_4_0.endlessController_ = arg_4_0.controllerEx_:GetController("endless")
	arg_4_0.maskController_ = arg_4_0.controllerEx_:GetController("mask")
	arg_4_0.tabController_ = arg_4_0.btnCon_:GetController("status")
	arg_4_0.poolItemList_ = {}

	for iter_4_0 = 1, 8 do
		arg_4_0.poolItemList_[iter_4_0] = CatchDuckStageItem.New(arg_4_0["itemPool_" .. iter_4_0])

		arg_4_0.poolItemList_[iter_4_0]:SetSelectCallBack(handler(arg_4_0, arg_4_0.OnSelectStageItem))
	end

	arg_4_0.poolItemEndless_ = CatchDuckStageItem.New(arg_4_0.itemEndlessPool_)

	arg_4_0.poolItemEndless_:SetSelectCallBack(handler(arg_4_0, arg_4_0.OnSelectStageItem))

	arg_4_0.endlessId_ = ActivityCatchDuckCfg.get_id_list_by_type[2][1]
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0:CloseSectionInfo()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnTask_, nil, function()
		arg_5_0:Go("/summerChessBoardTask", {
			taskActivityID = 280416
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnFirstHalf_, nil, function()
		arg_5_0:OnTabClick(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnSecondHalf_, nil, function()
		arg_5_0:OnTabClick(false)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_3_5_CATCH_DUCK_STAGE, 0)
	manager.redPoint:bindUIandKey(arg_10_0.btnTask_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, 280416))

	arg_10_0.isFirst_ = arg_10_0.params_.isFirst == nil and CatchDuckData:GetIsFirst() or arg_10_0.params_.isFirst

	CatchDuckData:SetIsFirst(arg_10_0.isFirst_)
	arg_10_0:RefreshUI()
	arg_10_0:SetScrollPos(CatchDuckData:GetEnterIndex())
	arg_10_0.stageAnim_:Play("DuckParty_Stage", -1, 0)
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CATCH_DUCK_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if arg_11_0:IsOpenRoute("catchDuckSelectionInfo") then
			arg_11_0:CloseSectionInfo()
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = ActivityData:GetActivityData(ActivityConst.Activity_3_5_CATCH_DUCK)

	arg_13_0.textTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_13_0.stopTime)

	arg_13_0:RefreTabState()
	arg_13_0:RefreshStage()
end

function var_0_0.RefreTabState(arg_14_0)
	local var_14_0 = CatchDuckData:IsOpenSecondHalf()

	arg_14_0.stateController_:SetSelectedState(var_14_0 and "show" or "hide")
	arg_14_0.tabController_:SetSelectedState(arg_14_0.isFirst_ and "left" or "right")
end

function var_0_0.RefreshStage(arg_15_0)
	arg_15_0.duckStageRecord_ = CatchDuckData:GetDuckStageData()

	arg_15_0:RefreshNormalStage()
	arg_15_0:RefreshEndlessStage()
end

function var_0_0.RefreshNormalStage(arg_16_0)
	arg_16_0.conditionId_ = arg_16_0.isFirst_ and CatchDuckData:GetConditionId(1) or CatchDuckData:GetConditionId(2)

	local var_16_0 = ActivityCatchDuckCfg.get_id_list_by_half[arg_16_0.conditionId_]
	local var_16_1 = true

	for iter_16_0 = 1, 8 do
		local var_16_2 = clone(ActivityCatchDuckCfg[var_16_0[iter_16_0]])
		local var_16_3 = arg_16_0.duckStageRecord_[var_16_2.stage_id]
		local var_16_4 = var_16_3 and var_16_3.score or nil

		if var_16_4 == nil then
			var_16_2.isLock = true

			if var_16_1 then
				var_16_1 = false

				local var_16_5 = ActivityCatchDuckCfg[var_16_2.pre]

				if var_16_5 == nil then
					var_16_2.isLock = false
				else
					local var_16_6 = arg_16_0.duckStageRecord_[var_16_5.stage_id]

					var_16_2.isLock = not var_16_6 or var_16_6 and var_16_6.score < var_16_5.target_score
				end
			end
		else
			var_16_2.isLock = false
			var_16_2.isComplete = var_16_4 >= var_16_2.target_score
		end

		var_16_2.score = var_16_4
		var_16_2.seconds = var_16_3 and var_16_3.seconds or nil

		arg_16_0.poolItemList_[iter_16_0]:RefreshUI(var_16_2, iter_16_0)
	end
end

function var_0_0.RefreshEndlessStage(arg_17_0)
	if arg_17_0.isFirst_ then
		arg_17_0.endlessController_:SetSelectedState("first")
	else
		arg_17_0.endlessController_:SetSelectedState("second")

		local var_17_0 = clone(ActivityCatchDuckCfg[arg_17_0.endlessId_])

		var_17_0.score = arg_17_0.duckStageRecord_[var_17_0.stage_id] and arg_17_0.duckStageRecord_[var_17_0.stage_id].score or nil
		var_17_0.isEndless = true

		local var_17_1 = ActivityCatchDuckCfg[var_17_0.pre]
		local var_17_2 = arg_17_0.duckStageRecord_[var_17_1.stage_id]

		var_17_0.isLock = not var_17_2 or var_17_2 and var_17_2.score < var_17_1.target_score

		arg_17_0.poolItemEndless_:RefreshUI(var_17_0, 9)
	end
end

function var_0_0.CloseSectionInfo(arg_18_0)
	if arg_18_0.selectedItem_ then
		arg_18_0.selectedItem_:SelectItem(false)

		arg_18_0.selectedItem_ = nil
	end

	arg_18_0:OnDuckStageInfoShow(false)
	JumpTools.Back()
end

function var_0_0.OnDuckStageInfoShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0.maskController_:SetSelectedState(arg_19_1 and "show" or "hide")

	if arg_19_1 then
		local var_19_0 = arg_19_0:CaculateMoveX(arg_19_3)

		arg_19_0:RemoveTween()

		arg_19_0.scrollRect_.enabled = false
		arg_19_0.tween_ = LeanTween.value(arg_19_0.scrollRect_.gameObject, arg_19_0.scrollRect_.horizontalNormalizedPosition, var_19_0, 0.2)

		arg_19_0.tween_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
			arg_19_0.scrollRect_.horizontalNormalizedPosition = arg_20_0
		end))
	else
		arg_19_0.scrollRect_.enabled = true
	end
end

function var_0_0.CaculateMoveX(arg_21_0, arg_21_1)
	local var_21_0 = (UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_21_1).x - Screen.width / 2) * manager.ui.canvasRate / (arg_21_0.content_.rect.width - arg_21_0.viewPortTrans_.rect.width)

	return arg_21_0.scrollRect_.horizontalNormalizedPosition + var_21_0
end

function var_0_0.OnTabClick(arg_22_0, arg_22_1)
	if arg_22_0.isFirst_ == arg_22_1 then
		return
	end

	arg_22_0.isFirst_ = arg_22_1

	arg_22_0.tabController_:SetSelectedState(arg_22_0.isFirst_ and "left" or "right")
	CatchDuckData:SetIsFirst(arg_22_0.isFirst_)

	arg_22_0.scrollRect_.horizontalNormalizedPosition = 0

	arg_22_0:RefreshStage()
	arg_22_0.stageAnim_:Play("DuckParty_Stage", -1, 0)
end

function var_0_0.SetScrollPos(arg_23_0, arg_23_1)
	local var_23_0 = (2 - arg_23_1) * 500

	arg_23_0.content_.anchoredPosition = Vector2(var_23_0, 0)
end

function var_0_0.OnSelectStageItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.selectedItem_ then
		arg_24_0.selectedItem_:SelectItem(false)
	end

	arg_24_0.selectedItem_ = arg_24_1

	arg_24_0.selectedItem_:SelectItem(true)
	arg_24_0:OnDuckStageInfoShow(true, arg_24_3, arg_24_1.transform_.position)
	arg_24_0:Go("catchDuckSelectionInfo", {
		stageData = arg_24_2,
		index = arg_24_3
	})
end

function var_0_0.RemoveTween(arg_25_0)
	if arg_25_0.tween_ then
		arg_25_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_25_0.content_.gameObject)

		arg_25_0.tween_ = nil
	end
end

function var_0_0.OnExit(arg_26_0)
	manager.windowBar:HideBar()
	arg_26_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_26_0.btnTask_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, 280416))
end

function var_0_0.Dispose(arg_27_0)
	var_0_0.super.Dispose(arg_27_0)

	for iter_27_0, iter_27_1 in pairs(arg_27_0.poolItemList_) do
		iter_27_1:Dispose()
	end

	arg_27_0.poolItemEndless_:Dispose()
end

return var_0_0
