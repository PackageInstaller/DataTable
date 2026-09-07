local Ship = class("Ship", import(".BaseVO"))

Ship.ENERGY_MID = 40
Ship.ENERGY_LOW = 0
Ship.RECOVER_ENERGY_POINT = 2
Ship.INTIMACY_PROPOSE = 6
Ship.CONFIG_MAX_STAR = 6
Ship.BACKYARD_1F_ENERGY_ADDITION = 2
Ship.BACKYARD_2F_ENERGY_ADDITION = 3
Ship.PREFERENCE_TAG_NONE = 0
Ship.PREFERENCE_TAG_COMMON = 1

local var_0_1 = {
	vanguard = i18n("word_vanguard_fleet"),
	main = i18n("word_main_fleet")
}

Ship.LOCK_STATE_UNLOCK = 0
Ship.LOCK_STATE_LOCK = 1
Ship.WEAPON_COUNT = 3
Ship.PREFAB_EQUIP = 4
Ship.MAX_SKILL_LEVEL = 10
Ship.ENERGY_RECOVER_TIME = 360

local var_0_2 = 4
local var_0_4 = 120
local var_0_5 = pg.ship_data_strengthen
local var_0_6 = pg.ship_level
local var_0_7 = pg.equip_skin_template
local var_0_8 = pg.ship_data_breakout

function nation2print(arg_1_0)
	return Nation.Nation2Print(arg_1_0)
end

function Ship:getRecoverEnergyPoint()
	return self.propose and 3 or 2
end

function shipType2name(arg_3_0)
	return ShipType.Type2Name(arg_3_0)
end

function shipType2print(arg_4_0)
	return ShipType.Type2Print(arg_4_0)
end

function shipType2Battleprint(arg_5_0)
	return ShipType.Type2BattlePrint(arg_5_0)
end

function skinId2bgPrint(arg_6_0)
	if pg.ship_skin_template[arg_6_0].rarity_bg and pg.ship_skin_template[arg_6_0].rarity_bg ~= "" then
		return pg.ship_skin_template[arg_6_0].rarity_bg
	end

	return
end

function Ship:useSkin(arg_7_1)
	local var_7_0 = self:getSkinId()

	if var_7_0 == arg_7_1 then
		return true
	end

	local var_7_1 = ShipSkin.GetChangeSkinGroupId(var_7_0)
	local var_7_2 = ShipSkin.GetChangeSkinGroupId(arg_7_1)

	if var_7_1 and var_7_2 and var_7_1 == var_7_2 then
		return true
	end

	return false
end

function Ship:rarity2bgPrint()
	return shipRarity2bgPrint(self:getRarity(), self:isBluePrintShip(), self:isMetaShip())
end

function Ship:rarity2bgPrintForGet()
	return skinId2bgPrint(self:getSkinId()) or self:rarity2bgPrint()
end

function Ship:getShipBgPrint(arg_10_1)
	local var_10_0 = self:getSkinId()

	assert(pg.ship_skin_template[var_10_0], "ship_skin_template not exist: " .. var_10_0)

	local var_10_1

	if not arg_10_1 and pg.ship_skin_template[var_10_0].bg_sp and pg.ship_skin_template[var_10_0].bg_sp ~= "" and PlayerPrefs.GetInt("paint_hide_other_obj_" .. pg.ship_skin_template[var_10_0].painting, 0) == 0 then
		var_10_1 = pg.ship_skin_template[var_10_0].bg_sp
	end

	if not var_10_1 or not var_10_1 then
		::label_10_0::

		local var_10_2

		if pg.ship_skin_template[var_10_0].bg and #pg.ship_skin_template[var_10_0].bg > 0 then
			var_10_2 = pg.ship_skin_template[var_10_0].bg or self:rarity2bgPrintForGet()
		end
	end

	return var_10_2
end

function Ship:getStar()
	return self:getConfig("star")
end

function Ship:getMaxStar()
	return pg.ship_data_template[self.configId].star_max
end

function Ship:getShipArmor()
	return self:getConfig("armor_type")
end

function Ship:getShipArmorName()
	return ArmorType.Type2Name((self:getShipArmor()))
end

function Ship:getGroupId()
	return pg.ship_data_template[self.configId].group_type
end

function Ship:getGroupIdByConfigId()
	return math.floor(self / 10)
end

function Ship:getTransformShipId()
	if pg.ship_data_trans[pg.ship_data_template[self].group_type] then
		for iter_17_0, iter_17_1 in ipairs(pg.ship_data_trans[pg.ship_data_template[self].group_type].transform_list) do
			for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
				for iter_17_4, iter_17_5 in ipairs(pg.transform_data_template[iter_17_3[2]].ship_id) do
					if iter_17_5[1] == self then
						return iter_17_5[2]
					end
				end
			end
		end
	end

	return
end

function Ship:getAircraftCount()
	local var_18_0 = self:getConfigTable().base_list
	local var_18_1 = self:getConfigTable().default_equip_list
	local var_18_2 = {}

	for iter_18_0 = 1, 3 do
		local var_18_3 = Equipment.getConfigData(self:getEquip(iter_18_0) and self:getEquip(iter_18_0).configId or var_18_1[iter_18_0]).type

		if table.contains(EquipType.AirDomainEquip, var_18_3) then
			var_18_2[var_18_3] = defaultValue(var_18_2[var_18_3], 0) + var_18_0[iter_18_0]
		end
	end

	return var_18_2
end

function Ship:getShipType()
	return self:getConfig("type")
end

function Ship:getEnergy()
	return self.energy
end

function Ship:getEnergeConfig()
	local var_21_0 = self:getEnergy()

	for iter_21_0, iter_21_1 in ipairs(pg.energy_template.all) do
		if type(iter_21_1) == "number" and var_21_0 >= pg.energy_template[iter_21_1].lower_bound and var_21_0 <= pg.energy_template[iter_21_1].upper_bound then
			return pg.energy_template[iter_21_1]
		end
	end

	assert(false, "疲劳配置不存在：" .. self.energy)

	return
end

function Ship:isLowEnergy()
	return self:getEnergeConfig().id < 3
end

function Ship:getEnergyPrint()
	local var_23_0 = self:getEnergeConfig()

	return var_23_0.icon, var_23_0.desc
end

function Ship:getIntimacy()
	return self.intimacy or 0
end

function Ship:getCVIntimacy()
	return self:getIntimacy() / 100 + (self.propose and 1000 or 0)
end

function Ship:getIntimacyMax()
	if self.propose then
		return 200
	else
		return self:GetNoProposeIntimacyMax()
	end

	return
end

function Ship:GetNoProposeIntimacyMax()
	return 100
end

function Ship:getIntimacyIcon()
	local var_28_0 = pg.intimacy_template[self:getIntimacyLevel()]
	local var_28_1 = ""

	if self:isMetaShip() then
		var_28_1 = "_meta"
	elseif self:IsXIdol() then
		var_28_1 = "_imas"
	end

	if not self.propose and math.floor(self:getIntimacy() / 100) >= self:getIntimacyMax() then
		return var_28_0.icon .. var_28_1, "heart" .. var_28_1
	else
		return var_28_0.icon .. var_28_1
	end

	return
end

function Ship:getIntimacyDetail()
	local var_29_0 = self:getIntimacyMax()
	local var_29_1 = math.floor(self:getIntimacy() / 100)
end

function Ship:getIntimacyInfo()
	local var_30_0 = pg.intimacy_template[self:getIntimacyLevel()]

	return var_30_0.icon, var_30_0.desc
end

function Ship:getIntimacyLevel()
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in pairs(pg.intimacy_template.all) do
		if type(iter_31_1) == "number" and self:getIntimacy() >= pg.intimacy_template[iter_31_1].lower_bound and self:getIntimacy() <= pg.intimacy_template[iter_31_1].upper_bound then
			var_31_0 = iter_31_1

			break
		end
	end

	if var_31_0 < self.INTIMACY_PROPOSE and self.propose then
		var_31_0 = self.INTIMACY_PROPOSE
	end

	return var_31_0
end

function Ship:getBluePrint()
	local var_32_0 = ShipBluePrint.New({
		id = self.groupId
	})
	local var_32_1 = self.strengthList[1] or {
		exp = 0,
		level = 0
	}

	var_32_0:updateInfo({
		blue_print_level = var_32_1.level,
		exp = var_32_1.exp
	})

	return var_32_0
end

function Ship:getBaseList()
	if self:isBluePrintShip() then
		local var_33_0 = self:getBluePrint()

		assert(var_33_0, "blueprint can not be nil" .. self.configId)

		return var_33_0:getBaseList(self)
	else
		return self:getConfig("base_list")
	end

	return
end

function Ship:getPreLoadCount()
	if self:isBluePrintShip() then
		return self:getBluePrint():getPreLoadCount(self)
	else
		return self:getConfig("preload_count")
	end

	return
end

function Ship:getNation()
	return self:getConfig("nationality")
end

function Ship:getPaintingName()
	assert(pg.ship_skin_template[pg.ship_data_statistics[self].skin_id], "ship_skin_template not exist: " .. self .. " " .. pg.ship_data_statistics[self].skin_id)

	return pg.ship_skin_template[pg.ship_data_statistics[self].skin_id].painting
end

function Ship:getName()
	if self.propose then
		if pg.PushNotificationMgr.GetInstance():isEnableShipName() then
			return self.name
		end
	end

	if self:isRemoulded() then
		return pg.ship_skin_template[self:getRemouldSkinId()].name
	end

	return pg.ship_data_statistics[self.configId].name
end

function Ship:GetDefaultName()
	if self:isRemoulded() then
		return pg.ship_skin_template[self:getRemouldSkinId()].name
	else
		return pg.ship_data_statistics[self.configId].name
	end

	return
end

function Ship:getShipName()
	return pg.ship_data_statistics[self].name
end

function Ship:getBreakOutLevel()
	assert(self, "必须存在配置id")
	assert(pg.ship_data_statistics[self], "必须存在配置" .. self)

	return pg.ship_data_statistics[self].star
end

