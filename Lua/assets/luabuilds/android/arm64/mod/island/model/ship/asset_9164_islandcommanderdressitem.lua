local IslandCommanderDressItem = class("IslandCommanderDressItem", import("model.vo.BaseVO"))

function IslandCommanderDressItem:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.state = arg_1_1.state
	self.color = arg_1_1.color
	self.color_list = arg_1_1.color_list or {}

	return
end

function IslandCommanderDressItem:SetReadState(arg_2_1)
	self.state = arg_2_1

	return
end

function IslandCommanderDressItem:ChangeColor(arg_3_1)
	self.color = arg_3_1

	return
end

function IslandCommanderDressItem:CheckColorIsOwned(arg_4_1)
	if arg_4_1 == 0 then
		return true
	end

	for iter_4_0, iter_4_1 in ipairs(self.color_list) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function IslandCommanderDressItem:AddDressColor(arg_5_1)
	table.insert(self.color_list, arg_5_1)

	return
end

function IslandCommanderDressItem:bindConfigTable()
	return pg.island_dress_template
end

function IslandCommanderDressItem:GetSortValue(arg_7_1, arg_7_2)
	local var_7_0 = 0

	var_7_0 = arg_7_1 == IslandShipDressUpPageNew.SORT_RARITY and self:GetRarity() or self.id

	return arg_7_2 == 1 and var_7_0 or -1 * var_7_0
end

function IslandCommanderDressItem:GetRarity()
	return self:getConfig("quality")
end

return IslandCommanderDressItem
