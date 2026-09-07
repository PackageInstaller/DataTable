local Live2dDrag = class("Live2dDrag")
local var_0_1 = 4
local var_0_2 = {}
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 1

function Live2dDrag:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.data = arg_1_1
	self.live2dData = arg_1_2
	self.commonData = arg_1_3
	self.frameRate = Application.targetFrameRate or 60
	var_0_2 = {
		Live2DPainting.DRAG_DOWN_ACTION
	}
	self.id = arg_1_1.id
	self.drawAbleName = arg_1_1.draw_able_name or ""
	self.parameterName = arg_1_1.parameter

	if arg_1_1.mode and arg_1_1.mode ~= 0 then
		self.mode = arg_1_1.mode or 1
	end

	self.startValue = arg_1_1.start_value or 0

	if arg_1_1.range and self.range ~= "" then
		self.range = arg_1_1.range or {
			0,
			0
		}
	end

	self.offsetX = arg_1_1.offset_x

	if self.offsetX == 0 then
		self.offsetX = nil
	end

	self.offsetY = arg_1_1.offset_y

	if self.offsetY == 0 then
		self.offsetY = nil
	end

	self.smooth = arg_1_1.smooth / 1000
	self.smoothRevert = arg_1_1.revert_smooth / 1000
	self.revert = arg_1_1.revert
	self.ignoreReact = arg_1_1.ignore_react == 1
	self.gyro = arg_1_1.gyro == 1 or nil
	self.gyroX = arg_1_1.gyro_x == 1
	self.gyroY = arg_1_1.gyro_y == 1
	self.gyroZ = arg_1_1.gyro_z == 1
	self.ignoreAction = arg_1_1.ignore_action == 1
	self.dragDirect = arg_1_1.drag_direct
	self.rangeAbs = arg_1_1.range_abs == 1
	self.partsData = arg_1_1.parts_data
	self.actionTrigger = arg_1_1.action_trigger

	if arg_1_1.react_pos_x ~= 0 then
		self.reactX = arg_1_1.react_pos_x or nil
	end

	if arg_1_1.react_pos_y ~= 0 then
		self.reactY = arg_1_1.react_pos_y or nil
	end

	self.actionTriggerActive = arg_1_1.action_trigger_active
	self.relationParameter = arg_1_1.relation_parameter
	self.relationParts = self.relationParameter.parts

	if arg_1_1.limit_time > 0 then
		self.limitTime = arg_1_1.limit_time or var_0_1
	end

	self.offsetCircle = arg_1_1.offset_circle or ""

	if self.offsetCircle.pos then
		self.offsetCirclePos = self.offsetCircle.pos or nil
	end

	if self.offsetCircle.start then
		self.offsetCircleStart = self.offsetCircle.start or nil
	end

	self.listenerData = arg_1_1.listener_data
	self.listenerType = self.listenerData.type
	self.listenerChange = self.listenerData.change
	self.listenerApply = self.listenerData.apply

	if arg_1_1.react_condition and arg_1_1.react_condition ~= "" then
		self.reactCondition = arg_1_1.react_condition or {}
	end

	if self.reactCondition.idle_on then
		self.idleOn = self.reactCondition.idle_on or {}
	end

	if self.reactCondition.idle_off then
		self.idleOff = self.reactCondition.idle_off or {}
	end

	local var_1_0 = false

	if #arg_1_1.revert_idle_index > 0 then
		if type(arg_1_1.revert_idle_index) == "table" then
			var_1_0 = arg_1_1.revert_idle_index
		elseif tonumber(arg_1_1.revert_idle_index) and tonumber(arg_1_1.revert_idle_index) >= 0 then
			var_1_0 = tonumber(arg_1_1.revert_idle_index) == 1
		end
	end

	self.revertIdleIndex = var_1_0
	self.revertActionIndex = arg_1_1.revert_action_index == 1
	self.saveParameterFlag = true

	if arg_1_1.save_parameter == -1 then
		self.saveParameterFlag = false
	end

	self.randomAttitudeIndex = L2D_RANDOM_PARAM
	self._active = false
	self._parameterCom = nil
	self.parameterValue = self.startValue
	self.parameterStartValue = self.startValue
	self.parameterTargetValue = self.startValue
	self.parameterSmooth = 0
	self.parameterSmoothTime = self.smooth
	self.mouseInputDown = Vector2(0, 0)
	self.nextTriggerTime = 0
	self.triggerActionTime = 0
	self.sensitive = 4
	self.l2dIdleIndex = 0
	self.reactPos = Vector2(0, 0)
	self.actionListIndex = 1
	self._relationParameterList = {}
	self.offsetDragX = self.startValue
	self.offsetDragY = self.startValue
	self.rangeOffset = self.range[2] - self.range[1]
	self.offsetDragTargetX = self.startValue
	self.offsetDragTargetY = self.startValue
	self._relationFlag = false
	self.ableFlag = false

	if self.relationParameter and self.relationParameter.list then
		self._relationFlag = true
	end

	self.extendActionFlag = false
	self.parameterComAdd = true
	self.reactConditionFlag = false
	self.loadL2dStep = true

	return
end

function Live2dDrag:onListenerEvent(arg_2_1, arg_2_2)
	self:onListenerTrigger(arg_2_1, arg_2_2)

	if not self.listenerType then
		return
	end

	if self.listenerType == arg_2_1 then
		local var_2_6 = false

		if self.listenerChange and #self.listenerChange > 0 then
			local var_2_7 = self:getChangeCheckName(arg_2_1, arg_2_2)

			if var_2_7 then
				for iter_2_0 = 1, #self.listenerChange do
					local var_2_8 = self.listenerChange[iter_2_0][1]
					local var_2_9 = self.listenerChange[iter_2_0][3]

					if #self.listenerChange[iter_2_0] >= 4 then
						local var_2_10 = self.listenerChange[iter_2_0][4] or 1

						if table.contains(self.listenerChange[iter_2_0][2], var_2_7) then
							local var_2_11

							if var_2_8 == var_0_6 then
								var_2_11 = self.parameterTargetValue + var_2_9
							elseif var_2_8 == var_0_7 then
								var_2_11 = var_2_9
							end

							if var_2_11 then
								var_2_6 = true

								local var_2_12 = self:fixParameterTargetValue(var_2_11, self.range, self.rangeAbs, self.dragDirect)

								if self.actionTrigger.change_focus == false then
									self.prepareTargetValue = var_2_12

									print(self.id .. "=" .. self.parameterName .. "等待动作结束后的target赋值" .. self.parameterTargetValue)
								else
									self:setTargetValue(var_2_12)
									print(self.id .. "=" .. self.parameterName .. "监听 数值变更为" .. self.parameterTargetValue)
								end
							end
						end

						if var_2_10 and var_2_10 > 0 then
							var_2_6 = true
							self.actionListIndex = var_2_10
						end
					end
				end
			end
		end

		if self.listenerApply and #self.listenerApply > 0 then
			if self.listenerApply[1] == var_0_8 and var_2_6 then
				local var_2_13 = self.parameterTargetValue

				if self.prepareTargetValue ~= nil then
					var_2_13 = self.prepareTargetValue
				end

				local var_2_14

				for iter_2_1 = 1, #self.listenerApply[2] do
					if var_2_13 >= self.listenerApply[2][iter_2_1][1] and var_2_13 < self.listenerApply[2][iter_2_1][2] then
						var_2_14 = self.listenerApply[2][iter_2_1][3]
					end
				end

				if var_2_14 and self.l2dIdleIndex ~= var_2_14 then
					self:onEventCallback(Live2DPainting.EVENT_CHANGE_IDLE_INDEX, {
						id = self.id,
						idle = var_2_14,
						activeData = self.actionTriggerActive
					})
				end
			end
		end
	end

	return
