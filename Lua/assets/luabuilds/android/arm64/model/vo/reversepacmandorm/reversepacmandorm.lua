local ReversePacmanDorm = class("ReversePacmanDorm", import("model.vo.Dorm.Dorm"))

function ReversePacmanDorm:Ctor(arg_1_1)
	ReversePacmanDorm.super.Ctor(self, arg_1_1)

	self.reversePacmanShips = {}

	return
end

function ReversePacmanDorm:GetMapSize()
	return Vector4(0, 0, BackYardConst.MAX_REVERSE_PACMAN_MAP_SIZE.x, BackYardConst.MAX_REVERSE_PACMAN_MAP_SIZE.y)
end

function ReversePacmanDorm:GetPutFurnitureList(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {
		id = -1
	}

	var_3_1.furniture_put_list = require("GameCfg.backyardTheme.theme_reverse_pacman").furnitures or {}

	local var_3_2 = ReversePacmanThemeTemplate.New(var_3_1, 1, self:GetMapSize())

	for iter_3_0, iter_3_1 in pairs(var_3_2 and var_3_2:GetAllFurniture() or {}) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, BackyardThemeFurniture._LoadWeight)

	return var_3_0
end

function ReversePacmanDorm:GetBayShipOnFloor(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.reversePacmanShips) do
		table.insert(var_4_0, iter_4_1)
	end

	return var_4_0
end

function ReversePacmanDorm:AddShip(arg_5_1)
	table.insert(self.reversePacmanShips, arg_5_1)

	return
end

return ReversePacmanDorm
