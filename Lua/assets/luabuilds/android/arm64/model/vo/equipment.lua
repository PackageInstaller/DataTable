local var_0_0 = class("Equipment", import(".BaseVO"))

var_0_0.EQUIPMENT_STATE_LOCK = 1
var_0_0.EQUIPMENT_STATE_EMPTY = 0
var_0_0.EQUIPMENT_NORMAL = 1
var_0_0.EQUIPMENT_IMPORTANCE = 2

local var_0_1 = pg.equip_skin_template

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.config_id or arg_1_0.id

	arg_1_0:InitConfig()

	arg_1_0.count = defaultValue(arg_1_1.count, 0)
	arg_1_0.new = defaultValue(arg_1_1.new, 0)
	arg_1_0.isSkin = defaultValue(arg_1_1.isSkin, false)
	arg_1_0.skinId = arg_1_1.skinId or 0

	return
end

function var_0_0.getConfigData(arg_2_0)
	local var_2_0

	if underscore.any({
		pg.equip_data_statistics,
		pg.equip_data_template
	}, function(arg_3_0)
		return arg_3_0[arg_2_0] ~= nil
	end) then
		var_2_0 = setmetatable({}, {
			__index = function(arg_4_0, arg_4_1)
				for iter_4_0, iter_4_1 in ipairs(var_0) do
					if iter_4_1[arg_2_0] and iter_4_1[arg_2_0][arg_4_1] ~= nil then
						arg_4_0[arg_4_1] = iter_4_1[arg_2_0][arg_4_1]

						return arg_4_0[arg_4_1]
					end
				end

				return
			end
		})

		if var_2_0.weapon_id and #var_2_0.weapon_id > 0 then
			var_2_0[AttributeType.CD] = pg.weapon_property[var_2_0.weapon_id[1]] and pg.weapon_property[var_2_0.weapon_id[1]].reload_max
		end
	end

	return var_2_0
end

function var_0_0.InitConfig(arg_5_0)
	arg_5_0.cfg = var_0_0.getConfigData(arg_5_0.configId)

	if not IsUnityEditor then
		arg_5_0.config = arg_5_0.cfg
	end

	assert(arg_5_0.cfg, string.format("without equip config from id_%d", arg_5_0.id))

	return
end

function var_0_0.getConfigTable(arg_6_0)
	return arg_6_0.cfg
end

function var_0_0.GetAttributes(arg_7_0)
	for iter_7_0 = 1, 3 do
		local var_7_0 = arg_7_0:getConfig("attribute_" .. iter_7_0)
		local var_7_1 = arg_7_0:getConfig("value_" .. iter_7_0)

		if var_7_0 ~= nil then
			local var_7_2 = {
				type = var_7_0
			}

			var_7_2.value = string.match(var_7_1, "^[%d|\\.]+$") and tonumber(var_7_1) or var_7_1
			var_7_2.auxBoost = arg_7_0:isDevice()
			var_7_2 = var_7_2 or false
			;({})[iter_7_0] = var_7_2
		end
	end

	return {}
end

function var_0_0.GetPropertyRate(arg_8_0)
	return arg_8_0:getConfig("property_rate")
end

function var_0_0.CanInBag(arg_9_0)
	return tobool(pg.equip_data_template[arg_9_0])
end

function var_0_0.vertify(arg_10_0)
	if arg_10_0:getConfig("value_1") ~= pg.equip_data_statistics[arg_10_0.configId].value_1 or arg_10_0:getConfig("value_2") ~= pg.equip_data_statistics[arg_10_0.configId].value_2 then
		return false
	end

	return true
end

