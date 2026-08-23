local Route = class("Route")
local var_0_1 = g.core.const.ConstMgr.SpineConst

Route.SPEED = 250

function Route:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._route = {}
	self._owner = nil
	self._follow = nil
	self._compFocus = arg_1_3

	self:setOwner(arg_1_1)

	if arg_1_2 then
		self:updateRoute(arg_1_2)
	end
end

function Route:setOwner(arg_2_1)
	self._owner = arg_2_1
end

function Route:updateRoute(arg_3_1)
	self._route = arg_3_1
end

function Route:moveTo(arg_4_1)
	local var_4_0, var_4_1, var_4_2, var_4_3, var_4_4

	if arg_4_1 then
		var_4_0 = arg_4_1.point or {}

		if arg_4_1 then
			var_4_1 = arg_4_1.isAnim or false

			if arg_4_1 then
				var_4_2 = arg_4_1.speed or 1

				if arg_4_1 then
					var_4_3 = arg_4_1.follow or {}

					if arg_4_1 then
						var_4_4 = arg_4_1.finishFunc or nil
					end
				end
			end
		end
	end

	local var_4_5 = Route.SPEED * var_4_2

	self._owner:stopAllFGActions()

	local var_4_6, var_4_7 = self:isInRoute((self._owner:getPosition()))
	local var_4_8, var_4_9 = self:isInRoute(var_4_0)

	if var_4_6 and var_4_8 then
		local var_4_10 = {}

		for iter_4_0 = var_4_7, var_4_9 - 1 do
			table.insert(var_4_10, fgui.FMoveTo:create(math.sqrt((self._route[iter_4_0].y - self._route[iter_4_0 + 1].y) * (self._route[iter_4_0].y - self._route[iter_4_0 + 1].y) + (self._route[iter_4_0].x - self._route[iter_4_0 + 1].x) * (self._route[iter_4_0].x - self._route[iter_4_0 + 1].x)) / var_4_5, {
				x = self._route[iter_4_0 + 1].x,
				y = self._route[iter_4_0 + 1].y
			}))
		end

		if next(var_4_3) then
			for iter_4_1 = 1, #var_4_3 do
				if var_4_3[iter_4_1].target then
					var_4_3[iter_4_1].target:retain()
				end
			end
		end

		table.insert(var_4_10, (fgui.FCallFunc:create(function()
			if var_4_1 then
				if self._owner:getChild("CommonKnight") then
					if self._owner:getChild("CommonKnight"):checkAction(var_0_1.LOOP_ACTION.IDLE) then
						self._owner:getChild("CommonKnight"):playAction(var_0_1.LOOP_ACTION.IDLE)
					end
				elseif self._owner:checkAction(var_0_1.LOOP_ACTION.IDLE) then
					self._owner:playAction(var_0_1.LOOP_ACTION.IDLE)
				end
			end

			if next(var_4_3) then
				for iter_5_0 = 1, #var_4_3 do
					if var_4_3[iter_5_0].target then
						var_4_3[iter_5_0].target:stopAllFGActions()
						var_4_3[iter_5_0].target:release()
					end
				end
			end

			if var_4_4 then
				var_4_4()
			end
		end)))

		if var_4_1 then
			if self._owner:getChild("CommonKnight") then
				if self._owner:getChild("CommonKnight"):checkAction(var_0_1.LOOP_ACTION.RUN) then
					self._owner:getChild("CommonKnight"):playAction(var_0_1.LOOP_ACTION.RUN)
				end
			elseif self._owner:checkAction(var_0_1.LOOP_ACTION.RUN) then
				self._owner:playAction(var_0_1.LOOP_ACTION.RUN)
			end
		end

		self._owner:runFGAction(fgui.FSequence:create(var_4_10))

		if next(var_4_3) then
			for iter_4_2 = 1, #var_4_3 do
				if var_4_3[iter_4_2].isParallax then
					var_4_3[iter_4_2].target:runFGAction(fgui.FParallaxFollow:createWithOffset(self._owner, 0, var_4_3[iter_4_2].yOffset, var_4_3[iter_4_2].rect))
				else
					var_4_3[iter_4_2].target:runFGAction(fgui.FFollow:createWithOffset(self._owner, 0, var_4_3[iter_4_2].yOffset, var_4_3[iter_4_2].rect))
				end
			end
		end
	end
end

