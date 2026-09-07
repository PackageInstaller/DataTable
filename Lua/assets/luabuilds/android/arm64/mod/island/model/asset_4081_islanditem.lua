local IslandItem = class("IslandItem", import("model.vo.BaseVO"))

IslandItem.TYPE_MATERIAL = 1
IslandItem.TYPE_PROP = 2
IslandItem.TYPE_SPECIAL_PROP = 3
IslandItem.TYPE_SHIP_EXP_BOOK = 5
IslandItem.GOLD_ID = 1
IslandItem.PEARL_ID = 9900

function IslandItem:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.num or arg_1_1.number or arg_1_1.count or 1
	self.time = arg_1_1.time or 0

	return
end

function IslandItem:GetNumberOfSlotsOccupied()
	if not self:IsMaterial() then
		return 0
	end

	if self.count <= 0 then
		return 0
	end

	local var_2_0 = self:getConfig("group_max")

	if var_2_0 == 0 then
		return 1
	else
		return math.ceil(self.count / var_2_0)
	end

	return
end

function IslandItem:bindConfigTable()
	return pg.island_item_data_template
end

function IslandItem:GetCount()
	return self.count
end

function IslandItem:CanRemove(arg_5_1)
	return arg_5_1 <= self:GetCount()
end

function IslandItem:ReduceCount(arg_6_1)
	self.count = self.count - arg_6_1

	return
end

function IslandItem:IncreaseCount(arg_7_1)
	self.count = self.count + arg_7_1

	return
end

function IslandItem:IsNotOwned()
	return self.count <= 0
end

function IslandItem:IsInvitationLetter()
	return IslandItem.StaticGetUsageType(self.configId) == IslandItemUsage.usage_island_invitation
end

function IslandItem:GetName()
	return self:getConfig("name")
end

function IslandItem:GetType()
	return self:getConfig("type")
end

function IslandItem:GetRarity()
	return self:getConfig("rarity")
end

function IslandItem:GetDesc()
	return self:getConfig("desc")
end

function IslandItem:GetIcon()
	return self:getConfig("icon")
end

function IslandItem:GetUseArg()
	return IslandItem.StaticGetUsageArg(self.configId)
end

function IslandItem:GetOwnTime()
	return self.time
end

function IslandItem:IsMaterial()
	return self:GetType() == IslandItem.TYPE_MATERIAL
end

function IslandItem:IsProp()
	return self:GetType() == IslandItem.TYPE_PROP or self:GetType() == IslandItem.TYPE_SHIP_EXP_BOOK
end

function IslandItem:IsSpecialProp()
	return self:GetType() == IslandItem.TYPE_SPECIAL_PROP
end

function IslandItem:IsFishingProp()
	return IslandItem.StaticGetUsageType(self.configId) == IslandItemUsage.usage_fishing
end

function IslandItem:GetMaterialFacility()
	if not self:IsMaterial() then
		return ""
	end

	return ""
end

function IslandItem:CanConvert()
	return self:getConfig("convert") == 1
end

function IslandItem:GetConvertPt()
	return self:getConfig("pt_num")
end

function IslandItem:StaticGetMapUsageList()
	return pg.island_item_data_template.get_id_list_by_usage[self] or {}
end

function IslandItem:StaticGetUsageArg()
	return pg.island_item_data_template[self].usage_arg
end

function IslandItem:StaticGetUsageType()
	return pg.island_item_data_template[self].usage
end

function IslandItem:GetAcquiringWay()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(pg.island_item_data_template[self.configId].jump_page) do
		table.insert(var_27_0, iter_27_1)
	end

	return var_27_0
end

return IslandItem
