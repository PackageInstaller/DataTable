local WorldCollectionProxy = class("WorldCollectionProxy", import("....BaseEntity"))

WorldCollectionProxy.Fields = {
	storyGroup = "table",
	data = "table",
	placeGroup = "table"
}
WorldCollectionProxy.EventPlaceUnlock = "WorldCollectionProxy.EventPlaceUnlock"
WorldCollectionProxy.WorldCollectionType = {
	FILE = 1,
	RECORD = 2
}
WorldCollectionProxy.WorldCollectionTemplate = {}
WorldCollectionProxy.WorldCollectionTemplateExtend = {}

for iter_0_0, iter_0_1 in ipairs(pg.world_collection_file_template.all) do
	if WorldCollectionProxy.WorldCollectionTemplate[iter_0_1] ~= nil then
		assert(false, "Repeat Collection UID " .. iter_0_1)
	end

	WorldCollectionProxy.WorldCollectionTemplate[iter_0_1] = pg.world_collection_file_template[iter_0_1]
	WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_1] = WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_1] or {}
	WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_1].type = WorldCollectionProxy.WorldCollectionType.FILE
end

for iter_0_2, iter_0_3 in ipairs(pg.world_collection_file_group.all) do
	for iter_0_4, iter_0_5 in ipairs(pg.world_collection_file_group[iter_0_3].child) do
		if WorldCollectionProxy.WorldCollectionTemplate[iter_0_5] ~= nil then
			WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_5].group = pg.world_collection_file_group[iter_0_3].id
		else
			assert(false, "Missing Collection FILE UID " .. iter_0_5)
		end
	end
end

for iter_0_6, iter_0_7 in ipairs(pg.world_collection_record_template.all) do
	if WorldCollectionProxy.WorldCollectionTemplate[iter_0_7] ~= nil then
		assert(false, "Repeat Collection UID " .. iter_0_7)
	end

	WorldCollectionProxy.WorldCollectionTemplate[iter_0_7] = pg.world_collection_record_template[iter_0_7]
	WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_7] = WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_7] or {}
	WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_7].type = WorldCollectionProxy.WorldCollectionType.RECORD
end

for iter_0_8, iter_0_9 in ipairs(pg.world_collection_record_group.all) do
	for iter_0_10, iter_0_11 in ipairs(pg.world_collection_record_group[iter_0_9].child) do
		if WorldCollectionProxy.WorldCollectionTemplate[iter_0_11] ~= nil then
			WorldCollectionProxy.WorldCollectionTemplateExtend[iter_0_11].group = pg.world_collection_record_group[iter_0_9].id
		else
			assert(false, "Missing Collection RECORD UID " .. iter_0_11)
		end
	end
end

function WorldCollectionProxy:GetCollectionTemplate()
	assert(WorldCollectionProxy.WorldCollectionTemplate[self], "Missing WorldCollection Config ID: " .. (self or "NIL"))

	return WorldCollectionProxy.WorldCollectionTemplate[self]
end

function WorldCollectionProxy:GetCollectionType()
	assert(WorldCollectionProxy.WorldCollectionTemplateExtend[self] and WorldCollectionProxy.WorldCollectionTemplateExtend[self].type, "Missing WorldCollection Type ID: " .. (self or "NIL"))

	return WorldCollectionProxy.WorldCollectionTemplateExtend[self].type
end

function WorldCollectionProxy:GetCollectionGroup()
	assert(WorldCollectionProxy.WorldCollectionTemplateExtend[self] and WorldCollectionProxy.WorldCollectionTemplateExtend[self].group, "Missing WorldCollection Type ID: " .. (self or "NIL"))

	return WorldCollectionProxy.WorldCollectionTemplateExtend[self].group
end

function WorldCollectionProxy:GetCollectionFileGroupTemplate()
	assert(pg.world_collection_file_group[self], "Missing world_collection_file_group Config ID: " .. (self or "NIL"))

	return pg.world_collection_file_group[self]
end

function WorldCollectionProxy:GetCollectionFileTemplate()
	assert(pg.world_collection_file_template[self], "Missing world_collection_file_template Config ID: " .. (self or "NIL"))

	return pg.world_collection_file_template[self]
end

function WorldCollectionProxy:GetCollectionRecordGroupTemplate()
	assert(pg.world_collection_record_group[self], "Missing world_collection_record_group Config ID: " .. (self or "NIL"))

	return pg.world_collection_record_group[self]
end

function WorldCollectionProxy:GetCollectionRecordTemplate()
	assert(pg.world_collection_record_template[self], "Missing world_collection_record_template Config ID: " .. (self or "NIL"))

	return pg.world_collection_record_template[self]
end

function WorldCollectionProxy:Setup(arg_8_1)
	self.data = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self.data[iter_8_1] = true
	end

	return
end

function WorldCollectionProxy:Unlock(arg_9_1)
	self.data[arg_9_1] = self.data[arg_9_1] or true

	return
end

function WorldCollectionProxy:IsUnlock(arg_10_1)
	return tobool(self.data[arg_10_1])
end

return WorldCollectionProxy
