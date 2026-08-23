local var_0_0
local var_0_1 = cc.size(20, 20)
local var_0_2 = {
	setMapTiledSize = function(arg_1_0)
		var_0_0 = arg_1_0
	end,
	getMapTiledSize = function()
		return var_0_0
	end,
	setRoomSize = function(arg_3_0)
		var_0_1 = arg_3_0
	end,
	getRoomSize = function()
		return var_0_1
	end,
	getWorldPosByGlobalCoordinate = function(self)
		return (self.x - self.y) * (var_0_0.width / 2), -(self.x + self.y) * (var_0_0.height / 2)
	end,
	getGlobalCoordinateByWorldPos = function(self)
		return math.round((self.x / (var_0_0.width / 2) + -self.y / (var_0_0.height / 2)) / 2), math.round((-self.y / (var_0_0.height / 2) - self.x / (var_0_0.width / 2)) / 2)
	end
}

function var_0_2:getGlobalCoordinateByRoomAndRoomCoordinate(arg_7_1)
	local var_7_0, var_7_1 = self:getRoomCoordinate()

	return var_0_2.getGlobalCoordinateByRoomPosAndRoomCoordinate(var_7_0, var_7_1, arg_7_1)
end

function var_0_2.getGlobalCoordinateByRoomPosAndRoomCoordinate(arg_8_0, arg_8_1, arg_8_2)
	return (arg_8_0 - 1) * var_0_1.width + arg_8_2.x, (arg_8_1 - 1) * var_0_1.height + arg_8_2.y
end

function var_0_2:getRoomCoordinateAndCoordinateByGlobalCoordinate()
	local var_9_0 = cc.p(0, 0)

	var_9_0.x = math.ceil((self.x + 1) / var_0_1.width)
	var_9_0.y = math.ceil((self.y + 1) / var_0_1.height)

	local var_9_1 = cc.p(0, 0)

	var_9_1.x = self.x - (var_9_0.x - 1) * var_0_1.width
	var_9_1.y = self.y - (var_9_0.y - 1) * var_0_1.height

	return var_9_0, var_9_1
end

function var_0_2:coordToCompPos()
	return (self.x - self.y) * (var_0_0.width / 2) + display.width / 2, -(-(self.x + self.y) * (var_0_0.height / 2)) + display.height / 2
end

function var_0_2:compPosToCoord()
	return -math.round(((display.height / 2 - self.y) / (var_0_0.height / 2) - (self.x - display.width / 2) / (var_0_0.width / 2)) / 2), -math.round((self.x - display.width / 2) / (var_0_0.width / 2) + ((display.height / 2 - self.y) / (var_0_0.height / 2) - (self.x - display.width / 2) / (var_0_0.width / 2)) / 2)
end

return var_0_2
