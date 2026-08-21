local var_0_0 = class("Live2dDrag")
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
	arg_1_0.frameRate = Application.targetFrameRate or 60
	var_0_2 = {
		Live2DPainting.DRAG_DOWN_ACTION
	}
	arg_1_0.id = arg_1_1.id
	arg_1_0.drawAbleName = arg_1_1.draw_able_name or ""
	arg_1_0.parameterName = arg_1_1.parameter

	if arg_1_1.mode and arg_1_1.mode ~= 0 then
		arg_1_0.mode = arg_1_1.mode or 1
		arg_1_0.startValue = arg_1_1.start_value or 0

		if arg_1_1.range and arg_1_0.range ~= "" then
			arg_1_0.range = arg_1_1.range or {
				0,
				0
			}
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

			if arg_1_1.react_pos_x ~= 0 then
				arg_1_0.reactX = arg_1_1.react_pos_x or nil

				if arg_1_1.react_pos_y ~= 0 then
					arg_1_0.reactY = arg_1_1.react_pos_y or nil
					arg_1_0.actionTriggerActive = arg_1_1.action_trigger_active
					arg_1_0.relationParameter = arg_1_1.relation_parameter
					arg_1_0.relationParts = arg_1_0.relationParameter.parts

					if arg_1_1.limit_time > 0 then
						arg_1_0.limitTime = arg_1_1.limit_time or var_0_1
						arg_1_0.offsetCircle = arg_1_1.offset_circle or ""

						if arg_1_0.offsetCircle.pos then
							arg_1_0.offsetCirclePos = arg_1_0.offsetCircle.pos or nil

							if arg_1_0.offsetCircle.start then
								arg_1_0.offsetCircleStart = arg_1_0.offsetCircle.start or nil
								arg_1_0.listenerData = arg_1_1.listener_data
								arg_1_0.listenerType = arg_1_0.listenerData.type
								arg_1_0.listenerChange = arg_1_0.listenerData.change
								arg_1_0.listenerApply = arg_1_0.listenerData.apply

								if arg_1_1.react_condition and arg_1_1.react_condition ~= "" then
									arg_1_0.reactCondition = arg_1_1.react_condition or {}

									if arg_1_0.reactCondition.idle_on then
										arg_1_0.idleOn = arg_1_0.reactCondition.idle_on or {}

										if arg_1_0.reactCondition.idle_off then
											arg_1_0.idleOff = arg_1_0.reactCondition.idle_off or {}

											local var_1_0 = false

											if #arg_1_1.revert_idle_index > 0 then
												if type(arg_1_1.revert_idle_index) == "table" then
													var_1_0 = arg_1_1.revert_idle_index
												elseif tonumber(arg_1_1.revert_idle_index) and tonumber(arg_1_1.revert_idle_index) >= 0 then
													var_1_0 = tonumber(arg_1_1.revert_idle_index) == 1
												end
											end

											arg_1_0.revertIdleIndex = var_1_0
											arg_1_0.revertActionIndex = arg_1_1.revert_action_index == 1
											arg_1_0.saveParameterFlag = true

											if arg_1_1.save_parameter == -1 then
												arg_1_0.saveParameterFlag = false
											end

											arg_1_0.randomAttitudeIndex = L2D_RANDOM_PARAM
											arg_1_0._active = false
											arg_1_0._parameterCom = nil
											arg_1_0.parameterValue = arg_1_0.startValue
											arg_1_0.parameterStartValue = arg_1_0.startValue
											arg_1_0.parameterTargetValue = arg_1_0.startValue
											arg_1_0.parameterSmooth = 0
											arg_1_0.parameterSmoothTime = arg_1_0.smooth
											arg_1_0.mouseInputDown = Vector2(0, 0)
											arg_1_0.nextTriggerTime = 0
											arg_1_0.triggerActionTime = 0
											arg_1_0.sensitive = 4
											arg_1_0.l2dIdleIndex = 0
											arg_1_0.reactPos = Vector2(0, 0)
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
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.onListenerEvent(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:onListenerTrigger(arg_2_1, arg_2_2)

	if not arg_2_0.listenerType then
		return
	end

	if arg_2_0.listenerType == arg_2_1 then
		local var_2_6 = false

		if arg_2_0.listenerChange and #arg_2_0.listenerChange > 0 then
			local var_2_7 = arg_2_0:getChangeCheckName(arg_2_1, arg_2_2)

			if var_2_7 then
				for iter_2_0 = 1, #arg_2_0.listenerChange do
					local var_2_8 = arg_2_0.listenerChange[iter_2_0][1]
					local var_2_9 = arg_2_0.listenerChange[iter_2_0][2]
					local var_2_10 = arg_2_0.listenerChange[iter_2_0][3]

					if #arg_2_0.listenerChange[iter_2_0] >= 4 then
						local var_2_11 = arg_2_0.listenerChange[iter_2_0][4] or 1

						if table.contains(var_2_9, var_2_7) then
							local var_2_12

							if var_2_8 == var_0_6 then
								var_2_12 = arg_2_0.parameterTargetValue + var_2_10
							elseif var_2_8 == var_0_7 then
								var_2_12 = var_2_10
							end

							if var_2_12 then
								var_2_6 = true

								local var_2_13 = arg_2_0:fixParameterTargetValue(var_2_12, arg_2_0.range, arg_2_0.rangeAbs, arg_2_0.dragDirect)

								if arg_2_0.actionTrigger.change_focus == false then
									arg_2_0.prepareTargetValue = var_2_13

									print(arg_2_0.id .. "=" .. arg_2_0.parameterName .. "等待动作结束后的target赋值" .. arg_2_0.parameterTargetValue)
								else
									arg_2_0:setTargetValue(var_2_13)
									print(arg_2_0.id .. "=" .. arg_2_0.parameterName .. "监听 数值变更为" .. arg_2_0.parameterTargetValue)
								end
							end

							if var_2_11 and var_2_11 > 0 then
								var_2_6 = true
								arg_2_0.actionListIndex = var_2_11
							end
						end
					end
				end
			end
		end

		if arg_2_0.listenerApply and #arg_2_0.listenerApply > 0 then
			if arg_2_0.listenerApply[1] == var_0_8 and var_2_6 then
				local var_2_14 = arg_2_0.parameterTargetValue

				if arg_2_0.prepareTargetValue ~= nil then
					var_2_14 = arg_2_0.prepareTargetValue
				end

				local var_2_15

				for iter_2_1 = 1, #arg_2_0.listenerApply[2] do
					if var_2_14 >= arg_2_0.listenerApply[2][iter_2_1][1] and var_2_14 < arg_2_0.listenerApply[2][iter_2_1][2] then
						var_2_15 = arg_2_0.listenerApply[2][iter_2_1][3]
					end
				end

				if var_2_15 and arg_2_0.l2dIdleIndex ~= var_2_15 then
					arg_2_0:onEventCallback(Live2DPainting.EVENT_CHANGE_IDLE_INDEX, {
						id = arg_2_0.id,
						idle = var_2_15,
						activeData = arg_2_0.actionTriggerActive
					})
				end
			end
		end
	end

	return
end

function var_0_0.onListenerTrigger(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == Live2DPainting.ON_ACTION_DRAG_CLICK then
		if arg_3_0.actionTrigger.click_cd and table.contains(arg_3_0.actionTrigger.click_cd, arg_3_2.draw_able_name) then
			arg_3_0.nextTriggerTime = arg_3_0.limitTime
		end

		goto label_3_0
	end

	::label_3_0::

	if arg_3_1 == Live2DPainting.ON_ACTION_PLAY then
		if arg_3_0.limitTime <= 0.2 then
			arg_3_0.nextTriggerTime = arg_3_0.limitTime or 0.2

			return
		end
	end
end

function var_0_0.getChangeCheckName(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == Live2DPainting.ON_ACTION_PLAY then
		return arg_4_2.action
	elseif arg_4_1 == Live2DPainting.ON_ACTION_DRAG_CLICK then
		return arg_4_2.draw_able_name
	elseif arg_4_1 == Live2DPainting.ON_ACTION_CHANGE_IDLE then
		return arg_4_2.idle
	elseif arg_4_1 == Live2DPainting.ON_ACTION_PARAMETER then
		-- block empty
	elseif arg_4_1 == Live2DPainting.ON_ACTION_DOWN then
		-- block empty
	elseif arg_4_1 == Live2DPainting.ON_ACTION_XY_TRIGGER then
		-- block empty
	elseif arg_4_1 == Live2DPainting.ON_ACTION_DRAG_TRIGGER then
		-- block empty
	end

	return nil
end

function var_0_0.startDrag(arg_5_0, arg_5_1)
	if arg_5_0.ignoreAction and arg_5_0.l2dIsPlaying then
		return
	end

	print(arg_5_0.drawAbleName .. " 按下了 id = " .. arg_5_0.id)

	if not arg_5_0._active then
		arg_5_0._active = true
		arg_5_0.mouseInputDown = Input.mousePosition
		arg_5_0.mouseInputDownTime = Time.time
		arg_5_0.triggerActionTime = 0

		if table.contains(var_0_2, arg_5_0.actionTrigger.type) then
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

		arg_6_0.mouseInputUp = Input.mousePosition
		arg_6_0.mouseInputUpTime = Time.time
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

	if arg_9_0.actionTrigger.type == Live2DPainting.DRAG_DOWN_ACTION and arg_9_0.actionTrigger.last then
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
	if type(arg_11_0.partsData) == "table" then
		local var_11_0 = arg_11_0.partsData.parts
		local var_11_1 = arg_11_0.partsData.type
		local var_11_2 = false

		if arg_11_0.offsetX or arg_11_0.offsetY then
			var_11_2 = true
		elseif arg_11_0.actionTrigger and arg_11_0.actionTrigger.type == Live2DPainting.DRAG_DOWN_TOUCH then
			var_11_2 = true
		elseif arg_11_0.offsetCirclePos then
			var_11_2 = true
		end

		if var_11_2 then
			local var_11_3
			local var_11_4

			for iter_11_0 = 1, #var_11_0 do
				local var_11_5 = math.abs(arg_11_0.parameterTargetValue - var_11_0[iter_11_0])

				if var_11_1 == var_0_3 or not var_11_1 then
					if not var_11_3 or var_11_5 < var_11_3 then
						var_11_3 = var_11_5
						var_11_4 = iter_11_0
					end
				elseif var_11_1 == var_0_4 then
					if var_11_0[iter_11_0] <= arg_11_0.parameterTargetValue and (not var_11_3 or var_11_5 < var_11_3) then
						var_11_3 = var_11_5
						var_11_4 = iter_11_0
					end
				elseif var_11_1 == var_0_5 and arg_11_0.parameterTargetValue <= var_11_0[iter_11_0] and (not var_11_3 or var_11_5 < var_11_3) then
					var_11_3 = var_11_5
					var_11_4 = iter_11_0
				end
			end

			if var_11_4 then
				if math.abs(arg_11_0.parameterTargetValue - var_11_0[var_11_4]) >= 0.05 then
					print("吸附数值" .. var_11_0[var_11_4])
				end

				if arg_11_0.offsetDragTargetX then
					arg_11_0.offsetDragTargetX = var_11_0[var_11_4]
				end

				if arg_11_0.offsetDragTargetY then
					arg_11_0.offsetDragTargetY = var_11_0[var_11_4]
				end

				arg_11_0:setTargetValue(var_11_0[var_11_4])
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
	table.insert(arg_16_0._relationParameterList, {
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
	if arg_22_1 == Live2DPainting.EVENT_ACTION_APPLY then
		local var_22_0 = {}
		local var_22_1
		local var_22_2 = false
		local var_22_3
		local var_22_4
		local var_22_6 = false

		if arg_22_0.actionTrigger.action then
			var_22_1 = arg_22_0:fillterAction(arg_22_0.actionTrigger.action)
			var_22_0 = arg_22_0.actionTriggerActive
			var_22_2 = arg_22_0.actionTrigger.focus == 1
			var_22_3 = arg_22_0.actionTrigger.target or nil
			var_22_6 = arg_22_0.actionTrigger.target_focus == 1

			if arg_22_0.actionTrigger.circle ~= nil and var_22_3 and var_22_3 == arg_22_0.parameterTargetValue then
				var_22_3 = arg_22_0.startValue
			end

			var_22_4 = arg_22_0.actionTrigger.react or nil

			arg_22_0:triggerAction()
			var_22_7()
		elseif arg_22_0.actionTrigger.action_list then
			local var_22_8 = arg_22_0.actionTrigger.action_list[arg_22_0.actionListIndex]

			var_22_1 = arg_22_0:fillterAction(arg_22_0.actionTrigger.action_list[arg_22_0.actionListIndex].action)
			var_22_0 = arg_22_0.actionTriggerActive.active_list and arg_22_0.actionListIndex <= #arg_22_0.actionTriggerActive.active_list and arg_22_0.actionTriggerActive.active_list[arg_22_0.actionListIndex] or arg_22_0.actionTriggerActive
			var_22_2 = var_22_8.focus == 1

			if not var_22_2 and arg_22_0.actionTrigger.focus then
				var_22_2 = arg_22_0.actionTrigger.focus == 1
			end

			var_22_3 = var_22_8.target or nil
			var_22_6 = var_22_8.target_focus == 1
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

			print("id = " .. arg_22_0.id .. " action list index = " .. arg_22_0.actionListIndex)
		elseif not arg_22_0.actionTrigger.action then
			var_22_1 = arg_22_0:fillterAction(arg_22_0.actionTrigger.action)
			var_22_0 = arg_22_0.actionTriggerActive
			var_22_2 = arg_22_0.actionTrigger.focus == 1
			var_22_3 = arg_22_0.actionTrigger.target or nil
			var_22_6 = arg_22_0.actionTrigger.target_focus == 1

			local var_22_9 = arg_22_0.actionTrigger.circle ~= nil

			var_22_4 = arg_22_0.actionTrigger.react or nil

			if var_22_9 and var_22_3 and var_22_3 == arg_22_0.parameterTargetValue then
				var_22_3 = arg_22_0.startValue
			end

			arg_22_0:triggerAction()
			arg_22_0:setTriggerActionFlag(false)
			var_22_7()
		end

		if var_22_0.idle then
			if type(var_22_0.idle) == "number" then
				if var_22_0.idle == arg_22_0.l2dIdleIndex and not var_22_0.repeat_flag then
					return
				end
			elseif type(var_22_0.idle) == "table" and #var_22_0.idle == 1 and var_22_0.idle[1] == arg_22_0.l2dIdleIndex and not var_22_0.repeat_flag then
				return
			end
		end

		print("执行aplly数据 id = " .. arg_22_0.id .. "播放action = " .. tostring(var_22_1) .. " active idle is " .. tostring(var_22_0.idle))

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
				arg_22_0:actionApplyFinish()

				return
			end
		}
	elseif arg_22_1 == Live2DPainting.EVENT_ACTION_ABLE then
		-- block empty
	elseif arg_22_1 == Live2DPainting.EVENT_CHANGE_IDLE_INDEX then
		print("change idle")
	elseif arg_22_1 == Live2DPainting.EVENT_GET_PARAMETER then
		arg_22_2.callback = arg_22_3
	elseif arg_22_1 == Live2DPainting.EVENT_GET_DRAG_PARAMETER then
		arg_22_2.callback = arg_22_3
	elseif arg_22_1 == Live2DPainting.EVENT_GET_WORLD_POSITION then
		arg_22_2.callback = arg_22_3
	elseif arg_22_1 == Live2DPainting.EVENT_GAME_XIAQI then
		arg_22_2.callback = arg_22_3
	end

	arg_22_0._eventCallback(arg_22_1, arg_22_2)

	return
end

function var_0_0.isApplyStopDrag(arg_25_0)
	if arg_25_0.actionTrigger and arg_25_0.actionTrigger.type == Live2DPainting.DRAG_MOVE_DOWN_UP then
		return false
	end

	return true
end

function var_0_0.fillterAction(arg_26_0, arg_26_1)
	if type(arg_26_1) == "table" then
		return arg_26_1[math.random(1, #arg_26_1)]
	else
		return arg_26_1
	end

	return
end

function var_0_0.onEventNotice(arg_27_0, arg_27_1)
	if arg_27_0._eventCallback then
		arg_27_0._eventCallback(arg_27_1, (arg_27_0:getCommonNoticeData()))
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
	if arg_37_0.actionTrigger.type == Live2DPainting.DRAG_CLICK_ACTION then
		arg_37_0._parameterUpdateFlag = true
	elseif arg_37_0.actionTrigger.type == Live2DPainting.DRAG_RELATION_IDLE then
		if not arg_37_0._parameterUpdateFlag then
			if not arg_37_0.l2dIsPlaying then
				arg_37_0._parameterUpdateFlag = true

				arg_37_0:changeParameComAble(true)
			elseif not table.contains(arg_37_0.actionTrigger.remove_com_list, arg_37_0.l2dPlayActionName) then
				arg_37_0._parameterUpdateFlag = true

				arg_37_0:changeParameComAble(true)
			end
		elseif arg_37_0._parameterUpdateFlag == true and arg_37_0.l2dIsPlaying and table.contains(arg_37_0.actionTrigger.remove_com_list, arg_37_0.l2dPlayActionName) then
			arg_37_0._parameterUpdateFlag = false

			arg_37_0:changeParameComAble(false)
		end
	else
		arg_37_0._parameterUpdateFlag = arg_37_0.actionTrigger.type == Live2DPainting.DRAG_DOWN_TOUCH and true or arg_37_0.actionTrigger.type == Live2DPainting.DRAG_LISTENER_EVENT and true or arg_37_0.actionTrigger.type == Live2DPainting.DRAG_ANIMATION_PLAY and true or arg_37_0.actionTrigger.type == Live2DPainting.DRAG_WITH_PARAMETER_MOVE and true or arg_37_0.actionTrigger.type == Live2DPainting.DRAG_MOVE_DOWN_UP and true or arg_37_0.actionTrigger.type == Live2DPainting.DRAG_GAME_XIAQI
	end

	return
end

function var_0_0.changeParameComAble(arg_38_0, arg_38_1)
	if arg_38_0.parameterComAdd == arg_38_1 then
		return
	end

	arg_38_0.parameterComAdd = arg_38_1

	if arg_38_1 then
		arg_38_0:onEventCallback(Live2DPainting.EVENT_ADD_PARAMETER_COM, {
			com = arg_38_0._parameterCom,
			start = arg_38_0.startValue,
			mode = arg_38_0.mode
		})
	else
		arg_38_0:onEventCallback(Live2DPainting.EVENT_REMOVE_PARAMETER_COM, {
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
		if arg_39_0.offsetX and arg_39_0.offsetX ~= 0 then
			var_39_0 = arg_39_0.offsetDragTargetX + (Input.mousePosition.x - arg_39_0.mouseInputDown.x) / arg_39_0.offsetX
			arg_39_0.offsetDragX = arg_39_0.offsetDragTargetX + (Input.mousePosition.x - arg_39_0.mouseInputDown.x) / arg_39_0.offsetX
		end

		if arg_39_0.offsetY and arg_39_0.offsetY ~= 0 then
			var_39_0 = arg_39_0.offsetDragTargetY + (Input.mousePosition.y - arg_39_0.mouseInputDown.y) / arg_39_0.offsetY
			arg_39_0.offsetDragY = arg_39_0.offsetDragTargetY + (Input.mousePosition.y - arg_39_0.mouseInputDown.y) / arg_39_0.offsetY
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
		if not arg_40_0.circleDragWorld then
			arg_40_0:onEventCallback(Live2DPainting.EVENT_GET_WORLD_POSITION, {
				pos = arg_40_0.offsetCirclePos,
				name = arg_40_0.drawAbleName
			}, function(arg_41_0)
				arg_40_0.circleDragWorld = arg_41_0

				return
			end)
		end

		arg_40_0:setTargetValue(arg_40_0.range[2] * ((math.atan2(arg_40_0.mouseWorld.x - arg_40_0.circleDragWorld.x, arg_40_0.mouseWorld.y - arg_40_0.circleDragWorld.y) * math.rad2Deg + 360 - arg_40_0.offsetCircleStart) % 360 / 360))

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

	if not Input.gyro.enabled then
		arg_42_0:setTargetValue(0)

		arg_42_0._parameterUpdateFlag = true

		return
	end

	if Input.gyro then
		local var_42_0 = Input.gyro.attitude or Vector3.zero
		local var_42_1 = 0

		if arg_42_0.gyroX and not math.isnan(var_42_0.y) then
			var_42_1 = Mathf.Clamp(var_42_0.y * arg_42_0.sensitive, -0.5, 0.5)
		elseif arg_42_0.gyroY and not math.isnan(var_42_0.x) then
			var_42_1 = Mathf.Clamp(var_42_0.x * arg_42_0.sensitive, -0.5, 0.5)
		elseif arg_42_0.gyroZ and not math.isnan(var_42_0.z) then
			var_42_1 = Mathf.Clamp(var_42_0.z * arg_42_0.sensitive, -0.5, 0.5)
		end

		if IsUnityEditor then
			if L2D_USE_RANDOM_ATTI then
				if arg_42_0.randomAttitudeIndex == 0 then
					var_42_1 = math.random() - 0.5

					arg_42_0:setTargetValue((var_42_1 + 0.5) * (arg_42_0.range[2] - arg_42_0.range[1]) + arg_42_0.range[1])

					arg_42_0.randomAttitudeIndex = L2D_RANDOM_PARAM
				elseif arg_42_0.randomAttitudeIndex > 0 then
					arg_42_0.randomAttitudeIndex = arg_42_0.randomAttitudeIndex - 1
				end
			end
		else
			arg_42_0:setTargetValue((var_42_1 + 0.5) * (arg_42_0.range[2] - arg_42_0.range[1]) + arg_42_0.range[1])
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
	if arg_44_0.delayTargetTime and arg_44_0.delayTargetTime > 0 then
		arg_44_0.delayTargetTime = arg_44_0.delayTargetTime - Time.deltaTime

		if arg_44_0.delayTargetTime <= 0 then
			arg_44_0.delayTargetTime = nil
		end

		return
	end

	if arg_44_0.prepareTargetValue and not arg_44_0.l2dIsPlaying then
		arg_44_0:setTargetValue(arg_44_0.prepareTargetValue)

		arg_44_0.prepareTargetValue = nil
	end

	if arg_44_0._parameterUpdateFlag and arg_44_0.parameterValue ~= arg_44_0.parameterTargetValue then
		if math.abs(arg_44_0.parameterValue - arg_44_0.parameterTargetValue) < 0.05 then
			arg_44_0:setParameterValue(arg_44_0.parameterTargetValue)
		elseif arg_44_0.parameterSmoothTime and arg_44_0.parameterSmoothTime > 0 then
			local var_44_0, var_44_1 = Live2DExtend.CustomSmoothValue(arg_44_0.parameterStartValue, arg_44_0:checkUpdateParameterNum(arg_44_0.parameterTargetValue, arg_44_0.parameterValue), arg_44_0.parameterSmoothTime, arg_44_0.parameterSmooth, Time.fixedDeltaTime)

			arg_44_0:setParameterValue(var_44_0, var_44_1)
		else
			arg_44_0:setParameterValue(arg_44_0.parameterTargetValue, 0)
		end
	end

	return
end

function var_0_0.checkUpdateParameterNum(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.offsetCirclePos and math.abs(arg_45_1 - arg_45_2) >= arg_45_0.rangeOffset / 2 then
		arg_45_1 = arg_45_2 < arg_45_1 and arg_45_1 - arg_45_0.rangeOffset or arg_45_1 + arg_45_0.rangeOffset
	end

	return arg_45_1
end

function var_0_0.updateRelationValue(arg_46_0)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0._relationParameterList) do
		local var_46_0 = iter_46_1.data
		local var_46_1 = iter_46_1.data.target
		local var_46_2
		local var_46_3

		if iter_46_1.data.type == Live2DPainting.relation_type_drag_x then
			var_46_2 = arg_46_0.offsetDragX or iter_46_1.start or arg_46_0.startValue or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_drag_y then
			var_46_2 = arg_46_0.offsetDragY or iter_46_1.start or arg_46_0.startValue or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_action_index then
			var_46_2 = iter_46_1.data.relation_value[arg_46_0.actionListIndex] or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_idle then
			if arg_46_0.loadL2dStep and arg_46_0.l2dIdleIndex == var_46_0.idle then
				var_46_3 = true
			end

			if arg_46_0.l2dIsPlaying then
				if arg_46_0.l2dPlayActionName == arg_46_0.actionTrigger.action then
					arg_46_0.relationActive = true
				end
			else
				arg_46_0.relationActive = false
				arg_46_0.relationCountTime = nil
			end

			if not var_46_3 and arg_46_0.relationActive and arg_46_0.l2dIdleIndex == var_46_0.idle then
				arg_46_0.relationCountTime = arg_46_0.relationCountTime or Time.GetTimestamp() + var_46_0.time

				if arg_46_0.relationCountTime and Time.GetTimestamp() >= arg_46_0.relationCountTime then
					var_46_3 = true
				end
			end
		else
			var_46_2 = arg_46_0.parameterTargetValue
			var_46_3 = false
		end

		local var_46_4
		local var_46_5
		local var_46_6 = arg_46_0:fixRelationParameter(var_46_2, var_46_0)
		local var_46_7 = iter_46_1.value or arg_46_0.startValue
		local var_46_8 = iter_46_1.parameterSmooth or 0

		if var_46_1 then
			var_46_4 = var_46_1

			goto label_46_0
		end

		if math.abs(var_46_6 - var_46_7) <= 0.01 then
			var_46_4 = var_46_6

			goto label_46_0
		end

		::label_46_0::

		if var_46_0.smooth then
			do
				local var_46_9 = var_46_0.smooth / 1000 or arg_46_0.smooth

				var_46_4, var_46_5 = Mathf.SmoothDamp(var_46_7, var_46_6, var_46_8, var_46_9)
			end

			iter_46_1.target = var_46_2
			iter_46_1.value = var_46_4
			iter_46_1.parameterSmooth = var_46_5
			iter_46_1.enable = var_46_3
			iter_46_1.comId = arg_46_0.id
		end
	end

	return
end

function var_0_0.fixRelationParameter(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2.range or arg_47_0.range
	local var_47_1 = arg_47_2.rangeAbs and arg_47_2.rangeAbs == 1 or arg_47_0.rangeAbs

	if arg_47_2.drag_direct then
		local var_47_2 = arg_47_2.drag_direct or arg_47_0.dragDirect

		return arg_47_0:fixParameterTargetValue(arg_47_1, var_47_0, var_47_1, var_47_2)
	end
end

function var_0_0.fixParameterTargetValue(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	if arg_48_1 < 0 and arg_48_4 == 1 then
		arg_48_1 = 0
	elseif arg_48_1 > 0 and arg_48_4 == 2 then
		arg_48_1 = 0
	end

	arg_48_1 = arg_48_3 and math.abs(arg_48_1) or arg_48_1

	if arg_48_1 < arg_48_2[1] then
		arg_48_1 = arg_48_2[1]
	elseif arg_48_1 > arg_48_2[2] then
		arg_48_1 = arg_48_2[2]
	end

	return arg_48_1
end

function var_0_0.checkReset(arg_49_0)
	if not arg_49_0._active and arg_49_0.parameterToStart then
		if arg_49_0.parameterToStart > 0 then
			arg_49_0.parameterToStart = arg_49_0.parameterToStart - Time.deltaTime
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
	arg_51_0.firstActive = not not (not arg_51_0.lastFrameActive and arg_51_0._active)
	arg_51_0.firstStop = not not (arg_51_0.lastFrameActive and not arg_51_0._active)
	arg_51_0.lastFrameActive = arg_51_0._active

	return
end

function var_0_0.updateTrigger(arg_52_0)
	if not arg_52_0:isActionTriggerAble() then
		return
	end

	local var_52_0 = arg_52_0.actionTrigger.type
	local var_52_2

	if arg_52_0.actionTrigger.time then
		var_52_2 = arg_52_0.actionTrigger.time
	elseif arg_52_0.actionTrigger.action_list and arg_52_0.actionListIndex > 0 then
		var_52_2 = arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].time
	end

	local var_52_3

	if arg_52_0.actionTrigger.num then
		var_52_3 = arg_52_0.actionTrigger.num
	elseif arg_52_0.actionTrigger.action_list and arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].num and arg_52_0.actionListIndex > 0 then
		var_52_3 = arg_52_0.actionTrigger.action_list[arg_52_0.actionListIndex].num
	end

	if var_52_0 == Live2DPainting.DRAG_TIME_ACTION then
		if arg_52_0._active then
			if var_52_3 and math.abs(arg_52_0.parameterValue - var_52_3) < math.abs(var_52_3) * 0.25 then
				arg_52_0.triggerActionTime = arg_52_0.triggerActionTime + Time.deltaTime

				if var_52_2 < arg_52_0.triggerActionTime and not arg_52_0.l2dIsPlaying then
					arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_53_0)
						if arg_53_0 then
							arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_DRAG_TRIGGER)
						end

						return
					end)
				end
			else
				print("配置id = " .. arg_52_0.id .. " 缺少参数 num")
			end
		end

		goto label_52_0
	end

	if var_52_0 == Live2DPainting.DRAG_CLICK_ACTION then
		if arg_52_0:checkClickAction() then
			arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_54_0)
				arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

				return
			end)
		end

		goto label_52_0
	end

	::label_52_0::

	if var_52_0 == Live2DPainting.DRAG_CLICK_RANGE then
		if arg_52_0:checkClickAction() then
			if arg_52_0.actionTrigger.parameter then
				local var_52_4 = arg_52_0.actionTrigger.parameter or arg_52_0.parameterName
				local var_52_5 = var_52_3

				arg_52_0:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
					name = var_52_4
				}, function(arg_55_0)
					print("获取到数值 " .. var_52_4 .. " = " .. arg_55_0, "匹配范围 = " .. var_52_5[1] .. " - " .. var_52_5[2])

					if arg_55_0 >= var_52_5[1] and arg_55_0 < var_52_5[2] then
						print("数值范围内，开始触发动作  = " .. tostring(arg_52_0.id))
						arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_56_0)
							arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

							return
						end)
					end

					return
				end)

				goto label_52_0

				if var_52_0 == Live2DPainting.DRAG_DOWN_ACTION then
					if arg_52_0._active then
						arg_52_0:setAbleWithFlag(true)

						if var_52_2 <= Time.time - arg_52_0.mouseInputDownTime and not arg_52_0.l2dIsPlaying then
							print("触发按压动作")
							arg_52_0:setAbleWithFlag(false)
							arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_57_0)
								if arg_57_0 then
									arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_DOWN)
								end

								return
							end)

							if arg_52_0.actionListIndex ~= 1 then
								arg_52_0:setTriggerActionFlag(false)
							end

							arg_52_0:setAbleWithFlag(true)

							arg_52_0.mouseInputDownTime = Time.time
						end
					elseif arg_52_0.actionTrigger.last and arg_52_0.actionListIndex ~= 1 then
						arg_52_0.actionListIndex = #arg_52_0.actionTrigger.action_list

						arg_52_0:setAbleWithFlag(false)
						arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_58_0)
							return
						end)
						arg_52_0:resetNextTriggerTime()
						arg_52_0:setTriggerActionFlag(false)
					else
						arg_52_0:setAbleWithFlag(false)
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_RELATION_XY then
					if arg_52_0._active then
						if math.abs(arg_52_0:fixParameterTargetValue(arg_52_0.offsetDragX, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect) - var_52_3[1]) <= math.abs(var_52_3[1]) * 0.25 and math.abs(arg_52_0:fixParameterTargetValue(arg_52_0.offsetDragY, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect) - var_52_3[2]) <= math.abs(var_52_3[2]) * 0.25 then
							arg_52_0.triggerActionTime = arg_52_0.triggerActionTime + Time.deltaTime

							if var_52_2 < arg_52_0.triggerActionTime and not arg_52_0.l2dIsPlaying then
								arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_59_0)
									if arg_59_0 then
										arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_XY_TRIGGER)
									end

									return
								end)
							end
						else
							arg_52_0.triggerActionTime = arg_52_0.triggerActionTime + 0
						end
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_RELATION_IDLE then
					if arg_52_0.actionTrigger.const_fit then
						for iter_52_0 = 1, #arg_52_0.actionTrigger.const_fit do
							if arg_52_0.l2dIdleIndex == arg_52_0.actionTrigger.const_fit[iter_52_0].idle and not arg_52_0.l2dIsPlaying then
								arg_52_0:setTargetValue(arg_52_0.actionTrigger.const_fit[iter_52_0].target)
							end
						end
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_CLICK_MANY then
					if arg_52_0:checkClickAction() then
						arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY)
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_LISTENER_EVENT then
					if arg_52_0._listenerTrigger then
						arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY)
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_DOWN_TOUCH then
					arg_52_0:setAbleWithFlag(arg_52_0._active)

					if arg_52_0._active then
						arg_52_0:setTargetValue((arg_52_0:fixParameterTargetValue(arg_52_0.parameterTargetValue + Time.deltaTime / arg_52_0.actionTrigger.delta, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect)))
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_CLICK_PARAMETER then
					if arg_52_0:checkClickAction() then
						local var_52_6 = var_52_3

						arg_52_0:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
							name = arg_52_0.actionTrigger.parameter
						}, function(arg_60_0)
							if math.abs(var_52_6 - arg_60_0) <= 0.05 then
								print("数值允许播放，开始执行动作 " .. arg_52_0.actionTrigger.action)
								arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_61_0)
									arg_52_0:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

									return
								end)
							end

							return
						end)
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_ANIMATION_PLAY then
					local var_52_7 = arg_52_0.actionTrigger.trigger_name

					if arg_52_0.actionTrigger.trigger_name == "idle" and arg_52_0.actionTrigger.trigger_index and arg_52_0.actionTrigger.trigger_index > 0 then
						var_52_7 = var_52_7 .. arg_52_0.actionTrigger.trigger_index
					end

					if arg_52_0.stateInfo:IsName(var_52_7) and arg_52_0.l2dIdleIndex == arg_52_0.actionTrigger.trigger_index then
						local var_52_8 = false

						if arg_52_0.actionTrigger.parameter_range then
							local var_52_9 = arg_52_0.actionTrigger.parameter_range[2]

							arg_52_0:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
								name = arg_52_0.actionTrigger.parameter_range[1]
							}, function(arg_62_0)
								if arg_62_0 and arg_62_0 >= var_52_9[1] and arg_62_0 < var_52_9[2] then
									var_52_8 = true
								end

								return
							end)
						else
							var_52_8 = true
						end

						if var_52_8 and arg_52_0.normalTime >= arg_52_0.actionTrigger.trigger_rate and not arg_52_0.animationPlayApply then
							arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function()
								return
							end)
							arg_52_0:setTriggerActionFlag(false)

							arg_52_0.animationPlayApply = true
						end
					elseif arg_52_0.animationPlayApply then
						arg_52_0.animationPlayApply = false
					end

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_EXTEND_ACTION_RULE then
					arg_52_0.extendActionFlag = arg_52_0.extendActionFlag or true

					goto label_52_0
				end

				if var_52_0 == Live2DPainting.DRAG_WITH_PARAMETER_MOVE then
					if not arg_52_0.l2dIsPlaying then
						local var_52_10
						local var_52_11

						if var_52_3 then
							var_52_10 = var_52_3 and math.abs(arg_52_0.parameterValue - var_52_3) or 0
							var_52_11 = math.abs(var_52_3) * 0.1
						end

						if var_52_3 and var_52_10 <= var_52_11 and not arg_52_0.parameterMoveTrigger then
							arg_52_0.parameterMoveTrigger = true

							arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_64_0)
								return
							end)

							goto label_52_0
						end

						arg_52_0.moveCheckStep = arg_52_0.moveCheckStep or 10

						if arg_52_0.parameterMoveTrigger then
							arg_52_0.parameterMoveTrigger = false

							arg_52_0:setParameterValue(arg_52_0.startValue)
							arg_52_0:setTargetValue(arg_52_0.startValue)
						end

						arg_52_0.moveCheckStep = arg_52_0.moveCheckStep - 1

						if arg_52_0.moveCheckStep <= 0 then
							arg_52_0.moveCheckStep = 10
							arg_52_0.lastParameterMove = arg_52_0.parameterMove

							arg_52_0:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
								name = arg_52_0.actionTrigger.parameter
							}, function(arg_65_0)
								arg_52_0.parameterMove = arg_65_0

								return
							end)

							if arg_52_0.lastParameterMove and arg_52_0.parameterMove then
								local var_52_12 = math.abs(arg_52_0.parameterMove - arg_52_0.lastParameterMove)

								if var_52_12 ~= 0 then
									if arg_52_0.actionTrigger.rate then
										do
											arg_52_0:setTargetValue(arg_52_0:fixParameterTargetValue(arg_52_0.parameterTargetValue + var_52_12 * var_52_13, arg_52_0.range, arg_52_0.rangeAbs, arg_52_0.dragDirect))
											print("检测数值发生改变 = " .. arg_52_0.parameterTargetValue)

											goto label_52_0

											if var_52_0 == Live2DPainting.DRAG_MOVE_DOWN_UP then
												local var_52_14 = arg_52_0.actionTrigger.range

												if arg_52_0._active and arg_52_0.actionTrigger.active == 1 then
													if not arg_52_0.dragMoveUp and arg_52_0.parameterValue > arg_52_0.actionTrigger.range[1] and arg_52_0.parameterValue <= arg_52_0.actionTrigger.range[2] then
														arg_52_0.dragMoveUp = true

														arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_66_0)
															return
														end)
													end
												elseif arg_52_0.firstStop and arg_52_0.actionTrigger.active == 0 then
													arg_52_0:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
														name = arg_52_0.actionTrigger.parameter
													}, function(arg_67_0)
														if arg_67_0 > var_52_14[1] and arg_67_0 <= var_52_14[2] then
															arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_68_0)
																return
															end)
														end

														return
													end)
												elseif arg_52_0._active == false and arg_52_0.dragMoveUp then
													arg_52_0.dragMoveUp = false
												end
											elseif var_52_0 == Live2DPainting.DRAG_GAME_XIAQI then
												if arg_52_0:checkClickAction() then
													arg_52_0:onEventCallback(Live2DPainting.EVENT_GAME_XIAQI, {
														parameter_value = arg_52_0.parameterValue
													}, function(arg_69_0)
														if arg_69_0 and arg_69_0.target then
															print(arg_52_0.parameterName .. " 设置数值 = " .. arg_69_0.target)
															arg_52_0:setTargetValue(arg_69_0.target)
														end

														return
													end)
												end
											elseif var_52_0 == Live2DPainting.DRAG_GAME_XIAQI_RESULT and arg_52_0.commonData and arg_52_0.commonData[Live2DPainting.COMMON_XIAQI_RESULT] ~= nil and arg_52_0.actionTrigger.win == 1 == arg_52_0.commonData[Live2DPainting.COMMON_XIAQI_RESULT] then
												arg_52_0:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_70_0)
													if arg_70_0 then
														arg_52_0:setTriggerActionFlag(false)
														arg_52_0:setCommonData(Live2DPainting.COMMON_XIAQI_RESULT, nil)
													end

													return
												end)
											end
										end

										return
									end
								end
							end
						end
					end
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
	local var_74_2, var_74_3

	if not arg_74_0.extendActionFlag then
		do return var_74_0, var_74_1 end

		var_74_2 = arg_74_0.actionTrigger.num
		var_74_3 = false
	end

	;({}).name = arg_74_0.actionTrigger.parameter

	arg_74_0:onEventCallback(Live2DPainting.EVENT_GET_DRAG_PARAMETER, {}, function(arg_75_0)
		if arg_75_0 > var_74_2[1] and arg_75_0 <= var_74_2[2] then
			var_74_3 = true
		end

		return
	end)

	if not false then
		return var_74_0, var_74_0
	end

	local var_74_4 = arg_74_0.actionTriggerActive.ignore

	if arg_74_0.actionTriggerActive.ignore and table.contains(var_74_4, arg_74_1) then
		var_74_0 = true
	end

	if arg_74_0.actionTriggerActive.enable and table.contains(arg_74_0.actionTriggerActive.enable, arg_74_1) then
		var_74_1 = true
	end

	return var_74_0, var_74_1
