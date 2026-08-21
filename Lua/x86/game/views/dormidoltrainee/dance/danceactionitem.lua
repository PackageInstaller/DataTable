local var_0_0 = class("DanceActionItem", ReduxView)

var_0_0.startDrag = {}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.dragDummy = nil

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.selectController = arg_3_0.controllers_:GetController("sel")
	arg_3_0.moveController = arg_3_0.controllers_:GetController("move")
	arg_3_0.playStateController = arg_3_0.controllers_:GetController("play")
	arg_3_0.lockController = arg_3_0.controllers_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	local var_4_0 = arg_4_0.eventTriggerListener_

	var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, function(arg_5_0, arg_5_1)
		arg_4_0:OnBeginDrag(arg_5_1)
	end)
	var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, function(arg_6_0, arg_6_1)
		arg_4_0:OnDrag(arg_6_1)
	end)
	var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, function(arg_7_0, arg_7_1)
		arg_4_0:OnEndDrag(arg_7_1)
	end)
	var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, function(arg_8_0, arg_8_1)
		arg_4_0:OnPointerDown(arg_8_1)
	end)
	var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, function(arg_9_0, arg_9_1)
		if not arg_9_1.dragging then
			arg_4_0:OnPointerClick(arg_9_1)
		end
	end)
	arg_4_0:SetListener(var_4_0)
end

local function var_0_1(arg_10_0)
	return IdolTraineeData:DanceDIYActionAvailable(arg_10_0) and not IdolDanceCollectionData:IsCollectionRecordViewed(arg_10_0)
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	arg_11_0.actionID = arg_11_1

	local var_11_0 = IdolDanceDIYActionCfg[arg_11_1]

	arg_11_0.name_.text = var_11_0.name

	local var_11_1 = GetTipsF("IDOL_DANCE_ACTION_BEAT", var_11_0.beat)

	arg_11_0.beat_.text = var_11_1
	arg_11_0.beat2_.text = var_11_1
	arg_11_0.duration_.text = manager.time:DescCDTime4(arg_11_0:TryGetActionDuration())

	local var_11_2 = var_11_0.type

	arg_11_0.style_.text = GetTips(IdolTraineeConst.style[var_11_2])
	arg_11_0.color_.color = IdolTraineeConst.styleColor[var_11_2]

	local var_11_3 = false

	if IdolTraineeData:DanceDIYActionAvailable(arg_11_1) then
		var_11_3 = var_0_1(arg_11_1)

		arg_11_0.lockController:SetSelectedState("false")

		arg_11_0.lockMsg_.text = ""
	else
		arg_11_0.lockController:SetSelectedState("true")

		arg_11_0.lockMsg_.text = IdolTraineeTools.GetDanceDIYActionUnlockDesc(arg_11_1)
	end

	manager.redPoint:SetRedPointIndependent(arg_11_0.transform_, var_11_3, RedPointStyle.SHOW_NEW_TAG)
	arg_11_0.moveController:SetSelectedState("false")
end

function var_0_0.AssignBy(arg_12_0, arg_12_1)
	arg_12_0:SetData(arg_12_1.startDragActionID or arg_12_1.actionID)
end

function var_0_0.Clear(arg_13_0)
	arg_13_0:SetData(0)
end