function var_0_0.CalcWeanponCD(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1:getProperties().reload or 100

	return string.format("%0.2f", ys.Battle.BattleFormulas.CalculateReloadTime(arg_11_0 or 0, var_11_0))
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

function var_0_0.GetInfoTrans(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.name
	local var_13_1 = arg_13_0.value
	local var_13_2 = arg_13_0.auxBoost

	if arg_13_0.type == AttributeType.CD then
		var_13_1 = var_0_0.CalcWeanponCD(var_13_1, arg_13_1) .. "s" .. pg.equip_data_code.WAVE.text

		goto label_13_0
	end

	::label_13_0::

	if arg_13_0.type == AttributeType.AirDurability then
		if arg_13_1 then
			do
				local var_13_3 = arg_13_1.level or 100

				var_13_1 = math.floor(var_13_1[1] + var_13_1[2] * (var_13_3 - 1) / 1000)

				if false then
					if arg_13_0.type == AttributeType.AntiSiren then
						var_13_1 = math.floor(var_13_1 / 100)
						var_13_1 = (var_13_1 > 0 and "+" or var_13_1 < 0 and "-" or "") .. var_13_1 .. "%"
					end
				end
			end

			var_13_0 = var_13_0 or AttributeType.Type2Name(arg_13_0.type)

			if not arg_13_1 then
				var_13_0 = defaultValue(var_0_4(var_13_0), var_13_0)
			end

			var_13_1 = var_13_1 or ""
			var_13_2 = var_13_2 and arg_13_1 and table.contains(arg_13_1:getSpecificType(), ShipType.SpecificTypeTable.auxiliary)

			return var_13_0, var_13_1, var_13_2
		end
	end
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

function var_0_0.AlignAttrs(arg_15_0, arg_15_1)
	for iter_15_0 = 1, #arg_15_0 do
		if not arg_15_1[iter_15_0] or arg_15_0[iter_15_0].type ~= arg_15_1[iter_15_0].type then
			table.insert(arg_15_1, iter_15_0, Clone(arg_15_0[iter_15_0]))

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

	for iter_15_2 = #arg_15_0 + 1, #arg_15_1 do
		table.insert(arg_15_0, Clone(arg_15_1[iter_15_2]))

		arg_15_0[iter_15_2].value = 0
	end

	return
end

function var_0_0.CompareInfo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1.compare = arg_16_0.type == AttributeType.Damage and var_0_5(arg_16_1.value) - var_0_5(arg_16_0.value) or arg_16_0.type == AttributeType.CD and -(var_0_0.CalcWeanponCD(arg_16_1.value, arg_16_2) - var_0_0.CalcWeanponCD(arg_16_0.value, arg_16_2)) or arg_16_1.value - arg_16_0.value

	return
end

function var_0_0.InsertAttrsUpgrade(arg_17_0, arg_17_1, arg_17_2)
	var_0_0.AlignAttrs(arg_17_0, arg_17_1)

	for iter_17_0 = #arg_17_0, 1, -1 do
		if arg_17_0[iter_17_0].value == arg_17_1[iter_17_0].value then
			if not arg_17_2 then
				table.remove(arg_17_0, iter_17_0)
				table.remove(arg_17_1, iter_17_0)
			end
		else
			arg_17_0[iter_17_0].nextValue = arg_17_1[iter_17_0].value
		end
	end

	return
end

function var_0_0.InsertAttrsCompare(arg_18_0, arg_18_1, arg_18_2)
	var_0_0.AlignAttrs(arg_18_0, arg_18_1)

	for iter_18_0 = 1, #arg_18_0 do
		var_0_0.CompareInfo(arg_18_0[iter_18_0], arg_18_1[iter_18_0], arg_18_2)
	end

	return
end

function var_0_0.GetPropertiesInfo(arg_19_0)
	if arg_19_0:getConfig(AttributeType.Damage) then
		table.insert(({
			attrs = {}
		}).attrs, {
			type = AttributeType.Damage,
			value = arg_19_0:getConfig(AttributeType.Damage)
		})
	end

	if arg_19_0:getConfig(AttributeType.CD) then
		local var_19_0 = {
			type = AttributeType.CD,
			value = arg_19_0:getConfig(AttributeType.CD)
		}

		table.insert(({
			attrs = {}
		}).attrs, var_19_0)

		if arg_19_0:isAircraftExtend() and arg_19_0:getConfig("weapon_id") then
			var_19_0.sub = {}

			for iter_19_0, iter_19_1 in ipairs(arg_19_0:getConfig("weapon_id")) do
				if pg.weapon_property[iter_19_1].type == 11 then
					table.insert(var_19_0.sub, {
						name = i18n("equip_info_34"),
						type = AttributeType.CD,
						value = pg.weapon_property[iter_19_1].reload_max
					})
				end
			end
		end
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0:GetAttributes()) do
		if iter_19_3 and iter_19_3.type ~= AttributeType.OxyRaidDistance then
			table.insert(({
				attrs = {}
			}).attrs, iter_19_3)
		end
	end

	if arg_19_0:GetAntiSirenPower() then
		table.insert(({
			attrs = {}
		}).attrs, {
			type = AttributeType.AntiSiren,
			value = arg_19_0:GetAntiSirenPower()
		})
	end

	local var_19_1 = arg_19_0:GetSonarProperty()

	if var_19_1 then
		table.insert(({
			attrs = {}
		}).attrs, {
			type = AttributeType.SonarRange,
			value = var_19_1[AttributeType.SonarRange]
		})
	end

	;({
		attrs = {}
	}).weapon = {
		lock_open = true,
		name = i18n(arg_19_0:isAircraftExtend() and "equip_info_24" or "equip_info_5"),
		sub = {}
	}

	for iter_19_4, iter_19_5 in ipairs(arg_19_0:getConfig("ammo_info")) do
		table.insert(({
			attrs = {}
		}).weapon.sub, arg_19_0:GetWeaponPageInfo(iter_19_5[1], iter_19_5[2]))
	end

	;({
		attrs = {}
	}).equipInfo = {
		name = i18n("equip_info_14"),
		sub = {}
	}

	for iter_19_6, iter_19_7 in ipairs(arg_19_0:getConfig("equip_info")) do
		table.insert(({
			attrs = {}
		}).equipInfo.sub, arg_19_0:GetEquipAttrPageInfo(iter_19_7))
	end

	;({
		attrs = {}
	}).part = {
		arg_19_0:getConfig("part_main"),
		arg_19_0:getConfig("part_sub")
	}
	;({
		attrs = {}
	}).equipmentType = arg_19_0:getConfig("type")

	return {
		attrs = {}
	}
end

function var_0_0.GetWeaponPageInfo(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1 = pg.equip_bullet_type[arg_20_1].exhibition_type == 2

	for iter_20_0, iter_20_1 in ipairs(pg.equip_bullet_type[arg_20_1].exhibition_list) do
		if not var_20_0 then
			var_20_0 = arg_20_0:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1)
			var_20_0.sub = {}
		else
			table.insert(var_20_0.sub, arg_20_0:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1))
		end
	end

	return var_20_0
