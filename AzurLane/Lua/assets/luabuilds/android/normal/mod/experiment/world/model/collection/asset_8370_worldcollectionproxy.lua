class = var_0_10000

local var_0_0 = "WorldCollectionProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....BaseEntity"))

var_0_1.Fields = {
	storyGroup = "table",
	data = "table",
	placeGroup = "table"
}
var_0_1.EventPlaceUnlock = "WorldCollectionProxy.EventPlaceUnlock"
var_0_1.WorldCollectionType = {
	FILE = 1,
	RECORD = 2
}
var_0_1.WorldCollectionTemplate = {}
var_0_1.WorldCollectionTemplateExtend = {}
ipairs = var_1
pg = var_2

for iter_0_0, iter_0_1 in var_1(var_2.world_collection_file_template.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.world_collection_file_template[iter_0_1]

	if var_0_1.WorldCollectionTemplate[iter_0_1] ~= nil then
		assert = var_0_10007

		var_0_10007(false, "Repeat Collection UID " .. iter_0_1)
	end

	var_0_10007 = var_0_1.WorldCollectionTemplate
	var_0_10007[iter_0_1] = var_0_10006
	var_0_10007 = var_0_1.WorldCollectionTemplateExtend

	local var_0_2

	if not var_0_1.WorldCollectionTemplateExtend[iter_0_1] then
		var_0_2 = {}
	end

	var_0_10007[iter_0_1] = var_0_2
	var_0_10007 = var_0_1.WorldCollectionTemplateExtend[iter_0_1]
	var_0_10007.type = var_0_1.WorldCollectionType.FILE
end

ipairs = var_1
pg = var_2

for iter_0_2, iter_0_3 in var_1(var_2.world_collection_file_group.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.world_collection_file_group[iter_0_3]
	ipairs = var_0_10007

	for iter_0_4, iter_0_5 in var_0_10007(var_0_10006.child) do
		local var_0_3

		if var_0_1.WorldCollectionTemplate[iter_0_5] ~= nil then
			var_0_3 = var_0_1.WorldCollectionTemplateExtend[iter_0_5]
			var_0_3.group = var_0_10006.id
		else
			assert = var_0_3

			var_0_3(false, "Missing Collection FILE UID " .. iter_0_5)
		end
	end
end

ipairs = var_1
pg = var_2

for iter_0_6, iter_0_7 in var_1(var_2.world_collection_record_template.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.world_collection_record_template[iter_0_7]

	if var_0_1.WorldCollectionTemplate[iter_0_7] ~= nil then
		assert = var_0_10007

		var_0_10007(false, "Repeat Collection UID " .. iter_0_7)
	end

	var_0_10007 = var_0_1.WorldCollectionTemplate
	var_0_10007[iter_0_7] = var_0_10006
	var_0_10007 = var_0_1.WorldCollectionTemplateExtend

	local var_0_4

	if not var_0_1.WorldCollectionTemplateExtend[iter_0_7] then
		var_0_4 = {}
	end

	var_0_10007[iter_0_7] = var_0_4
	var_0_10007 = var_0_1.WorldCollectionTemplateExtend[iter_0_7]
	var_0_10007.type = var_0_1.WorldCollectionType.RECORD
end

ipairs = var_1
pg = var_2

for iter_0_8, iter_0_9 in var_1(var_2.world_collection_record_group.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.world_collection_record_group[iter_0_9]
	ipairs = var_0_10007

	for iter_0_10, iter_0_11 in var_0_10007(var_0_10006.child) do
		local var_0_5

		if var_0_1.WorldCollectionTemplate[iter_0_11] ~= nil then
			var_0_5 = var_0_1.WorldCollectionTemplateExtend[iter_0_11]
			var_0_5.group = var_0_10006.id
		else
			assert = var_0_5

			var_0_5(false, "Missing Collection RECORD UID " .. iter_0_11)
		end
	end
end

function var_0_1.GetCollectionTemplate(arg_1_0)
	local var_1_0 = var_0_1.WorldCollectionTemplate[arg_1_0]

	assert = var_1_10002

	var_1_10002(var_1_0, "Missing WorldCollection Config ID: " .. (arg_1_0 or "NIL"))

	return var_1_0
end

function var_0_1.GetCollectionType(arg_2_0)
	local var_2_0 = var_0_1.WorldCollectionTemplateExtend[arg_2_0]

	assert = var_1_10002

	var_1_10002(var_2_0 and var_2_0.type, "Missing WorldCollection Type ID: " .. (arg_2_0 or "NIL"))

	return var_2_0.type
end

function var_0_1.GetCollectionGroup(arg_3_0)
	local var_3_0 = var_0_1.WorldCollectionTemplateExtend[arg_3_0]

	assert = var_1_10002

	var_1_10002(var_3_0 and var_3_0.group, "Missing WorldCollection Type ID: " .. (arg_3_0 or "NIL"))

	return var_3_0.group
end

function var_0_1.GetCollectionFileGroupTemplate(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.world_collection_file_group[arg_4_0]

	assert = var_1_10002

	var_1_10002(var_4_0, "Missing world_collection_file_group Config ID: " .. (arg_4_0 or "NIL"))

	return var_4_0
end

function var_0_1.GetCollectionFileTemplate(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.world_collection_file_template[arg_5_0]

	assert = var_1_10002

	var_1_10002(var_5_0, "Missing world_collection_file_template Config ID: " .. (arg_5_0 or "NIL"))

	return var_5_0
end

function var_0_1.GetCollectionRecordGroupTemplate(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.world_collection_record_group[arg_6_0]

	assert = var_1_10002

	var_1_10002(var_6_0, "Missing world_collection_record_group Config ID: " .. (arg_6_0 or "NIL"))

	return var_6_0
end

function var_0_1.GetCollectionRecordTemplate(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.world_collection_record_template[arg_7_0]

	assert = var_1_10002

	var_1_10002(var_7_0, "Missing world_collection_record_template Config ID: " .. (arg_7_0 or "NIL"))

	return var_7_0
end

function var_0_1.Setup(arg_8_0, arg_8_1)
	arg_8_0.data = {}
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_1) do
		arg_8_0.data[iter_8_1] = true
	end

	return
end

function var_0_1.Unlock(arg_9_0, arg_9_1)
	if not arg_9_0.data[arg_9_1] then
		arg_9_0.data[arg_9_1] = true
	end

	return
end

function var_0_1.IsUnlock(arg_10_0, arg_10_1)
	tobool = var_1_10002

	return var_1_10002(arg_10_0.data[arg_10_1])
end

return var_0_1
