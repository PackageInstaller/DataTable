class = var_0_10000

local var_0_0 = "AgoraOpView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandOpView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraOpUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	var_0_1.super.OnInit(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.opUI

	var_2.SetAsFirstSibling(var_2_0)

	local var_2_1 = arg_2_0._tf

	arg_2_0.agoraPanel = var_2.Find(var_2_1, "agora_op_btns")

	local var_2_2 = arg_2_0.opUI

	arg_2_0.lookBtn = var_2.Find(var_2_2, "look")

	local var_2_3 = arg_2_0.opUI

	arg_2_0.moveBtn = var_2.Find(var_2_3, "move")

	local var_2_4 = arg_2_0.agoraPanel

	arg_2_0.agoraMoveBtn = var_2.Find(var_2_4, "move")

	local var_2_5 = arg_2_0._tf

	arg_2_0.agoraMoveDirTr = var_2.Find(var_2_5, "agora_op_btns/move/Area/dir")

	local var_2_6 = arg_2_0.agoraPanel

	arg_2_0.dragBtn = var_2.Find(var_2_6, "drag")

	local var_2_7 = arg_2_0.dragBtn

	arg_2_0.confirmBtn = var_2.Find(var_2_7, "ok")

	local var_2_8 = arg_2_0.dragBtn

	arg_2_0.removeBtn = var_2.Find(var_2_8, "cancel")

	local var_2_9 = arg_2_0.dragBtn

	arg_2_0.rotationBtn = var_2.Find(var_2_9, "rotation")

	local var_2_10 = arg_2_0._tf

	arg_2_0.signInTip = var_2.Find(var_2_10, "adapt/signIn_tip")
	arg_2_0.isDraging = false

	arg_2_0:ShowOrHideGameObject(arg_2_0.agoraPanel, false)

	local var_2_11 = arg_2_0.agoraPanel
	local var_2_12 = var_2.GetComponent

	typeof = var_4
	Animation = var_5
	arg_2_0.animator = var_2_12(var_2_11, var_4(var_5))

	local var_2_13 = arg_2_0.agoraPanel
	local var_2_14 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5
	arg_2_0.dftAniEvent = var_2_14(var_2_13, var_4(var_5))
	setText = var_2

	local var_2_15 = arg_2_0.signInTip
	local var_2_16 = var_3.Find(var_2_15, "Text")

	i18n = var_2_15

	var_2(var_2_16, var_2_15("island_agora_signIn_tip"))
	arg_2_0:UpdateSignInTip()

	return
end

function var_0_1.DisablePlayerOp(arg_3_0)
	var_0_1.super.DisablePlayerOp(arg_3_0)

	setActive = var_1

	var_1(arg_3_0.signInTip, false)

	return
end

function var_0_1.EnablePlayerOp(arg_4_0)
	var_0_1.super.EnablePlayerOp(arg_4_0)
	arg_4_0:UpdateSignInTip()

	return
end

function var_0_1.OnUpdate(arg_5_0)
	var_0_1.super.OnUpdate(arg_5_0)

	if arg_5_0.activeMould and not arg_5_0.isDraging then
		arg_5_0:UpdateDragPosition(arg_5_0.activeMould)
	end

	return
end

function var_0_1.UpdateSignInTip(arg_6_0)
	local var_6_0 = arg_6_0:GetView()

	if not var_1.IsSelfIsland(var_6_0) then
		setActive = var_1

		var_1(arg_6_0.signInTip, false)
	else
		local var_6_1 = arg_6_0:GetView()
		local var_6_2 = var_1.GetIsland(var_6_1)

		setActive = var_6_1

		local var_6_3 = arg_6_0.signInTip
		local var_6_4 = var_6_2:GetSignInAgency()

		var_6_1(var_6_3, var_4.CanSignIn(var_6_4))
	end

	return
end

function var_0_1.ShowMoveBtn(arg_7_0, arg_7_1)
	arg_7_0:ShowOrHideGameObject(arg_7_0.agoraPanel, arg_7_1)

	return
end