end

function Live2dDrag:onListenerTrigger(arg_3_1, arg_3_2)
	if arg_3_1 == Live2DPainting.ON_ACTION_DRAG_CLICK then
		if self.actionTrigger.click_cd and table.contains(self.actionTrigger.click_cd, arg_3_2.draw_able_name) then
			self.nextTriggerTime = self.limitTime
		end
	elseif arg_3_1 == Live2DPainting.ON_ACTION_PLAY then
		if self.limitTime <= 0.2 then
			self.nextTriggerTime = self.limitTime or 0.2
		end
	end

	return
end

function Live2dDrag:getChangeCheckName(arg_4_1, arg_4_2)
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

function Live2dDrag:startDrag(arg_5_1)
	if self.ignoreAction and self.l2dIsPlaying then
		return
	end

	print(self.drawAbleName .. " 按下了 id = " .. self.id)

	if not self._active then
		self._active = true
		self.mouseInputDown = Input.mousePosition
		self.mouseInputDownTime = Time.time
		self.triggerActionTime = 0

		if table.contains(var_0_2, self.actionTrigger.type) then
			self.actionListIndex = 1
		end

		self.parameterSmoothTime = self.smooth
	end

	return
end

function Live2dDrag:stopDrag(arg_6_1)
	if self._active then
		self._active = false

		self:setParameterRevert()

		if self.offsetDragX then
			self.offsetDragTargetX = self:fixParameterTargetValue(self.offsetDragX, self.range, self.rangeAbs, self.dragDirect)
		end

		if self.offsetDragY then
			self.offsetDragTargetY = self:fixParameterTargetValue(self.offsetDragY, self.range, self.rangeAbs, self.dragDirect)
		end

		self:checkResetTriggerTime()

		self.mouseInputUp = Input.mousePosition
		self.mouseInputUpTime = Time.time
		self.mouseWorld = nil
		self.circleDragWorld = nil

		self:updatePartsParameter()
		self:saveData()
	end

	return
end

function Live2dDrag:setParameterRevert()
	if self.revert > 0 then
		self.parameterToStart = self.revert / 1000
		self.parameterSmoothTime = self.smoothRevert
	end

	return
end

function Live2dDrag:onDrag(arg_8_1)
	self.mouseWorld = arg_8_1.pointerCurrentRaycast.worldPosition

	return
end

function Live2dDrag:checkResetTriggerTime()
	if not not (self.actionTrigger.type == Live2DPainting.DRAG_DOWN_ACTION and self.actionTrigger.last) then
		self:resetNextTriggerTime()
	end

	return
end

function Live2dDrag:resetNextTriggerTime()
	self.nextTriggerTime = 0

	return
end

function Live2dDrag:updatePartsParameter()
	if type(self.partsData) == "table" then
		local var_11_0 = self.partsData.parts
		local var_11_1 = self.partsData.type
		local var_11_2 = false

		if self.offsetX or self.offsetY then
			var_11_2 = true
		elseif self.actionTrigger and self.actionTrigger.type == Live2DPainting.DRAG_DOWN_TOUCH then
			var_11_2 = true
		elseif self.offsetCirclePos then
			var_11_2 = true
		end

		if var_11_2 then
			local var_11_3
			local var_11_4

			for iter_11_0 = 1, #var_11_0 do
				local var_11_5 = math.abs(self.parameterTargetValue - var_11_0[iter_11_0])

				if var_11_1 == var_0_3 or not var_11_1 then
					if not var_11_3 or var_11_5 < var_11_3 then
						var_11_3 = var_11_5
						var_11_4 = iter_11_0
					end
				elseif var_11_1 == var_0_4 then
					if var_11_0[iter_11_0] <= self.parameterTargetValue and (not var_11_3 or var_11_5 < var_11_3) then
						var_11_3 = var_11_5
						var_11_4 = iter_11_0
					end
				elseif var_11_1 == var_0_5 and self.parameterTargetValue <= var_11_0[iter_11_0] and (not var_11_3 or var_11_5 < var_11_3) then
					var_11_3 = var_11_5
					var_11_4 = iter_11_0
				end
			end

			if var_11_4 then
				if math.abs(self.parameterTargetValue - var_11_0[var_11_4]) >= 0.05 then
					print("吸附数值" .. var_11_0[var_11_4])
				end

				if self.offsetDragTargetX then
					self.offsetDragTargetX = var_11_0[var_11_4]
				end

				if self.offsetDragTargetY then
					self.offsetDragTargetY = var_11_0[var_11_4]
				end

				self:setTargetValue(var_11_0[var_11_4])
			end
		end
	end

	return
end

function Live2dDrag:getIgnoreReact()
	return self.ignoreReact
end

function Live2dDrag:setParameterCom(arg_13_1)
	if not arg_13_1 then
		-- block empty
	end

	self._parameterCom = arg_13_1

	return
end

function Live2dDrag:getParameterCom()
	return self._parameterCom
end

function Live2dDrag:getParameterName()
	if self.parameterName and #self.parameterName > 0 then
		return self.parameterName
	end

	return nil
end

