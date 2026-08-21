local var_0_0 = class("Dorm3dIKView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_0.SET_CONTROL_ACTIVE = "Dorm3dIKView.SET_CONTROL_ACTIVE"
var_0_0.SET_CAMERA_BUTTON_ACTIVE = "Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE"
var_0_0.RESET_ENTRY_MENU = "Dorm3dIKView.RESET_ENTRY_MENU"
var_0_0.SET_BACK_BUTTON_ACTIVE = "Dorm3dIKView.SET_BACK_BUTTON_ACTIVE"
var_0_0.UPDATE_TEXT_TIPS = "Dorm3dIKView.UPDATE_TEXT_TIPS"
var_0_0.UPDATE_TIPS = "Dorm3dIKView.UPDATE_TIPS"
var_0_0.SET_TIPS_ACTIVE = "Dorm3dIKView.SET_TIPS_ACTIVE"
var_0_0.SET_HAND_POSITION = "Dorm3dIKView.SET_HAND_POSITION"
var_0_0.PLAY_HAND_BEGIN = "Dorm3dIKView.PLAY_HAND_BEGIN"
var_0_0.PLAY_HAND_END = "Dorm3dIKView.PLAY_HAND_END"
var_0_0.UPDATE_HOLD_PROGRESS = "Dorm3dIKView.UPDATE_HOLD_PROGRESS"

function var_0_0.Init(arg_1_0)
	arg_1_0.uiContainer = arg_1_0._tf:Find("UI")
	arg_1_0.rtIKUI = arg_1_0.uiContainer:Find("ik")
	arg_1_0.ikControlUI = arg_1_0._tf:Find("IKControl")
	arg_1_0.controlLayer = arg_1_0.ikControlUI:Find("ControlLayer")

	arg_1_0:InitIKControlRoots()
	arg_1_0:InitButtons()
	arg_1_0:InitDragEvent()
	arg_1_0:InitEvents()

	return
end

function var_0_0.InitIKControlRoots(arg_2_0)
	arg_2_0.ikTipsRoot = arg_2_0.ikControlUI:Find("Tips")

	setActive(arg_2_0.ikTipsRoot, false)

	arg_2_0.ikTouchTipsRoot = arg_2_0.ikControlUI:Find("TouchTips")

	assert(not IsNil(arg_2_0.ikTouchTipsRoot), "Missing IKControl/TouchTips")
	setActive(arg_2_0.ikTouchTipsRoot, false)

	arg_2_0.ikTouchTipTpl = arg_2_0.ikTouchTipsRoot:Find("tpl")

	assert(not IsNil(arg_2_0.ikTouchTipTpl), "Missing IKControl/TouchTips/tpl")
	assert(not IsNil(arg_2_0.ikTouchTipTpl:Find("Click")) and not IsNil(arg_2_0.ikTouchTipTpl:Find("Hold")), "TouchTips/tpl missing Click or Hold")
	setActive(arg_2_0.ikTouchTipTpl, false)

	arg_2_0.holdProgressRoot = arg_2_0.ikControlUI:Find("HoldProgress")

	assert(not IsNil(arg_2_0.holdProgressRoot), "Missing IKControl/HoldProgress")

	arg_2_0.holdProgressTpl = arg_2_0.holdProgressRoot:Find("tpl")

	assert(not IsNil(arg_2_0.holdProgressTpl), "Missing IKControl/HoldProgress/tpl")
	setActive(arg_2_0.holdProgressRoot, false)
	setActive(arg_2_0.holdProgressTpl, false)

	arg_2_0.ikHand = arg_2_0.ikControlUI:Find("Handler")

	setActive(arg_2_0.ikHand, false)
	eachChild(arg_2_0.ikHand, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	arg_2_0.ikTextTipsRoot = arg_2_0.ikControlUI:Find("TextTips")

	setActive(arg_2_0.ikTextTipsRoot, false)
	eachChild(arg_2_0.ikTextTipsRoot, function(arg_4_0)
		setActive(arg_4_0, false)

		return
	end)
	setActive(arg_2_0.ikControlUI, false)

	return
end

function var_0_0.InitButtons(arg_5_0)
	onButton(arg_5_0, arg_5_0.rtIKUI:Find("btn_back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("roll_gametip")
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.rtIKUI:Find("Right/btn_camera"), function()
		arg_5_0:emit(RoomIKSystem.CYCLE_IK_CAMERA_GROUP)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.rtIKUI:Find("Right/MenuSmall"), function()
		setActive(arg_5_0.rtIKUI:Find("Right/MenuSmall"), false)
		setActive(arg_5_0.rtIKUI:Find("Right/Menu"), true)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.rtIKUI:Find("Right/Menu/Collapse"), function()
		setActive(arg_5_0.rtIKUI:Find("Right/Menu"), false)
		setActive(arg_5_0.rtIKUI:Find("Right/MenuSmall"), true)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.rtIKUI:Find("Right/Menu"), function()
		setActive(arg_5_0.rtIKUI:Find("Right"), false)
		arg_5_0:emit(Dorm3dRoomMediator.OPEN_SKIN_SELECT_LAYER, arg_5_0.contextData.GetApartment():GetConfigID(), arg_5_0.contextData.GetCurrentLadyEnv(), function(arg_11_0, arg_11_1, arg_11_2)
			arg_5_0:emit(RoomIKSystem.SWITCH_IK_SKIN, arg_11_0, arg_11_1, arg_11_2)

			return
		end, function()
			setActive(arg_5_0.rtIKUI:Find("Right"), true)

			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitDragEvent(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0.controlLayer:GetComponent(typeof(SlideController))

	if var_13_1 and not IsNil(var_13_1) then
		var_13_1:ClearEvents()

		var_13_1.enabled = false
	end

	local var_13_2 = GetOrAddComponent(arg_13_0.controlLayer, typeof(SlideControllerHotfix))

	var_13_2:ClearEvents()

	arg_13_0.ikSlideController = var_13_2

	var_13_2:AddPointDownFunc(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0:GetTouchTarget(arg_13_0.contextData.GetCurrentLadyEnv(), arg_14_1.position)

		if not var_14_0 then
			return
		end

		arg_13_0.touchPressTarget = var_14_0

		arg_13_0:EmitTouchPress(true, var_14_0, arg_14_1.position)

		return
	end)
	var_13_2:AddPointUpFunc(function(arg_15_0, arg_15_1)
		arg_13_0.touchPressTarget = nil

		if not arg_13_0.touchPressTarget then
			return
		end

		arg_13_0:EmitTouchPress(false, arg_13_0.touchPressTarget, arg_15_1.position)

		return
	end)
	var_13_2:AddBeginDragFunc(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_13_0.contextData.GetCurrentLadyEnv()

		if not var_16_0.IKSettings then
			return
		end

		local var_16_1 = arg_16_1.position
		local var_16_2 = CameraMgr.instance:Raycast(var_16_0.IKSettings.CameraRaycaster, arg_16_1.position):ToTable()
		local var_16_3

		if #var_16_2 <= 0 then
			do return end

			var_16_3 = table.keyof(var_16_0.IKSettings.Colliders, var_16_2[1].gameObject.transform)
		end

		warning(var_16_2[1].gameObject.transform, var_16_3)

		if not var_16_3 then
			return
		end

		arg_13_0:emit(RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY, var_16_0, var_16_3, var_16_1)

		var_13_0 = tobool(var_16_0.ikHandler)

		return
	end)
	var_13_2:AddDragFunc(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_13_0.contextData.GetCurrentLadyEnv()

		if var_17_0.ikHandler then
			arg_13_0:emit(RoomIKSystem.ON_DRAG_CHARACTER_BODY, var_17_0, arg_17_1.position)

			return
		end

		if var_13_0 then
			return
		end

		arg_13_0:emit(Dorm3dRoomTemplateScene.ON_STICK_MOVE, arg_17_1.delta)

		return
	end)
	var_13_2:AddDragEndFunc(function(arg_18_0, arg_18_1)
		var_13_0 = nil

		local var_18_0 = arg_13_0.contextData.GetCurrentLadyEnv()

		if var_18_0.ikHandler then
			arg_13_0:emit(RoomIKSystem.ON_RELEASE_CHARACTER_BODY, var_18_0)
		end

		return
	end)

	return
end

function var_0_0.GetTouchTarget(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_1.IKSettings then
		return
	end

	local var_19_0 = CameraMgr.instance:Raycast(arg_19_1.IKSettings.CameraRaycaster, arg_19_2)

	for iter_19_0, iter_19_1 in ipairs((var_19_0:ToTable())) do
		local var_19_1 = table.keyof(arg_19_1.IKSettings.Colliders, iter_19_1.gameObject.transform)

		if var_19_1 then
			return {
				source = "body",
				target = var_19_1
			}
		end

		local var_19_2 = arg_19_0:GetTouchSceneItem(arg_19_1, iter_19_1.gameObject.transform)

		if var_19_2 then
			return {
				source = "scene_item",
				target = var_19_2
			}
		end
	end

	return
end

function var_0_0.GetTouchSceneItem(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_1.iKTouchDatas then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_1.iKTouchDatas) do
		if #pg.dorm3d_ik_touch[iter_20_1[1]].scene_item > 0 then
			local var_20_0 = arg_20_0.contextData.GetSceneItem(pg.dorm3d_ik_touch[iter_20_1[1]].scene_item)

			if var_20_0 and var_0_0.IsTransformInHierarchy(arg_20_2, var_20_0) then
				return pg.dorm3d_ik_touch[iter_20_1[1]].scene_item
			end
		end
	end

	return
end

function var_0_0.IsTransformInHierarchy(arg_21_0, arg_21_1)
	while arg_21_0 do
		if arg_21_0 == arg_21_1 then
			return true
		end

		arg_21_0 = arg_21_0.parent
	end

	return false
end

function var_0_0.EmitTouchPress(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2.source == "body" then
		local var_22_0 = arg_22_0

		if arg_22_1 then
			local var_22_2 = RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN or RoomTouchSystem.ON_TOUCH_CHARACTER_UP

			var_22_1(var_22_0, var_22_2, arg_22_2.target, arg_22_3)

			goto label_22_0

			::label_22_0::

			if arg_22_2.source == "scene_item" then
				local var_22_3 = arg_22_0

				if arg_22_1 then
					do
						local var_22_5 = RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN or RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP

						var_22_4(var_22_3, var_22_5, arg_22_2.target, arg_22_3)
					end

					return
				end
			end
		end
	end
end

function var_0_0.InitEvents(arg_23_0)
	arg_23_0:bind(var_0_0.SET_CONTROL_ACTIVE, function(arg_24_0, arg_24_1)
		setActive(arg_23_0.ikControlUI, arg_24_1)

		if not arg_24_1 then
			arg_23_0:ResetHand()
			arg_23_0:ResetHoldProgress()

			arg_23_0.touchPressTarget = nil
		end

		return
	end)
	arg_23_0:bind(var_0_0.SET_CAMERA_BUTTON_ACTIVE, function(arg_25_0, arg_25_1)
		setActive(arg_23_0.rtIKUI:Find("Right/btn_camera"), arg_25_1)

		return
	end)
	arg_23_0:bind(var_0_0.RESET_ENTRY_MENU, function(arg_26_0, arg_26_1)
		setActive(arg_23_0.rtIKUI:Find("Right/MenuSmall"), arg_26_1)
		setActive(arg_23_0.rtIKUI:Find("Right/Menu"), false)

		return
	end)
	arg_23_0:bind(var_0_0.SET_BACK_BUTTON_ACTIVE, function(arg_27_0, arg_27_1)
		setActive(arg_23_0.rtIKUI:Find("btn_back"), arg_27_1)

		return
	end)
	arg_23_0:bind(var_0_0.UPDATE_TEXT_TIPS, function(arg_28_0, arg_28_1)
		arg_23_0:UpdateTextTips(arg_28_1)

		return
	end)
	arg_23_0:bind(var_0_0.UPDATE_TIPS, function(arg_29_0, arg_29_1, arg_29_2)
		arg_23_0:UpdateTips(arg_29_1, arg_29_2)

		return
	end)
	arg_23_0:bind(var_0_0.SET_TIPS_ACTIVE, function(arg_30_0, arg_30_1)
		arg_23_0:SetTipsActive(arg_30_1)

		return
	end)
	arg_23_0:bind(var_0_0.SET_HAND_POSITION, function(arg_31_0, arg_31_1)
		setAnchoredPosition(arg_23_0.ikHand, arg_31_1)

		return
	end)
	arg_23_0:bind(var_0_0.PLAY_HAND_BEGIN, function()
		arg_23_0:PlayHandBegin()

		return
	end)
	arg_23_0:bind(var_0_0.PLAY_HAND_END, function()
		arg_23_0:PlayHandEnd()

		return
	end)
	arg_23_0:bind(var_0_0.UPDATE_HOLD_PROGRESS, function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		arg_23_0:UpdateHoldProgress(arg_34_1, arg_34_2, arg_34_3)

		return
	end)

	return
end

function var_0_0.UpdateTextTips(arg_35_0, arg_35_1)
	eachChild(arg_35_0.ikTextTipsRoot, function(arg_36_0)
		setActive(arg_36_0, false)

		return
	end)
	_.each(arg_35_1 or {}, function(arg_37_0)
		local var_37_0 = arg_37_0:getConfig("tip_text")

		if not var_37_0 or #var_37_0 == 0 then
			return
		end

		local var_37_1 = arg_35_0.ikTextTipsRoot:Find(var_37_0)

		if not IsNil(var_37_1) then
			setActive(var_37_1, true)
		end

		return
	end)

	return
end

function var_0_0.SetTipsActive(arg_38_0, arg_38_1)
	if arg_38_1 and arg_38_0.holdProgressActive then
		arg_38_1 = false
	end

	setActive(arg_38_0.ikTipsRoot, arg_38_1)
	setActive(arg_38_0.ikTouchTipsRoot, arg_38_1)
	setActive(arg_38_0.ikTextTipsRoot, arg_38_1)

	return
end

function var_0_0.UpdateHoldProgress(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1 then
		arg_39_0:ResetHoldProgress()

		return
	end

	arg_39_0.holdProgressActive = true

	arg_39_0:SetTipsActive(false)
	setActive(arg_39_0.holdProgressRoot, true)
	setActive(arg_39_0.holdProgressTpl, true)
	setLocalPosition(arg_39_0.holdProgressTpl, LuaHelper.ScreenToLocal(arg_39_0.holdProgressRoot, arg_39_2, pg.UIMgr.GetInstance().uiCameraComp))

	local var_39_0 = arg_39_0.holdProgressTpl:Find("Progress")

	if IsNil(var_39_0) then
		var_39_0 = arg_39_0.holdProgressTpl
	end

	local var_39_1 = GetComponent(var_39_0, typeof(Image))

	if not IsNil(var_39_1) then
		var_39_1.fillAmount = math.clamp(arg_39_3 or 0, 0, 1)
	end

	return
end

function var_0_0.ResetHoldProgress(arg_40_0)
	arg_40_0.holdProgressActive = nil

	setActive(arg_40_0.holdProgressTpl, false)
	setActive(arg_40_0.holdProgressRoot, false)

	return
end

function var_0_0.SetTouchTipType(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1:Find("Click")
	local var_41_1 = arg_41_1:Find("Hold")

	assert(not IsNil(var_41_0) and not IsNil(var_41_1), "TouchTips/tpl item missing Click or Hold")
	setActive(var_41_0, arg_41_2 == RoomTouchSystem.TRIGGER_CLICK)
	setActive(var_41_1, arg_41_2 == RoomTouchSystem.TRIGGER_LONG_PRESS)

	return
end

function var_0_0.UpdateTouchTips(arg_42_0, arg_42_1, arg_42_2)
	UIItemList.StaticAlign(arg_42_0.ikTouchTipsRoot, arg_42_0.ikTouchTipTpl, #arg_42_2, function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_43_1 = arg_43_1 + 1

		local var_43_0
		local var_43_1 = Vector2.zero

		arg_42_0:SetTouchTipType(arg_43_2, pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].trigger_type)

		if pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset and pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset ~= "" then
			var_43_1 = Vector2.New(unpack(pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset))
		end

		var_43_0 = #pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].scene_item > 0 and arg_42_0.contextData.GetSceneItem(pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].scene_item) or arg_42_1.IKSettings.Colliders[pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].body]

		if var_43_0 then
			local var_43_2 = var_43_0.position
			local var_43_3 = var_43_0:GetComponent(typeof(UnityEngine.Collider))

			if var_43_3 then
				var_43_2 = var_43_3.bounds.center
			end

			setLocalPosition(arg_43_2, arg_42_0.contextData.GetLocalPosition(arg_42_0.contextData.GetScreenPosition(var_43_2, arg_42_1.IKSettings.CameraRaycaster.eventCamera), arg_42_0.ikTouchTipsRoot) + var_43_1)
		end

		setActive(arg_43_2, var_43_0)

		return
	end)

	return
end

function var_0_0.PlayHandBegin(arg_44_0)
	setActive(arg_44_0.ikHand, true)
	eachChild(arg_44_0.ikHand, function(arg_45_0)
		setActive(arg_45_0, false)

		return
	end)
	arg_44_0:StopHandTimer()
	setActive(arg_44_0.ikHand:Find("Begin"), true)

	arg_44_0.handTimer = Timer.New(function()
		setActive(arg_44_0.ikHand:Find("Begin"), false)
		setActive(arg_44_0.ikHand:Find("Normal"), true)

		return
	end, 0.5, 1)

	arg_44_0.handTimer:Start()

	return
end

function var_0_0.ResetHand(arg_47_0)
	arg_47_0:StopHandTimer()
	eachChild(arg_47_0.ikHand, function(arg_48_0)
		setActive(arg_48_0, false)

		return
	end)
	setActive(arg_47_0.ikHand, false)

	return
end

function var_0_0.PlayHandEnd(arg_49_0)
	arg_49_0:StopHandTimer()
	setActive(arg_49_0.ikHand:Find("Begin"), false)
	setActive(arg_49_0.ikHand:Find("Normal"), false)
	setActive(arg_49_0.ikHand:Find("End"), true)

	arg_49_0.handTimer = Timer.New(function()
		setActive(arg_49_0.ikHand:Find("End"), false)
		setActive(arg_49_0.ikHand, false)

		return
	end, 0.5, 1)

	arg_49_0.handTimer:Start()

	return
end

function var_0_0.StopHandTimer(arg_51_0)
	if not arg_51_0.handTimer then
		return
	end

	arg_51_0.handTimer:Stop()

	arg_51_0.handTimer = nil

	return
end

function var_0_0.UpdateTips(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_1 and arg_52_2 then
		local var_52_0 = arg_52_2.readyIKLayers or {}

		UIItemList.StaticAlign(arg_52_0.ikTipsRoot, arg_52_0.ikTipsRoot:GetChild(0), #_.filter(var_52_0, function(arg_53_0)
			return not arg_53_0.ignoreDrag
		end), function(arg_54_0, arg_54_1, arg_54_2)
			if arg_54_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_54_1 = arg_54_1 + 1

			local var_54_3 = var_0[arg_54_1]:GetTriggerBoneName()
			local var_54_4 = var_54_3 and arg_52_2.IKSettings.Colliders[var_54_3] or nil
			local var_54_5 = var_0[arg_54_1]:GetIKTipOffset()

			if var_54_3 and arg_52_2.IKSettings.Colliders[var_54_3] or nil then
				local var_54_6 = var_54_4.position
				local var_54_7 = var_54_4:GetComponent(typeof(UnityEngine.Collider))

				if var_54_7 then
					var_54_6 = var_54_7.bounds.center
				end

				local var_54_8 = arg_52_0.contextData.GetLocalPosition(arg_52_0.contextData.GetScreenPosition(var_54_6, arg_52_2.IKSettings.CameraRaycaster.eventCamera), arg_52_0.ikTipsRoot) + var_54_5

				setLocalPosition(arg_54_2, var_54_8)

				local var_54_9 = var_54_2:GetTriggerRect()
				local var_54_10 = var_54_9:PointToNormalized(Vector2.zero)
				local var_54_11 = Vector2.zero

				if var_54_10.x < 0.5 and var_54_10.y < 0.5 then
					var_54_11 = var_54_9.max
				elseif var_54_10.x >= 0.5 and var_54_10.y < 0.5 then
					var_54_11 = Vector2.New(var_54_9.xMin, var_54_9.yMax)
				elseif var_54_10.x < 0.5 and var_54_10.y >= 0.5 then
					var_54_11 = Vector2.New(var_54_9.xMax, var_54_9.yMin)
				elseif var_54_10.x >= 0.5 and var_54_10.y >= 0.5 then
					var_54_11 = var_54_9.min
				end

				if var_54_10.x == 0.5 then
					var_54_11.x = var_54_8.x < 0 and var_54_9.xMax or var_54_9.xMin
				end

				if var_54_10.y == 0.5 then
					var_54_11.y = var_54_8.y < 0 and var_54_9.yMax or var_54_9.yMin
				end

				setLocalRotation(arg_54_2, Quaternion.LookRotation(Vector3.forward, Vector3.New((var_54_11 - var_54_9.center).x, (var_54_11 - var_54_9.center).y, 0)))
			end

			setActive(arg_54_2, var_54_4)

			return
		end)

		local var_52_1 = arg_52_2.iKTouchDatas or {}

		arg_52_0:UpdateTouchTips(arg_52_2, var_52_1)
	end

	arg_52_0:SetTipsActive(arg_52_1)

	return
end

function var_0_0.Dispose(arg_55_0)
	if arg_55_0.ikSlideController then
		arg_55_0.ikSlideController:ClearEvents()

		arg_55_0.ikSlideController = nil
	end

	arg_55_0:ResetHand()
	arg_55_0:ResetHoldProgress()
	var_0_0.super.Dispose(arg_55_0)

	return
end

return var_0_0
