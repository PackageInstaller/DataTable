local Equipment = class("Equipment", import(".BaseVO"))

Equipment.EQUIPMENT_STATE_LOCK = 1
Equipment.EQUIPMENT_STATE_EMPTY = 0
Equipment.EQUIPMENT_NORMAL = 1
Equipment.EQUIPMENT_IMPORTANCE = 2

local var_0_1 = pg.equip_skin_template

function Equipment:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.config_id or self.id

	self:InitConfig()

	self.count = defaultValue(arg_1_1.count, 0)
	self.new = defaultValue(arg_1_1.new, 0)
	self.isSkin = defaultValue(arg_1_1.isSkin, false)
	self.skinId = arg_1_1.skinId or 0

	return
end

function Equipment:getConfigData()
	local var_2_0 = {
		pg.equip_data_statistics,
		pg.equip_data_template
	}
	local var_2_1

	if underscore.any(var_2_0, function(arg_3_0)
		return arg_3_0[self] ~= nil
	end) then
		var_2_1 = setmetatable({}, {
			__index = function(self, arg_4_1)
				for iter_4_0, iter_4_1 in ipairs(var_2_0) do
					if iter_4_1[self] and iter_4_1[self][arg_4_1] ~= nil then
						self[arg_4_1] = iter_4_1[self][arg_4_1]

						return self[arg_4_1]
					end
				end

				return
			end
		})

		if var_2_1.weapon_id and #var_2_1.weapon_id > 0 then
			var_2_1[AttributeType.CD] = pg.weapon_property[var_2_1.weapon_id[1]] and pg.weapon_property[var_2_1.weapon_id[1]].reload_max
		end
	end

	return var_2_1
end

function Equipment:InitConfig()
	self.cfg = Equipment.getConfigData(self.configId)

	if not IsUnityEditor then
		self.config = self.cfg
	end

	assert(self.cfg, string.format("without equip config from id_%d", self.id))

	return
end

function Equipment:getConfigTable()
	return self.cfg
end

function Equipment:GetAttributes()
	local var_7_0 = {}

	for iter_7_0 = 1, 3 do
		local var_7_1 = self:getConfig("attribute_" .. iter_7_0)
		local var_7_2 = self:getConfig("value_" .. iter_7_0)
		local var_7_3

		if var_7_1 ~= nil then
			var_7_3 = {
				type = var_7_1
			}
			var_7_3.value = string.match(var_7_2, "^[%d|\\.]+$") and tonumber(var_7_2) or var_7_2
			var_7_3.auxBoost = self:isDevice()
			var_7_3 = var_7_3 or false
		end

		var_7_0[iter_7_0] = var_7_3
	end

	return var_7_0
end

function Equipment:GetPropertyRate()
	return self:getConfig("property_rate")
end

function Equipment:CanInBag()
	return tobool(pg.equip_data_template[self])
end

function Equipment:vertify()
	if self:getConfig("value_1") ~= pg.equip_data_statistics[self.configId].value_1 or self:getConfig("value_2") ~= pg.equip_data_statistics[self.configId].value_2 then
		return false
	end

	return true
end

function Equipment:CalcWeanponCD(arg_11_1)
	return string.format("%0.2f", ys.Battle.BattleFormulas.CalculateReloadTime(self or 0, arg_11_1 and arg_11_1:getProperties().reload or 100))
end

local var_0_2 = {
	equip_info_34 = "equip_info_33",
	attribute_cd = "cd_normal"
}
local var_0_3

local function var_0_4(arg_12_0)
	if not var_0_3 then
		var_0_3 = {}

		for iter_12_0, iter_12_1 in pairs(var_0_2) do
			var_0_3[i18n(iter_12_0)] = i18n(iter_12_1)
		end
	end

	return var_0_3[arg_12_0]
end