function Live2dDrag:addRelationComData(arg_16_1, arg_16_2)
	table.insert(self._relationParameterList, {
		com = arg_16_1,
		data = arg_16_2
	})

	return
end

function Live2dDrag:getRelationParameterList()
	return self._relationParameterList
end

function Live2dDrag:getReactCondition()
	return self.reactConditionFlag
end

function Live2dDrag:getActive()
	return self._active
end

function Live2dDrag:getParameterUpdateFlag()
	return self._parameterUpdateFlag
end

function Live2dDrag:setEventCallback(arg_21_1)
	self._eventCallback = arg_21_1

	return
end

function Live2dDrag:onEventCallback(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 == Live2DPainting.EVENT_ACTION_APPLY then
		local var_22_0 = {}
		local var_22_1
		local var_22_2 = false
		local var_22_3
		local var_22_4
		local var_22_6 = false

		local function var_22_7()
			if self:isApplyStopDrag() then
				self:stopDrag()
			end

			return
		end

		if self.actionTrigger.action then
			var_22_1 = self:fillterAction(self.actionTrigger.action)
			var_22_0 = self.actionTriggerActive
			var_22_2 = self.actionTrigger.focus == 1
			var_22_3 = self.actionTrigger.target or nil
			var_22_6 = self.actionTrigger.target_focus == 1

			if self.actionTrigger.circle ~= nil and var_22_3 and var_22_3 == self.parameterTargetValue then
				var_22_3 = self.startValue
			end

			var_22_4 = self.actionTrigger.react or nil

			self:triggerAction()
			var_22_7()
		elseif self.actionTrigger.action_list then
			local var_22_8 = self.actionTrigger.action_list[self.actionListIndex]

			var_22_1 = self:fillterAction(self.actionTrigger.action_list[self.actionListIndex].action)
			var_22_0 = self.actionTriggerActive.active_list and self.actionListIndex <= #self.actionTriggerActive.active_list and self.actionTriggerActive.active_list[self.actionListIndex] or self.actionTriggerActive
			var_22_2 = var_22_8.focus == 1

			if not var_22_2 and self.actionTrigger.focus then
				var_22_2 = self.actionTrigger.focus == 1
			end

			var_22_3 = var_22_8.target or nil
			var_22_6 = var_22_8.target_focus == 1
			var_22_4 = var_22_8.react or nil

			if var_22_1 and #var_22_1 > 0 then
				self:triggerAction()
			end

			if self.actionListIndex == #self.actionTrigger.action_list then
				self.actionListIndex = 1

				var_22_7()
			else
				self.actionListIndex = self.actionListIndex + 1
			end

			print("id = " .. self.id .. " action list index = " .. self.actionListIndex)
		elseif not self.actionTrigger.action then
			var_22_1 = self:fillterAction(self.actionTrigger.action)
			var_22_0 = self.actionTriggerActive
			var_22_2 = self.actionTrigger.focus == 1
			var_22_3 = self.actionTrigger.target or nil
			var_22_6 = self.actionTrigger.target_focus == 1
			var_22_4 = self.actionTrigger.react or nil

			if self.actionTrigger.circle ~= nil and var_22_3 and var_22_3 == self.parameterTargetValue then
				var_22_3 = self.startValue
			end

			self:triggerAction()
			self:setTriggerActionFlag(false)
			var_22_7()
		end

		if var_22_0.idle then
			if type(var_22_0.idle) == "number" then
				if var_22_0.idle == self.l2dIdleIndex and not var_22_0.repeat_flag then
					return
				end
			elseif type(var_22_0.idle) == "table" and #var_22_0.idle == 1 and var_22_0.idle[1] == self.l2dIdleIndex and not var_22_0.repeat_flag then
				return
			end
		end

		print("执行aplly数据 id = " .. self.id .. "播放action = " .. tostring(var_22_1) .. " active idle is " .. tostring(var_22_0.idle))

		if var_22_3 then
			self:setTargetValue(var_22_3)

			if var_22_6 then
				self:setParameterValue(var_22_3)
			end

			if not var_22_1 then
				self.revertResetFlag = true
			end
		end

		if var_22_2 then
			self:setTriggerActionFlag(false)
		end

		arg_22_2 = {
			id = self.id,
			action = var_22_1,
			activeData = var_22_0,
			focus = var_22_2,
			react = var_22_4,
			callback = arg_22_3,
			finishCall = function()
				self:actionApplyFinish()

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

	self._eventCallback(arg_22_1, arg_22_2)

	return
end

function Live2dDrag:isApplyStopDrag()
	if self.actionTrigger and self.actionTrigger.type == Live2DPainting.DRAG_MOVE_DOWN_UP then
		return false
	end

	return true
end

function Live2dDrag:fillterAction(arg_26_1)
	if type(arg_26_1) == "table" then
		return arg_26_1[math.random(1, #arg_26_1)]
	else
		return arg_26_1
	end

	return
end

function Live2dDrag:onEventNotice(arg_27_1)
	if self._eventCallback then
		self._eventCallback(arg_27_1, (self:getCommonNoticeData()))
	end

	return
end

function Live2dDrag:getCommonNoticeData()
	return {
		draw_able_name = self.drawAbleName,
		parameter_name = self.parameterName,
		parameter_target = self.parameterTargetValue
	}
end

function Live2dDrag:setTargetValue(arg_29_1)
	self.parameterSmooth = 0
	self.parameterStartValue = self.parameterTargetValue
	self.parameterTargetValue = arg_29_1

	return
end

function Live2dDrag:setTargetValueDelay(arg_30_1, arg_30_2)
	self:setTargetValue(arg_30_1)

	self.delayTargetTime = arg_30_2

	return
end

function Live2dDrag:getParameter()
	return self.parameterValue
end

function Live2dDrag:getParameterTarget()
	return self.parameterTargetValue
end

function Live2dDrag:getParameToTargetFlag()
	if self.parameterValue ~= self.parameterTargetValue then
		return true
	end

	if self.parameterToStart and self.parameterToStart > 0 then
		return true
	end

	return false
end

function Live2dDrag:actionApplyFinish()
	return
end

function Live2dDrag:stepParameter(arg_35_1)
	self:updateStepData(arg_35_1)
	self:updateActiveState()
	self:updateTrigger()
	self:updateParameterUpdateFlag()
	self:updateGyro()
	self:updateDrag()
	self:updateCircleDrag()
	self:updateReactValue()
	self:updateParameterValue()
	self:updateRelationValue()
	self:checkReset()

	self.loadL2dStep = false

	return
end

function Live2dDrag:updateStepData(arg_36_1)
	self.reactPos = arg_36_1.reactPos
	self.lastNormalTime = self.normalTime
	self.normalTime = arg_36_1.normalTime
	self.stateInfo = arg_36_1.stateInfo

	return
end

function Live2dDrag:updateParameterUpdateFlag()
	if self.actionTrigger.type == Live2DPainting.DRAG_CLICK_ACTION then
		self._parameterUpdateFlag = true
	elseif self.actionTrigger.type == Live2DPainting.DRAG_RELATION_IDLE then
		if not self._parameterUpdateFlag then
			if not self.l2dIsPlaying then
				self._parameterUpdateFlag = true

				self:changeParameComAble(true)
			elseif not table.contains(self.actionTrigger.remove_com_list, self.l2dPlayActionName) then
				self._parameterUpdateFlag = true

				self:changeParameComAble(true)
			end
		elseif self._parameterUpdateFlag == true and self.l2dIsPlaying and table.contains(self.actionTrigger.remove_com_list, self.l2dPlayActionName) then
			self._parameterUpdateFlag = false

			self:changeParameComAble(false)
		end
	else
		self._parameterUpdateFlag = self.actionTrigger.type == Live2DPainting.DRAG_DOWN_TOUCH and true or self.actionTrigger.type == Live2DPainting.DRAG_LISTENER_EVENT and true or self.actionTrigger.type == Live2DPainting.DRAG_ANIMATION_PLAY and true or self.actionTrigger.type == Live2DPainting.DRAG_WITH_PARAMETER_MOVE and true or self.actionTrigger.type == Live2DPainting.DRAG_MOVE_DOWN_UP and true or self.actionTrigger.type == Live2DPainting.DRAG_GAME_XIAQI
	end

	return
end

function Live2dDrag:changeParameComAble(arg_38_1)
	if self.parameterComAdd == arg_38_1 then
		return
	end

	self.parameterComAdd = arg_38_1

	if arg_38_1 then
		self:onEventCallback(Live2DPainting.EVENT_ADD_PARAMETER_COM, {
			com = self._parameterCom,
			start = self.startValue,
			mode = self.mode
		})
	else
		self:onEventCallback(Live2DPainting.EVENT_REMOVE_PARAMETER_COM, {
			com = self._parameterCom,
			mode = self.mode
		})
	end

	return
end

function Live2dDrag:updateDrag()
	if not self.offsetX and not self.offsetY then
		return
	end

	local var_39_0

	if self._active then
		if self.offsetX and self.offsetX ~= 0 then
			var_39_0 = self.offsetDragTargetX + (Input.mousePosition.x - self.mouseInputDown.x) / self.offsetX
			self.offsetDragX = self.offsetDragTargetX + (Input.mousePosition.x - self.mouseInputDown.x) / self.offsetX
		end

		if self.offsetY and self.offsetY ~= 0 then
			var_39_0 = self.offsetDragTargetY + (Input.mousePosition.y - self.mouseInputDown.y) / self.offsetY
			self.offsetDragY = self.offsetDragTargetY + (Input.mousePosition.y - self.mouseInputDown.y) / self.offsetY
		end

		if var_39_0 then
			self:setTargetValue(self:fixParameterTargetValue(var_39_0, self.range, self.rangeAbs, self.dragDirect))
		end
	end

	self._parameterUpdateFlag = true

	return
end

function Live2dDrag:updateCircleDrag()
	if not self.offsetCirclePos then
		return
	end

	if self._active and self.mouseWorld ~= nil then
		if not self.circleDragWorld then
			self:onEventCallback(Live2DPainting.EVENT_GET_WORLD_POSITION, {
				pos = self.offsetCirclePos,
				name = self.drawAbleName
			}, function(arg_41_0)
				self.circleDragWorld = arg_41_0

				return
			end)
		end

		self:setTargetValue(self.range[2] * ((math.atan2(self.mouseWorld.x - self.circleDragWorld.x, self.mouseWorld.y - self.circleDragWorld.y) * math.rad2Deg + 360 - self.offsetCircleStart) % 360 / 360))

		self._parameterUpdateFlag = true
	elseif self.parameterTargetValue ~= self.parameterValue then
		self._parameterUpdateFlag = true
	end

	return
end

function Live2dDrag:updateGyro()
	if not self.gyro then
		return
	end

	if not Input.gyro.enabled then
		self:setTargetValue(0)

		self._parameterUpdateFlag = true

		return
	end

	local var_42_0

	if Input.gyro then
		var_42_0 = Input.gyro.attitude or Vector3.zero
	end

	local var_42_1 = 0

	if self.gyroX and not math.isnan(var_42_0.y) then
		var_42_1 = Mathf.Clamp(var_42_0.y * self.sensitive, -0.5, 0.5)
	elseif self.gyroY and not math.isnan(var_42_0.x) then
		var_42_1 = Mathf.Clamp(var_42_0.x * self.sensitive, -0.5, 0.5)
	elseif self.gyroZ and not math.isnan(var_42_0.z) then
		var_42_1 = Mathf.Clamp(var_42_0.z * self.sensitive, -0.5, 0.5)
	end

	if IsUnityEditor then
		if L2D_USE_RANDOM_ATTI then
			if self.randomAttitudeIndex == 0 then
				var_42_1 = math.random() - 0.5

				self:setTargetValue((var_42_1 + 0.5) * (self.range[2] - self.range[1]) + self.range[1])

				self.randomAttitudeIndex = L2D_RANDOM_PARAM
			elseif self.randomAttitudeIndex > 0 then
				self.randomAttitudeIndex = self.randomAttitudeIndex - 1
			end
		end
	else
		self:setTargetValue((var_42_1 + 0.5) * (self.range[2] - self.range[1]) + self.range[1])
	end

	self._parameterUpdateFlag = true

	return
end

function Live2dDrag:updateReactValue()
	if not self.reactX and not self.reactY then
		return
	end

	local var_43_0
	local var_43_1 = false

	if self.l2dIgnoreReact then
		var_43_0 = self.parameterTargetValue
	elseif self.reactX then
		var_43_0 = self.reactPos.x * self.reactX
		var_43_1 = true
	else
		var_43_0 = self.reactPos.y * self.reactY
		var_43_1 = true
	end

	if var_43_1 then
		self:setTargetValue(self:fixParameterTargetValue(var_43_0, self.range, self.rangeAbs, self.dragDirect))
	end

	self._parameterUpdateFlag = true

	return
end

function Live2dDrag:updateParameterValue()
	if self.delayTargetTime and self.delayTargetTime > 0 then
		self.delayTargetTime = self.delayTargetTime - Time.deltaTime

		if self.delayTargetTime <= 0 then
			self.delayTargetTime = nil
		end

		return
	end

	if self.prepareTargetValue and not self.l2dIsPlaying then
		self:setTargetValue(self.prepareTargetValue)

		self.prepareTargetValue = nil
	end

	if self._parameterUpdateFlag and self.parameterValue ~= self.parameterTargetValue then
		if math.abs(self.parameterValue - self.parameterTargetValue) < 0.05 then
			self:setParameterValue(self.parameterTargetValue)
		elseif self.parameterSmoothTime and self.parameterSmoothTime > 0 then
			local var_44_0, var_44_1 = Live2DExtend.CustomSmoothValue(self.parameterStartValue, self:checkUpdateParameterNum(self.parameterTargetValue, self.parameterValue), self.parameterSmoothTime, self.parameterSmooth, Time.fixedDeltaTime)

			self:setParameterValue(var_44_0, var_44_1)
		else
			self:setParameterValue(self.parameterTargetValue, 0)
		end
	end

	return
end

function Live2dDrag:checkUpdateParameterNum(arg_45_1, arg_45_2)
	if self.offsetCirclePos and math.abs(arg_45_1 - arg_45_2) >= self.rangeOffset / 2 then
		arg_45_1 = arg_45_2 < arg_45_1 and arg_45_1 - self.rangeOffset or arg_45_1 + self.rangeOffset
	end

	return arg_45_1
end

function Live2dDrag:updateRelationValue()
	for iter_46_0, iter_46_1 in ipairs(self._relationParameterList) do
		local var_46_0 = iter_46_1.data
		local var_46_1 = iter_46_1.data.target
		local var_46_2
		local var_46_3

		if iter_46_1.data.type == Live2DPainting.relation_type_drag_x then
			var_46_2 = self.offsetDragX or iter_46_1.start or self.startValue or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_drag_y then
			var_46_2 = self.offsetDragY or iter_46_1.start or self.startValue or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_action_index then
			var_46_2 = iter_46_1.data.relation_value[self.actionListIndex] or 0
			var_46_3 = true
		elseif iter_46_1.data.type == Live2DPainting.relation_type_idle then
			if self.loadL2dStep and self.l2dIdleIndex == var_46_0.idle then
				var_46_3 = true
			end

			if self.l2dIsPlaying then
				if self.l2dPlayActionName == self.actionTrigger.action then
					self.relationActive = true
				end
			else
				self.relationActive = false
				self.relationCountTime = nil
			end

			if not var_46_3 and self.relationActive and self.l2dIdleIndex == var_46_0.idle then
				self.relationCountTime = self.relationCountTime or Time.GetTimestamp() + var_46_0.time

				if self.relationCountTime and Time.GetTimestamp() >= self.relationCountTime then
					var_46_3 = true
				end
			end
		else
			var_46_2 = self.parameterTargetValue
			var_46_3 = false
		end

		local var_46_4
		local var_46_5

		if var_46_1 then
			var_46_4 = var_46_1
		else
			local var_46_6 = self:fixRelationParameter(var_46_2, var_46_0)
			local var_46_7 = iter_46_1.value or self.startValue

			if math.abs(var_46_6 - var_46_7) <= 0.01 then
				var_46_4 = var_46_6
			else
				var_46_4, var_46_5 = Mathf.SmoothDamp(var_46_7, var_46_6, iter_46_1.parameterSmooth or 0, (var_46_0.smooth or nil) and (var_46_0.smooth / 1000 or self.smooth))
			end
		end

		iter_46_1.target = var_46_2
		iter_46_1.value = var_46_4
		iter_46_1.parameterSmooth = var_46_5
		iter_46_1.enable = var_46_3
		iter_46_1.comId = self.id
	end

	return
end

function Live2dDrag:fixRelationParameter(arg_47_1, arg_47_2)
	return self:fixParameterTargetValue(arg_47_1, arg_47_2.range or self.range, arg_47_2.rangeAbs and arg_47_2.rangeAbs == 1 or self.rangeAbs, (arg_47_2.drag_direct or nil) and (arg_47_2.drag_direct or self.dragDirect))
end

function Live2dDrag:fixParameterTargetValue(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
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

function Live2dDrag:checkReset()
	if not self._active and self.parameterToStart then
		if self.parameterToStart > 0 then
			self.parameterToStart = self.parameterToStart - Time.deltaTime
		end

		if self.parameterToStart <= 0 then
			self:setTargetValue(self.startValue)

			self.parameterToStart = nil

			if self.revertResetFlag then
				self:setTriggerActionFlag(false)

				self.revertResetFlag = false
			end

			if self.offsetDragX then
				self.offsetDragX = self.startValue
				self.offsetDragTargetX = self.startValue
			end

			if self.offsetDragY then
				self.offsetDragY = self.startValue
				self.offsetDragTargetY = self.startValue
			end
		end
	end

	return
end

function Live2dDrag:setParameterValue(arg_50_1, arg_50_2)
	if arg_50_1 then
		self.parameterValue = arg_50_1
	end

	if arg_50_2 then
		self.parameterSmooth = arg_50_2
	end

	return
end

function Live2dDrag:updateActiveState()
	self.firstActive = not not (not self.lastFrameActive and self._active)
	self.firstStop = not not (self.lastFrameActive and not self._active)
	self.lastFrameActive = self._active

	return
end

function Live2dDrag:updateTrigger()
	if not self:isActionTriggerAble() then
		return
	end

	local var_52_0 = self.actionTrigger.type
	local var_52_2

	if self.actionTrigger.time then
		var_52_2 = self.actionTrigger.time
	elseif self.actionTrigger.action_list and self.actionListIndex > 0 then
		var_52_2 = self.actionTrigger.action_list[self.actionListIndex].time
	end

	local var_52_3

	if self.actionTrigger.num then
		var_52_3 = self.actionTrigger.num
	elseif self.actionTrigger.action_list and self.actionTrigger.action_list[self.actionListIndex].num and self.actionListIndex > 0 then
		var_52_3 = self.actionTrigger.action_list[self.actionListIndex].num
	end

	if var_52_0 == Live2DPainting.DRAG_TIME_ACTION then
		if self._active then
			if var_52_3 and math.abs(self.parameterValue - var_52_3) < math.abs(var_52_3) * 0.25 then
				self.triggerActionTime = self.triggerActionTime + Time.deltaTime

				if var_52_2 < self.triggerActionTime and not self.l2dIsPlaying then
					self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_53_0)
						if arg_53_0 then
							self:onEventNotice(Live2DPainting.ON_ACTION_DRAG_TRIGGER)
						end

						return
					end)
				end
			else
				print("配置id = " .. self.id .. " 缺少参数 num")
			end
		end
	elseif var_52_0 == Live2DPainting.DRAG_CLICK_ACTION then
		if self:checkClickAction() then
			self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_54_0)
				self:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

				return
			end)
		end
	elseif var_52_0 == Live2DPainting.DRAG_CLICK_RANGE then
		if self:checkClickAction() then
			local var_52_4

			if self.actionTrigger.parameter then
				var_52_4 = self.actionTrigger.parameter or self.parameterName
			end

			local var_52_5 = var_52_3

			self:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
				name = var_52_4
			}, function(arg_55_0)
				print("获取到数值 " .. var_52_4 .. " = " .. arg_55_0, "匹配范围 = " .. var_52_5[1] .. " - " .. var_52_5[2])

				if arg_55_0 >= var_52_5[1] and arg_55_0 < var_52_5[2] then
					print("数值范围内，开始触发动作  = " .. tostring(self.id))
					self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_56_0)
						self:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

						return
					end)
				end

				return
			end)
		end
	elseif var_52_0 == Live2DPainting.DRAG_DOWN_ACTION then
		if self._active then
			self:setAbleWithFlag(true)

			if var_52_2 <= Time.time - self.mouseInputDownTime and not self.l2dIsPlaying then
				print("触发按压动作")
				self:setAbleWithFlag(false)
				self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_57_0)
					if arg_57_0 then
						self:onEventNotice(Live2DPainting.ON_ACTION_DOWN)
					end

					return
				end)

				if self.actionListIndex ~= 1 then
					self:setTriggerActionFlag(false)
				end

				self:setAbleWithFlag(true)

				self.mouseInputDownTime = Time.time
			end
		elseif self.actionTrigger.last and self.actionListIndex ~= 1 then
			self.actionListIndex = #self.actionTrigger.action_list

			self:setAbleWithFlag(false)
			self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_58_0)
				return
			end)
			self:resetNextTriggerTime()
			self:setTriggerActionFlag(false)
		else
			self:setAbleWithFlag(false)
		end
	elseif var_52_0 == Live2DPainting.DRAG_RELATION_XY then
		if self._active then
			if math.abs(self:fixParameterTargetValue(self.offsetDragX, self.range, self.rangeAbs, self.dragDirect) - var_52_3[1]) <= math.abs(var_52_3[1]) * 0.25 and math.abs(self:fixParameterTargetValue(self.offsetDragY, self.range, self.rangeAbs, self.dragDirect) - var_52_3[2]) <= math.abs(var_52_3[2]) * 0.25 then
				self.triggerActionTime = self.triggerActionTime + Time.deltaTime

				if var_52_2 < self.triggerActionTime and not self.l2dIsPlaying then
					self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_59_0)
						if arg_59_0 then
							self:onEventNotice(Live2DPainting.ON_ACTION_XY_TRIGGER)
						end

						return
					end)
				end
			else
				self.triggerActionTime = self.triggerActionTime + 0
			end
		end
	elseif var_52_0 == Live2DPainting.DRAG_RELATION_IDLE then
		if self.actionTrigger.const_fit then
			for iter_52_0 = 1, #self.actionTrigger.const_fit do
				if self.l2dIdleIndex == self.actionTrigger.const_fit[iter_52_0].idle and not self.l2dIsPlaying then
					self:setTargetValue(self.actionTrigger.const_fit[iter_52_0].target)
				end
			end
		end
	elseif var_52_0 == Live2DPainting.DRAG_CLICK_MANY then
		if self:checkClickAction() then
			self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY)
		end
	elseif var_52_0 == Live2DPainting.DRAG_LISTENER_EVENT then
		if self._listenerTrigger then
			self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY)
		end
	elseif var_52_0 == Live2DPainting.DRAG_DOWN_TOUCH then
		self:setAbleWithFlag(self._active)

		if self._active then
			self:setTargetValue((self:fixParameterTargetValue(self.parameterTargetValue + Time.deltaTime / self.actionTrigger.delta, self.range, self.rangeAbs, self.dragDirect)))
		end
	elseif var_52_0 == Live2DPainting.DRAG_CLICK_PARAMETER then
		if self:checkClickAction() then
			local var_52_6 = var_52_3

			self:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
				name = self.actionTrigger.parameter
			}, function(arg_60_0)
				if math.abs(var_52_6 - arg_60_0) <= 0.05 then
					print("数值允许播放，开始执行动作 " .. self.actionTrigger.action)
					self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_61_0)
						self:onEventNotice(Live2DPainting.ON_ACTION_DRAG_CLICK)

						return
					end)
				end

				return
			end)
		end
	elseif var_52_0 == Live2DPainting.DRAG_ANIMATION_PLAY then
		local var_52_7 = self.actionTrigger.trigger_name

		if self.actionTrigger.trigger_name == "idle" and self.actionTrigger.trigger_index and self.actionTrigger.trigger_index > 0 then
			var_52_7 = var_52_7 .. self.actionTrigger.trigger_index
		end

		if self.stateInfo:IsName(var_52_7) and self.l2dIdleIndex == self.actionTrigger.trigger_index then
			local var_52_8 = false

			if self.actionTrigger.parameter_range then
				local var_52_9 = self.actionTrigger.parameter_range[2]

				self:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
					name = self.actionTrigger.parameter_range[1]
				}, function(arg_62_0)
					if arg_62_0 and arg_62_0 >= var_52_9[1] and arg_62_0 < var_52_9[2] then
						var_52_8 = true
					end

					return
				end)
			else
				var_52_8 = true
			end

			if var_52_8 and self.normalTime >= self.actionTrigger.trigger_rate and not self.animationPlayApply then
				self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function()
					return
				end)
				self:setTriggerActionFlag(false)

				self.animationPlayApply = true
			end
		elseif self.animationPlayApply then
			self.animationPlayApply = false
		end
	elseif var_52_0 == Live2DPainting.DRAG_EXTEND_ACTION_RULE then
		self.extendActionFlag = self.extendActionFlag or true
	elseif var_52_0 == Live2DPainting.DRAG_WITH_PARAMETER_MOVE then
		if not self.l2dIsPlaying then
			local var_52_10
			local var_52_11

			if var_52_3 then
				var_52_10 = var_52_3 and math.abs(self.parameterValue - var_52_3) or 0
				var_52_11 = math.abs(var_52_3) * 0.1
			end

			if var_52_3 and var_52_10 <= var_52_11 and not self.parameterMoveTrigger then
				self.parameterMoveTrigger = true

				self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_64_0)
					return
				end)
			else
				self.moveCheckStep = self.moveCheckStep or 10

				if self.parameterMoveTrigger then
					self.parameterMoveTrigger = false

					self:setParameterValue(self.startValue)
					self:setTargetValue(self.startValue)
				end

				self.moveCheckStep = self.moveCheckStep - 1

				if self.moveCheckStep <= 0 then
					self.moveCheckStep = 10
					self.lastParameterMove = self.parameterMove

					self:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
						name = self.actionTrigger.parameter
					}, function(arg_65_0)
						self.parameterMove = arg_65_0

						return
					end)

					if self.lastParameterMove and self.parameterMove then
						local var_52_12 = math.abs(self.parameterMove - self.lastParameterMove)

						if var_52_12 ~= 0 then
							self:setTargetValue(self:fixParameterTargetValue(self.parameterTargetValue + var_52_12 * ((self.actionTrigger.rate or nil) and (self.actionTrigger.rate or 0)), self.range, self.rangeAbs, self.dragDirect))
							print("检测数值发生改变 = " .. self.parameterTargetValue)
						end
					end
				end
			end
		end
	elseif var_52_0 == Live2DPainting.DRAG_MOVE_DOWN_UP then
		local var_52_13 = self.actionTrigger.range

		if self._active and self.actionTrigger.active == 1 then
			if not self.dragMoveUp and self.parameterValue > self.actionTrigger.range[1] and self.parameterValue <= self.actionTrigger.range[2] then
				self.dragMoveUp = true

				self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_66_0)
					return
				end)
			end
		elseif self.firstStop and self.actionTrigger.active == 0 then
			self:onEventCallback(Live2DPainting.EVENT_GET_PARAMETER, {
				name = self.actionTrigger.parameter
			}, function(arg_67_0)
				if arg_67_0 > var_52_13[1] and arg_67_0 <= var_52_13[2] then
					self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_68_0)
						return
					end)
				end

				return
			end)
		elseif self._active == false and self.dragMoveUp then
			self.dragMoveUp = false
		end
	elseif var_52_0 == Live2DPainting.DRAG_GAME_XIAQI then
		if self:checkClickAction() then
			self:onEventCallback(Live2DPainting.EVENT_GAME_XIAQI, {
				parameter_value = self.parameterValue
			}, function(arg_69_0)
				if arg_69_0 and arg_69_0.target then
					print(self.parameterName .. " 设置数值 = " .. arg_69_0.target)
					self:setTargetValue(arg_69_0.target)
				end

				return
			end)
		end
	elseif var_52_0 == Live2DPainting.DRAG_GAME_XIAQI_RESULT and self.commonData and self.commonData[Live2DPainting.COMMON_XIAQI_RESULT] ~= nil and self.actionTrigger.win == 1 == self.commonData[Live2DPainting.COMMON_XIAQI_RESULT] then
		self:onEventCallback(Live2DPainting.EVENT_ACTION_APPLY, nil, function(arg_70_0)
			if arg_70_0 then
				self:setTriggerActionFlag(false)
				self:setCommonData(Live2DPainting.COMMON_XIAQI_RESULT, nil)
			end

			return
		end)
	end

	return
