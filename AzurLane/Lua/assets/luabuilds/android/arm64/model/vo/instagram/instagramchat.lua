class = var_0_10000

local var_0_0 = "InstagramChat"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

pg = var_0_10001

local var_0_2 = var_0_10001.activity_ins_ship_group_template

pg = var_0_0

local var_0_3 = var_0_0.activity_ins_chat_group

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.characterId = arg_1_1.id
	arg_1_0.skinId = arg_1_1.skin_id
	arg_1_0.care = arg_1_1.favorite
	arg_1_0.currentTopicId = arg_1_1.cur_chat_group

	arg_1_0:SetTopics(arg_1_1.chat_group_list)

	arg_1_0.currentTopic = arg_1_0:GetTopic(arg_1_0.currentTopicId)
	arg_1_0.characterConfig = var_0_2[arg_1_0.characterId]
	arg_1_0.name = arg_1_0.characterConfig.name
	arg_1_0.sculpture = arg_1_0.characterConfig.sculpture
	arg_1_0.sculptureII = arg_1_0.characterConfig.sculpture_ii
	arg_1_0.type = arg_1_0.characterConfig.type
	arg_1_0.nationality = arg_1_0.characterConfig.nationality
	arg_1_0.groupBackground = arg_1_0.characterConfig.background
	arg_1_0.skins = {}

	if arg_1_0.type == 1 then
		arg_1_0:SetBackgrounds()
	end

	return
end

function var_0_1.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = {}
	arg_2_0.allTopicIds = var_0_3.get_id_list_by_ship_group[arg_2_0.characterId]
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.allTopicIds) do
		local var_2_0

		ipairs = var_1_10008

		for iter_2_2, iter_2_3 in var_1_10008(arg_2_1) do
			if iter_2_3.id == iter_2_1 then
				var_2_0 = iter_2_3
			end
		end

		InstagramTopic = var_1_10008
		var_1_10008 = var_1_10008.New(var_0_3[iter_2_1], var_2_0)
		table = var_9

		var_9.insert(arg_2_0.topics, var_1_10008)
	end

	return
end

function var_0_1.GetTopic(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.topics) do
		if iter_3_1.topicId == arg_3_1 then
			return iter_3_1
		end
	end

	return nil
end

function var_0_1.SetCurrentTopic(arg_4_0, arg_4_1)
	arg_4_0.currentTopicId = arg_4_1
	arg_4_0.currentTopic = arg_4_0:GetTopic(arg_4_1)

	return
end

function var_0_1.GetDisplayWord(arg_5_0)
	local var_5_0 = arg_5_0.currentTopic

	return var_1.GetLatestCharacterWord(var_5_0)
end

function var_0_1.GetCharacterEndFlag(arg_6_0)
	local var_6_0 = 1

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.topics) do
		if iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function var_0_1.GetCharacterEndFlagExceptCurrent(arg_7_0)
	local var_7_0 = 1

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.topics) do
		if iter_7_1.topicId ~= arg_7_0.currentTopicId and iter_7_1.active and not iter_7_1:IsCompleted() then
			var_7_0 = 0

			break
		end
	end

	return var_7_0
end

function var_0_1.GetLatestOperationTime(arg_8_0)
	local var_8_0 = 0

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.topics) do
		if iter_8_1.active and var_8_0 < iter_8_1.operationTime then
			var_8_0 = iter_8_1.operationTime
		end
	end

	return var_8_0
end

function var_0_1.SetCare(arg_9_0, arg_9_1)
	arg_9_0.care = arg_9_1

	return
end

function var_0_1.SortTopicList(arg_10_0)
	table = var_1_10001

	var_1_10001.sort(arg_10_0.topics, function(arg_11_0, arg_11_1)
		if (arg_11_0.isII and 1 or 0) ~= (arg_11_1.isII and 1 or 0) then
			return var_2 < var_3
		end

		if (arg_11_0.active and 1 or 0) ~= (arg_11_1.active and 1 or 0) then
			return var_5 < var_4
		end

		return arg_11_0.topicId > arg_11_1.topicId
	end)

	return
end

function var_0_1.SetBackgrounds(arg_12_0)
	ShipGroup = var_1_10001
	arg_12_0.skins = var_1_10001.GetDisplayableSkinList(arg_12_0.characterId)
	getProxy = var_1
	ShipSkinProxy = var_3

	local var_12_0 = var_1(var_3)
	local var_12_1 = var_1.GetShareSkinsForShipGroupInJuus(var_12_0, arg_12_0.characterId)

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(var_12_1) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_12_2 = arg_12_0.skins

		pg = var_1_10010

		var_1_10007(var_12_2, var_1_10010.ship_skin_template[iter_12_1.id])
	end

	getProxy = var_2
	CollectionProxy = var_4

	local var_12_3 = var_2(var_4)
	local var_12_4 = var_2.getGroups(var_12_3)

	for iter_12_2 = #arg_12_0.skins, 1, -1 do
		local var_12_5 = var_12_4[arg_12_0.skins[iter_12_2].ship_group]
		local var_12_6 = var_7.skin_type

		ShipSkin = var_1_10010

		if var_12_6 == var_1_10010.SKIN_TYPE_PROPOSE and (not var_12_5 or var_12_5.married == 0) then
			table = var_12_6

			var_12_6.remove(arg_12_0.skins, iter_12_2)
		end

		local var_12_7 = var_7.skin_type

		ShipSkin = var_1_10010

		if var_12_7 == var_1_10010.SKIN_TYPE_REMAKE and (not var_12_5 or not var_12_5.trans) then
			table = var_12_7

			var_12_7.remove(arg_12_0.skins, iter_12_2)
		end

		local var_12_8 = var_7.skin_type

		ShipSkin = var_1_10010

		if var_12_8 == var_1_10010.SKIN_TYPE_DEFAULT and not var_12_5 then
			table = var_12_8

			var_12_8.remove(arg_12_0.skins, iter_12_2)
		end
	end

	return
end

function var_0_1.GetSkins(arg_13_0)
	arg_13_0:SetBackgrounds()

	return arg_13_0.skins
end

function var_0_1.GetPainting(arg_14_0)
	local var_14_0 = 0

	if arg_14_0.currentTopic.isII then
		ShipGroup = var_2
		var_14_0 = var_2.getDefaultShipConfig(arg_14_0.currentTopic.topicConfig.group_ii).skin_id
	else
		ShipGroup = var_2
		var_14_0 = var_2.getDefaultShipConfig(arg_14_0.characterId).skin_id
	end

	pg = var_2

	local var_14_1 = var_2.ship_skin_template[var_14_0]

	assert = var_1_10003

	var_1_10003(var_14_1, "ship_skin_template not exist: " .. var_14_0)

	return var_14_1.painting
end

function var_0_1.GetPaintingId(arg_15_0)
	local var_15_0 = 0

	if arg_15_0.currentTopic.isII then
		ShipGroup = var_2
		var_15_0 = var_2.getDefaultShipConfig(arg_15_0.currentTopic.topicConfig.group_ii).skin_id
	else
		ShipGroup = var_2
		var_15_0 = var_2.getDefaultShipConfig(arg_15_0.characterId).skin_id
	end

	return var_15_0
end

return var_0_1
