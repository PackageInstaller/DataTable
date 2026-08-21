local var_0_0 = class("WorldCollectionProxy", import("....BaseEntity"))

var_0_0.Fields = {
	storyGroup = "table",
	data = "table",
	placeGroup = "table"
}
var_0_0.EventPlaceUnlock = "WorldCollectionProxy.EventPlaceUnlock"
var_0_0.WorldCollectionType = {
	FILE = 1,
	RECORD = 2
}
var_0_0.WorldCollectionTemplate = {}
var_0_0.WorldCollectionTemplateExtend = {}

for iter_0_0, iter_0_1 in ipairs(pg.world_collection_file_template.all) do
	if var_0_0.WorldCollectionTemplate[iter_0_1] ~= nil then
		assert(false, "Repeat Collection UID " .. iter_0_1)
	end

	var_0_0.WorldCollectionTemplate[iter_0_1] = pg.world_collection_file_template[iter_0_1]
	var_0_0.WorldCollectionTemplateExtend[iter_0_1] = var_0_0.WorldCollectionTemplateExtend[iter_0_1] or {}
	var_0_0.WorldCollectionTemplateExtend[iter_0_1].type = var_0_0.WorldCollectionType.FILE
end

for iter_0_2, iter_0_3 in ipairs(pg.world_collection_file_group.all) do
	for iter_0_4, iter_0_5 in ipairs(pg.world_collection_file_group[iter_0_3].child) do
		if var_0_0.WorldCollectionTemplate[iter_0_5] ~= nil then
			var_0_0.WorldCollectionTemplateExtend[iter_0_5].group = pg.world_collection_file_group[iter_0_3].id
		else
			assert(false, "Missing Collection FILE UID " .. iter_0_5)
		end
	end
end

for iter_0_6, iter_0_7 in ipairs(pg.world_collection_record_template.all) do
	if var_0_0.WorldCollectionTemplate[iter_0_7] ~= nil then
		assert(false, "Repeat Collection UID " .. iter_0_7)
	end

	var_0_0.WorldCollectionTemplate[iter_0_7] = pg.world_collection_record_template[iter_0_7]
	var_0_0.WorldCollectionTemplateExtend[iter_0_7] = var_0_0.WorldCollectionTemplateExtend[iter_0_7] or {}
	var_0_0.WorldCollectionTemplateExtend[iter_0_7].type = var_0_0.WorldCollectionType.RECORD
end

for iter_0_8, iter_0_9 in ipairs(pg.world_collection_record_group.all) do
	for iter_0_10, iter_0_11 in ipairs(pg.world_collection_record_group[iter_0_9].child) do
		if var_0_0.WorldCollectionTemplate[iter_0_11] ~= nil then
			var_0_0.WorldCollectionTemplateExtend[iter_0_11].group = pg.world_collection_record_group[iter_0_9].id
		else
			assert(false, "Missing Collection RECORD UID " .. iter_0_11)
		end
	end
end

function var_0_0.GetCollectionTemplate(arg_1_0)
	assert(var_0_0.WorldCollectionTemplate[arg_1_0], "Missing WorldCollection Config ID: " .. (arg_1_0 or "NIL"))

	return var_0_0.WorldCollectionTemplate[arg_1_0]
end

function var_0_0.GetCollectionType(arg_2_0)
	assert(var_0_0.WorldCollectionTemplateExtend[arg_2_0] and var_0_0.WorldCollectionTemplateExtend[arg_2_0].type, "Missing WorldCollection Type ID: " .. (arg_2_0 or "NIL"))

	return var_0_0.WorldCollectionTemplateExtend[arg_2_0].type
end

function var_0_0.GetCollectionGroup(arg_3_0)
	assert(var_0_0.WorldCollectionTemplateExtend[arg_3_0] and var_0_0.WorldCollectionTemplateExtend[arg_3_0].group, "Missing WorldCollection Type ID: " .. (arg_3_0 or "NIL"))

	return var_0_0.WorldCollectionTemplateExtend[arg_3_0].group
end

function var_0_0.GetCollectionFileGroupTemplate(arg_4_0)
	assert(pg.world_collection_file_group[arg_4_0], "Missing world_collection_file_group Config ID: " .. (arg_4_0 or "NIL"))

	return pg.world_collection_file_group[arg_4_0]
end

function var_0_0.GetCollectionFileTemplate(arg_5_0)
	assert(pg.world_collection_file_template[arg_5_0], "Missing world_collection_file_template Config ID: " .. (arg_5_0 or "NIL"))

	return pg.world_collection_file_template[arg_5_0]
end

function var_0_0.GetCollectionRecordGroupTemplate(arg_6_0)
	assert(pg.world_collection_record_group[arg_6_0], "Missing world_collection_record_group Config ID: " .. (arg_6_0 or "NIL"))

	return pg.world_collection_record_group[arg_6_0]
end

function var_0_0.GetCollectionRecordTemplate(arg_7_0)
	assert(pg.world_collection_record_template[arg_7_0], "Missing world_collection_record_template Config ID: " .. (arg_7_0 or "NIL"))

	return pg.world_collection_record_template[arg_7_0]
end

function var_0_0.Setup(arg_8_0, arg_8_1)
	arg_8_0.data = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0.data[iter_8_1] = true
	end

	return
end

function var_0_0.Unlock(arg_9_0, arg_9_1)
	arg_9_0.data[arg_9_1] = arg_9_0.data[arg_9_1] or true

	return
end

function var_0_0.IsUnlock(arg_10_0, arg_10_1)
	return tobool(arg_10_0.data[arg_10_1])
end

return var_0_0