end

function Live2dDrag:IsTouchAble()
	return true
end

function Live2dDrag:setCommonData(arg_72_1, arg_72_2)
	self.commonData[arg_72_1] = arg_72_2

	return
end

function Live2dDrag:getExtendAction()
	return self.extendActionFlag
end

function Live2dDrag:checkActionInExtendFlag(arg_74_1)
	local var_74_0 = false
	local var_74_1 = false
	local var_74_4

	if not self.extendActionFlag then
		do return var_74_0, var_74_1 end

		local var_74_2 = self.actionTrigger.num
		local var_74_3 = false

		var_74_4 = {}
	end

	var_74_4.name = self.actionTrigger.parameter

	self:onEventCallback(Live2DPainting.EVENT_GET_DRAG_PARAMETER, var_74_4, function(arg_75_0)
		if arg_75_0 > var_74_2[1] and arg_75_0 <= var_74_2[2] then
			var_74_3 = true
		end

		return
	end)

	if not false then
		return var_74_0, var_74_0
	end

	if self.actionTriggerActive.ignore and table.contains(self.actionTriggerActive.ignore, arg_74_1) then
		var_74_0 = true
	end

	if self.actionTriggerActive.enable and table.contains(self.actionTriggerActive.enable, arg_74_1) then
		var_74_1 = true
	end

	return var_74_0, var_74_1