function var_0_0.Swap(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.actionID
	local var_14_1 = arg_14_1.actionID

	arg_14_0:SetData(var_14_1)
	arg_14_1:SetData(var_14_0)
end

function var_0_0.SetSelected(arg_15_0, arg_15_1)
	arg_15_0.selectController:SetSelectedState(arg_15_1 and "true" or "false")
end

function var_0_0.MuteNewActionRedpoint(arg_16_0)
	IdolDanceCollectionAction.ViewCollectionRecord(arg_16_0.actionID)
end

local function var_0_2(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0.GetUICam()

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_17_1, arg_17_0, var_17_0)
end

function var_0_0.DragOnHandleArea(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.position

	return var_0_2(var_18_0, arg_18_0.dragOutHandle_)
end

function var_0_0.DragOutOfArea(arg_19_0, arg_19_1)
	return nullable(arg_19_0.dragDummy, "dragOnHandle")
end

function var_0_0.IsCurItemDragging(arg_20_0)
	return var_0_0.startDrag[arg_20_0.actionID]
end

function var_0_0.Selectable(arg_21_0)
	return arg_21_0.lockController:GetSelectedState() ~= "true"
end

function var_0_0.IsDragging(arg_22_0)
	return arg_22_0.startDragActionID ~= nil
end

function var_0_0.Dragable(arg_23_0)
	return arg_23_0:Selectable()
end

function var_0_0.OnBeginDrag(arg_24_0, arg_24_1)
	if arg_24_0.parentScroll then
		arg_24_0.parentScroll:OnBeginDrag(arg_24_1)

		if arg_24_0.actionID then
			var_0_0.startDrag[arg_24_0.actionID] = true
			arg_24_0.startDragActionID = arg_24_0.actionID
		end
	end

	arg_24_0.dragDummy = {}

	local var_24_0 = var_0_0.GetUICam():WorldToScreenPoint(arg_24_0.transform_.position)

	arg_24_0.dragDummy.dragOnHandle = arg_24_0:DragOnHandleArea(arg_24_1)
end

function var_0_0.OnDrag(arg_25_0, arg_25_1)
	if arg_25_0:Dragable() and arg_25_0:DragOutOfArea(arg_25_1) then
		if arg_25_0.dragDummy.obj == nil then
			arg_25_0:CreateDragDummy()
			manager.notify:CallFirstUpdateFunc("OnBeginDragDanceActionItem", arg_25_0, arg_25_1)
		end

		manager.notify:CallFirstUpdateFunc("OnDragDanceActionItem", arg_25_0, arg_25_1)
	else
		if arg_25_0.parentScroll then
			arg_25_0.parentScroll:OnDrag(arg_25_1)
		end

		if arg_25_0.dragDummy.obj then
			manager.notify:CallFirstUpdateFunc("OnEndDragDanceActionItem", arg_25_0, arg_25_1)
			arg_25_0:DisposeDragDummy()
		end
	end
end

function var_0_0.CreateDragDummy(arg_26_0)
	if arg_26_0.dragDummy.obj == nil then
		local var_26_0 = arg_26_0.dragDummyRootTrs or arg_26_0.transform_.parent
		local var_26_1 = GameObject.Instantiate(arg_26_0.gameObject_, var_26_0, true)
		local var_26_2 = Vector2(0.5, 0.5)
		local var_26_3 = var_26_1.transform.sizeDelta

		arg_26_0.dragDummy.obj = var_26_1
		arg_26_0.dragDummy.parent = var_26_0
		arg_26_0.dragDummy.ctrl = {}
		arg_26_0.dragDummy.pivot = var_26_2
		arg_26_0.dragDummy.size = var_26_3

		arg_26_0:BindCfgUI(var_26_1, arg_26_0.dragDummy.ctrl)

		local var_26_4 = arg_26_0.dragDummy.ctrl.controllers_
		local var_26_5 = var_26_4:GetController("move")
		local var_26_6 = var_26_4:GetController("play")

		var_26_5:SetSelectedState("true")
		var_26_6:SetSelectedState("normal")
	end
end

function var_0_0.DisposeDragDummy(arg_27_0)
	if arg_27_0.dragDummy and arg_27_0.dragDummy.obj then
		GameObject.Destroy(arg_27_0.dragDummy.obj)

		arg_27_0.dragDummy.obj = nil
		arg_27_0.dragDummy.ctrl = nil
	end
end

function var_0_0.OnEndDrag(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.startDragActionID or arg_28_0.actionID

	if arg_28_0.parentScroll and arg_28_0.startDrag then
		if var_28_0 then
			var_0_0.startDrag[var_28_0] = nil
		end

		arg_28_0.parentScroll:OnEndDrag(arg_28_1)
	end

	if nullable(arg_28_0.dragDummy, "obj") then
		manager.notify:CallFirstUpdateFunc("OnDropDanceActionItem", arg_28_0, arg_28_1)
		GameObject.Destroy(arg_28_0.dragDummy.obj)

		arg_28_0.dragDummy = nil
	end

	arg_28_0.startDragActionID = nil
end

function var_0_0.WillAcceptDrop(arg_29_0, arg_29_1)
	return false
end

function var_0_0.OnDropAccepted(arg_30_0, arg_30_1)
	arg_30_1:AssignBy(arg_30_0)
end

function var_0_0.OnPointerDown(arg_31_0)
	if arg_31_0:Selectable() then
		arg_31_0:MuteNewActionRedpoint()
		manager.notify:CallFirstUpdateFunc("OnDanceItemPointerDown", arg_31_0)
	end
end

function var_0_0.OnPointerClick(arg_32_0, arg_32_1)
	manager.notify:CallFirstUpdateFunc("OnDanceItemPointerClick", arg_32_0)
end

function var_0_0.GetAction(arg_33_0)
	return nullable(IdolDanceDIYActionCfg, arg_33_0.actionID, "anime_action")
end

function var_0_0.SetPlayState(arg_34_0, arg_34_1)
	arg_34_0.playStateController:SetSelectedState(arg_34_1)
end

function var_0_0.SetDragDummyRoot(arg_35_0, arg_35_1)
	arg_35_0.dragDummyRootTrs = arg_35_1
end

function var_0_0.OnPreviewStart(arg_36_0)
	arg_36_0:SetPlayState("play")

	arg_36_0.progress_.fillAmount = 0
end

function var_0_0.OnPreviewUpdate(arg_37_0, arg_37_1)
	arg_37_0.progress_.fillAmount = arg_37_1
end

function var_0_0.OnPreviewEnd(arg_38_0, arg_38_1)
	arg_38_0:SetPlayState(arg_38_1 and "pause" or "normal")

	arg_38_0.progress_.fillAmount = 0
end

function var_0_0.IsDuringPreview(arg_39_0)
	return arg_39_0.playStateController:GetSelectedState() == "play"
end

function var_0_0.TryGetActionDuration(arg_40_0)
	local var_40_0 = nullable(IdolDanceDIYActionCfg, arg_40_0.actionID, "duration")

	if var_40_0 and var_40_0 > 0 then
		return var_40_0
	end

	local var_40_1 = DormUtils.GetEntityData(DIYBridge.charaEID).cfgID

	return DanceGame.GetSequence(var_40_1, nil, arg_40_0:GetAction()).duration or 0
end

function var_0_0.Dispose(arg_41_0)
	arg_41_0:DisposeDragDummy()
	var_0_0.super.Dispose(arg_41_0)
end

return var_0_0
