local CardPuzzleShip = class("CardPuzzleShip", BaseVO)

function CardPuzzleShip:getShipArmor()
	return self:getConfig("armor")
end

function CardPuzzleShip:getShipArmorName()
	return ArmorType.Type2Name((self:getShipArmor()))
end

function CardPuzzleShip:getGroupId()
	return pg.ship_data_template[self.configId].group_type
end

function CardPuzzleShip:getGroupIdByConfigId()
	return math.floor(self / 10)
end

function CardPuzzleShip:getShipType()
	return pg.ship_data_statistics[self.configId].type
end

function CardPuzzleShip:getNation()
	assert(false)

	return
end

function CardPuzzleShip:getPaintingName()
	assert(pg.ship_skin_template[pg.ship_data_statistics[self].skin_id], "ship_skin_template not exist: " .. self .. " " .. pg.ship_data_statistics[self].skin_id)

	return pg.ship_skin_template[pg.ship_data_statistics[self].skin_id].painting
end

function CardPuzzleShip:getName()
	return pg.ship_data_statistics[self.configId].name
end

function CardPuzzleShip:getShipName()
	return pg.ship_data_statistics[self].name
end

function CardPuzzleShip:Ctor(arg_10_1)
	self.configId = arg_10_1.template_id or arg_10_1.configId
	self.level = arg_10_1.level
	self.exp = arg_10_1.exp

	if arg_10_1.name and arg_10_1.name ~= "" then
		self.name = arg_10_1.name
	else
		assert(pg.ship_data_statistics[self.configId], "必须存在配置" .. self.configId)

		self.name = pg.ship_data_statistics[self.configId].name
	end

	self.equipmentSkins = {}
	self.equipments = {}

	if arg_10_1.equip_info_list then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1.equip_info_list or {}) do
			self.equipments[iter_10_0] = iter_10_1.id > 0 and Equipment.New({
				count = 1,
				id = iter_10_1.id,
				config_id = iter_10_1.id,
				skinId = iter_10_1.skinId
			}) or false

			if iter_10_1.skinId > 0 then
				self.equipmentSkins[iter_10_0] = iter_10_1.skinId or 0
			end

			self:reletiveEquipSkin(iter_10_0)
		end
	end

	self.skills = {}

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.skill_id_list or {}) do
		self:updateSkill(iter_10_3)
	end

	self.star = self:getConfig("rarity")
	self.transforms = {}
	self.skinId = not HXSet.isHxSkin() and (arg_10_1.skin_id or 0) or 0

	if self.skinId == 0 then
		self.skinId = self:getConfig("skin_id")
	end

	return
end

function CardPuzzleShip:getActiveEquipments()
	local var_11_0 = Clone(self.equipments)

	for iter_11_0 = #var_11_0, 1, -1 do
		if var_11_0[iter_11_0] then
			for iter_11_1 = 1, iter_11_0 - 1 do
				if var_11_0[iter_11_1] and var_11_0[iter_11_0]:getConfig("equip_limit") ~= 0 and var_11_0[iter_11_1]:getConfig("equip_limit") == var_11_0[iter_11_0]:getConfig("equip_limit") then
					var_11_0[iter_11_0] = false
				end
			end
		end
	end

	return var_11_0
end

function CardPuzzleShip:getAllEquipments()
	return self.equipments
end

function CardPuzzleShip:updateSkinId(arg_13_1)
	self.skinId = arg_13_1

	return
end

function CardPuzzleShip:getPrefab()
	assert(pg.ship_skin_template[self.skinId], "ship_skin_template not exist: " .. self.configId .. " " .. self.skinId)

	return pg.ship_skin_template[self.skinId].prefab
end

function CardPuzzleShip:getPainting()
	assert(pg.ship_skin_template[self.skinId], "ship_skin_template not exist: " .. self.configId .. " " .. self.skinId)

	return pg.ship_skin_template[self.skinId].painting
end

function CardPuzzleShip:GetSkinConfig()
	assert(pg.ship_skin_template[self.skinId], "ship_skin_template not exist: " .. self.configId .. " " .. self.skinId)

	return pg.ship_skin_template[self.skinId]