end

function Live2dDrag:setAbleWithFlag(arg_76_1)
	if self.ableFlag ~= arg_76_1 then
		self.ableFlag = arg_76_1

		self:onEventCallback(Live2DPainting.EVENT_ACTION_ABLE, {
			ableFlag = arg_76_1
		})
	end

	return
end

function Live2dDrag:triggerAction()
	self.nextTriggerTime = self.limitTime

	self:setTriggerActionFlag(true)

	return
end

function Live2dDrag:isActionTriggerAble()
	if self.actionTrigger.type == nil then
		return false
	end

	if not self.actionTrigger or self.actionTrigger == "" then
		return false
	end

	if self.nextTriggerTime - Time.deltaTime >= 0 then
		self.nextTriggerTime = self.nextTriggerTime - Time.deltaTime

		return false
	end

	if self.isTriggerAtion then
		return false
	end

	return true
end

function Live2dDrag:updateStateData(arg_79_1)
	if self.l2dIdleIndex ~= arg_79_1.idleIndex then
		if type(self.revertIdleIndex) == "boolean" and self.revertIdleIndex == true then
			self:setTargetValue(self.startValue)

			self.offsetDragX, self.offsetDragY = self.startValue, self.startValue
			self.offsetDragTargetX, self.offsetDragTargetY = self.startValue, self.startValue
		elseif type(self.revertIdleIndex) == "table" and table.contains(self.revertIdleIndex, arg_79_1.idleIndex) then
			self:setTargetValue(self.startValue)

			self.offsetDragTargetX, self.offsetDragTargetY = self.startValue, self.startValue
			self.offsetDragX, self.offsetDragY = self.startValue, self.startValue
		end
	end

	self.lastActionIndex = self.actionListIndex

	if arg_79_1.isPlaying and self.actionTrigger.reset_index_action and arg_79_1.actionName and table.contains(self.actionTrigger.reset_index_action, arg_79_1.actionName) then
		self.actionListIndex = 1
	end

	if self.revertActionIndex and self.lastActionIndex ~= self.actionListIndex then
		self:setTargetValue(self.startValue)
	end

	self.l2dIdleIndex = arg_79_1.idleIndex
	self.l2dIsPlaying = arg_79_1.isPlaying
	self.l2dIgnoreReact = arg_79_1.ignoreReact
	self.l2dPlayActionName = arg_79_1.actionName

	if not self.l2dIsPlaying and self.isTriggerAtion then
		self:setTriggerActionFlag(false)
	end

	if self.l2dIdleIndex and self.idleOn and #self.idleOn > 0 then
		self.reactConditionFlag = not table.contains(self.idleOn, self.l2dIdleIndex)
	end

	if self.l2dIdleIndex and self.idleOff and #self.idleOff > 0 then
		self.reactConditionFlag = table.contains(self.idleOff, self.l2dIdleIndex)
	end

	return
