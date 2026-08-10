local var_0_0 = class("QWorldQuestSideView", ReduxView)

function var_0_0.UIParent(arg_1_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_0.gameObject_.transform
	arg_2_0.mainHomePage_ = arg_2_2

	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.items_ = {}

	SetActive(arg_3_0.questCondItemGo_, false)

	arg_3_0.itemsNew_ = {}
	arg_3_0.typeController_ = arg_3_0.questConEx_:GetController("type")
	arg_3_0.animTimers_ = {}
	arg_3_0.lastTrackingId_ = -1

	SetActive(arg_3_0.questFinishGo_, false)
	SetActive(arg_3_0.questNewGo_, false)
	SetActive(arg_3_0.questNewItemGo_, false)
	SetActive(arg_3_0.questCondItemGo_, false)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.questSideBtn_, nil, function()
		if not arg_4_0.mainHomePage_:CheckCanInteract() then
			return
		end

		if arg_4_0.questIdNew_ ~= nil then
			if arg_4_0.questIdNew_ ~= QWorldQuestTool.GetMainQuestTrackingId() then
				QWorldQuestAction.UpdateTrackingMainQuestId(arg_4_0.questIdNew_, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(arg_4_0.questIdNew_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
					QWorldNotifyQueue:ClearQuestNewQueue()
					QWorldNotifyQueue:ResetNotifyTime()
					arg_4_0:ShowTrackingMainQuest()
				end)
			else
				QWorldNotifyQueue:ClearQuestNewQueue()
				QWorldNotifyQueue:ResetNotifyTime()
				arg_4_0:ShowTrackingMainQuest()
			end

			return
		end

		arg_4_0.mainHomePage_.fadeAnim = true

		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)

	if arg_4_0.gmBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.gmBtn_, nil, function()
			if not Application.isEditor then
				return
			end

			if not QWorldGmView then
				QWorldGmView = import("game.qworld.gm.QWorldGmView")
				gameContext.routesCfg_.qworldGmView = {
					name = "qworldGmView",
					component = QWorldGmView
				}
			end

			JumpTools.OpenPageByJump("/qworldGmView", {})
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.noHideFx_ = true

	arg_9_0:ShowTrackingMainQuest()
	arg_9_0.questPanelAni_:Update(99999)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items_) do
		if iter_9_1.gameObject_.activeSelf then
			iter_9_1:GetAnimator():Update(99999)
		end
	end
end

