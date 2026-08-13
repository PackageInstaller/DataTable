class = var_0_10000

local var_0_0 = var_0_10000("Live2dDrag")
local var_0_1 = 4
local var_0_2 = {}
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data = arg_1_1
	arg_1_0.live2dData = arg_1_2
	arg_1_0.commonData = arg_1_3
	Application = var_1_10004

	local var_1_0

	if not var_1_10004.targetFrameRate then
		var_1_0 = 60
	end

	arg_1_0.frameRate = var_1_0

	local var_1_1 = {}

	Live2DPainting = var_1_10005
	var_1_1[1] = var_1_10005.DRAG_DOWN_ACTION
	var_0_2 = var_1_1
	arg_1_0.id = arg_1_1.id

	local var_1_2

	if not arg_1_1.draw_able_name then
		var_1_2 = ""
	end

	arg_1_0.drawAbleName = var_1_2
	arg_1_0.parameterName = arg_1_1.parameter

	local var_1_3

	if not arg_1_1.mode or arg_1_1.mode == 0 or not arg_1_1.mode then
		var_1_3 = 1
	end

	arg_1_0.mode = var_1_3

	local var_1_4

	if not arg_1_1.start_value then
		var_1_4 = 0
	end

	arg_1_0.startValue = var_1_4

	local var_1_5

	if not arg_1_1.range or arg_1_0.range == "" or not arg_1_1.range then
		var_1_5 = {
			0,
			0
		}
	end

	arg_1_0.range = var_1_5
	arg_1_0.offsetX = arg_1_1.offset_x

	if arg_1_0.offsetX == 0 then
		arg_1_0.offsetX = nil
	end

	arg_1_0.offsetY = arg_1_1.offset_y

	if arg_1_0.offsetY == 0 then
		arg_1_0.offsetY = nil
	end

	arg_1_0.smooth = arg_1_1.smooth / 1000
	arg_1_0.smoothRevert = arg_1_1.revert_smooth / 1000
	arg_1_0.revert = arg_1_1.revert
	arg_1_0.ignoreReact = arg_1_1.ignore_react == 1
	arg_1_0.gyro = arg_1_1.gyro == 1 or nil
	arg_1_0.gyroX = arg_1_1.gyro_x == 1
	arg_1_0.gyroY = arg_1_1.gyro_y == 1
	arg_1_0.gyroZ = arg_1_1.gyro_z == 1
	arg_1_0.ignoreAction = arg_1_1.ignore_action == 1
	arg_1_0.dragDirect = arg_1_1.drag_direct
	arg_1_0.rangeAbs = arg_1_1.range_abs == 1
	arg_1_0.partsData = arg_1_1.parts_data
	arg_1_0.actionTrigger = arg_1_1.action_trigger

	local var_1_6

	if arg_1_1.react_pos_x == 0 or not arg_1_1.react_pos_x then
		var_1_6 = nil
	end

	arg_1_0.reactX = var_1_6

	local var_1_7

	if arg_1_1.react_pos_y == 0 or not arg_1_1.react_pos_y then
		var_1_7 = nil
	end

	arg_1_0.reactY = var_1_7
	arg_1_0.actionTriggerActive = arg_1_1.action_trigger_active
	arg_1_0.relationParameter = arg_1_1.relation_parameter
	arg_1_0.relationParts = arg_1_0.relationParameter.parts

	local var_1_8

	if not (arg_1_1.limit_time > 0) or not arg_1_1.limit_time then
		var_1_8 = var_0_1
	end

	arg_1_0.limitTime = var_1_8

	local var_1_9

	if not arg_1_1.offset_circle then
		var_1_9 = ""
	end

	arg_1_0.offsetCircle = var_1_9

	local var_1_10

	if not arg_1_0.offsetCircle.pos or not arg_1_0.offsetCircle.pos then
		var_1_10 = nil
	end

	arg_1_0.offsetCirclePos = var_1_10

	local var_1_11

	if not arg_1_0.offsetCircle.start or not arg_1_0.offsetCircle.start then
		var_1_11 = nil
	end

	arg_1_0.offsetCircleStart = var_1_11
	arg_1_0.listenerData = arg_1_1.listener_data
	arg_1_0.listenerType = arg_1_0.listenerData.type
	arg_1_0.listenerChange = arg_1_0.listenerData.change
	arg_1_0.listenerApply = arg_1_0.listenerData.apply

	local var_1_12

	if not arg_1_1.react_condition or arg_1_1.react_condition == "" or not arg_1_1.react_condition then
		var_1_12 = {}
	end

	arg_1_0.reactCondition = var_1_12

	local var_1_13

	if not arg_1_0.reactCondition.idle_on or not arg_1_0.reactCondition.idle_on then
		var_1_13 = {}
	end

	arg_1_0.idleOn = var_1_13

	local var_1_14

	if not arg_1_0.reactCondition.idle_off or not arg_1_0.reactCondition.idle_off then
		var_1_14 = {}
	end

	arg_1_0.idleOff = var_1_14

	local var_1_15 = false

	if #arg_1_1.revert_idle_index > 0 then
		type = var_5

		if var_5(arg_1_1.revert_idle_index) == "table" then
			var_1_15 = arg_1_1.revert_idle_index
		else
			tonumber = var_5

			if var_5(arg_1_1.revert_idle_index) then
				tonumber = var_5

				if var_5(arg_1_1.revert_idle_index) >= 0 then
					tonumber = var_5
					var_1_15 = var_5(arg_1_1.revert_idle_index) == 1 and true or false
				end
			end
		end
	end

	arg_1_0.revertIdleIndex = var_1_15
	arg_1_0.revertActionIndex = arg_1_1.revert_action_index == 1 and true or false
	arg_1_0.saveParameterFlag = true

	if arg_1_1.save_parameter == -1 then
		arg_1_0.saveParameterFlag = false
	end

	L2D_RANDOM_PARAM = var_5
	arg_1_0.randomAttitudeIndex = var_5
	arg_1_0._active = false
	arg_1_0._parameterCom = nil
	arg_1_0.parameterValue = arg_1_0.startValue
	arg_1_0.parameterStartValue = arg_1_0.startValue
	arg_1_0.parameterTargetValue = arg_1_0.startValue
	arg_1_0.parameterSmooth = 0
	arg_1_0.parameterSmoothTime = arg_1_0.smooth
	Vector2 = var_5
	arg_1_0.mouseInputDown = var_5(0, 0)
	arg_1_0.nextTriggerTime = 0
	arg_1_0.triggerActionTime = 0
	arg_1_0.sensitive = 4
	arg_1_0.l2dIdleIndex = 0
	Vector2 = var_5
	arg_1_0.reactPos = var_5(0, 0)
	arg_1_0.actionListIndex = 1
	arg_1_0._relationParameterList = {}
	arg_1_0.offsetDragX = arg_1_0.startValue
	arg_1_0.offsetDragY = arg_1_0.startValue
	arg_1_0.rangeOffset = arg_1_0.range[2] - arg_1_0.range[1]
	arg_1_0.offsetDragTargetX = arg_1_0.startValue
	arg_1_0.offsetDragTargetY = arg_1_0.startValue
	arg_1_0._relationFlag = false
	arg_1_0.ableFlag = false

	if arg_1_0.relationParameter and arg_1_0.relationParameter.list then
		arg_1_0._relationFlag = true
	end

	arg_1_0.extendActionFlag = false
	arg_1_0.parameterComAdd = true
	arg_1_0.reactConditionFlag = false
	arg_1_0.loadL2dStep = true

	return
end