function Equipment:GetInfoTrans(arg_13_1)
	local var_13_0 = self.name
	local var_13_1 = self.value
	local var_13_2 = self.auxBoost

	if self.type == AttributeType.CD then
		var_13_1 = Equipment.CalcWeanponCD(var_13_1, arg_13_1) .. "s" .. pg.equip_data_code.WAVE.text
	elseif self.type == AttributeType.AirDurability then
		var_13_1 = math.floor(var_13_1[1] + var_13_1[2] * (((arg_13_1 or nil) and (arg_13_1.level or 100)) - 1) / 1000)
	elseif self.type == AttributeType.AntiSiren then
		var_13_1 = math.floor(var_13_1 / 100)
		var_13_1 = (var_13_1 > 0 and "+" or var_13_1 < 0 and "-" or "") .. var_13_1 .. "%"
	end

	var_13_0 = var_13_0 or AttributeType.Type2Name(self.type)

	if not arg_13_1 then
		var_13_0 = defaultValue(var_0_4(var_13_0), var_13_0)
	end

	var_13_1 = var_13_1 or ""
	var_13_2 = var_13_2 and arg_13_1 and table.contains(arg_13_1:getSpecificType(), ShipType.SpecificTypeTable.auxiliary)

	return var_13_0, var_13_1, var_13_2
end

local function var_0_5(arg_14_0)
	if string.match(arg_14_0, pg.equip_data_code.WAVE.text) then
		arg_14_0 = string.gsub(arg_14_0, pg.equip_data_code.WAVE.text, "")
	end

	arg_14_0 = string.gsub(arg_14_0, " ", "")

	local var_14_0 = {
		string.match(arg_14_0, "~(%d+)")
	}

	if #var_14_0 > 0 then
		arg_14_0 = string.gsub(arg_14_0, "~" .. var_14_0[1], "")
	end

	local var_14_1 = {
		string.match(arg_14_0, "(%d+)x(%d+)")
	}

	while #var_14_1 > 0 do
		arg_14_0 = string.gsub(arg_14_0, var_14_1[1] .. "x" .. var_14_1[2], var_14_1[1] * var_14_1[2], 1)
		var_14_1 = {
			string.match(arg_14_0, "(%d+)x(%d+)")
		}
	end

	return tonumber(arg_14_0)
end

function Equipment:AlignAttrs(arg_15_1)
	for iter_15_0 = 1, #self do
		if not arg_15_1[iter_15_0] or self[iter_15_0].type ~= arg_15_1[iter_15_0].type then
			table.insert(arg_15_1, iter_15_0, Clone(self[iter_15_0]))

			arg_15_1[iter_15_0].value = 0

			for iter_15_1 = iter_15_0 + 1, #arg_15_1 do
				if arg_15_1[iter_15_0].type == arg_15_1[iter_15_1].type then
					arg_15_1[iter_15_0].value = arg_15_1[iter_15_1].value

					table.remove(arg_15_1, iter_15_1)

					break
				end
			end
		end
	end

	for iter_15_2 = #self + 1, #arg_15_1 do
		table.insert(self, Clone(arg_15_1[iter_15_2]))

		self[iter_15_2].value = 0
	end

	return
end

function Equipment:CompareInfo(arg_16_1, arg_16_2)
	arg_16_1.compare = self.type == AttributeType.Damage and var_0_5(arg_16_1.value) - var_0_5(self.value) or self.type == AttributeType.CD and -(Equipment.CalcWeanponCD(arg_16_1.value, arg_16_2) - Equipment.CalcWeanponCD(self.value, arg_16_2)) or arg_16_1.value - self.value

	return
end

function Equipment:InsertAttrsUpgrade(arg_17_1, arg_17_2)
	Equipment.AlignAttrs(self, arg_17_1)

	for iter_17_0 = #self, 1, -1 do
		if self[iter_17_0].value == arg_17_1[iter_17_0].value then
			if not arg_17_2 then
				table.remove(self, iter_17_0)
				table.remove(arg_17_1, iter_17_0)
			end
		else
			self[iter_17_0].nextValue = arg_17_1[iter_17_0].value
		end
	end

	return
end

