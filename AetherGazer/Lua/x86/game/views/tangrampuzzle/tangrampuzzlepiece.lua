local var_0_0 = class("PuzzleNewPiece", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.globalIndex_ = arg_1_2
	arg_1_0.correctID_ = arg_1_3

	arg_1_0:Init()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.icon_.alphaHitTestMinimumThreshold = 1
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.highLightController_ = ControllerUtil.GetController(arg_3_0.transform_, "highLight")
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.enterAnimController_ = ControllerUtil.GetController(arg_3_0.transform_, "enterAnim")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.draging_ == true then
			return
		end

		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		manager.audio:PlayEffect("ui_system", "button", "")

		if arg_4_0.clickCallback_ then
			arg_4_0.clickCallback_(arg_4_0.globalIndex_)
		end
	end)
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.BeginDragFun)))
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.DragFun)))
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.EndDragFun)))
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.clickCallback_ = nil
	arg_6_0.endDragCallback_ = nil
	arg_6_0.beginDragCallback_ = nil

	arg_6_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_6_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_6_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_6_0:StopLeanTween()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.draging_ = false

	arg_7_0:StopAnimTimer()
	arg_7_0:StopLeanTween()
	arg_7_0:RecoverTrans()
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.lastID_ = arg_9_0.curID_
	arg_9_0.curID_ = arg_9_1
	arg_9_0.activityID_ = arg_9_2

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	if arg_10_0.curID_ ~= 0 then
		local var_10_0 = TangramPuzzleCfg[arg_10_0.activityID_]
		local var_10_1 = TangramPuzzleTools.GetPuzzlePictureDic(arg_10_0.activityID_)[arg_10_0.curID_]

		arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_10_0.path .. var_10_1)

		arg_10_0.icon_:SetNativeSize()
	end

	SetActive(arg_10_0.gameObject_, arg_10_0.curID_ ~= 0)
	arg_10_0:StopAnimTimer()
	arg_10_0.enterAnimController_:SetSelectedState("false")
end

function var_0_0.SetRegionID(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.regionID_ = arg_11_1
	arg_11_0.localIndex_ = arg_11_2
end

function var_0_0.GetCurRegion(arg_12_0)
	return arg_12_0.regionID_, arg_12_0.localIndex_
end

function var_0_0.GetGlobalIndex(arg_13_0)
	return arg_13_0.globalIndex_
end

function var_0_0.SetSelectCallBack(arg_14_0, arg_14_1)
	arg_14_0.selectCallBack_ = arg_14_1
end

function var_0_0.RefreshStatus(arg_15_0)
	return
end

function var_0_0.SetHighLight(arg_16_0, arg_16_1)
	arg_16_0.highLightController_:SetSelectedState(arg_16_1 and "on" or "off")
end

function var_0_0.SetSelect(arg_17_0, arg_17_1)
	arg_17_0.selectController_:SetSelectedState(arg_17_1 and "on" or "off")
end

function var_0_0.IsRightSide(arg_18_0)
	return arg_18_0.correctID_ == arg_18_0.curID_
end

function var_0_0.IsEmpty(arg_19_0)
	return arg_19_0.curID_ == 0
end

function var_0_0.GetCurID(arg_20_0)
	return arg_20_0.curID_
end

function var_0_0.SetTransParent(arg_21_0, arg_21_1)
	arg_21_0.originParent_ = arg_21_0.transform_.parent

	arg_21_0.transform_:SetParent(arg_21_1)
end

function var_0_0.RecoverTrans(arg_22_0)
	if arg_22_0.originPos_ then
		arg_22_0.transform_.position = arg_22_0.originPos_
		arg_22_0.originPos_ = nil
	end

	if arg_22_0.originParent_ then
		arg_22_0.transform_:SetParent(arg_22_0.originParent_)

		arg_22_0.originParent_ = nil
	end
end

function var_0_0.RegistClickCallback(arg_23_0, arg_23_1)
	arg_23_0.clickCallback_ = arg_23_1
end

function var_0_0.RegistBeginDragCallback(arg_24_0, arg_24_1)
	arg_24_0.beginDragCallback_ = arg_24_1
end

function var_0_0.RegistEndDragCallback(arg_25_0, arg_25_1)
	arg_25_0.endDragCallback_ = arg_25_1
end

function var_0_0.BeginDragFun(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0.draging_ then
		return
	end

	arg_26_0.draging_ = true

	if arg_26_0.beginDragCallback_ and not arg_26_0.beginDragCallback_(arg_26_0.globalIndex_) then
		arg_26_0.draging_ = false

		return
	end

	arg_26_0.originPos_ = arg_26_0.transform_.position
	arg_26_0.canvasRate_ = manager.ui.canvasSize_.x / Screen.width
end

function var_0_0.DragFun(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.draging_ then
		return
	end

	local var_27_0 = arg_27_2.delta * arg_27_0.canvasRate_

	arg_27_0.transform_:SetLocalPositionDelta(var_27_0.x, var_27_0.y, 0)
end

function var_0_0.EndDragFun(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0.draging_ then
		return
	end

	arg_28_0.draging_ = false

	if arg_28_0.endDragCallback_ then
		arg_28_0.endDragCallback_(arg_28_0.globalIndex_, arg_28_2)
	end
end

function var_0_0.UpdatePosition(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.originPos_ = arg_29_0.transform_.position

	arg_29_0:StopLeanTween()

	arg_29_0.posLeanTween_ = LeanTween.move(arg_29_0.gameObject_, arg_29_1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if arg_29_2 then
			arg_29_2()
		end

		arg_29_0:StopLeanTween()
	end))
end

function var_0_0.PlayEnterAnim(arg_31_0, arg_31_1)
	SetActive(arg_31_0.gameObject_, true)
	arg_31_0.enterAnimController_:SetSelectedState("true")
	arg_31_0:PlayAnim(arg_31_0.anim_, "puzzleTemplate_enter", arg_31_1)
end

function var_0_0.StopAnimTimer(arg_32_0)
	if arg_32_0.animtimer_ then
		arg_32_0.animtimer_:Stop()

		arg_32_0.animtimer_ = nil
	end
end

function var_0_0.StopLeanTween(arg_33_0)
	if arg_33_0.posLeanTween_ then
		arg_33_0.posLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_33_0.posLeanTween_.id)

		arg_33_0.posLeanTween_ = nil
	end
end

function var_0_0.PlayAnim(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if not arg_34_1 then
		if arg_34_3 then
			arg_34_3()
		end

		return
	end

	arg_34_0:StopAnimTimer()

	arg_34_1.enabled = true

	arg_34_1:Play(arg_34_2, -1, 0)
	arg_34_1:Update(0)

	arg_34_0.animtimer_ = Timer.New(function()
		local var_35_0 = arg_34_1:GetCurrentAnimatorStateInfo(0)

		if var_35_0:IsName(arg_34_2) and var_35_0.normalizedTime >= 1 then
			arg_34_0:StopAnimTimer()

			arg_34_1.enabled = false

			if arg_34_3 then
				arg_34_3()
			end
		end
	end, 0.033, -1)

	arg_34_0.animtimer_:Start()
end

return var_0_0
