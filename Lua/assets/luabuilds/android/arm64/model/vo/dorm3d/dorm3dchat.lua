local var_0_0 = class("Dorm3dChat", import("..BaseVO"))
local var_0_1 = pg.dorm3d_ins_ship_group_template
local var_0_2 = pg.dorm3d_ins_chat_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.characterId = arg_1_1.ship_group
	arg_1_0.skinId = arg_1_1.cur_back
	arg_1_0.care = arg_1_1.care_flag
	arg_1_0.currentTopicId = arg_1_1.cur_comm_id

	arg_1_0:SetTopics(arg_1_1.comm_list)

	arg_1_0.currentTopic = arg_1_0:GetTopic(arg_1_0.currentTopicId)
	arg_1_0.characterConfig = var_0_1[arg_1_0.characterId]
	arg_1_0.name = arg_1_0.characterConfig.name
	arg_1_0.sculpture = arg_1_0.characterConfig.sculpture
	arg_1_0.groupBackground = arg_1_0.characterConfig.background
	arg_1_0.type = arg_1_0.characterConfig.type
	arg_1_0.skins = {}

	if arg_1_0.type == 1 then
		arg_1_0:SetBackgrounds()
	end

	return
end

function var_0_0.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = {}
	arg_2_0.allTopicIds = var_0_2.get_id_list_by_ship_group[arg_2_0.characterId]

	local var_2_0 = arg_2_0.allTopicIds or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if var_0_2[iter_2_1].type == "1" then
			local var_2_1

			for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
				if iter_2_3.id == iter_2_1 then
					var_2_1 = iter_2_3
				end
			end

			table.insert(arg_2_0.topics, (Dorm3dTopic.New(var_0_2[iter_2_1], var_2_1)))
		end
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

function var_0_0.GetCharacterEndFlag(arg_5_0)
	local var_5_0 = 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.topics) do
		if iter_5_1.active and not iter_5_1:IsCompleted() then
			var_5_0 = 0

			break
		end
	end

	return var_5_0
end

function var_0_0.GetCharacterEndFlagExceptCurrent(arg_6_0)
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.topics) do
		if iter_6_1.topicId ~= arg_6_0.currentTopicId and iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function var_0_0.GetLatestOperationTime(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.topics) do
		if iter_7_1.active and var_7_0 < iter_7_1.operationTime then
			var_7_0 = iter_7_1.operationTime
		end
	end

	return var_7_0
end

function var_0_0.SetCare(arg_8_0, arg_8_1)
	arg_8_0.care = arg_8_1

	return
end

function var_0_0.SortTopicList(arg_9_0)
	table.sort(arg_9_0.topics, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.active and 1 or 0
		local var_10_1 = arg_10_1.active and 1 or 0

		if (arg_10_0.active and 1 or 0) ~= (arg_10_1.active and 1 or 0) then
			return var_10_1 < var_10_0
		end

		return arg_10_0.topicId > arg_10_1.topicId
	end)

	return
end

function var_0_0.SetBackgrounds(arg_11_0)
	arg_11_0.skins = arg_11_0:getDisplayableSkinList()

	local var_11_0 = getProxy(CollectionProxy):getGroups()[arg_11_0.characterId]

	for iter_11_0 = #arg_11_0.skins, 1, -1 do
		if arg_11_0.skins[iter_11_0].skin_type == ShipSkin.SKIN_TYPE_PROPOSE and (not var_11_0 or var_11_0 and var_11_0.married == 0) then
			table.remove(arg_11_0.skins, iter_11_0)
		end

		if arg_11_0.skins[iter_11_0].skin_type == ShipSkin.SKIN_TYPE_REMAKE and (not var_11_0 or var_11_0 and not var_11_0.trans) then
			table.remove(arg_11_0.skins, iter_11_0)
		end
	end

	return
end

function var_0_0.GetSkins(arg_12_0)
	arg_12_0:SetBackgrounds()

	return arg_12_0.skins
end

function var_0_0.GetPainting(arg_13_0)
	local var_13_0 = ShipGroup.getDefaultShipConfig(arg_13_0.characterId).skin_id

	assert(pg.ship_skin_template[var_13_0], "ship_skin_template not exist: " .. var_13_0)

	return pg.ship_skin_template[var_13_0].painting
end

function var_0_0.GetPaintingId(arg_14_0)
	return ShipGroup.getDefaultShipConfig(arg_14_0.characterId).skin_id
end

function var_0_0.getDisplayableSkinList(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(pg.ship_skin_template.all) do
		if pg.ship_skin_template[iter_15_1].ship_group == arg_15_0.characterId and pg.ship_skin_template[iter_15_1].no_showing ~= "1" and not (function(arg_16_0)
			local var_16_0 = arg_16_0.skin_type ~= ShipSkin.SKIN_TYPE_OLD and (arg_16_0.skin_type == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not getProxy(ShipSkinProxy):hasSkin(arg_16_0.id) or false) or true

			return var_16_0
		end)(pg.ship_skin_template[iter_15_1]) and (function(arg_17_0)
			return getProxy(ShipSkinProxy):InShowTime(arg_17_0)
		end)(pg.ship_skin_template[iter_15_1].id) then
			table.insert({}, pg.ship_skin_template[iter_15_1])
		end
	end

	return {}
end

function var_0_0.GetTopicsSortByActivateTime(arg_18_0)
	local var_18_0 = Clone(arg_18_0.topics)

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0.active and 1 or 0
		local var_19_1 = arg_19_1.active and 1 or 0

		if (arg_19_0.active and 1 or 0) ~= (arg_19_1.active and 1 or 0) then
			return var_19_1 < var_19_0
		end

		local var_19_2 = arg_19_0.operationTime
		local var_19_3 = arg_19_1.operationTime

		if arg_19_0.operationTime ~= arg_19_1.operationTime then
			return var_19_3 < var_19_2
		end

		return arg_19_0.topicId > arg_19_1.topicId
	end)

	return var_18_0
end

return var_0_0
