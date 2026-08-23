local var_0_0 = {
	height = 10,
	width = 10
}

return {
	setMapTiledSize = function(arg_1_0)
		var_0_0 = arg_1_0
	end,
	getMapTiledSize = function()
		return var_0_0
	end,
	getWorldPosByGlobalCoordinate = function(self)
		return (self.x - self.y) * (var_0_0.width / 2), -(self.x + self.y) * (var_0_0.height / 2)
	end,
	getGlobalCoordinateByWorldPos = function(self)
		return math.round((self.x / (var_0_0.width / 2) + -self.y / (var_0_0.height / 2)) / 2), math.round((-self.y / (var_0_0.height / 2) - self.x / (var_0_0.width / 2)) / 2)
	end,
	coordToCompPos = function(self)
		return (self.x - self.y) * (var_0_0.width / 2) + display.width / 2, -(-(self.x + self.y) * (var_0_0.height / 2)) + display.height / 2
	end,
	compPosToCoord = function(self)
		return -math.round(((display.height / 2 - self.y) / (var_0_0.height / 2) - (self.x - display.width / 2) / (var_0_0.width / 2)) / 2), -math.round((self.x - display.width / 2) / (var_0_0.width / 2) + ((display.height / 2 - self.y) / (var_0_0.height / 2) - (self.x - display.width / 2) / (var_0_0.width / 2)) / 2)
	end
}