end

function Live2dDrag:checkClickAction()
	if self.firstActive then
		if self.actionTrigger.down then
			if self.actionTrigger.focus == 1 and self.l2dIsPlaying then
				return true
			elseif not self.l2dIsPlaying then
				return true
			end
		else
			self:setAbleWithFlag(true)
		end
	elseif self.firstStop then
		if not self.actionTrigger.down and math.abs(self.mouseInputUp.x - self.mouseInputDown.x) < 30 and math.abs(self.mouseInputUp.y - self.mouseInputDown.y) < 30 and self.mouseInputUpTime - self.mouseInputDownTime < 0.5 then
			if self.actionTrigger.focus == 1 and self.l2dIsPlaying then
				if self.l2dPlayActionName == self.actionTrigger.action then
					self.clickTriggerTime = Time.realtimeSinceStartup + 0.1
				end
			elseif not self.l2dIsPlaying then
				self.clickTriggerTime = Time.realtimeSinceStartup + 0.1
			end
		else
			self:setAbleWithFlag(false)
		end
	elseif self.clickTriggerTime and self.clickTriggerTime > 0 and Time.realtimeSinceStartup >= self.clickTriggerTime then
		self:setAbleWithFlag(false)

		if Time.realtimeSinceStartup - self.clickTriggerTime <= 0.1 then
			print("点击成功" .. self.id)

			self.clickTriggerTime = nil

			return true
		end
	end

	return false
