local var_0_0 = g.core.config.furniture_info
local var_0_1 = g.core.config.furniture_limit_info
local var_0_2 = g.core.const.ConstMgr.FurnitureConst
local var_0_3 = g.core.common.ServerTime
local FurnitureStruct = class("FurnitureStruct")

function FurnitureStruct:ctor(arg_1_1)
	self._info = {}

	self:updateData(arg_1_1)
end

function FurnitureStruct:updateData(arg_2_1)
	table.merge(self, arg_2_1)

	self._info = var_0_0.get(self.furniture_id)

	self:_updateSvrDefinitionLevel()
end

function FurnitureStruct:getInfo()
	return self._info
end

function FurnitureStruct:getFurnitureType()
	return self._info.type
end

function FurnitureStruct:isSpin()
	return self.is_spin == 1
end

function FurnitureStruct:setSpin(arg_6_1)
	if self:isSpin() ~= arg_6_1 then
		self.is_spin = arg_6_1 and 1 or 0

		self:_updateSvrDefinitionLevel()
	end
end

function FurnitureStruct:_updateSvrDefinitionLevel()
	if self._info.type == var_0_2.FURNITURE_TYPE.WALL_DECORATION then
		self.level = self:isSpin() and var_0_2.SVR_DEFINITION_LEVEL.WALL_DECORATION_RIGHT or var_0_2.SVR_DEFINITION_LEVEL.WALL_DECORATION_LEFT
	end
end

function FurnitureStruct:setGridPos(arg_8_1, arg_8_2)
	if arg_8_1 and arg_8_2 then
		self.x, self.y = arg_8_1, arg_8_2
	end
end

function FurnitureStruct:getCDEndTime()
	return self.cd or 0
end

function FurnitureStruct:getCDTotalTime()
	return var_0_1.get(self._info.type).limit_time
end

function FurnitureStruct:getCDProgress()
	local var_11_0 = self:getCDEndTime()
	local var_11_1 = self:getCDTotalTime()

	if var_11_1 <= 0 then
		return
	elseif var_11_0 <= var_0_3:getTime() then
		return 100
	else
		return math.floor(math.max(0, var_11_1 - (var_11_0 - var_0_3:getTime())) / var_11_1 * 100)
	end
end

function FurnitureStruct:isCDOver()
	if self:getCDTotalTime() <= 0 then
		return true
	else
		return self:getCDEndTime() <= var_0_3:getTime()
	end
end

function FurnitureStruct:getEditId()
	return tonumber(self.furniture_id .. self.is_spin .. self.level .. self.x .. self.y)
end

function FurnitureStruct:getNames()
	return var_0_2.FURNITURE_NAMES_PREFIX .. self:getEditId()
end

function FurnitureStruct:getDataFormatSvrNeed()
	return {
		furniture_id = self.furniture_id,
		x = self.x,
		y = self.y,
		is_spin = self.is_spin,
		level = self.level
	}
end

function FurnitureStruct:isSame(arg_16_1)
	if arg_16_1 then
		return arg_16_1.furniture_id == self.furniture_id and arg_16_1.is_spin == self.is_spin and arg_16_1.x == self.x and arg_16_1.y == self.y
	else
		return false
	end
end

return FurnitureStruct
