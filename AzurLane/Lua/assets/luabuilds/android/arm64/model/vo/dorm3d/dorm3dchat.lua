class = var_0_10000

local var_0_0 = "Dorm3dChat"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

pg = var_0_10001

local var_0_2 = var_0_10001.dorm3d_ins_ship_group_template

pg = var_0_0

local var_0_3 = var_0_0.dorm3d_ins_chat_group

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.characterId = arg_1_1.ship_group
	arg_1_0.skinId = arg_1_1.cur_back
	arg_1_0.care = arg_1_1.care_flag
	arg_1_0.currentTopicId = arg_1_1.cur_comm_id

	arg_1_0:SetTopics(arg_1_1.comm_list)

	arg_1_0.currentTopic = arg_1_0:GetTopic(arg_1_0.currentTopicId)
	arg_1_0.characterConfig = var_0_2[arg_1_0.characterId]
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

function var_0_1.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = {}
	arg_2_0.allTopicIds = var_0_3.get_id_list_by_ship_group[arg_2_0.characterId]
	ipairs = var_2

	local var_2_0

	if not arg_2_0.allTopicIds then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		if var_0_3[iter_2_1].type == "1" then
			local var_2_1

			ipairs = var_1_10008

			for iter_2_2, iter_2_3 in var_1_10008(arg_2_1) do
				if iter_2_3.id == iter_2_1 then
					var_2_1 = iter_2_3
				end
			end

			Dorm3dTopic = var_1_10008
			var_1_10008 = var_1_10008.New(var_0_3[iter_2_1], var_2_1)
			table = var_9

			var_9.insert(arg_2_0.topics, var_1_10008)
		end
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

function var_0_1.GetCharacterEndFlag(arg_5_0)
	local var_5_0 = 1

	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.topics) do
		if iter_5_1.active and not iter_5_1:IsCompleted() then
			var_5_0 = 0

			break
		end
	end

	return var_5_0
end

function var_0_1.GetCharacterEndFlagExceptCurrent(arg_6_0)
	local var_6_0 = 1

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.topics) do
		if iter_6_1.topicId ~= arg_6_0.currentTopicId and iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function var_0_1.GetLatestOperationTime(arg_7_0)
	local var_7_0 = 0

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.topics) do
		if iter_7_1.active and var_7_0 < iter_7_1.operationTime then
			var_7_0 = iter_7_1.operationTime
		end
	end

	return var_7_0
end

function var_0_1.SetCare(arg_8_0, arg_8_1)
	arg_8_0.care = arg_8_1

	return
end

function var_0_1.SortTopicList(arg_9_0)
	table = var_1_10001

	var_1_10001.sort(arg_9_0.topics, function(arg_10_0, arg_10_1)
		if (arg_10_0.active and 1 or 0) ~= (arg_10_1.active and 1 or 0) then
			return var_3 < var_2
		end

		return arg_10_0.topicId > arg_10_1.topicId
	end)

	return
end

function var_0_1.SetBackgrounds(arg_11_0)
	local var_11_0 = arg_11_0

	arg_11_0.skins = arg_11_0.getDisplayableSkinList(var_11_0)
	getProxy = var_1
	CollectionProxy = var_11_0

	local var_11_1 = var_1(var_11_0)
	local var_11_2 = var_1.getGroups(var_11_1)[arg_11_0.characterId]

	for iter_11_0 = #arg_11_0.skins, 1, -1 do
		local var_11_3 = arg_11_0.skins[iter_11_0].skin_type

		ShipSkin = var_1_10009

		if var_11_3 == var_1_10009.SKIN_TYPE_PROPOSE and (not var_11_2 or var_11_2 and var_11_2.married == 0) then
			table = var_11_3

			var_11_3.remove(arg_11_0.skins, iter_11_0)
		end

		local var_11_4 = var_7.skin_type

		ShipSkin = var_1_10009

		if var_11_4 == var_1_10009.SKIN_TYPE_REMAKE and (not var_11_2 or var_11_2 and not var_11_2.trans) then
			table = var_11_4

			var_11_4.remove(arg_11_0.skins, iter_11_0)
		end
	end

	return
end

function var_0_1.GetSkins(arg_12_0)
	arg_12_0:SetBackgrounds()

	return arg_12_0.skins
end

function var_0_1.GetPainting(arg_13_0)
	ShipGroup = var_1_10001

	local var_13_0 = var_1_10001.getDefaultShipConfig(arg_13_0.characterId).skin_id

	pg = var_1_10002

	local var_13_1 = var_1_10002.ship_skin_template[var_13_0]

	assert = var_3

	var_3(var_13_1, "ship_skin_template not exist: " .. var_13_0)

	return var_13_1.painting
end

function var_0_1.GetPaintingId(arg_14_0)
	ShipGroup = var_1_10001

	return var_1_10001.getDefaultShipConfig(arg_14_0.characterId).skin_id
end

function var_0_1.getDisplayableSkinList(arg_15_0)
	local var_15_0 = {}

	local function var_15_1(arg_16_0)
		local var_16_0 = arg_16_0.skin_type

		ShipSkin = var_2_10002

		local var_16_3

		if var_16_0 ~= var_2_10002.SKIN_TYPE_OLD then
			local var_16_1 = arg_16_0.skin_type

			ShipSkin = var_2

			if var_16_1 == var_2.SKIN_TYPE_NOT_HAVE_HIDE then
				getProxy = var_16_1
				ShipSkinProxy = var_2_10003

				local var_16_2 = var_16_1(var_2_10003)

				var_16_3 = not var_1.hasSkin(var_16_2, arg_16_0.id)
			else
				var_16_3 = false
			end
		else
			var_16_3 = true
		end

		return var_16_3
	end

	local function var_15_2(arg_17_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10003

		local var_17_0 = var_2_10001(var_2_10003)

		return var_1.InShowTime(var_17_0, arg_17_0)
	end

	ipairs = var_1_10004
	pg = var_1_10006

	for iter_15_0, iter_15_1 in var_1_10004(var_1_10006.ship_skin_template.all) do
		pg = var_1_10009

		if var_1_10009.ship_skin_template[iter_15_1].ship_group == arg_15_0.characterId and var_1_10009.no_showing ~= "1" and not var_15_1(var_1_10009) and var_15_2(var_1_10009.id) then
			table = var_10

			var_10.insert(var_15_0, var_1_10009)
		end
	end

	return var_15_0
end

function var_0_1.GetTopicsSortByActivateTime(arg_18_0)
	Clone = var_1_10001

	local var_18_0 = var_1_10001(arg_18_0.topics)

	table = var_1_10002

	var_1_10002.sort(var_18_0, function(arg_19_0, arg_19_1)
		if (arg_19_0.active and 1 or 0) ~= (arg_19_1.active and 1 or 0) then
			return var_3 < var_2
		end

		if arg_19_0.operationTime ~= arg_19_1.operationTime then
			return var_5 < var_4
		end

		return arg_19_0.topicId > arg_19_1.topicId
	end)

	return var_18_0
end

return var_0_1