end

function Live2dDrag:saveData()
	if self.revert == -1 and self.saveParameterFlag then
		Live2dConst.SaveDragData(self.id, self.live2dData.skinId, self.live2dData.ship.id, self.parameterTargetValue)
	end

	if self.actionTrigger.type == Live2DPainting.DRAG_CLICK_MANY then
		Live2dConst.SetDragActionIndex(self.id, self.live2dData.skinId, self.live2dData.ship.id, self.actionListIndex)
	end

	if self._relationFlag then
		Live2dConst.SetRelationData(self.id, self.live2dData.skinId, self.live2dData.ship.id, self:getRelationSaveData())
	end

	return
end

function Live2dDrag:getActionTriggerType()
	if self.actionTrigger and self.actionTrigger.type then
		return self.actionTrigger.type
	end

	return nil
end

function Live2dDrag:loadData()
	if self.revert == -1 and self.saveParameterFlag then
		local var_83_0 = Live2dConst.GetDragData(self.id, self.live2dData:GetShipSkinConfig().id, self.live2dData.ship.id)

		if var_83_0 then
			self:setParameterValue(var_83_0)
			self:setTargetValue(var_83_0)
		end

		if var_83_0 == self.startValue and self._relationParameterList and #self._relationParameterList > 0 then
			self:clearRelationValue()
		end
	end

	if self.actionTrigger.type == Live2DPainting.DRAG_CLICK_MANY then
		self.actionListIndex = Live2dConst.GetDragActionIndex(self.id, self.live2dData:GetShipSkinConfig().id, self.live2dData.ship.id) or 1
	end

	if self._relationFlag then
		local var_83_1 = Live2dConst.GetRelationData(self.id, self.live2dData:GetShipSkinConfig().id, self.live2dData.ship.id)

		if var_83_1.drag_x then
			self.offsetDragX = var_83_1.drag_x or self.startValue
		end

		if var_83_1.drag_y then
			self.offsetDragY = var_83_1.drag_y or self.startValue
		end
	end

	return
