local RoomTouchSystem = class("RoomTouchSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

RoomTouchSystem.ENTER_TOUCH_MODE = "RoomTouchSystem.ENTER_TOUCH_MODE"
RoomTouchSystem.EXIT_TOUCH_MODE = "RoomTouchSystem.EXIT_TOUCH_MODE"
RoomTouchSystem.EXIT_HEARTBEAT_MODE = "RoomTouchSystem.EXIT_HEARTBEAT_MODE"
RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN = "RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN"
RoomTouchSystem.ON_TOUCH_CHARACTER_UP = "RoomTouchSystem.ON_TOUCH_CHARACTER_UP"
RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN"
RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP = "RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP"
RoomTouchSystem.CANCEL_TOUCH_PRESS = "RoomTouchSystem.CANCEL_TOUCH_PRESS"
RoomTouchSystem.VALIDATE_TOUCH_CONFIGS = "RoomTouchSystem.VALIDATE_TOUCH_CONFIGS"
RoomTouchSystem.UPDATE_TOUCH_PANEL = "RoomTouchSystem.UPDATE_TOUCH_PANEL"
RoomTouchSystem.UPDATE_TOUCH_COUNT = "RoomTouchSystem.UPDATE_TOUCH_COUNT"
RoomTouchSystem.UPDATE_TOUCH_LEVEL = "RoomTouchSystem.UPDATE_TOUCH_LEVEL"
RoomTouchSystem.UPDATE_TOUCH_DISPLAY = "RoomTouchSystem.UPDATE_TOUCH_DISPLAY"
RoomTouchSystem.GET_TOUCH_GAME_STATE = "RoomTouchSystem.GET_TOUCH_GAME_STATE"
RoomTouchSystem.SET_TOUCH_EXIT_CALL = "RoomTouchSystem.SET_TOUCH_EXIT_CALL"
RoomTouchSystem.TRIGGER_CLICK = 1
RoomTouchSystem.TRIGGER_LONG_PRESS = 2
RoomTouchSystem.HOLD_PROGRESS_SHOW_DELAY = 0.5

function RoomTouchSystem:RegisterEvents()
	self:Bind(RoomTouchSystem.ENTER_TOUCH_MODE, function(arg_2_0, arg_2_1)
		self:EnterTouchMode(arg_2_1)

		return
	end)
	self:Bind(RoomTouchSystem.EXIT_TOUCH_MODE, function()
		self:ExitTouchMode()

		return
	end)
	self:Bind(RoomTouchSystem.EXIT_HEARTBEAT_MODE, function()
		self:ExitHeartbeatMode()

		return
	end)
	self:Bind(RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN, function(arg_5_0, arg_5_1, arg_5_2)
		self:OnTouchPressDown("body", arg_5_1, arg_5_2)

		return
	end)
	self:Bind(RoomTouchSystem.ON_TOUCH_CHARACTER_UP, function(arg_6_0, arg_6_1)
		self:OnTouchPressUp("body", arg_6_1)

		return
	end)
	self:Bind(RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		self:OnTouchPressDown("scene_item", arg_7_1, arg_7_2)

		return
	end)
	self:Bind(RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP, function(arg_8_0, arg_8_1)
		self:OnTouchPressUp("scene_item", arg_8_1)

		return
	end)
	self:Bind(RoomTouchSystem.CANCEL_TOUCH_PRESS, function()
		self:CancelAllTouchPress()

		return
	end)
	self:Bind(RoomTouchSystem.VALIDATE_TOUCH_CONFIGS, function(arg_10_0, arg_10_1, arg_10_2)
		self:ValidateTouchConfigs(arg_10_1, arg_10_2)

		return
	end)
	self:Bind(RoomIKSystem.ON_IK_STATUS_CHANGED, function(arg_11_0, arg_11_1, arg_11_2)
		if not self:Func("GetBlackboardValue", self:GetCurrentLadyEnv(), "inTouching") then
			return
		end

		self:DoTouch(arg_11_1, arg_11_2)

		return
	end)
	self:Bind(RoomIKSystem.ON_IK_LAYER_ACTION, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		self:TouchModeAction(arg_12_1, arg_12_2, unpack(arg_12_3))(arg_12_4)

		return
	end)
	self:Bind(RoomTouchSystem.GET_TOUCH_GAME_STATE, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.inTouchGame = self.inTouchGame
		end

		return
	end)
	self:Bind(RoomTouchSystem.SET_TOUCH_EXIT_CALL, function(arg_14_0, arg_14_1)
		self.touchExitCall = arg_14_1

		return
	end)

	return
end

function RoomTouchSystem:OnDispose()
	self:CancelAllTouchPress()

	if self.downTimer then
		self.downTimer:Stop()

		self.downTimer = nil
	end

	if self.sliderLT and LeanTween.isTweening(self.sliderLT) then
		LeanTween.cancel(self.sliderLT)

		self.sliderLT = nil
	end

	return
end

function RoomTouchSystem:OnUpdate()
	self:UpdateHoldProgress()

	return
end

function RoomTouchSystem:EnterTouchMode(arg_17_1)
	local var_17_0 = self:GetCurrentLadyEnv()

	if self:Func("GetBlackboardValue", var_17_0, "inTouching") then
		return
	end

	arg_17_1 = arg_17_1 or self:GetRoom():getApartmentZoneConfig(var_17_0.ladyBaseZone, "touch_id", self:Get("apartment"):GetConfigID())
	self.touchConfig = pg.dorm3d_touch_data[arg_17_1]

	if not self.touchConfig then
		warning("dorm3d_touch_data no config for id:" .. tostring(arg_17_1))

		return
	end

	self.inTouchGame = self.touchConfig.heartbeat_enable > 0

	self:Emit(RoomTouchSystem.UPDATE_TOUCH_PANEL, self.inTouchGame)

	if self.inTouchGame then
		self.touchCount = 0
		self.touchLevel = 1
		self.lastCount = 0
		self.topCount = 0

		self:Emit(RoomTouchSystem.UPDATE_TOUCH_DISPLAY, self.touchLevel, self.touchCount)

		self.downTimer = Timer.New(function()
			self:UpdateTouchCount((self.touchLevel > 1 or nil) and pg.dorm3d_set.reduce_heartbeat.key_value_int)

			return
		end, 1, -1)

		self.downTimer:Start()
	end

	local var_17_1 = {}

	table.insert(var_17_1, function(arg_19_0)
		self:Func("SetBlackboardValue", var_17_0, "inTouching", true)
		self:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
		self:Func("SetUI", arg_19_0, "blank")

		return
	end)
	table.insert(var_17_1, function(arg_20_0)
		self:Emit(RoomIKSystem.SET_IK_CONFIG, var_17_0, self.touchConfig.ik_status[1])
		self:Emit(RoomIKSystem.SET_IK_STATE, true, arg_20_0)

		return
	end)
	table.insert(var_17_1, function(arg_21_0)
		existCall(arg_21_0)

		return
	end)
	seriesAsync(var_17_1, function()
		Shader.SetGlobalFloat("_ScreenClipOff", 0)
		self:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		return
	end)

	return
end

function RoomTouchSystem:ExitTouchMode()
	local var_23_0 = self:GetCurrentLadyEnv()

	if not self:Func("GetBlackboardValue", var_23_0, "inTouching") then
		return
	end

	local var_23_1 = {}

	self:CancelAllTouchPress()

	if self.inTouchGame then
		table.insert(var_23_1, function(arg_24_0)
			self:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			self:Emit(RoomTouchSystem.UPDATE_TOUCH_PANEL, false, true, arg_24_0)

			return
		end)
		table.insert(var_23_1, function(arg_25_0)
			local var_25_0 = 0

			for iter_25_0, iter_25_1 in ipairs(self.touchConfig.heartbeat_favor) do
				if iter_25_1[1] > self.topCount then
					break
				else
					var_25_0 = iter_25_1[2]
				end
			end

			if var_25_0 > 0 then
				self:Emit(Dorm3dRoomMediator.TRIGGER_FAVOR, self:Get("apartment").configId, var_25_0)
			end

			self.touchCount = nil
			self.touchLevel = nil
			self.topCount = nil

			if self.downTimer then
				self.downTimer:Stop()

				self.downTimer = nil
			end

			self.inTouchGame = false

			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_25_0()

			return
		end)
	else
		table.insert(var_23_1, function(arg_26_0)
			self:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)

			if self.touchConfig.default_favor > 0 then
				self:Emit(Dorm3dRoomMediator.TRIGGER_FAVOR, self:Get("apartment").configId, self.touchConfig.default_favor)
			end

			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_26_0()

			return
		end)
	end

	table.insert(var_23_1, function(arg_27_0)
		var_23_0.ikConfig = {
			character_position = var_23_0.ladyBaseZone,
			character_action = self.touchConfig.finish_action
		}

		self:Emit(Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE)
		self:Emit(RoomIKSystem.SET_IK_STATE, false, arg_27_0)

		return
	end)
	table.insert(var_23_1, function(arg_28_0)
		var_23_0.ikConfig = nil

		self:Emit(RoomIKSystem.SET_IK_SPECIAL_CALL, nil)
		self:Func("SetUI", arg_28_0, "back")

		return
	end)
	seriesAsync(var_23_1, function()
		self:Func("SetBlackboardValue", var_23_0, "inTouching", false)
		self:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		self.touchConfig = nil
		self.touchExitCall = nil

		existCall(self.touchExitCall)

		return
	end)

	return
