local InstagramChat = class("InstagramChat", import("..BaseVO"))
local var_0_1 = pg.activity_ins_ship_group_template
local var_0_2 = pg.activity_ins_chat_group

function InstagramChat:Ctor(arg_1_1)
	self.characterId = arg_1_1.id
	self.skinId = arg_1_1.skin_id
	self.care = arg_1_1.favorite
	self.currentTopicId = arg_1_1.cur_chat_group

	self:SetTopics(arg_1_1.chat_group_list)

	self.currentTopic = self:GetTopic(self.currentTopicId)
	self.characterConfig = var_0_1[self.characterId]
	self.name = self.characterConfig.name
	self.sculpture = self.characterConfig.sculpture
	self.sculptureII = self.characterConfig.sculpture_ii
	self.type = self.characterConfig.type
	self.nationality = self.characterConfig.nationality
	self.groupBackground = self.characterConfig.background
	self.skins = {}

	if self.type == 1 then
		self:SetBackgrounds()
	end

	return
end

function InstagramChat:SetTopics(arg_2_1)
	self.topics = {}
	self.allTopicIds = var_0_2.get_id_list_by_ship_group[self.characterId]

	for iter_2_0, iter_2_1 in ipairs(self.allTopicIds) do
		local var_2_0

		for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
			if iter_2_3.id == iter_2_1 then
				var_2_0 = iter_2_3
			end
		end

		table.insert(self.topics, (InstagramTopic.New(var_0_2[iter_2_1], var_2_0)))
	end

	return
end

function InstagramChat:GetTopic(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.topics) do
		if iter_3_1.topicId == arg_3_1 then
			return iter_3_1
		end
	end

	return nil
end

function InstagramChat:SetCurrentTopic(arg_4_1)
	self.currentTopicId = arg_4_1
	self.currentTopic = self:GetTopic(arg_4_1)

	return
end

function InstagramChat:GetDisplayWord()
	return self.currentTopic:GetLatestCharacterWord()
end

function InstagramChat:GetCharacterEndFlag()
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in ipairs(self.topics) do
		if iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function InstagramChat:GetCharacterEndFlagExceptCurrent()
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in ipairs(self.topics) do
		if iter_7_1.topicId ~= self.currentTopicId and iter_7_1.active and not iter_7_1:IsCompleted() then
			var_7_0 = 0

			break
		end
	end

	return var_7_0
end

function InstagramChat:GetLatestOperationTime()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.topics) do
		if iter_8_1.active and var_8_0 < iter_8_1.operationTime then
			var_8_0 = iter_8_1.operationTime
		end
	end

	return var_8_0
end

function InstagramChat:SetCare(arg_9_1)
	self.care = arg_9_1

	return
end

function InstagramChat:SortTopicList()
	table.sort(self.topics, function(arg_11_0, arg_11_1)
		if (arg_11_0.isII and 1 or 0) ~= (arg_11_1.isII and 1 or 0) then
			return (arg_11_0.isII and 1 or 0) < (arg_11_1.isII and 1 or 0)
		end

		if (arg_11_0.active and 1 or 0) ~= (arg_11_1.active and 1 or 0) then
			return (arg_11_1.active and 1 or 0) < (arg_11_0.active and 1 or 0)
		end

		return arg_11_0.topicId > arg_11_1.topicId
	end)

	return
end

function InstagramChat:SetBackgrounds()
	self.skins = ShipGroup.GetDisplayableSkinList(self.characterId)

	for iter_12_0, iter_12_1 in ipairs((getProxy(ShipSkinProxy):GetShareSkinsForShipGroupInJuus(self.characterId))) do
		table.insert(self.skins, pg.ship_skin_template[iter_12_1.id])
	end

	local var_12_0 = getProxy(CollectionProxy):getGroups()

	for iter_12_2 = #self.skins, 1, -1 do
		if self.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_PROPOSE and (not var_12_0[self.skins[iter_12_2].ship_group] or var_12_0[self.skins[iter_12_2].ship_group].married == 0) then
			table.remove(self.skins, iter_12_2)
		end

		if self.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_REMAKE and (not var_12_0[self.skins[iter_12_2].ship_group] or not var_12_0[self.skins[iter_12_2].ship_group].trans) then
			table.remove(self.skins, iter_12_2)
		end

		if self.skins[iter_12_2].skin_type == ShipSkin.SKIN_TYPE_DEFAULT and not var_12_0[self.skins[iter_12_2].ship_group] then
			table.remove(self.skins, iter_12_2)
		end
	end

	return
end

function InstagramChat:GetSkins()
	self:SetBackgrounds()

	return self.skins
end

function InstagramChat:GetPainting()
	local var_14_0 = 0

	var_14_0 = self.currentTopic.isII and ShipGroup.getDefaultShipConfig(self.currentTopic.topicConfig.group_ii).skin_id or ShipGroup.getDefaultShipConfig(self.characterId).skin_id

	local var_14_1 = pg.ship_skin_template[var_14_0]

	assert(pg.ship_skin_template[var_14_0], "ship_skin_template not exist: " .. var_14_0)

	return var_14_1.painting
end

function InstagramChat:GetPaintingId()
	return self.currentTopic.isII and ShipGroup.getDefaultShipConfig(self.currentTopic.topicConfig.group_ii).skin_id or ShipGroup.getDefaultShipConfig(self.characterId).skin_id
end

return InstagramChat