end

function var_0_0.setAbleWithFlag(arg_76_0, arg_76_1)
	if arg_76_0.ableFlag ~= arg_76_1 then
		arg_76_0.ableFlag = arg_76_1

		arg_76_0:onEventCallback(Live2DPainting.EVENT_ACTION_ABLE, {
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

	if arg_78_0.nextTriggerTime - Time.deltaTime >= 0 then
		arg_78_0.nextTriggerTime = arg_78_0.nextTriggerTime - Time.deltaTime

		return false
	end

	if arg_78_0.isTriggerAtion then
		return false
	end

	return true
end

function var_0_0.updateStateData(arg_79_0, arg_79_1)
	if arg_79_0.l2dIdleIndex ~= arg_79_1.idleIndex then
		if type(arg_79_0.revertIdleIndex) == "boolean" and arg_79_0.revertIdleIndex == true then
			arg_79_0:setTargetValue(arg_79_0.startValue)

			arg_79_0.offsetDragX, arg_79_0.offsetDragY = arg_79_0.startValue, arg_79_0.startValue
			arg_79_0.offsetDragTargetX, arg_79_0.offsetDragTargetY = arg_79_0.startValue, arg_79_0.startValue
		elseif type(arg_79_0.revertIdleIndex) == "table" and table.contains(arg_79_0.revertIdleIndex, arg_79_1.idleIndex) then
			arg_79_0:setTargetValue(arg_79_0.startValue)

			arg_79_0.offsetDragTargetX, arg_79_0.offsetDragTargetY = arg_79_0.startValue, arg_79_0.startValue
			arg_79_0.offsetDragX, arg_79_0.offsetDragY = arg_79_0.startValue, arg_79_0.startValue
		end
	end

	arg_79_0.lastActionIndex = arg_79_0.actionListIndex

	if arg_79_1.isPlaying and arg_79_0.actionTrigger.reset_index_action and arg_79_1.actionName and table.contains(arg_79_0.actionTrigger.reset_index_action, arg_79_1.actionName) then
		arg_79_0.actionListIndex = 1
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
		arg_79_0.reactConditionFlag = not table.contains(arg_79_0.idleOn, arg_79_0.l2dIdleIndex)
	end

	if arg_79_0.l2dIdleIndex and arg_79_0.idleOff and #arg_79_0.idleOff > 0 then
		arg_79_0.reactConditionFlag = table.contains(arg_79_0.idleOff, arg_79_0.l2dIdleIndex)
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
	elseif arg_80_0.firstStop then
		local var_80_0 = math.abs(arg_80_0.mouseInputUp.x - arg_80_0.mouseInputDown.x) < 30 and math.abs(arg_80_0.mouseInputUp.y - arg_80_0.mouseInputDown.y) < 30
		local var_80_1 = arg_80_0.mouseInputUpTime - arg_80_0.mouseInputDownTime < 0.5

		if not arg_80_0.actionTrigger.down and var_80_0 and var_80_1 then
			if arg_80_0.actionTrigger.focus == 1 and arg_80_0.l2dIsPlaying then
				if arg_80_0.l2dPlayActionName == arg_80_0.actionTrigger.action then
					arg_80_0.clickTriggerTime = Time.realtimeSinceStartup + 0.1
				end
			elseif not arg_80_0.l2dIsPlaying then
				arg_80_0.clickTriggerTime = Time.realtimeSinceStartup + 0.1
			end
		else
			arg_80_0:setAbleWithFlag(false)
		end
	elseif arg_80_0.clickTriggerTime and arg_80_0.clickTriggerTime > 0 and Time.realtimeSinceStartup >= arg_80_0.clickTriggerTime then
		arg_80_0:setAbleWithFlag(false)

		if Time.realtimeSinceStartup - arg_80_0.clickTriggerTime <= 0.1 then
			print("点击成功" .. arg_80_0.id)

			arg_80_0.clickTriggerTime = nil

			return true
		end
	end

	return false
end

function var_0_0.saveData(arg_81_0)
	if arg_81_0.revert == -1 and arg_81_0.saveParameterFlag then
		Live2dConst.SaveDragData(arg_81_0.id, arg_81_0.live2dData.skinId, arg_81_0.live2dData.ship.id, arg_81_0.parameterTargetValue)
	end

	if arg_81_0.actionTrigger.type == Live2DPainting.DRAG_CLICK_MANY then
		Live2dConst.SetDragActionIndex(arg_81_0.id, arg_81_0.live2dData.skinId, arg_81_0.live2dData.ship.id, arg_81_0.actionListIndex)
	end

	if arg_81_0._relationFlag then
		Live2dConst.SetRelationData(arg_81_0.id, arg_81_0.live2dData.skinId, arg_81_0.live2dData.ship.id, arg_81_0:getRelationSaveData())
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
	if arg_83_0.revert == -1 and arg_83_0.saveParameterFlag then
		local var_83_0 = Live2dConst.GetDragData(arg_83_0.id, arg_83_0.live2dData:GetShipSkinConfig().id, arg_83_0.live2dData.ship.id)

		if var_83_0 then
			arg_83_0:setParameterValue(var_83_0)
			arg_83_0:setTargetValue(var_83_0)
		end

		if var_83_0 == arg_83_0.startValue and arg_83_0._relationParameterList and #arg_83_0._relationParameterList > 0 then
			arg_83_0:clearRelationValue()
		end
	end

	if arg_83_0.actionTrigger.type == Live2DPainting.DRAG_CLICK_MANY then
		arg_83_0.actionListIndex = Live2dConst.GetDragActionIndex(arg_83_0.id, arg_83_0.live2dData:GetShipSkinConfig().id, arg_83_0.live2dData.ship.id) or 1
	end

	if arg_83_0._relationFlag then
		local var_83_1 = Live2dConst.GetRelationData(arg_83_0.id, arg_83_0.live2dData:GetShipSkinConfig().id, arg_83_0.live2dData.ship.id)

		if var_83_1.drag_x then
			arg_83_0.offsetDragX = var_83_1.drag_x or arg_83_0.startValue

			if var_83_1.drag_y then
				arg_83_0.offsetDragY = var_83_1.drag_y or arg_83_0.startValue

				return
			end
		end
	end
end

function var_0_0.getRelationSaveData(arg_84_0)
	return {
		[Live2dConst.RELATION_DRAG_X] = arg_84_0.offsetDragX,
		[Live2dConst.RELATION_DRAG_Y] = arg_84_0.offsetDragY
	}
end

function var_0_0.clearRelationValue(arg_85_0)
	if arg_85_0._relationParameterList and #arg_85_0._relationParameterList > 0 then
		for iter_85_0 = 1, #arg_85_0._relationParameterList do
			if arg_85_0._relationParameterList[iter_85_0].data.type == Live2DPainting.relation_type_drag_x or arg_85_0._relationParameterList[iter_85_0].data.type == Live2DPainting.relation_type_drag_y then
				arg_85_0._relationParameterList[iter_85_0].value = arg_85_0._relationParameterList[iter_85_0].start or arg_85_0.startValue or 0
				arg_85_0._relationParameterList[iter_85_0].enable = true
			end

			arg_85_0.offsetDragX, arg_85_0.offsetDragY = arg_85_0.startValue, arg_85_0.startValue
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
	arg_89_0.mouseInputDown = Vector2(0, 0)
	arg_89_0.data = nil
	arg_89_0.live2dData = nil
	arg_89_0.commonData = nil

	return
end

return var_0_0
