local var_0_0 = class("AgoraOpView", import("Mod.Island.Core.View.IslandOpView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandAgoraOpUI"
end

function var_0_0.OnInit(arg_2_0, arg_2_1)
	var_0_0.super.OnInit(arg_2_0, arg_2_1)
	arg_2_0.opUI:SetAsFirstSibling()

	arg_2_0.agoraPanel = arg_2_0._tf:Find("agora_op_btns")
	arg_2_0.lookBtn = arg_2_0.opUI:Find("look")
	arg_2_0.moveBtn = arg_2_0.opUI:Find("move")
	arg_2_0.agoraMoveBtn = arg_2_0.agoraPanel:Find("move")
	arg_2_0.agoraMoveDirTr = arg_2_0._tf:Find("agora_op_btns/move/Area/dir")
	arg_2_0.dragBtn = arg_2_0.agoraPanel:Find("drag")
	arg_2_0.confirmBtn = arg_2_0.dragBtn:Find("ok")
	arg_2_0.removeBtn = arg_2_0.dragBtn:Find("cancel")
	arg_2_0.rotationBtn = arg_2_0.dragBtn:Find("rotation")
	arg_2_0.signInTip = arg_2_0._tf:Find("adapt/signIn_tip")
	arg_2_0.isDraging = false

	arg_2_0:ShowOrHideGameObject(arg_2_0.agoraPanel, false)

	arg_2_0.animator = arg_2_0.agoraPanel:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0.agoraPanel:GetComponent(typeof(DftAniEvent))

	setText(arg_2_0.signInTip:Find("Text"), i18n("island_agora_signIn_tip"))
	arg_2_0:UpdateSignInTip()

	return
end

function var_0_0.DisablePlayerOp(arg_3_0)
	var_0_0.super.DisablePlayerOp(arg_3_0)
	setActive(arg_3_0.signInTip, false)

	return
end

function var_0_0.EnablePlayerOp(arg_4_0)
	var_0_0.super.EnablePlayerOp(arg_4_0)
	arg_4_0:UpdateSignInTip()

	return
end

function var_0_0.OnUpdate(arg_5_0)
	var_0_0.super.OnUpdate(arg_5_0)

	if arg_5_0.activeMould and not arg_5_0.isDraging then
		arg_5_0:UpdateDragPosition(arg_5_0.activeMould)
	end

	return
end

function var_0_0.UpdateSignInTip(arg_6_0)
	if not arg_6_0:GetView():IsSelfIsland() then
		setActive(arg_6_0.signInTip, false)
	else
		local var_6_0 = arg_6_0:GetView():GetIsland():GetSignInAgency()

		setActive(arg_6_0.signInTip, var_6_0:CanSignIn())
	end

	return
end

function var_0_0.ShowMoveBtn(arg_7_0, arg_7_1)
	arg_7_0:ShowOrHideGameObject(arg_7_0.agoraPanel, arg_7_1)

	return
end

function var_0_0.ActiveDragBtn(arg_8_0, arg_8_1)
	arg_8_0.dftAniEvent:SetEndEvent(nil)
	arg_8_0:UpdateDragPosition(arg_8_1)

	arg_8_0.activeMould = arg_8_1

	arg_8_0.animator:Stop()
	arg_8_0.dftAniEvent:SetEndEvent(function()
		arg_8_0.dftAniEvent:SetEndEvent(nil)
		arg_8_0:AddDraglistener(arg_8_1)

		return
	end)
	arg_8_0.animator:Play("anim_IslandAgoraOpUI_Agora_In")

	return
end

function var_0_0.InActiveDragBtn(arg_10_0)
	arg_10_0.activeMould = nil
	arg_10_0.isDraging = false

	arg_10_0.animator:Stop()
	removeOnButton(arg_10_0.confirmBtn)
	removeOnButton(arg_10_0.removeBtn)
	removeOnButton(arg_10_0.rotationBtn)
	arg_10_0.dftAniEvent:SetEndEvent(nil)
	arg_10_0.dftAniEvent:SetEndEvent(function()
		arg_10_0.dftAniEvent:SetEndEvent(nil)
		arg_10_0:RemoveDraglistener()

		arg_10_0.dragBtn.localPosition = Vector3(10000, 10000, 0)

		return
	end)
	arg_10_0.animator:Play("anim_IslandAgoraOpUI_Agora_Out")

	return
end

function var_0_0.UpdateDragPosition(arg_12_0, arg_12_1)
	arg_12_0.dragBtn.localPosition = AgoraCalc.ScreenPosition2LocalPosition(arg_12_0.dragBtn.parent, (AgoraCalc.WorldPosition2ScreenPosition(arg_12_1.root.position)))

	return
end

function var_0_0.AddDraglistener(arg_13_0, arg_13_1)
	local var_13_0 = GetOrAddComponent(arg_13_0.dragBtn, typeof(EventTriggerListener))

	var_13_0:AddBeginDragFunc(function(arg_14_0, arg_14_1)
		arg_13_0.isDraging = true

		arg_13_0:Op("BeginDragItem")

		return
	end)
	var_13_0:AddDragFunc(function(arg_15_0, arg_15_1)
		arg_13_0:Op("DragItem", (AgoraCalc.ScreenPostion2MapPosition(arg_15_1.position)))
		arg_13_0:UpdateDragPosition(arg_13_1)

		return
	end)
	var_13_0:AddDragEndFunc(function(arg_16_0, arg_16_1)
		arg_13_0:Op("EndDragItem", (AgoraCalc.ScreenPostion2MapPosition(arg_16_1.position)))
		arg_13_0:UpdateDragPosition(arg_13_1)

		arg_13_0.isDraging = false

		return
	end)
	onButton(arg_13_0, arg_13_0.confirmBtn, function()
		arg_13_0:Op("ConfirmSelectedItem")

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.removeBtn, function()
		arg_13_0:Op("RemovePlaceItem")

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.rotationBtn, function()
		arg_13_0:Op("RotationItem")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RemoveDraglistener(arg_20_0)
	local var_20_0 = GetOrAddComponent(arg_20_0.dragBtn, typeof(EventTriggerListener))

	var_20_0:AddBeginDragFunc(nil)
	var_20_0:AddDragFunc(nil)
	var_20_0:AddDragEndFunc(nil)
	removeOnButton(arg_20_0.confirmBtn)
	removeOnButton(arg_20_0.removeBtn)

	return
end

function var_0_0.EnterMode(arg_21_0, arg_21_1)
	if arg_21_1 == AgoraView.MODE_OVERVIEW then
		arg_21_0:ShowOrHideGameObject(arg_21_0.moveBtn, true)
		arg_21_0:ShowOrHideGameObject(arg_21_0.agoraPanel, false)
		arg_21_0:TryEnablePlayerOp()
		arg_21_0.inputController:ActivePlayerActionMap(IslandConst.PLAYER_INPUT_INDEX)
		arg_21_0:RemoveEditModeListener()
	elseif arg_21_1 == AgoraView.MODE_EDIT then
		arg_21_0:ShowOrHideGameObject(arg_21_0.moveBtn, false)
		arg_21_0:ShowOrHideGameObject(arg_21_0.agoraPanel, true)

		if not arg_21_0.mode or arg_21_0.mode == AgoraView.MODE_OVERVIEW then
			arg_21_0:TryDisablePlayerOp()
		end

		arg_21_0.inputController:ActivePlayerActionMap(IslandConst.AGORA_INPUT_INDEX)
		arg_21_0.inputController:EnableAgoraLook()
		arg_21_0:RemovePaveTileModeListener()
		arg_21_0:AddEditModeListener()
	elseif arg_21_1 == AgoraView.MODE_PAVE_TILE then
		arg_21_0.inputController:DisableAgoraLook()
		arg_21_0:RemoveEditModeListener()
		arg_21_0:AddPaveTileModeListener()
	end

	arg_21_0.mode = arg_21_1

	return
end

function var_0_0.OnEditModeClick(arg_22_0, arg_22_1)
	local var_22_0 = IslandHelper.Raycast4Agora(arg_22_1, IslandConst.UNIT_LIST_AGORA, IslandConst.LAYER_WORLDMAP3D)

	if var_22_0 > 0 then
		arg_22_0:Op("TrySelectItemById", var_22_0)
	end

	return
end

function var_0_0.AddEditModeListener(arg_23_0)
	local var_23_0 = GetOrAddComponent(arg_23_0.lookBtn, typeof(EventTriggerListener))
	local var_23_1

	var_23_0:AddPointDownFunc(function(arg_24_0, arg_24_1)
		var_23_1 = arg_24_1.position

		return
	end)
	var_23_0:AddPointUpFunc(function(arg_25_0, arg_25_1)
		if not var_23_1 or var_23_1 ~= arg_25_1.position then
			return
		end

		arg_23_0:OnEditModeClick(arg_25_1.position)

		var_23_1 = nil

		return
	end)

	return
end

function var_0_0.RemoveEditModeListener(arg_26_0)
	local var_26_0 = arg_26_0.lookBtn:GetComponent(typeof(EventTriggerListener))

	if var_26_0 then
		var_26_0:AddPointDownFunc(nil)
		var_26_0:AddPointUpFunc(nil)
	end

	return
end

function var_0_0.AddPaveTileModeListener(arg_27_0)
	local var_27_0 = GetOrAddComponent(arg_27_0.lookBtn, typeof(EventTriggerListener))
	local var_27_1

	var_27_0:AddPointDownFunc(function(arg_28_0, arg_28_1)
		var_27_1 = arg_28_1.position

		return
	end)
	var_27_0:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if not var_27_1 or var_27_1 ~= arg_29_1.position then
			return
		end

		arg_27_0:Op("OpLayer", (AgoraCalc.ScreenPostion2MapPosition(arg_29_1.position)))

		return
	end)
	var_27_0:AddBeginDragFunc(function(arg_30_0, arg_30_1)
		return
	end)
	var_27_0:AddDragFunc(function(arg_31_0, arg_31_1)
		arg_27_0:Op("OpLayer", (AgoraCalc.ScreenPostion2MapPosition(arg_31_1.position)))

		return
	end)
	var_27_0:AddDragEndFunc(function(arg_32_0, arg_32_1)
		return
	end)

	return
end

function var_0_0.RemovePaveTileModeListener(arg_33_0)
	local var_33_0 = arg_33_0.lookBtn:GetComponent(typeof(EventTriggerListener))

	if var_33_0 then
		var_33_0:AddPointDownFunc(nil)
		var_33_0:AddPointUpFunc(nil)
		var_33_0:AddBeginDragFunc(nil)
		var_33_0:AddDragFunc(nil)
		var_33_0:AddDragEndFunc(nil)
	end

	return
end

function var_0_0.OnDestroy(arg_34_0)
	var_0_0.super.OnDestroy(arg_34_0)
	arg_34_0:RemovePaveTileModeListener()
	arg_34_0:RemoveDraglistener()
	arg_34_0.dftAniEvent:SetEndEvent(nil)

	return
end

return var_0_0
