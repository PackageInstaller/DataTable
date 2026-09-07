local SharedIsland = class("SharedIsland", import(".BaseIsland"))

function SharedIsland:Ctor(arg_1_1)
	SharedIsland.super.Ctor(self, arg_1_1.public_data)
	self:HandleAgora()

	self.mapID = pg.island_set.initial_visitor_scene.key_value_int

	self:SetSpawnPointId(pg.island_set.initial_visitor_spawn_point.key_value_int)

	return
end

function SharedIsland:HandleAgora()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(pg.island_furniture_template.all) do
		table.insert(var_2_0, {
			id = iter_2_1,
			count = pg.island_furniture_template[iter_2_1].setNum
		})
	end

	self:GetAgoraAgency():InitPrivateData({
		furniture_list = var_2_0
	})

	return
end

return SharedIsland
