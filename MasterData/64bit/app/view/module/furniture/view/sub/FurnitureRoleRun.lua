local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local FurnitureRoleRun = class("FurnitureRoleRun")

function FurnitureRoleRun:ctor(arg_1_1)
	self._roleObject = arg_1_1.obj
	self._MAP_TILE_HW = var_0_1.FURNITURE_GRID_WIDTH / 2
	self._MAP_TILE_HH = var_0_1.FURNITURE_GRID_HEIGHT / 2
end

function FurnitureRoleRun:setRouteData(arg_2_1)
	self._route = arg_2_1
end

function FurnitureRoleRun:_updateRoleRunAction()
	if self._roleObject and #self._route > 0 then
		self:_refreshRoleZorder()

		self._schedule = self._roleObject:newSchedule(handler(self, self._onUpdate), 1)

		self:moveContinue({
			speed = 0.2,
			isAnim = true,
			finishFunc = handler(self, function()
				self:_cancelRunSchedule()
			end)
		})
	end
end

function FurnitureRoleRun:_onUpdate()
	if self._roleObject then
		self:_refreshRoleZorder()
	end
end

function FurnitureRoleRun:_refreshRoleZorder()
	local var_6_0 = self._roleObject:getPosition()
	local var_6_1, var_6_2 = self:pixelToCoord(var_6_0.x, -var_6_0.y)

	self._roleObject:setRolePlaceCoordXY(var_6_1, var_6_2)
	self._roleObject:dispatchCompEvent("ROLE_RUN_UPDATE_Z_ORDER")
end

function FurnitureRoleRun:moveContinue(arg_7_1)
	local var_7_0, var_7_1, var_7_2

	if arg_7_1 then
		var_7_0 = arg_7_1.isAnim or false

		if arg_7_1 then
			var_7_1 = arg_7_1.finishFunc or nil

			if arg_7_1 then
				var_7_2 = arg_7_1.speed or 1
			end
		end
	end

	local var_7_3 = self._roleObject:getScale()

	self._roleObject:stopAllFGActions()

	local var_7_4 = {}

	for iter_7_0 = 1, #self._route do
		table.insert(var_7_4, self._route[iter_7_0])
	end

	local var_7_5 = {}

	for iter_7_1 = 1, #var_7_4 - 1 do
		local var_7_6 = var_7_4[iter_7_1 + 1]
		local var_7_7 = math.sqrt((var_7_4[iter_7_1].y - var_7_4[iter_7_1 + 1].y) * (var_7_4[iter_7_1].y - var_7_4[iter_7_1 + 1].y) + (var_7_4[iter_7_1].x - var_7_4[iter_7_1 + 1].x) * (var_7_4[iter_7_1].x - var_7_4[iter_7_1 + 1].x)) / (250 * var_7_2)
		local var_7_8 = var_7_3.x
		local var_7_9

		if var_7_4[iter_7_1].x > var_7_4[iter_7_1 + 1].x then
			var_7_8 = -math.abs(var_7_3.x)
		else
			var_7_8 = math.abs(var_7_3.x)
			var_7_9 = var_7_5
		end

		table.insert(var_7_5, fgui.FSequence:create({
			fgui.FCallFunc:create(function()
				if self._roleObject.setSpin then
					self._roleObject:setSpin(var_7_8)
				end
			end),
			fgui.FMoveTo:create(var_7_7, {
				x = var_7_6.x,
				y = var_7_6.y
			})
		}))
	end

	table.insert(var_7_5, (fgui.FCallFunc:create(function()
		if var_7_0 then
			self._roleObject:getChild("roleHolderComp"):getChild("CommonKnight"):playAction(var_0_0.LOOP_ACTION.IDLE)
		end

		if var_7_1 then
			var_7_1()
		end
	end)))

	if var_7_0 then
		self._roleObject:getChild("roleHolderComp"):getChild("CommonKnight"):playAction(var_0_0.LOOP_ACTION.WALK)
	end

	self._roleObject:runFGAction(fgui.FSequence:create(var_7_5))
end

function FurnitureRoleRun:pixelToCoord(arg_10_1, arg_10_2)
	return math.round((arg_10_1 / self._MAP_TILE_HW + -(arg_10_2 + self._MAP_TILE_HH) / self._MAP_TILE_HH) / 2), math.round((-(arg_10_2 + self._MAP_TILE_HH) / self._MAP_TILE_HH - arg_10_1 / self._MAP_TILE_HW) / 2)
end

function FurnitureRoleRun:_cancelRunSchedule()
	if self._schedule then
		self._roleObject:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function FurnitureRoleRun:onUnload()
	self:_cancelRunSchedule()
end

return FurnitureRoleRun