function Route:moveFollow(arg_6_1)
	local var_6_0, var_6_1, var_6_2, var_6_3, var_6_4

	if arg_6_1 then
		var_6_0 = arg_6_1.point or {}

		if arg_6_1 then
			var_6_1 = arg_6_1.isAnim or false

			if arg_6_1 then
				var_6_2 = arg_6_1.speed or 1

				if arg_6_1 then
					var_6_3 = arg_6_1.follow or {}

					if arg_6_1 then
						var_6_4 = arg_6_1.finishFunc or nil
					end
				end
			end
		end
	end

	local var_6_5 = arg_6_1.focusRoute or {}
	local var_6_6 = Route.SPEED * var_6_2

	self._owner:stopAllFGActions()

	local var_6_7, var_6_8 = self:isInRoute((self._owner:getPosition()))
	local var_6_9, var_6_10 = self:isInRoute(var_6_0)

	if var_6_7 and var_6_9 then
		local var_6_11 = {}
		local var_6_12 = {}

		for iter_6_0 = var_6_8, var_6_10 - 1 do
			local var_6_13 = math.sqrt((self._route[iter_6_0].y - self._route[iter_6_0 + 1].y) * (self._route[iter_6_0].y - self._route[iter_6_0 + 1].y) + (self._route[iter_6_0].x - self._route[iter_6_0 + 1].x) * (self._route[iter_6_0].x - self._route[iter_6_0 + 1].x)) / var_6_6

			table.insert(var_6_11, fgui.FMoveTo:create(var_6_13, {
				x = self._route[iter_6_0 + 1].x,
				y = self._route[iter_6_0 + 1].y
			}))
			table.insert(var_6_12, fgui.FMoveTo:create(var_6_13, {
				x = var_6_5[iter_6_0 + 1].x,
				y = var_6_5[iter_6_0 + 1].y
			}))
		end

		if next(var_6_3) then
			for iter_6_1 = 1, #var_6_3 do
				if var_6_3[iter_6_1].target then
					var_6_3[iter_6_1].target:retain()
				end
			end
		end

		table.insert(var_6_11, (fgui.FCallFunc:create(function()
			if var_6_1 then
				if self._owner:getChild("CommonKnight") then
					if self._owner:getChild("CommonKnight"):checkAction(var_0_1.LOOP_ACTION.IDLE) then
						self._owner:getChild("CommonKnight"):playAction(var_0_1.LOOP_ACTION.IDLE)
					end
				elseif self._owner:checkAction(var_0_1.LOOP_ACTION.IDLE) then
					self._owner:playAction(var_0_1.LOOP_ACTION.IDLE)
				end
			end

			if next(var_6_3) then
				for iter_7_0 = 1, #var_6_3 do
					if var_6_3[iter_7_0].target then
						var_6_3[iter_7_0].target:stopAllFGActions()
						var_6_3[iter_7_0].target:release()
					end
				end
			end

			if var_6_4 then
				var_6_4()
			end
		end)))

		if var_6_1 then
			if self._owner:getChild("CommonKnight") then
				if self._owner:getChild("CommonKnight"):checkAction(var_0_1.LOOP_ACTION.RUN) then
					self._owner:getChild("CommonKnight"):playAction(var_0_1.LOOP_ACTION.RUN)
				end
			elseif self._owner:checkAction(var_0_1.LOOP_ACTION.RUN) then
				self._owner:playAction(var_0_1.LOOP_ACTION.RUN)
			end
		end

		self._owner:runFGAction(fgui.FSequence:create(var_6_11))
		self._compFocus:runFGAction(fgui.FSequence:create(var_6_12))

		if next(var_6_3) then
			for iter_6_2 = 1, #var_6_3 do
				if var_6_3[iter_6_2].isParallax then
					var_6_3[iter_6_2].target:runFGAction(fgui.FParallaxFollow:createWithOffset(self._compFocus, 0, var_6_3[iter_6_2].yOffset, var_6_3[iter_6_2].rect))
				else
					var_6_3[iter_6_2].target:runFGAction(fgui.FFollow:createWithOffset(self._compFocus, 0, var_6_3[iter_6_2].yOffset, var_6_3[iter_6_2].rect))
				end
			end
		end
	end
end