function var_0_0.OnBehind(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.OnQWorldMainQuestUpdate(arg_12_0, arg_12_1)
	if arg_12_0.questIdNew_ or arg_12_0.questIdFinish_ then
		return
	end

	arg_12_0.conditionFx_ = arg_12_1 == arg_12_0.lastTrackingId_ and arg_12_0.lastTrackingId_ ~= -1 and arg_12_0.lastTrackingId_ == QWorldQuestTool.GetMainQuestTrackingId()

	arg_12_0:ShowTrackingMainQuest()
end

function var_0_0.OnQWorldQuestUpdateProgress(arg_13_0)
	if arg_13_0.questIdNew_ or arg_13_0.questIdFinish_ then
		return
	end

	if QWorldQuestTool.MainQuestHasRealtimeProgress(QWorldQuestTool.GetMainQuestTrackingId()) then
		arg_13_0:RefreshUI()
	end
end

function var_0_0.OnNotifyQueueEnd(arg_14_0)
	if arg_14_0.questIdNew_ or arg_14_0.questIdFinish_ then
		arg_14_0:ShowTrackingMainQuest()
	end
end

local function var_0_1(arg_15_0)
	local var_15_0 = 5381

	for iter_15_0 = 1, #arg_15_0 do
		var_15_0 = var_15_0 * 32 + var_15_0 + arg_15_0:byte(iter_15_0)
	end

	return var_15_0
end

local function var_0_2(arg_16_0)
	local var_16_0 = SandplayTaskCfg[arg_16_0]
	local var_16_1 = var_16_0.task_target
	local var_16_2 = QWorldQuestTool.GetQuestProgress(arg_16_0)

	return var_0_1(var_16_0.task_target) + var_16_2
end

function var_0_0.RefreshUI(arg_17_0)
	local var_17_0 = arg_17_0.questIdNew_ or arg_17_0.questIdFinish_ or QWorldQuestTool.GetMainQuestTrackingId()
	local var_17_1 = QWorldQuestData:GetMainQuestData(var_17_0)

	if not var_17_1 then
		SetActive(arg_17_0.questContentGo_, false)
		arg_17_0:_StopAllAnimatorTimer()
	else
		SetActive(arg_17_0.questContentGo_, arg_17_0.enabled_ ~= false)

		local var_17_2 = SandplayTaskMainCfg[var_17_1.id]

		arg_17_0.questTitleText_.text = var_17_2.title

		local var_17_3 = QWorldQuestTool.GetVisibleQuestIdList(var_17_1.id, true)
		local var_17_4 = #var_17_3
		local var_17_5 = arg_17_0.questIdNew_ and arg_17_0.itemsNew_ or arg_17_0.items_
		local var_17_6 = arg_17_0.questIdNew_ and arg_17_0.questNewGo_.transform or arg_17_0.questCondListTrans_
		local var_17_7 = arg_17_0.questIdNew_ and arg_17_0.questNewItemGo_ or arg_17_0.questCondItemGo_

		for iter_17_0, iter_17_1 in ipairs(var_17_5) do
			SetActive(iter_17_1.gameObject_, iter_17_0 <= var_17_4)
			arg_17_0:_StopAnimatorTimer(iter_17_1:GetAnimator())
		end

		for iter_17_2 = 1, var_17_4 do
			local var_17_8 = var_17_5[iter_17_2]

			if not var_17_8 then
				local var_17_9 = Object.Instantiate(var_17_7, var_17_6)

				SetActive(var_17_9, true)

				var_17_8 = QWorldSideQuestItem.New(var_17_9)
				var_17_5[iter_17_2] = var_17_8
			end

			local var_17_10 = var_17_3[iter_17_2]

			if arg_17_0.conditionFx_ and (var_17_8.__hash == nil or var_17_8.__hash ~= var_0_2(var_17_10)) then
				arg_17_0:_PlayAnimatorWithCallback(var_17_8:GetAnimator(), "UI_newtaskItem_xs", function()
					var_17_8:SetData(var_17_10)

					var_17_8.__hash = var_0_2(var_17_10)
				end)
			else
				var_17_8:SetData(var_17_10)

				var_17_8.__hash = var_0_2(var_17_10)
			end
		end

		if arg_17_0.questIdNew_ then
			arg_17_0.questTrackGo_.transform:SetAsLastSibling()
		end

		local var_17_11 = SandplayTaskMainCfg[var_17_0].main_task_type

		if var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
			arg_17_0.typeController_:SetSelectedState("main")
		elseif var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
			arg_17_0.typeController_:SetSelectedState("side")
		elseif var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
			arg_17_0.typeController_:SetSelectedState("explore")
		end

		arg_17_0.conditionFx_ = nil

		if arg_17_0.needTitleFx_ then
			if var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
				arg_17_0.questTitleAni_:Play("UI_questPanel_title_yellow", -1, 0)
			elseif var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
				arg_17_0.questTitleAni_:Play("UI_questPanel_title_blue", -1, 0)
			elseif var_17_11 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
				arg_17_0.questTitleAni_:Play("UI_questPanel_title_green", -1, 0)
			end

			arg_17_0.needTitleFx_ = nil
		else
			arg_17_0.questTitleAni_:Play("UI_questPanel_title", -1, 0)
		end
	end

	if arg_17_0.mainHomePage_.rewardPanelGo_.activeSelf then
		arg_17_0.mainHomePage_:UpdateLeftPanelLayout()
	end
end

function var_0_0.HideSideUI(arg_19_0, arg_19_1)
	if not arg_19_0.questContentGo_.activeSelf or arg_19_0.noHideFx_ then
		arg_19_0.noHideFx_ = nil

		arg_19_0:_StopAnimatorTimer(arg_19_0.questPanelAni_)

		if arg_19_1 then
			arg_19_1()
		end

		return
	end

	arg_19_0:_PlayAnimatorWithCallback(arg_19_0.questPanelAni_, "UI_questPanel_xs", function()
		if arg_19_1 then
			arg_19_1()
		else
			SetActive(arg_19_0.questContentGo_, false)
		end
	end)
end

function var_0_0.ShowMainQuestsFinish(arg_21_0, arg_21_1)
	arg_21_0.questIdNew_ = nil
	arg_21_0.questIdFinish_ = arg_21_1

	arg_21_0:HideSideUI(function()
		arg_21_0:_RemoveQuestCondition()
		arg_21_0:_RemoveNewQuestCondition()
		SetActive(arg_21_0.questFinishGo_, true)
		SetActive(arg_21_0.questContentGo_, true)
		arg_21_0.questPanelAni_:Play("UI_questPanel")
		arg_21_0.questPanelAni_:Update(0)
		arg_21_0:RefreshUI()
	end)
end

function var_0_0.ShowMainQuestsNew(arg_23_0, arg_23_1)
	arg_23_0.questIdNew_ = arg_23_1
	arg_23_0.questIdFinish_ = nil

	arg_23_0:HideSideUI(function()
		arg_23_0:_RemoveQuestCondition()
		SetActive(arg_23_0.questFinishGo_, false)
		SetActive(arg_23_0.questNewGo_, true)

		arg_23_0.needTitleFx_ = true

		SetActive(arg_23_0.questContentGo_, true)
		arg_23_0.questPanelAni_:Play("UI_questPanel")
		arg_23_0.questPanelAni_:Update(0)
		arg_23_0:RefreshUI()
	end)
end

function var_0_0.ShowTrackingMainQuest(arg_25_0)
	local var_25_0 = arg_25_0.lastTrackingId_ ~= QWorldQuestTool.GetMainQuestTrackingId() or arg_25_0.questIdNew_ ~= nil or arg_25_0.questIdFinish_ ~= nil

	arg_25_0.questIdNew_ = nil
	arg_25_0.questIdFinish_ = nil

	if var_25_0 then
		arg_25_0:HideSideUI(function()
			arg_25_0.lastTrackingId_ = QWorldQuestTool.GetMainQuestTrackingId()

			SetActive(arg_25_0.questFinishGo_, false)
			arg_25_0:_RemoveNewQuestCondition()
			SetActive(arg_25_0.questContentGo_, true)
			arg_25_0.questPanelAni_:Play("UI_questPanel")
			arg_25_0.questPanelAni_:Update(0)
			arg_25_0:RefreshUI()
		end)
	else
		arg_25_0.noHideFx_ = nil

		SetActive(arg_25_0.questFinishGo_, false)
		arg_25_0:_RemoveNewQuestCondition()
		SetActive(arg_25_0.questContentGo_, true)
		arg_25_0.questPanelAni_:Play("UI_questPanel")
		arg_25_0.questPanelAni_:Update(0)
		arg_25_0:RefreshUI()
	end
end

function var_0_0._RemoveQuestCondition(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.items_) do
		SetActive(iter_27_1.gameObject_, false)
	end
end

function var_0_0._RemoveNewQuestCondition(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemsNew_) do
		Object.Destroy(arg_28_0.items_.gameObject_)
		iter_28_1:Dispose()
	end

	SetActive(arg_28_0.questNewGo_, false)
end

function var_0_0._PlayAnimatorWithCallback(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0:_StopAnimatorTimer(arg_29_1)
	arg_29_1:Play(arg_29_2)
	arg_29_1:Update(0)

	local var_29_0 = Timer.New(function()
		local var_30_0 = arg_29_1:GetCurrentAnimatorStateInfo(0)
		local var_30_1 = var_30_0.length

		if var_30_0:IsName(arg_29_2) and var_30_0.normalizedTime >= 1 then
			if arg_29_0.animTimers_[arg_29_1] ~= nil then
				arg_29_0.animTimers_[arg_29_1]:Stop()

				arg_29_0.animTimers_[arg_29_1] = nil
			end

			if arg_29_3 ~= nil then
				arg_29_3()
			end
		end
	end, 0.033, -1)

	var_29_0:Start()

	arg_29_0.animTimers_[arg_29_1] = var_29_0
end

function var_0_0._StopAnimatorTimer(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.animTimers_[arg_31_1]

	if var_31_0 then
		var_31_0:Stop()

		arg_31_0.animTimers_[arg_31_1] = nil
	end
end

function var_0_0._StopAllAnimatorTimer(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.animTimers_) do
		iter_32_1:Stop()
	end

	arg_32_0.animTimers_ = {}
end

function var_0_0.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.items_) do
		iter_33_1:Dispose()
	end

	arg_33_0:_RemoveNewQuestCondition()
	arg_33_0:_StopAllAnimatorTimer()

	arg_33_0.gameObject_ = nil
	arg_33_0.transform_ = nil

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
