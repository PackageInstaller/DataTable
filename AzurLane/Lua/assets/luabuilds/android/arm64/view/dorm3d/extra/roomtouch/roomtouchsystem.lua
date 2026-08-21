local var_0_0 = class("RoomTouchSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.ENTER_TOUCH_MODE = "RoomTouchSystem.ENTER_TOUCH_MODE"
var_0_0.EXIT_TOUCH_MODE = "RoomTouchSystem.EXIT_TOUCH_MODE"
var_0_0.EXIT_HEARTBEAT_MODE = "RoomTouchSystem.EXIT_HEARTBEAT_MODE"
var_0_0.ON_TOUCH_CHARACTER_DOWN = "RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN"
var_0_0.ON_TOUCH_CHARACTER_UP = "RoomTouchSystem.ON_TOUCH_CHARACTER_UP"
var_0_0.ON_TOUCH_SCENE_ITEM_DOWN = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN"
var_0_0.ON_TOUCH_SCENE_ITEM_UP = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP"
var_0_0.CANCEL_TOUCH_PRESS = "RoomTouchSystem.CANCEL_TOUCH_PRESS"
var_0_0.VALIDATE_TOUCH_CONFIGS = "RoomTouchSystem.VALIDATE_TOUCH_CONFIGS"
var_0_0.UPDATE_TOUCH_PANEL = "RoomTouchSystem.UPDATE_TOUCH_PANEL"
var_0_0.UPDATE_TOUCH_COUNT = "RoomTouchSystem.UPDATE_TOUCH_COUNT"
var_0_0.UPDATE_TOUCH_LEVEL = "RoomTouchSystem.UPDATE_TOUCH_LEVEL"
var_0_0.UPDATE_TOUCH_DISPLAY = "RoomTouchSystem.UPDATE_TOUCH_DISPLAY"
var_0_0.GET_TOUCH_GAME_STATE = "RoomTouchSystem.GET_TOUCH_GAME_STATE"
var_0_0.SET_TOUCH_EXIT_CALL = "RoomTouchSystem.SET_TOUCH_EXIT_CALL"
var_0_0.TRIGGER_CLICK = 1
var_0_0.TRIGGER_LONG_PRESS = 2
var_0_0.HOLD_PROGRESS_SHOW_DELAY = 0.5

function var_0_0.RegisterEvents(arg_1_0)
	arg_1_0:Bind(var_0_0.ENTER_TOUCH_MODE, function(arg_2_0, arg_2_1)
		arg_1_0:EnterTouchMode(arg_2_1)

		return
	end)
	arg_1_0:Bind(var_0_0.EXIT_TOUCH_MODE, function()
		arg_1_0:ExitTouchMode()

		return
	end)
	arg_1_0:Bind(var_0_0.EXIT_HEARTBEAT_MODE, function()
		arg_1_0:ExitHeartbeatMode()

		return
	end)
	arg_1_0:Bind(var_0_0.ON_TOUCH_CHARACTER_DOWN, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:OnTouchPressDown("body", arg_5_1, arg_5_2)

		return
	end)
	arg_1_0:Bind(var_0_0.ON_TOUCH_CHARACTER_UP, function(arg_6_0, arg_6_1)
		arg_1_0:OnTouchPressUp("body", arg_6_1)

		return
	end)
	arg_1_0:Bind(var_0_0.ON_TOUCH_SCENE_ITEM_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:OnTouchPressDown("scene_item", arg_7_1, arg_7_2)

		return
	end)
	arg_1_0:Bind(var_0_0.ON_TOUCH_SCENE_ITEM_UP, function(arg_8_0, arg_8_1)
		arg_1_0:OnTouchPressUp("scene_item", arg_8_1)

		return
	end)
	arg_1_0:Bind(var_0_0.CANCEL_TOUCH_PRESS, function()
		arg_1_0:CancelAllTouchPress()

		return
	end)
	arg_1_0:Bind(var_0_0.VALIDATE_TOUCH_CONFIGS, function(arg_10_0, arg_10_1, arg_10_2)
		arg_1_0:ValidateTouchConfigs(arg_10_1, arg_10_2)

		return
	end)
	arg_1_0:Bind(RoomIKSystem.ON_IK_STATUS_CHANGED, function(arg_11_0, arg_11_1, arg_11_2)
		if not arg_1_0:Func("GetBlackboardValue", arg_1_0:GetCurrentLadyEnv(), "inTouching") then
			return
		end

		arg_1_0:DoTouch(arg_11_1, arg_11_2)

		return
	end)
	arg_1_0:Bind(RoomIKSystem.ON_IK_LAYER_ACTION, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		arg_1_0:TouchModeAction(arg_12_1, arg_12_2, unpack(arg_12_3))(arg_12_4)

		return
	end)
	arg_1_0:Bind(var_0_0.GET_TOUCH_GAME_STATE, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.inTouchGame = arg_1_0.inTouchGame
		end

		return
	end)
	arg_1_0:Bind(var_0_0.SET_TOUCH_EXIT_CALL, function(arg_14_0, arg_14_1)
		arg_1_0.touchExitCall = arg_14_1

		return
	end)

	return
end

function var_0_0.OnDispose(arg_15_0)
	arg_15_0:CancelAllTouchPress()

	if arg_15_0.downTimer then
		arg_15_0.downTimer:Stop()

		arg_15_0.downTimer = nil
	end

	if arg_15_0.sliderLT and LeanTween.isTweening(arg_15_0.sliderLT) then
		LeanTween.cancel(arg_15_0.sliderLT)

		arg_15_0.sliderLT = nil
	end

	return
end

function var_0_0.OnUpdate(arg_16_0)
	arg_16_0:UpdateHoldProgress()

	return
end

function var_0_0.EnterTouchMode(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetCurrentLadyEnv()

	if arg_17_0:Func("GetBlackboardValue", var_17_0, "inTouching") then
		return
	end

	arg_17_1 = arg_17_1 or arg_17_0:GetRoom():getApartmentZoneConfig(var_17_0.ladyBaseZone, "touch_id", arg_17_0:Get("apartment"):GetConfigID())
	arg_17_0.touchConfig = pg.dorm3d_touch_data[arg_17_1]

	if not arg_17_0.touchConfig then
		warning("dorm3d_touch_data no config for id:" .. tostring(arg_17_1))

		return
	end

	arg_17_0.inTouchGame = arg_17_0.touchConfig.heartbeat_enable > 0

	arg_17_0:Emit(var_0_0.UPDATE_TOUCH_PANEL, arg_17_0.inTouchGame)

	if arg_17_0.inTouchGame then
		arg_17_0.touchCount = 0
		arg_17_0.touchLevel = 1
		arg_17_0.lastCount = 0
		arg_17_0.topCount = 0

		arg_17_0:Emit(var_0_0.UPDATE_TOUCH_DISPLAY, arg_17_0.touchLevel, arg_17_0.touchCount)

		arg_17_0.downTimer = Timer.New(function()
			local var_18_0 = pg.dorm3d_set.reduce_interaction.key_value_int

			if arg_17_0.touchLevel > 1 then
				var_18_0 = pg.dorm3d_set.reduce_heartbeat.key_value_int
			end

			arg_17_0:UpdateTouchCount(var_18_0)

			return
		end, 1, -1)

		arg_17_0.downTimer:Start()
	end

	local var_17_1 = {}

	table.insert({}, function(arg_19_0)
		arg_17_0:Func("SetBlackboardValue", var_17_0, "inTouching", true)
		arg_17_0:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
		arg_17_0:Func("SetUI", arg_19_0, "blank")

		return
	end)
	table.insert(var_17_1, function(arg_20_0)
		arg_17_0:Emit(RoomIKSystem.SET_IK_CONFIG, var_17_0, arg_17_0.touchConfig.ik_status[1])
		arg_17_0:Emit(RoomIKSystem.SET_IK_STATE, true, arg_20_0)

		return
	end)
	table.insert(var_17_1, function(arg_21_0)
		existCall(arg_21_0)

		return
	end)
	seriesAsync(var_17_1, function()
		Shader.SetGlobalFloat("_ScreenClipOff", 0)
		arg_17_0:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		return
	end)

	return
end

function var_0_0.ExitTouchMode(arg_23_0)
	if not arg_23_0:Func("GetBlackboardValue", arg_23_0:GetCurrentLadyEnv(), "inTouching") then
		return
	end

	local var_23_0 = {}

	arg_23_0:CancelAllTouchPress()

	if arg_23_0.inTouchGame then
		table.insert(var_23_0, function(arg_24_0)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			arg_23_0:Emit(var_0_0.UPDATE_TOUCH_PANEL, false, true, arg_24_0)

			return
		end)
		table.insert(var_23_0, function(arg_25_0)
			local var_25_0 = 0

			for iter_25_0, iter_25_1 in ipairs(arg_23_0.touchConfig.heartbeat_favor) do
				if iter_25_1[1] > arg_23_0.topCount then
					break
				else
					var_25_0 = iter_25_1[2]
				end
			end

			if var_25_0 > 0 then
				arg_23_0:Emit(Dorm3dRoomMediator.TRIGGER_FAVOR, arg_23_0:Get("apartment").configId, var_25_0)
			end

			arg_23_0.touchCount = nil
			arg_23_0.touchLevel = nil
			arg_23_0.topCount = nil

			if arg_23_0.downTimer then
				arg_23_0.downTimer:Stop()

				arg_23_0.downTimer = nil
			end

			arg_23_0.inTouchGame = false

			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_25_0()

			return
		end)
	else
		table.insert(var_23_0, function(arg_26_0)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)

			if arg_23_0.touchConfig.default_favor > 0 then
				arg_23_0:Emit(Dorm3dRoomMediator.TRIGGER_FAVOR, arg_23_0:Get("apartment").configId, arg_23_0.touchConfig.default_favor)
			end

			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_26_0()

			return
		end)
	end

	table.insert(var_23_0, function(arg_27_0)
		var_0.ikConfig = {
			character_position = var_0.ladyBaseZone,
			character_action = arg_23_0.touchConfig.finish_action
		}

		arg_23_0:Emit(Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE)
		arg_23_0:Emit(RoomIKSystem.SET_IK_STATE, false, arg_27_0)

		return
	end)
	table.insert(var_23_0, function(arg_28_0)
		var_0.ikConfig = nil

		arg_23_0:Emit(RoomIKSystem.SET_IK_SPECIAL_CALL, nil)
		arg_23_0:Func("SetUI", arg_28_0, "back")

		return
	end)
	seriesAsync(var_23_0, function()
		arg_23_0:Func("SetBlackboardValue", var_0, "inTouching", false)
		arg_23_0:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		arg_23_0.touchConfig = nil
		arg_23_0.touchExitCall = nil

		existCall(arg_23_0.touchExitCall)

		return
	end)

	return
end

function var_0_0.TouchModeAction(arg_30_0, arg_30_1, arg_30_2, arg_30_3, ...)
	return switch(arg_30_3, {
		function(arg_31_0, arg_31_1)
			return function(arg_32_0)
				seriesAsync({
					function(arg_33_0)
						if not arg_31_1 or arg_31_1 == "" then
							return arg_33_0()
						end

						arg_30_0:Func("PlaySingleAction", arg_30_1, arg_31_1, arg_33_0)

						return
					end,
					function(arg_34_0)
						arg_30_0:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_31_0)
						arg_30_0:Emit(RoomIKSystem.SET_IK_STATE, true, arg_34_0)

						return
					end,
					arg_32_0
				})

				return
			end
		end,
		function()
			return function()
				arg_30_0:Emit(RoomIKSystem.CONSUME_IK_SPECIAL_CALL, {})

				if ({}).consumed then
					return
				end

				arg_30_0:ExitTouchMode()

				return
			end
		end,
		function(arg_37_0, arg_37_1)
			return function(arg_38_0)
				arg_30_0:Func("PlaySingleAction", arg_30_1, arg_37_1, arg_38_0)

				return
			end
		end,
		function(arg_39_0, arg_39_1, arg_39_2)
			return function(arg_40_0)
				seriesAsync({
					function(arg_41_0)
						arg_30_0:Func("DoTalk", arg_39_1, arg_41_0)

						return
					end,
					function(arg_42_0)
						if not arg_39_2 or arg_39_2 == 0 then
							return arg_42_0()
						end

						arg_30_0:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_39_2)
						arg_30_0:Emit(RoomIKSystem.SET_IK_STATE, true, arg_42_0)

						return
					end,
					arg_40_0
				})

				return
			end
		end,
		function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
			return function(arg_44_0)
				arg_30_0:Func("PlaySceneItemAnim", arg_43_2, arg_43_3)
				arg_30_0:Func("PlaySingleAction", arg_30_1, arg_43_1, arg_44_0)

				return
			end
		end,
		function(arg_45_0)
			return function(arg_46_0)
				if #pg.dorm3d_ik_touch[arg_30_2].scene_item == 0 then
					return
				end

				local var_46_0 = arg_30_0:GetSceneItem(pg.dorm3d_ik_touch[arg_30_2].scene_item)

				if not var_46_0 then
					warning(string.format("dorm3d_ik_touch:%d without scene_item:%s", arg_30_2, pg.dorm3d_ik_touch[arg_30_2].scene_item))

					return
				end

				local var_46_1 = var_46_0:Find(arg_45_0)

				if not IsNil(var_46_1) then
					setActive(var_46_1, false)
					setActive(var_46_1, true)
				end

				arg_46_0()

				return
			end
		end,
		function(arg_47_0)
			local var_47_0 = pg.dorm3d_ik_touch_move[arg_47_0].target_ik
			local var_47_1 = pg.dorm3d_ik_touch_move[arg_47_0].move_time
			local var_47_2 = pg.dorm3d_ik_touch_move[arg_47_0].ik_point
			local var_47_3 = pg.dorm3d_ik_touch_move[arg_47_0].touch_step

			arg_30_1.IKSettings.forceMove = arg_30_1.IKSettings.forceMove or {}

			local var_47_4 = arg_30_1.IKSettings.forceMove

			arg_30_1.IKSettings.forceMove[pg.dorm3d_ik_touch_move[arg_47_0].target_ik] = arg_30_1.IKSettings.forceMove[pg.dorm3d_ik_touch_move[arg_47_0].target_ik] or {}
			arg_30_1.IKSettings.forceMove[pg.dorm3d_ik_touch_move[arg_47_0].target_ik].count = arg_30_1.IKSettings.forceMove[pg.dorm3d_ik_touch_move[arg_47_0].target_ik].count or 0

			return function(arg_48_0)
				seriesAsync({
					function(arg_49_0)
						if var_47_4[var_47_0].count >= #var_47_3 then
							return arg_49_0()
						end

						local var_49_0 = Dorm3dIK.New({
							configId = var_47_0
						})

						var_47_4[var_47_0].count = var_47_4[var_47_0].count + 1

						pg.IKMgr.GetInstance():ResetIK(var_49_0:GetTriggerBoneName())
						pg.IKMgr.GetInstance():PlayIKMove(arg_30_0:Get("raycastCamera"):WorldToScreenPoint(arg_30_1.IKSettings.Colliders[var_49_0:GetTriggerBoneName()].position), var_49_0:GetTriggerBoneName(), Vector2.New(unpack(var_47_2)), var_47_3[var_47_4[var_47_0].count + 1], var_47_1, function()
							var_47_4[var_47_0].count = 0

							arg_49_0()

							return
						end)

						return
					end,
					arg_48_0
				})

				return
			end
		end,
		function(arg_51_0)
			return function(arg_52_0)
				arg_30_0:Emit(Dorm3dStockingMgr.SET_STOCKING_STATUS, arg_51_0)

				return
			end
		end,
		function(arg_53_0, arg_53_1)
			return function()
				arg_30_0:Emit(RoomIKSystem.SET_IK_SWITCH_SKIN_ID, arg_30_0:Get("apartment"):GetCurSkinId())
				arg_30_1:SwitchCharacterSkin(arg_30_0:Get("apartment"):GetConfigID(), arg_53_0)
				arg_30_0:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_53_1)
				arg_30_0:Emit(RoomIKSystem.SET_IK_STATE, true)

				return
			end
		end
	}, function()
		return function()
			return
		end
	end, ...)