function Ship:Ctor(arg_41_1)
	self.id = arg_41_1.id
	self.configId = arg_41_1.template_id or arg_41_1.configId
	self.level = arg_41_1.level
	self.exp = arg_41_1.exp
	self.energy = arg_41_1.energy
	self.lockState = arg_41_1.is_locked
	self.intimacy = arg_41_1.intimacy
	self.propose = arg_41_1.propose and arg_41_1.propose > 0
	self.proposeTime = arg_41_1.propose

	if self.intimacy and self.intimacy > 10000 and not self.propose then
		self.intimacy = 10000
	end

	self.renameTime = arg_41_1.change_name_timestamp

	if arg_41_1.name and arg_41_1.name ~= "" then
		self.name = arg_41_1.name
	else
		assert(pg.ship_data_statistics[self.configId], "必须存在配置" .. self.configId)

		self.name = pg.ship_data_statistics[self.configId].name
	end

	self.groupId = pg.ship_data_template[self.configId].group_type
	self.bluePrintFlag = pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[self.groupId][1]].handbook_type == 2
	self.strengthList = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1.strength_list or {}) do
		if not self:isBluePrintShip() then
			self.strengthList[ShipModAttr.ID_TO_ATTR[iter_41_1.id]] = iter_41_1.exp
		else
			table.insert(self.strengthList, {
				level = iter_41_1.id,
				exp = iter_41_1.exp
			})
		end
	end

	self.equipmentSkins = {}
	self.equipments = {}

	if arg_41_1.equip_info_list then
		for iter_41_2, iter_41_3 in ipairs(arg_41_1.equip_info_list or {}) do
			self.equipments[iter_41_2] = iter_41_3.id > 0 and Equipment.New({
				count = 1,
				id = iter_41_3.id,
				config_id = iter_41_3.id,
				skinId = iter_41_3.skinId
			}) or false

			if iter_41_3.skinId > 0 then
				self.equipmentSkins[iter_41_2] = iter_41_3.skinId or 0
			end

			self:reletiveEquipSkin(iter_41_2)
		end
	end

	self.spWeapon = nil

	if arg_41_1.spweapon then
		self:UpdateSpWeapon(SpWeapon.CreateByNet(arg_41_1.spweapon))
	end

	self.skills = {}

	for iter_41_4, iter_41_5 in ipairs(arg_41_1.skill_id_list or {}) do
		self:updateSkill(iter_41_5)
	end

	self.star = self:getConfig("rarity")
	self.transforms = {}

	for iter_41_6, iter_41_7 in ipairs(arg_41_1.transform_list or {}) do
		self.transforms[iter_41_7.id] = {
			id = iter_41_7.id,
			level = iter_41_7.level
		}
	end

	self.createTime = arg_41_1.create_time or 0

	local var_41_2 = getProxy(CollectionProxy)

	self.virgin = var_41_2 and var_41_2.shipGroups[self.groupId] == nil

	local var_41_3 = table.indexof({
		pg.gameset.test_ship_config_1.key_value,
		pg.gameset.test_ship_config_2.key_value,
		pg.gameset.test_ship_config_3.key_value
	}, self.configId)

	self.testShip = var_41_3 == 1 and {
		2,
		3,
		4
	} or var_41_3 == 2 and {
		5
	} or var_41_3 == 3 and {
		6
	} or nil
	self.maxIntimacy = pg.intimacy_template[#pg.intimacy_template.all].upper_bound

	local var_41_4 = 0

	if not HXSet.isHxSkin() then
		var_41_4 = arg_41_1.skin_id or 0
	end

	self.phantomDic = {}

	self:updateSkinId(var_41_4, 0)

	for iter_41_8, iter_41_9 in ipairs(arg_41_1.skin_shadow_list or {}) do
		self:updateSkinId(iter_41_9.value, iter_41_9.key)
	end

	self.noChangeSkin = arg_41_1.noChangeSkin or false
	self.phantomRandomFlag = {}

	for iter_41_10, iter_41_11 in ipairs(arg_41_1.char_random_flag or {}) do
		self:updateRandomFlag(1, iter_41_11)
	end

	self.name = arg_41_1.name and arg_41_1.name ~= "" and arg_41_1.name or self:isRemoulded() and pg.ship_skin_template[self:getRemouldSkinId()].name or pg.ship_data_statistics[self.configId].name
	self.maxLevel = arg_41_1.max_level
	self.proficiency = arg_41_1.proficiency or 0
	self.preferenceTag = arg_41_1.common_flag
	self.hpRant = 10000
	self.strategies = {}
	self.triggers = {}
	self.commanderId = arg_41_1.commanderid or 0
	self.activityNpc = arg_41_1.activity_npc or 0

	if Ship.isMetaShipByConfigID(self.configId) then
		self.metaCharacter = MetaCharacter.New({
			id = MetaCharacterConst.GetMetaShipGroupIDByConfigID(self.configId),
			repair_attr_info = arg_41_1.meta_repair_list
		}, self)
	end

	return
end

function Ship:isMetaShipByConfigID()
	local var_42_0 = false

	if pg.ship_meta_breakout.all[1] <= self then
		for iter_42_0, iter_42_1 in ipairs(pg.ship_meta_breakout.all) do
			if self == iter_42_1 then
				var_42_0 = true

				break
			end
		end
	end

	return var_42_0
end

function Ship:isMetaShip()
	return self.metaCharacter ~= nil
end

function Ship:getMetaCharacter()
	return self.metaCharacter
end

function Ship:unlockActivityNpc(arg_45_1)
	self.activityNpc = arg_45_1

	return
end

function Ship:isActivityNpc()
	return self.activityNpc > 0
end

function Ship:getActiveEquipments()
	local var_47_0 = Clone(self.equipments)

	for iter_47_0 = #var_47_0, 1, -1 do
		if var_47_0[iter_47_0] then
			for iter_47_1 = 1, iter_47_0 - 1 do
				if var_47_0[iter_47_1] and var_47_0[iter_47_0]:getConfig("equip_limit") ~= 0 and var_47_0[iter_47_1]:getConfig("equip_limit") == var_47_0[iter_47_0]:getConfig("equip_limit") then
					var_47_0[iter_47_0] = false
				end
			end
		end
	end

	return var_47_0
end

function Ship:getAllEquipments()
	return self.equipments
end

function Ship:isBluePrintShip()
	return self.bluePrintFlag
end

function Ship:getSkinId(arg_50_1)
	local var_50_0 = self:getPhantomSkin(arg_50_1 or 0)

	if not self.noChangeSkin and tobool(self.id) and ShipSkin.IsChangeSkin(var_50_0) then
		local var_50_1 = ShipSkin.GetStoreChangeSkinId(ShipSkin.GetChangeSkinGroupId(var_50_0), self:GetShipPhantomMark())

		if var_50_1 then
			return var_50_1
		end
	end

	return var_50_0
end

function Ship:RevertAsmrSkin()
	local var_51_0 = self:getSkinId()

	if not self.noChangeSkin and tobool(self.id) and ShipSkin.IsChangeSkin(var_51_0) then
		if ShipSkin.GetChangeSkinCustomDataId(var_51_0, "asmr") == 1 and ShipSkin.GetChangeSkinCustomDataId(var_51_0, "index") ~= 1 then
			ShipSkin.SetStoreChangeSkinId(ShipSkin.GetChangeSkinMainId(var_51_0), self:GetShipPhantomMark())
		end
	end

	return
end

function Ship:getPhantomSkin(arg_52_1)
	if not arg_52_1 or arg_52_1 == 0 then
		return self.skinId
	else
		return self.phantomDic[self.phantomId] or self:getConfig("skin_id")
	end

	return
end

function Ship:updateSkinId(arg_53_1, arg_53_2)
	if not arg_53_1 or arg_53_1 == 0 then
		arg_53_1 = self:getConfig("skin_id")
	end

	if arg_53_2 == 0 then
		self.skinId = arg_53_1
	else
		self.phantomDic[arg_53_2] = arg_53_1
	end

	return
end

function Ship:getAllShipPhantomMarks()
	local var_54_0 = {}

	for iter_54_0 = 0, getGameset("technology_shadow_num")[1] do
		if iter_54_0 == 0 or self.phantomDic[iter_54_0] then
			table.insert(var_54_0, ShipPhantom.PackMark(self.id, iter_54_0))
		end
	end

	return var_54_0
end

function Ship:getAllShipPhantom()
	local var_55_0 = {}

	for iter_55_0 = 0, getGameset("technology_shadow_num")[1] do
		if iter_55_0 == 0 or self.phantomDic[iter_55_0] then
			table.insert(var_55_0, ShipPhantom.Create(self, iter_55_0))
		end
	end

	return var_55_0
end

function Ship:updateRandomFlag(arg_56_1, arg_56_2)
	arg_56_2 = defaultValue(arg_56_2, 0)
	self.phantomRandomFlag[arg_56_2] = arg_56_1

	return
end

function Ship:getRandomFlag(arg_57_1)
	return defaultValue(self.phantomRandomFlag[arg_57_1 or 0], 0) > 0
end

function Ship:getRandomFlagShipPhantomMarks()
	local var_58_0 = {}

	for iter_58_0 = 0, getGameset("technology_shadow_num")[1] do
		if defaultValue(self.phantomRandomFlag[iter_58_0], 0) > 0 then
			table.insert(var_58_0, self:GetShipPhantomMark(iter_58_0))
		end
	end

	return var_58_0
end

function Ship:updateName()
	if self.name ~= pg.ship_data_statistics[self.configId].name then
		return
	end

	self.name = self:isRemoulded() and pg.ship_skin_template[self:getRemouldSkinId()].name or pg.ship_data_statistics[self.configId].name

	return
end

function Ship:isRemoulded()
	if self.remoulded then
		return true
	end

	if pg.ship_data_trans[self.groupId] then
		for iter_60_0, iter_60_1 in ipairs(pg.ship_data_trans[self.groupId].transform_list) do
			for iter_60_2, iter_60_3 in ipairs(iter_60_1) do
				if pg.transform_data_template[iter_60_3[2]].skin_id ~= 0 and self.transforms[iter_60_3[2]] and self.transforms[iter_60_3[2]].level == pg.transform_data_template[iter_60_3[2]].max_level then
					return true
				end
			end
		end
	end

	return false
end

function Ship:getRemouldSkinId()
	local var_61_0 = ShipGroup.getModSkin(self.groupId)

	if var_61_0 then
		return var_61_0.id
	end

	return nil
end

function Ship:hasEquipmentSkinInPos(arg_62_1)
	return self.equipments[arg_62_1] and self.equipments[arg_62_1]:hasSkin()
end

function Ship:getPrefab(arg_63_1)
	local var_63_0 = self:getSkinId()

	if self:hasEquipmentSkinInPos(var_0_2) then
		local var_63_1 = var_0_7[self:getEquip(var_0_2):getSkinId()].ship_skin_id

		var_63_0 = var_63_1 ~= 0 and var_63_1 or var_63_0
	end

	local var_63_2 = pg.ship_skin_template[var_63_0]

	assert(pg.ship_skin_template[var_63_0], "ship_skin_template not exist: " .. self.configId .. " " .. var_63_0)

	if var_63_2.double_char and var_63_2.double_char == 1 and arg_63_1 ~= nil then
		if arg_63_1 == 1 then
			return var_63_2.prefab .. "_L"
		elseif arg_63_1 == 2 then
			return var_63_2.prefab .. "_R"
		end
	end

	return var_63_2.prefab
end

function Ship:IsDoubleSkin()
	local var_64_0 = self:getSkinId()
	local var_64_1 = pg.ship_skin_template[var_64_0]

	assert(pg.ship_skin_template[var_64_0], "ship_skin_template not exist: " .. self.configId .. " " .. var_64_0)

	return var_64_1.double_char and var_64_1.double_char == 1 or false
end

function Ship:getAttachmentPrefab()
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in ipairs(self.equipments) do
		if iter_65_1 and iter_65_1:hasSkinOrbit() then
			local var_65_1 = iter_65_1:getSkinId()

			var_65_0[var_65_1] = {
				config = var_0_7[var_65_1],
				index = iter_65_0
			}
		end
	end

	return var_65_0
end

function Ship:getPainting()
	local var_66_0 = self:getSkinId()

	assert(pg.ship_skin_template[var_66_0], "ship_skin_template not exist: " .. self.configId .. " " .. var_66_0)

	return pg.ship_skin_template[var_66_0].painting
end

function Ship:GetSkinConfig(arg_67_1)
	local var_67_0 = self:getSkinId()

	assert(pg.ship_skin_template[var_67_0], "ship_skin_template not exist: " .. self.configId .. " " .. var_67_0)

	return pg.ship_skin_template[var_67_0]
end

function Ship:getRemouldPainting()
	local var_68_0 = self:getRemouldSkinId()

	assert(pg.ship_skin_template[var_68_0], "ship_skin_template not exist: " .. self.configId .. " " .. var_68_0)

	return pg.ship_skin_template[var_68_0].painting
end

function Ship:isTestShip()
	return self.testShip
end

function Ship:canUseTestShip(arg_70_1)
	assert(self.testShip, "ship is not TestShip")

	return table.contains(self.testShip, arg_70_1)
end

function Ship:updateEquip(arg_71_1, arg_71_2)
	assert(arg_71_2 == nil or arg_71_2.count == 1)

	local var_71_0 = self.equipments[arg_71_1]

	self.equipments[arg_71_1] = arg_71_2 and Clone(arg_71_2) or false

	local function var_71_2(arg_72_0)
		arg_72_0 = CreateShell(arg_72_0)
		arg_72_0.shipId = self.id
		arg_72_0.shipPos = arg_71_1

		return arg_72_0
	end

	if var_71_0 then
		getProxy(EquipmentProxy):OnShipEquipsRemove(var_71_0, self.id, arg_71_1)
		var_71_0:setSkinId(0)
		pg.m02:sendNotification(BayProxy.SHIP_EQUIPMENT_REMOVED, var_71_2(var_71_0))
	end

	if arg_71_2 then
		getProxy(EquipmentProxy):OnShipEquipsAdd(arg_71_2, self.id, arg_71_1)
		self:reletiveEquipSkin(arg_71_1)
		pg.m02:sendNotification(BayProxy.SHIP_EQUIPMENT_ADDED, var_71_2(arg_71_2))
	end

	return
end

function Ship:reletiveEquipSkin(arg_73_1)
	if self.equipments[arg_73_1] and self.equipmentSkins[arg_73_1] ~= 0 then
		if table.contains(pg.equip_skin_template[self.equipmentSkins[arg_73_1]].equip_type, (self.equipments[arg_73_1]:getType())) then
			self.equipments[arg_73_1]:setSkinId(self.equipmentSkins[arg_73_1])
		else
			self.equipments[arg_73_1]:setSkinId(0)
		end
	elseif self.equipments[arg_73_1] then
		self.equipments[arg_73_1]:setSkinId(0)
	end

	return
end

function Ship:updateEquipmentSkin(arg_74_1, arg_74_2)
	if not arg_74_1 then
		return
	end

	if arg_74_2 and arg_74_2 > 0 then
		local var_74_0 = pg.equip_skin_template[arg_74_2].equip_type
		local var_74_1 = false

		for iter_74_0, iter_74_1 in ipairs((self:getSkinTypes(arg_74_1))) do
			for iter_74_2, iter_74_3 in ipairs(var_74_0) do
				if iter_74_1 == iter_74_3 then
					var_74_1 = true

					break
				end
			end
		end

		if not var_74_1 then
			assert(var_74_1, "部位" .. arg_74_1 .. " 无法穿戴皮肤 " .. arg_74_2)

			return
		end

		local var_74_2 = self.equipments[arg_74_1] and self.equipments[arg_74_1]:getType() or false

		self.equipmentSkins[arg_74_1] = arg_74_2

		if var_74_2 and table.contains(var_74_0, var_74_2) then
			self.equipments[arg_74_1]:setSkinId(self.equipmentSkins[arg_74_1])
		elseif var_74_2 and not table.contains(var_74_0, var_74_2) then
			self.equipments[arg_74_1]:setSkinId(0)
		end
	else
		self.equipmentSkins[arg_74_1] = 0

		if self.equipments[arg_74_1] then
			self.equipments[arg_74_1]:setSkinId(0)
		end
	end

	return
end

function Ship:getEquip(arg_75_1)
	return Clone(self.equipments[arg_75_1])
end

function Ship:getEquipSkins()
	return Clone(self.equipmentSkins)
end

function Ship:getEquipSkin(arg_77_1)
	return self.equipmentSkins[arg_77_1]
end

function Ship:getCanEquipSkin(arg_78_1)
	local var_78_0 = self:getSkinTypes(arg_78_1)

	if var_78_0 and #var_78_0 then
		for iter_78_0, iter_78_1 in ipairs(var_78_0) do
			if pg.equip_data_by_type[iter_78_1].equip_skin == 1 then
				return true
			end
		end
	end

	return false
end

function Ship:checkCanEquipSkin(arg_79_1, arg_79_2)
	if not arg_79_1 or not arg_79_2 then
		return
	end

	for iter_79_0, iter_79_1 in ipairs((self:getSkinTypes(arg_79_1))) do
		if table.contains(pg.equip_skin_template[arg_79_2].equip_type, iter_79_1) then
			return true
		end
	end

	return false
end

function Ship:getSkinTypes(arg_80_1)
	return pg.ship_data_template[self.configId]["equip_" .. arg_80_1] or {}
end

function Ship:addSkillExp(arg_81_1, arg_81_2)
	local var_81_0 = self.skills[arg_81_1] or {
		exp = 0,
		level = 1,
		id = arg_81_1
	}
	local var_81_1

	if var_81_0.level then
		var_81_1 = var_81_0.level or 1
	end

	local var_81_2 = pg.skill_need_exp.all[#pg.skill_need_exp.all]

	if var_81_1 == pg.skill_need_exp.all[#pg.skill_need_exp.all] then
		return
	end

	local var_81_3

	if var_81_0.exp then
		var_81_3 = arg_81_2 + var_81_0.exp or 0 + arg_81_2

		while var_81_3 >= pg.skill_need_exp[var_81_1].exp do
			var_81_3 = var_81_3 - pg.skill_need_exp[var_81_1].exp
			var_81_1 = var_81_1 + 1

			if var_81_1 == var_81_2 then
				var_81_3 = 0

				break
			end
		end
	end

	self:updateSkill({
		id = var_81_0.id,
		level = var_81_1,
		exp = var_81_3
	})

	return
end

function Ship:upSkillLevelForMeta(arg_82_1)
	local var_82_0 = self.skills[arg_82_1]
	local var_82_1

	if not self.skills[arg_82_1] then
		var_82_0 = {
			exp = 0,
			level = 0,
			id = arg_82_1
		}
		var_82_1 = var_82_0.level
	end

	if not self:isSkillLevelMax(arg_82_1) then
		var_82_1 = var_82_1 + 1
	end

	self:updateSkill({
		exp = 0,
		id = var_82_0.id,
		level = var_82_1
	})

	return
end

function Ship:getMetaSkillLevelBySkillID(arg_83_1)
	return (self.skills[arg_83_1] or {
		exp = 0,
		level = 0,
		id = arg_83_1
	}).level
end

function Ship:isSkillLevelMax(arg_84_1)
	local var_84_0 = self.skills[arg_84_1] or {
		exp = 0,
		level = 1,
		id = arg_84_1
	}

	return ((var_84_0.level or nil) and (var_84_0.level or 1)) >= pg.skill_data_template[arg_84_1].max_level
end

function Ship:isAllMetaSkillLevelMax()
	local var_85_0 = true

	for iter_85_0, iter_85_1 in ipairs((MetaCharacterConst.getTacticsSkillIDListByShipConfigID(self.configId))) do
		if not self:isSkillLevelMax(iter_85_1) then
			var_85_0 = false

			break
		end
	end

	return var_85_0
end

function Ship:isAllMetaSkillLock()
	local var_86_0 = true

	for iter_86_0, iter_86_1 in ipairs((MetaCharacterConst.getTacticsSkillIDListByShipConfigID(self.configId))) do
		if self:getMetaSkillLevelBySkillID(iter_86_1) > 0 then
			var_86_0 = false

			break
		end
	end

	return var_86_0
end

function Ship:bindConfigTable()
	return pg.ship_data_statistics
end

function Ship:isAvaiable()
	return true
end

Ship.PROPERTIES = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Armor,
	AttributeType.Hit,
	AttributeType.Dodge,
	AttributeType.Speed,
	AttributeType.Luck,
	AttributeType.AntiSub
}
Ship.PROPERTIES_ENHANCEMENT = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Hit,
	AttributeType.Dodge,
	AttributeType.Speed,
	AttributeType.Luck,
	AttributeType.AntiSub
}
Ship.DIVE_PROPERTIES = {
	AttributeType.OxyMax,
	AttributeType.OxyCost,
	AttributeType.OxyRecovery,
	AttributeType.OxyRecoveryBench,
	AttributeType.OxyRecoverySurface,
	AttributeType.OxyAttackDuration,
	AttributeType.OxyRaidDistance
}
Ship.SONAR_PROPERTIES = {
	AttributeType.SonarRange
}

function Ship:intimacyAdditions(arg_89_1)
	local var_89_0 = pg.intimacy_template[self:getIntimacyLevel()].attr_bonus * 0.0001

	for iter_89_0, iter_89_1 in pairs(arg_89_1) do
		if iter_89_0 == AttributeType.Durability or iter_89_0 == AttributeType.Cannon or iter_89_0 == AttributeType.Torpedo or iter_89_0 == AttributeType.AntiAircraft or iter_89_0 == AttributeType.AntiSub or iter_89_0 == AttributeType.Air or iter_89_0 == AttributeType.Reload or iter_89_0 == AttributeType.Hit or iter_89_0 == AttributeType.Dodge then
			arg_89_1[iter_89_0] = arg_89_1[iter_89_0] * (var_89_0 + 1)
		end
	end

	return
end

function Ship:getShipProperties()
	local var_90_0 = self:getBaseProperties()

	if self:isBluePrintShip() then
		local var_90_1 = self:getBluePrint()

		assert(var_90_1, "blueprint can not be nil" .. self.configId)

		for iter_90_0, iter_90_1 in pairs((var_90_1:getTotalAdditions())) do
			var_90_0[iter_90_0] = var_90_0[iter_90_0] + calcFloor(iter_90_1)
		end

		self:intimacyAdditions(var_90_0)
	elseif self:isMetaShip() then
		assert(self.metaCharacter)

		for iter_90_2, iter_90_3 in pairs(var_90_0) do
			var_90_0[iter_90_2] = var_90_0[iter_90_2] + self.metaCharacter:getAttrAddition(iter_90_2)
		end

		self:intimacyAdditions(var_90_0)
	else
		local var_90_2 = var_0_5[pg.ship_data_template[self.configId].strengthen_id]

		for iter_90_4, iter_90_5 in pairs(self.strengthList) do
			var_90_0[iter_90_4] = var_90_0[iter_90_4] + calcFloor(math.min(iter_90_5, var_90_2.durability[ShipModAttr.ATTR_TO_INDEX[iter_90_4]] * var_90_2.level_exp[ShipModAttr.ATTR_TO_INDEX[iter_90_4]]) / math.max(self:getModExpRatio(iter_90_4), 1))
		end

		self:intimacyAdditions(var_90_0)

		for iter_90_6, iter_90_7 in pairs(self.transforms) do
			for iter_90_8 = 1, iter_90_7.level do
				local var_90_3 = pg.transform_data_template[iter_90_7.id].effect[iter_90_8] or {}

				for iter_90_9, iter_90_10 in pairs(var_90_0) do
					if var_90_3[iter_90_9] then
						var_90_0[iter_90_9] = var_90_0[iter_90_9] + var_90_3[iter_90_9]
					end
				end
			end
		end
	end

	return var_90_0
end

function Ship:getTechNationAddition(arg_91_1)
	local var_91_0 = getProxy(TechnologyNationProxy)
	local var_91_1 = self:getConfig("type")

	if var_91_1 == ShipType.DaoQuV or var_91_1 == ShipType.DaoQuM then
		var_91_1 = ShipType.QuZhu
	end

	return var_91_0:getShipAddition(var_91_1, arg_91_1)
end

function Ship:getTechNationMaxAddition(arg_92_1)
	return getProxy(TechnologyNationProxy):getShipMaxAddition(self:getConfig("type"), arg_92_1)
end

function Ship:getEquipProficiencyByPos(arg_93_1)
	return self:getEquipProficiencyList()[arg_93_1]
end

function Ship:getEquipProficiencyList()
	local var_94_0 = Clone(self:getConfigTable().equipment_proficiency)

	if self:isBluePrintShip() then
		local var_94_1 = self:getBluePrint()

		assert(var_94_1, "blueprint can not be nil >>>" .. self.groupId)

		var_94_0 = var_94_1:getEquipProficiencyList(self)
	else
		for iter_94_0, iter_94_1 in ipairs(var_94_0) do
			local var_94_2 = 0

			for iter_94_2, iter_94_3 in pairs(self.transforms) do
				for iter_94_4 = 1, iter_94_3.level do
					local var_94_3 = pg.transform_data_template[iter_94_3.id].effect[iter_94_4] or {}

					if var_94_3["equipment_proficiency_" .. iter_94_0] then
						var_94_2 = var_94_2 + var_94_3["equipment_proficiency_" .. iter_94_0]
					end
				end
			end

			var_94_0[iter_94_0] = iter_94_1 + var_94_2
		end
	end

	return var_94_0
end

function Ship:getBaseProperties()
	local var_95_0 = self:getConfigTable()

	assert(var_95_0, "配置表没有这艘船" .. self.configId)

	local var_95_1 = {}
	local var_95_2 = {}

	for iter_95_0, iter_95_1 in ipairs(Ship.PROPERTIES) do
		var_95_1[iter_95_1] = self:getGrowthForAttr(iter_95_1)
		var_95_2[iter_95_1] = var_95_1[iter_95_1]
	end

	for iter_95_2, iter_95_3 in ipairs(self:getConfig("lock")) do
		var_95_2[iter_95_3] = var_95_1[iter_95_3]
	end

	for iter_95_4, iter_95_5 in ipairs(Ship.DIVE_PROPERTIES) do
		var_95_2[iter_95_5] = var_95_0[iter_95_5]
	end

	for iter_95_6, iter_95_7 in ipairs(Ship.SONAR_PROPERTIES) do
		var_95_2[iter_95_7] = 0
	end

	return var_95_2
end

function Ship:getGrowthForAttr(arg_96_1)
	local var_96_0 = self:getConfigTable()
	local var_96_1 = table.indexof(Ship.PROPERTIES, arg_96_1)
	local var_96_2 = var_96_0.attrs[var_96_1] + (self.level - 1) * var_96_0.attrs_growth[var_96_1] / 1000

	if pg.gameset.extra_attr_level_limit.key_value < self.level then
		var_96_2 = var_96_2 + (self.level - pg.gameset.extra_attr_level_limit.key_value) * var_96_0.attrs_growth_extra[var_96_1] / 1000
	end

	return var_96_2
end

function Ship:isMaxStar()
	return self:getStar() >= self:getMaxStar()
end

function Ship:IsMaxStarByTmpID()
	return pg.ship_data_template[self].star >= pg.ship_data_template[self].star_max
end

function Ship:IsSpweaponUnlock()
	if not self:CanAccumulateExp() then
		return false, "spweapon_tip_locked"
	else
		return true
	end

	return
end

function Ship:getModProperties(arg_100_1)
	return self.strengthList[arg_100_1] or 0
end

function Ship:addModAttrExp(arg_101_1, arg_101_2)
	local var_101_0 = self:getModAttrTopLimit(arg_101_1)

	if var_101_0 == 0 then
		return
	end

	local var_101_1 = self:getModExpRatio(arg_101_1)
	local var_101_2 = self:getModProperties(arg_101_1)

	self.strengthList[arg_101_1] = var_101_2 + arg_101_2 > var_101_0 * var_101_1 and var_101_0 * var_101_1 or var_101_2 + arg_101_2

	return
end

function Ship:getNeedModExp()
	local var_102_0 = {}

	for iter_102_0, iter_102_1 in pairs(ShipModAttr.ID_TO_ATTR) do
		local var_102_1 = self:getModAttrTopLimit(iter_102_1)

		var_102_0[iter_102_1] = var_102_1 == 0 and 0 or var_102_1 * self:getModExpRatio(iter_102_1) - self:getModProperties(iter_102_1)
	end

	return var_102_0
end

function Ship:attrVertify()
	if not BayProxy.checkShiplevelVertify(self) then
		return false
	end

	for iter_103_0, iter_103_1 in ipairs(self.equipments) do
		if iter_103_1 and not iter_103_1:vertify() then
			return false
		end
	end

	return true
end

function Ship:getEquipmentProperties()
	local var_104_0 = {}
	local var_104_1 = {}

	for iter_104_0, iter_104_1 in ipairs(Ship.PROPERTIES) do
		var_104_0[iter_104_1] = 0
	end

	for iter_104_2, iter_104_3 in ipairs(Ship.DIVE_PROPERTIES) do
		var_104_0[iter_104_3] = 0
	end

	for iter_104_4, iter_104_5 in ipairs(Ship.SONAR_PROPERTIES) do
		var_104_0[iter_104_5] = 0
	end

	for iter_104_6, iter_104_7 in ipairs(Ship.PROPERTIES_ENHANCEMENT) do
		var_104_1[iter_104_7] = 0
	end

	var_104_0[AttributeType.AirDominate] = 0
	var_104_0[AttributeType.AntiSiren] = 0

	for iter_104_8, iter_104_9 in ipairs((self:getActiveEquipments())) do
		if iter_104_9 then
			for iter_104_10, iter_104_11 in ipairs((iter_104_9:GetAttributes())) do
				if iter_104_11 and var_104_0[iter_104_11.type] then
					var_104_0[iter_104_11.type] = var_104_0[iter_104_11.type] + iter_104_11.value
				end
			end

			for iter_104_12, iter_104_13 in pairs((iter_104_9:GetPropertyRate())) do
				var_104_1[iter_104_12] = math.max(var_104_1[iter_104_12], iter_104_13)
			end

			local var_104_2 = iter_104_9:GetSonarProperty()

			if var_104_2 then
				for iter_104_14, iter_104_15 in pairs(var_104_2) do
					var_104_0[iter_104_14] = var_104_0[iter_104_14] + iter_104_15
				end
			end

			local var_104_3 = iter_104_9:GetAntiSirenPower()

			if var_104_3 then
				var_104_0[AttributeType.AntiSiren] = var_104_0[AttributeType.AntiSiren] + var_104_3 / 16
			end
		end
	end

	;(function()
		local var_105_0 = self:GetSpWeapon()

		if not var_105_0 then
			return
		end

		for iter_105_0, iter_105_1 in ipairs(var_105_0:GetPropertiesInfo().attrs) do
			if iter_105_1 and var_104_0[iter_105_1.type] then
				var_104_0[iter_105_1.type] = var_104_0[iter_105_1.type] + iter_105_1.value
			end
		end

		return
	end)()

	for iter_104_16, iter_104_17 in pairs(var_104_1) do
		var_104_1[iter_104_16] = iter_104_17 + 1
	end

	return var_104_0, var_104_1
end

function Ship:getSkillEffects()
	local var_106_0 = self:getShipSkillEffects()

	_.each(self:getEquipmentSkillEffects(), function(arg_107_0)
		table.insert(var_106_0, arg_107_0)

		return
	end)

	return var_106_0
end

function Ship:getShipSkillEffects()
	local var_108_0 = {}

	for iter_108_0, iter_108_1 in ipairs((self:getSkillList())) do
		self:FilterActiveSkill(var_108_0, pg.buffCfg["buff_" .. self:RemapSkillId(iter_108_1, true)], self.skills[iter_108_1])
	end

	return var_108_0
end

function Ship:getEquipmentSkillEffects()
	local var_109_0 = {}

	for iter_109_0, iter_109_1 in ipairs((self:getActiveEquipments())) do
		local var_109_2 = iter_109_1 and iter_109_1:getConfig("skill_id")[1] and iter_109_1:getConfig("skill_id")[1][1]

		self:FilterActiveSkill(var_109_0, (var_109_2 or nil) and pg.buffCfg["buff_" .. var_109_2])
	end

	;(function()
		local var_110_0 = self:GetSpWeapon()
		local var_110_1 = var_110_0 and var_110_0:GetEffect() or 0

		self:FilterActiveSkill(var_109_0, (var_110_1 > 0 or nil) and pg.buffCfg["buff_" .. var_110_1])

		return
	end)()

	return var_109_0
end

function Ship:FilterActiveSkill(arg_111_1, arg_111_2, arg_111_3)
	if not arg_111_2 or not arg_111_2.const_effect_list then
		return
	end

	for iter_111_0 = 1, #arg_111_2.const_effect_list do
		local var_111_0 = arg_111_2.const_effect_list[iter_111_0].trigger
		local var_111_1 = arg_111_2.const_effect_list[iter_111_0].arg_list
		local var_111_2 = 1

		if arg_111_3 then
			var_111_2 = arg_111_3.level

			if arg_111_2[arg_111_3.level].const_effect_list and arg_111_2[arg_111_3.level].const_effect_list[iter_111_0] then
				var_111_0 = arg_111_2[arg_111_3.level].const_effect_list[iter_111_0].trigger or var_111_0
				var_111_1 = arg_111_2[arg_111_3.level].const_effect_list[iter_111_0].arg_list or var_111_1
			end
		end

		local var_111_3 = true

		for iter_111_1, iter_111_2 in pairs(var_111_0) do
			if self.triggers[iter_111_1] ~= iter_111_2 then
				var_111_3 = false

				break
			end
		end

		if var_111_3 then
			table.insert(arg_111_1, {
				type = arg_111_2.const_effect_list[iter_111_0].type,
				arg_list = var_111_1,
				level = var_111_2
			})
		end
	end

	return
end

function Ship:getEquipmentGearScore()
	local var_112_0 = 0

	for iter_112_0, iter_112_1 in ipairs((self:getActiveEquipments())) do
		if iter_112_1 then
			var_112_0 = var_112_0 + iter_112_1:GetGearScore()
		end
	end

	return var_112_0
end

function Ship:getProperties(arg_113_1, arg_113_2, arg_113_3, arg_113_4)
	local var_113_0 = arg_113_1 or {}
	local var_113_1 = self:getConfig("nationality")
	local var_113_2 = self:getConfig("type")
	local var_113_3 = self:getShipProperties()
	local var_113_4, var_113_5 = self:getEquipmentProperties()
	local var_113_6
	local var_113_7
	local var_113_8

	if arg_113_3 and self:getFlag("inWorld") then
		local var_113_9 = WorldConst.FetchWorldShip(self.id)

		var_113_6, var_113_7 = var_113_9:GetShipBuffProperties()
		var_113_8 = var_113_9:GetShipPowerBuffProperties()
	end

	for iter_113_0, iter_113_1 in ipairs(Ship.PROPERTIES) do
		local var_113_10 = 0
		local var_113_11 = 0

		for iter_113_2, iter_113_3 in pairs(var_113_0) do
			var_113_10 = var_113_10 + iter_113_3:getAttrRatioAddition(iter_113_1, var_113_1, var_113_2) / 100
			var_113_11 = var_113_11 + iter_113_3:getAttrValueAddition(iter_113_1, var_113_1, var_113_2)
		end

		local var_113_12 = var_113_10 + (var_113_5[iter_113_1] or 1)
		local var_113_13

		if var_113_7 then
			var_113_13 = var_113_7[iter_113_1] or 1

			local var_113_14

			if var_113_6 then
				var_113_14 = var_113_6[iter_113_1] or 0

				if iter_113_1 == AttributeType.Speed then
					var_113_3[iter_113_1] = var_113_3[iter_113_1] * var_113_12 * var_113_13 + var_113_11 + var_113_4[iter_113_1] + var_113_14

					goto label_113_0
				end
			end
		end

		var_113_3[iter_113_1] = calcFloor(calcFloor(var_113_3[iter_113_1]) * var_113_12 * var_113_13) + var_113_11 + var_113_4[iter_113_1] + var_113_14

		::label_113_0::
	end

	if not arg_113_2 and self:isMaxStar() then
		for iter_113_4, iter_113_5 in pairs(var_113_3) do
			var_113_3[iter_113_4] = var_113_3[iter_113_4] + (arg_113_4 and self:getTechNationMaxAddition(iter_113_4) or self:getTechNationAddition(iter_113_4))
		end
	end

	for iter_113_6, iter_113_7 in ipairs(Ship.DIVE_PROPERTIES) do
		var_113_3[iter_113_7] = var_113_3[iter_113_7] + var_113_4[iter_113_7]
	end

	for iter_113_8, iter_113_9 in ipairs(Ship.SONAR_PROPERTIES) do
		var_113_3[iter_113_9] = var_113_3[iter_113_9] + var_113_4[iter_113_9]
	end

	if arg_113_3 then
		var_113_3[AttributeType.AntiSiren] = (var_113_3[AttributeType.AntiSiren] or 0) + var_113_4[AttributeType.AntiSiren]
	end

	if var_113_8 then
		for iter_113_10, iter_113_11 in pairs(var_113_8) do
			if var_113_3[iter_113_10] then
				var_113_3[iter_113_10] = iter_113_10 == AttributeType.Speed and var_113_3[iter_113_10] * iter_113_11 or math.floor(var_113_3[iter_113_10] * iter_113_11)
			end
		end
	end

	return var_113_3
end

function Ship:getTransGearScore()
	local var_114_0 = 0

	for iter_114_0, iter_114_1 in pairs(self.transforms) do
		for iter_114_2 = 1, iter_114_1.level do
			var_114_0 = var_114_0 + (pg.transform_data_template[iter_114_1.id].gear_score[iter_114_2] or 0)
		end
	end

	return var_114_0
end

function Ship:getShipCombatPower(arg_115_1)
	local var_115_0 = self:getProperties(arg_115_1, nil, nil, true)

	return math.floor(var_115_0[AttributeType.Durability] / 5 + var_115_0[AttributeType.Cannon] + var_115_0[AttributeType.Torpedo] + var_115_0[AttributeType.AntiAircraft] + var_115_0[AttributeType.Air] + var_115_0[AttributeType.AntiSub] + var_115_0[AttributeType.Reload] + var_115_0[AttributeType.Hit] * 2 + var_115_0[AttributeType.Dodge] * 2 + var_115_0[AttributeType.Speed] + self:getEquipmentGearScore() + self:getTransGearScore())
end

function Ship:cosumeEnergy(arg_116_1)
	self:setEnergy(math.max(self:getEnergy() - arg_116_1, 0))

	return
end

function Ship:addEnergy(arg_117_1)
	self:setEnergy(self:getEnergy() + arg_117_1)

	return
end

function Ship:setEnergy(arg_118_1)
	self.energy = arg_118_1

	return
end

function Ship:setLikability(arg_119_1)
	assert(arg_119_1 >= 0 and arg_119_1 <= self.maxIntimacy, "intimacy value invaild" .. arg_119_1)
	self:setIntimacy(arg_119_1)

	return
end

function Ship:addLikability(arg_120_1)
	self:setIntimacy((Mathf.Clamp(self:getIntimacy() + arg_120_1, 0, self.maxIntimacy)))

	return
end

function Ship:setIntimacy(arg_121_1)
	if arg_121_1 > 10000 and not self.propose then
		arg_121_1 = 10000
	end

	self.intimacy = arg_121_1

	if not self:isActivityNpc() then
		getProxy(CollectionProxy).shipGroups[self.groupId]:updateMaxIntimacy(self:getIntimacy())
	end

	return
end

function Ship:getLevelExpConfig(arg_122_1)
	if self:getConfig("rarity") == ShipRarity.SSR then
		local var_122_0 = Clone(getConfigFromLevel1(var_0_6, arg_122_1 or self.level))

		var_122_0.exp = var_122_0.exp_ur
		var_122_0.exp_start = var_122_0.exp_ur_start
		var_122_0.exp_interval = var_122_0.exp_ur_interval
		var_122_0.exp_end = var_122_0.exp_ur_end

		return var_122_0
	else
		return getConfigFromLevel1(var_0_6, arg_122_1 or self.level)
	end

	return
end

function Ship:getExp()
	if self.level == self:getMaxLevel() and LOCK_FULL_EXP then
		return 0
	end

	return self.exp
end

function Ship:getProficiency()
	return self.proficiency
end

function Ship:addExp(arg_125_1, arg_125_2)
	local var_125_0 = self:getMaxLevel()

	if self.level == var_125_0 then
		if self.exp >= pg.gameset.exp_overflow_max.key_value then
			return
		end

		if LOCK_FULL_EXP or not arg_125_2 or not self:CanAccumulateExp() then
			arg_125_1 = 0
		end
	end

	self.exp = self.exp + arg_125_1

	local var_125_1 = false

	while self:canLevelUp() do
		self.exp = self.exp - self:getLevelExpConfig().exp_interval
		self.level = math.min(self.level + 1, var_125_0)
		var_125_1 = true
	end

	if self.level == var_125_0 then
		if arg_125_2 and self:CanAccumulateExp() then
			self.exp = math.min(self.exp, pg.gameset.exp_overflow_max.key_value)
		elseif var_125_1 then
			self.exp = 0
		end
	end

	return
end

function Ship:getMaxLevel()
	return self.maxLevel
end

function Ship:canLevelUp()
	return self:getLevelExpConfig(self.level + 1) and self:getLevelExpConfig().exp_interval <= self.exp and self:getMaxLevel() > self.level
end

function Ship:getConfigMaxLevel()
	return var_0_6.all[#var_0_6.all]
end

function Ship:isConfigMaxLevel()
	return self.level == self:getConfigMaxLevel()
end

function Ship:updateMaxLevel(arg_130_1)
	self.maxLevel = math.max(math.min(self:getConfigMaxLevel(), arg_130_1), self.maxLevel)

	return
end

function Ship:getNextMaxLevel()
	for iter_131_0 = self:getMaxLevel() + 1, self:getConfigMaxLevel() do
		if var_0_6[iter_131_0].level_limit == 1 then
			return iter_131_0
		end
	end

	return
end

function Ship:canUpgrade()
	if self:isBluePrintShip() then
		return false
	end

	if self:isMetaShip() then
		local var_132_0 = self:getMetaCharacter()

		if not var_132_0 then
			return false
		end

		local var_132_1 = var_132_0:getBreakOutInfo()

		if not var_132_1:hasNextInfo() then
			return false
		end

		local var_132_2, var_132_3 = var_132_1:getLimited()

		if var_132_2 > self.level then
			return false
		end

		return true
	else
		local var_132_4 = var_0_8[self.configId]

		assert(var_0_8[self.configId], "不存在配置" .. self.configId)

		return not self:isMaxStar() and self.level >= var_132_4.level
	end

	return
end

function Ship:isReachNextMaxLevel()
	return self.level == self:getMaxLevel() and self:CanAccumulateExp() and self:getNextMaxLevel() ~= nil
end

function Ship:isAwakening()
	return self:isReachNextMaxLevel() and self.level < var_0_4
end

function Ship:isAwakening2()
	return self:isReachNextMaxLevel() and self.level >= var_0_4
end

function Ship:notMaxLevelForFilter()
	return self.level ~= self:getMaxLevel()
end

function Ship:getNextMaxLevelConsume()
	local var_137_0 = var_0_6[self:getMaxLevel()]["need_item_rarity" .. self:getConfig("rarity")]

	assert(var_137_0, "items  can not be nil")

	return _.map(var_137_0, function(arg_138_0)
		return {
			type = arg_138_0[1],
			id = arg_138_0[2],
			count = arg_138_0[3]
		}
	end)
end

function Ship:canUpgradeMaxLevel()
	if not self:isReachNextMaxLevel() then
		local var_139_1 = i18n("upgrade_to_next_maxlevel_failed")

		return
	else
		local var_139_2 = getProxy(PlayerProxy):getData()
		local var_139_3 = getProxy(BagProxy)

		for iter_139_0, iter_139_1 in pairs((self:getNextMaxLevelConsume())) do
			if iter_139_1.type == DROP_TYPE_RESOURCE then
				if var_139_2:getResById(iter_139_1.id) < iter_139_1.count then
					local var_139_5 = i18n("common_no_resource")

					return
				end
			elseif iter_139_1.type == DROP_TYPE_ITEM and var_139_3:getItemCountById(iter_139_1.id) < iter_139_1.count then
				local var_139_7 = i18n("common_no_item_1")

				return
			end
		end
	end

	return true
end

function Ship:CanAccumulateExp()
	return pg.ship_data_template[self.configId].can_get_proficency == 1
end

function Ship:getTotalExp()
	return self:getLevelExpConfig().exp_start + self.exp
end

function Ship:getStartBattleExpend()
	if table.contains(ShipType.SubShipType, self:getShipType()) then
		return 0
	else
		return pg.ship_data_template[self.configId].oil_at_start
	end

	return
end

function Ship:getEndBattleExpend()
	return (math.floor(pg.ship_data_template[self.configId].oil_at_end * self:getLevelExpConfig().fight_oil_ratio / 16))
end

function Ship:getBattleTotalExpend()
	return self:getStartBattleExpend() + self:getEndBattleExpend()
end

function Ship:getShipAmmo()
	local var_145_0 = self:getConfig(AttributeType.Ammo)

	for iter_145_0, iter_145_1 in pairs(self:getAllSkills()) do
		local var_145_1 = pg.skill_benefit_template[tonumber(iter_145_0 .. string.format("%.2d", iter_145_1.level))]

		if var_145_1 and self:IsBenefitSkillActive(var_145_1) and (var_145_1.type == Ship.BENEFIT_EQUIP or var_145_1.type == Ship.BENEFIT_SKILL) then
			var_145_0 = var_145_0 + defaultValue(var_145_1.effect[1], 0)
		end
	end

	for iter_145_2, iter_145_3 in ipairs((self:getActiveEquipments())) do
		local var_145_2 = iter_145_3 and iter_145_3:getConfig("equip_parameters").ammo

		if var_145_2 then
			var_145_0 = var_145_0 + var_145_2
		end
	end

	return var_145_0
end

function Ship:getHuntingLv()
	local var_146_0 = self:getConfig("huntingrange_level")

	for iter_146_0, iter_146_1 in pairs(self:getAllSkills()) do
		local var_146_1 = pg.skill_benefit_template[tonumber(iter_146_0 .. string.format("%.2d", iter_146_1.level))]

		if var_146_1 and self:IsBenefitSkillActive(var_146_1) and (var_146_1.type == Ship.BENEFIT_EQUIP or var_146_1.type == Ship.BENEFIT_SKILL) then
			var_146_0 = var_146_0 + defaultValue(var_146_1.effect[2], 0)
		end
	end

	for iter_146_2, iter_146_3 in ipairs((self:getActiveEquipments())) do
		local var_146_2 = iter_146_3 and iter_146_3:getConfig("equip_parameters").hunting_lv

		if var_146_2 then
			var_146_0 = var_146_0 + var_146_2
		end
	end

	return (math.min(var_146_0, self:getMaxHuntingLv()))
end

function Ship:getMapAuras()
	local var_147_0 = {}

	for iter_147_0, iter_147_1 in pairs(self:getAllSkills()) do
		local var_147_1 = pg.skill_benefit_template[tonumber(iter_147_0 .. string.format("%.2d", iter_147_1.level))]

		if var_147_1 and self:IsBenefitSkillActive(var_147_1) and var_147_1.type == Ship.BENEFIT_MAP_AURA then
			table.insert(var_147_0, {
				id = var_147_1.effect[1],
				level = iter_147_1.level
			})
		end
	end

	return var_147_0
end

function Ship:getMapAids()
	local var_148_0 = {}

	for iter_148_0, iter_148_1 in pairs(self:getAllSkills()) do
		local var_148_1 = pg.skill_benefit_template[tonumber(iter_148_0 .. string.format("%.2d", iter_148_1.level))]

		if var_148_1 and self:IsBenefitSkillActive(var_148_1) and var_148_1.type == Ship.BENEFIT_AID then
			table.insert(var_148_0, {
				id = var_148_1.effect[1],
				level = iter_148_1.level
			})
		end
	end

	return var_148_0
end

Ship.BENEFIT_SKILL = 2
Ship.BENEFIT_EQUIP = 3
Ship.BENEFIT_MAP_AURA = 4
Ship.BENEFIT_AID = 5

function Ship:IsBenefitSkillActive(arg_149_1)
	local var_149_0 = false

	if arg_149_1.type == Ship.BENEFIT_SKILL then
		if not arg_149_1.limit[1] or arg_149_1.limit[1] == self.triggers.TeamNumbers then
			var_149_0 = true
		end
	elseif arg_149_1.type == Ship.BENEFIT_EQUIP then
		for iter_149_0, iter_149_1 in ipairs((self:getAllEquipments())) do
			if iter_149_1 and table.contains(arg_149_1.limit, iter_149_1:getConfig("id")) then
				var_149_0 = true

				break
			end
		end
	elseif arg_149_1.type == Ship.BENEFIT_MAP_AURA then
		if self.hpRant and self.hpRant > 0 then
			return true
		end
	elseif arg_149_1.type == Ship.BENEFIT_AID and self.hpRant and self.hpRant > 0 then
		return true
	end

	return var_149_0
end

function Ship:getMaxHuntingLv()
	return #self:getConfig("hunting_range")
end

function Ship:getHuntingRange(arg_151_1)
	local var_151_0 = self:getConfig("hunting_range")
	local var_151_1 = Clone(var_151_0[1])

	for iter_151_0 = 2, math.min(arg_151_1 or self:getHuntingLv(), self:getMaxHuntingLv()) do
		_.each(var_151_0[iter_151_0], function(arg_152_0)
			table.insert(var_151_1, {
				arg_152_0[1],
				arg_152_0[2]
			})

			return
		end)
	end

	return var_151_1
end

function Ship:getTriggerSkills()
	local var_153_0 = {}

	_.each(self:getSkillEffects(), function(arg_154_0)
		if arg_154_0.type == "AddBuff" and arg_154_0.arg_list and arg_154_0.arg_list.buff_id then
			var_153_0[arg_154_0.arg_list.buff_id] = {
				id = arg_154_0.arg_list.buff_id,
				level = arg_154_0.level
			}
		end

		return
	end)

	return var_153_0
end

function Ship:GetEquipmentSkills()
	local var_155_0 = {}

	for iter_155_0, iter_155_1 in ipairs((self:getActiveEquipments())) do
		if iter_155_1 and iter_155_1:getConfig("skill_id")[1] then
			local var_155_1, var_155_2 = unpack(iter_155_1:getConfig("skill_id")[1])

			var_155_0[var_155_1] = {
				id = var_155_1,
				level = var_155_2
			}
		end
	end

	;(function()
		local var_156_0 = self:GetSpWeapon()
		local var_156_1 = var_156_0 and var_156_0:GetEffect() or 0

		if var_156_1 > 0 then
			var_155_0[var_156_1] = {
				level = 1,
				id = var_156_1
			}
		end

		return
	end)()

	return var_155_0
end

function Ship:getAllSkills()
	local var_157_0 = Clone(self.skills)

	for iter_157_0, iter_157_1 in pairs(self:GetEquipmentSkills()) do
		var_157_0[iter_157_0] = iter_157_1
	end

	for iter_157_2, iter_157_3 in pairs(self:getTriggerSkills()) do
		var_157_0[iter_157_2] = iter_157_3
	end

	return var_157_0
end

function Ship:isSameKind(arg_158_1)
	return pg.ship_data_template[self.configId].group_type == pg.ship_data_template[arg_158_1.configId].group_type
end

function Ship:GetLockState()
	return self.lockState
end

function Ship:IsLocked()
	return self.lockState == Ship.LOCK_STATE_LOCK
end

function Ship:SetLockState(arg_161_1)
	self.lockState = arg_161_1

	return
end

function Ship:GetPreferenceTag()
	return self.preferenceTag or 0
end

function Ship:IsPreferenceTag()
	return self:GetPreferenceTag() == Ship.PREFERENCE_TAG_COMMON
end

function Ship:SetPreferenceTag(arg_164_1)
	self.preferenceTag = arg_164_1

	return
end

function Ship:calReturnRes()
	return pg.ship_data_by_type[self:getShipType()].distory_resource_gold_ratio, 0, pg.ship_data_by_star[self:getConfig("rarity")].destory_item
end

function Ship:getRarity()
	local var_166_0 = self:getConfig("rarity")

	if self:isRemoulded() then
		var_166_0 = var_166_0 + 1
	end

	return var_166_0
end

function Ship:updateSkill(arg_167_1)
	local var_167_0 = arg_167_1.skill_id or arg_167_1.id
	local var_167_1 = arg_167_1.skill_lv or arg_167_1.lv or arg_167_1.level
	local var_167_2 = arg_167_1.skill_exp or arg_167_1.exp

	self.skills[var_167_0] = {
		id = var_167_0,
		level = var_167_1,
		exp = var_167_2
	}

	return
end

function Ship:canEquipAtPos(arg_168_1, arg_168_2)
	local var_168_0, var_168_1 = self:isForbiddenAtPos(arg_168_1, arg_168_2)

	if var_168_0 then
		return false, var_168_1
	end

	for iter_168_0, iter_168_1 in ipairs(self.equipments) do
		if iter_168_1 and iter_168_0 ~= arg_168_2 and iter_168_1:getConfig("equip_limit") ~= 0 and arg_168_1:getConfig("equip_limit") == iter_168_1:getConfig("equip_limit") then
			local var_168_3 = i18n("ship_equip_same_group_equipment")

			return
		end
	end

	return true
end

function Ship:isForbiddenAtPos(arg_169_1, arg_169_2)
	assert(pg.ship_data_template[self.configId], "can not find ship in ship_data_templtae: " .. self.configId)

	if not table.contains(pg.ship_data_template[self.configId]["equip_" .. arg_169_2], arg_169_1:getConfig("type")) then
		local var_169_1 = i18n("common_limit_equip")

		return
	end

	if table.contains(arg_169_1:getConfig("ship_type_forbidden"), self:getShipType()) then
		local var_169_3 = i18n("common_limit_equip")

		return
	end

	return false
end

function Ship:canEquipCommander(arg_170_1)
	if arg_170_1:getShipType() ~= self:getShipType() then
		local var_170_1 = i18n("commander_type_unmatch")

		return
	end

	return true
end

function Ship:upgrade()
	if pg.ship_data_transform[self.configId].trans_id and pg.ship_data_transform[self.configId].trans_id > 0 then
		self.configId = pg.ship_data_transform[self.configId].trans_id
		self.star = self:getConfig("star")
	end

	return
end

function Ship:getTeamType()
	return ShipType.GetTeamFromShipType(self:getShipType())
end

function Ship:getFleetName()
	return var_0_1[self:getTeamType()]
end

function Ship:getMaxConfigId()
	local var_174_0

	for iter_174_0 = 4, 1, -1 do
		local var_174_1 = tonumber(self.groupId .. iter_174_0)

		if pg.ship_data_template[var_174_1] then
			var_174_0 = var_174_1

			break
		end
	end

	return var_174_0
end

function Ship:getFlag(arg_175_1, arg_175_2)
	return pg.ShipFlagMgr.GetInstance():GetShipFlag(self.id, arg_175_1, arg_175_2)
end

function Ship:hasAnyFlag(arg_176_1)
	return _.any(arg_176_1, function(arg_177_0)
		return self:getFlag(arg_177_0)
	end)
end

function Ship:isBreakOut()
	return self.configId % 10 > 1
end

function Ship:fateSkillChange(arg_179_1)
	if not self.skillChangeList then
		if self:isBluePrintShip() then
			self.skillChangeList = self:getBluePrint():getChangeSkillList() or {}
		end
	end

	for iter_179_0, iter_179_1 in ipairs(self.skillChangeList) do
		if iter_179_1[1] == arg_179_1 and self.skills[iter_179_1[2]] then
			return iter_179_1[2]
		end
	end

	return arg_179_1
end

function Ship:RemapSkillId(arg_180_1, arg_180_2)
	local var_180_0 = self:GetSpWeapon()

	if var_180_0 then
		if table.contains(pg.ship_data_template[self.configId].hide_buff_list, arg_180_1) then
			return var_180_0:RemapHiddenSkillId(arg_180_1)
		elseif arg_180_2 then
			local var_180_1 = var_180_0:RemapHiddenSkillId(arg_180_1)

			if var_180_1 == arg_180_1 then
				var_180_1 = var_180_0:RemapSkillId(arg_180_1)
			end

			return var_180_1
		else
			return var_180_0:RemapSkillId(arg_180_1)
		end
	end

	return arg_180_1
end

function Ship:getSkillList()
	local var_181_0 = Clone(pg.ship_data_template[self.configId].buff_list)

	if pg.ship_data_trans[self.groupId] and pg.ship_data_trans[self.groupId].skill_id ~= 0 then
		if self.transforms[pg.ship_data_trans[self.groupId].skill_id] and pg.transform_data_template[pg.ship_data_trans[self.groupId].skill_id].skill_id ~= 0 then
			table.insert(var_181_0, pg.transform_data_template[pg.ship_data_trans[self.groupId].skill_id].skill_id)
		end
	end

	local var_181_2 = {}

	for iter_181_0, iter_181_1 in ipairs((Clone(pg.ship_data_template[self.configId].buff_list_display))) do
		for iter_181_2, iter_181_3 in ipairs(var_181_0) do
			if iter_181_1 == iter_181_3 then
				table.insert(var_181_2, self:fateSkillChange(iter_181_1))
			end
		end
	end

	return var_181_2
end

function Ship:getModAttrTopLimit(arg_182_1)
	return calcFloor((3 + 7 * (math.min(self.level, 100) / 100)) * pg.ship_data_strengthen[pg.ship_data_template[self.configId].strengthen_id].durability[ShipModAttr.ATTR_TO_INDEX[arg_182_1]] * 0.1)
end

function Ship:leftModAdditionPoint(arg_183_1)
	return math.max(0, self:getModAttrTopLimit(arg_183_1) - calcFloor(self:getModProperties(arg_183_1) / self:getModExpRatio(arg_183_1)))
end

function Ship:getModAttrBaseMax(arg_184_1)
	if not table.contains(self:getConfig("lock"), arg_184_1) then
		return calcFloor(self:getShipProperties()[arg_184_1] + self:leftModAdditionPoint(arg_184_1))
	else
		return 0
	end

	return
end

function Ship:getModExpRatio(arg_185_1)
	if not table.contains(self:getConfig("lock"), arg_185_1) then
		assert(pg.ship_data_strengthen[pg.ship_data_template[self.configId].strengthen_id], "ship_data_strengthen>>>>>>" .. pg.ship_data_template[self.configId].strengthen_id)

		return math.max(pg.ship_data_strengthen[pg.ship_data_template[self.configId].strengthen_id].level_exp[ShipModAttr.ATTR_TO_INDEX[arg_185_1]], 1)
	else
		return 1
	end

	return
end

function Ship:inUnlockTip()
	return table.contains(pg.gameset.tip_unlock_shipIds.description[0], self)
end

function Ship:proposeSkinOwned(arg_187_1)
	local var_187_0

	if arg_187_1 then
		::label_187_0::

		var_187_0 = self.propose and arg_187_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE
	end

	return var_187_0
end

function Ship:getProposeSkin()
	return ShipSkin.GetSkinByType(self.groupId, ShipSkin.SKIN_TYPE_PROPOSE)
end

function Ship:getDisplaySkillIds()
	return _.map(pg.ship_data_template[self.configId].buff_list_display, function(arg_190_0)
		return self:fateSkillChange(arg_190_0)
	end)
end

function Ship:isFullSkillLevel()
	for iter_191_0, iter_191_1 in pairs(self.skills) do
		if pg.skill_data_template[iter_191_1.id].max_level ~= iter_191_1.level then
			return false
		end
	end

	return true
end

function Ship:setEquipmentRecord(arg_192_1, arg_192_2)
	PlayerPrefs.SetString("equipment_record" .. "_" .. arg_192_1 .. "_" .. self.id, table.concat(_.flatten(arg_192_2), ":"))
	PlayerPrefs.Save()

	return
end

function Ship:getEquipmentRecord(arg_193_1)
	if not self.equipmentRecords then
		local var_193_0 = string.split(PlayerPrefs.GetString("equipment_record" .. "_" .. arg_193_1 .. "_" .. self.id) or "", ":")
		local var_193_1 = {}

		for iter_193_0 = 1, 3 do
			var_193_1[iter_193_0] = _.map(_.slice(var_193_0, 5 * iter_193_0 - 4, 5), function(arg_194_0)
				return tonumber(arg_194_0)
			end)
		end

		self.equipmentRecords = var_193_1
	end

	return self.equipmentRecords
end

function Ship:SetSpWeaponRecord(arg_195_1, arg_195_2)
	PlayerPrefs.SetString("spweapon_record" .. "_" .. arg_195_1 .. "_" .. self.id, table.concat(_.map({
		1,
		2,
		3
	}, function(arg_196_0)
		if arg_195_2[arg_196_0] then
			return (arg_195_2[arg_196_0]:GetUID() or 0) .. "," .. arg_195_2[arg_196_0]:GetConfigID()
		else
			return "0,0"
		end

		return
	end), ":"))
	PlayerPrefs.Save()

	return
end

function Ship:GetSpWeaponRecord(arg_197_1)
	return (_.map(string.split(PlayerPrefs.GetString("spweapon_record" .. "_" .. arg_197_1 .. "_" .. self.id, ""), ":"), function(arg_198_0)
		local var_198_0 = string.split(arg_198_0, ",")

		assert(var_198_0)

		local var_198_1 = tonumber(var_198_0[1])
		local var_198_2 = tonumber(var_198_0[2])

		if not var_198_2 or var_198_2 == 0 then
			return false
		end

		return (SpWeapon.New({
			id = var_198_2
		}))
	end))
end

function Ship:hasEquipEquipmentSkin()
	for iter_199_0, iter_199_1 in ipairs(self.equipments) do
		if iter_199_1 and iter_199_1:hasSkin() then
			return true
		end
	end

	return false
end

function Ship:hasCommander()
	return self.commanderId and self.commanderId ~= 0
end

function Ship:getCommander()
	return self.commanderId
end

function Ship:setCommander(arg_202_1)
	self.commanderId = arg_202_1

	return
end

function Ship:getSkillIndex(arg_203_1)
	for iter_203_0, iter_203_1 in ipairs((self:getSkillList())) do
		if arg_203_1 == iter_203_1 then
			return iter_203_0
		end
	end

	return
end

function Ship:getTactics()
	return 1, "tactics_attack"
end

function Ship:IsBgmSkin()
	return table.contains(self:GetSkinConfig().tag, ShipSkin.WITH_BGM)
end

function Ship:GetSkinBgm()
	if self:IsBgmSkin() then
		return self:GetSkinConfig().bgm
	end

	return
end

function Ship:isIntensifyMax()
	local var_207_0 = intProperties(self:getShipProperties())

	if self:isBluePrintShip() then
		return true
	end

	for iter_207_0, iter_207_1 in pairs(ShipModAttr.ID_TO_ATTR) do
		if self:getModAttrBaseMax(iter_207_1) ~= var_207_0[iter_207_1] then
			return false
		end
	end

	return true
end

function Ship:isRemouldable()
	return not self:isTestShip() and not self:isBluePrintShip() and pg.ship_data_trans[self.groupId]
end

function Ship:isAllRemouldFinish()
	assert(pg.ship_data_trans[self.groupId], "this ship group without remould config:" .. self.groupId)

	for iter_209_0, iter_209_1 in ipairs(pg.ship_data_trans[self.groupId].transform_list) do
		for iter_209_2, iter_209_3 in ipairs(iter_209_1) do
			if #pg.transform_data_template[iter_209_3[2]].edit_trans > 0 then
				-- block empty
			elseif not self.transforms[iter_209_3[2]] or self.transforms[iter_209_3[2]].level < pg.transform_data_template[iter_209_3[2]].max_level then
				return false
			end
		end
	end

	return true
end

function Ship:isSpecialFilter()
	assert(pg.ship_data_statistics[self.configId], "this ship without statistics:" .. self.configId)

	for iter_210_0, iter_210_1 in ipairs(pg.ship_data_statistics[self.configId].tag_list) do
		if iter_210_1 == "special" then
			return true
		end
	end

	return false
end

function Ship:hasAvailiableSkin()
	local var_211_0 = getProxy(ShipSkinProxy)
	local var_211_1 = var_211_0:getRawData()
	local var_211_2 = 0

	for iter_211_0, iter_211_1 in ipairs((var_211_0:GetAllSkinForShip(self))) do
		if self:proposeSkinOwned(iter_211_1) or var_211_1[iter_211_1.id] or var_211_0:hasSkin(iter_211_1.id) then
			var_211_2 = var_211_2 + 1
		end
	end

	return var_211_2 > 0
end

function Ship:hasProposeSkin()
	local var_212_0 = getProxy(ShipSkinProxy)

	for iter_212_0, iter_212_1 in ipairs((var_212_0:GetAllSkinForShip(self))) do
		if iter_212_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
			return true
		end
	end

	for iter_212_2, iter_212_3 in ipairs((var_212_0:GetShareSkinsForShip(self))) do
		if iter_212_3.skin_type == ShipSkin.SKIN_TYPE_PROPOSE then
			return true
		end
	end

	return false
end

function Ship:HasUniqueSpWeapon()
	return tobool(pg.spweapon_data_statistics.get_id_list_by_unique[self:getGroupId()])
end

function Ship:getAircraftReloadCD()
	local var_214_0 = self:getConfigTable().base_list
	local var_214_1 = self:getConfigTable().default_equip_list
	local var_214_2 = 0
	local var_214_3 = 0

	for iter_214_0 = 1, 3 do
		local var_214_4 = self:getEquip(iter_214_0)
		local var_214_5

		if var_214_4 then
			var_214_5 = var_214_4.configId or var_214_1[iter_214_0]
		end

		local var_214_6 = Equipment.getConfigData(var_214_5).type

		if underscore.any(EquipType.AirEquipTypes, function(arg_215_0)
			return var_214_6 == arg_215_0
		end) then
			var_214_2 = var_214_2 + Equipment.GetEquipReloadStatic(var_214_5) * var_214_0[iter_214_0]
			var_214_3 = var_214_3 + var_214_0[iter_214_0]
		end
	end

	return {
		name = i18n("equip_info_31"),
		type = AttributeType.CD,
		value = var_214_2 / var_214_3 * (ys.Battle.BattleConfig.AIR_ASSIST_RELOAD_RATIO * pg.bfConsts.PERCENT)
	}
end

function Ship:IsTagShip(arg_216_1)
	return table.contains(self:getConfig("tag_list"), arg_216_1)
end

function Ship:setReMetaSpecialItemVO(arg_217_1)
	self.reMetaSpecialItemVO = arg_217_1

	return
end

function Ship:getReMetaSpecialItemVO(arg_218_1)
	return self.reMetaSpecialItemVO
end

function Ship:getProposeType()
	if self:isMetaShip() then
		return "meta"
	elseif self:IsXIdol() then
		return "imas"
	else
		return "default"
	end

	return
end

function Ship:IsXIdol()
	return self:getNation() == Nation.IDOL_LINK
end

function Ship:getSpecificType()
	return pg.ship_data_template[self.configId].specific_type
end

function Ship:GetSpWeapon()
	return self.spWeapon
end

function Ship:UpdateSpWeapon(arg_223_1)
	local var_223_1 = (arg_223_1 and arg_223_1:GetUID() or 0) == (self.spWeapon and self.spWeapon:GetUID() or 0)

	self.spWeapon = arg_223_1

	if arg_223_1 then
		arg_223_1:SetShipId(self.id)
	end

	if var_223_1 then
		pg.m02:sendNotification(EquipmentProxy.SPWEAPONS_UPDATED)
	end

	return
end

function Ship:CanEquipSpWeapon(arg_224_1)
	local var_224_0, var_224_1 = self:IsSpWeaponForbidden(arg_224_1)

	if var_224_0 then
		return false, var_224_1
	end

	return true
end

function Ship:IsSpWeaponForbidden(arg_225_1)
	if not table.contains(arg_225_1:GetWearableShipTypes(), (self:getShipType())) then
		local var_225_1 = i18n("spweapon_tip_group_error")

		return
	end

	local var_225_2 = arg_225_1:GetUniqueGroup()

	if var_225_2 ~= 0 and var_225_2 ~= self:getGroupId() then
		local var_225_4 = i18n("spweapon_tip_group_error")

		return
	end

	return false
end

function Ship:GetMapStrikeAnim()
	local var_226_0
	local var_226_1 = self:getShipType()

	switch(ShipType.GetTeamFromShipType(var_226_1), {
		[TeamType.Main] = function()
			var_226_0 = ShipType.IsTypeQuZhu(var_226_1) and "SubTorpedoUI" or ShipType.ContainInLimitBundle(ShipType.BundleAircraftCarrier, var_226_1) and "AirStrikeUI" or ShipType.ContainInLimitBundle(ShipType.BundleBattleShip, var_226_1) and "CannonUI" or "CannonUI"

			return
		end,
		[TeamType.Vanguard] = function()
			if ShipType.IsTypeQuZhu(var_226_1) then
				var_226_0 = "SubTorpedoUI"
			end

			return
		end,
		[TeamType.Submarine] = function()
			var_226_0 = self:getNation() == Nation.MOT and "CannonUI" or "SubTorpedoUI"

			return
		end
	})

	return nil
end

function Ship:IsDefaultSkin()
	local var_230_0 = self:getSkinId()

	return var_230_0 == 0 or var_230_0 == self:getConfig("skin_id")
end

function Ship:IsMatchKey(arg_231_1)
	if not arg_231_1 or arg_231_1 == "" then
		return true
	end

	arg_231_1 = string.lower(string.gsub(arg_231_1, "%.", "%%."))

	return underscore.any({
		pg._ship_data_statistics[self.configId].name,
		self:GetDefaultName(),
		(self:getName())
	}, function(arg_232_0)
		return string.find(string.lower(arg_232_0), arg_231_1)
	end)
end

function Ship:IsOwner()
	return tobool(self.id)
end

function Ship:GetUniqueId()
	return self.id
end

function Ship:ShowPropose()
	if not self.propose then
		return false
	else
		local var_235_0

		if HXSet.isHxPropose() then
			var_235_0 = self:IsOwner()

			if var_235_0 then
				var_235_0 = self:GetUniqueId() == getProxy(PlayerProxy):getRawData():GetProposeShipId()
			end
		end

		return var_235_0
	end

	return
end

function Ship:GetColorName(arg_236_1)
	arg_236_1 = arg_236_1 or self:getName()

	if PlayerPrefs.GetInt("SHIP_NAME_COLOR", PLATFORM_CODE == PLATFORM_CH and 1 or 0) == 1 and self.propose then
		return setColorStr(arg_236_1, "#FFAACEFF")
	else
		return arg_236_1
	end

	return
end

local var_0_9 = {
	effect = {
		"duang_meta_jiehun",
		"duang_6_jiehun_tuzhi",
		"duang_6_jiehun",
		"duang_meta_%s",
		"duang_6"
	},
	frame = {
		"prop4_1",
		"prop%s",
		"prop"
	}
}

function Ship:GetFrameAndEffect(arg_237_1)
	arg_237_1 = tobool(arg_237_1)

	local var_237_0
	local var_237_1

	if self.propose then
		if self:isMetaShip() then
			var_237_1 = string.format(var_0_9.effect[1])
			var_237_0 = string.format(var_0_9.frame[1])
		elseif self:isBluePrintShip() then
			var_237_1 = string.format(var_0_9.effect[2])
			var_237_0 = string.format(var_0_9.frame[2], self:rarity2bgPrint())
		else
			var_237_1 = string.format(var_0_9.effect[3])
			var_237_0 = string.format(var_0_9.frame[3])
		end

		if not self:ShowPropose() then
			var_237_0 = nil
		end
	elseif self:isMetaShip() then
		var_237_1 = string.format(var_0_9.effect[4], self:rarity2bgPrint())
	elseif self:getRarity() == ShipRarity.SSR then
		var_237_1 = string.format(var_0_9.effect[5])
	end

	if arg_237_1 then
		var_237_1 = var_237_1 and var_237_1 .. "_1"
	end

	return var_237_0, var_237_1
end

function Ship:GetRecordPosKey()
	return self:getSkinId()
end

function Ship:GetShipPhantomMark(arg_239_1)
	return ShipPhantom.PackMark(self.id, arg_239_1)
end

function Ship:GetSelectMark()
	return self.id
end

return Ship
