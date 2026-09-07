local IslandTradeRank = class("IslandTradeRank")

function IslandTradeRank:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.value = arg_1_1.value
	self.skinId = arg_1_1.skinId
	self.islandLevel = arg_1_1.islandLevel
	self.name = arg_1_1.name

	return
end

function IslandTradeRank:IsVaild()
	return self.value > 0
end

function IslandTradeRank:IsSelf()
	return self.id == getProxy(PlayerProxy):getRawData().id
end

function IslandTradeRank:SetValue(arg_4_1)
	self.value = arg_4_1

	return
end

return IslandTradeRank
