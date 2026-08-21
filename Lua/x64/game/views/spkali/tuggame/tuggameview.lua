local var_0_0 = class("TugGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_TugGameCheckpointUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selectIndex = 0
	arg_3_0.nowIndex = 1
	arg_3_0.isStopAni = true
	arg_3_0.passIndex = 0
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.nodeList = {}
	arg_5_0.pointlist = {}
	arg_5_0.selectIndex = nil
	arg_5_0.stageScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.RefreshItem), arg_5_0.uilistGo_, TugGameItem)
end

function var_0_0.RefreshItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetActivityID(arg_6_0.activityID_)
	arg_6_2:SetData(arg_6_0.pointlist[arg_6_1], arg_6_1, #arg_6_0.pointlist, arg_6_0)
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	if arg_7_0.selectIndex then
		local var_7_0 = arg_7_0.stageScroll_:GetItemByIndex(arg_7_0.selectIndex)

		if var_7_0 then
			var_7_0:SetSelect(false)
		end
	end

	arg_7_0.selectIndex = arg_7_1

	local var_7_1 = arg_7_0.stageScroll_:GetItemByIndex(arg_7_0.selectIndex)

	if var_7_1 then
		var_7_1:SetSelect(true)
	end

	local var_7_2 = arg_7_0.viewportTrs_.rect.width
	local var_7_3 = arg_7_0.selectIndex * 500
	local var_7_4 = var_7_3 - var_7_2 / 2

	if arg_7_0.isStopAni then
		var_7_4 = math.min(math.max(var_7_3 - var_7_2 / 2, 0), #arg_7_0.nodeList * 500 - var_7_2)
		arg_7_0.isStopAni = false
	end

	arg_7_0.moveLeanTween_ = LeanTween.moveLocalX(arg_7_0.contentTrs_.gameObject, -var_7_4, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		arg_7_0:StopLeanTween()
	end))

	local var_7_5 = (arg_7_0.selectIndex - 1) * 500
	local var_7_6 = arg_7_0.contentTrs_.sizeDelta.x - var_7_2

	SPKaliChallengeData:SaveTugPointPos(Mathf.Clamp(var_7_5 / var_7_6, 0, 1))
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.taskbtnBtn_, nil, "OnTask")

	for iter_9_0 = 1, 2 do
		arg_9_0:AddBtnListener(arg_9_0[string.format("nextbtn0%sBtn_", iter_9_0)], nil, function()
			arg_9_0:ChangeTab(iter_9_0)
		end)
	end
end

function var_0_0.StopLeanTween(arg_11_0)
	if arg_11_0.moveLeanTween_ then
		arg_11_0.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_11_0.moveLeanTween_.id)

		arg_11_0.moveLeanTween_ = nil
	end
end

function var_0_0.ChangeBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_KALI_DESC_2")
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0.uilistSr_.enabled = true
	arg_13_0.isStopAni = false

	if arg_13_0.selectIndex then
		local var_13_0 = arg_13_0.stageScroll_:GetItemByIndex(arg_13_0.selectIndex)

		if var_13_0 then
			var_13_0:SetSelect(false)
		end

		arg_13_0:UpdateSCorll()
	end

	arg_13_0:ChangeBar()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.activityID_ = arg_14_0.params_ and arg_14_0.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_TUGGAME

	arg_14_0:UpdateStage()
	arg_14_0:RegistEventListener(ACTIVITY_KALI_INFO, function()
		arg_14_0:UpdateStage()
	end)
end

function var_0_0.AddRedPoint(arg_16_0)
	return
end

function var_0_0.RemoveRedPoint(arg_17_0)
	return
end

function var_0_0.UpdateSelectMove(arg_18_0)
	arg_18_0.scrollviewSr_.horizontalNormalizedPosition = arg_18_0.passIndex / #arg_18_0.pointlist
end

function var_0_0.UpdateStage(arg_19_0)
	arg_19_0.pointlist = SpKaliTool.GetTugGameStageData(arg_19_0.activityID_)

	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.pointlist) do
		if iter_19_1 and iter_19_1.passState then
			var_19_0 = iter_19_0
		end
	end

	arg_19_0:UpdateSCorll()

	arg_19_0.texttittle02Text_.text = string.format("%s/%s", var_19_0, #arg_19_0.pointlist)
end

function var_0_0.UpdateSCorll(arg_20_0)
	local var_20_0 = Vector2.zero

	if SPKaliChallengeData.pos2 then
		var_20_0 = Vector2.New(SPKaliChallengeData.pos2, 0)
	end

	arg_20_0.stageScroll_:StartScrollByPosition(#arg_20_0.pointlist, var_20_0)
end

function var_0_0.OnExit(arg_21_0)
	var_0_0.super.OnExit(arg_21_0)
	arg_21_0:RemoveRedPoint()
	manager.windowBar:HideBar()

	arg_21_0.isStopAni = true
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)

	if arg_22_0.stageScroll_ then
		arg_22_0.stageScroll_:Dispose()
	end

	arg_22_0:StopLeanTween()
end

return var_0_0
