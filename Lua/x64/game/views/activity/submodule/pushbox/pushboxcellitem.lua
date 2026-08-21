local var_0_0 = class("PushBoxCellItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.overCon_ = ControllerUtil.GetController(arg_3_0.transform_, "over")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.bridgeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "bridge")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.coordinateX_ = arg_6_1
	arg_6_0.coordinateY_ = arg_6_2
	arg_6_0.type_ = arg_6_3

	arg_6_0:Reset()
	arg_6_0:RefreshType()
end

function var_0_0.Reset(arg_7_0)
	arg_7_0.onReadyEnterHandler_ = nil
	arg_7_0.actionPassHandler_ = nil
	arg_7_0.onPassedHandler_ = nil
	arg_7_0.onStopHandler_ = nil
	arg_7_0.isCanPass_ = true
end

function var_0_0.RefreshType(arg_8_0)
	arg_8_0.stateCon_:SetSelectedState(arg_8_0.type_)
	arg_8_0.bridgeCon_:SetSelectedState("false")
	arg_8_0.overCon_:SetSelectedState("false")

	if arg_8_0.type_ == PushBoxConst.CELL_TYPE.NORMAL then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.NormalActionPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.NormalStop)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.BLOCK then
		arg_8_0.isCanPass_ = false
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.GOAL then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.GoalActionPass)
		arg_8_0.onPassedHandler_ = handler(arg_8_0, arg_8_0.GoalPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.GoalStop)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.BRIDGE then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.BridgeActionPass)
		arg_8_0.onPassedHandler_ = handler(arg_8_0, arg_8_0.BridgePass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.NormalStop)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.UP_SLIDER then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.NormalActionPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.UpSlider)
		arg_8_0.onReadyEnterHandler_ = handler(arg_8_0, arg_8_0.UpSliderEnter)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.NormalActionPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.DownSlider)
		arg_8_0.onReadyEnterHandler_ = handler(arg_8_0, arg_8_0.DownSliderEnter)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.NormalActionPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.LeftSlider)
		arg_8_0.onReadyEnterHandler_ = handler(arg_8_0, arg_8_0.LeftSliderEnter)
	elseif arg_8_0.type_ == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
		arg_8_0.actionPassHandler_ = handler(arg_8_0, arg_8_0.NormalActionPass)
		arg_8_0.onStopHandler_ = handler(arg_8_0, arg_8_0.RightSlider)
		arg_8_0.onReadyEnterHandler_ = handler(arg_8_0, arg_8_0.RightSliderEnter)
	end
end

function var_0_0.IsCanPass(arg_9_0)
	return arg_9_0.isCanPass_
end

function var_0_0.GetType(arg_10_0)
	return arg_10_0.type_
end

function var_0_0.GetPos(arg_11_0)
	return arg_11_0.coordinateX_, arg_11_0.coordinateY_
end

function var_0_0.GetLoaclPosition(arg_12_0)
	return arg_12_0.transform_.localPosition.x, arg_12_0.transform_.localPosition.y
end

function var_0_0.OnReadyEnter(arg_13_0)
	if arg_13_0.onReadyEnterHandler_ then
		arg_13_0.onReadyEnterHandler_()
	end
end

function var_0_0.ActionPass(arg_14_0)
	if arg_14_0.actionPassHandler_ then
		arg_14_0.actionPassHandler_()
	end
end

function var_0_0.OnPass(arg_15_0)
	if arg_15_0.onPassedHandler_ then
		arg_15_0.onPassedHandler_()
	end
end

function var_0_0.OnStop(arg_16_0)
	if arg_16_0.onStopHandler_ then
		arg_16_0.onStopHandler_()
	end
end

function var_0_0.UpSliderEnter(arg_17_0)
	if not PushBoxTool:CheckCanPass(arg_17_0.coordinateX_, arg_17_0.coordinateY_, 0, -1) then
		return
	end

	arg_17_0:SliderEnter()
end

function var_0_0.DownSliderEnter(arg_18_0)
	if not PushBoxTool:CheckCanPass(arg_18_0.coordinateX_, arg_18_0.coordinateY_, 0, 1) then
		return
	end

	arg_18_0:SliderEnter()
end

function var_0_0.LeftSliderEnter(arg_19_0)
	if not PushBoxTool:CheckCanPass(arg_19_0.coordinateX_, arg_19_0.coordinateY_, -1, 0) then
		return
	end

	arg_19_0:SliderEnter()
end

function var_0_0.RightSliderEnter(arg_20_0)
	if not PushBoxTool:CheckCanPass(arg_20_0.coordinateX_, arg_20_0.coordinateY_, 1, 0) then
		return
	end

	arg_20_0:SliderEnter()
end

function var_0_0.SliderEnter(arg_21_0)
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_change")
end

function var_0_0.NormalStop(arg_22_0)
	arg_22_0.isCanPass_ = false
end

function var_0_0.GoalActionPass(arg_23_0)
	arg_23_0.isCanPass_ = true
end

function var_0_0.GoalPass(arg_24_0)
	arg_24_0.overCon_:SetSelectedState("false")
end

function var_0_0.GoalStop(arg_25_0)
	arg_25_0.overCon_:SetSelectedState("true")

	arg_25_0.isCanPass_ = false
end

function var_0_0.BridgeActionPass(arg_26_0)
	arg_26_0.isCanPass_ = false
end

function var_0_0.NormalActionPass(arg_27_0)
	arg_27_0.isCanPass_ = true
end

function var_0_0.BridgePass(arg_28_0)
	arg_28_0.bridgeCon_:SetSelectedState("true")
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_break")
end

function var_0_0.UpSlider(arg_29_0)
	if not PushBoxTool:CheckCanPass(arg_29_0.coordinateX_, arg_29_0.coordinateY_, 0, -1) then
		arg_29_0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, -1, arg_29_0.coordinateX_, arg_29_0.coordinateY_)
end

function var_0_0.DownSlider(arg_30_0)
	if not PushBoxTool:CheckCanPass(arg_30_0.coordinateX_, arg_30_0.coordinateY_, 0, 1) then
		arg_30_0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, 1, arg_30_0.coordinateX_, arg_30_0.coordinateY_)
end

function var_0_0.LeftSlider(arg_31_0)
	if not PushBoxTool:CheckCanPass(arg_31_0.coordinateX_, arg_31_0.coordinateY_, -1, 0) then
		arg_31_0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, -1, 0, arg_31_0.coordinateX_, arg_31_0.coordinateY_)
end

function var_0_0.RightSlider(arg_32_0)
	if not PushBoxTool:CheckCanPass(arg_32_0.coordinateX_, arg_32_0.coordinateY_, 1, 0) then
		arg_32_0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 1, 0, arg_32_0.coordinateX_, arg_32_0.coordinateY_)
end

function var_0_0.OnExit(arg_33_0)
	arg_33_0:Reset()
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0:RemoveAllListeners()
	arg_34_0:Reset()
	arg_34_0.super.Dispose(arg_34_0)
end

return var_0_0