function Route:moveParallaxNode(arg_8_1)
	local var_8_0, var_8_1, var_8_2, var_8_3

	if arg_8_1 then
		var_8_0 = arg_8_1.point or {}

		if arg_8_1 then
			var_8_1 = arg_8_1.speed or 1

			if arg_8_1 then
				var_8_2 = arg_8_1.finishFunc or nil

				if arg_8_1 then
					var_8_3 = arg_8_1.yOffset or 0
				end
			end
		end
	end

	local var_8_4 = Route.SPEED * var_8_1

	self._owner:stopAllFGActions()

	local var_8_5 = self._owner:getMovePosition()

	var_8_5.y = -var_8_5.y

	local var_8_6, var_8_7 = self:isInRoute(var_8_5)
	local var_8_8, var_8_9 = self:isInRoute(var_8_0)

	if var_8_8 then
		local var_8_10 = {}

		for iter_8_0 = 1, var_8_9 - 1 do
			table.insert(var_8_10, fgui.FParallaxMoveTo:create(math.sqrt((self._route[iter_8_0].y - self._route[iter_8_0 + 1].y) * (self._route[iter_8_0].y - self._route[iter_8_0 + 1].y) + (self._route[iter_8_0].x - self._route[iter_8_0 + 1].x) * (self._route[iter_8_0].x - self._route[iter_8_0 + 1].x)) / var_8_4, {
				x = self._route[iter_8_0 + 1].x,
				y = var_8_3 + self._route[iter_8_0 + 1].y
			}))
		end

		table.insert(var_8_10, (fgui.FCallFunc:create(function()
			if var_8_2 then
				var_8_2()
			end
		end)))
		self._owner:runFGAction(fgui.FSequence:create(var_8_10))
	end
end

function Route:moveToEndOfRoute(arg_10_1)
	local var_10_0, var_10_1, var_10_2, var_10_3, var_10_4, var_10_5

	if arg_10_1 then
		var_10_0 = arg_10_1.isAnim or false

		if arg_10_1 then
			var_10_1 = arg_10_1.speed or 1

			if arg_10_1 then
				var_10_2 = arg_10_1.follow or nil

				if arg_10_1 then
					var_10_3 = arg_10_1.finishFunc or nil

					if arg_10_1 then
						var_10_4 = arg_10_1.standAni or var_0_1.LOOP_ACTION.IDLE

						if arg_10_1 then
							var_10_5 = arg_10_1.runAni or var_0_1.LOOP_ACTION.RUN
						end
					end
				end
			end
		end
	end

	local var_10_6 = self._owner:getScale()

	self._owner:stopAllFGActions()

	local var_10_7 = self._owner:getPosition()
	local var_10_8, var_10_9 = self:isInRoute(var_10_7)
	local var_10_10 = {}

	if not var_10_8 then
		local var_10_11 = self._route[1]
		local var_10_12 = math.sqrt((var_10_7.y - self._route[1].y) * (var_10_7.y - self._route[1].y) + (var_10_7.x - self._route[1].x) * (var_10_7.x - self._route[1].x)) / (Route.SPEED * var_10_1)
		local var_10_13 = var_10_6.x

		var_10_13 = var_10_7.x > self._route[1].x and -math.abs(var_10_6.x) or math.abs(var_10_6.x)

		table.insert(var_10_10, fgui.FSequence:create({
			fgui.FScaleTo:create(0, var_10_13, var_10_6.y),
			fgui.FMoveTo:create(var_10_12, {
				x = var_10_11.x,
				y = var_10_11.y
			})
		}))
	end

	for iter_10_0 = 1, #self._route - 1 do
		local var_10_14 = self._route[iter_10_0 + 1]
		local var_10_15 = math.sqrt((self._route[iter_10_0].y - self._route[iter_10_0 + 1].y) * (self._route[iter_10_0].y - self._route[iter_10_0 + 1].y) + (self._route[iter_10_0].x - self._route[iter_10_0 + 1].x) * (self._route[iter_10_0].x - self._route[iter_10_0 + 1].x)) / (Route.SPEED * var_10_1)
		local var_10_16 = var_10_6.x

		var_10_16 = self._route[iter_10_0].x > self._route[iter_10_0 + 1].x and -math.abs(var_10_6.x) or math.abs(var_10_6.x)

		local var_10_17 = {
			fgui.FScaleTo:create(0, var_10_16, var_10_6.y),
			fgui.FMoveTo:create(var_10_15, {
				x = var_10_14.x,
				y = var_10_14.y
			})
		}

		if var_10_14.func then
			table.insert(var_10_17, (fgui.FCallFunc:create(function()
				var_10_14.func(iter_10_0 + 1)
			end)))
		end

		table.insert(var_10_10, fgui.FSequence:create(var_10_17))
	end

	table.insert(var_10_10, (fgui.FCallFunc:create(function()
		if var_10_0 then
			self._owner:getChild("CommonKnight"):playAction(var_10_4)
		end

		if var_10_2 then
			var_10_2.target:stopAllFGActions()
		end

		if var_10_3 then
			var_10_3()
		end
	end)))

	if var_10_0 then
		self._owner:getChild("CommonKnight"):playAction(var_10_5)
	end

	self._owner:runFGAction(fgui.FSequence:create(var_10_10))

	if var_10_2 then
		var_10_2.target:runFGAction(fgui.FFollow:createWithOffset(self._owner, var_10_2.xOffset, var_10_2.yOffset, var_10_2.rect))
	end