function var_0_0.onListenerEvent(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:onListenerTrigger(arg_2_1, arg_2_2)

	if not arg_2_0.listenerType then
		return
	end

	if arg_2_0.listenerType == arg_2_1 then
		local var_2_0 = arg_2_2.action
		local var_2_1 = arg_2_2.values
		local var_2_2 = arg_2_2.idle
		local var_2_3 = arg_2_2.idle_change
		local var_2_4 = arg_2_2.draw_able_name
		local var_2_5 = arg_2_2.parameter_name
		local var_2_6 = false

		if arg_2_0.listenerChange and #arg_2_0.listenerChange > 0 and arg_2_0:getChangeCheckName(arg_2_1, arg_2_2) then
			for iter_2_0 = 1, #arg_2_0.listenerChange do
				local var_2_7 = arg_2_0.listenerChange[iter_2_0][1]
				local var_2_8 = var_15[2]
				local var_2_9 = var_15[3]
				local var_2_10 = #var_15
				local var_2_11

				if not (4 <= var_2_10) or not var_15[4] then
					var_2_11 = 1
				end

				table = var_20

				if var_20.contains(var_2_8, var_10) then
					local var_2_12

					if var_2_7 == var_0_6 then
						var_2_12 = arg_2_0.parameterTargetValue + var_2_9
					elseif var_2_7 == var_0_7 then
						var_2_12 = var_2_9
					end

					if var_2_12 then
						var_2_6 = true

						local var_2_13 = arg_2_0:fixParameterTargetValue(var_2_12, arg_2_0.range, arg_2_0.rangeAbs, arg_2_0.dragDirect)

						if arg_2_0.actionTrigger.change_focus == false then
							arg_2_0.prepareTargetValue = var_2_13
							print = var_21

							var_21(arg_2_0.id .. "=" .. arg_2_0.parameterName .. "等待动作结束后的target赋值" .. arg_2_0.parameterTargetValue)
						else
							arg_2_0:setTargetValue(var_2_13)

							print = var_21

							var_21(arg_2_0.id .. "=" .. arg_2_0.parameterName .. "监听 数值变更为" .. arg_2_0.parameterTargetValue)
						end
					end

					if var_2_11 and var_2_11 > 0 then
						var_2_6 = true
						arg_2_0.actionListIndex = var_2_11
					end
				end
			end
		end

		if arg_2_0.listenerApply and #arg_2_0.listenerApply > 0 then
			local var_2_14 = arg_2_0.listenerApply[1]
			local var_2_15 = arg_2_0.listenerApply[2]

			if var_2_14 == var_0_8 and var_2_6 then
				local var_2_16 = arg_2_0.parameterTargetValue

				if arg_2_0.prepareTargetValue ~= nil then
					var_2_16 = arg_2_0.prepareTargetValue
				end

				local var_2_17

				for iter_2_1 = 1, #var_2_15 do
					if var_2_16 >= var_2_15[iter_2_1][1] and var_2_16 < var_18[2] then
						var_2_17 = var_18[3]
					end
				end

				if var_2_17 and arg_2_0.l2dIdleIndex ~= var_2_17 then
					local var_2_18 = arg_2_0
					local var_2_19 = arg_2_0.onEventCallback

					Live2DPainting = iter_2_1

					var_2_19(var_2_18, iter_2_1.EVENT_CHANGE_IDLE_INDEX, {
						id = arg_2_0.id,
						idle = var_2_17,
						activeData = arg_2_0.actionTriggerActive
					})
				end
			end
		end
	end

	return
end

function var_0_0.onListenerTrigger(arg_3_0, arg_3_1, arg_3_2)
	Live2DPainting = var_1_10003

	if arg_3_1 == var_1_10003.ON_ACTION_DRAG_CLICK then
		if arg_3_0.actionTrigger.click_cd then
			table = var_3

			if var_3.contains(arg_3_0.actionTrigger.click_cd, arg_3_2.draw_able_name) then
				arg_3_0.nextTriggerTime = arg_3_0.limitTime
			end
		end
	else
		Live2DPainting = var_3

		if arg_3_1 == var_3.ON_ACTION_PLAY then
			local var_3_0

			if not (arg_3_0.limitTime <= 0.2) or not arg_3_0.limitTime then
				var_3_0 = 0.2
			end

			arg_3_0.nextTriggerTime = var_3_0
		end
	end

	return
end

function var_0_0.getChangeCheckName(arg_4_0, arg_4_1, arg_4_2)
	Live2DPainting = var_1_10003

	if arg_4_1 == var_1_10003.ON_ACTION_PLAY then
		return arg_4_2.action
	else
		Live2DPainting = var_3

		if arg_4_1 == var_3.ON_ACTION_DRAG_CLICK then
			return arg_4_2.draw_able_name
		else
			Live2DPainting = var_3

			if arg_4_1 == var_3.ON_ACTION_CHANGE_IDLE then
				return arg_4_2.idle
			else
				Live2DPainting = var_3

				if arg_4_1 == var_3.ON_ACTION_PARAMETER then
					-- block empty
				else
					Live2DPainting = var_3

					if arg_4_1 == var_3.ON_ACTION_DOWN then
						-- block empty
					else
						Live2DPainting = var_3

						if arg_4_1 == var_3.ON_ACTION_XY_TRIGGER then
							-- block empty
						else
							Live2DPainting = var_3

							if arg_4_1 == var_3.ON_ACTION_DRAG_TRIGGER then
								-- block empty
							end
						end
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.startDrag(arg_5_0, arg_5_1)
	if arg_5_0.ignoreAction and arg_5_0.l2dIsPlaying then
		return
	end

	print = var_2

	var_2(arg_5_0.drawAbleName .. " 按下了 id = " .. arg_5_0.id)

	if not arg_5_0._active then
		arg_5_0._active = true
		Input = var_2
		arg_5_0.mouseInputDown = var_2.mousePosition
		Time = var_2
		arg_5_0.mouseInputDownTime = var_2.time
		arg_5_0.triggerActionTime = 0
		table = var_2

		if var_2.contains(var_0_2, arg_5_0.actionTrigger.type) then
			arg_5_0.actionListIndex = 1
		end

		arg_5_0.parameterSmoothTime = arg_5_0.smooth
	end

	return
end

function var_0_0.stopDrag(arg_6_0, arg_6_1)
	if arg_6_0._active then
		arg_6_0._active = false

		arg_6_0:setParameterRevert()

		if arg_6_0.offsetDragX then
			arg_6_0.offsetDragTargetX = arg_6_0:fixParameterTargetValue(arg_6_0.offsetDragX, arg_6_0.range, arg_6_0.rangeAbs, arg_6_0.dragDirect)
		end

		if arg_6_0.offsetDragY then
			arg_6_0.offsetDragTargetY = arg_6_0:fixParameterTargetValue(arg_6_0.offsetDragY, arg_6_0.range, arg_6_0.rangeAbs, arg_6_0.dragDirect)
		end

		arg_6_0:checkResetTriggerTime()

		Input = var_2
		arg_6_0.mouseInputUp = var_2.mousePosition
		Time = var_2
		arg_6_0.mouseInputUpTime = var_2.time
		arg_6_0.mouseWorld = nil
		arg_6_0.circleDragWorld = nil

		arg_6_0:updatePartsParameter()
		arg_6_0:saveData()
	end

	return
end

function var_0_0.setParameterRevert(arg_7_0)
	if arg_7_0.revert > 0 then
		arg_7_0.parameterToStart = arg_7_0.revert / 1000
		arg_7_0.parameterSmoothTime = arg_7_0.smoothRevert
	end

	return
end

function var_0_0.onDrag(arg_8_0, arg_8_1)
	arg_8_0.mouseWorld = arg_8_1.pointerCurrentRaycast.worldPosition

	return
end

function var_0_0.checkResetTriggerTime(arg_9_0)
	local var_9_0 = false
	local var_9_1 = arg_9_0.actionTrigger.type

	Live2DPainting = var_1_10003

	if var_9_1 == var_1_10003.DRAG_DOWN_ACTION and arg_9_0.actionTrigger.last then
		var_9_0 = true
	end

	if var_9_0 then
		arg_9_0:resetNextTriggerTime()
	end

	return
end

function var_0_0.resetNextTriggerTime(arg_10_0)
	arg_10_0.nextTriggerTime = 0

	return
end

function var_0_0.updatePartsParameter(arg_11_0)
	type = var_1_10001

	if var_1_10001(arg_11_0.partsData) == "table" then
		local var_11_0 = arg_11_0.partsData.parts
		local var_11_1 = arg_11_0.partsData.type
		local var_11_2 = false

		if arg_11_0.offsetX or arg_11_0.offsetY then
			var_11_2 = true
		else
			if arg_11_0.actionTrigger then
				local var_11_3 = arg_11_0.actionTrigger.type

				Live2DPainting = var_1_10005

				if var_11_3 == var_1_10005.DRAG_DOWN_TOUCH then
					var_11_2 = true

					goto label_11_0
				end
			end

			if arg_11_0.offsetCirclePos then
				var_11_2 = true
			end
		end

		::label_11_0::

		if var_11_2 then
			local var_11_4 = arg_11_0.parameterTargetValue
			local var_11_5
			local var_11_6

			for iter_11_0 = 1, #var_11_0 do
				local var_11_7 = var_11_0[iter_11_0]

				math = var_1_10012
				var_1_10012 = var_1_10012.abs(var_11_4 - var_11_7)

				if var_11_1 == var_0_3 or not var_11_1 then
					if not var_11_5 or var_1_10012 < var_11_5 then
						var_11_5 = var_1_10012
						var_11_6 = iter_11_0
					end
				elseif var_11_1 == var_0_4 then
					if var_11_7 <= var_11_4 and (not var_11_5 or var_1_10012 < var_11_5) then
						var_11_5 = var_1_10012
						var_11_6 = iter_11_0
					end
				elseif var_11_1 == var_0_5 and var_11_4 <= var_11_7 and (not var_11_5 or var_1_10012 < var_11_5) then
					var_11_5 = var_1_10012
					var_11_6 = iter_11_0
				end
			end

			if var_11_6 then
				math = var_7

				if var_7.abs(arg_11_0.parameterTargetValue - var_11_0[var_11_6]) >= 0.05 then
					print = var_7

					var_7("吸附数值" .. var_11_0[var_11_6])
				end

				if arg_11_0.offsetDragTargetX then
					arg_11_0.offsetDragTargetX = var_11_0[var_11_6]
				end

				if arg_11_0.offsetDragTargetY then
					arg_11_0.offsetDragTargetY = var_11_0[var_11_6]
				end

				arg_11_0:setTargetValue(var_11_0[var_11_6])
			end
		end
	end

	return
end

function var_0_0.getIgnoreReact(arg_12_0)
	return arg_12_0.ignoreReact
end

function var_0_0.setParameterCom(arg_13_0, arg_13_1)
	if not arg_13_1 then
		-- block empty
	end

	arg_13_0._parameterCom = arg_13_1

	return
end

function var_0_0.getParameterCom(arg_14_0)
	return arg_14_0._parameterCom
end

function var_0_0.getParameterName(arg_15_0)
	if arg_15_0.parameterName and #arg_15_0.parameterName > 0 then
		return arg_15_0.parameterName
	end

	return nil
end

function var_0_0.addRelationComData(arg_16_0, arg_16_1, arg_16_2)
	table = var_1_10003

	var_1_10003.insert(arg_16_0._relationParameterList, {
		com = arg_16_1,
		data = arg_16_2
	})

	return
end

function var_0_0.getRelationParameterList(arg_17_0)
	return arg_17_0._relationParameterList
end

function var_0_0.getReactCondition(arg_18_0)
	return arg_18_0.reactConditionFlag
end

function var_0_0.getActive(arg_19_0)
	return arg_19_0._active
end

function var_0_0.getParameterUpdateFlag(arg_20_0)
	return arg_20_0._parameterUpdateFlag
end

function var_0_0.setEventCallback(arg_21_0, arg_21_1)
	arg_21_0._eventCallback = arg_21_1

	return
end

function var_0_0.onEventCallback(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	Live2DPainting = var_1_10004

	local var_22_0

	if arg_22_1 == var_1_10004.EVENT_ACTION_APPLY then
		var_22_0 = {}

		local var_22_1
		local var_22_2 = false
		local var_22_3
		local var_22_4
		local var_22_5
		local var_22_6 = false

		local function var_22_7()
			local var_23_0 = arg_22_0

			if var_0.isApplyStopDrag(var_23_0) then
				local var_23_1 = arg_22_0

				var_0.stopDrag(var_23_1)
			end

			return
		end

		if arg_22_0.actionTrigger.action then
			var_22_1 = arg_22_0:fillterAction(arg_22_0.actionTrigger.action)
			var_22_0 = arg_22_0.actionTriggerActive
			var_22_2 = arg_22_0.actionTrigger.focus == 1 and true or false
			var_22_3 = arg_22_0.actionTrigger.target or nil
			var_22_6 = arg_22_0.actionTrigger.target_focus == 1 and true or false

			if (arg_22_0.actionTrigger.circle ~= nil and true or false) and var_22_3 and var_22_3 == arg_22_0.parameterTargetValue then
				var_22_3 = arg_22_0.startValue
			end

			var_22_4 = arg_22_0.actionTrigger.react or nil

			arg_22_0:triggerAction()
			var_22_7()
		elseif arg_22_0.actionTrigger.action_list then
			local var_22_8 = arg_22_0.actionTrigger.action_list[arg_22_0.actionListIndex]

			var_22_1 = arg_22_0:fillterAction(var_22_8.action)

			if arg_22_0.actionTriggerActive.active_list and arg_22_0.actionListIndex <= #arg_22_0.actionTriggerActive.active_list then
				var_22_0 = arg_22_0.actionTriggerActive.active_list[arg_22_0.actionListIndex]
			else
				var_22_0 = arg_22_0.actionTriggerActive
			end

			var_22_2 = var_22_8.focus == 1 and true or false

			if not var_22_2 and arg_22_0.actionTrigger.focus then
				var_22_2 = arg_22_0.actionTrigger.focus == 1 and true or false
			end

			var_22_3 = var_22_8.target or nil
			var_22_6 = var_22_8.target_focus == 1 and true or false
			var_22_4 = var_22_8.react or nil

			if var_22_1 and #var_22_1 > 0 then
				arg_22_0:triggerAction()
			end

			if arg_22_0.actionListIndex == #arg_22_0.actionTrigger.action_list then
				arg_22_0.actionListIndex = 1

				var_22_7()
			else
				arg_22_0.actionListIndex = arg_22_0.actionListIndex + 1
			end

			print = var_13

			var_13("id = " .. arg_22_0.id .. " action list index = " .. arg_22_0.actionListIndex)
		elseif not arg_22_0.actionTrigger.action then
			var_22_1 = arg_22_0:fillterAction(arg_22_0.actionTrigger.action)
			var_22_0 = arg_22_0.actionTriggerActive
			var_22_2 = arg_22_0.actionTrigger.focus == 1 and true or false
			var_22_3 = arg_22_0.actionTrigger.target or nil
			var_22_6 = arg_22_0.actionTrigger.target_focus == 1 and true or false

			local var_22_9 = arg_22_0.actionTrigger.circle ~= nil and true or false

			var_22_4 = arg_22_0.actionTrigger.react or nil

			if var_22_9 and var_22_3 and var_22_3 == arg_22_0.parameterTargetValue then
				var_22_3 = arg_22_0.startValue
			end

			arg_22_0:triggerAction()
			arg_22_0:setTriggerActionFlag(false)
			var_22_7()
		end

		if var_22_0.idle then
			type = var_12

			if var_12(var_22_0.idle) == "number" then
				if var_22_0.idle == arg_22_0.l2dIdleIndex and not var_22_0.repeat_flag then
					return
				end
			else
				type = var_12

				if var_12(var_22_0.idle) == "table" and #var_22_0.idle == 1 and var_22_0.idle[1] == arg_22_0.l2dIdleIndex and not var_22_0.repeat_flag then
					return
				end
			end
		end

		print = var_12

		local var_22_10 = "执行aplly数据 id = "
		local var_22_11 = arg_22_0.id
		local var_22_12 = "播放action = "

		tostring = var_1_10017

		local var_22_13 = var_1_10017(var_22_1)
		local var_22_14 = " active idle is "

		tostring = var_19

		var_12(var_22_10 .. var_22_11 .. var_22_12 .. var_22_13 .. var_22_14 .. var_19(var_22_0.idle))

		if var_22_3 then
			arg_22_0:setTargetValue(var_22_3)

			if var_22_6 then
				arg_22_0:setParameterValue(var_22_3)
			end

			if not var_22_1 then
				arg_22_0.revertResetFlag = true
			end
		end

		if var_22_2 then
			arg_22_0:setTriggerActionFlag(false)
		end

		arg_22_2 = {
			id = arg_22_0.id,
			action = var_22_1,
			activeData = var_22_0,
			focus = var_22_2,
			react = var_22_4,
			callback = arg_22_3,
			finishCall = function()
				local var_24_0 = arg_22_0

				var_0.actionApplyFinish(var_24_0)

				return
			end
		}
	else
		Live2DPainting = var_22_0

		if arg_22_1 == var_22_0.EVENT_ACTION_ABLE then
			-- block empty
		else
			Live2DPainting = var_4

			if arg_22_1 == var_4.EVENT_CHANGE_IDLE_INDEX then
				print = var_4

				var_4("change idle")
			else
				Live2DPainting = var_4

				if arg_22_1 == var_4.EVENT_GET_PARAMETER then
					arg_22_2.callback = arg_22_3
				else
					Live2DPainting = var_4

					if arg_22_1 == var_4.EVENT_GET_DRAG_PARAMETER then
						arg_22_2.callback = arg_22_3
					else
						Live2DPainting = var_4

						if arg_22_1 == var_4.EVENT_GET_WORLD_POSITION then
							arg_22_2.callback = arg_22_3
						else
							Live2DPainting = var_4

							if arg_22_1 == var_4.EVENT_GAME_XIAQI then
								arg_22_2.callback = arg_22_3
							end
						end
					end
				end
			end
		end
	end

	arg_22_0._eventCallback(arg_22_1, arg_22_2)

	return
end

function var_0_0.isApplyStopDrag(arg_25_0)
	if arg_25_0.actionTrigger then
		local var_25_0 = arg_25_0.actionTrigger.type

		Live2DPainting = var_1_10002

		if var_25_0 == var_1_10002.DRAG_MOVE_DOWN_UP then
			return false
		end
	end

	return true
end

function var_0_0.fillterAction(arg_26_0, arg_26_1)
	type = var_1_10002

	if var_1_10002(arg_26_1) == "table" then
		math = var_2

		return arg_26_1[var_2.random(1, #arg_26_1)]
	else
		return arg_26_1
	end

	return
end

function var_0_0.onEventNotice(arg_27_0, arg_27_1)
	if arg_27_0._eventCallback then
		local var_27_0 = arg_27_0:getCommonNoticeData()

		arg_27_0._eventCallback(arg_27_1, var_27_0)
	end

	return
end

function var_0_0.getCommonNoticeData(arg_28_0)
	return {
		draw_able_name = arg_28_0.drawAbleName,
		parameter_name = arg_28_0.parameterName,
		parameter_target = arg_28_0.parameterTargetValue
	}
end

function var_0_0.setTargetValue(arg_29_0, arg_29_1)
	arg_29_0.parameterSmooth = 0
	arg_29_0.parameterStartValue = arg_29_0.parameterTargetValue
	arg_29_0.parameterTargetValue = arg_29_1

	return
end

function var_0_0.setTargetValueDelay(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:setTargetValue(arg_30_1)

	arg_30_0.delayTargetTime = arg_30_2

	return
end

function var_0_0.getParameter(arg_31_0)
	return arg_31_0.parameterValue
end

function var_0_0.getParameterTarget(arg_32_0)
	return arg_32_0.parameterTargetValue
end

function var_0_0.getParameToTargetFlag(arg_33_0)
	if arg_33_0.parameterValue ~= arg_33_0.parameterTargetValue then
		return true
	end

	if arg_33_0.parameterToStart and arg_33_0.parameterToStart > 0 then
		return true
	end

	return false
end

function var_0_0.actionApplyFinish(arg_34_0)
	return
end

function var_0_0.stepParameter(arg_35_0, arg_35_1)
	arg_35_0:updateStepData(arg_35_1)
	arg_35_0:updateActiveState()
	arg_35_0:updateTrigger()
	arg_35_0:updateParameterUpdateFlag()
	arg_35_0:updateGyro()
	arg_35_0:updateDrag()
	arg_35_0:updateCircleDrag()
	arg_35_0:updateReactValue()
	arg_35_0:updateParameterValue()
	arg_35_0:updateRelationValue()
	arg_35_0:checkReset()

	arg_35_0.loadL2dStep = false

	return
end

function var_0_0.updateStepData(arg_36_0, arg_36_1)
	arg_36_0.reactPos = arg_36_1.reactPos
	arg_36_0.lastNormalTime = arg_36_0.normalTime
	arg_36_0.normalTime = arg_36_1.normalTime
	arg_36_0.stateInfo = arg_36_1.stateInfo

	return
end

function var_0_0.updateParameterUpdateFlag(arg_37_0)
	local var_37_0 = arg_37_0.actionTrigger.type

	Live2DPainting = var_1_10002

	if var_37_0 == var_1_10002.DRAG_CLICK_ACTION then
		arg_37_0._parameterUpdateFlag = true
	else
		local var_37_1 = arg_37_0.actionTrigger.type

		Live2DPainting = var_2

		if var_37_1 == var_2.DRAG_RELATION_IDLE then
			if not arg_37_0._parameterUpdateFlag then
				if not arg_37_0.l2dIsPlaying then
					arg_37_0._parameterUpdateFlag = true

					arg_37_0:changeParameComAble(true)
				else
					table = var_1

					if not var_1.contains(arg_37_0.actionTrigger.remove_com_list, arg_37_0.l2dPlayActionName) then
						arg_37_0._parameterUpdateFlag = true

						arg_37_0:changeParameComAble(true)
					end
				end
			elseif arg_37_0._parameterUpdateFlag == true and arg_37_0.l2dIsPlaying then
				table = var_1

				if var_1.contains(arg_37_0.actionTrigger.remove_com_list, arg_37_0.l2dPlayActionName) then
					arg_37_0._parameterUpdateFlag = false

					arg_37_0:changeParameComAble(false)
				end
			end
		else
			local var_37_2 = arg_37_0.actionTrigger.type

			Live2DPainting = var_2

			if var_37_2 == var_2.DRAG_DOWN_TOUCH then
				arg_37_0._parameterUpdateFlag = true
			else
				local var_37_3 = arg_37_0.actionTrigger.type

				Live2DPainting = var_2

				if var_37_3 == var_2.DRAG_LISTENER_EVENT then
					arg_37_0._parameterUpdateFlag = true
				else
					local var_37_4 = arg_37_0.actionTrigger.type

					Live2DPainting = var_2

					if var_37_4 == var_2.DRAG_ANIMATION_PLAY then
						arg_37_0._parameterUpdateFlag = true
					else
						local var_37_5 = arg_37_0.actionTrigger.type

						Live2DPainting = var_2

						if var_37_5 == var_2.DRAG_WITH_PARAMETER_MOVE then
							arg_37_0._parameterUpdateFlag = true
						else
							local var_37_6 = arg_37_0.actionTrigger.type

							Live2DPainting = var_2

							if var_37_6 == var_2.DRAG_MOVE_DOWN_UP then
								arg_37_0._parameterUpdateFlag = true
							else
								local var_37_7 = arg_37_0.actionTrigger.type

								Live2DPainting = var_2

								if var_37_7 == var_2.DRAG_GAME_XIAQI then
									arg_37_0._parameterUpdateFlag = true
								else
									arg_37_0._parameterUpdateFlag = false
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.changeParameComAble(arg_38_0, arg_38_1)
	if arg_38_0.parameterComAdd == arg_38_1 then
		return
	end

	arg_38_0.parameterComAdd = arg_38_1

	if arg_38_1 then
		local var_38_0 = arg_38_0
		local var_38_1 = arg_38_0.onEventCallback

		Live2DPainting = var_1_10005

		var_38_1(var_38_0, var_1_10005.EVENT_ADD_PARAMETER_COM, {
			com = arg_38_0._parameterCom,
			start = arg_38_0.startValue,
			mode = arg_38_0.mode
		})
	else
		local var_38_2 = arg_38_0
		local var_38_3 = arg_38_0.onEventCallback

		Live2DPainting = var_1_10005

		var_38_3(var_38_2, var_1_10005.EVENT_REMOVE_PARAMETER_COM, {
			com = arg_38_0._parameterCom,
			mode = arg_38_0.mode
		})
	end

	return
end

function var_0_0.updateDrag(arg_39_0)
	if not arg_39_0.offsetX and not arg_39_0.offsetY then
		return
	end

	local var_39_0

	if arg_39_0._active then
		Input = var_2

		local var_39_1 = var_2.mousePosition

		if arg_39_0.offsetX and arg_39_0.offsetX ~= 0 then
			local var_39_2 = var_39_1.x - arg_39_0.mouseInputDown.x

			arg_39_0.offsetDragX = arg_39_0.offsetDragTargetX + var_39_2 / arg_39_0.offsetX
		end

		if arg_39_0.offsetY and arg_39_0.offsetY ~= 0 then
			local var_39_3 = var_39_1.y - arg_39_0.mouseInputDown.y

			arg_39_0.offsetDragY = arg_39_0.offsetDragTargetY + var_39_3 / arg_39_0.offsetY
		end

		if var_39_0 then
			arg_39_0:setTargetValue(arg_39_0:fixParameterTargetValue(var_39_0, arg_39_0.range, arg_39_0.rangeAbs, arg_39_0.dragDirect))
		end
	end

	arg_39_0._parameterUpdateFlag = true

	return
end

function var_0_0.updateCircleDrag(arg_40_0)
	if not arg_40_0.offsetCirclePos then
		return
	end

	if arg_40_0._active and arg_40_0.mouseWorld ~= nil then
		local var_40_1

		if not arg_40_0.circleDragWorld then
			local var_40_0 = arg_40_0

			var_40_1 = arg_40_0.onEventCallback
			Live2DPainting = var_1_10004

			var_40_1(var_40_0, var_1_10004.EVENT_GET_WORLD_POSITION, {
				pos = arg_40_0.offsetCirclePos,
				name = arg_40_0.drawAbleName
			}, function(arg_41_0)
				arg_40_0.circleDragWorld = arg_41_0

				return
			end)
		end

		math = var_40_1

		local var_40_2 = var_40_1.atan2(arg_40_0.mouseWorld.x - arg_40_0.circleDragWorld.x, arg_40_0.mouseWorld.y - arg_40_0.circleDragWorld.y)

		math = var_1_10002

		local var_40_3 = (var_40_2 * var_1_10002.rad2Deg + 360 - arg_40_0.offsetCircleStart) % 360 / 360
		local var_40_4 = arg_40_0.range[2] * var_40_3

		arg_40_0:setTargetValue(var_40_4)

		arg_40_0._parameterUpdateFlag = true
	elseif arg_40_0.parameterTargetValue ~= arg_40_0.parameterValue then
		arg_40_0._parameterUpdateFlag = true
	end

	return
end

function var_0_0.updateGyro(arg_42_0)
	if not arg_42_0.gyro then
		return
	end

	Input = var_1

	if not var_1.gyro.enabled then
		arg_42_0:setTargetValue(0)

		arg_42_0._parameterUpdateFlag = true

		return
	end

	Input = var_1

	if var_1.gyro then
		Input = var_42_0

		local var_42_0

		if not var_42_0.gyro.attitude then
			Vector3 = var_42_0
			var_42_0 = var_42_0.zero
		end

		local var_42_1 = 0

		if arg_42_0.gyroX then
			math = var_3

			if not var_3.isnan(var_42_0.y) then
				Mathf = var_3
				var_42_1 = var_3.Clamp(var_42_0.y * arg_42_0.sensitive, -0.5, 0.5)

				goto label_42_0
			end
		end

		if arg_42_0.gyroY then
			math = var_3

			if not var_3.isnan(var_42_0.x) then
				Mathf = var_3
				var_42_1 = var_3.Clamp(var_42_0.x * arg_42_0.sensitive, -0.5, 0.5)

				goto label_42_0
			end
		end

		if arg_42_0.gyroZ then
			math = var_3

			if not var_3.isnan(var_42_0.z) then
				Mathf = var_3
				var_42_1 = var_3.Clamp(var_42_0.z * arg_42_0.sensitive, -0.5, 0.5)
			end
		end

		::label_42_0::

		IsUnityEditor = var_3

		if var_3 then
			L2D_USE_RANDOM_ATTI = var_3

			if var_3 then
				if arg_42_0.randomAttitudeIndex == 0 then
					math = var_3

					local var_42_2 = (var_3.random() - 0.5 + 0.5) * (arg_42_0.range[2] - arg_42_0.range[1]) + arg_42_0.range[1]

					arg_42_0:setTargetValue(var_42_2)

					L2D_RANDOM_PARAM = var_4
					arg_42_0.randomAttitudeIndex = var_4
				elseif arg_42_0.randomAttitudeIndex > 0 then
					arg_42_0.randomAttitudeIndex = arg_42_0.randomAttitudeIndex - 1
				end
			end
		else
			local var_42_3 = (var_42_1 + 0.5) * (arg_42_0.range[2] - arg_42_0.range[1]) + arg_42_0.range[1]

			arg_42_0:setTargetValue(var_42_3)
		end

		arg_42_0._parameterUpdateFlag = true

		return
	end
end

function var_0_0.updateReactValue(arg_43_0)
	if not arg_43_0.reactX and not arg_43_0.reactY then
		return
	end

	local var_43_0
	local var_43_1 = false

	if arg_43_0.l2dIgnoreReact then
		var_43_0 = arg_43_0.parameterTargetValue
	elseif arg_43_0.reactX then
		var_43_0 = arg_43_0.reactPos.x * arg_43_0.reactX
		var_43_1 = true
	else
		var_43_0 = arg_43_0.reactPos.y * arg_43_0.reactY
		var_43_1 = true
	end

	if var_43_1 then
		arg_43_0:setTargetValue(arg_43_0:fixParameterTargetValue(var_43_0, arg_43_0.range, arg_43_0.rangeAbs, arg_43_0.dragDirect))
	end

	arg_43_0._parameterUpdateFlag = true

	return
end

function var_0_0.updateParameterValue(arg_44_0)
	if arg_44_0.delayTargetTime then
		local var_44_0 = arg_44_0.delayTargetTime

		if 0 < var_44_0 then
			local var_44_1 = arg_44_0.delayTargetTime

			Time = var_2
			arg_44_0.delayTargetTime = var_44_1 - var_2.deltaTime

			if arg_44_0.delayTargetTime <= 0 then
				arg_44_0.delayTargetTime = nil
			end

			return
		end
	end

	if arg_44_0.prepareTargetValue and not arg_44_0.l2dIsPlaying then
		arg_44_0:setTargetValue(arg_44_0.prepareTargetValue)

		arg_44_0.prepareTargetValue = nil
	end

	if arg_44_0._parameterUpdateFlag and arg_44_0.parameterValue ~= arg_44_0.parameterTargetValue then
		math = var_1

		if var_1.abs(arg_44_0.parameterValue - arg_44_0.parameterTargetValue) < 0.05 then
			arg_44_0:setParameterValue(arg_44_0.parameterTargetValue)
		elseif arg_44_0.parameterSmoothTime and arg_44_0.parameterSmoothTime > 0 then
			local var_44_2 = arg_44_0.parameterValue
			local var_44_3 = arg_44_0.parameterTargetValue
			local var_44_4 = arg_44_0:checkUpdateParameterNum(var_44_3, var_44_2)

			Live2DExtend = var_3

			local var_44_5 = var_3.CustomSmoothValue
			local var_44_6 = arg_44_0.parameterStartValue
			local var_44_7 = var_44_4
			local var_44_8 = arg_44_0.parameterSmoothTime
			local var_44_9 = arg_44_0.parameterSmooth

			Time = var_1_10009

			local var_44_10, var_44_11 = var_44_5(var_44_6, var_44_7, var_44_8, var_44_9, var_1_10009.fixedDeltaTime)

			arg_44_0:setParameterValue(var_44_10, var_44_11)
		else
			arg_44_0:setParameterValue(arg_44_0.parameterTargetValue, 0)
		end
	end

	return
end

function var_0_0.checkUpdateParameterNum(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.offsetCirclePos then
		math = var_3

		if var_3.abs(arg_45_1 - arg_45_2) >= arg_45_0.rangeOffset / 2 then
			if arg_45_2 < arg_45_1 then
				arg_45_1 = arg_45_1 - arg_45_0.rangeOffset
			else
				arg_45_1 = arg_45_1 + arg_45_0.rangeOffset
			end
		end
	end

	return arg_45_1
end

function var_0_0.updateRelationValue(arg_46_0)
	ipairs = var_1_10001

	for iter_46_0, iter_46_1 in var_1_10001(arg_46_0._relationParameterList) do
		local var_46_0 = iter_46_1.data.type
		local var_46_1 = var_6.relation_value
		local var_46_2 = var_6.target
		local var_46_3
		local var_46_4

		Live2DPainting = var_1_10012

		if var_46_0 == var_1_10012.relation_type_drag_x then
			var_46_3 = arg_46_0.offsetDragX or iter_46_1.start or arg_46_0.startValue or 0
			var_46_4 = true
		else
			Live2DPainting = var_1_10012

			if var_46_0 == var_1_10012.relation_type_drag_y then
				var_46_3 = arg_46_0.offsetDragY or iter_46_1.start or arg_46_0.startValue or 0
				var_46_4 = true
			else
				Live2DPainting = var_1_10012

				if var_46_0 == var_1_10012.relation_type_action_index then
					if not var_46_1[arg_46_0.actionListIndex] then
						var_46_3 = 0
					end

					var_46_4 = true
				else
					Live2DPainting = var_1_10012

					if var_46_0 == var_1_10012.relation_type_idle then
						if arg_46_0.loadL2dStep and arg_46_0.l2dIdleIndex == var_6.idle then
							var_46_4 = true
						end

						if arg_46_0.l2dIsPlaying then
							if arg_46_0.l2dPlayActionName == arg_46_0.actionTrigger.action then
								arg_46_0.relationActive = true
							end
						else
							arg_46_0.relationActive = false
							arg_46_0.relationCountTime = nil
						end

						if not var_46_4 and arg_46_0.relationActive and arg_46_0.l2dIdleIndex == var_6.idle then
							if not arg_46_0.relationCountTime then
								Time = var_1_10012
								arg_46_0.relationCountTime = var_1_10012.GetTimestamp() + var_6.time
							end

							if arg_46_0.relationCountTime then
								Time = var_1_10012

								if var_1_10012.GetTimestamp() >= arg_46_0.relationCountTime then
									var_46_4 = true
								end
							end
						end
					else
						var_46_3 = arg_46_0.parameterTargetValue
						var_46_4 = false
					end
				end
			end
		end

		var_1_10012 = nil

		local var_46_5

		if var_46_2 then
			var_1_10012 = var_46_2
		else
			local var_46_6 = arg_46_0
			local var_46_7 = arg_46_0.fixRelationParameter(var_46_6, var_46_3, var_6)
			local var_46_8

			if not iter_46_1.value then
				var_46_8 = arg_46_0.startValue
			end

			math = var_46_6

			if var_46_6.abs(var_46_7 - var_46_8) <= 0.01 then
				var_1_10012 = var_46_7
			else
				local var_46_9

				if not iter_46_1.parameterSmooth then
					var_46_9 = 0
				end

				local var_46_10

				if not var_6.smooth or not (var_6.smooth / 1000) then
					var_46_10 = arg_46_0.smooth
				end

				Mathf = var_18
				var_1_10012, var_46_5 = var_18.SmoothDamp(var_46_8, var_46_7, var_46_9, var_46_10)
			end
		end

		iter_46_1.target = var_46_3
		iter_46_1.value = var_1_10012
		iter_46_1.parameterSmooth = var_46_5
		iter_46_1.enable = var_46_4
		iter_46_1.comId = arg_46_0.id
	end

	return
end

function var_0_0.fixRelationParameter(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0

	if not arg_47_2.range then
		var_47_0 = arg_47_0.range
	end

	local var_47_1 = arg_47_2.rangeAbs and arg_47_2.rangeAbs == 1 or arg_47_0.rangeAbs
	local var_47_2

	if not arg_47_2.drag_direct or not arg_47_2.drag_direct then
		var_47_2 = arg_47_0.dragDirect
	end

	return arg_47_0:fixParameterTargetValue(arg_47_1, var_47_0, var_47_1, var_47_2)
end

function var_0_0.fixParameterTargetValue(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	if arg_48_1 < 0 and arg_48_4 == 1 then
		arg_48_1 = 0
	elseif 0 < arg_48_1 and arg_48_4 == 2 then
		arg_48_1 = 0
	end

	if arg_48_3 then
		math = var_5
		arg_48_1 = var_5.abs(arg_48_1) or arg_48_1
	end

	if arg_48_1 < arg_48_2[1] then
		arg_48_1 = arg_48_2[1]
	elseif arg_48_1 > arg_48_2[2] then
		arg_48_1 = arg_48_2[2]
	end

	return arg_48_1
end

function var_0_0.checkReset(arg_49_0)
	if not arg_49_0._active and arg_49_0.parameterToStart then
		local var_49_0 = arg_49_0.parameterToStart

		if 0 < var_49_0 then
			local var_49_1 = arg_49_0.parameterToStart

			Time = var_2
			arg_49_0.parameterToStart = var_49_1 - var_2.deltaTime
		end

		if arg_49_0.parameterToStart <= 0 then
			arg_49_0:setTargetValue(arg_49_0.startValue)

			arg_49_0.parameterToStart = nil

			if arg_49_0.revertResetFlag then
				arg_49_0:setTriggerActionFlag(false)

				arg_49_0.revertResetFlag = false
			end

			if arg_49_0.offsetDragX then
				arg_49_0.offsetDragX = arg_49_0.startValue
				arg_49_0.offsetDragTargetX = arg_49_0.startValue
			end

			if arg_49_0.offsetDragY then
				arg_49_0.offsetDragY = arg_49_0.startValue
				arg_49_0.offsetDragTargetY = arg_49_0.startValue
			end
		end
	end

	return
end

function var_0_0.setParameterValue(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_1 then
		arg_50_0.parameterValue = arg_50_1
	end

	if arg_50_2 then
		arg_50_0.parameterSmooth = arg_50_2
	end

	return
end

function var_0_0.updateActiveState(arg_51_0)
	if not arg_51_0.lastFrameActive and arg_51_0._active then
		arg_51_0.firstActive = true
	else
		arg_51_0.firstActive = false
	end

	if arg_51_0.lastFrameActive and not arg_51_0._active then
		arg_51_0.firstStop = true
	else
		arg_51_0.firstStop = false
	end

	arg_51_0.lastFrameActive = arg_51_0._active

	return
end

function var_0_0.updateTrigger(arg_52_0)
	if not arg_52_0:isActionTriggerAble() then
		return
	end

	local var_52_0 = arg_52_0.actionTrigger.type
	local var_52_1 = arg_52_0.actionTrigger.action
	local var_52_2

	if arg_52_0.actionTrigger.time then
		var_52_2 = arg_52_0.actionTrigger.time
	elseif arg_52_0.actionTrigger.action_list and arg_52_0.actionListIndex > 0 then
		var_52_2 = arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].time
	end

	local var_52_3
	local var_52_4

	if arg_52_0.actionTrigger.num then
		var_52_3 = arg_52_0.actionTrigger.num
	elseif arg_52_0.actionTrigger.action_list and arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].num then
		var_52_4 = arg_52_0.actionListIndex

		if 0 < var_52_4 then
			var_52_3 = arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].num
		end
	end

	Live2DPainting = var_52_4

	local var_52_5

	if var_52_0 == var_52_4.DRAG_TIME_ACTION then
		if arg_52_0._active then
			if var_52_3 then
				math = var_52_5
				var_52_5 = var_52_5.abs(arg_52_0.parameterValue - var_52_3)
				math = var_1_10006

				if var_52_5 < var_1_10006.abs(var_52_3) * 0.25 then
					var_52_5 = arg_52_0.triggerActionTime
					Time = var_1_10006
					arg_52_0.triggerActionTime = var_52_5 + var_1_10006.deltaTime

					if var_52_2 < arg_52_0.triggerActionTime and not arg_52_0.l2dIsPlaying then
						var_1_10007 = arg_52_0
						var_52_5 = arg_52_0.onEventCallback
						Live2DPainting = iter_52_0

						var_52_5(var_1_10007, iter_52_0.EVENT_ACTION_APPLY, nil, function(arg_53_0)
							if arg_53_0 then
								local var_53_0 = arg_52_0
								local var_53_1 = var_1.onEventNotice

								Live2DPainting = var_2_10004

								var_53_1(var_53_0, var_2_10004.ON_ACTION_DRAG_TRIGGER)
							end

							return
						end)
					end

					goto label_52_1
				end
			end

			print = var_52_5

			var_52_5("配置id = " .. arg_52_0.id .. " 缺少参数 num")
		end

		goto label_52_1
	end

	Live2DPainting = var_52_5

	if var_52_0 == var_52_5.DRAG_CLICK_ACTION then
		var_1_10007 = arg_52_0

		if arg_52_0.checkClickAction(var_1_10007) then
			iter_52_0 = arg_52_0
			var_1_10006 = arg_52_0.onEventCallback
			Live2DPainting = var_1_10009

			var_1_10006(iter_52_0, var_1_10009.EVENT_ACTION_APPLY, nil, function(arg_54_0)
				local var_54_0 = arg_52_0
				local var_54_1 = var_1.onEventNotice

				Live2DPainting = var_2_10004

				var_54_1(var_54_0, var_2_10004.ON_ACTION_DRAG_CLICK)

				return
			end)
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	if var_52_0 == var_5.DRAG_CLICK_RANGE then
		var_1_10007 = arg_52_0

		if arg_52_0.checkClickAction(var_1_10007) then
			if not arg_52_0.actionTrigger.parameter or not arg_52_0.actionTrigger.parameter then
				var_1_10006 = arg_52_0.parameterName
			end

			var_1_10007 = var_52_3
			var_1_10010 = arg_52_0
			iter_52_0 = arg_52_0.onEventCallback
			Live2DPainting = var_1_10011

			iter_52_0(var_1_10010, var_1_10011.EVENT_GET_PARAMETER, {
				name = var_1_10006
			}, function(arg_55_0)
				print = var_2_10001

				var_2_10001("获取到数值 " .. var_1_10006 .. " = " .. arg_55_0, "匹配范围 = " .. var_1_10007[1] .. " - " .. var_1_10007[2])

				if arg_55_0 >= var_1_10007[1] and arg_55_0 < var_1_10007[2] then
					print = var_1

					local var_55_0 = "数值范围内，开始触发动作  = "

					tostring = var_4

					var_1(var_55_0 .. var_4(arg_52_0.id))

					local var_55_1 = arg_52_0
					local var_55_2 = var_1.onEventCallback

					Live2DPainting = var_4

					var_55_2(var_55_1, var_4.EVENT_ACTION_APPLY, nil, function(arg_56_0)
						local var_56_0 = arg_52_0
						local var_56_1 = var_1.onEventNotice

						Live2DPainting = var_3_10004

						var_56_1(var_56_0, var_3_10004.ON_ACTION_DRAG_CLICK)

						return
					end)
				end

				return
			end)
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	local var_52_6

	if var_52_0 == var_5.DRAG_DOWN_ACTION then
		if arg_52_0._active then
			var_1_10007 = arg_52_0

			arg_52_0.setAbleWithFlag(var_1_10007, true)

			Time = var_52_6

			if var_52_2 <= var_52_6.time - arg_52_0.mouseInputDownTime and not arg_52_0.l2dIsPlaying then
				print = var_52_6

				var_52_6("触发按压动作")

				var_1_10007 = arg_52_0

				arg_52_0.setAbleWithFlag(var_1_10007, false)

				var_1_10007 = arg_52_0
				var_52_6 = arg_52_0.onEventCallback
				Live2DPainting = iter_52_0

				var_52_6(var_1_10007, iter_52_0.EVENT_ACTION_APPLY, nil, function(arg_57_0)
					if arg_57_0 then
						local var_57_0 = arg_52_0
						local var_57_1 = var_1.onEventNotice

						Live2DPainting = var_2_10004

						var_57_1(var_57_0, var_2_10004.ON_ACTION_DOWN)
					end

					return
				end)

				if arg_52_0.actionListIndex ~= 1 then
					var_1_10007 = arg_52_0

					arg_52_0.setTriggerActionFlag(var_1_10007, false)
				end

				var_1_10007 = arg_52_0

				arg_52_0.setAbleWithFlag(var_1_10007, true)

				Time = var_52_6
				arg_52_0.mouseInputDownTime = var_52_6.time
			end
		elseif arg_52_0.actionTrigger.last and arg_52_0.actionListIndex ~= 1 then
			arg_52_0.actionListIndex = #arg_52_0.actionTrigger.action_list
			var_1_10007 = arg_52_0

			arg_52_0.setAbleWithFlag(var_1_10007, false)

			var_1_10007 = arg_52_0
			var_52_6 = arg_52_0.onEventCallback
			Live2DPainting = iter_52_0

			var_52_6(var_1_10007, iter_52_0.EVENT_ACTION_APPLY, nil, function(arg_58_0)
				return
			end)

			var_1_10007 = arg_52_0

			arg_52_0.resetNextTriggerTime(var_1_10007)

			var_1_10007 = arg_52_0

			arg_52_0.setTriggerActionFlag(var_1_10007, false)
		else
			var_1_10007 = arg_52_0

			arg_52_0.setAbleWithFlag(var_1_10007, false)
		end

		goto label_52_1
	end

	Live2DPainting = var_52_6

	local var_52_7

	if var_52_0 == var_52_6.DRAG_RELATION_XY then
		if arg_52_0._active then
			var_1_10007 = arg_52_0
			var_52_7 = arg_52_0.fixParameterTargetValue(var_1_10007, arg_52_0.offsetDragX, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect)
			iter_52_0 = arg_52_0
			var_1_10006 = arg_52_0.fixParameterTargetValue(iter_52_0, arg_52_0.offsetDragY, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect)
			var_1_10007 = var_52_3[1]
			iter_52_0 = var_52_3[2]
			math = var_1_10009
			var_1_10009 = var_1_10009.abs(var_52_7 - var_1_10007)
			math = var_1_10010

			if var_1_10009 <= var_1_10010.abs(var_1_10007) * 0.25 then
				math = var_1_10009
				var_1_10009 = var_1_10009.abs(var_1_10006 - iter_52_0)
				math = var_1_10010

				if var_1_10009 <= var_1_10010.abs(iter_52_0) * 0.25 then
					var_1_10009 = arg_52_0.triggerActionTime
					Time = var_1_10010
					arg_52_0.triggerActionTime = var_1_10009 + var_1_10010.deltaTime

					if var_52_2 < arg_52_0.triggerActionTime and not arg_52_0.l2dIsPlaying then
						var_1_10011 = arg_52_0
						var_1_10009 = arg_52_0.onEventCallback
						Live2DPainting = var_12

						var_1_10009(var_1_10011, var_12.EVENT_ACTION_APPLY, nil, function(arg_59_0)
							if arg_59_0 then
								local var_59_0 = arg_52_0
								local var_59_1 = var_1.onEventNotice

								Live2DPainting = var_2_10004

								var_59_1(var_59_0, var_2_10004.ON_ACTION_XY_TRIGGER)
							end

							return
						end)
					end

					goto label_52_1
				end
			end

			arg_52_0.triggerActionTime = arg_52_0.triggerActionTime + 0
		end

		goto label_52_1
	end

	Live2DPainting = var_52_7

	if var_52_0 == var_52_7.DRAG_RELATION_IDLE then
		if arg_52_0.actionTrigger.const_fit then
			for iter_52_0 = 1, #arg_52_0.actionTrigger.const_fit do
				var_1_10009 = arg_52_0.actionTrigger.const_fit[iter_52_0]

				if arg_52_0.l2dIdleIndex == var_1_10009.idle and not arg_52_0.l2dIsPlaying then
					arg_52_0:setTargetValue(var_1_10009.target)
				end
			end
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	if var_52_0 == var_5.DRAG_CLICK_MANY then
		var_1_10007 = arg_52_0

		if arg_52_0.checkClickAction(var_1_10007) then
			iter_52_0 = arg_52_0
			var_1_10006 = arg_52_0.onEventCallback
			Live2DPainting = var_1_10009

			var_1_10006(iter_52_0, var_1_10009.EVENT_ACTION_APPLY)
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	local var_52_8

	if var_52_0 == var_5.DRAG_LISTENER_EVENT then
		if arg_52_0._listenerTrigger then
			var_1_10007 = arg_52_0
			var_52_8 = arg_52_0.onEventCallback
			Live2DPainting = iter_52_0

			var_52_8(var_1_10007, iter_52_0.EVENT_ACTION_APPLY)
		end

		goto label_52_1
	end

	Live2DPainting = var_52_8

	local var_52_9

	if var_52_0 == var_52_8.DRAG_DOWN_TOUCH then
		var_1_10007 = arg_52_0

		arg_52_0.setAbleWithFlag(var_1_10007, arg_52_0._active)

		if arg_52_0._active then
			Time = var_52_9
			var_52_9 = var_52_9.deltaTime / arg_52_0.actionTrigger.delta
			var_1_10006 = arg_52_0.parameterTargetValue + var_52_9
			var_1_10009 = arg_52_0
			var_1_10006 = arg_52_0.fixParameterTargetValue(var_1_10009, var_1_10006, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect)
			var_1_10009 = arg_52_0

			arg_52_0.setTargetValue(var_1_10009, var_1_10006)
		end

		goto label_52_1
	end

	Live2DPainting = var_52_9

	if var_52_0 == var_52_9.DRAG_CLICK_PARAMETER then
		var_1_10007 = arg_52_0

		if arg_52_0.checkClickAction(var_1_10007) then
			var_1_10006 = var_52_3
			var_1_10007 = arg_52_0.actionTrigger.parameter
			var_1_10010 = arg_52_0
			iter_52_0 = arg_52_0.onEventCallback
			Live2DPainting = var_1_10011

			iter_52_0(var_1_10010, var_1_10011.EVENT_GET_PARAMETER, {
				name = var_1_10007
			}, function(arg_60_0)
				math = var_2_10001

				if var_2_10001.abs(var_1_10006 - arg_60_0) <= 0.05 then
					print = var_1

					var_1("数值允许播放，开始执行动作 " .. arg_52_0.actionTrigger.action)

					local var_60_0 = arg_52_0
					local var_60_1 = var_1.onEventCallback

					Live2DPainting = var_4

					var_60_1(var_60_0, var_4.EVENT_ACTION_APPLY, nil, function(arg_61_0)
						local var_61_0 = arg_52_0
						local var_61_1 = var_1.onEventNotice

						Live2DPainting = var_3_10004

						var_61_1(var_61_0, var_3_10004.ON_ACTION_DRAG_CLICK)

						return
					end)
				end

				return
			end)
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	local var_52_10

	if var_52_0 == var_5.DRAG_ANIMATION_PLAY then
		var_52_10 = arg_52_0.actionTrigger.trigger_name

		if arg_52_0.actionTrigger.trigger_name == "idle" and arg_52_0.actionTrigger.trigger_index then
			var_1_10006 = arg_52_0.actionTrigger.trigger_index

			if 0 < var_1_10006 then
				var_52_10 = var_52_10 .. arg_52_0.actionTrigger.trigger_index
			end
		end

		iter_52_0 = arg_52_0.stateInfo

		if var_1_10006.IsName(iter_52_0, var_52_10) and arg_52_0.l2dIdleIndex == arg_52_0.actionTrigger.trigger_index then
			var_1_10006 = false

			if arg_52_0.actionTrigger.parameter_range then
				iter_52_0 = var_1_10007[1]
				var_1_10009 = var_1_10007[2]

				local var_52_11 = arg_52_0

				var_1_10010 = arg_52_0.onEventCallback
				Live2DPainting = var_1_10013

				var_1_10010(var_52_11, var_1_10013.EVENT_GET_PARAMETER, {
					name = iter_52_0
				}, function(arg_62_0)
					if arg_62_0 and arg_62_0 >= var_1_10009[1] and arg_62_0 < var_1_10009[2] then
						var_1_10006 = true
					end

					return
				end)
			else
				var_1_10006 = true
			end

			if var_1_10006 then
				iter_52_0 = arg_52_0.normalTime

				if arg_52_0.actionTrigger.trigger_rate <= iter_52_0 and not arg_52_0.animationPlayApply then
					var_1_10010 = arg_52_0
					iter_52_0 = arg_52_0.onEventCallback
					Live2DPainting = var_1_10011

					iter_52_0(var_1_10010, var_1_10011.EVENT_ACTION_APPLY, nil, function()
						return
					end)

					var_1_10010 = arg_52_0

					arg_52_0.setTriggerActionFlag(var_1_10010, false)

					arg_52_0.animationPlayApply = true
				end
			end
		elseif arg_52_0.animationPlayApply then
			arg_52_0.animationPlayApply = false
		end

		goto label_52_1
	end

	Live2DPainting = var_52_10

	if var_52_0 == var_52_10.DRAG_EXTEND_ACTION_RULE then
		if not arg_52_0.extendActionFlag then
			arg_52_0.extendActionFlag = true
		end

		goto label_52_1
	end

	Live2DPainting = var_5

	if var_52_0 == var_5.DRAG_WITH_PARAMETER_MOVE then
		if not arg_52_0.l2dIsPlaying then
			local var_52_12

			var_1_10006 = nil

			if var_52_3 then
				if var_52_3 then
					math = var_1_10007

					if not var_1_10007.abs(arg_52_0.parameterValue - var_52_3) then
						::label_52_0::

						var_52_12 = 0
					end

					math = var_1_10007
					var_1_10006 = var_1_10007.abs(var_52_3) * 0.1

					if var_52_3 and var_52_12 <= var_1_10006 and not arg_52_0.parameterMoveTrigger then
						arg_52_0.parameterMoveTrigger = true
						var_1_10009 = arg_52_0
						var_1_10007 = arg_52_0.onEventCallback
						Live2DPainting = var_1_10010

						var_1_10007(var_1_10009, var_1_10010.EVENT_ACTION_APPLY, nil, function(arg_64_0)
							return
						end)
					else
						if not arg_52_0.moveCheckStep then
							arg_52_0.moveCheckStep = 10
						end

						if arg_52_0.parameterMoveTrigger then
							arg_52_0.parameterMoveTrigger = false
							var_1_10009 = arg_52_0

							arg_52_0.setParameterValue(var_1_10009, arg_52_0.startValue)

							var_1_10009 = arg_52_0

							arg_52_0.setTargetValue(var_1_10009, arg_52_0.startValue)
						end

						arg_52_0.moveCheckStep = arg_52_0.moveCheckStep - 1

						if arg_52_0.moveCheckStep <= 0 then
							arg_52_0.moveCheckStep = 10
							var_1_10007 = arg_52_0.actionTrigger.parameter
							arg_52_0.lastParameterMove = arg_52_0.parameterMove

							local var_52_13 = arg_52_0

							iter_52_0 = arg_52_0.onEventCallback
							Live2DPainting = var_1_10011

							iter_52_0(var_52_13, var_1_10011.EVENT_GET_PARAMETER, {
								name = var_1_10007
							}, function(arg_65_0)
								arg_52_0.parameterMove = arg_65_0

								return
							end)

							if arg_52_0.lastParameterMove and arg_52_0.parameterMove then
								math = iter_52_0

								if iter_52_0.abs(arg_52_0.parameterMove - arg_52_0.lastParameterMove) ~= 0 then
									if not arg_52_0.actionTrigger.rate or not arg_52_0.actionTrigger.rate then
										var_1_10009 = 0
									end

									local var_52_14 = arg_52_0.parameterTargetValue + iter_52_0 * var_1_10009

									arg_52_0:setTargetValue(arg_52_0:fixParameterTargetValue(var_52_14, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect))

									print = var_11

									var_11("检测数值发生改变 = " .. arg_52_0.parameterTargetValue)
								end
							end
						end
					end

					goto label_52_1

					Live2DPainting = var_52_12

					do
						local var_52_15

						if var_52_0 == var_52_12.DRAG_MOVE_DOWN_UP then
							var_52_15 = arg_52_0.actionTrigger.range

							if arg_52_0._active and arg_52_0.actionTrigger.active == 1 then
								if not arg_52_0.dragMoveUp then
									var_1_10006 = arg_52_0.parameterValue

									if var_52_15[1] < var_1_10006 and arg_52_0.parameterValue <= var_52_15[2] then
										arg_52_0.dragMoveUp = true
										iter_52_0 = arg_52_0
										var_1_10006 = arg_52_0.onEventCallback
										Live2DPainting = var_1_10009

										var_1_10006(iter_52_0, var_1_10009.EVENT_ACTION_APPLY, nil, function(arg_66_0)
											return
										end)
									end
								end
							elseif arg_52_0.firstStop and arg_52_0.actionTrigger.active == 0 then
								iter_52_0 = arg_52_0
								var_1_10006 = arg_52_0.onEventCallback
								Live2DPainting = var_1_10009

								var_1_10006(iter_52_0, var_1_10009.EVENT_GET_PARAMETER, {
									name = arg_52_0.actionTrigger.parameter
								}, function(arg_67_0)
									if arg_67_0 > var_52_15[1] and arg_67_0 <= var_52_15[2] then
										local var_67_0 = arg_52_0
										local var_67_1 = var_1.onEventCallback

										Live2DPainting = var_2_10004

										var_67_1(var_67_0, var_2_10004.EVENT_ACTION_APPLY, nil, function(arg_68_0)
											return
										end)
									end

									return
								end)
							elseif arg_52_0._active == false and arg_52_0.dragMoveUp then
								arg_52_0.dragMoveUp = false
							end
						else
							Live2DPainting = var_52_15

							local var_52_16

							if var_52_0 == var_52_15.DRAG_GAME_XIAQI then
								var_1_10007 = arg_52_0

								if arg_52_0.checkClickAction(var_1_10007) then
									var_1_10007 = arg_52_0
									var_52_16 = arg_52_0.onEventCallback
									Live2DPainting = iter_52_0

									var_52_16(var_1_10007, iter_52_0.EVENT_GAME_XIAQI, {
										parameter_value = arg_52_0.parameterValue
									}, function(arg_69_0)
										if arg_69_0 and arg_69_0.target then
											print = var_1

											var_1(arg_52_0.parameterName .. " 设置数值 = " .. arg_69_0.target)

											local var_69_0 = arg_52_0

											var_1.setTargetValue(var_69_0, arg_69_0.target)
										end

										return
									end)
								end
							else
								Live2DPainting = var_52_16

								if var_52_0 == var_52_16.DRAG_GAME_XIAQI_RESULT and arg_52_0.commonData then
									local var_52_17 = arg_52_0.commonData

									Live2DPainting = var_1_10006

									if var_52_17[var_1_10006.COMMON_XIAQI_RESULT] ~= nil then
										local var_52_18 = arg_52_0.actionTrigger.win == 1 and true or false
										local var_52_19 = arg_52_0.commonData

										Live2DPainting = var_1_10007

										if var_52_18 == var_52_19[var_1_10007.COMMON_XIAQI_RESULT] then
											local var_52_20 = arg_52_0
											local var_52_21 = arg_52_0.onEventCallback

											Live2DPainting = var_1_10009

											var_52_21(var_52_20, var_1_10009.EVENT_ACTION_APPLY, nil, function(arg_70_0)
												if arg_70_0 then
													local var_70_0 = arg_52_0

													var_1.setTriggerActionFlag(var_70_0, false)

													local var_70_1 = arg_52_0
													local var_70_2 = var_1.setCommonData

													Live2DPainting = var_4

													var_70_2(var_70_1, var_4.COMMON_XIAQI_RESULT, nil)
												end

												return
											end)
										end
									end
								end
							end
						end
					end

					::label_52_1::

					return
				end
			end
		end
	end
end

function var_0_0.IsTouchAble(arg_71_0)
	return true
end

function var_0_0.setCommonData(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0.commonData[arg_72_1] = arg_72_2

	return
end

function var_0_0.getExtendAction(arg_73_0)
	return arg_73_0.extendActionFlag
end

function var_0_0.checkActionInExtendFlag(arg_74_0, arg_74_1)
	local var_74_0 = false
	local var_74_1 = false

	if not arg_74_0.extendActionFlag then
		return var_74_0, var_74_1
	end

	local var_74_2 = arg_74_0.actionTrigger.parameter
	local var_74_3 = arg_74_0.actionTrigger.num
	local var_74_4 = false
	local var_74_5 = arg_74_0
	local var_74_6 = arg_74_0.onEventCallback

	Live2DPainting = var_1_10010

	var_74_6(var_74_5, var_1_10010.EVENT_GET_DRAG_PARAMETER, {
		name = var_74_2
	}, function(arg_75_0)
		if arg_75_0 > var_74_3[1] and arg_75_0 <= var_74_3[2] then
			var_74_4 = true
		end

		return
	end)

	if not var_74_4 then
		return var_74_0, var_74_0
	end

	local var_74_7 = arg_74_0.actionTriggerActive.ignore
	local var_74_8 = arg_74_0.actionTriggerActive.enable

	if var_74_7 then
		table = var_74_5

		if var_74_5.contains(var_74_7, arg_74_1) then
			var_74_0 = true
		end
	end

	if var_74_8 then
		table = var_74_5

		if var_74_5.contains(var_74_8, arg_74_1) then
			var_74_1 = true
		end
	end

	return var_74_0, var_74_1
end

function var_0_0.setAbleWithFlag(arg_76_0, arg_76_1)
	if arg_76_0.ableFlag ~= arg_76_1 then
		arg_76_0.ableFlag = arg_76_1

		local var_76_0 = arg_76_0
		local var_76_1 = arg_76_0.onEventCallback

		Live2DPainting = var_1_10005

		var_76_1(var_76_0, var_1_10005.EVENT_ACTION_ABLE, {
			ableFlag = arg_76_1
		})
	end

	return
end

function var_0_0.triggerAction(arg_77_0)
	arg_77_0.nextTriggerTime = arg_77_0.limitTime

	arg_77_0:setTriggerActionFlag(true)

	return
end

function var_0_0.isActionTriggerAble(arg_78_0)
	if arg_78_0.actionTrigger.type == nil then
		return false
	end

	if not arg_78_0.actionTrigger or arg_78_0.actionTrigger == "" then
		return false
	end

	local var_78_0 = arg_78_0.nextTriggerTime

	Time = var_1_10002

	local var_78_1 = var_78_0 - var_1_10002.deltaTime

	if 0 <= var_78_1 then
		local var_78_2 = arg_78_0.nextTriggerTime

		Time = var_2
		arg_78_0.nextTriggerTime = var_78_2 - var_2.deltaTime

		return false
	end

	if arg_78_0.isTriggerAtion then
		return false
	end

	return true
end

function var_0_0.updateStateData(arg_79_0, arg_79_1)
	if arg_79_0.l2dIdleIndex ~= arg_79_1.idleIndex then
		type = var_2

		local var_79_0

		if var_2(arg_79_0.revertIdleIndex) == "boolean" and arg_79_0.revertIdleIndex == true then
			arg_79_0:setTargetValue(arg_79_0.startValue)

			var_79_0 = arg_79_0.startValue
			arg_79_0.offsetDragY = arg_79_0.startValue
			arg_79_0.offsetDragX = var_79_0
			var_79_0 = arg_79_0.startValue
			arg_79_0.offsetDragTargetY = arg_79_0.startValue
			arg_79_0.offsetDragTargetX = var_79_0
		else
			type = var_79_0

			if var_79_0(arg_79_0.revertIdleIndex) == "table" then
				table = var_2

				if var_2.contains(arg_79_0.revertIdleIndex, arg_79_1.idleIndex) then
					arg_79_0:setTargetValue(arg_79_0.startValue)

					arg_79_0.offsetDragTargetX, arg_79_0.offsetDragTargetY = arg_79_0.startValue, arg_79_0.startValue
					arg_79_0.offsetDragX, arg_79_0.offsetDragY = arg_79_0.startValue, arg_79_0.startValue
				end
			end
		end
	end

	arg_79_0.lastActionIndex = arg_79_0.actionListIndex

	if arg_79_1.isPlaying and arg_79_0.actionTrigger.reset_index_action and arg_79_1.actionName then
		table = var_2

		if var_2.contains(arg_79_0.actionTrigger.reset_index_action, arg_79_1.actionName) then
			arg_79_0.actionListIndex = 1
		end
	end

	if arg_79_0.revertActionIndex and arg_79_0.lastActionIndex ~= arg_79_0.actionListIndex then
		arg_79_0:setTargetValue(arg_79_0.startValue)
	end

	arg_79_0.l2dIdleIndex = arg_79_1.idleIndex
	arg_79_0.l2dIsPlaying = arg_79_1.isPlaying
	arg_79_0.l2dIgnoreReact = arg_79_1.ignoreReact
	arg_79_0.l2dPlayActionName = arg_79_1.actionName

	if not arg_79_0.l2dIsPlaying and arg_79_0.isTriggerAtion then
		arg_79_0:setTriggerActionFlag(false)
	end

	if arg_79_0.l2dIdleIndex and arg_79_0.idleOn and #arg_79_0.idleOn > 0 then
		table = var_2
		arg_79_0.reactConditionFlag = not var_2.contains(arg_79_0.idleOn, arg_79_0.l2dIdleIndex)
	end

	if arg_79_0.l2dIdleIndex and arg_79_0.idleOff and #arg_79_0.idleOff > 0 then
		table = var_2
		arg_79_0.reactConditionFlag = var_2.contains(arg_79_0.idleOff, arg_79_0.l2dIdleIndex)
	end

	return
end

function var_0_0.checkClickAction(arg_80_0)
	if arg_80_0.firstActive then
		if arg_80_0.actionTrigger.down then
			if arg_80_0.actionTrigger.focus == 1 and arg_80_0.l2dIsPlaying then
				return true
			elseif not arg_80_0.l2dIsPlaying then
				return true
			end
		else
			arg_80_0:setAbleWithFlag(true)
		end

		goto label_80_0
	end

	if arg_80_0.firstStop then
		math = var_1

		if var_1.abs(arg_80_0.mouseInputUp.x - arg_80_0.mouseInputDown.x) < 30 then
			math = var_1

			do
				local var_80_0

				if not (var_1.abs(arg_80_0.mouseInputUp.y - arg_80_0.mouseInputDown.y) < 30) then
					var_80_0 = false
				else
					var_80_0 = true
				end

				local var_80_1 = arg_80_0.mouseInputUpTime - arg_80_0.mouseInputDownTime < 0.5

				if not arg_80_0.actionTrigger.down and var_80_0 and var_80_1 then
					if arg_80_0.actionTrigger.focus == 1 and arg_80_0.l2dIsPlaying then
						if arg_80_0.l2dPlayActionName == arg_80_0.actionTrigger.action then
							Time = var_3
							arg_80_0.clickTriggerTime = var_3.realtimeSinceStartup + 0.1
						end
					elseif not arg_80_0.l2dIsPlaying then
						Time = var_3
						arg_80_0.clickTriggerTime = var_3.realtimeSinceStartup + 0.1
					end
				else
					arg_80_0:setAbleWithFlag(false)
				end

				if false then
					if arg_80_0.clickTriggerTime and arg_80_0.clickTriggerTime > 0 then
						Time = var_1

						if var_1.realtimeSinceStartup >= arg_80_0.clickTriggerTime then
							arg_80_0:setAbleWithFlag(false)

							Time = var_1

							if var_1.realtimeSinceStartup - arg_80_0.clickTriggerTime <= 0.1 then
								print = var_1

								var_1("点击成功" .. arg_80_0.id)

								arg_80_0.clickTriggerTime = nil

								return true
							end
						end
					end
				end
			end

			::label_80_0::

			return false
		end
	end
end

function var_0_0.saveData(arg_81_0)
	local var_81_0 = arg_81_0.id
	local var_81_1 = arg_81_0.live2dData.skinId
	local var_81_2 = arg_81_0.live2dData.ship.id

	if arg_81_0.revert == -1 and arg_81_0.saveParameterFlag then
		Live2dConst = var_4

		var_4.SaveDragData(var_81_0, var_81_1, var_81_2, arg_81_0.parameterTargetValue)
	end

	local var_81_3 = arg_81_0.actionTrigger.type

	Live2DPainting = var_1_10005

	if var_81_3 == var_1_10005.DRAG_CLICK_MANY then
		Live2dConst = var_81_3

		var_81_3.SetDragActionIndex(var_81_0, var_81_1, var_81_2, arg_81_0.actionListIndex)
	end

	if arg_81_0._relationFlag then
		Live2dConst = var_4

		var_4.SetRelationData(var_81_0, var_81_1, var_81_2, arg_81_0:getRelationSaveData())
	end

	return
end

function var_0_0.getActionTriggerType(arg_82_0)
	if arg_82_0.actionTrigger and arg_82_0.actionTrigger.type then
		return arg_82_0.actionTrigger.type
	end

	return nil
end

function var_0_0.loadData(arg_83_0)
	local var_83_0 = arg_83_0.id
	local var_83_1 = arg_83_0.live2dData
	local var_83_2 = var_2.GetShipSkinConfig(var_83_1).id
	local var_83_3 = arg_83_0.live2dData.ship.id

	if arg_83_0.revert == -1 and arg_83_0.saveParameterFlag then
		Live2dConst = var_4

		local var_83_4 = var_4.GetDragData
		local var_83_5 = arg_83_0.id
		local var_83_6 = arg_83_0.live2dData

		if var_83_4(var_83_5, var_7.GetShipSkinConfig(var_83_6).id, arg_83_0.live2dData.ship.id) then
			arg_83_0:setParameterValue(var_4)
			arg_83_0:setTargetValue(var_4)
		end

		if var_4 == arg_83_0.startValue and arg_83_0._relationParameterList and #arg_83_0._relationParameterList > 0 then
			arg_83_0:clearRelationValue()
		end
	end

	local var_83_7 = arg_83_0.actionTrigger.type

	Live2DPainting = var_1_10005

	if var_83_7 == var_1_10005.DRAG_CLICK_MANY then
		Live2dConst = var_83_7

		local var_83_8 = var_83_7.GetDragActionIndex
		local var_83_9 = arg_83_0.id
		local var_83_10 = arg_83_0.live2dData
		local var_83_11

		if not var_83_8(var_83_9, var_7.GetShipSkinConfig(var_83_10).id, arg_83_0.live2dData.ship.id) then
			var_83_11 = 1
		end

		arg_83_0.actionListIndex = var_83_11
	end

	if arg_83_0._relationFlag then
		Live2dConst = var_4

		local var_83_12

		if not var_4.GetRelationData(var_83_0, var_83_2, var_83_3).drag_x or not var_4.drag_x then
			var_83_12 = arg_83_0.startValue
		end

		arg_83_0.offsetDragX = var_83_12

		local var_83_13

		if not var_4.drag_y or not var_4.drag_y then
			var_83_13 = arg_83_0.startValue
		end

		arg_83_0.offsetDragY = var_83_13
	end

	return
end

function var_0_0.getRelationSaveData(arg_84_0)
	local var_84_0 = {}

	Live2dConst = var_1_10002
	var_84_0[var_1_10002.RELATION_DRAG_X] = arg_84_0.offsetDragX
	Live2dConst = var_2
	var_84_0[var_2.RELATION_DRAG_Y] = arg_84_0.offsetDragY

	return var_84_0
end

function var_0_0.clearRelationValue(arg_85_0)
	if arg_85_0._relationParameterList and #arg_85_0._relationParameterList > 0 then
		for iter_85_0 = 1, #arg_85_0._relationParameterList do
			local var_85_0 = arg_85_0._relationParameterList[iter_85_0].data.type

			Live2DPainting = var_1_10007

			if var_85_0 ~= var_1_10007.relation_type_drag_x then
				local var_85_1 = var_5.data.type

				Live2DPainting = var_1_10007

				if var_85_1 == var_1_10007.relation_type_drag_y then
					local var_85_2

					if not var_5.start and not arg_85_0.startValue then
						var_85_2 = 0
					end

					var_5.value = var_85_2
					var_5.enable = true
				end

				arg_85_0.offsetDragX, arg_85_0.offsetDragY = arg_85_0.startValue, arg_85_0.startValue
			end
		end
	end

	return
end

function var_0_0.loadL2dFinal(arg_86_0)
	arg_86_0.loadL2dStep = true

	return
end

function var_0_0.clearData(arg_87_0)
	if arg_87_0.revert == -1 then
		arg_87_0.actionListIndex = 1
		arg_87_0.delayTargetTime = nil

		arg_87_0:setParameterValue(arg_87_0.startValue)
		arg_87_0:setTargetValue(arg_87_0.startValue)
		arg_87_0:clearRelationValue()
	end

	return
end

function var_0_0.setTriggerActionFlag(arg_88_0, arg_88_1)
	arg_88_0.isTriggerAtion = arg_88_1

	return
end

function var_0_0.dispose(arg_89_0)
	arg_89_0._active = false
	arg_89_0._parameterCom = nil
	arg_89_0.parameterValue = arg_89_0.startValue
	arg_89_0.parameterTargetValue = 0
	arg_89_0.parameterSmooth = 0
	Vector2 = var_1
	arg_89_0.mouseInputDown = var_1(0, 0)
	arg_89_0.data = nil
	arg_89_0.live2dData = nil
	arg_89_0.commonData = nil

	return
end

return var_0_0