function var_0_1.ActiveDragBtn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.dftAniEvent

	var_2.SetEndEvent(var_8_0, nil)
	arg_8_0:UpdateDragPosition(arg_8_1)

	arg_8_0.activeMould = arg_8_1

	local var_8_1 = arg_8_0.animator

	var_2.Stop(var_8_1)

	local var_8_2 = arg_8_0.dftAniEvent

	var_2.SetEndEvent(var_8_2, function()
		local var_9_0 = arg_8_0.dftAniEvent

		var_0.SetEndEvent(var_9_0, nil)

		local var_9_1 = arg_8_0

		var_0.AddDraglistener(var_9_1, arg_8_1)

		return
	end)

	local var_8_3 = arg_8_0.animator

	var_2.Play(var_8_3, "anim_IslandAgoraOpUI_Agora_In")

	return
end

function var_0_1.InActiveDragBtn(arg_10_0)
	arg_10_0.activeMould = nil
	arg_10_0.isDraging = false

	local var_10_0 = arg_10_0.animator

	var_1.Stop(var_10_0)

	removeOnButton = var_1

	var_1(arg_10_0.confirmBtn)

	removeOnButton = var_1

	var_1(arg_10_0.removeBtn)

	removeOnButton = var_1

	var_1(arg_10_0.rotationBtn)

	local var_10_1 = arg_10_0.dftAniEvent

	var_1.SetEndEvent(var_10_1, nil)

	local var_10_2 = arg_10_0.dftAniEvent

	var_1.SetEndEvent(var_10_2, function()
		local var_11_0 = arg_10_0.dftAniEvent

		var_0.SetEndEvent(var_11_0, nil)

		local var_11_1 = arg_10_0

		var_0.RemoveDraglistener(var_11_1)

		local var_11_2 = arg_10_0.dragBtn

		Vector3 = var_11_1
		var_11_2.localPosition = var_11_1(10000, 10000, 0)

		return
	end)

	local var_10_3 = arg_10_0.animator

	var_1.Play(var_10_3, "anim_IslandAgoraOpUI_Agora_Out")

	return
end

function var_0_1.UpdateDragPosition(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.root.position

	AgoraCalc = var_1_10003

	local var_12_1 = var_1_10003.WorldPosition2ScreenPosition(var_12_0)

	AgoraCalc = var_4

	local var_12_2 = var_4.ScreenPosition2LocalPosition(arg_12_0.dragBtn.parent, var_12_1)

	arg_12_0.dragBtn.localPosition = var_12_2

	return
end

function var_0_1.AddDraglistener(arg_13_0, arg_13_1)
	GetOrAddComponent = var_1_10002

	local var_13_0 = arg_13_0.dragBtn

	typeof = var_1_10004
	EventTriggerListener = var_1_10005

	local var_13_1 = var_1_10002(var_13_0, var_1_10004(var_1_10005))

	var_2.AddBeginDragFunc(var_13_1, function(arg_14_0, arg_14_1)
		arg_13_0.isDraging = true

		local var_14_0 = arg_13_0

		var_2.Op(var_14_0, "BeginDragItem")

		return
	end)
	var_2:AddDragFunc(function(arg_15_0, arg_15_1)
		AgoraCalc = var_2_10002

		local var_15_0 = var_2_10002.ScreenPostion2MapPosition(arg_15_1.position)
		local var_15_1 = arg_13_0

		var_3.Op(var_15_1, "DragItem", var_15_0)

		local var_15_2 = arg_13_0

		var_3.UpdateDragPosition(var_15_2, arg_13_1)

		return
	end)
	var_2:AddDragEndFunc(function(arg_16_0, arg_16_1)
		AgoraCalc = var_2_10002

		local var_16_0 = var_2_10002.ScreenPostion2MapPosition(arg_16_1.position)
		local var_16_1 = arg_13_0

		var_3.Op(var_16_1, "EndDragItem", var_16_0)

		local var_16_2 = arg_13_0

		var_3.UpdateDragPosition(var_16_2, arg_13_1)

		arg_13_0.isDraging = false

		return
	end)

	onButton = var_3

	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.confirmBtn

	local function var_13_4()
		local var_17_0 = arg_13_0

		var_0.Op(var_17_0, "ConfirmSelectedItem")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_13_2, var_13_3, var_13_4, var_1_10007)

	onButton = var_3

	local var_13_5 = arg_13_0
	local var_13_6 = arg_13_0.removeBtn

	local function var_13_7()
		local var_18_0 = arg_13_0

		var_0.Op(var_18_0, "RemovePlaceItem")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_13_5, var_13_6, var_13_7, var_1_10007)

	onButton = var_3

	local var_13_8 = arg_13_0
	local var_13_9 = arg_13_0.rotationBtn

	local function var_13_10()
		local var_19_0 = arg_13_0

		var_0.Op(var_19_0, "RotationItem")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_13_8, var_13_9, var_13_10, var_1_10007)

	return