function Equipment:InsertAttrsCompare(arg_18_1, arg_18_2)
	Equipment.AlignAttrs(self, arg_18_1)

	for iter_18_0 = 1, #self do
		Equipment.CompareInfo(self[iter_18_0], arg_18_1[iter_18_0], arg_18_2)
	end

	return
end

function Equipment:GetPropertiesInfo()
	local var_19_0 = {
		attrs = {}
	}

	if self:getConfig(AttributeType.Damage) then
		table.insert(var_19_0.attrs, {
			type = AttributeType.Damage,
			value = self:getConfig(AttributeType.Damage)
		})
	end

	if self:getConfig(AttributeType.CD) then
		local var_19_1 = {
			type = AttributeType.CD,
			value = self:getConfig(AttributeType.CD)
		}

		table.insert(var_19_0.attrs, var_19_1)

		if self:isAircraftExtend() and self:getConfig("weapon_id") then
			var_19_1.sub = {}

			for iter_19_0, iter_19_1 in ipairs(self:getConfig("weapon_id")) do
				if pg.weapon_property[iter_19_1].type == 11 then
					table.insert(var_19_1.sub, {
						name = i18n("equip_info_34"),
						type = AttributeType.CD,
						value = pg.weapon_property[iter_19_1].reload_max
					})
				end
			end
		end
	end

	for iter_19_2, iter_19_3 in ipairs(self:GetAttributes()) do
		if iter_19_3 and iter_19_3.type ~= AttributeType.OxyRaidDistance then
			table.insert(var_19_0.attrs, iter_19_3)
		end
	end

	if self:GetAntiSirenPower() then
		table.insert(var_19_0.attrs, {
			type = AttributeType.AntiSiren,
			value = self:GetAntiSirenPower()
		})
	end

	local var_19_2 = self:GetSonarProperty()

	if var_19_2 then
		table.insert(var_19_0.attrs, {
			type = AttributeType.SonarRange,
			value = var_19_2[AttributeType.SonarRange]
		})
	end

	var_19_0.weapon = {
		lock_open = true,
		name = i18n(self:isAircraftExtend() and "equip_info_24" or "equip_info_5"),
		sub = {}
	}

	for iter_19_4, iter_19_5 in ipairs(self:getConfig("ammo_info")) do
		table.insert(var_19_0.weapon.sub, self:GetWeaponPageInfo(iter_19_5[1], iter_19_5[2]))
	end

	var_19_0.equipInfo = {
		name = i18n("equip_info_14"),
		sub = {}
	}

	for iter_19_6, iter_19_7 in ipairs(self:getConfig("equip_info")) do
		table.insert(var_19_0.equipInfo.sub, self:GetEquipAttrPageInfo(iter_19_7))
	end

	var_19_0.part = {
		self:getConfig("part_main"),
		self:getConfig("part_sub")
	}
	var_19_0.equipmentType = self:getConfig("type")

	return var_19_0
end

function Equipment:GetWeaponPageInfo(arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1 = pg.equip_bullet_type[arg_20_1].exhibition_type == 2

	for iter_20_0, iter_20_1 in ipairs(pg.equip_bullet_type[arg_20_1].exhibition_list) do
		if not var_20_0 then
			var_20_0 = self:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1)
			var_20_0.sub = {}
		else
			table.insert(var_20_0.sub, self:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1))
		end
	end

	return var_20_0
end