end

function var_0_0.GetWeaponInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3 and pg.weapon_property[arg_21_2].bullet_ID[1] or arg_21_2

	return switch(arg_21_1, {
		function()
			return {
				name = i18n("equip_ammo_type_" .. arg_21_0:getConfig(AttributeType.Ammo))
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
			local var_31_1 = pg.bullet_template[var_21_0].extra_param.randomOffsetX or "0"
			local var_31_2 = "*"
			local var_31_3 = pg.bullet_template[var_21_0].extra_param.randomOffsetZ or "0"

			var_31_0.value = var_31_1 .. var_31_2 .. var_31_3

			return var_31_0
		end,
		function()
			return {
				name = i18n("equip_info_13"),
				value = arg_21_0:getConfig(AttributeType.Speciality)
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

function var_0_0.GetEquipAttrPageInfo(arg_35_0, arg_35_1)
	local var_35_0
	local var_35_1

	if type(arg_35_1) == "table" then
		var_35_1 = arg_35_1[2]
		var_35_0 = arg_35_1[1]

		goto label_35_0

		var_35_1 = arg_35_0:getConfig("weapon_id")[1]
	end

	var_35_0 = arg_35_1

	::label_35_0::

	assert(tobool(var_0_6[var_35_0]) == (type(arg_35_1) == "table"), "equip attr sid type error from equip:" .. arg_35_0.id)

	return arg_35_0:GetEquipAttrInfo(var_35_0, var_35_1)
end

function var_0_0.GetEquipAttrInfo(arg_36_0, arg_36_1, arg_36_2)
	return switch(arg_36_1, {
		function()
			local var_37_0 = {
				name = i18n("equip_info_15")
			}

			if pg.weapon_property[arg_36_2].min_range == 0 then
				var_37_0.value = pg.weapon_property[arg_36_2].range or pg.weapon_property[arg_36_2].min_range .. "-" .. pg.weapon_property[arg_36_2].range

				return var_37_0
			end
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

				return var_40_0
			end
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
				value = Nation.Nation2Name(arg_36_0:getConfig("nationality"))
			}
		end,
		function()
			return {
				name = i18n("equip_info_20"),
				value = pg.aircraft_template[arg_36_0.id].speed
			}
		end,
		function()
			return {
				name = i18n("equip_info_21"),
				type = AttributeType.AirDurability,
				value = {
					pg.aircraft_template[arg_36_0.id].max_hp,
					pg.aircraft_template[arg_36_0.id].hp_growth
				}
			}
		end,
		function()
			return {
				name = i18n("equip_info_22"),
				value = pg.aircraft_template[arg_36_0.id].dodge_limit
			}
		end,
		function()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return {
					name = i18n("equip_info_28"),
					type = AttributeType.Corrected,
					value = EquipmentRarity.Rarity2CorrectedLevel(arg_36_0:getConfig("rarity"), arg_36_0:getConfig("level"))
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
			local var_47_0

			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				do return nil end

				goto label_47_0

				var_47_0 = {
					name = i18n("equip_info_29")
				}
			end

			var_47_0.value = AttributeType.Type2Name(({
				AttributeType.Cannon,
				AttributeType.Torpedo,
				AttributeType.AntiAircraft,
				AttributeType.Air,
				AttributeType.AntiSub
			})[pg.weapon_property[arg_36_2].attack_attribute])

			do return var_47_0 end

			::label_47_0::

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

function var_0_0.GetGearScore(arg_50_0)
	local var_50_0 = arg_50_0:getConfig("rarity")

	assert(pg.equip_data_by_quality[var_50_0], "equip_data_by_quality not exist: " .. var_50_0)

	return pg.equip_data_by_quality[var_50_0].gear_score + arg_50_0:getConfig("level") * pg.equip_data_by_quality[var_50_0].gear_score_addition
end

function var_0_0.GetSkill(arg_51_0)
	local var_51_0
	local var_51_1 = arg_51_0:getConfig("skill_id")[1] and arg_51_0:getConfig("skill_id")[1][1]

	if var_51_1 then
		var_51_0 = getSkillConfig(var_51_1)
	end

	return var_51_0
end

function var_0_0.GetWeaponID(arg_52_0)
	return arg_52_0:getConfig("weapon_id")
end

function var_0_0.GetSonarProperty(arg_53_0)
	local var_53_0 = arg_53_0:getConfig("equip_parameters").range

	if var_53_0 then
		return {
			[AttributeType.SonarRange] = var_53_0
		}
	else
		return nil
	end

	return
end

function var_0_0.GetAntiSirenPower(arg_54_0)
	return arg_54_0:getConfig("anti_siren")
end

function var_0_0.canUpgrade(arg_55_0)
	return var_0_0.getConfigData(arg_55_0).next ~= 0
end

function var_0_0.hasPrevLevel(arg_56_0)
	return arg_56_0:getConfig("prev") ~= 0
end

function var_0_0.getRevertAwards(arg_57_0)
	local var_57_0 = 0
	local var_57_1 = arg_57_0

	while var_57_1:hasPrevLevel() do
		var_57_1 = Equipment.New({
			id = var_57_1:getConfig("prev")
		})

		for iter_57_0, iter_57_1 in ipairs(var_57_1:getConfig("trans_use_item")) do
			table.insert({}, Drop.New({
				type = DROP_TYPE_ITEM,
				id = iter_57_1[1],
				count = iter_57_1[2]
			}))
		end

		var_57_0 = var_57_0 + var_57_1:getConfig("trans_use_gold")
	end

	local var_57_2 = PlayerConst.MergeSameDrops({})

	if var_57_0 > 0 then
		table.insert(var_57_2, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = var_57_0
		}))
	end

	return var_57_2
end

function var_0_0.canEquipSkin(arg_58_0)
	return pg.equip_data_by_type[arg_58_0:getConfig("type")].equip_skin == 1
end

function var_0_0.getType(arg_59_0)
	return arg_59_0:getConfig("type")
end

function var_0_0.hasSkin(arg_60_0)
	return arg_60_0.skinId and arg_60_0.skinId ~= 0
end

function var_0_0.setSkinId(arg_61_0, arg_61_1)
	arg_61_0.skinId = arg_61_1

	return
end

function var_0_0.getSkinId(arg_62_0)
	return arg_62_0.skinId
end

function var_0_0.hasSkinOrbit(arg_63_0)
	if not arg_63_0:hasSkin() then
		return false
	end

	return var_0_0.IsOrbitSkin(arg_63_0.skinId)
end

function var_0_0.IsOrbitSkin(arg_64_0)
	if var_0_1[arg_64_0].orbit_combat ~= "" or var_0_1[arg_64_0].orbit_ui ~= "" then
		return true
	else
		return false
	end

	return
end

function var_0_0.isImportance(arg_65_0)
	return arg_65_0:getConfig("important") == var_0_0.EQUIPMENT_IMPORTANCE
end

function var_0_0.isUnique(arg_66_0)
	return arg_66_0:getConfig("equip_limit") ~= 0
end

function var_0_0.isDevice(arg_67_0)
	local var_67_0 = arg_67_0:getConfig("type")

	return underscore.any(EquipType.DeviceEquipTypes, function(arg_68_0)
		return arg_68_0 == var_67_0
	end)
end

function var_0_0.isAircraft(arg_69_0)
	local var_69_0 = arg_69_0:getConfig("type")

	return underscore.any(EquipType.AirEquipTypes, function(arg_70_0)
		return arg_70_0 == var_69_0
	end)
end

function var_0_0.isAircraftExtend(arg_71_0)
	local var_71_0 = arg_71_0:getConfig("type")

	return underscore.any(EquipType.AirExtendEquipTypes, function(arg_72_0)
		return arg_72_0 == var_71_0
	end)
end

function var_0_0.MigrateTo(arg_73_0, arg_73_1)
	assert(not arg_73_0.isSkin)

	return Equipment.New({
		id = arg_73_1,
		config_id = arg_73_1,
		count = arg_73_0.count
	})
end

function var_0_0.GetRootEquipment(arg_74_0)
	local var_74_0 = var_0_0.getConfigData(arg_74_0.configId)

	while var_74_0.prev > 0 do
		var_74_0 = var_0_0.getConfigData(var_74_0.prev)
	end

	local var_74_1 = arg_74_0:MigrateTo(var_74_0.id)

	var_74_1.count = 1

	return var_74_1
end

function var_0_0.getNation(arg_75_0)
	return arg_75_0:getConfig("nationality")
end

function var_0_0.GetEquipRootStatic(arg_76_0)
	local var_76_0 = var_0_0.getConfigData(arg_76_0)

	while var_76_0.prev > 0 do
		var_76_0 = var_0_0.getConfigData(var_76_0.prev)
	end

	return var_76_0.id
end

function var_0_0.GetRevertRewardsStatic(arg_77_0)
	local var_77_0 = var_0_0.getConfigData(arg_77_0)

	while var_77_0.prev > 0 do
		var_77_0 = var_0_0.getConfigData(var_77_0.prev)

		for iter_77_0, iter_77_1 in ipairs(var_77_0.trans_use_item) do
			local var_77_1 = ({})[iter_77_1[1]]

			if not ({})[iter_77_1[1]] then
				var_77_1 = 0
			end

			;({})[iter_77_1[1]] = var_77_1 + iter_77_1[2]
		end

		local var_77_2 = ({}).gold

		if not ({}).gold then
			var_77_2 = 0
		end

		;({}).gold = var_77_2 + var_77_0.trans_use_gold
	end

	return {}
end

function var_0_0.GetEquipReloadStatic(arg_78_0)
	local var_78_0 = var_0_0.getConfigData(arg_78_0).weapon_id

	if var_78_0 and #var_78_0 > 0 then
		if pg.weapon_property[var_78_0[1]] then
			return pg.weapon_property[var_78_0[1]].reload_max
		end
	end

	return
end

function var_0_0.GetEquipComposeCfgStatic(arg_79_0)
	for iter_79_0, iter_79_1 in ipairs(pg.compose_data_template.all) do
		local var_79_0 = true

		for iter_79_2, iter_79_3 in pairs(arg_79_0) do
			var_79_0 = var_79_0 and pg.compose_data_template[iter_79_1][iter_79_2] == iter_79_3
		end

		if var_79_0 then
			return pg.compose_data_template[iter_79_1]
		end
	end

	return
end

function var_0_0.IsMatchKey(arg_80_0, arg_80_1)
	return EquipmentTools.IsMatchKey({
		arg_80_0:getConfig("name"),
		pg._equip_data_statistics[arg_80_0.configId].name
	}, arg_80_1)
end

return var_0_0
