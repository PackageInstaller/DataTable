local WorldPlace = class("WorldPlace")
local var_0_1 = {
	i18n1("碧蓝"),
	i18n1("铁血"),
	i18n1("塞壬")
}
local var_0_2 = pg.world_collection_place_template

function WorldPlace:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.number = arg_1_1.number or 0
	self.unlock = false
	self.config = var_0_2[self.configId]

	assert(self.config)

	return
end

function WorldPlace:setUnlock(arg_2_1)
	self.unlock = arg_2_1

	return
end

function WorldPlace:isUnlock()
	return self.unlock
end

function WorldPlace:getNumber()
	return self.number
end

function WorldPlace:getDesc()
	if self:isUnlock() then
		return self.config.description_known
	else
		return self.config.description_unknown
	end

	return
end

function WorldPlace:getCamp()
	return var_0_1[tonumber(self.config.type)]
end

function WorldPlace:getName()
	if self:isUnlock() then
		return self.config.name
	else
		return self.config.name_unknown
	end

	return
end

function WorldPlace:getIconPath()
	if self:isUnlock() then
		return "shipYardIcon/abeikelongbi"
	else
		return "shipYardIcon/unknown"
	end

	return
end

function WorldPlace:getFullViewImg()
	return "levelmap/map_1"
end

return WorldPlace
