local var_0_0 = class("AutoChessCardDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Illustrated/Activity_AutoChess_IllustratedDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rightPanelController_ = arg_4_0.controller_:GetController("rightPanel")
	arg_4_0.switchController_ = arg_4_0.controller_:GetController("switch")
	arg_4_0.sunglassesController_ = arg_4_0.controller_:GetController("sunglasses")
	arg_4_0.tabListController_ = arg_4_0.controller_:GetController("tab")
	arg_4_0.tabSwitchController_ = arg_4_0.tabController_:GetController("switch")
	arg_4_0.tipsItem_ = AutoChessCardTipsItem.New(arg_4_0.tipsGo_)
	arg_4_0.mixItem_ = AutoChessCardMixItem.New(arg_4_0.mixGo_)
	arg_4_0.cardItem_ = AutoChessCardItem.New(arg_4_0.cardGo_)
	arg_4_0.chessItem_ = AutoChessShowItem.New(arg_4_0.chessGo_)
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.uRBtn_, nil, function()
		arg_5_0.cardId_ = arg_5_0.cardList[AutoChessCardConst.CARD_TYPE.UR]

		arg_5_0:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 3,
			activity_id = AutoChessData:GetActivityID(),
			item_id = arg_5_0.cardId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.sRBtn_, nil, function()
		arg_5_0.cardId_ = arg_5_0.cardList[AutoChessCardConst.CARD_TYPE.SR]

		arg_5_0:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 2,
			activity_id = AutoChessData:GetActivityID(),
			item_id = arg_5_0.cardId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rBtn_, nil, function(arg_8_0)
		arg_5_0.cardId_ = arg_5_0.cardList[AutoChessCardConst.CARD_TYPE.R]

		arg_5_0:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 1,
			activity_id = AutoChessData:GetActivityID(),
			item_id = arg_5_0.cardId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.mixBtn_, nil, function()
		arg_5_0.rightPanelController_:SetSelectedState("mixPanel")
		arg_5_0.mixItem_:SetData(arg_5_0.cardId_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.sunglassesOnBtn_, nil, function()
		if arg_5_0.isOpen then
			return
		end

		arg_5_0.isOpen = true

		AutoChessCardAction.RequestSunglasses(handler(arg_5_0, arg_5_0.OnSunglassesBack), 1)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_special_change_touch",
			type = 1,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.sunglassesOffBtn_, nil, function()
		if not arg_5_0.isOpen then
			return
		end

		arg_5_0.isOpen = false

		AutoChessCardAction.RequestSunglasses(handler(arg_5_0, arg_5_0.OnSunglassesBack), 2)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_special_change_touch",
			type = 2,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.leftBtn_, nil, function()
		local var_12_0 = AutoChessCardCfg[arg_5_0.cardId_]
		local var_12_1 = AutoChessCardCfg.get_id_list_by_type_is_card_pool[var_12_0.type][1]
		local var_12_2 = table.indexof(var_12_1, arg_5_0.cardId_)

		if var_12_2 == 1 then
			arg_5_0.cardId_ = var_12_1[#var_12_1]
		else
			arg_5_0.cardId_ = var_12_1[var_12_2 - 1]
		end

		arg_5_0:Refresh()
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightBtn_, nil, function()
		local var_13_0 = AutoChessCardCfg[arg_5_0.cardId_]
		local var_13_1 = AutoChessCardCfg.get_id_list_by_type_is_card_pool[var_13_0.type][1]
		local var_13_2 = table.indexof(var_13_1, arg_5_0.cardId_)

		if var_13_2 == #var_13_1 then
			arg_5_0.cardId_ = var_13_1[1]
		else
			arg_5_0.cardId_ = var_13_1[var_13_2 + 1]
		end

		arg_5_0:Refresh()
		arg_5_0:RefreshUI()
	end)
end

function var_0_0.OnSunglassesBack(arg_14_0)
	arg_14_0:RefreshSwitch()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_15_0, arg_15_0.OnBeginDragFun)))
	arg_15_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_15_0, arg_15_0.OnDragFun)))
	arg_15_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_15_0, arg_15_0.OnEndDragFun)))

	arg_15_0.cardId_ = arg_15_0.params_.cardId

	arg_15_0:Refresh()
end

