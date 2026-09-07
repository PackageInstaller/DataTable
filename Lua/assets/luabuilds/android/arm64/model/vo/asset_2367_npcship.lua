local NpcShip = class("NpcShip", import(".Ship"))

function NpcShip:Ctor(arg_1_1)
	NpcShip.super.Ctor(self, arg_1_1)

	for iter_1_0 = 1, 3 do
		self.equipments[iter_1_0] = self.equipments[iter_1_0] or pg.ship_data_template[self.configId]["equip_id_" .. iter_1_0] > 0 and Equipment.New({
			id = pg.ship_data_template[self.configId]["equip_id_" .. iter_1_0]
		}) or false
	end

	self.isNpc = true

	return
end

function NpcShip:getExp()
	return 0
end

function NpcShip:addExp(arg_3_1, arg_3_2)
	return
end

function NpcShip:getIntimacy()
	return pg.intimacy_template[self:getIntimacyLevel()].lower_bound
end

function NpcShip:getIntimacyLevel()
	return 2
end

function NpcShip:setIntimacy(arg_6_1)
	return
end

function NpcShip:getEnergy()
	return pg.ship_data_template[self.configId].energy
end

function NpcShip:setEnergy(arg_8_1)
	return
end

return NpcShip