end

function Live2dDrag:getRelationSaveData()
	return {
		[Live2dConst.RELATION_DRAG_X] = self.offsetDragX,
		[Live2dConst.RELATION_DRAG_Y] = self.offsetDragY
	}
end

function Live2dDrag:clearRelationValue()
	if self._relationParameterList and #self._relationParameterList > 0 then
		for iter_85_0 = 1, #self._relationParameterList do
			if self._relationParameterList[iter_85_0].data.type == Live2DPainting.relation_type_drag_x or self._relationParameterList[iter_85_0].data.type == Live2DPainting.relation_type_drag_y then
				self._relationParameterList[iter_85_0].value = self._relationParameterList[iter_85_0].start or self.startValue or 0
				self._relationParameterList[iter_85_0].enable = true
			end

			self.offsetDragX, self.offsetDragY = self.startValue, self.startValue
		end
	end

	return
end

function Live2dDrag:loadL2dFinal()
	self.loadL2dStep = true

	return
end

function Live2dDrag:clearData()
	if self.revert == -1 then
		self.actionListIndex = 1
		self.delayTargetTime = nil

		self:setParameterValue(self.startValue)
		self:setTargetValue(self.startValue)
		self:clearRelationValue()
	end

	return
end

function Live2dDrag:setTriggerActionFlag(arg_88_1)
	self.isTriggerAtion = arg_88_1

	return
end

function Live2dDrag:dispose()
	self._active = false
	self._parameterCom = nil
	self.parameterValue = self.startValue
	self.parameterTargetValue = 0
	self.parameterSmooth = 0
	self.mouseInputDown = Vector2(0, 0)
	self.data = nil
	self.live2dData = nil
	self.commonData = nil

	return
end

return Live2dDrag