end

function var_0_0.GetTouchPressKey(arg_57_0, arg_57_1, arg_57_2)
	return tostring(arg_57_1) .. ":" .. tostring(arg_57_2)
end

function var_0_0.AssertTouchSource(arg_58_0, arg_58_1, arg_58_2)
	assert(arg_58_1 == "body" or arg_58_1 == "scene_item", "Unknown touch source: " .. tostring(arg_58_1))
	assert(arg_58_2 and arg_58_2 ~= "", "Invalid touch target: " .. tostring(arg_58_2))

	return
end

function var_0_0.GetTouchConfigSourceTarget(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = type(arg_59_1.scene_item) == "string" and arg_59_1.scene_item ~= ""

	assert((type(arg_59_1.body) == "string" and arg_59_1.body ~= "") ~= var_59_0, "Invalid dorm3d_ik_touch source: " .. tostring(arg_59_2 or arg_59_1.id))

	if var_59_0 then
		return "scene_item", arg_59_1.scene_item
	else
		return "body", arg_59_1.body
	end

	return
end

function var_0_0.AssertTouchConfig(arg_60_0, arg_60_1)
	local var_60_0 = pg.dorm3d_ik_touch[arg_60_1]

	assert(pg.dorm3d_ik_touch[arg_60_1], "Missing dorm3d_ik_touch config: " .. tostring(arg_60_1))
	assert(var_60_0.trigger_type == var_0_0.TRIGGER_CLICK or var_60_0.trigger_type == var_0_0.TRIGGER_LONG_PRESS, "Invalid dorm3d_ik_touch trigger_type: " .. tostring(arg_60_1))

	if var_60_0.trigger_type == var_0_0.TRIGGER_LONG_PRESS then
		assert(type(var_60_0.hold_time) == "number" and var_60_0.hold_time > 0, "Invalid dorm3d_ik_touch hold_time: " .. tostring(arg_60_1))
	end

	arg_60_0:GetTouchConfigSourceTarget(var_60_0, arg_60_1)

	return var_60_0
end

function var_0_0.ValidateTouchConfigs(arg_61_0, arg_61_1, arg_61_2)
	assert(type(arg_61_1) == "table", "Invalid dorm3d_ik_status touch_data: " .. tostring(arg_61_2))

	local var_61_0 = {}

	_.each(arg_61_1, function(arg_62_0)
		local var_62_0 = arg_61_0:AssertTouchConfig(arg_62_0[1])
		local var_62_1, var_62_2 = arg_61_0:GetTouchConfigSourceTarget(var_62_0, arg_62_0[1])
		local var_62_3 = var_62_1 .. ":" .. var_62_2 .. ":" .. tostring(var_62_0.trigger_type)

		assert(not var_61_0[var_62_3], string.format("Duplicate dorm3d_ik_touch trigger: ids=%s,%s source=%s target=%s trigger_type=%s", tostring(var_61_0[var_62_3]), tostring(arg_62_0[1]), var_62_1, var_62_2, tostring(var_62_0.trigger_type)))

		var_61_0[var_62_3] = arg_62_0[1]

		return
	end)

	return
end

function var_0_0.GetTouchInfos(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	arg_63_0:AssertTouchSource(arg_63_1, arg_63_2)

	local var_63_0 = arg_63_0:GetCurrentLadyEnv()

	if not var_63_0.ikConfig then
		return {}, var_63_0
	end

	assert(type(var_63_0.iKTouchDatas) == "table", "Invalid current IK touch data")

	local var_63_1 = {}

	for iter_63_0, iter_63_1 in ipairs(var_63_0.iKTouchDatas) do
		local var_63_2, var_63_3, var_63_4 = unpack(iter_63_1)
		local var_63_5 = arg_63_0:AssertTouchConfig(var_63_2)
		local var_63_6, var_63_7 = arg_63_0:GetTouchConfigSourceTarget(var_63_5, var_63_2)

		if var_63_6 == arg_63_1 and var_63_7 == arg_63_2 and var_63_5.trigger_type == arg_63_3 then
			table.insert(var_63_1, iter_63_1)
		end
	end

	assert(#var_63_1 <= 1, string.format("Duplicate dorm3d_ik_touch trigger: source=%s target=%s trigger_type=%s", tostring(arg_63_1), tostring(arg_63_2), tostring(arg_63_3)))

	return var_63_1, var_63_0
end

function var_0_0.GetFirstLongPressInfo(arg_64_0, arg_64_1, arg_64_2)
	return arg_64_0:GetTouchInfos(arg_64_1, arg_64_2, var_0_0.TRIGGER_LONG_PRESS)[1]
end

function var_0_0.OnTouchPressDown(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:AssertTouchSource(arg_65_1, arg_65_2)
	arg_65_0:ClearTouchPressConsumed(arg_65_1, arg_65_2)
	arg_65_0:CancelTouchPress(arg_65_1, arg_65_2)

	local var_65_0 = arg_65_0:GetFirstLongPressInfo(arg_65_1, arg_65_2)

	if not var_65_0 then
		return
	end

	assert(arg_65_3, "Missing touch press screenPosition")

	local var_65_1 = arg_65_0:AssertTouchConfig(var_65_0[1])
	local var_65_2 = {
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3,
		startTime = Time.time
	}

	;({
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3,
		startTime = Time.time
	}).timer = Timer.New(function()
		var_65_2.triggered = true
		var_65_2.timer = nil

		arg_65_0:HideHoldProgress()
		arg_65_0:SetTouchPressConsumed(arg_65_1, arg_65_2)
		arg_65_0:TriggerTouchInfo(var_65_0)

		return
	end, var_65_1.hold_time, 1)

	;({
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3,
		startTime = Time.time
	}).timer:Start()

	arg_65_0.touchPressStates = arg_65_0.touchPressStates or {}
	arg_65_0.touchPressStates[arg_65_0:GetTouchPressKey(arg_65_1, arg_65_2)] = {
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3,
		startTime = Time.time
	}

	return
end

function var_0_0.OnTouchPressUp(arg_67_0, arg_67_1, arg_67_2)
	arg_67_0:AssertTouchSource(arg_67_1, arg_67_2)

	local var_67_0 = arg_67_0:GetTouchPressKey(arg_67_1, arg_67_2)

	if arg_67_0.touchPressStates then
		local var_67_1 = arg_67_0.touchPressStates[var_67_0] or nil

		if var_67_1 then
			local var_67_2 = var_67_1.triggered or arg_67_0.touchPressConsumed and arg_67_0.touchPressConsumed[var_67_0]

			arg_67_0:CancelTouchPress(arg_67_1, arg_67_2)
			arg_67_0:ClearTouchPressConsumed(arg_67_1, arg_67_2)

			if var_67_2 then
				return
			end

			local var_67_3 = arg_67_0:GetTouchInfos(arg_67_1, arg_67_2, var_0_0.TRIGGER_CLICK)

			if not var_67_3[1] then
				return
			end

			arg_67_0:TriggerTouchInfo(var_67_3[1])

			return
		end
	end
end

function var_0_0.SetTouchPressConsumed(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0.touchPressConsumed = arg_68_0.touchPressConsumed or {}
	arg_68_0.touchPressConsumed[arg_68_0:GetTouchPressKey(arg_68_1, arg_68_2)] = true

	return
end

function var_0_0.ClearTouchPressConsumed(arg_69_0, arg_69_1, arg_69_2)
	if not arg_69_0.touchPressConsumed then
		return
	end

	arg_69_0.touchPressConsumed[arg_69_0:GetTouchPressKey(arg_69_1, arg_69_2)] = nil

	return
end

function var_0_0.CancelTouchPress(arg_70_0, arg_70_1, arg_70_2)
	if not arg_70_0.touchPressStates then
		return
	end

	local var_70_0 = arg_70_0:GetTouchPressKey(arg_70_1, arg_70_2)

	if arg_70_0.touchPressStates[var_70_0] and arg_70_0.touchPressStates[var_70_0].timer then
		arg_70_0.touchPressStates[var_70_0].timer:Stop()
	end

	arg_70_0:HideHoldProgress()

	arg_70_0.touchPressStates[var_70_0] = nil

	return
end

function var_0_0.CancelAllTouchPress(arg_71_0)
	arg_71_0:HideHoldProgress()

	if not arg_71_0.touchPressStates then
		return
	end

	for iter_71_0, iter_71_1 in pairs(arg_71_0.touchPressStates) do
		if iter_71_1.timer then
			iter_71_1.timer:Stop()
		end
	end

	arg_71_0.touchPressStates = nil

	return
end

function var_0_0.HideHoldProgress(arg_72_0)
	if not arg_72_0.holdProgressActive then
		return
	end

	arg_72_0.holdProgressActive = nil

	arg_72_0:Emit(Dorm3dIKView.UPDATE_HOLD_PROGRESS, false)

	return
end

function var_0_0.UpdateHoldProgress(arg_73_0)
	if not arg_73_0.touchPressStates then
		arg_73_0:HideHoldProgress()

		return
	end

	for iter_73_0, iter_73_1 in pairs(arg_73_0.touchPressStates) do
		if not iter_73_1.triggered and iter_73_1.holdTime > var_0_0.HOLD_PROGRESS_SHOW_DELAY then
			if Time.time - iter_73_1.startTime >= var_0_0.HOLD_PROGRESS_SHOW_DELAY then
				arg_73_0.holdProgressActive = true

				arg_73_0:Emit(Dorm3dIKView.UPDATE_HOLD_PROGRESS, true, iter_73_1.screenPosition, (Time.time - iter_73_1.startTime) / iter_73_1.holdTime)

				return
			end
		end
	end

	arg_73_0:HideHoldProgress()

	return
end

function var_0_0.TriggerTouchInfo(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0:GetCurrentLadyEnv()
	local var_74_1, var_74_2, var_74_3 = unpack(arg_74_1)
	local var_74_4 = arg_74_0:AssertTouchConfig(var_74_1)

	if #var_74_4.action_emote > 0 then
		arg_74_0:Func("PlayFaceAnim", var_74_0, var_74_4.action_emote)
	end

	local var_74_5 = var_74_4.vibrate

	if type(var_74_4.vibrate) == "table" and VibrateMgr.Instance:IsSupport() then
		local var_74_6 = {}
		local var_74_7 = {}
		local var_74_8 = {}

		underscore.each(var_74_5, function(arg_75_0)
			local var_75_0 = arg_75_0[1]

			if PLATFORM == PLATFORM_IPHONEPLAYER then
				var_75_0 = var_75_0 / 1000
			end

			table.insert(var_74_6, var_75_0)
			table.insert(var_74_7, arg_75_0[2])
			table.insert(var_74_8, 1)

			return
		end)

		if PLATFORM == PLATFORM_ANDROID then
			VibrateMgr.Instance:VibrateWaveform({}, {})
		elseif PLATFORM == PLATFORM_IPHONEPLAYER then
			VibrateMgr.Instance:VibrateWaveform({}, {}, {})
		end
	end

	arg_74_0:Emit(RoomIKSystem.SET_IK_BLOCK, true)
	arg_74_0:TouchModeAction(var_74_0, var_74_1, unpack(var_74_3))(function()
		arg_74_0:Emit(RoomIKSystem.RESET_IK_TIP_TIMER)
		arg_74_0:Emit(RoomIKSystem.SET_IK_BLOCK, nil)

		return
	end)

	return
end

function var_0_0.UpdateTouchCount(arg_77_0, arg_77_1)
	local var_77_0, var_77_1

	if arg_77_0.touchLevel > 1 then
		arg_77_1 = math.min(0, arg_77_1)
		var_77_0 = arg_77_0.touchLevel > 1 and 200 or 100
		var_77_1 = math.clamp
	end

	arg_77_0.touchCount = var_77_1(arg_77_0.touchCount + arg_77_1, arg_77_0.touchLevel > 1 and 100 or 0, var_77_0)

	local var_77_2

	if arg_77_0.touchLevel == 1 and arg_77_0.touchCount >= 100 then
		var_77_2 = 2
	elseif arg_77_0.touchLevel > 1 and arg_77_0.touchCount <= 100 then
		var_77_2 = 1
	end

	if var_77_2 and var_77_2 ~= arg_77_0.touchLevel then
		arg_77_0:Emit(RoomIKSystem.GET_IK_BLOCK, {})

		if ({}).blockIK then
			arg_77_0:Emit(var_0_0.UPDATE_TOUCH_COUNT, arg_77_0.touchCount)

			arg_77_0.topCount = math.max(arg_77_0.topCount, arg_77_0.touchCount)

			return
		end

		arg_77_0.touchLevel = var_77_2

		if arg_77_0.touchConfig.ik_status[var_77_2] then
			if var_77_2 > 1 then
				arg_77_0.touchCount = 200
			elseif var_77_2 == 1 then
				arg_77_0.touchCount = 0
			end

			local var_77_3 = arg_77_0:GetCurrentLadyEnv()

			seriesAsync({
				function(arg_78_0)
					arg_77_0:Func("ShowBlackScreen", true, arg_78_0)

					return
				end,
				function(arg_79_0)
					arg_77_0:Emit(RoomIKSystem.SET_IK_CONFIG, var_77_3, var_0)
					arg_77_0:Emit(RoomIKSystem.SET_IK_STATE, true, arg_79_0)

					if var_77_2 > 1 and arg_77_0.touchConfig.heartbeat_enter_anim ~= "" then
						arg_77_0:Func("SwitchAnim", var_77_3, arg_77_0.touchConfig.heartbeat_enter_anim)
					end

					return
				end,
				function(arg_80_0)
					arg_77_0:Func("ShowBlackScreen", false, arg_80_0)

					return
				end
			})
		end

		arg_77_0:Emit(var_0_0.UPDATE_TOUCH_DISPLAY, arg_77_0.touchLevel, arg_77_0.touchCount)
	else
		arg_77_0:Emit(var_0_0.UPDATE_TOUCH_COUNT, arg_77_0.touchCount)
	end

	arg_77_0.topCount = math.max(arg_77_0.topCount, arg_77_0.touchCount)

	return
end

function var_0_0.ExitHeartbeatMode(arg_81_0)
	if not arg_81_0.touchLevel or arg_81_0.touchLevel == 1 then
		return
	end

	arg_81_0.touchCount = 0

	arg_81_0:UpdateTouchCount(0)

	return
end

function var_0_0.DoTouch(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_0.inTouchGame then
		switch(arg_82_2, {
			function()
				arg_82_0:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				arg_82_0:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				arg_82_0:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				arg_82_0:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat_trriger.key_value_int)

				return
			end
		})
	end

	return
end

return var_0_0
