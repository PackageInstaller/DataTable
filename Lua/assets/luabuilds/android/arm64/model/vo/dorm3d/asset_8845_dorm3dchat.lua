local Dorm3dChat = class("Dorm3dChat", import("..BaseVO"))
local var_0_1 = pg.dorm3d_ins_ship_group_template
local var_0_2 = pg.dorm3d_ins_chat_group

function Dorm3dChat:Ctor(arg_1_1)
	self.characterId = arg_1_1.ship_group
	self.skinId = arg_1_1.cur_back
	self.care = arg_1_1.care_flag
	self.currentTopicId = arg_1_1.cur_comm_id

	self:SetTopics(arg_1_1.comm_list)

	self.currentTopic = self:GetTopic(self.currentTopicId)
	self.characterConfig = var_0_1[self.characterId]
	self.name = self.characterConfig.name
	self.sculpture = self.characterConfig.sculpture
	self.groupBackground = self.characterConfig.background
	self.type = self.characterConfig.type
	self.skins = {}

	if self.type == 1 then
		self:SetBackgrounds()
	end

	return
end

function Dorm3dChat:SetTopics(arg_2_1)
	self.topics = {}
	self.allTopicIds = var_0_2.get_id_list_by_ship_group[self.characterId]

	for iter_2_0, iter_2_1 in ipairs(self.allTopicIds or {}) do
		if var_0_2[iter_2_1].type == "1" then
			local var_2_0

			for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
				if iter_2_3.id == iter_2_1 then
					var_2_0 = iter_2_3
				end
			end

			table.insert(self.topics, (Dorm3dTopic.New(var_0_2[iter_2_1], var_2_0)))
		end
	end

	return
end

function Dorm3dChat:GetTopic(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.topics) do
		if iter_3_1.topicId == arg_3_1 then
			return iter_3_1
		end
	end

	return nil
end

function Dorm3dChat:SetCurrentTopic(arg_4_1)
	self.currentTopicId = arg_4_1
	self.currentTopic = self:GetTopic(arg_4_1)

	return
end

function Dorm3dChat:GetCharacterEndFlag()
	local var_5_0 = 1

	for iter_5_0, iter_5_1 in ipairs(self.topics) do
		if iter_5_1.active and not iter_5_1:IsCompleted() then
			var_5_0 = 0

			break
		end
	end

	return var_5_0
end

function Dorm3dChat:GetCharacterEndFlagExceptCurrent()
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in ipairs(self.topics) do
		if iter_6_1.topicId ~= self.currentTopicId and iter_6_1.active and not iter_6_1:IsCompleted() then
			var_6_0 = 0

			break
		end
	end

	return var_6_0
end

function Dorm3dChat:GetLatestOperationTime()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(self.topics) do
		if iter_7_1.active and var_7_0 < iter_7_1.operationTime then
			var_7_0 = iter_7_1.operationTime
		end
	end

	return var_7_0
end

function Dorm3dChat:SetCare(arg_8_1)
	self.care = arg_8_1

	return
end

function Dorm3dChat:SortTopicList()
	table.sort(self.topics, function(arg_10_0, arg_10_1)
		if (arg_10_0.active and 1 or 0) ~= (arg_10_1.active and 1 or 0) then
			return (arg_10_1.active and 1 or 0) < (arg_10_0.active and 1 or 0)
		end

		return arg_10_0.topicId > arg_10_1.topicId
	end)

	return
end

function Dorm3dChat:SetBackgrounds()
	self.skins = self:getDisplayableSkinList()

	local var_11_0 = getProxy(CollectionProxy):getGroups()[self.characterId]

	for iter_11_0 = #self.skins, 1, -1 do
		if self.skins[iter_11_0].skin_type == ShipSkin.SKIN_TYPE_PROPOSE and (not var_11_0 or var_11_0 and var_11_0.married == 0) then
			table.remove(self.skins, iter_11_0)
		end

		if self.skins[iter_11_0].skin_type == ShipSkin.SKIN_TYPE_REMAKE and (not var_11_0 or var_11_0 and not var_11_0.trans) then
			table.remove(self.skins, iter_11_0)
		end
	end

	return
end

function Dorm3dChat:GetSkins()
	self:SetBackgrounds()

	return self.skins
end

function Dorm3dChat:GetPainting()
	local var_13_0 = ShipGroup.getDefaultShipConfig(self.characterId).skin_id

	assert(pg.ship_skin_template[var_13_0], "ship_skin_template not exist: " .. var_13_0)

	return pg.ship_skin_template[var_13_0].painting
end

function Dorm3dChat:GetPaintingId()
	return ShipGroup.getDefaultShipConfig(self.characterId).skin_id
end

function Dorm3dChat:getDisplayableSkinList()
	local var_15_0 = {}

	local function var_15_1(arg_16_0)
		return arg_16_0.skin_type ~= ShipSkin.SKIN_TYPE_OLD and (arg_16_0.skin_type == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not getProxy(ShipSkinProxy):hasSkin(arg_16_0.id) or false) or true
	end

	local function var_15_2(arg_17_0)
		return getProxy(ShipSkinProxy):InShowTime(arg_17_0)
	end

	for iter_15_0, iter_15_1 in ipairs(pg.ship_skin_template.all) do
		if pg.ship_skin_template[iter_15_1].ship_group == self.characterId and pg.ship_skin_template[iter_15_1].no_showing ~= "1" and not var_15_1(pg.ship_skin_template[iter_15_1]) and var_15_2(pg.ship_skin_template[iter_15_1].id) then
			table.insert(var_15_0, pg.ship_skin_template[iter_15_1])
		end
	end

	return var_15_0
end

function Dorm3dChat:GetTopicsSortByActivateTime()
	local var_18_0 = Clone(self.topics)

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if (arg_19_0.active and 1 or 0) ~= (arg_19_1.active and 1 or 0) then
			return (arg_19_1.active and 1 or 0) < (arg_19_0.active and 1 or 0)
		end

		if arg_19_0.operationTime ~= arg_19_1.operationTime then
			return arg_19_1.operationTime < arg_19_0.operationTime
		end

		return arg_19_0.topicId > arg_19_1.topicId
	end)

	return var_18_0
end

return Dorm3dChat
