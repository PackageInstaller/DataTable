local IslandCardDiyAgency = class("IslandCardDiyAgency", import(".IslandBaseAgency"))

function IslandCardDiyAgency:OnInit(arg_1_1)
	self.data = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.image_list) do
		self.data[iter_1_1.id] = IslandCardDiy.New(iter_1_1)
	end

	self.data[pg.island_set.island_card_photo_default.key_value_int] = self.data[pg.island_set.island_card_photo_default.key_value_int] or IslandCardDiy.New({
		num = 1,
		id = pg.island_set.island_card_photo_default.key_value_int
	})

	return
end

function IslandCardDiyAgency:GetData()
	return self.data
end

function IslandCardDiyAgency:GetIds()
	return underscore.keys(self.data)
end

function IslandCardDiyAgency:GetIdCount(arg_4_1)
	return (self.data[arg_4_1] or nil) and (self.data[arg_4_1].count or 0)
end

function IslandCardDiyAgency:AddCardDiy(arg_5_1)
	if self.data[arg_5_1.id] then
		self.data[arg_5_1.id]:AddCount(arg_5_1.num)
	else
		self.data[arg_5_1.id] = IslandCardDiy.New(arg_5_1)
	end

	return
end

return IslandCardDiyAgency