end

function CardPuzzleShip:updateEquip(arg_17_1, arg_17_2)
	assert(arg_17_2 == nil or arg_17_2.count == 1)

	self.equipments[arg_17_1] = arg_17_2 and Clone(arg_17_2) or false

	return
end

function CardPuzzleShip:getEquip(arg_18_1)
	return Clone(self.equipments[arg_18_1])
end

function CardPuzzleShip:bindConfigTable()
	return pg.puzzle_ship_template
end

function CardPuzzleShip:isAvaiable()
	return true
end

CardPuzzleShip.PROPERTIES = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.AntiSub,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Armor,
	AttributeType.Hit,
	AttributeType.Speed,
	AttributeType.Dodge,
	AttributeType.Luck
}
CardPuzzleShip.DIVE_PROPERTIES = {
	AttributeType.OxyMax,
	AttributeType.OxyCost,
	AttributeType.OxyRecovery,
	AttributeType.OxyRecoveryBench,
	AttributeType.OxyAttackDuration,
	AttributeType.OxyRaidDistance
}
CardPuzzleShip.SONAR_PROPERTIES = {
	AttributeType.SonarRange
}

function CardPuzzleShip:getShipProperties()
	return (self:getBaseProperties())
end

function CardPuzzleShip:getBaseProperties()
	local var_22_0 = self:getConfigTable()

	assert(var_22_0, "配置表没有这艘船" .. self.configId)

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(CardPuzzleShip.PROPERTIES) do
		var_22_1[iter_22_1] = var_22_0[iter_22_1]
	end

	for iter_22_2, iter_22_3 in ipairs(CardPuzzleShip.DIVE_PROPERTIES) do
		var_22_1[iter_22_3] = 0
	end

	for iter_22_4, iter_22_5 in ipairs(CardPuzzleShip.SONAR_PROPERTIES) do
		var_22_1[iter_22_5] = 0
	end

	return var_22_1
end