function Equipment:GetWeaponInfo(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3 then
		local var_21_0 = pg.weapon_property[arg_21_2].bullet_ID[1] or arg_21_2
	end

	return switch(arg_21_1, {
		function()
			return {
				name = i18n("equip_ammo_type_" .. self:getConfig(AttributeType.Ammo))
			}
		end,
		function()
			return {
				name = pg.weapon_name[arg_21_2].name
			}
		end,
		function()
			return {
				type = AttributeType.Damage,
				value = pg.weapon_property[arg_21_2].damage
			}
		end,
		function()
			return {
				name = i18n("equip_info_6"),
				value = pg.bullet_template[var_21_0].velocity
			}
		end,
		function()
			return {
				name = i18n("equip_info_7"),
				value = pg.bullet_template[var_21_0].velocity
			}
		end,
		function()
			return {
				name = i18n("equip_info_8"),
				value = pg.bullet_template[var_21_0].damage_type[1] * 100 .. "-" .. pg.bullet_template[var_21_0].damage_type[2] * 100 .. "-" .. pg.bullet_template[var_21_0].damage_type[3] * 100
			}
		end,
		function()
			return {
				name = i18n("equip_info_9"),
				value = pg.bullet_template[var_21_0].hit_type.range
			}
		end,
		function()
			return {
				name = i18n("equip_info_10"),
				value = pg.weapon_property[arg_21_2].range
			}
		end,
		function()
			return {
				name = i18n("equip_info_11"),
				value = pg.weapon_property[arg_21_2].angle
			}
		end,
		function()
			local var_31_0 = {
				name = i18n("equip_info_12")
			}

			var_31_0.value = (pg.bullet_template[var_21_0].extra_param.randomOffsetX or "0") .. "*" .. (pg.bullet_template[var_21_0].extra_param.randomOffsetZ or "0")

			return var_31_0
		end,
		function()
			return {
				name = i18n("equip_info_13"),
				value = self:getConfig(AttributeType.Speciality)
			}
		end,
		function()
			return {
				type = AttributeType.CD,
				value = pg.weapon_property[arg_21_2].reload_max
			}
		end,
		function()
			return {
				name = i18n("attribute_max_distance_damage"),
				value = (1 - pg.bullet_template[var_21_0].hit_type.decay) * 100 .. "%"
			}
		end
	})
end

local var_0_6 = {
	true,
	true,
	true,
	13,
	true,
	[nil] = nil
}

function Equipment:GetEquipAttrPageInfo(arg_35_1)
	local var_35_0
	local var_35_1

	if type(arg_35_1) == "table" then
		var_35_1 = arg_35_1[2]
		var_35_0 = arg_35_1[1]
	else
		var_35_1 = self:getConfig("weapon_id")[1]
		var_35_0 = arg_35_1
	end

	assert(tobool(var_0_6[var_35_0]) == (type(arg_35_1) == "table"), "equip attr sid type error from equip:" .. self.id)

	return self:GetEquipAttrInfo(var_35_0, var_35_1)
end

function Equipment:GetEquipAttrInfo(arg_36_1, arg_36_2)
	return switch(arg_36_1, {
		function()
			local var_37_0 = {
				name = i18n("equip_info_15")
			}

			if pg.weapon_property[arg_36_2].min_range == 0 then
				var_37_0.value = pg.weapon_property[arg_36_2].range or pg.weapon_property[arg_36_2].min_range .. "-" .. pg.weapon_property[arg_36_2].range
			end

			return var_37_0
		end,
		function()
			return {
				name = i18n("equip_info_16"),
				value = pg.weapon_property[arg_36_2].angle
			}
		end,
		function()
			return {
				name = i18n("equip_info_17"),
				value = pg.bullet_template[arg_36_2].range - pg.bullet_template[arg_36_2].range_offset .. "-" .. pg.bullet_template[arg_36_2].range + pg.bullet_template[arg_36_2].range_offset
			}
		end,
		function()
			local var_40_0 = {
				name = i18n("equip_info_18")
			}

			if pg.barrage_template[arg_36_2].random_angle then
				var_40_0.value = pg.barrage_template[arg_36_2].angle or math.abs(pg.barrage_template[arg_36_2].delta_angle) * pg.barrage_template[arg_36_2].primal_repeat
			end

			return var_40_0
		end,
		function()
			return {
				name = i18n("attribute_scatter"),
				value = pg.bullet_template[arg_36_2].extra_param.randomOffsetX
			}
		end,
		function()
			return {
				name = i18n("equip_info_19"),
				value = Nation.Nation2Name(self:getConfig("nationality"))
			}
		end,
		function()
			return {
				name = i18n("equip_info_20"),
				value = pg.aircraft_template[self.id].speed
			}
		end,
		function()
			return {
				name = i18n("equip_info_21"),
				type = AttributeType.AirDurability,
				value = {
					pg.aircraft_template[self.id].max_hp,
					pg.aircraft_template[self.id].hp_growth
				}
			}
		end,
		function()
			return {
				name = i18n("equip_info_22"),
				value = pg.aircraft_template[self.id].dodge_limit
			}
		end,
		function()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return {
					name = i18n("equip_info_28"),
					type = AttributeType.Corrected,
					value = EquipmentRarity.Rarity2CorrectedLevel(self:getConfig("rarity"), self:getConfig("level"))
				}
			else
				return {
					name = i18n("equip_info_28"),
					type = AttributeType.Corrected,
					value = pg.weapon_property[arg_36_2].corrected .. "%"
				}
			end

			return
		end,
		function()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return nil
			else
				local var_47_0 = {
					name = i18n("equip_info_29")
				}

				var_47_0.value = AttributeType.Type2Name(({
					AttributeType.Cannon,
					AttributeType.Torpedo,
					AttributeType.AntiAircraft,
					AttributeType.Air,
					AttributeType.AntiSub
				})[pg.weapon_property[arg_36_2].attack_attribute])

				return var_47_0
			end

			return
		end,
		function()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return nil
			else
				return {
					name = i18n("equip_info_30"),
					value = pg.weapon_property[arg_36_2].attack_attribute_ratio .. "%"
				}
			end

			return
		end,
		function()
			return {
				name = i18n("equip_info_32"),
				value = math.abs(pg.bullet_template[arg_36_2].extra_param.aim_offset)
			}
		end
	})
end

function Equipment:GetGearScore()
	local var_50_0 = self:getConfig("rarity")

	assert(pg.equip_data_by_quality[var_50_0], "equip_data_by_quality not exist: " .. var_50_0)

	return pg.equip_data_by_quality[var_50_0].gear_score + self:getConfig("level") * pg.equip_data_by_quality[var_50_0].gear_score_addition
end

function Equipment:GetSkill()
	local var_51_1 = self:getConfig("skill_id")[1] and self:getConfig("skill_id")[1][1]

	return (var_51_1 or nil) and getSkillConfig(var_51_1)
end

function Equipment:GetWeaponID()
	return self:getConfig("weapon_id")
end

function Equipment:GetSonarProperty()
	local var_53_0 = self:getConfig("equip_parameters").range

	if var_53_0 then
		return {
			[AttributeType.SonarRange] = var_53_0
		}
	else
		return nil
	end

	return
end

function Equipment:GetAntiSirenPower()
	return self:getConfig("anti_siren")
end

function Equipment:canUpgrade()
	return Equipment.getConfigData(self).next ~= 0
end

function Equipment:hasPrevLevel()
	return self:getConfig("prev") ~= 0
end

function Equipment:getRevertAwards()
	local var_57_0 = {}
	local var_57_1 = 0
	local var_57_2 = self

	while var_57_2:hasPrevLevel() do
		var_57_2 = Equipment.New({
			id = var_57_2:getConfig("prev")
		})

		for iter_57_0, iter_57_1 in ipairs(var_57_2:getConfig("trans_use_item")) do
			table.insert(var_57_0, Drop.New({
				type = DROP_TYPE_ITEM,
				id = iter_57_1[1],
				count = iter_57_1[2]
			}))
		end

		var_57_1 = var_57_1 + var_57_2:getConfig("trans_use_gold")
	end

	local var_57_3 = PlayerConst.MergeSameDrops(var_57_0)

	if var_57_1 > 0 then
		table.insert(var_57_3, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = var_57_1
		}))
	end

	return var_57_3
