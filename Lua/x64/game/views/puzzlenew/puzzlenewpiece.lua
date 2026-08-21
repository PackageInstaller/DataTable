local var_0_0 = class("PuzzleNewPiece", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.parentTrans_ = arg_1_1
	arg_1_0.index_ = arg_1_3
	arg_1_0.correctID_ = arg_1_4

	arg_1_0:Init()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.BeginDragFun)))
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.DragFun)))
	arg_4_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.EndDragFun)))
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
	arg_5_0.endDragCallback_ = nil

	arg_5_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_5_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_5_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.lastID_ = arg_7_0.curID_
	arg_7_0.curID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2

	arg_7_0:RefreshUI()

	if arg_7_3 and arg_7_0.lastID_ ~= arg_7_0.curID_ and arg_7_0:IsRightSide() then
		arg_7_0:PlayAnim()
	else
		arg_7_0:StopAnim()
	end
end

function var_0_0.SetRegionID(arg_8_0, arg_8_1)
	arg_8_0.regionID_ = arg_8_1
end

function var_0_0.GetRegionID(arg_9_0)
	return arg_9_0.regionID_
end

function var_0_0.SetSelectCallBack(arg_10_0, arg_10_1)
	arg_10_0.selectCallBack_ = arg_10_1
end

function var_0_0.RefreshUI(arg_11_0)
	if arg_11_0.curID_ ~= 0 then
		local var_11_0 = PuzzleNewCfg[arg_11_0.activityID_]
		local var_11_1 = PuzzleNewTools.GetPuzzlePosDic(arg_11_0.activityID_)[arg_11_0.curID_]
		local var_11_2 = var_11_0.picture_fragment_id[var_11_1]

		arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_11_0.path .. var_11_2)
	end

	SetActive(arg_11_0.gameObject_, arg_11_0.curID_ ~= 0)
	arg_11_0:Recover()
end

function var_0_0.Recover(arg_12_0)
	if arg_12_0.originPos_ then
		arg_12_0.transform_.localPosition = arg_12_0.originPos_
	end

	arg_12_0.originPos_ = nil

	arg_12_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_13_0)
	if arg_13_0.curID_ ~= 0 then
		if not arg_13_0:IsRightSide() then
			arg_13_0.stateController_:SetSelectedState("wrong")
		else
			arg_13_0.stateController_:SetSelectedState("correct")
		end
	else
		arg_13_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.IsRightSide(arg_14_0)
	return arg_14_0.correctID_ == arg_14_0.curID_
end

function var_0_0.IsEmpty(arg_15_0)
	return arg_15_0.curID_ == 0
end

function var_0_0.GetCurID(arg_16_0)
	return arg_16_0.curID_
end

function var_0_0.RegistEndDragCallback(arg_17_0, arg_17_1)
	arg_17_0.endDragCallback_ = arg_17_1
end

function var_0_0.BeginDragFun(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.originPos_ = arg_18_0.transform_.localPosition

	arg_18_0.transform_:SetAsLastSibling()
	arg_18_0.stateController_:SetSelectedState("normal")
end

function var_0_0.DragFun(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_19_1, var_19_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_19_0.parentTrans_, arg_19_2.position, var_19_0, nil)

	arg_19_0.transform_.localPosition = var_19_2
end

function var_0_0.EndDragFun(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.endDragCallback_ then
		arg_20_0.endDragCallback_(arg_20_0.index_, arg_20_2)
	end
end

function var_0_0.PlayAnim(arg_21_0)
	SetActive(arg_21_0.correctAnim_.gameObject, true)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
end

function var_0_0.StopAnim(arg_22_0)
	SetActive(arg_22_0.correctAnim_.gameObject, false)
end

return var_0_0