end

function var_0_1.RemoveDraglistener(arg_20_0)
	GetOrAddComponent = var_1_10001

	local var_20_0 = arg_20_0.dragBtn

	typeof = var_1_10003
	EventTriggerListener = var_1_10004

	local var_20_1 = var_1_10001(var_20_0, var_1_10003(var_1_10004))

	var_1.AddBeginDragFunc(var_20_1, nil)
	var_1:AddDragFunc(nil)
	var_1:AddDragEndFunc(nil)

	removeOnButton = var_2

	var_2(arg_20_0.confirmBtn)

	removeOnButton = var_2

	var_2(arg_20_0.removeBtn)

	return
end

function var_0_1.EnterMode(arg_21_0, arg_21_1)
	AgoraView = var_1_10002

	local var_21_1

	if arg_21_1 == var_1_10002.MODE_OVERVIEW then
		arg_21_0:ShowOrHideGameObject(arg_21_0.moveBtn, true)
		arg_21_0:ShowOrHideGameObject(arg_21_0.agoraPanel, false)
		arg_21_0:TryEnablePlayerOp()

		local var_21_0 = arg_21_0.inputController

		var_21_1 = var_21_1.ActivePlayerActionMap
		IslandConst = var_4

		var_21_1(var_21_0, var_4.PLAYER_INPUT_INDEX)
		arg_21_0:RemoveEditModeListener()

		goto label_21_0
	end

	AgoraView = var_21_1

	if arg_21_1 == var_21_1.MODE_EDIT then
		arg_21_0:ShowOrHideGameObject(arg_21_0.moveBtn, false)

		local var_21_2 = arg_21_0

		arg_21_0.ShowOrHideGameObject(var_21_2, arg_21_0.agoraPanel, true)

		if arg_21_0.mode then
			do
				local var_21_3 = arg_21_0.mode

				AgoraView = var_21_2

				if var_21_3 == var_21_2.MODE_OVERVIEW then
					arg_21_0:TryDisablePlayerOp()
				end

				local var_21_4 = arg_21_0.inputController

				var_21_3 = var_21_3.ActivePlayerActionMap
				IslandConst = var_4

				var_21_3(var_21_4, var_4.AGORA_INPUT_INDEX)

				local var_21_5 = arg_21_0.inputController

				var_21_3.EnableAgoraLook(var_21_5)
				arg_21_0:RemovePaveTileModeListener()
				arg_21_0:AddEditModeListener()

				if false then
					AgoraView = var_21_3

					if arg_21_1 == var_21_3.MODE_PAVE_TILE then
						local var_21_6 = arg_21_0.inputController

						var_2.DisableAgoraLook(var_21_6)
						arg_21_0:RemoveEditModeListener()
						arg_21_0:AddPaveTileModeListener()
					end
				end
			end

			::label_21_0::

			arg_21_0.mode = arg_21_1

			return
		end
	end
end