end

function Route:moveContinue(arg_13_1)
	local var_13_0, var_13_1, var_13_2, var_13_3, var_13_4, var_13_5

	if arg_13_1 then
		var_13_0 = arg_13_1.isAnim or false

		if arg_13_1 then
			var_13_1 = arg_13_1.speed or 1

			if arg_13_1 then
				var_13_2 = arg_13_1.follow or nil

				if arg_13_1 then
					var_13_3 = arg_13_1.finishFunc or nil

					if arg_13_1 then
						var_13_4 = arg_13_1.startIndex or 1

						if arg_13_1 then
							var_13_5 = arg_13_1.isReverse or false
						end
					end
				end
			end
		end
	end

	local var_13_6 = self._owner:getScale()
	local var_13_7 = Route.SPEED * var_13_1

	self._owner:stopAllFGActions()

	local var_13_8 = self._owner:getPosition()

	if var_13_4 < 1 then
		return
	end

	local var_13_9 = {}

	if var_13_5 then
		for iter_13_0 = var_13_4, 1, -1 do
			table.insert(var_13_9, self._route[iter_13_0])
		end
	else
		for iter_13_1 = var_13_4, #self._route do
			table.insert(var_13_9, self._route[iter_13_1])
		end
	end

	local var_13_10 = {}

	for iter_13_2 = 1, #var_13_9 - 1 do
		local var_13_11 = var_13_9[iter_13_2 + 1]
		local var_13_12 = math.sqrt((var_13_9[iter_13_2].y - var_13_9[iter_13_2 + 1].y) * (var_13_9[iter_13_2].y - var_13_9[iter_13_2 + 1].y) + (var_13_9[iter_13_2].x - var_13_9[iter_13_2 + 1].x) * (var_13_9[iter_13_2].x - var_13_9[iter_13_2 + 1].x)) / var_13_7
		local var_13_13 = var_13_6.x

		var_13_13 = var_13_9[iter_13_2].x > var_13_9[iter_13_2 + 1].x and -math.abs(var_13_6.x) or math.abs(var_13_6.x)

		local var_13_14 = {
			fgui.FScaleTo:create(0, var_13_13, var_13_6.y),
			fgui.FMoveTo:create(var_13_12, {
				x = var_13_11.x,
				y = var_13_11.y
			})
		}

		if var_13_11.func then
			table.insert(var_13_14, (fgui.FCallFunc:create(function()
				var_13_11.func((var_13_5 or nil) and #var_13_9 - iter_13_2)
			end)))
		end

		table.insert(var_13_10, fgui.FSequence:create(var_13_14))
	end

	table.insert(var_13_10, (fgui.FCallFunc:create(function()
		if var_13_0 then
			self._owner:playAction(var_0_1.LOOP_ACTION.IDLE)
		end

		if var_13_2 then
			var_13_2.target:stopAllFGActions()
		end

		if var_13_3 then
			var_13_3()
		end
	end)))

	if var_13_0 then
		self._owner:playAction(var_0_1.LOOP_ACTION.RUN)
	end

	self._owner:runFGAction(fgui.FSequence:create(var_13_10))

	if var_13_2 then
		var_13_2.target:runFGAction(fgui.FFollow:createWithOffset(self._owner, var_13_2.xOffset, var_13_2.yOffset, var_13_2.rect))
	end
end

function Route:moveCycle(arg_16_1)
	local var_16_0, var_16_1, var_16_2, var_16_3

	if arg_16_1 then
		var_16_0 = arg_16_1.isAnim or false

		if arg_16_1 then
			var_16_1 = arg_16_1.speed or 1

			if arg_16_1 then
				var_16_2 = arg_16_1.follow or nil

				if arg_16_1 then
					var_16_3 = arg_16_1.startIndex or 1
				end
			end
		end
	end

	local var_16_4 = self._owner:getScale()
	local var_16_5 = Route.SPEED * var_16_1

	self._owner:stopAllFGActions()

	if var_16_3 < 1 then
		return
	end

	local var_16_6 = {}

	if var_16_3 == 1 then
		var_16_6 = self._route
	else
		local var_16_7 = #self._route - var_16_3 + 1

		for iter_16_0 = 1, #self._route do
			table.insert(var_16_6, self._route[iter_16_0 <= var_16_7 and iter_16_0 + var_16_3 - 1 or iter_16_0 - var_16_7])
		end
	end

	table.insert(var_16_6, var_16_6[1])

	local function var_16_10()
		local var_17_0 = {}

		for iter_17_0 = 1, #var_16_6 - 1 do
			local var_17_1 = var_16_6[iter_17_0 + 1]
			local var_17_2 = math.sqrt((var_16_6[iter_17_0].y - var_16_6[iter_17_0 + 1].y) * (var_16_6[iter_17_0].y - var_16_6[iter_17_0 + 1].y) + (var_16_6[iter_17_0].x - var_16_6[iter_17_0 + 1].x) * (var_16_6[iter_17_0].x - var_16_6[iter_17_0 + 1].x)) / var_16_5
			local var_17_3 = var_16_4.x

			var_17_3 = var_16_6[iter_17_0].x > var_16_6[iter_17_0 + 1].x and -math.abs(var_16_4.x) or math.abs(var_16_4.x)

			local var_17_4 = {
				fgui.FScaleTo:create(0, var_17_3, var_16_4.y),
				fgui.FMoveTo:create(var_17_2, {
					x = var_17_1.x,
					y = var_17_1.y
				})
			}
			local var_17_5

			if var_17_1.func then
				table.insert(var_17_4, (fgui.FCallFunc:create(function()
					var_17_1.func()
				end)))

				var_17_5 = var_17_0
			end

			table.insert(var_17_0, (fgui.FSequence:create(var_17_4)))
		end

		if var_16_0 then
			self._owner:playAction(var_0_1.LOOP_ACTION.RUN)
		end

		table.insert(var_17_0, fgui.FCallFunc:create(var_16_10))
		self._owner:runFGAction(fgui.FSequence:create(var_17_0))
	end

	;(nil)()

	if var_16_2 then
		var_16_2.target:runFGAction(fgui.FFollow:createWithOffset(self._owner, var_16_2.xOffset, var_16_2.yOffset, var_16_2.rect))
	end
end

function Route:moveBy(arg_19_1)
	local var_19_0, var_19_1, var_19_2

	if arg_19_1 then
		var_19_0 = arg_19_1.step or 0

		if arg_19_1 then
			var_19_1 = arg_19_1.isAnim or false

			if arg_19_1 then
				var_19_2 = arg_19_1.speed or Route.SPEED
			end
		end
	end

	local var_19_3 = Route.SPEED * var_19_2

	self._owner:stopAllFGActions()

	if var_19_0 <= 0 then
		return
	end

	local var_19_4, var_19_5 = self:isInRoute((self._owner:getPosition()))

	if var_19_4 then
		local var_19_6 = {}

		for iter_19_0 = var_19_5, var_19_5 + var_19_0 - 1 do
			table.insert(var_19_6, fgui.FMoveTo:create(math.sqrt((self._route[iter_19_0].y - self._route[iter_19_0 + 1].y) * (self._route[iter_19_0].y - self._route[iter_19_0 + 1].y) + (self._route[iter_19_0].x - self._route[iter_19_0 + 1].x) * (self._route[iter_19_0].x - self._route[iter_19_0 + 1].x)) / var_19_3, {
				x = self._route[iter_19_0 + 1].x,
				y = self._route[iter_19_0 + 1].y
			}))
		end

		if var_19_1 then
			table.insert(var_19_6, (fgui.FCallFunc:create(function()
				self._owner:getChildAt(0):playReadyAction()
			end)))
			self._owner:getChildAt(0):playRunAction()
		end

		self._owner:runFGAction(fgui.FSequence:create(var_19_6))
	end
end

function Route:stop()
	self._owner:stopAllFGActions()
end

function Route:isInRoute(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(self._route) do
		if tonumber(string.format("%.2f", iter_22_1.x)) == tonumber(string.format("%.2f", arg_22_1.x)) and tonumber(string.format("%.2f", iter_22_1.y)) == tonumber(string.format("%.2f", arg_22_1.y)) then
			return true, iter_22_0
		end
	end

	return false
end

return Route
