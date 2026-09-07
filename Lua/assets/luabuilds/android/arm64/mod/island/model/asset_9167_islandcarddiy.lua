local IslandCardDiy = class("IslandCardDiy", import("model.vo.BaseVO"))

function IslandCardDiy:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.num or 1

	return
end

function IslandCardDiy:bindConfigTable()
	return pg.island_card_diy
end

function IslandCardDiy:AddCount(arg_3_1)
	self.count = self.count + arg_3_1

	return
end

return IslandCardDiy