function var_0_1.OnEditModeClick(arg_22_0, arg_22_1)
	IslandHelper = var_1_10002

	local var_22_0 = var_1_10002.Raycast4Agora
	local var_22_1 = arg_22_1

	IslandConst = var_1_10004

	local var_22_2 = var_1_10004.UNIT_LIST_AGORA

	IslandConst = var_1_10005

	if var_22_0(var_22_1, var_22_2, var_1_10005.LAYER_WORLDMAP3D) > 0 then
		arg_22_0:Op("TrySelectItemById", var_2)
	end

	return
end

function var_0_1.AddEditModeListener(arg_23_0)
	GetOrAddComponent = var_1_10001

	local var_23_0 = arg_23_0.lookBtn

	typeof = var_1_10003
	EventTriggerListener = var_1_10004

	local var_23_1 = var_1_10001(var_23_0, var_1_10003(var_1_10004))
	local var_23_2

	var_23_1:AddPointDownFunc(function(arg_24_0, arg_24_1)
		var_23_2 = arg_24_1.position

		return
	end)
	var_23_1:AddPointUpFunc(function(arg_25_0, arg_25_1)
		if not var_23_2 or var_23_2 ~= arg_25_1.position then
			return
		end

		local var_25_0 = arg_23_0

		var_2.OnEditModeClick(var_25_0, arg_25_1.position)

		var_23_2 = nil

		return
	end)

	return
end

function var_0_1.RemoveEditModeListener(arg_26_0)
	local var_26_0 = arg_26_0.lookBtn
	local var_26_1 = var_1.GetComponent

	typeof = var_1_10003
	EventTriggerListener = var_1_10004

	if var_26_1(var_26_0, var_1_10003(var_1_10004)) then
		var_1:AddPointDownFunc(nil)
		var_1:AddPointUpFunc(nil)
	end

	return
end

function var_0_1.AddPaveTileModeListener(arg_27_0)
	GetOrAddComponent = var_1_10001

	local var_27_0 = arg_27_0.lookBtn

	typeof = var_1_10003
	EventTriggerListener = var_1_10004

	local var_27_1 = var_1_10001(var_27_0, var_1_10003(var_1_10004))
	local var_27_2

	var_27_1:AddPointDownFunc(function(arg_28_0, arg_28_1)
		var_27_2 = arg_28_1.position

		return
	end)
	var_27_1:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if not var_27_2 or var_27_2 ~= arg_29_1.position then
			return
		end

		AgoraCalc = var_2

		local var_29_0 = var_2.ScreenPostion2MapPosition(arg_29_1.position)
		local var_29_1 = arg_27_0

		var_3.Op(var_29_1, "OpLayer", var_29_0)

		local var_29_2

		return
	end)
	var_27_1:AddBeginDragFunc(function(arg_30_0, arg_30_1)
		return
	end)
	var_27_1:AddDragFunc(function(arg_31_0, arg_31_1)
		AgoraCalc = var_2_10002

		local var_31_0 = var_2_10002.ScreenPostion2MapPosition(arg_31_1.position)
		local var_31_1 = arg_27_0

		var_3.Op(var_31_1, "OpLayer", var_31_0)

		return
	end)
	var_27_1:AddDragEndFunc(function(arg_32_0, arg_32_1)
		return
	end)

	return
end

function var_0_1.RemovePaveTileModeListener(arg_33_0)
	local var_33_0 = arg_33_0.lookBtn
	local var_33_1 = var_1.GetComponent

	typeof = var_1_10003
	EventTriggerListener = var_1_10004

	if var_33_1(var_33_0, var_1_10003(var_1_10004)) then
		var_1:AddPointDownFunc(nil)
		var_1:AddPointUpFunc(nil)
		var_1:AddBeginDragFunc(nil)
		var_1:AddDragFunc(nil)
		var_1:AddDragEndFunc(nil)
	end

	return
end

function var_0_1.OnDestroy(arg_34_0)
	var_0_1.super.OnDestroy(arg_34_0)
	arg_34_0:RemovePaveTileModeListener()
	arg_34_0:RemoveDraglistener()

	local var_34_0 = arg_34_0.dftAniEvent

	var_1.SetEndEvent(var_34_0, nil)

	return
end

return var_0_1
