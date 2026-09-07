local IslandIllustration = class("IslandIllustration", import("model.vo.BaseVO"))

IslandIllustration.TYPES = {
	NPC = 2,
	ITEM = 3,
	FISH = 4,
	CHAR = 1
}
IslandIllustration.STATUS = {
	UNLOCK = 3,
	LOCK = 1,
	CAN_UNLOCK = 2
}

function IslandIllustration:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = arg_1_1
	self.status = IslandIllustration.STATUS.LOCK
	self.isTip = false
	self.basePoint = 0
	self.levelPoints = 0
	self.levelPointGotData = {}
	self.starPoints = 0
	self.starPointGotData = {}

	self:InitConfigData()

	return
end

function IslandIllustration:bindConfigTable()
	return pg.island_illustrated_guide
end

function IslandIllustration:InitConfigData()
	return
end

function IslandIllustration:bindLinkConfigTable()
	return switch(self:getConfig("type"), {
		[IslandIllustration.TYPES.CHAR] = function()
			return pg.island_chara_template
		end,
		[IslandIllustration.TYPES.NPC] = function()
			return pg.island_unit_character
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return pg.island_item_data_template
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return pg.island_fish
		end
	})
end

function IslandIllustration:GetLinkConfigID()
	return self:getConfig("unlock_id")
end

function IslandIllustration:getLinkConfigTable()
	local var_10_0 = self:bindLinkConfigTable()

	assert(var_10_0, "should bindLinkConfigTable() first: " .. self.__cname)

	return var_10_0[self:GetLinkConfigID()]
end

function IslandIllustration:getLinkConfig(arg_11_1)
	local var_11_0 = self:getLinkConfigTable()

	assert(var_11_0 ~= nil, "LinkConfig missed, type -" .. self.__cname .. " configId: " .. tostring(self.configId))

	return var_11_0[arg_11_1]
end

function IslandIllustration:GetName()
	return switch(self:getConfig("type"), {
		[IslandIllustration.TYPES.CHAR] = function()
			return pg.island_unit_character[self:getLinkConfig("unit_id")].name
		end,
		[IslandIllustration.TYPES.NPC] = function()
			return self:getLinkConfig("name")
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return self:getLinkConfig("name")
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return self:getLinkConfig("name")
		end
	})
end

function IslandIllustration:GetEnName()
	return switch(self:getConfig("type"), {
		[IslandIllustration.TYPES.CHAR] = function()
			return pg.island_unit_character[self:getLinkConfig("unit_id")].english_name
		end,
		[IslandIllustration.TYPES.NPC] = function()
			return self:getLinkConfig("english_name")
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return ""
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return ""
		end
	})
end

function IslandIllustration:GetDesc()
	return switch(self:getConfig("type"), {
		[IslandIllustration.TYPES.CHAR] = function()
			return pg.island_unit_character[self:getLinkConfig("unit_id")].describe_illustrated_guid
		end,
		[IslandIllustration.TYPES.NPC] = function()
			return self:getLinkConfig("describe_illustrated_guid")
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return self:getLinkConfig("desc")
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return pg.island_item_data_template[self:getLinkConfig("item_id")].desc
		end
	})
end

function IslandIllustration:GetIcon()
	return switch(self:getConfig("type"), {
		[IslandIllustration.TYPES.CHAR] = function()
			return "ShipYardIcon/" .. IslandShip.StaticGetPrefab((self:GetLinkConfigID()))
		end,
		[IslandIllustration.TYPES.NPC] = function()
			return "island/IslandCharIcon/" .. self:getLinkConfig("rendering")
		end,
		[IslandIllustration.TYPES.ITEM] = function()
			return "island/" .. self:getLinkConfig("icon")
		end,
		[IslandIllustration.TYPES.FISH] = function()
			return "island/" .. pg.island_item_data_template[self:getLinkConfig("item_id")].icon
		end
	})
end

function IslandIllustration:SetPointData(arg_32_1)
	self.basePoint = arg_32_1.base
	self.levelPoints = 0
	self.levelPointGotData = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.lv_list) do
		self.levelPoints = self.levelPoints + iter_32_1.value
		self.levelPointGotData[iter_32_1.lv] = iter_32_1.value
	end

	self.starPoints = 0
	self.starPointGotData = {}

	for iter_32_2, iter_32_3 in ipairs(arg_32_1.star_list) do
		self.starPoints = self.starPoints + iter_32_3.value
		self.starPointGotData[iter_32_3.lv] = iter_32_3.value
	end

	return
end

function IslandIllustration:SetStatus(arg_33_1)
	self.status = arg_33_1

	if self.status == IslandIllustration.STATUS.CAN_UNLOCK then
		self.isTip = true
	elseif self.status == IslandIllustration.STATUS.UNLOCK then
		self.basePoint = self:getConfig("collect_add")
	end

	return
end

function IslandIllustration:GetStatus()
	return self.status
end

function IslandIllustration:CheckTip()
	self.isTip = self.status == IslandIllustration.STATUS.CAN_UNLOCK

	return
end

function IslandIllustration:IsTip()
	return self.isTip
end

function IslandIllustration:GetPoints()
	return self.basePoint + self.levelPoints + self.starPoints
end

function IslandIllustration:GetTypeAndLinkId()
	return pg.island_illustrated_guide[self].type, pg.island_illustrated_guide[self].unlock_id
end

return IslandIllustration