function var_0_0.Refresh(arg_16_0)
	local var_16_0 = AutoChessCardCfg[arg_16_0.cardId_].group_id

	arg_16_0.chessId_ = AutoChessCardTools.GetChessId(arg_16_0.cardId_)
	arg_16_0.cardList = AutoChessCardCfg.get_id_list_by_group_id[var_16_0]

	table.sort(arg_16_0.cardList, function(arg_17_0, arg_17_1)
		local var_17_0 = AutoChessCardCfg[arg_17_0]
		local var_17_1 = AutoChessCardCfg[arg_17_1]

		return var_17_0.type < var_17_1.type
	end)
	arg_16_0.tabListController_:SetSelectedIndex(#arg_16_0.cardList - 1)
	arg_16_0:RefreshSwitch()
end

function var_0_0.RefreshSwitch(arg_18_0)
	if AutoChessCardData:GetSunglassesState() == 0 then
		arg_18_0.switchController_:SetSelectedState("hide")
		arg_18_0.chessItem_:RefreshSunglassesState(0)
	elseif AutoChessCardData:GetSunglassesState() == 1 then
		arg_18_0.isOpen = true

		arg_18_0.switchController_:SetSelectedState("show")
		arg_18_0.sunglassesController_:SetSelectedState("on")
		arg_18_0.chessItem_:RefreshSunglassesState(1)
	else
		arg_18_0.isOpen = false

		arg_18_0.switchController_:SetSelectedState("show")
		arg_18_0.sunglassesController_:SetSelectedState("off")
		arg_18_0.chessItem_:RefreshSunglassesState(2)
	end
end

function var_0_0.RefreshUI(arg_19_0)
	local var_19_0 = AutoChessCardCfg[arg_19_0.cardId_]

	arg_19_0.cardItem_:SetData(arg_19_0.cardId_, arg_19_0.URFactoryItem_:GetItem(arg_19_0.cardId_))
	arg_19_0.chessItem_:SetData(arg_19_0.cardId_, arg_19_0.chessId_, AutoChessCardData:GetSunglassesState())

	if AutoChessCardData:GetCardNum(arg_19_0.cardId_) > 0 then
		arg_19_0.isDragable_ = true

		arg_19_0.cardItem_:SetPositionState(true)
		arg_19_0.cardItem_:SetGreyState(false)
		arg_19_0.anim_:Play("Container_light_ani")
	else
		arg_19_0.isDragable_ = false

		arg_19_0.cardItem_:SetPositionState(false)
		arg_19_0.cardItem_:SetGreyState(true)
		arg_19_0.anim_:Play("default")
	end

	arg_19_0.rightPanelController_:SetSelectedState("tipsPanel")
	arg_19_0.tipsItem_:SetData(arg_19_0.chessId_, arg_19_0.cardId_)

	if var_19_0.type == AutoChessCardConst.CARD_TYPE.R then
		arg_19_0.tabSwitchController_:SetSelectedState("state2")
	elseif var_19_0.type == AutoChessCardConst.CARD_TYPE.SR then
		arg_19_0.tabSwitchController_:SetSelectedState("state1")
	else
		arg_19_0.tabSwitchController_:SetSelectedState("state0")
	end
end

function var_0_0.OnBeginDragFun(arg_20_0)
	if not arg_20_0.isDragable_ then
		return
	end

	arg_20_0.isDraging_ = true

	local var_20_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_20_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_20_2 = {}
	local var_20_3, var_20_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_20_0.cardTrans_, var_20_0, var_20_1, var_20_2)

	arg_20_0.dragStartPos_ = var_20_4

	arg_20_0.anim_:Play("default")

	arg_20_0.anim_.applyRootMotion = true
	arg_20_0.initRotation_ = arg_20_0.cardTrans_.localEulerAngles
end

function var_0_0.OnDragFun(arg_21_0)
	if not arg_21_0.isDragable_ then
		return
	end

	if not arg_21_0.isDraging_ then
		return
	end

	local var_21_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_21_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_21_2 = {}
	local var_21_3, var_21_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_21_0.cardTrans_, var_21_0, var_21_1, var_21_2)
	local var_21_5 = var_21_4
	local var_21_6 = var_21_5.x - arg_21_0.dragStartPos_.x
	local var_21_7 = var_21_5.y - arg_21_0.dragStartPos_.y
	local var_21_8 = arg_21_0.initRotation_.x + var_21_7 * 0.1
	local var_21_9 = arg_21_0.initRotation_.y - var_21_6 * 0.1
	local var_21_10 = math.min(30, math.max(-30, arg_21_0:NormalizeAngle(var_21_8)))
	local var_21_11 = math.min(30, math.max(-30, arg_21_0:NormalizeAngle(var_21_9)))

	arg_21_0.cardTrans_.localEulerAngles = Vector3.New(var_21_10, var_21_11, arg_21_0.cardTrans_.localEulerAngles.z)
end

function var_0_0.OnEndDragFun(arg_22_0, arg_22_1)
	if not arg_22_0.isDragable_ then
		return
	end

	arg_22_0.isDraging_ = false
	arg_22_0.anim_.applyRootMotion = false

	arg_22_0.anim_:Play("Container_light_ani")
end

function var_0_0.NormalizeAngle(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 % 360

	if var_23_0 > 180 then
		var_23_0 = var_23_0 - 360
	elseif var_23_0 < -180 then
		var_23_0 = var_23_0 + 360
	end

	return var_23_0
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:RefreshUI()
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR
	})
end

function var_0_0.OnExit(arg_25_0)
	manager.windowBar:HideBar()
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_25_0.anim_:Rebind()
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.cardItem_:Dispose()
	arg_26_0.tipsItem_:Dispose()
	arg_26_0.mixItem_:Dispose()
	arg_26_0.chessItem_:Dispose()
	arg_26_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