end

function Equipment:canEquipSkin()
	return pg.equip_data_by_type[self:getConfig("type")].equip_skin == 1
end

function Equipment:getType()
	return self:getConfig("type")
end

function Equipment:hasSkin()
	return self.skinId and self.skinId ~= 0
end

function Equipment:setSkinId(arg_61_1)
	self.skinId = arg_61_1

	return
end

function Equipment:getSkinId()
	return self.skinId
end

function Equipment:hasSkinOrbit()
	if not self:hasSkin() then
		return false
	end

	return Equipment.IsOrbitSkin(self.skinId)
end

function Equipment:IsOrbitSkin()
	if var_0_1[self].orbit_combat ~= "" or var_0_1[self].orbit_ui ~= "" then
		return true
	else
		return false
	end

	return
end

function Equipment:isImportance()
	return self:getConfig("important") == Equipment.EQUIPMENT_IMPORTANCE
end

function Equipment:isUnique()
	return self:getConfig("equip_limit") ~= 0
end

function Equipment:isDevice()
	local var_67_0 = self:getConfig("type")

	return underscore.any(EquipType.DeviceEquipTypes, function(arg_68_0)
		return arg_68_0 == var_67_0
	end)
end

function Equipment:isAircraft()
	local var_69_0 = self:getConfig("type")

	return underscore.any(EquipType.AirEquipTypes, function(arg_70_0)
		return arg_70_0 == var_69_0
	end)