end

function RoomTouchSystem:TouchModeAction(arg_30_1, arg_30_2, arg_30_3, ...)
	return switch(arg_30_3, {
		function(arg_31_0, arg_31_1)
			return function(arg_32_0)
				seriesAsync({
					function(arg_33_0)
						if not arg_31_1 or arg_31_1 == "" then
							return arg_33_0()
						end

						self:Func("PlaySingleAction", arg_30_1, arg_31_1, arg_33_0)

						return
					end,
					function(arg_34_0)
						self:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_31_0)
						self:Emit(RoomIKSystem.SET_IK_STATE, true, arg_34_0)

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

				self:Emit(RoomIKSystem.CONSUME_IK_SPECIAL_CALL, var_36_0)

				if var_36_0.consumed then
					return
				end

				self:ExitTouchMode()

				return
			end
		end,
		function(arg_37_0, arg_37_1)
			return function(arg_38_0)
				self:Func("PlaySingleAction", arg_30_1, arg_37_1, arg_38_0)

				return
			end
		end,
		function(arg_39_0, arg_39_1, arg_39_2)
			return function(arg_40_0)
				seriesAsync({
					function(arg_41_0)
						self:Func("DoTalk", arg_39_1, arg_41_0)

						return
					end,
					function(arg_42_0)
						if not arg_39_2 or arg_39_2 == 0 then
							return arg_42_0()
						end

						self:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_39_2)
						self:Emit(RoomIKSystem.SET_IK_STATE, true, arg_42_0)

						return
					end,
					arg_40_0
				})

				return
			end
		end,
		function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
			return function(arg_44_0)
				self:Func("PlaySceneItemAnim", arg_43_2, arg_43_3)
				self:Func("PlaySingleAction", arg_30_1, arg_43_1, arg_44_0)

				return
			end
		end,
		function(arg_45_0)
			return function(arg_46_0)
				if #pg.dorm3d_ik_touch[arg_30_2].scene_item == 0 then
					return
				end

				local var_46_0 = self:GetSceneItem(pg.dorm3d_ik_touch[arg_30_2].scene_item)

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
						pg.IKMgr.GetInstance():PlayIKMove(self:Get("raycastCamera"):WorldToScreenPoint(arg_30_1.IKSettings.Colliders[var_49_0:GetTriggerBoneName()].position), var_49_0:GetTriggerBoneName(), Vector2.New(unpack(var_47_2)), var_47_3[var_47_4[var_47_0].count + 1], var_47_1, function()
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
				self:Emit(Dorm3dStockingMgr.SET_STOCKING_STATUS, arg_51_0)

				return
			end
		end,
		function(arg_53_0, arg_53_1)
			return function()
				self:Emit(RoomIKSystem.SET_IK_SWITCH_SKIN_ID, self:Get("apartment"):GetCurSkinId())
				arg_30_1:SwitchCharacterSkin(self:Get("apartment"):GetConfigID(), arg_53_0)
				self:Emit(RoomIKSystem.SET_IK_CONFIG, arg_30_1, arg_53_1)
				self:Emit(RoomIKSystem.SET_IK_STATE, true)

				return
			end
		end
	}, function()
		return function()
			return
		end
	end, ...)
end

function RoomTouchSystem:GetTouchPressKey(arg_57_1, arg_57_2)
	return tostring(arg_57_1) .. ":" .. tostring(arg_57_2)
end

function RoomTouchSystem:AssertTouchSource(arg_58_1, arg_58_2)
	assert(arg_58_1 == "body" or arg_58_1 == "scene_item", "Unknown touch source: " .. tostring(arg_58_1))
	assert(arg_58_2 and arg_58_2 ~= "", "Invalid touch target: " .. tostring(arg_58_2))

	return
end

function RoomTouchSystem:GetTouchConfigSourceTarget(arg_59_1, arg_59_2)
	local var_59_0 = type(arg_59_1.scene_item) == "string" and arg_59_1.scene_item ~= ""

	assert((type(arg_59_1.body) == "string" and arg_59_1.body ~= "") ~= var_59_0, "Invalid dorm3d_ik_touch source: " .. tostring(arg_59_2 or arg_59_1.id))

	if var_59_0 then
		return "scene_item", arg_59_1.scene_item
	else
		return "body", arg_59_1.body
	end

	return
end

function RoomTouchSystem:AssertTouchConfig(arg_60_1)
	local var_60_0 = pg.dorm3d_ik_touch[arg_60_1]

	assert(pg.dorm3d_ik_touch[arg_60_1], "Missing dorm3d_ik_touch config: " .. tostring(arg_60_1))
	assert(var_60_0.trigger_type == RoomTouchSystem.TRIGGER_CLICK or var_60_0.trigger_type == RoomTouchSystem.TRIGGER_LONG_PRESS, "Invalid dorm3d_ik_touch trigger_type: " .. tostring(arg_60_1))

	if var_60_0.trigger_type == RoomTouchSystem.TRIGGER_LONG_PRESS then
		assert(type(var_60_0.hold_time) == "number" and var_60_0.hold_time > 0, "Invalid dorm3d_ik_touch hold_time: " .. tostring(arg_60_1))
	end

	self:GetTouchConfigSourceTarget(var_60_0, arg_60_1)

	return var_60_0
end

function RoomTouchSystem:ValidateTouchConfigs(arg_61_1, arg_61_2)
	assert(type(arg_61_1) == "table", "Invalid dorm3d_ik_status touch_data: " .. tostring(arg_61_2))

	local var_61_0 = {}

	_.each(arg_61_1, function(arg_62_0)
		local var_62_0 = self:AssertTouchConfig(arg_62_0[1])
		local var_62_1, var_62_2 = self:GetTouchConfigSourceTarget(var_62_0, arg_62_0[1])
		local var_62_3 = var_62_1 .. ":" .. var_62_2 .. ":" .. tostring(var_62_0.trigger_type)

		assert(not var_61_0[var_62_3], string.format("Duplicate dorm3d_ik_touch trigger: ids=%s,%s source=%s target=%s trigger_type=%s", tostring(var_61_0[var_62_3]), tostring(arg_62_0[1]), var_62_1, var_62_2, tostring(var_62_0.trigger_type)))

		var_61_0[var_62_3] = arg_62_0[1]

		return
	end)

	return
end

function RoomTouchSystem:GetTouchInfos(arg_63_1, arg_63_2, arg_63_3)
	self:AssertTouchSource(arg_63_1, arg_63_2)

	local var_63_0 = self:GetCurrentLadyEnv()

	if not var_63_0.ikConfig then
		return {}, var_63_0
	end

	assert(type(var_63_0.iKTouchDatas) == "table", "Invalid current IK touch data")

	local var_63_1 = {}

	for iter_63_0, iter_63_1 in ipairs(var_63_0.iKTouchDatas) do
		local var_63_2, var_63_3, var_63_4 = unpack(iter_63_1)
		local var_63_5 = self:AssertTouchConfig(var_63_2)
		local var_63_6, var_63_7 = self:GetTouchConfigSourceTarget(var_63_5, var_63_2)

		if var_63_6 == arg_63_1 and var_63_7 == arg_63_2 and var_63_5.trigger_type == arg_63_3 then
			table.insert(var_63_1, iter_63_1)
		end
	end

	assert(#var_63_1 <= 1, string.format("Duplicate dorm3d_ik_touch trigger: source=%s target=%s trigger_type=%s", tostring(arg_63_1), tostring(arg_63_2), tostring(arg_63_3)))

	return var_63_1, var_63_0
end

function RoomTouchSystem:GetFirstLongPressInfo(arg_64_1, arg_64_2)
	return self:GetTouchInfos(arg_64_1, arg_64_2, RoomTouchSystem.TRIGGER_LONG_PRESS)[1]
end

function RoomTouchSystem:OnTouchPressDown(arg_65_1, arg_65_2, arg_65_3)
	self:AssertTouchSource(arg_65_1, arg_65_2)
	self:ClearTouchPressConsumed(arg_65_1, arg_65_2)
	self:CancelTouchPress(arg_65_1, arg_65_2)

	local var_65_0 = self:GetFirstLongPressInfo(arg_65_1, arg_65_2)

	if not var_65_0 then
		return
	end

	assert(arg_65_3, "Missing touch press screenPosition")

	local var_65_1 = self:AssertTouchConfig(var_65_0[1])
	local var_65_2 = {
		triggered = false,
		holdTime = var_65_1.hold_time,
		screenPosition = arg_65_3,
		startTime = Time.time
	}

	var_65_2.timer = Timer.New(function()
		var_65_2.triggered = true
		var_65_2.timer = nil

		self:HideHoldProgress()
		self:SetTouchPressConsumed(arg_65_1, arg_65_2)
		self:TriggerTouchInfo(var_65_0)

		return
	end, var_65_1.hold_time, 1)

	var_65_2.timer:Start()

	self.touchPressStates = self.touchPressStates or {}
	self.touchPressStates[self:GetTouchPressKey(arg_65_1, arg_65_2)] = var_65_2

	return
end

function RoomTouchSystem:OnTouchPressUp(arg_67_1, arg_67_2)
	self:AssertTouchSource(arg_67_1, arg_67_2)

	local var_67_0 = self:GetTouchPressKey(arg_67_1, arg_67_2)

	if self.touchPressStates then
		local var_67_1 = self.touchPressStates[var_67_0] or nil
		local var_67_2

		if var_67_1 then
			var_67_2 = var_67_1.triggered or self.touchPressConsumed and self.touchPressConsumed[var_67_0]
		end
	end

	self:CancelTouchPress(arg_67_1, arg_67_2)
	self:ClearTouchPressConsumed(arg_67_1, arg_67_2)

	if var_67_2 then
		return
	end

	local var_67_3 = self:GetTouchInfos(arg_67_1, arg_67_2, RoomTouchSystem.TRIGGER_CLICK)

	if not var_67_3[1] then
		return
	end

	self:TriggerTouchInfo(var_67_3[1])

	return
end

function RoomTouchSystem:SetTouchPressConsumed(arg_68_1, arg_68_2)
	self.touchPressConsumed = self.touchPressConsumed or {}
	self.touchPressConsumed[self:GetTouchPressKey(arg_68_1, arg_68_2)] = true

	return
end

function RoomTouchSystem:ClearTouchPressConsumed(arg_69_1, arg_69_2)
	if not self.touchPressConsumed then
		return
	end

	self.touchPressConsumed[self:GetTouchPressKey(arg_69_1, arg_69_2)] = nil

	return
end

function RoomTouchSystem:CancelTouchPress(arg_70_1, arg_70_2)
	if not self.touchPressStates then
		return
	end

	local var_70_0 = self:GetTouchPressKey(arg_70_1, arg_70_2)

	if self.touchPressStates[var_70_0] and self.touchPressStates[var_70_0].timer then
		self.touchPressStates[var_70_0].timer:Stop()
	end

	self:HideHoldProgress()

	self.touchPressStates[var_70_0] = nil

	return
end

function RoomTouchSystem:CancelAllTouchPress()
	self:HideHoldProgress()

	if not self.touchPressStates then
		return
	end

	for iter_71_0, iter_71_1 in pairs(self.touchPressStates) do
		if iter_71_1.timer then
			iter_71_1.timer:Stop()
		end
	end

	self.touchPressStates = nil

	return
end

function RoomTouchSystem:HideHoldProgress()
	if not self.holdProgressActive then
		return
	end

	self.holdProgressActive = nil

	self:Emit(Dorm3dIKView.UPDATE_HOLD_PROGRESS, false)

	return
end

function RoomTouchSystem:UpdateHoldProgress()
	if not self.touchPressStates then
		self:HideHoldProgress()

		return
	end

	for iter_73_0, iter_73_1 in pairs(self.touchPressStates) do
		if not iter_73_1.triggered and iter_73_1.holdTime > RoomTouchSystem.HOLD_PROGRESS_SHOW_DELAY then
			if Time.time - iter_73_1.startTime >= RoomTouchSystem.HOLD_PROGRESS_SHOW_DELAY then
				self.holdProgressActive = true

				self:Emit(Dorm3dIKView.UPDATE_HOLD_PROGRESS, true, iter_73_1.screenPosition, (Time.time - iter_73_1.startTime) / iter_73_1.holdTime)

				return
			end
		end
	end

	self:HideHoldProgress()

	return
end

function RoomTouchSystem:TriggerTouchInfo(arg_74_1)
	local var_74_0 = self:GetCurrentLadyEnv()
	local var_74_1, var_74_2, var_74_3 = unpack(arg_74_1)
	local var_74_4 = self:AssertTouchConfig(var_74_1)

	if #var_74_4.action_emote > 0 then
		self:Func("PlayFaceAnim", var_74_0, var_74_4.action_emote)
	end

	if type(var_74_4.vibrate) == "table" and VibrateMgr.Instance:IsSupport() then
		local var_74_5 = {}
		local var_74_6 = {}
		local var_74_7 = {}

		underscore.each(var_74_4.vibrate, function(arg_75_0)
			local var_75_0 = arg_75_0[1]

			if PLATFORM == PLATFORM_IPHONEPLAYER then
				var_75_0 = var_75_0 / 1000
			end

			table.insert(var_74_5, var_75_0)
			table.insert(var_74_6, arg_75_0[2])
			table.insert(var_74_7, 1)

			return
		end)

		if PLATFORM == PLATFORM_ANDROID then
			VibrateMgr.Instance:VibrateWaveform(var_74_5, var_74_6)
		elseif PLATFORM == PLATFORM_IPHONEPLAYER then
			VibrateMgr.Instance:VibrateWaveform(var_74_5, var_74_6, var_74_7)
		end
	end

	self:Emit(RoomIKSystem.SET_IK_BLOCK, true)
	self:TouchModeAction(var_74_0, var_74_1, unpack(var_74_3))(function()
		self:Emit(RoomIKSystem.RESET_IK_TIP_TIMER)
		self:Emit(RoomIKSystem.SET_IK_BLOCK, nil)

		return
	end)

	return
end

function RoomTouchSystem:UpdateTouchCount(arg_77_1)
	local var_77_0

	if self.touchLevel > 1 then
		arg_77_1 = math.min(0, arg_77_1)
		var_77_0 = self.touchLevel > 1 and 200 or 100
	end

	self.touchCount = math.clamp(self.touchCount + arg_77_1, self.touchLevel > 1 and 100 or 0, var_77_0)

	local var_77_1

	if self.touchLevel == 1 and self.touchCount >= 100 then
		var_77_1 = 2
	elseif self.touchLevel > 1 and self.touchCount <= 100 then
		var_77_1 = 1
	end

	if var_77_1 and var_77_1 ~= self.touchLevel then
		local var_77_2 = {}

		self:Emit(RoomIKSystem.GET_IK_BLOCK, var_77_2)

		if var_77_2.blockIK then
			self:Emit(RoomTouchSystem.UPDATE_TOUCH_COUNT, self.touchCount)

			self.topCount = math.max(self.topCount, self.touchCount)

			return
		end

		self.touchLevel = var_77_1

		local var_77_3 = self.touchConfig.ik_status[var_77_1]

		if self.touchConfig.ik_status[var_77_1] then
			if var_77_1 > 1 then
				self.touchCount = 200
			elseif var_77_1 == 1 then
				self.touchCount = 0
			end

			local var_77_4 = self:GetCurrentLadyEnv()

			seriesAsync({
				function(arg_78_0)
					self:Func("ShowBlackScreen", true, arg_78_0)

					return
				end,
				function(arg_79_0)
					self:Emit(RoomIKSystem.SET_IK_CONFIG, var_77_4, var_77_3)
					self:Emit(RoomIKSystem.SET_IK_STATE, true, arg_79_0)

					if var_77_1 > 1 and self.touchConfig.heartbeat_enter_anim ~= "" then
						self:Func("SwitchAnim", var_77_4, self.touchConfig.heartbeat_enter_anim)
					end

					return
				end,
				function(arg_80_0)
					self:Func("ShowBlackScreen", false, arg_80_0)

					return
				end
			})
		end

		self:Emit(RoomTouchSystem.UPDATE_TOUCH_DISPLAY, self.touchLevel, self.touchCount)
	else
		self:Emit(RoomTouchSystem.UPDATE_TOUCH_COUNT, self.touchCount)
	end

	self.topCount = math.max(self.topCount, self.touchCount)

	return
end

function RoomTouchSystem:ExitHeartbeatMode()
	if not self.touchLevel or self.touchLevel == 1 then
		return
	end

	self.touchCount = 0

	self:UpdateTouchCount(0)

	return
end

function RoomTouchSystem:DoTouch(arg_82_1, arg_82_2)
	if self.inTouchGame then
		switch(arg_82_2, {
			function()
				self:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				self:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				self:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat.key_value_int)

				return
			end,
			function()
				self:UpdateTouchCount(pg.dorm3d_set.rapport_heartbeat_trriger.key_value_int)

				return
			end
		})
	end

	return
end

return RoomTouchSystem
