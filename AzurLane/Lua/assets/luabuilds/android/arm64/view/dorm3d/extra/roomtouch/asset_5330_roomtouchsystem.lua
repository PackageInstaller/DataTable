class = var_0_10000

local var_0_0 = "RoomTouchSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.ENTER_TOUCH_MODE = "RoomTouchSystem.ENTER_TOUCH_MODE"
var_0_1.EXIT_TOUCH_MODE = "RoomTouchSystem.EXIT_TOUCH_MODE"
var_0_1.EXIT_HEARTBEAT_MODE = "RoomTouchSystem.EXIT_HEARTBEAT_MODE"
var_0_1.ON_TOUCH_CHARACTER_DOWN = "RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN"
var_0_1.ON_TOUCH_CHARACTER_UP = "RoomTouchSystem.ON_TOUCH_CHARACTER_UP"
var_0_1.ON_TOUCH_SCENE_ITEM_DOWN = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN"
var_0_1.ON_TOUCH_SCENE_ITEM_UP = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP"
var_0_1.CANCEL_TOUCH_PRESS = "RoomTouchSystem.CANCEL_TOUCH_PRESS"
var_0_1.VALIDATE_TOUCH_CONFIGS = "RoomTouchSystem.VALIDATE_TOUCH_CONFIGS"
var_0_1.UPDATE_TOUCH_PANEL = "RoomTouchSystem.UPDATE_TOUCH_PANEL"
var_0_1.UPDATE_TOUCH_COUNT = "RoomTouchSystem.UPDATE_TOUCH_COUNT"
var_0_1.UPDATE_TOUCH_LEVEL = "RoomTouchSystem.UPDATE_TOUCH_LEVEL"
var_0_1.UPDATE_TOUCH_DISPLAY = "RoomTouchSystem.UPDATE_TOUCH_DISPLAY"
var_0_1.GET_TOUCH_GAME_STATE = "RoomTouchSystem.GET_TOUCH_GAME_STATE"
var_0_1.SET_TOUCH_EXIT_CALL = "RoomTouchSystem.SET_TOUCH_EXIT_CALL"
var_0_1.TRIGGER_CLICK = 1
var_0_1.TRIGGER_LONG_PRESS = 2
var_0_1.HOLD_PROGRESS_SHOW_DELAY = 0.5

