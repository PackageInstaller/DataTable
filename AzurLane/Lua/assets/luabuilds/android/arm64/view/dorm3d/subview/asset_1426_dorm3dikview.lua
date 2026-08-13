class = var_0_10000

local var_0_0 = "Dorm3dIKView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_1.SET_CONTROL_ACTIVE = "Dorm3dIKView.SET_CONTROL_ACTIVE"
var_0_1.SET_CAMERA_BUTTON_ACTIVE = "Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE"
var_0_1.RESET_ENTRY_MENU = "Dorm3dIKView.RESET_ENTRY_MENU"
var_0_1.SET_BACK_BUTTON_ACTIVE = "Dorm3dIKView.SET_BACK_BUTTON_ACTIVE"
var_0_1.UPDATE_TEXT_TIPS = "Dorm3dIKView.UPDATE_TEXT_TIPS"
var_0_1.UPDATE_TIPS = "Dorm3dIKView.UPDATE_TIPS"
var_0_1.SET_TIPS_ACTIVE = "Dorm3dIKView.SET_TIPS_ACTIVE"
var_0_1.SET_HAND_POSITION = "Dorm3dIKView.SET_HAND_POSITION"
var_0_1.PLAY_HAND_BEGIN = "Dorm3dIKView.PLAY_HAND_BEGIN"
var_0_1.PLAY_HAND_END = "Dorm3dIKView.PLAY_HAND_END"
var_0_1.UPDATE_HOLD_PROGRESS = "Dorm3dIKView.UPDATE_HOLD_PROGRESS"

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.uiContainer = var_1.Find(var_1_0, "UI")

	local var_1_1 = arg_1_0.uiContainer

	arg_1_0.rtIKUI = var_1.Find(var_1_1, "ik")

	local var_1_2 = arg_1_0._tf

	arg_1_0.ikControlUI = var_1.Find(var_1_2, "IKControl")

	local var_1_3 = arg_1_0.ikControlUI

	arg_1_0.controlLayer = var_1.Find(var_1_3, "ControlLayer")

	arg_1_0:InitIKControlRoots()
	arg_1_0:InitButtons()
	arg_1_0:InitDragEvent()
	arg_1_0:InitEvents()

	return
end

function var_0_1.InitIKControlRoots(arg_2_0)
	local var_2_0 = arg_2_0.ikControlUI

	arg_2_0.ikTipsRoot = var_1.Find(var_2_0, "Tips")
	setActive = var_1

	var_1(arg_2_0.ikTipsRoot, false)

	local var_2_1 = arg_2_0.ikControlUI

	arg_2_0.ikTouchTipsRoot = var_1.Find(var_2_1, "TouchTips")
	assert = var_1
	IsNil = var_2_1

	var_1(not var_2_1(arg_2_0.ikTouchTipsRoot), "Missing IKControl/TouchTips")

	setActive = var_1

	var_1(arg_2_0.ikTouchTipsRoot, false)

	local var_2_2 = arg_2_0.ikTouchTipsRoot

	arg_2_0.ikTouchTipTpl = var_1.Find(var_2_2, "tpl")
	assert = var_1
	IsNil = var_2_2

	var_1(not var_2_2(arg_2_0.ikTouchTipTpl), "Missing IKControl/TouchTips/tpl")

	assert = var_1
	IsNil = var_3

	local var_2_3 = arg_2_0.ikTouchTipTpl
	local var_2_5

	if not var_3(var_5.Find(var_2_3, "Click")) then
		IsNil = var_3

		local var_2_4 = arg_2_0.ikTouchTipTpl

		var_2_5 = not var_3(var_5.Find(var_2_4, "Hold"))
	else
		var_2_5 = false
	end

	if false then
		var_2_5 = true
	end

	var_1(var_2_5, "TouchTips/tpl missing Click or Hold")

	setActive = var_1

	var_1(arg_2_0.ikTouchTipTpl, false)

	local var_2_6 = arg_2_0.ikControlUI

	arg_2_0.holdProgressRoot = var_1.Find(var_2_6, "HoldProgress")
	assert = var_1
	IsNil = var_2_6

	var_1(not var_2_6(arg_2_0.holdProgressRoot), "Missing IKControl/HoldProgress")

	local var_2_7 = arg_2_0.holdProgressRoot

	arg_2_0.holdProgressTpl = var_1.Find(var_2_7, "tpl")
	assert = var_1
	IsNil = var_2_7

	var_1(not var_2_7(arg_2_0.holdProgressTpl), "Missing IKControl/HoldProgress/tpl")

	setActive = var_1

	var_1(arg_2_0.holdProgressRoot, false)

	setActive = var_1

	var_1(arg_2_0.holdProgressTpl, false)

	local var_2_8 = arg_2_0.ikControlUI

	arg_2_0.ikHand = var_1.Find(var_2_8, "Handler")
	setActive = var_1

	var_1(arg_2_0.ikHand, false)

	eachChild = var_1

	var_1(arg_2_0.ikHand, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, false)

		return
	end)

	local var_2_9 = arg_2_0.ikControlUI

	arg_2_0.ikTextTipsRoot = var_1.Find(var_2_9, "TextTips")
	setActive = var_1

	var_1(arg_2_0.ikTextTipsRoot, false)

	eachChild = var_1

	var_1(arg_2_0.ikTextTipsRoot, function(arg_4_0)
		setActive = var_2_10001

		var_2_10001(arg_4_0, false)

		return
	end)

	setActive = var_1

	var_1(arg_2_0.ikControlUI, false)

	return