function CardPuzzleShip:getGiftProperties(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(CardPuzzleShip.PROPERTIES) do
		var_23_0[iter_23_1] = 0
	end

	for iter_23_2, iter_23_3 in ipairs(CardPuzzleShip.DIVE_PROPERTIES) do
		var_23_0[iter_23_3] = 0
	end

	for iter_23_4, iter_23_5 in ipairs(CardPuzzleShip.SONAR_PROPERTIES) do
		var_23_0[iter_23_5] = 0
	end

	for iter_23_6, iter_23_7 in ipairs(arg_23_1) do
		if iter_23_7 then
			for iter_23_8, iter_23_9 in ipairs((iter_23_7:GetAttributeBonus(self))) do
				if iter_23_9 and var_23_0[iter_23_9.type] then
					var_23_0[iter_23_9.type] = var_23_0[iter_23_9.type] + iter_23_9.value
				end
			end
		end
	end

	return var_23_0
end

function CardPuzzleShip:getProperties(arg_24_1)
	local var_24_0 = self:getShipProperties()
	local var_24_1 = self:getGiftProperties(arg_24_1)

	for iter_24_0, iter_24_1 in ipairs(CardPuzzleShip.PROPERTIES) do
		var_24_0[iter_24_1] = iter_24_1 == AttributeType.Speed and var_24_0[iter_24_1] + var_24_1[iter_24_1] or calcFloor(var_24_0[iter_24_1] + var_24_1[iter_24_1])
	end

	for iter_24_2, iter_24_3 in ipairs(CardPuzzleShip.DIVE_PROPERTIES) do
		var_24_0[iter_24_3] = var_24_0[iter_24_3] + var_24_1[iter_24_3]
	end

	for iter_24_4, iter_24_5 in ipairs(CardPuzzleShip.SONAR_PROPERTIES) do
		var_24_0[iter_24_5] = var_24_0[iter_24_5] + var_24_1[iter_24_5]
	end

	return var_24_0
end

function CardPuzzleShip:getTriggerSkills()
	local var_25_0 = {}

	_.each(self:getSkillEffects(), function(arg_26_0)
		if arg_26_0.type == "AddBuff" and arg_26_0.arg_list and arg_26_0.arg_list.buff_id then
			var_25_0[arg_26_0.arg_list.buff_id] = {
				id = arg_26_0.arg_list.buff_id,
				level = arg_26_0.level
			}
		end

		return
	end)

	return var_25_0
end

function CardPuzzleShip:GetEquipmentSkills()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs((self:getActiveEquipments())) do
		if iter_27_1 then
			local var_27_1 = iter_27_1:getConfig("skill_id")[1]

			if var_27_1 then
				var_27_0[var_27_1] = {
					level = 1,
					id = var_27_1
				}
			end
		end
	end

	return var_27_0
end

function CardPuzzleShip:getAllSkills()
	local var_28_0 = Clone(self.skills)

	for iter_28_0, iter_28_1 in pairs(self:GetEquipmentSkills()) do
		var_28_0[iter_28_0] = iter_28_1
	end

	for iter_28_2, iter_28_3 in pairs(self:getTriggerSkills()) do
		var_28_0[iter_28_2] = iter_28_3
	end

	return var_28_0
end

function CardPuzzleShip:getRarity()
	assert(false)

	return
end

function CardPuzzleShip:upgrade()
	assert(false)

	return
end

function CardPuzzleShip:getTeamType()
	return ShipType.GetTeamFromShipType(self:getShipType())
end

function CardPuzzleShip:getMaxConfigId()
	local var_32_0

	for iter_32_0 = 4, 1, -1 do
		local var_32_1 = tonumber(self.groupId .. iter_32_0)

		if pg.ship_data_template[var_32_1] then
			var_32_0 = var_32_1

			break
		end
	end

	return var_32_0
end

function CardPuzzleShip:fateSkillChange(arg_33_1)
	if not self.skillChangeList then
		if self:isBluePrintShip() then
			self.skillChangeList = self:getBluePrint():getChangeSkillList() or {}
		end
	end

	for iter_33_0, iter_33_1 in ipairs(self.skillChangeList) do
		if iter_33_1[1] == arg_33_1 and self.skills[iter_33_1[2]] then
			return iter_33_1[2]
		end
	end

	return arg_33_1
end

function CardPuzzleShip:getSkillList()
	local var_34_0 = Clone(pg.ship_data_template[self.configId].buff_list)

	if pg.ship_data_trans[self.groupId] and pg.ship_data_trans[self.groupId].skill_id ~= 0 then
		if self.transforms[pg.ship_data_trans[self.groupId].skill_id] and pg.transform_data_template[pg.ship_data_trans[self.groupId].skill_id].skill_id ~= 0 then
			table.insert(var_34_0, pg.transform_data_template[pg.ship_data_trans[self.groupId].skill_id].skill_id)
		end
	end

	local var_34_2 = {}

	for iter_34_0, iter_34_1 in ipairs((Clone(pg.ship_data_template[self.configId].buff_list_display))) do
		for iter_34_2, iter_34_3 in ipairs(var_34_0) do
			if iter_34_1 == iter_34_3 then
				table.insert(var_34_2, self:fateSkillChange(iter_34_1))
			end
		end
	end

	return var_34_2
end

function CardPuzzleShip:getDisplaySkillIds()
	return _.map(pg.ship_data_template[self.configId].buff_list_display, function(arg_36_0)
		return self:fateSkillChange(arg_36_0)
	end)
end

function CardPuzzleShip:getSkillIndex(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs((self:getSkillList())) do
		if arg_37_1 == iter_37_1 then
			return iter_37_0
		end
	end

	return
end

function CardPuzzleShip:IsBgmSkin()
	return table.contains(self:GetSkinConfig().tag, ShipSkin.WITH_BGM)
end

function CardPuzzleShip:GetSkinBgm()
	if self:IsBgmSkin() then
		return self:GetSkinConfig().bgm
	end

	return
end

function CardPuzzleShip:GetConfigId()
	return self.configId
end

function CardPuzzleShip:GetDefaultCards()
	return self:getConfig("default_card")
end

return CardPuzzleShip