function var_0_1.RegisterEvents(arg_1_0)
	arg_1_0:Bind(var_0_1.ENTER_TOUCH_MODE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.EnterTouchMode(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:Bind(var_0_1.EXIT_TOUCH_MODE, function()
		local var_3_0 = arg_1_0

		var_0.ExitTouchMode(var_3_0)

		return
	end)
	arg_1_0:Bind(var_0_1.EXIT_HEARTBEAT_MODE, function()
		local var_4_0 = arg_1_0

		var_0.ExitHeartbeatMode(var_4_0)

		return
	end)
	arg_1_0:Bind(var_0_1.ON_TOUCH_CHARACTER_DOWN, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0

		var_3.OnTouchPressDown(var_5_0, "body", arg_5_1, arg_5_2)

		return
	end)
	arg_1_0:Bind(var_0_1.ON_TOUCH_CHARACTER_UP, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0

		var_2.OnTouchPressUp(var_6_0, "body", arg_6_1)

		return
	end)
	arg_1_0:Bind(var_0_1.ON_TOUCH_SCENE_ITEM_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0

		var_3.OnTouchPressDown(var_7_0, "scene_item", arg_7_1, arg_7_2)

		return
	end)
	arg_1_0:Bind(var_0_1.ON_TOUCH_SCENE_ITEM_UP, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0

		var_2.OnTouchPressUp(var_8_0, "scene_item", arg_8_1)

		return
	end)
	arg_1_0:Bind(var_0_1.CANCEL_TOUCH_PRESS, function()
		local var_9_0 = arg_1_0

		var_0.CancelAllTouchPress(var_9_0)

		return
	end)
	arg_1_0:Bind(var_0_1.VALIDATE_TOUCH_CONFIGS, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_1_0

		var_3.ValidateTouchConfigs(var_10_0, arg_10_1, arg_10_2)

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.Bind

	RoomIKSystem = var_4

	var_1_1(var_1_0, var_4.ON_IK_STATUS_CHANGED, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_1_0
		local var_11_1 = var_3.GetCurrentLadyEnv(var_11_0)
		local var_11_2 = arg_1_0

		if not var_4.Func(var_11_2, "GetBlackboardValue", var_11_1, "inTouching") then
			return
		end

		local var_11_3 = arg_1_0

		var_4.DoTouch(var_11_3, arg_11_1, arg_11_2)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.Bind

	RoomIKSystem = var_4

	var_1_3(var_1_2, var_4.ON_IK_LAYER_ACTION, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = arg_1_0
		local var_12_1 = var_5.TouchModeAction
		local var_12_2 = arg_12_1
		local var_12_3 = arg_12_2

		unpack = var_2_10010

		var_12_1(var_12_0, var_12_2, var_12_3, var_2_10010(arg_12_3))(arg_12_4)

		return
	end)
	arg_1_0:Bind(var_0_1.GET_TOUCH_GAME_STATE, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.inTouchGame = arg_1_0.inTouchGame
		end

		return
	end)
	arg_1_0:Bind(var_0_1.SET_TOUCH_EXIT_CALL, function(arg_14_0, arg_14_1)
		arg_1_0.touchExitCall = arg_14_1

		return
	end)

	return
end

function var_0_1.OnDispose(arg_15_0)
	arg_15_0:CancelAllTouchPress()

	if arg_15_0.downTimer then
		local var_15_0 = arg_15_0.downTimer

		var_1.Stop(var_15_0)

		arg_15_0.downTimer = nil
	end

	if arg_15_0.sliderLT then
		LeanTween = var_1

		if var_1.isTweening(arg_15_0.sliderLT) then
			LeanTween = var_1

			var_1.cancel(arg_15_0.sliderLT)

			arg_15_0.sliderLT = nil
		end
	end

	return
end

function var_0_1.OnUpdate(arg_16_0)
	arg_16_0:UpdateHoldProgress()

	return
end

function var_0_1.EnterTouchMode(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetCurrentLadyEnv()

	if arg_17_0:Func("GetBlackboardValue", var_17_0, "inTouching") then
		return
	end

	local var_17_2, var_17_3

	if not arg_17_1 then
		local var_17_1 = arg_17_0:GetRoom()

		var_17_2 = var_17_2.getApartmentZoneConfig
		var_17_3 = var_17_0.ladyBaseZone

		local var_17_4 = "touch_id"
		local var_17_5 = arg_17_0:Get("apartment")

		arg_17_1 = var_17_2(var_17_1, var_17_3, var_17_4, var_8.GetConfigID(var_17_5))
	end

	pg = var_17_2
	arg_17_0.touchConfig = var_17_2.dorm3d_touch_data[arg_17_1]

	if not arg_17_0.touchConfig then
		warning = var_3

		local var_17_6 = "dorm3d_touch_data no config for id:"

		tostring = var_17_3

		var_3(var_17_6 .. var_17_3(arg_17_1))

		return
	end

	local var_17_7 = arg_17_0.touchConfig.heartbeat_enable

	arg_17_0.inTouchGame = 0 < var_17_7

	arg_17_0:Emit(var_0_1.UPDATE_TOUCH_PANEL, arg_17_0.inTouchGame)

	if arg_17_0.inTouchGame then
		arg_17_0.touchCount = 0
		arg_17_0.touchLevel = 1
		arg_17_0.lastCount = 0
		arg_17_0.topCount = 0

		arg_17_0:Emit(var_0_1.UPDATE_TOUCH_DISPLAY, arg_17_0.touchLevel, arg_17_0.touchCount)

		Timer = var_3
		arg_17_0.downTimer = var_3.New(function()
			pg = var_2_10000

			local var_18_0 = var_2_10000.dorm3d_set.reduce_interaction.key_value_int

			if arg_17_0.touchLevel > 1 then
				pg = var_1
				var_18_0 = var_1.dorm3d_set.reduce_heartbeat.key_value_int
			end

			local var_18_1 = arg_17_0

			var_1.UpdateTouchCount(var_18_1, var_18_0)

			return
		end, 1, -1)

		local var_17_8 = arg_17_0.downTimer

		var_3.Start(var_17_8)
	end

	local var_17_9 = {}

	table = var_4

	var_4.insert(var_17_9, function(arg_19_0)
		local var_19_0 = arg_17_0

		var_1.Func(var_19_0, "SetBlackboardValue", var_17_0, "inTouching", true)

		local var_19_1 = arg_17_0
		local var_19_2 = var_1.Emit

		Dorm3dRoomTemplateScene = var_4

		var_19_2(var_19_1, var_4.SHOW_BLOCK)

		local var_19_3 = arg_17_0

		var_1.Func(var_19_3, "SetUI", arg_19_0, "blank")

		return
	end)

	table = var_4

	var_4.insert(var_17_9, function(arg_20_0)
		local var_20_0 = arg_17_0.touchConfig.ik_status[1]
		local var_20_1 = arg_17_0
		local var_20_2 = var_2.Emit

		RoomIKSystem = var_2_10005

		var_20_2(var_20_1, var_2_10005.SET_IK_CONFIG, var_17_0, var_20_0)

		local var_20_3 = arg_17_0
		local var_20_4 = var_2.Emit

		RoomIKSystem = var_5

		var_20_4(var_20_3, var_5.SET_IK_STATE, true, arg_20_0)

		return
	end)

	table = var_4

	var_4.insert(var_17_9, function(arg_21_0)
		existCall = var_2_10001

		var_2_10001(arg_21_0)

		return
	end)

	seriesAsync = var_4

	var_4(var_17_9, function()
		Shader = var_2_10000

		var_2_10000.SetGlobalFloat("_ScreenClipOff", 0)

		local var_22_0 = arg_17_0
		local var_22_1 = var_0.Emit

		Dorm3dRoomTemplateScene = var_3

		var_22_1(var_22_0, var_3.HIDE_BLOCK)

		return
	end)

	return
end

function var_0_1.ExitTouchMode(arg_23_0)
	local var_23_0 = arg_23_0:GetCurrentLadyEnv()

	if not arg_23_0:Func("GetBlackboardValue", var_23_0, "inTouching") then
		return
	end

	local var_23_1 = {}

	arg_23_0:CancelAllTouchPress()

	if arg_23_0.inTouchGame then
		table = var_3

		var_3.insert(var_23_1, function(arg_24_0)
			local var_24_0 = arg_23_0
			local var_24_1 = var_1.Emit

			Dorm3dRoomTemplateScene = var_2_10004

			var_24_1(var_24_0, var_2_10004.SHOW_BLOCK)

			local var_24_2 = arg_23_0

			var_1.Emit(var_24_2, var_0_1.UPDATE_TOUCH_PANEL, false, true, arg_24_0)

			return
		end)

		table = var_3

		var_3.insert(var_23_1, function(arg_25_0)
			local var_25_0 = 0

			ipairs = var_2_10002

			for iter_25_0, iter_25_1 in var_2_10002(arg_23_0.touchConfig.heartbeat_favor) do
				if iter_25_1[1] > arg_23_0.topCount then
					break
				else
					var_25_0 = iter_25_1[2]
				end
			end

			if var_25_0 > 0 then
				local var_25_1 = arg_23_0
				local var_25_2 = var_2.Emit

				Dorm3dRoomMediator = iter_25_0

				local var_25_3 = iter_25_0.TRIGGER_FAVOR
				local var_25_4 = arg_23_0

				var_25_2(var_25_1, var_25_3, var_6.Get(var_25_4, "apartment").configId, var_25_0)
			end

			arg_23_0.touchCount = nil
			arg_23_0.touchLevel = nil
			arg_23_0.topCount = nil

			if arg_23_0.downTimer then
				local var_25_5 = arg_23_0.downTimer

				var_2.Stop(var_25_5)

				arg_23_0.downTimer = nil
			end

			local var_25_6 = arg_23_0

			var_25_6.inTouchGame = false
			Shader = var_25_6

			var_25_6.SetGlobalFloat("_ScreenClipOff", 1)
			arg_25_0()

			return
		end)
	else
		table = var_3

		var_3.insert(var_23_1, function(arg_26_0)
			local var_26_0 = arg_23_0
			local var_26_1 = var_1.Emit

			Dorm3dRoomTemplateScene = var_2_10004

			var_26_1(var_26_0, var_2_10004.SHOW_BLOCK)

			local var_26_2 = arg_23_0.touchConfig.default_favor
			local var_26_4

			if 0 < var_26_2 then
				local var_26_3 = arg_23_0

				var_26_4 = var_26_4.Emit
				Dorm3dRoomMediator = var_2_10005

				local var_26_5 = var_2_10005.TRIGGER_FAVOR
				local var_26_6 = arg_23_0

				var_26_4(var_26_3, var_26_5, var_6.Get(var_26_6, "apartment").configId, var_26_2)
			end

			Shader = var_26_4

			var_26_4.SetGlobalFloat("_ScreenClipOff", 1)
			arg_26_0()

			return
		end)
	end

	table = var_3

	var_3.insert(var_23_1, function(arg_27_0)
		var_23_0.ikConfig = {
			character_position = var_23_0.ladyBaseZone,
			character_action = arg_23_0.touchConfig.finish_action
		}

		local var_27_0 = arg_23_0
		local var_27_1 = var_1.Emit

		Dorm3dStockingMgr = var_2_10004

		var_27_1(var_27_0, var_2_10004.ON_EXIT_TOUCH_MODE)

		local var_27_2 = arg_23_0
		local var_27_3 = var_1.Emit

		RoomIKSystem = var_4

		var_27_3(var_27_2, var_4.SET_IK_STATE, false, arg_27_0)

		return
	end)

	table = var_3

	var_3.insert(var_23_1, function(arg_28_0)
		var_23_0.ikConfig = nil

		local var_28_0 = arg_23_0
		local var_28_1 = var_1.Emit

		RoomIKSystem = var_2_10004

		var_28_1(var_28_0, var_2_10004.SET_IK_SPECIAL_CALL, nil)

		local var_28_2 = arg_23_0

		var_1.Func(var_28_2, "SetUI", arg_28_0, "back")

		return
	end)

	seriesAsync = var_3

	var_3(var_23_1, function()
		local var_29_0 = arg_23_0

		var_0.Func(var_29_0, "SetBlackboardValue", var_23_0, "inTouching", false)

		local var_29_1 = arg_23_0
		local var_29_2 = var_0.Emit

		Dorm3dRoomTemplateScene = var_3

		var_29_2(var_29_1, var_3.HIDE_BLOCK)

		arg_23_0.touchConfig = nil

		local var_29_3 = arg_23_0.touchExitCall
		local var_29_4 = arg_23_0

		var_29_4.touchExitCall = nil
		existCall = var_29_4

		var_29_4(var_29_3)

		return
	end)

	return
end

function var_0_1.TouchModeAction(arg_30_0, arg_30_1, arg_30_2, arg_30_3, ...)
	switch = var_1_10004

	return var_1_10004(arg_30_3, {
		function(arg_31_0, arg_31_1)
			return function(arg_32_0)
				seriesAsync = var_3_10001

				var_3_10001({
					function(arg_33_0)
						if not arg_31_1 or arg_31_1 == "" then
							return arg_33_0()
						end

						local var_33_0 = arg_30_0

						var_1.Func(var_33_0, "PlaySingleAction", arg_30_1, arg_31_1, arg_33_0)

						return
					end,
					function(arg_34_0)
						local var_34_0 = arg_30_0
						local var_34_1 = var_1.Emit

						RoomIKSystem = var_4_10004

						var_34_1(var_34_0, var_4_10004.SET_IK_CONFIG, arg_30_1, arg_31_0)

						local var_34_2 = arg_30_0
						local var_34_3 = var_1.Emit

						RoomIKSystem = var_4

						var_34_3(var_34_2, var_4.SET_IK_STATE, true, arg_34_0)

						return
					end,
					arg_32_0
				})

				return
			end
		end,
		function()
			return function()
				local var_36_0 = {}
				local var_36_1 = arg_30_0
				local var_36_2 = var_1.Emit

				RoomIKSystem = var_3_10004

				var_36_2(var_36_1, var_3_10004.CONSUME_IK_SPECIAL_CALL, var_36_0)

				if var_36_0.consumed then
					return
				end

				local var_36_3 = arg_30_0

				var_1.ExitTouchMode(var_36_3)

				return
			end
		end,
		function(arg_37_0, arg_37_1)
			return function(arg_38_0)
				local var_38_0 = arg_30_0

				var_1.Func(var_38_0, "PlaySingleAction", arg_30_1, arg_37_1, arg_38_0)

				return
			end
		end,
		function(arg_39_0, arg_39_1, arg_39_2)
			return function(arg_40_0)
				seriesAsync = var_3_10001

				var_3_10001({
					function(arg_41_0)
						local var_41_0 = arg_30_0

						var_1.Func(var_41_0, "DoTalk", arg_39_1, arg_41_0)

						return
					end,
					function(arg_42_0)
						if not arg_39_2 or arg_39_2 == 0 then
							return arg_42_0()
						end

						local var_42_0 = arg_30_0
						local var_42_1 = var_1.Emit

						RoomIKSystem = var_4_10004

						var_42_1(var_42_0, var_4_10004.SET_IK_CONFIG, arg_30_1, arg_39_2)

						local var_42_2 = arg_30_0
						local var_42_3 = var_1.Emit

						RoomIKSystem = var_4

						var_42_3(var_42_2, var_4.SET_IK_STATE, true, arg_42_0)

						return
					end,
					arg_40_0
				})

				return
			end
		end,
		function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
			return function(arg_44_0)
				local var_44_0 = arg_30_0

				var_1.Func(var_44_0, "PlaySceneItemAnim", arg_43_2, arg_43_3)

				local var_44_1 = arg_30_0

				var_1.Func(var_44_1, "PlaySingleAction", arg_30_1, arg_43_1, arg_44_0)

				return
			end
		end,
		function(arg_45_0)
			return function(arg_46_0)
				pg = var_3_10001

				if #var_3_10001.dorm3d_ik_touch[arg_30_2].scene_item == 0 then
					return
				end

				local var_46_0 = arg_30_0

				if not var_2.GetSceneItem(var_46_0, var_1.scene_item) then
					warning = var_3_10003
					string = var_5

					var_3_10003(var_5.format("dorm3d_ik_touch:%d without scene_item:%s", arg_30_2, var_1.scene_item))

					return
				end

				local var_46_1 = var_2:Find(arg_45_0)

				IsNil = var_46_0

				if not var_46_0(var_46_1) then
					setActive = var_4

					var_4(var_46_1, false)

					setActive = var_4

					var_4(var_46_1, true)
				end

				arg_46_0()

				return
			end
		end,
		function(arg_47_0)
			pg = var_2_10001

			local var_47_0 = var_2_10001.dorm3d_ik_touch_move[arg_47_0].target_ik
			local var_47_1 = var_1.move_time
			local var_47_2 = var_1.ik_point
			local var_47_3 = var_1.touch_step
			local var_47_4 = arg_30_1.IKSettings
			local var_47_5

			if not arg_30_1.IKSettings.forceMove then
				var_47_5 = {}
			end

			var_47_4.forceMove = var_47_5

			local var_47_6

			if not arg_30_1.IKSettings.forceMove[var_47_0] then
				var_47_6 = {}
			end

			var_6[var_47_0] = var_47_6

			local var_47_7 = var_6[var_47_0]
			local var_47_8

			if not var_6[var_47_0].count then
				var_47_8 = 0
			end

			var_47_7.count = var_47_8

			return function(arg_48_0)
				seriesAsync = var_3_10001

				var_3_10001({
					function(arg_49_0)
						local var_49_0 = var_0[var_47_0].count

						if #var_47_3 <= var_49_0 then
							return arg_49_0()
						end

						Dorm3dIK = var_49_0

						local var_49_1 = var_49_0.New({
							configId = var_47_0
						})

						Vector2 = var_2

						local var_49_2 = var_2.New

						unpack = var_4

						local var_49_3 = var_49_2(var_4(var_47_2))
						local var_49_4 = var_0[var_47_0].count
						local var_49_5 = var_0[var_47_0]

						var_49_5.count = var_49_4 + 1
						pg = var_49_5

						local var_49_6 = var_49_5.IKMgr.GetInstance()

						var_4.ResetIK(var_49_6, var_49_1:GetTriggerBoneName())

						local var_49_7 = arg_30_1.IKSettings.Colliders[var_49_1:GetTriggerBoneName()]
						local var_49_8 = arg_30_0
						local var_49_9 = var_5.Get(var_49_8, "raycastCamera")
						local var_49_10 = var_5.WorldToScreenPoint(var_49_9, var_49_7.position)

						pg = var_49_6

						local var_49_11 = var_49_6.IKMgr.GetInstance()

						var_6.PlayIKMove(var_49_11, var_49_10, var_49_1:GetTriggerBoneName(), var_49_3, var_47_3[var_49_4 + 1], var_47_1, function()
							var_0[var_47_0].count = 0

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
				local var_52_0 = arg_30_0
				local var_52_1 = var_1.Emit

				Dorm3dStockingMgr = var_3_10004

				var_52_1(var_52_0, var_3_10004.SET_STOCKING_STATUS, arg_51_0)

				return
			end
		end,
		function(arg_53_0, arg_53_1)
			return function()
				local var_54_0 = arg_30_0
				local var_54_1 = var_0.Get(var_54_0, "apartment")
				local var_54_2 = var_0.GetConfigID(var_54_1)
				local var_54_3 = arg_30_0
				local var_54_4 = var_1.Emit

				RoomIKSystem = var_3_10004

				local var_54_5 = var_3_10004.SET_IK_SWITCH_SKIN_ID
				local var_54_6 = arg_30_0
				local var_54_7 = var_5.Get(var_54_6, "apartment")

				var_54_4(var_54_3, var_54_5, var_5.GetCurSkinId(var_54_7))

				local var_54_8 = arg_30_1

				var_1.SwitchCharacterSkin(var_54_8, var_54_2, arg_53_0)

				local var_54_9 = arg_30_0
				local var_54_10 = var_1.Emit

				RoomIKSystem = var_4

				var_54_10(var_54_9, var_4.SET_IK_CONFIG, arg_30_1, arg_53_1)

				local var_54_11 = arg_30_0
				local var_54_12 = var_1.Emit

				RoomIKSystem = var_4

				var_54_12(var_54_11, var_4.SET_IK_STATE, true)

				return
			end
		end
	}, function()
		return function()
			return
		end
	end, ...)
end

function var_0_1.GetTouchPressKey(arg_57_0, arg_57_1, arg_57_2)
	tostring = var_1_10003

	local var_57_0 = var_1_10003(arg_57_1)
	local var_57_1 = ":"

	tostring = var_5

	return var_57_0 .. var_57_1 .. var_5(arg_57_2)
end

function var_0_1.AssertTouchSource(arg_58_0, arg_58_1, arg_58_2)
	assert = var_1_10003

	local var_58_0 = arg_58_1 == "body" or arg_58_1 == "scene_item"
	local var_58_1 = "Unknown touch source: "

	tostring = var_1_10007

	var_1_10003(var_58_0, var_58_1 .. var_1_10007(arg_58_1))

	assert = var_1_10003

	local var_58_2 = arg_58_2 and arg_58_2 ~= ""
	local var_58_3 = "Invalid touch target: "

	tostring = var_7

	var_1_10003(var_58_2, var_58_3 .. var_7(arg_58_2))

	return
end

function var_0_1.GetTouchConfigSourceTarget(arg_59_0, arg_59_1, arg_59_2)
	type = var_1_10003

	local var_59_0 = var_1_10003(arg_59_1.body) == "string" and arg_59_1.body ~= ""

	type = var_1_10004

	local var_59_1 = var_1_10004(arg_59_1.scene_item) == "string" and arg_59_1.scene_item ~= ""

	assert = var_5

	local var_59_2 = var_59_0 ~= var_59_1
	local var_59_3 = "Invalid dorm3d_ik_touch source: "

	tostring = var_1_10009

	var_5(var_59_2, var_59_3 .. var_1_10009(arg_59_2 or arg_59_1.id))

	if var_59_1 then
		return "scene_item", arg_59_1.scene_item
	else
		return "body", arg_59_1.body
	end

	return
end

function var_0_1.AssertTouchConfig(arg_60_0, arg_60_1)
	pg = var_1_10002

	local var_60_0 = var_1_10002.dorm3d_ik_touch[arg_60_1]

	assert = var_1_10003

	local var_60_1 = var_60_0
	local var_60_2 = "Missing dorm3d_ik_touch config: "

	tostring = var_1_10007

	var_1_10003(var_60_1, var_60_2 .. var_1_10007(arg_60_1))

	assert = var_1_10003

	local var_60_3 = var_60_0.trigger_type == var_0_1.TRIGGER_CLICK or var_60_0.trigger_type == var_0_1.TRIGGER_LONG_PRESS
	local var_60_4 = "Invalid dorm3d_ik_touch trigger_type: "

	tostring = var_7

	var_1_10003(var_60_3, var_60_4 .. var_7(arg_60_1))

	if var_60_0.trigger_type == var_0_1.TRIGGER_LONG_PRESS then
		assert = var_3
		type = var_60_3

		local var_60_5 = var_60_3(var_60_0.hold_time) == "number" and var_60_0.hold_time > 0
		local var_60_6 = "Invalid dorm3d_ik_touch hold_time: "

		tostring = var_7

		var_3(var_60_5, var_60_6 .. var_7(arg_60_1))
	end

	arg_60_0:GetTouchConfigSourceTarget(var_60_0, arg_60_1)

	return var_60_0
end

function var_0_1.ValidateTouchConfigs(arg_61_0, arg_61_1, arg_61_2)
	assert = var_1_10003
	type = var_1_10005

	local var_61_0 = var_1_10005(arg_61_1) == "table"
	local var_61_1 = "Invalid dorm3d_ik_status touch_data: "

	tostring = var_7

	var_1_10003(var_61_0, var_61_1 .. var_7(arg_61_2))

	local var_61_2 = {}

	_ = var_1_10004

	var_1_10004.each(arg_61_1, function(arg_62_0)
		local var_62_0 = arg_62_0[1]
		local var_62_1 = arg_61_0
		local var_62_2 = var_2.AssertTouchConfig(var_62_1, var_62_0)
		local var_62_3 = arg_61_0
		local var_62_4, var_62_5 = var_3.GetTouchConfigSourceTarget(var_62_3, var_62_2, var_62_0)
		local var_62_6 = var_62_4
		local var_62_7 = ":"
		local var_62_8 = var_62_5
		local var_62_9 = ":"

		tostring = var_2_10009

		local var_62_10 = var_62_6 .. var_62_7 .. var_62_8 .. var_62_9 .. var_2_10009(var_62_2.trigger_type)

		assert = var_62_7

		local var_62_11 = not var_61_2[var_62_10]

		string = var_9

		local var_62_12 = var_9.format
		local var_62_13 = "Duplicate dorm3d_ik_touch trigger: ids=%s,%s source=%s target=%s trigger_type=%s"

		tostring = var_2_10012

		local var_62_14 = var_2_10012(var_61_2[var_62_10])

		tostring = var_2_10013

		local var_62_15 = var_2_10013(var_62_0)
		local var_62_16 = var_62_4
		local var_62_17 = var_62_5

		tostring = var_2_10016

		var_62_7(var_62_11, var_62_12(var_62_13, var_62_14, var_62_15, var_62_16, var_62_17, var_2_10016(var_62_2.trigger_type)))

		var_61_2[var_62_10] = var_62_0

		return
	end)

	return
end

function var_0_1.GetTouchInfos(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	arg_63_0:AssertTouchSource(arg_63_1, arg_63_2)

	local var_63_0 = arg_63_0

	if not arg_63_0.GetCurrentLadyEnv(var_63_0).ikConfig then
		return {}, var_4
	end

	assert = var_5
	type = var_7

	var_5(var_7(var_4.iKTouchDatas) == "table", "Invalid current IK touch data")

	local var_63_1 = {}

	ipairs = var_63_0

	for iter_63_0, iter_63_1 in var_63_0(var_4.iKTouchDatas) do
		unpack = var_1_10011
		var_1_10011, var_1_10012, var_1_10013 = var_1_10011(iter_63_1)

		local var_63_2 = arg_63_0:AssertTouchConfig(var_1_10011)
		local var_63_3, var_63_4 = arg_63_0:GetTouchConfigSourceTarget(var_63_2, var_1_10011)

		if var_63_3 == arg_63_1 and var_63_4 == arg_63_2 and var_63_2.trigger_type == arg_63_3 then
			table = var_18

			var_18.insert(var_63_1, iter_63_1)
		end
	end

	assert = var_6

	local var_63_5 = #var_63_1 <= 1

	string = var_9

	local var_63_6 = var_9.format
	local var_63_7 = "Duplicate dorm3d_ik_touch trigger: source=%s target=%s trigger_type=%s"

	tostring = var_1_10012

	local var_63_8 = var_1_10012(arg_63_1)

	tostring = var_1_10013

	local var_63_9 = var_1_10013(arg_63_2)

	tostring = var_14

	var_6(var_63_5, var_63_6(var_63_7, var_63_8, var_63_9, var_14(arg_63_3)))

	return var_63_1, var_4
end

function var_0_1.GetFirstLongPressInfo(arg_64_0, arg_64_1, arg_64_2)
	return arg_64_0:GetTouchInfos(arg_64_1, arg_64_2, var_0_1.TRIGGER_LONG_PRESS)[1]
end

function var_0_1.OnTouchPressDown(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:AssertTouchSource(arg_65_1, arg_65_2)
	arg_65_0:ClearTouchPressConsumed(arg_65_1, arg_65_2)
	arg_65_0:CancelTouchPress(arg_65_1, arg_65_2)

	if not arg_65_0:GetFirstLongPressInfo(arg_65_1, arg_65_2) then
		return
	end

	assert = var_1_10005

	var_1_10005(arg_65_3, "Missing touch press screenPosition")

	local var_65_0 = var_4[1]
	local var_65_1 = arg_65_0:AssertTouchConfig(var_65_0)
	local var_65_2 = arg_65_0:GetTouchPressKey(arg_65_1, arg_65_2)
	local var_65_3 = {
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3
	}

	Time = var_9
	var_65_3.startTime = var_9.time
	Timer = var_9
	var_65_3.timer = var_9.New(function()
		var_65_3.triggered = true
		var_65_3.timer = nil

		local var_66_0 = arg_65_0

		var_0.HideHoldProgress(var_66_0)

		local var_66_1 = arg_65_0

		var_0.SetTouchPressConsumed(var_66_1, arg_65_1, arg_65_2)

		local var_66_2 = arg_65_0

		var_0.TriggerTouchInfo(var_66_2, var_0)

		return
	end, var_65_1.hold_time, 1)

	local var_65_4 = var_65_3.timer

	var_9.Start(var_65_4)

	local var_65_5

	if not arg_65_0.touchPressStates then
		var_65_5 = {}
	end

	arg_65_0.touchPressStates = var_65_5
	arg_65_0.touchPressStates[var_65_2] = var_65_3

	return
end

function var_0_1.OnTouchPressUp(arg_67_0, arg_67_1, arg_67_2)
	arg_67_0:AssertTouchSource(arg_67_1, arg_67_2)

	local var_67_0 = arg_67_0:GetTouchPressKey(arg_67_1, arg_67_2)
	local var_67_1

	if not arg_67_0.touchPressStates or not arg_67_0.touchPressStates[var_67_0] then
		var_67_1 = nil
	end

	local var_67_2

	if (not var_67_1 or not var_67_1.triggered) and arg_67_0.touchPressConsumed then
		var_67_2 = arg_67_0.touchPressConsumed[var_67_0]
	end

	arg_67_0:CancelTouchPress(arg_67_1, arg_67_2)
	arg_67_0:ClearTouchPressConsumed(arg_67_1, arg_67_2)

	if var_67_2 then
		return
	end

	if not arg_67_0:GetTouchInfos(arg_67_1, arg_67_2, var_0_1.TRIGGER_CLICK)[1] then
		return
	end

	arg_67_0:TriggerTouchInfo(var_6[1])

	return
end

function var_0_1.SetTouchPressConsumed(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0

	if not arg_68_0.touchPressConsumed then
		var_68_0 = {}
	end

	arg_68_0.touchPressConsumed = var_68_0
	arg_68_0.touchPressConsumed[arg_68_0:GetTouchPressKey(arg_68_1, arg_68_2)] = true

	return
end

function var_0_1.ClearTouchPressConsumed(arg_69_0, arg_69_1, arg_69_2)
	if not arg_69_0.touchPressConsumed then
		return
	end

	arg_69_0.touchPressConsumed[arg_69_0:GetTouchPressKey(arg_69_1, arg_69_2)] = nil

	return
end

function var_0_1.CancelTouchPress(arg_70_0, arg_70_1, arg_70_2)
	if not arg_70_0.touchPressStates then
		return
	end

	local var_70_0 = arg_70_0:GetTouchPressKey(arg_70_1, arg_70_2)

	if arg_70_0.touchPressStates[var_70_0] and var_4.timer then
		local var_70_1 = var_4.timer

		var_5.Stop(var_70_1)
	end

	arg_70_0:HideHoldProgress()

	arg_70_0.touchPressStates[var_70_0] = nil

	return
end

function var_0_1.CancelAllTouchPress(arg_71_0)
	arg_71_0:HideHoldProgress()

	if not arg_71_0.touchPressStates then
		return
	end

	pairs = var_1

	for iter_71_0, iter_71_1 in var_1(arg_71_0.touchPressStates) do
		if iter_71_1.timer then
			local var_71_0 = iter_71_1.timer

			var_6.Stop(var_71_0)
		end
	end

	arg_71_0.touchPressStates = nil

	return
end

function var_0_1.HideHoldProgress(arg_72_0)
	if not arg_72_0.holdProgressActive then
		return
	end

	arg_72_0.holdProgressActive = nil

	local var_72_0 = arg_72_0
	local var_72_1 = arg_72_0.Emit

	Dorm3dIKView = var_1_10004

	var_72_1(var_72_0, var_1_10004.UPDATE_HOLD_PROGRESS, false)

	return
end

function var_0_1.UpdateHoldProgress(arg_73_0)
	if not arg_73_0.touchPressStates then
		arg_73_0:HideHoldProgress()

		return
	end

	pairs = var_1

	for iter_73_0, iter_73_1 in var_1(arg_73_0.touchPressStates) do
		if not iter_73_1.triggered and iter_73_1.holdTime > var_0_1.HOLD_PROGRESS_SHOW_DELAY then
			Time = var_6

			if var_6.time - iter_73_1.startTime >= var_0_1.HOLD_PROGRESS_SHOW_DELAY then
				arg_73_0.holdProgressActive = true

				local var_73_0 = arg_73_0
				local var_73_1 = arg_73_0.Emit

				Dorm3dIKView = var_1_10010

				var_73_1(var_73_0, var_1_10010.UPDATE_HOLD_PROGRESS, true, iter_73_1.screenPosition, var_6 / iter_73_1.holdTime)

				return
			end
		end
	end

	arg_73_0:HideHoldProgress()

	return
end

function var_0_1.TriggerTouchInfo(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0:GetCurrentLadyEnv()

	unpack = var_1_10003

	local var_74_1, var_74_2, var_74_3 = var_1_10003(arg_74_1)
	local var_74_4 = #arg_74_0:AssertTouchConfig(var_74_1).action_emote

	if 0 < var_74_4 then
		arg_74_0:Func("PlayFaceAnim", var_74_0, var_7)
	end

	local var_74_5 = var_6.vibrate

	type = var_9

	if var_9(var_74_5) == "table" then
		VibrateMgr = var_9

		local var_74_6 = var_9.Instance

		if var_9.IsSupport(var_74_6) then
			local var_74_7 = {}
			local var_74_8 = {}
			local var_74_9 = {}

			underscore = var_1_10012

			var_1_10012.each(var_74_5, function(arg_75_0)
				local var_75_0 = arg_75_0[1]

				PLATFORM = var_2_10002
				PLATFORM_IPHONEPLAYER = var_2_10003

				if var_2_10002 == var_2_10003 then
					var_75_0 = var_75_0 / 1000
				end

				table = var_2_10002

				var_2_10002.insert(var_74_7, var_75_0)

				table = var_2

				var_2.insert(var_74_8, arg_75_0[2])

				table = var_2

				var_2.insert(var_74_9, 1)

				return
			end)

			PLATFORM = var_1_10012
			PLATFORM_ANDROID = var_1_10013

			if var_1_10012 == var_1_10013 then
				VibrateMgr = var_1_10012
				var_1_10014 = var_1_10012.Instance

				var_1_10012.VibrateWaveform(var_1_10014, var_74_7, var_74_8)
			else
				PLATFORM = var_1_10012
				PLATFORM_IPHONEPLAYER = var_1_10013

				if var_1_10012 == var_1_10013 then
					VibrateMgr = var_1_10012
					var_1_10014 = var_1_10012.Instance

					var_1_10012.VibrateWaveform(var_1_10014, var_74_7, var_74_8, var_74_9)
				end
			end
		end
	end

	local var_74_10 = arg_74_0
	local var_74_11 = arg_74_0.Emit

	RoomIKSystem = var_1_10012

	var_74_11(var_74_10, var_1_10012.SET_IK_BLOCK, true)

	local var_74_12 = arg_74_0
	local var_74_13 = arg_74_0.TouchModeAction
	local var_74_14 = var_74_0
	local var_74_15 = var_74_1

	unpack = var_1_10014

	var_74_13(var_74_12, var_74_14, var_74_15, var_1_10014(var_74_3))(function()
		local var_76_0 = arg_74_0
		local var_76_1 = var_0.Emit

		RoomIKSystem = var_2_10003

		var_76_1(var_76_0, var_2_10003.RESET_IK_TIP_TIMER)

		local var_76_2 = arg_74_0
		local var_76_3 = var_0.Emit

		RoomIKSystem = var_3

		var_76_3(var_76_2, var_3.SET_IK_BLOCK, nil)

		return
	end)

	return
end

function var_0_1.UpdateTouchCount(arg_77_0, arg_77_1)
	if arg_77_0.touchLevel > 1 then
		math = var_2
		arg_77_1 = var_2.min(0, arg_77_1)
	end

	local var_77_0 = arg_77_0.touchLevel > 1 and 100 or 0
	local var_77_1 = arg_77_0.touchLevel
	local var_77_2 = 1 < var_77_1 and 200 or 100

	math = var_4
	arg_77_0.touchCount = var_4.clamp(arg_77_0.touchCount + arg_77_1, var_77_0, var_77_2)

	local var_77_3

	if arg_77_0.touchLevel == 1 and arg_77_0.touchCount >= 100 then
		var_77_3 = 2
	elseif arg_77_0.touchLevel > 1 and arg_77_0.touchCount <= 100 then
		var_77_3 = 1
	end

	local var_77_4

	if var_77_3 and var_77_3 ~= arg_77_0.touchLevel then
		var_77_4 = {}

		local var_77_5 = arg_77_0
		local var_77_6 = arg_77_0.Emit

		RoomIKSystem = var_1_10009

		var_77_6(var_77_5, var_1_10009.GET_IK_BLOCK, var_77_4)

		if var_77_4.blockIK then
			var_77_5 = arg_77_0

			arg_77_0.Emit(var_77_5, var_0_1.UPDATE_TOUCH_COUNT, arg_77_0.touchCount)

			math = var_6
			arg_77_0.topCount = var_6.max(arg_77_0.topCount, arg_77_0.touchCount)

			return
		end

		arg_77_0.touchLevel = var_77_3

		if arg_77_0.touchConfig.ik_status[var_77_3] then
			if var_77_3 > 1 then
				arg_77_0.touchCount = 200
			elseif var_77_3 == 1 then
				arg_77_0.touchCount = 0
			end

			local var_77_7 = arg_77_0:GetCurrentLadyEnv()

			seriesAsync = var_77_5

			var_77_5({
				function(arg_78_0)
					local var_78_0 = arg_77_0

					var_1.Func(var_78_0, "ShowBlackScreen", true, arg_78_0)

					return
				end,
				function(arg_79_0)
					local var_79_0 = arg_77_0
					local var_79_1 = var_1.Emit

					RoomIKSystem = var_2_10004

					var_79_1(var_79_0, var_2_10004.SET_IK_CONFIG, var_77_7, var_0)

					local var_79_2 = arg_77_0
					local var_79_3 = var_1.Emit

					RoomIKSystem = var_4

					var_79_3(var_79_2, var_4.SET_IK_STATE, true, arg_79_0)

					if var_77_3 > 1 and arg_77_0.touchConfig.heartbeat_enter_anim ~= "" then
						local var_79_4 = arg_77_0

						var_1.Func(var_79_4, "SwitchAnim", var_77_7, arg_77_0.touchConfig.heartbeat_enter_anim)
					end

					return
				end,
				function(arg_80_0)
					local var_80_0 = arg_77_0

					var_1.Func(var_80_0, "ShowBlackScreen", false, arg_80_0)

					return
				end
			})
		end

		arg_77_0:Emit(var_0_1.UPDATE_TOUCH_DISPLAY, arg_77_0.touchLevel, arg_77_0.touchCount)
	else
		arg_77_0:Emit(var_0_1.UPDATE_TOUCH_COUNT, arg_77_0.touchCount)
	end

	math = var_77_4
	arg_77_0.topCount = var_77_4.max(arg_77_0.topCount, arg_77_0.touchCount)

	return
end

function var_0_1.ExitHeartbeatMode(arg_81_0)
	if not arg_81_0.touchLevel or arg_81_0.touchLevel == 1 then
		return
	end

	arg_81_0.touchCount = 0

	arg_81_0:UpdateTouchCount(0)

	return
end

function var_0_1.DoTouch(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_0.inTouchGame then
		switch = var_3

		var_3(arg_82_2, {
			function()
				local var_83_0 = arg_82_0
				local var_83_1 = var_0.UpdateTouchCount

				pg = var_2_10003

				var_83_1(var_83_0, var_2_10003.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				local var_84_0 = arg_82_0
				local var_84_1 = var_0.UpdateTouchCount

				pg = var_2_10003

				var_84_1(var_84_0, var_2_10003.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				local var_85_0 = arg_82_0
				local var_85_1 = var_0.UpdateTouchCount

				pg = var_2_10003

				var_85_1(var_85_0, var_2_10003.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				local var_86_0 = arg_82_0
				local var_86_1 = var_0.UpdateTouchCount

				pg = var_2_10003

				var_86_1(var_86_0, var_2_10003.dorm3d_set.rapport_heartbeat_trriger.key_value_int)

				return
			end
		})
	end

	return
end

return var_0_1