end

function var_0_1.InitButtons(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.rtIKUI
	local var_5_2 = var_4.Find(var_5_1, "btn_back/help")

	local function var_5_3()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		i18n = var_2_10004
		var_6_2.helps = var_2_10004("roll_gametip")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.rtIKUI
	local var_5_6 = var_4.Find(var_5_5, "Right/btn_camera")

	local function var_5_7()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		RoomIKSystem = var_2_10003

		var_7_1(var_7_0, var_2_10003.CYCLE_IK_CAMERA_GROUP)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.rtIKUI
	local var_5_10 = var_4.Find(var_5_9, "Right/MenuSmall")

	local function var_5_11()
		setActive = var_2_10000

		local var_8_0 = arg_5_0.rtIKUI

		var_2_10000(var_2.Find(var_8_0, "Right/MenuSmall"), false)

		setActive = var_2_10000

		local var_8_1 = arg_5_0.rtIKUI

		var_2_10000(var_2.Find(var_8_1, "Right/Menu"), true)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.rtIKUI
	local var_5_14 = var_4.Find(var_5_13, "Right/Menu/Collapse")

	local function var_5_15()
		setActive = var_2_10000

		local var_9_0 = arg_5_0.rtIKUI

		var_2_10000(var_2.Find(var_9_0, "Right/Menu"), false)

		setActive = var_2_10000

		local var_9_1 = arg_5_0.rtIKUI

		var_2_10000(var_2.Find(var_9_1, "Right/MenuSmall"), true)

		return
	end

	SFX_PANEL = var_5_13

	var_1_10001(var_5_12, var_5_14, var_5_15, var_5_13)

	onButton = var_1_10001

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.rtIKUI
	local var_5_18 = var_4.Find(var_5_17, "Right/Menu")

	local function var_5_19()
		setActive = var_2_10000

		local var_10_0 = arg_5_0.rtIKUI

		var_2_10000(var_2.Find(var_10_0, "Right"), false)

		local var_10_1 = arg_5_0
		local var_10_2 = var_0.emit

		Dorm3dRoomMediator = var_3

		local var_10_3 = var_3.OPEN_SKIN_SELECT_LAYER
		local var_10_4 = arg_5_0.contextData.GetApartment()

		var_10_2(var_10_1, var_10_3, var_4.GetConfigID(var_10_4), arg_5_0.contextData.GetCurrentLadyEnv(), function(arg_11_0, arg_11_1, arg_11_2)
			local var_11_0 = arg_5_0
			local var_11_1 = var_3.emit

			RoomIKSystem = var_3_10006

			var_11_1(var_11_0, var_3_10006.SWITCH_IK_SKIN, arg_11_0, arg_11_1, arg_11_2)

			return
		end, function()
			setActive = var_3_10000

			local var_12_0 = arg_5_0.rtIKUI

			var_3_10000(var_2.Find(var_12_0, "Right"), true)

			return
		end, true)

		return
	end

	SFX_PANEL = var_5_17

	var_1_10001(var_5_16, var_5_18, var_5_19, var_5_17)

	return
end

function var_0_1.InitDragEvent(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0.controlLayer
	local var_13_2 = var_2.GetComponent

	typeof = var_1_10005
	SlideController = var_1_10007

	if var_13_2(var_13_1, var_1_10005(var_1_10007)) then
		IsNil = var_1_10003

		if not var_1_10003(var_2) then
			var_2:ClearEvents()

			var_2.enabled = false
		end
	end

	GetOrAddComponent = var_1_10003

	local var_13_3 = arg_13_0.controlLayer

	typeof = var_1_10006
	SlideControllerHotfix = var_1_10008

	local var_13_4 = var_1_10003(var_13_3, var_1_10006(var_1_10008))

	var_3.ClearEvents(var_13_4)

	arg_13_0.ikSlideController = var_3

	var_3:AddPointDownFunc(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0.contextData.GetCurrentLadyEnv()
		local var_14_1 = arg_13_0

		if not var_3.GetTouchTarget(var_14_1, var_14_0, arg_14_1.position) then
			return
		end

		arg_13_0.touchPressTarget = var_3

		local var_14_2 = arg_13_0

		var_4.EmitTouchPress(var_14_2, true, var_3, arg_14_1.position)

		return
	end)
	var_3:AddPointUpFunc(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_13_0.touchPressTarget

		arg_13_0.touchPressTarget = nil

		if not var_15_0 then
			return
		end

		local var_15_1 = arg_13_0

		var_3.EmitTouchPress(var_15_1, false, var_15_0, arg_15_1.position)

		return
	end)
	var_3:AddBeginDragFunc(function(arg_16_0, arg_16_1)
		if not arg_13_0.contextData.GetCurrentLadyEnv().IKSettings then
			return
		end

		local var_16_0 = arg_16_1.position

		CameraMgr = var_2_10004

		local var_16_1 = var_2_10004.instance
		local var_16_2 = var_4.Raycast(var_16_1, var_2.IKSettings.CameraRaycaster, var_16_0)

		if #var_4.ToTable(var_16_2) <= 0 then
			return
		end

		local var_16_3 = var_4[1].gameObject.transform

		table = var_6

		local var_16_4 = var_6.keyof(var_2.IKSettings.Colliders, var_16_3)

		warning = var_7

		var_7(var_16_3, var_16_4)

		if not var_16_4 then
			return
		end

		local var_16_5 = arg_13_0
		local var_16_6 = var_7.emit

		RoomIKSystem = var_10

		var_16_6(var_16_5, var_10.ON_BEGIN_DRAG_CHARACTER_BODY, var_2, var_16_4, var_16_0)

		tobool = var_16_6
		var_13_0 = var_16_6(var_2.ikHandler)

		return
	end)
	var_3:AddDragFunc(function(arg_17_0, arg_17_1)
		if arg_13_0.contextData.GetCurrentLadyEnv().ikHandler then
			local var_17_0 = arg_13_0
			local var_17_1 = var_3.emit

			RoomIKSystem = var_2_10006

			var_17_1(var_17_0, var_2_10006.ON_DRAG_CHARACTER_BODY, var_2, arg_17_1.position)

			return
		end

		if var_13_0 then
			return
		end

		local var_17_2 = arg_13_0
		local var_17_3 = var_3.emit

		Dorm3dRoomTemplateScene = var_2_10006

		var_17_3(var_17_2, var_2_10006.ON_STICK_MOVE, arg_17_1.delta)

		return
	end)
	var_3:AddDragEndFunc(function(arg_18_0, arg_18_1)
		var_13_0 = nil

		if arg_13_0.contextData.GetCurrentLadyEnv().ikHandler then
			local var_18_0 = arg_13_0
			local var_18_1 = var_3.emit

			RoomIKSystem = var_2_10006

			var_18_1(var_18_0, var_2_10006.ON_RELEASE_CHARACTER_BODY, var_2)
		end

		return
	end)

	return
end

function var_0_1.GetTouchTarget(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_1.IKSettings then
		return
	end

	CameraMgr = var_1_10003

	local var_19_0 = var_1_10003.instance
	local var_19_1 = var_3.Raycast(var_19_0, arg_19_1.IKSettings.CameraRaycaster, arg_19_2)
	local var_19_2 = var_3.ToTable(var_19_1)

	ipairs = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10004(var_19_2) do
		local var_19_3 = iter_19_1.gameObject.transform

		table = var_1_10010

		if var_1_10010.keyof(arg_19_1.IKSettings.Colliders, var_19_3) then
			return {
				source = "body",
				target = var_1_10010
			}
		end

		if arg_19_0:GetTouchSceneItem(arg_19_1, var_19_3) then
			return {
				source = "scene_item",
				target = var_11
			}
		end
	end

	return
end

function var_0_1.GetTouchSceneItem(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_1.iKTouchDatas then
		return
	end

	ipairs = var_3

	for iter_20_0, iter_20_1 in var_3(arg_20_1.iKTouchDatas) do
		pg = var_1_10008

		if #var_1_10008.dorm3d_ik_touch[iter_20_1[1]].scene_item > 0 and arg_20_0.contextData.GetSceneItem(var_1_10008.scene_item) and var_0_1.IsTransformInHierarchy(arg_20_2, var_9) then
			return var_1_10008.scene_item
		end
	end

	return
end

function var_0_1.IsTransformInHierarchy(arg_21_0, arg_21_1)
	while arg_21_0 do
		if arg_21_0 == arg_21_1 then
			return true
		end

		arg_21_0 = arg_21_0.parent
	end

	return false
end

function var_0_1.EmitTouchPress(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2.source == "body" then
		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0.emit

		if arg_22_1 then
			RoomTouchSystem = var_1_10007

			if not var_1_10007.ON_TOUCH_CHARACTER_DOWN then
				RoomTouchSystem = var_1_10007
				var_1_10007 = var_1_10007.ON_TOUCH_CHARACTER_UP
			end

			var_22_1(var_22_0, var_1_10007, arg_22_2.target, arg_22_3)

			goto label_22_0

			if arg_22_2.source == "scene_item" then
				local var_22_2 = arg_22_0
				local var_22_3 = arg_22_0.emit

				if arg_22_1 then
					RoomTouchSystem = var_1_10007

					if not var_1_10007.ON_TOUCH_SCENE_ITEM_DOWN then
						RoomTouchSystem = var_1_10007
						var_1_10007 = var_1_10007.ON_TOUCH_SCENE_ITEM_UP
					end

					var_22_3(var_22_2, var_1_10007, arg_22_2.target, arg_22_3)

					::label_22_0::

					return
				end
			end
		end
	end
end

function var_0_1.InitEvents(arg_23_0)
	arg_23_0:bind(var_0_1.SET_CONTROL_ACTIVE, function(arg_24_0, arg_24_1)
		setActive = var_2_10002

		var_2_10002(arg_23_0.ikControlUI, arg_24_1)

		if not arg_24_1 then
			local var_24_0 = arg_23_0

			var_2.ResetHand(var_24_0)

			local var_24_1 = arg_23_0

			var_2.ResetHoldProgress(var_24_1)

			arg_23_0.touchPressTarget = nil
		end

		return
	end)
	arg_23_0:bind(var_0_1.SET_CAMERA_BUTTON_ACTIVE, function(arg_25_0, arg_25_1)
		setActive = var_2_10002

		local var_25_0 = arg_23_0.rtIKUI

		var_2_10002(var_4.Find(var_25_0, "Right/btn_camera"), arg_25_1)

		return
	end)
	arg_23_0:bind(var_0_1.RESET_ENTRY_MENU, function(arg_26_0, arg_26_1)
		setActive = var_2_10002

		local var_26_0 = arg_23_0.rtIKUI

		var_2_10002(var_4.Find(var_26_0, "Right/MenuSmall"), arg_26_1)

		setActive = var_2_10002

		local var_26_1 = arg_23_0.rtIKUI

		var_2_10002(var_4.Find(var_26_1, "Right/Menu"), false)

		return
	end)
	arg_23_0:bind(var_0_1.SET_BACK_BUTTON_ACTIVE, function(arg_27_0, arg_27_1)
		setActive = var_2_10002

		local var_27_0 = arg_23_0.rtIKUI

		var_2_10002(var_4.Find(var_27_0, "btn_back"), arg_27_1)

		return
	end)
	arg_23_0:bind(var_0_1.UPDATE_TEXT_TIPS, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_23_0

		var_2.UpdateTextTips(var_28_0, arg_28_1)

		return
	end)
	arg_23_0:bind(var_0_1.UPDATE_TIPS, function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_23_0

		var_3.UpdateTips(var_29_0, arg_29_1, arg_29_2)

		return
	end)
	arg_23_0:bind(var_0_1.SET_TIPS_ACTIVE, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_23_0

		var_2.SetTipsActive(var_30_0, arg_30_1)

		return
	end)
	arg_23_0:bind(var_0_1.SET_HAND_POSITION, function(arg_31_0, arg_31_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_23_0.ikHand, arg_31_1)

		return
	end)
	arg_23_0:bind(var_0_1.PLAY_HAND_BEGIN, function()
		local var_32_0 = arg_23_0

		var_0.PlayHandBegin(var_32_0)

		return
	end)
	arg_23_0:bind(var_0_1.PLAY_HAND_END, function()
		local var_33_0 = arg_23_0

		var_0.PlayHandEnd(var_33_0)

		return
	end)
	arg_23_0:bind(var_0_1.UPDATE_HOLD_PROGRESS, function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		local var_34_0 = arg_23_0

		var_4.UpdateHoldProgress(var_34_0, arg_34_1, arg_34_2, arg_34_3)

		return
	end)

	return
end

function var_0_1.UpdateTextTips(arg_35_0, arg_35_1)
	eachChild = var_1_10002

	var_1_10002(arg_35_0.ikTextTipsRoot, function(arg_36_0)
		setActive = var_2_10001

		var_2_10001(arg_36_0, false)

		return
	end)

	_ = var_1_10002

	var_1_10002.each(arg_35_1 or {}, function(arg_37_0)
		local var_37_0 = arg_37_0

		if not arg_37_0.getConfig(var_37_0, "tip_text") or #var_1 == 0 then
			return
		end

		local var_37_1 = arg_35_0.ikTextTipsRoot
		local var_37_2 = var_2.Find(var_37_1, var_1)

		IsNil = var_37_0

		if not var_37_0(var_37_2) then
			setActive = var_3

			var_3(var_37_2, true)
		end

		return
	end)

	return
end

function var_0_1.SetTipsActive(arg_38_0, arg_38_1)
	if arg_38_1 and arg_38_0.holdProgressActive then
		arg_38_1 = false
	end

	setActive = var_1_10002

	var_1_10002(arg_38_0.ikTipsRoot, arg_38_1)

	setActive = var_1_10002

	var_1_10002(arg_38_0.ikTouchTipsRoot, arg_38_1)

	setActive = var_1_10002

	var_1_10002(arg_38_0.ikTextTipsRoot, arg_38_1)

	return
end

function var_0_1.UpdateHoldProgress(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1 then
		arg_39_0:ResetHoldProgress()

		return
	end

	arg_39_0.holdProgressActive = true

	arg_39_0:SetTipsActive(false)

	setActive = var_4

	var_4(arg_39_0.holdProgressRoot, true)

	setActive = var_4

	var_4(arg_39_0.holdProgressTpl, true)

	setLocalPosition = var_4

	local var_39_0 = arg_39_0.holdProgressTpl

	LuaHelper = var_7

	local var_39_1 = var_7.ScreenToLocal
	local var_39_2 = arg_39_0.holdProgressRoot
	local var_39_3 = arg_39_2

	pg = var_1_10011

	var_4(var_39_0, var_39_1(var_39_2, var_39_3, var_1_10011.UIMgr.GetInstance().uiCameraComp))

	local var_39_4 = arg_39_0.holdProgressTpl
	local var_39_5 = var_4.Find(var_39_4, "Progress")

	IsNil = var_1_10005

	if var_1_10005(var_39_5) then
		var_39_5 = arg_39_0.holdProgressTpl
	end

	GetComponent = var_5

	local var_39_6 = var_39_5

	typeof = var_1_10008
	Image = var_39_3

	local var_39_7 = var_5(var_39_6, var_1_10008(var_39_3))

	IsNil = var_39_4

	if not var_39_4(var_39_7) then
		math = var_6
		var_39_7.fillAmount = var_6.clamp(arg_39_3 or 0, 0, 1)
	end

	return
end

function var_0_1.ResetHoldProgress(arg_40_0)
	arg_40_0.holdProgressActive = nil
	setActive = var_1

	var_1(arg_40_0.holdProgressTpl, false)

	setActive = var_1

	var_1(arg_40_0.holdProgressRoot, false)

	return
end

function var_0_1.SetTouchTipType(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1
	local var_41_1 = arg_41_1.Find(var_41_0, "Click")
	local var_41_2 = arg_41_1:Find("Hold")

	assert = var_41_0
	IsNil = var_7

	local var_41_3

	if not var_7(var_41_1) then
		IsNil = var_7
		var_41_3 = not var_7(var_41_2)
	else
		var_41_3 = false
	end

	if false then
		var_41_3 = true
	end

	var_41_0(var_41_3, "TouchTips/tpl item missing Click or Hold")

	setActive = var_41_0

	local var_41_4 = var_41_1

	RoomTouchSystem = var_8

	var_41_0(var_41_4, arg_41_2 == var_8.TRIGGER_CLICK)

	setActive = var_41_0

	local var_41_5 = var_41_2

	RoomTouchSystem = var_8

	var_41_0(var_41_5, arg_41_2 == var_8.TRIGGER_LONG_PRESS)

	return
end

function var_0_1.UpdateTouchTips(arg_42_0, arg_42_1, arg_42_2)
	UIItemList = var_1_10003

	var_1_10003.StaticAlign(arg_42_0.ikTouchTipsRoot, arg_42_0.ikTouchTipTpl, #arg_42_2, function(arg_43_0, arg_43_1, arg_43_2)
		UIItemList = var_2_10003

		if arg_43_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_43_1 = arg_43_1 + 1

		local var_43_0

		Vector2 = var_2_10004

		local var_43_1 = var_2_10004.zero
		local var_43_2 = arg_42_2[arg_43_1][1]

		pg = var_2_10006

		local var_43_3 = var_2_10006.dorm3d_ik_touch[var_43_2]
		local var_43_4 = arg_42_0

		var_7.SetTouchTipType(var_43_4, arg_43_2, var_43_3.trigger_type)

		if var_43_3.tip_offset and var_43_3.tip_offset ~= "" then
			Vector2 = var_7

			local var_43_5 = var_7.New

			unpack = var_43_4
			var_43_1 = var_43_5(var_43_4(var_43_3.tip_offset))
		end

		if #var_43_3.scene_item > 0 then
			var_43_0 = arg_42_0.contextData.GetSceneItem(var_43_3.scene_item)
		else
			var_43_0 = arg_42_1.IKSettings.Colliders[var_43_3.body]
		end

		local var_43_6

		if var_43_0 then
			var_43_6 = var_43_0.position

			local var_43_7 = var_43_0
			local var_43_8 = var_43_0.GetComponent

			typeof = var_11
			UnityEngine = var_2_10013

			if var_43_8(var_43_7, var_11(var_2_10013.Collider)) then
				var_43_6 = var_8.bounds.center
			end

			setLocalPosition = var_43_4

			var_43_4(arg_43_2, arg_42_0.contextData.GetLocalPosition(arg_42_0.contextData.GetScreenPosition(var_43_6, arg_42_1.IKSettings.CameraRaycaster.eventCamera), arg_42_0.ikTouchTipsRoot) + var_43_1)
		end

		setActive = var_43_6

		var_43_6(arg_43_2, var_43_0)

		return
	end)

	return
end

function var_0_1.PlayHandBegin(arg_44_0)
	setActive = var_1_10001

	var_1_10001(arg_44_0.ikHand, true)

	eachChild = var_1_10001

	var_1_10001(arg_44_0.ikHand, function(arg_45_0)
		setActive = var_2_10001

		var_2_10001(arg_45_0, false)

		return
	end)
	arg_44_0:StopHandTimer()

	setActive = var_1

	local var_44_0 = arg_44_0.ikHand

	var_1(var_3.Find(var_44_0, "Begin"), true)

	Timer = var_1
	arg_44_0.handTimer = var_1.New(function()
		setActive = var_2_10000

		local var_46_0 = arg_44_0.ikHand

		var_2_10000(var_2.Find(var_46_0, "Begin"), false)

		setActive = var_2_10000

		local var_46_1 = arg_44_0.ikHand

		var_2_10000(var_2.Find(var_46_1, "Normal"), true)

		return
	end, 0.5, 1)

	local var_44_1 = arg_44_0.handTimer

	var_1.Start(var_44_1)

	return
end

function var_0_1.ResetHand(arg_47_0)
	arg_47_0:StopHandTimer()

	eachChild = var_1

	var_1(arg_47_0.ikHand, function(arg_48_0)
		setActive = var_2_10001

		var_2_10001(arg_48_0, false)

		return
	end)

	setActive = var_1

	var_1(arg_47_0.ikHand, false)

	return
end

function var_0_1.PlayHandEnd(arg_49_0)
	arg_49_0:StopHandTimer()

	setActive = var_1

	local var_49_0 = arg_49_0.ikHand

	var_1(var_3.Find(var_49_0, "Begin"), false)

	setActive = var_1

	local var_49_1 = arg_49_0.ikHand

	var_1(var_3.Find(var_49_1, "Normal"), false)

	setActive = var_1

	local var_49_2 = arg_49_0.ikHand

	var_1(var_3.Find(var_49_2, "End"), true)

	Timer = var_1
	arg_49_0.handTimer = var_1.New(function()
		setActive = var_2_10000

		local var_50_0 = arg_49_0.ikHand

		var_2_10000(var_2.Find(var_50_0, "End"), false)

		setActive = var_2_10000

		var_2_10000(arg_49_0.ikHand, false)

		return
	end, 0.5, 1)

	local var_49_3 = arg_49_0.handTimer

	var_1.Start(var_49_3)

	return
end

function var_0_1.StopHandTimer(arg_51_0)
	if not arg_51_0.handTimer then
		return
	end

	local var_51_0 = arg_51_0.handTimer

	var_1.Stop(var_51_0)

	arg_51_0.handTimer = nil

	return
end

function var_0_1.UpdateTips(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_1 and arg_52_2 then
		_ = var_1_10003

		local var_52_0 = var_1_10003.filter
		local var_52_1

		if not arg_52_2.readyIKLayers then
			var_52_1 = {}
		end

		local var_52_2 = var_52_0(var_52_1, function(arg_53_0)
			return not arg_53_0.ignoreDrag
		end)

		UIItemList = var_1_10004

		local var_52_3 = var_1_10004.StaticAlign
		local var_52_4 = arg_52_0.ikTipsRoot
		local var_52_5 = arg_52_0.ikTipsRoot

		var_52_3(var_52_4, var_7.GetChild(var_52_5, 0), #var_52_2, function(arg_54_0, arg_54_1, arg_54_2)
			UIItemList = var_2_10003

			if arg_54_0 ~= var_2_10003.EventUpdate then
				return
			end

			arg_54_1 = arg_54_1 + 1

			local var_54_0

			Vector2 = var_2_10004

			local var_54_1 = var_2_10004.zero
			local var_54_2 = var_52_2[arg_54_1]
			local var_54_3 = var_5.GetTriggerBoneName(var_54_2) and arg_52_2.IKSettings.Colliders[var_6] or nil
			local var_54_4 = var_5:GetIKTipOffset()
			local var_54_5

			if var_54_3 then
				var_54_5 = var_54_3.position

				local var_54_6 = var_54_3
				local var_54_7 = var_54_3.GetComponent

				typeof = var_2_10011
				UnityEngine = var_2_10013

				if var_54_7(var_54_6, var_2_10011(var_2_10013.Collider)) then
					var_54_5 = var_8.bounds.center
				end

				local var_54_8 = arg_52_0.contextData.GetLocalPosition(arg_52_0.contextData.GetScreenPosition(var_54_5, arg_52_2.IKSettings.CameraRaycaster.eventCamera), arg_52_0.ikTipsRoot) + var_54_4

				setLocalPosition = var_54_6

				var_54_6(arg_54_2, var_54_8)

				local var_54_9 = var_5
				local var_54_10 = var_5.GetTriggerRect(var_54_9)
				local var_54_11 = var_10.PointToNormalized

				Vector2 = var_14

				local var_54_12 = var_54_11(var_54_10, var_14.zero)

				Vector2 = var_54_9

				local var_54_13 = var_54_9.zero

				if var_54_12.x < 0.5 and var_54_12.y < 0.5 then
					var_54_13 = var_10.max
				else
					local var_54_14 = var_54_12.x

					if 0.5 <= var_54_14 and var_54_12.y < 0.5 then
						Vector2 = var_13
						var_54_13 = var_13.New(var_10.xMin, var_10.yMax)
					else
						if var_54_12.x < 0.5 then
							local var_54_15 = var_54_12.y

							if 0.5 <= var_54_15 then
								Vector2 = var_54_15
								var_54_13 = var_54_15.New(var_10.xMax, var_10.yMin)

								goto label_54_0
							end
						end

						local var_54_16 = var_54_12.x

						if 0.5 <= var_54_16 then
							local var_54_17 = var_54_12.y

							if 0.5 <= var_54_17 then
								var_54_13 = var_10.min
							end
						end
					end
				end

				::label_54_0::

				if var_54_12.x == 0.5 then
					if var_54_8.x < 0 then
						var_54_13.x = var_10.xMax
					else
						var_54_13.x = var_10.xMin
					end
				end

				if var_54_12.y == 0.5 then
					if var_54_8.y < 0 then
						var_54_13.y = var_10.yMax
					else
						var_54_13.y = var_10.yMin
					end
				end

				local var_54_18 = var_54_13 - var_10.center

				setLocalRotation = var_14

				local var_54_19 = arg_54_2

				Quaternion = var_2_10017

				local var_54_20 = var_2_10017.LookRotation

				Vector3 = var_2_10019

				local var_54_21 = var_2_10019.forward

				Vector3 = var_2_10020

				var_14(var_54_19, var_54_20(var_54_21, var_2_10020.New(var_54_18.x, var_54_18.y, 0)))
			end

			setActive = var_54_5

			var_54_5(arg_54_2, var_54_3)

			return
		end)

		local var_52_6 = arg_52_0
		local var_52_7 = arg_52_0.UpdateTouchTips
		local var_52_8 = arg_52_2
		local var_52_9

		if not arg_52_2.iKTouchDatas then
			var_52_9 = {}
		end

		var_52_7(var_52_6, var_52_8, var_52_9)
	end

	arg_52_0:SetTipsActive(arg_52_1)

	return
end

function var_0_1.Dispose(arg_55_0)
	if arg_55_0.ikSlideController then
		local var_55_0 = arg_55_0.ikSlideController

		var_1.ClearEvents(var_55_0)

		arg_55_0.ikSlideController = nil
	end

	arg_55_0:ResetHand()
	arg_55_0:ResetHoldProgress()
	var_0_1.super.Dispose(arg_55_0)

	return
end

return var_0_1