end

function Equipment:isAircraftExtend()
	local var_71_0 = self:getConfig("type")

	return underscore.any(EquipType.AirExtendEquipTypes, function(arg_72_0)
		return arg_72_0 == var_71_0
	end)
end

function Equipment:MigrateTo(arg_73_1)
	assert(not self.isSkin)

	return Equipment.New({
		id = arg_73_1,
		config_id = arg_73_1,
		count = self.count
	})
end

function Equipment:GetRootEquipment()
	local var_74_0 = Equipment.getConfigData(self.configId)

	while var_74_0.prev > 0 do
		var_74_0 = Equipment.getConfigData(var_74_0.prev)
	end

	local var_74_1 = self:MigrateTo(var_74_0.id)

	var_74_1.count = 1

	return var_74_1
end

function Equipment:getNation()
	return self:getConfig("nationality")
end

function Equipment:GetEquipRootStatic()
	local var_76_0 = Equipment.getConfigData(self)

	while var_76_0.prev > 0 do
		var_76_0 = Equipment.getConfigData(var_76_0.prev)
	end

	return var_76_0.id
end

function Equipment:GetRevertRewardsStatic()
	local var_77_0 = {}
	local var_77_1 = Equipment.getConfigData(self)

	while var_77_1.prev > 0 do
		var_77_1 = Equipment.getConfigData(var_77_1.prev)

		for iter_77_0, iter_77_1 in ipairs(var_77_1.trans_use_item) do
			var_77_0[iter_77_1[1]] = (var_77_0[iter_77_1[1]] or 0) + iter_77_1[2]
		end

		var_77_0.gold = (var_77_0.gold or 0) + var_77_1.trans_use_gold
	end

	return var_77_0
end

function Equipment:GetEquipReloadStatic()
	local var_78_0 = Equipment.getConfigData(self).weapon_id

	if var_78_0 and #var_78_0 > 0 then
		if pg.weapon_property[var_78_0[1]] then
			return pg.weapon_property[var_78_0[1]].reload_max
		end
	end

	return
end

function Equipment:GetEquipComposeCfgStatic()
	for iter_79_0, iter_79_1 in ipairs(pg.compose_data_template.all) do
		local var_79_0 = true

		for iter_79_2, iter_79_3 in pairs(self) do
			var_79_0 = var_79_0 and pg.compose_data_template[iter_79_1][iter_79_2] == iter_79_3
		end

		if var_79_0 then
			return pg.compose_data_template[iter_79_1]
		end
	end

	return
end

function Equipment:IsMatchKey(arg_80_1)
	return EquipmentTools.IsMatchKey({
		self:getConfig("name"),
		pg._equip_data_statistics[self.configId].name
	}, arg_80_1)
end

return Equipment
