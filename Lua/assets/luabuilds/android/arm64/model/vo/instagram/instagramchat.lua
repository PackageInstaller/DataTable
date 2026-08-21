local var_0_0 = class("InstagramChat", import("..BaseVO"))
local var_0_1 = pg.activity_ins_ship_group_template
local var_0_2 = pg.activity_ins_chat_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.characterId = arg_1_1.id
	arg_1_0.skinId = arg_1_1.skin_id
	arg_1_0.care = arg_1_1.favorite
	arg_1_0.currentTopicId = arg_1_1.cur_chat_group

	arg_1_0:SetTopics(arg_1_1.chat_group_list)

	arg_1_0.currentTopic = arg_1_0:GetTopic(arg_1_0.currentTopicId)
	arg_1_0.characterConfig = var_0_1[arg_1_0.characterId]
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

function var_0_0.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = {}
	arg_2_0.allTopicIds = var_0_2.get_id_list_by_ship_group[arg_2_0.characterId]

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.allTopicIds) do
		local var_2_0

		for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
			if iter_2_3.id == iter_2_1 then
				var_2_0 = iter_2_3
			end
		end

		table.insert(arg_2_0.topics, (InstagramTopic.New(var_0_2[iter_2_1], var_2_0)))
	end

	return
end

function var_0_0.GetTopic(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.topics) do
		if iter_3_1.topicId == arg_3_1 then
			return iter_3_1
		end
	end

	return nil
end

function var_0_0.SetCurrentTopic(arg_4_0, arg_4_1)
	arg_4_0.currentTopicId = arg_4_1
	arg_4_0.currentTopic = arg_4_0:GetTopic(arg_4_1)

	return
end

function var_0_0.GetDisplayWord(arg_5_0)
	return arg_5_0.currentTopic:GetLatestCharacterWord()
end

function var_0_0.GetCharacterEndFlag(arg_6_0)
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.topics) do
		if iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function var_0_0.GetCharacterEndFlagExceptCurrent(arg_7_0)
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.topics) do
		if iter_7_1.topicId ~= arg_7_0.currentTopicId and iter_7_1.active and not iter_7_1:IsCompleted() then
			var_7_0 = 0

			break
		end
	end

	return var_7_0
end

function var_0_0.GetLatestOperationTime(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.topics) do
		if iter_8_1.active and var_8_0 < iter_8_1.operationTime then
			var_8_0 = iter_8_1.operationTime
		end
	end

	return var_8_0
end

function var_0_0.SetCare(arg_9_0, arg_9_1)
	arg_9_0.care = arg_9_1

	return
end

function var_0_0.SortTopicList(arg_10_0)
	table.sort(arg_10_0.topics, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.isII and 1 or 0
		local var_11_1 = arg_11_1.isII and 1 or 0

		if (arg_11_0.isII and 1 or 0) ~= (arg_11_1.isII and 1 or 0) then
			return var_11_0 < var_11_1
		end

		local var_11_2 = arg_11_0.active and 1 or 0
		local var_11_3 = arg_11_1.active and 1 or 0

		if (arg_11_0.active and 1 or 0) ~= (arg_11_1.active and 1 or 0) then
			return var_11_3 < var_11_2
		end

		return arg_11_0.topicId > arg_11_1.topicId
	end)

	return
end

function var_0_0.SetBackgrounds(arg_12_0)
	arg_12_0.skins = ShipGroup.GetDisplayableSkinList(arg_12_0.characterId)

	for iter_12_0, iter_12_1 in ipairs((getProxy(ShipSkinProxy):GetShareSkinsForShipGroupInJuus(arg_12_0.characterId))) do
		table.insert(arg_12_0.skins, pg.ship_skin_template[iter_12_1.id])
	end

	local var_12_0 = getProxy(CollectionProxy):getGroups()

	for iter_12_2 = #arg_12_0.skins, 1, -1 do
		if arg_12_0.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_PROPOSE and (not var_12_0[arg_12_0.skins[iter_12_2].ship_group] or var_12_0[arg_12_0.skins[iter_12_2].ship_group].married == 0) then
			table.remove(arg_12_0.skins, iter_12_2)
		end

		if arg_12_0.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_REMAKE and (not var_12_0[arg_12_0.skins[iter_12_2].ship_group] or not var_12_0[arg_12_0.skins[iter_12_2].ship_group].trans) then
			table.remove(arg_12_0.skins, iter_12_2)
		end

		if arg_12_0.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_DEFAULT and not var_12_0[arg_12_0.skins[iter_12_2].ship_group] then
			table.remove(arg_12_0.skins, iter_12_2)
		end
	end

	return
end

function var_0_0.GetSkins(arg_13_0)
	arg_13_0:SetBackgrounds()

	return arg_13_0.skins
end

function var_0_0.GetPainting(arg_14_0)
	local var_14_0 = 0

	var_14_0 = arg_14_0.currentTopic.isII and ShipGroup.getDefaultShipConfig(arg_14_0.currentTopic.topicConfig.group_ii).skin_id or ShipGroup.getDefaultShipConfig(arg_14_0.characterId).skin_id

	local var_14_1 = pg.ship_skin_template[var_14_0]

	assert(pg.ship_skin_template[var_14_0], "ship_skin_template not exist: " .. var_14_0)

	return var_14_1.painting
end

function var_0_0.GetPaintingId(arg_15_0)
	return arg_15_0.currentTopic.isII and ShipGroup.getDefaultShipConfig(arg_15_0.currentTopic.topicConfig.group_ii).skin_id or ShipGroup.getDefaultShipConfig(arg_15_0.characterId).skin_id
end

return var_0_0
