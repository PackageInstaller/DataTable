local IndexConst = class("IndexConst")

function IndexConst:Flags2Bits()
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(self) do
		var_1_0 = bit.bor(var_1_0, bit.lshift(1, iter_1_1))
	end

	return var_1_0
end

function IndexConst:FlagRange2Bits(arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = self, arg_2_1 do
		var_2_0 = bit.bor(var_2_0, bit.lshift(1, iter_2_0))
	end

	return var_2_0
end

function IndexConst:ToggleBits(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = self
	local var_3_1 = bit.lshift(1, arg_3_3)

	if arg_3_2 then
		local var_3_2 = bit.lshift(1, arg_3_2)

		if var_3_1 == var_3_2 then
			var_3_0 = var_3_2
		else
			if bit.band(var_3_0, var_3_2) > 0 then
				var_3_0 = var_3_0 - var_3_2
			end

			if bit.band(var_3_0, var_3_1) > 0 then
				var_3_1 = -var_3_1
			end

			var_3_0 = var_3_0 + var_3_1

			if var_3_0 == _.reduce(arg_3_1, 0, function(arg_4_0, arg_4_1)
				return arg_4_0 + (arg_4_1 ~= arg_3_2 and bit.lshift(1, arg_4_1) or 0)
			end) or var_3_0 == 0 then
				var_3_0 = var_3_2
			end
		end
	else
		if bit.band(var_3_0, var_3_1) > 0 then
			var_3_1 = -var_3_1
		end

		var_3_0 = var_3_0 + var_3_1
	end

	return var_3_0
end

function IndexConst:SingleToggleBits(arg_5_1, arg_5_2, arg_5_3)
	local var_5_1 = bit.lshift(1, arg_5_3)

	return self == var_5_1 and bit.lshift(1, arg_5_2) or var_5_1
end

function IndexConst:StrLShift(arg_6_1)
	for iter_6_0 = 1, arg_6_1 do
		self = self .. "0"
	end

	return self .. ""
end

function IndexConst:StrAnd(arg_7_1)
	local var_7_0 = ""
	local var_7_1 = string.len(self) > string.len(arg_7_1) and self or arg_7_1
	local var_7_2 = var_7_1 == self and arg_7_1 or self
	local var_7_3 = string.len(var_7_1)
	local var_7_4 = string.len(var_7_1 == self and arg_7_1 or self)

	for iter_7_0 = 1, var_7_4 do
		var_7_0 = string.sub(var_7_2, iter_7_0, iter_7_0) == "1" and string.sub(var_7_1, var_7_3 - var_7_4 + iter_7_0, var_7_3 - var_7_4 + iter_7_0) == "1" and var_7_0 .. "1" or var_7_0 .. "0"
	end

	local var_7_5 = ""

	for iter_7_1 = 1, var_7_3 - var_7_4 do
		var_7_5 = var_7_5 .. "0"
	end

	return var_7_5 .. var_7_0
end

function IndexConst:StrOr(arg_8_1)
	local var_8_0 = ""
	local var_8_1 = string.len(self) > string.len(arg_8_1) and self or arg_8_1
	local var_8_2 = var_8_1 == self and arg_8_1 or self
	local var_8_3 = string.len(var_8_1)
	local var_8_4 = string.len(var_8_1 == self and arg_8_1 or self)

	for iter_8_0 = 1, var_8_4 do
		var_8_0 = (string.sub(var_8_2, iter_8_0, iter_8_0) == "1" or string.sub(var_8_1, var_8_3 - var_8_4 + iter_8_0, var_8_3 - var_8_4 + iter_8_0) == "1") and var_8_0 .. "1" or var_8_0 .. "0"
	end

	return string.sub(var_8_1, 1, var_8_3 - var_8_4) .. var_8_0
end

function IndexConst:Flags2Str()
	local var_9_0 = ""

	for iter_9_0, iter_9_1 in ipairs(self) do
		var_9_0 = IndexConst.StrOr(var_9_0, IndexConst.StrLShift("1", iter_9_1))
	end

	return var_9_0
end

function IndexConst:FlagRange2Str(arg_10_1)
	local var_10_0 = ""

	for iter_10_0 = self, arg_10_1 do
		var_10_0 = IndexConst.StrOr(var_10_0, IndexConst.StrLShift("1", iter_10_0))
	end

	return var_10_0
end

function IndexConst:ToggleStr(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self
	local var_11_1 = IndexConst.StrLShift("1", arg_11_3)

	if arg_11_2 then
		local var_11_2 = IndexConst.StrLShift("1", arg_11_2)
		local var_11_3 = ""

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			if iter_11_1 ~= arg_11_2 then
				var_11_3 = IndexConst.StrOr(var_11_3, IndexConst.StrLShift("1", iter_11_1))
			end
		end

		if var_11_1 == var_11_2 or var_11_0 == var_11_3 then
			var_11_0 = var_11_2
		else
			if string.find(IndexConst.StrAnd(var_11_0, var_11_2), "1") ~= nil then
				var_11_0 = var_11_1
			else
				local var_11_4 = IndexConst.StrOr(var_11_0, var_11_1)
				local var_11_5 = string.len(var_11_4) - arg_11_3

				var_11_0 = string.sub(var_11_4, 1, var_11_5 - 1) .. (string.find(IndexConst.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1") .. string.sub(var_11_4, var_11_5 + 1)
			end

			if var_11_0 == var_11_3 or string.find(var_11_0, "1") == nil then
				var_11_0 = var_11_2
			end
		end
	else
		local var_11_6 = IndexConst.StrOr(var_11_0, var_11_1)
		local var_11_7 = string.len(var_11_6) - arg_11_3

		var_11_0 = string.sub(var_11_6, 1, var_11_7 - 1) .. (string.find(IndexConst.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1") .. string.sub(var_11_6, var_11_7 + 1)
	end

	return var_11_0
end

function IndexConst:BitAll()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(self) do
		var_12_0 = bit.bor(iter_12_1, var_12_0)
	end

	return var_12_0
end

IndexConst.EquipmentTypeSmallCannon = bit.lshift(1, 0)
IndexConst.EquipmentTypeMediumCannon = bit.lshift(1, 1)
IndexConst.EquipmentTypeBigCannon = bit.lshift(1, 2)
IndexConst.EquipmentTypeWarshipTorpedo = bit.lshift(1, 3)
IndexConst.EquipmentTypeSubmaraineTorpedo = bit.lshift(1, 4)
IndexConst.EquipmentTypeAntiAircraft = bit.lshift(1, 5)
IndexConst.EquipmentTypeFighter = bit.lshift(1, 6)
IndexConst.EquipmentTypeBomber = bit.lshift(1, 7)
IndexConst.EquipmentTypeTorpedoBomber = bit.lshift(1, 8)
IndexConst.EquipmentTypeEquip = bit.lshift(1, 9)
IndexConst.EquipmentTypeOther = bit.lshift(1, 10)
IndexConst.EquipmentTypeIndexs = {
	IndexConst.EquipmentTypeSmallCannon,
	IndexConst.EquipmentTypeMediumCannon,
	IndexConst.EquipmentTypeBigCannon,
	IndexConst.EquipmentTypeWarshipTorpedo,
	IndexConst.EquipmentTypeSubmaraineTorpedo,
	IndexConst.EquipmentTypeAntiAircraft,
	IndexConst.EquipmentTypeFighter,
	IndexConst.EquipmentTypeBomber,
	IndexConst.EquipmentTypeTorpedoBomber,
	IndexConst.EquipmentTypeEquip,
	IndexConst.EquipmentTypeOther
}
IndexConst.EquipmentTypeAll = IndexConst.BitAll(IndexConst.EquipmentTypeIndexs)

table.insert(IndexConst.EquipmentTypeIndexs, 1, IndexConst.EquipmentTypeAll)

function IndexConst:filterEquipByType(arg_13_1)
	if not arg_13_1 or arg_13_1 == IndexConst.EquipmentTypeAll then
		return true
	end

	for iter_13_0 = 2, #EquipmentSortCfg.index do
		if bit.band(bit.lshift(1, iter_13_0 - 2), arg_13_1) > 0 and table.contains(EquipmentSortCfg.index[iter_13_0].types, self:getConfig("type")) then
			return true
		end
	end

	return false
end

IndexConst.EquipmentTypeNames = {
	"word_equipment_all",
	"word_equipment_small_cannon",
	"word_equipment_medium_cannon",
	"word_equipment_big_cannon",
	"word_equipment_warship_torpedo",
	"word_equipment_submarine_torpedo",
	"word_equipment_antiaircraft",
	"word_equipment_fighter",
	"word_equipment_bomber",
	"word_equipment_torpedo_bomber",
	"word_equipment_equip",
	"word_equipment_special"
}
IndexConst.EquipCampUS = bit.lshift(1, 0)
IndexConst.EquipCampEN = bit.lshift(1, 1)
IndexConst.EquipCampJP = bit.lshift(1, 2)
IndexConst.EquipCampDE = bit.lshift(1, 3)
IndexConst.EquipCampCN = bit.lshift(1, 4)
IndexConst.EquipCampITA = bit.lshift(1, 5)
IndexConst.EquipCampSN = bit.lshift(1, 6)
IndexConst.EquipCampFR = bit.lshift(1, 7)
IndexConst.EquipCampMNF = bit.lshift(1, 8)
IndexConst.EquipCampMOT = bit.lshift(1, 9)
IndexConst.EquipCampLINK = bit.lshift(1, 10)
IndexConst.EquipCampOther = bit.lshift(1, 11)
IndexConst.EquipCampIndexs = {
	IndexConst.EquipCampUS,
	IndexConst.EquipCampEN,
	IndexConst.EquipCampJP,
	IndexConst.EquipCampDE,
	IndexConst.EquipCampCN,
	IndexConst.EquipCampITA,
	IndexConst.EquipCampSN,
	IndexConst.EquipCampFR,
	IndexConst.EquipCampMNF,
	IndexConst.EquipCampMOT,
	IndexConst.EquipCampLINK,
	IndexConst.EquipCampOther
}
IndexConst.EquipCampNames = {
	"word_shipNation_all",
	"word_shipNation_baiYing",
	"word_shipNation_huangJia",
	"word_shipNation_chongYing",
	"word_shipNation_tieXue",
	"word_shipNation_dongHuang",
	"word_shipNation_saDing",
	"word_shipNation_beiLian",
	"word_shipNation_ziyou",
	"word_shipNation_weixi",
	"word_shipNation_mot",
	"word_shipNation_link",
	"word_shipNation_other"
}
IndexConst.EquipCampAll = IndexConst.BitAll(IndexConst.EquipCampIndexs)

table.insert(IndexConst.EquipCampIndexs, 1, IndexConst.EquipCampAll)

function IndexConst:filterEquipByCamp(arg_14_1)
	if not arg_14_1 or arg_14_1 == IndexConst.EquipmentTypeAll then
		return true
	end

	for iter_14_0 = 2, #EquipmentSortCfg.campIndex do
		if bit.band(bit.lshift(1, iter_14_0 - 2), arg_14_1) > 0 then
			for iter_14_1, iter_14_2 in ipairs(EquipmentSortCfg.campIndex[iter_14_0].types) do
				if iter_14_2 == Nation.LINK then
					if self:getNation() >= Nation.LINK then
						return true
					end
				elseif iter_14_2 == self:getNation() then
					return true
				end
			end
		end
	end

	return false
end

IndexConst.EquipProperty_Cannon = bit.lshift(1, 0)
IndexConst.EquipProperty_Air = bit.lshift(1, 1)
IndexConst.EquipProperty_Dodge = bit.lshift(1, 2)
IndexConst.EquipProperty_AntiAircraft = bit.lshift(1, 3)
IndexConst.EquipProperty_Torpedo = bit.lshift(1, 4)
IndexConst.EquipProperty_Reload = bit.lshift(1, 5)
IndexConst.EquipProperty_Durability = bit.lshift(1, 6)
IndexConst.EquipProperty_Antisub = bit.lshift(1, 7)
IndexConst.EquipProperty_Oxy = bit.lshift(1, 8)
IndexConst.EquipProperty_Speed = bit.lshift(1, 9)
IndexConst.EquipProperty_Hit = bit.lshift(1, 10)
IndexConst.EquipProperty_Luck = bit.lshift(1, 11)
IndexConst.EquipPropertyIndexs = {
	IndexConst.EquipProperty_Cannon,
	IndexConst.EquipProperty_Air,
	IndexConst.EquipProperty_Dodge,
	IndexConst.EquipProperty_AntiAircraft,
	IndexConst.EquipProperty_Torpedo,
	IndexConst.EquipProperty_Reload,
	IndexConst.EquipProperty_Durability,
	IndexConst.EquipProperty_Antisub,
	IndexConst.EquipProperty_Oxy,
	IndexConst.EquipProperty_Speed,
	IndexConst.EquipProperty_Hit,
	IndexConst.EquipProperty_Luck
}
IndexConst.EquipPropertyAll = IndexConst.BitAll(IndexConst.EquipPropertyIndexs)

table.insert(IndexConst.EquipPropertyIndexs, 1, IndexConst.EquipPropertyAll)

IndexConst.EquipPropertyNames = {
	"sort_attribute",
	"attribute_cannon",
	"attribute_air",
	"attribute_dodge",
	"attribute_antiaircraft",
	"attribute_torpedo",
	"attribute_reload",
	"attribute_durability",
	"attribute_antisub",
	"attribute_oxy_max",
	"attribute_speed",
	"attribute_hit",
	"attribute_luck"
}

function IndexConst:filterEquipByProperty(arg_15_1)
	local var_15_0 = {}

	if self:getConfig("attribute_1") then
		table.insert(var_15_0, self:getConfig("attribute_1"))
	end

	if self:getConfig("attribute_2") then
		table.insert(var_15_0, self:getConfig("attribute_2"))
	end

	if self:getConfig("attribute_3") then
		table.insert(var_15_0, self:getConfig("attribute_3"))
	end

	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if not iter_15_1 or iter_15_1 == IndexConst.EquipPropertyAll then
			var_15_1 = var_15_1 + 1
		else
			for iter_15_2 = 2, #EquipmentSortCfg.propertyIndex do
				if bit.band(bit.lshift(1, iter_15_2 - 2), iter_15_1) > 0 then
					for iter_15_3 = #var_15_0, 1, -1 do
						if table.contains(EquipmentSortCfg.propertyIndex[iter_15_2].types, var_15_0[iter_15_3]) then
							var_15_1 = var_15_1 + 1

							table.remove(var_15_0, iter_15_3)

							break
						end
					end
				end
			end
		end
	end

	return var_15_1 >= #arg_15_1
end

IndexConst.EquipAmmoChuanjia = bit.lshift(1, 0)
IndexConst.EquipAmmoGaobao = bit.lshift(1, 1)
IndexConst.EquipAmmoTongchangDan = bit.lshift(1, 2)
IndexConst.EquipAmmoQita = bit.lshift(1, 3)
IndexConst.EquipAmmoIndexs_1 = {
	IndexConst.EquipAmmoChuanjia,
	IndexConst.EquipAmmoGaobao,
	IndexConst.EquipAmmoTongchangDan,
	IndexConst.EquipAmmoQita
}
IndexConst.EquipAmmoAll_1 = IndexConst.BitAll(IndexConst.EquipAmmoIndexs_1)

table.insert(IndexConst.EquipAmmoIndexs_1, 1, IndexConst.EquipAmmoAll_1)

IndexConst.EquipAmmoIndexs_1_Names = {
	"attribute_ammo",
	"equip_ammo_type_1",
	"equip_ammo_type_2",
	"equip_ammo_type_3",
	"word_shipType_other"
}

function IndexConst:filterEquipAmmo1(arg_16_1)
	if not arg_16_1 or arg_16_1 == IndexConst.EquipAmmoAll_1 then
		return true
	end

	for iter_16_0 = 2, #EquipmentSortCfg.ammoIndex1 do
		if bit.band(bit.lshift(1, iter_16_0 - 2), arg_16_1) > 0 and table.contains(EquipmentSortCfg.ammoIndex1[iter_16_0].types, self:getConfig("ammo")) then
			return true
		end
	end

	return false
end

IndexConst.EquipAmmoShengdao = bit.lshift(1, 0)
IndexConst.EquipAmmoTongchang = bit.lshift(1, 1)
IndexConst.EquipAmmoIndexs_2 = {
	IndexConst.EquipAmmoShengdao,
	IndexConst.EquipAmmoTongchang
}
IndexConst.EquipAmmoAll_2 = IndexConst.BitAll(IndexConst.EquipAmmoIndexs_2)

table.insert(IndexConst.EquipAmmoIndexs_2, 1, IndexConst.EquipAmmoAll_2)

IndexConst.EquipAmmoIndexs_2_Names = {
	"attribute_ammo",
	"equip_ammo_type_4",
	"equip_ammo_type_5"
}

function IndexConst:filterEquipAmmo2(arg_17_1)
	if not arg_17_1 or arg_17_1 == IndexConst.EquipAmmoAll_2 then
		return true
	end

	for iter_17_0 = 2, #EquipmentSortCfg.ammoIndex2 do
		if bit.band(bit.lshift(1, iter_17_0 - 2), arg_17_1) > 0 and table.contains(EquipmentSortCfg.ammoIndex2[iter_17_0].types, self:getConfig("ammo")) then
			return true
		end
	end

	return false
end

IndexConst.EquipmentRarity1 = bit.lshift(1, 0)
IndexConst.EquipmentRarity2 = bit.lshift(1, 1)
IndexConst.EquipmentRarity3 = bit.lshift(1, 2)
IndexConst.EquipmentRarity4 = bit.lshift(1, 3)
IndexConst.EquipmentRarity5 = bit.lshift(1, 4)
IndexConst.EquipmentRarityIndexs = {
	IndexConst.EquipmentRarity1,
	IndexConst.EquipmentRarity2,
	IndexConst.EquipmentRarity3,
	IndexConst.EquipmentRarity4,
	IndexConst.EquipmentRarity5
}
IndexConst.EquipmentRarityAll = IndexConst.BitAll(IndexConst.EquipmentRarityIndexs)

table.insert(IndexConst.EquipmentRarityIndexs, 1, IndexConst.EquipmentRarityAll)

IndexConst.RarityNames = {
	"index_all",
	"index_rare2",
	"index_rare3",
	"index_rare4",
	"index_rare5",
	"index_rare6"
}

function IndexConst:filterEquipByRarity(arg_18_1)
	if not arg_18_1 or arg_18_1 == IndexConst.EquipmentRarityAll then
		return true
	end

	return bit.band(bit.lshift(1, (math.max(self:getConfig("rarity") - 2, 0))), arg_18_1) > 0
end

IndexConst.EquipmentExtraNames = {
	"index_without_limit",
	"index_equip",
	"index_strengthen",
	"index_reform"
}
IndexConst.EquipmentExtraEquiping = bit.lshift(1, 0)
IndexConst.EquipmentExtraStrengthen = bit.lshift(1, 1)
IndexConst.EquipmentExtraTransform = bit.lshift(1, 2)
IndexConst.EquipmentExtraIndexs = {
	IndexConst.EquipmentExtraEquiping,
	IndexConst.EquipmentExtraStrengthen,
	IndexConst.EquipmentExtraTransform
}
IndexConst.EquipmentExtraNone = 0

table.insert(IndexConst.EquipmentExtraIndexs, 1, IndexConst.EquipmentExtraNone)

function IndexConst:filterEquipByExtra(arg_19_1)
	arg_19_1 = arg_19_1 or 0

	if bit.band(arg_19_1, IndexConst.EquipmentExtraEquiping) > 0 and not self.shipId then
		return false
	end

	if bit.band(arg_19_1, IndexConst.EquipmentExtraStrengthen) > 0 then
		if not pg.equip_data_template[self.id] or not pg.equip_data_template[self.id].next or pg.equip_data_template[self.id].next == 0 then
			return false
		end
	end

	if bit.band(arg_19_1, IndexConst.EquipmentExtraTransform) > 0 then
		local var_19_0 = EquipmentProxy.EquipTransformTargetDict[Equipment.GetEquipRootStatic(self.id)]

		if not var_19_0 or not var_19_0.targets then
			return false
		end
	end

	return true
end

IndexConst.DisplayEquipSkinSort = 6
IndexConst.DisplayEquipSkinIndex = 7
IndexConst.DisplayEquipSkinTheme = 8
IndexConst.EquipSkinSortType = 1
IndexConst.EquipSkinSortTypes = {
	IndexConst.EquipSkinSortType
}
IndexConst.EquipSkinSortNames = {
	i18n("word_equipskin_type")
}
IndexConst.EquipSkinIndexAll = 1
IndexConst.EquipSkinIndexCannon = 2
IndexConst.EquipSkinIndexTarpedo = 3
IndexConst.EquipSkinIndexAircraft = 4
IndexConst.EquipSkinIndexAux = 5
IndexConst.EquipSkinIndexTypes = {
	IndexConst.EquipSkinIndexAll,
	IndexConst.EquipSkinIndexCannon,
	IndexConst.EquipSkinIndexTarpedo,
	IndexConst.EquipSkinIndexAircraft,
	IndexConst.EquipSkinIndexAux
}
IndexConst.EquipSkinIndexNames = {
	i18n("word_equipskin_all"),
	i18n("word_equipskin_cannon"),
	i18n("word_equipskin_tarpedo"),
	i18n("word_equipskin_aircraft"),
	i18n("word_equipskin_aux")
}
IndexConst.EquipSkinThemeAll = 1
IndexConst.EquipSkinThemeEnd = nil
IndexConst.EquipSkinThemeTypes = {
	IndexConst.EquipSkinThemeAll
}

for iter_0_0, iter_0_1 in ipairs(pg.equip_skin_theme_template.all) do
	table.insert(IndexConst.EquipSkinThemeTypes, iter_0_0 + IndexConst.EquipSkinThemeAll)

	if iter_0_0 == #pg.equip_skin_theme_template.all then
		IndexConst.EquipSkinThemeEnd = iter_0_0 + IndexConst.EquipSkinThemeAll + 1
	end
end

IndexConst.EquipSkinThemeNames = {
	i18n("word_equipskin_all")
}

for iter_0_2, iter_0_3 in ipairs(pg.equip_skin_theme_template.all) do
	table.insert(IndexConst.EquipSkinThemeNames, pg.equip_skin_theme_template[iter_0_3].name)
end

function IndexConst:filterEquipSkinByIndex(arg_20_1)
	if not arg_20_1 then
		return true
	end

	if bit.band(arg_20_1, bit.lshift(1, IndexConst.EquipSkinIndexAll)) > 0 then
		return true
	end

	local var_20_0 = {}
	local var_20_1 = {
		1,
		2,
		3,
		4,
		5
	}

	for iter_20_0, iter_20_1 in ipairs(IndexConst.EquipSkinIndexTypes) do
		if bit.band(arg_20_1, bit.lshift(1, iter_20_1)) > 0 then
			for iter_20_2, iter_20_3 in ipairs(EquipmentSortCfg.skinIndex[var_20_1[iter_20_1]].types) do
				table.insert(var_20_0, iter_20_3)
			end
		end
	end

	if self.count > 0 and self.isSkin then
		for iter_20_4, iter_20_5 in pairs(pg.equip_skin_template[self.id].equip_type) do
			if table.contains(var_20_0, iter_20_5) then
				return true
			end
		end
	end

	return
end

function IndexConst:filterEquipSkinByTheme(arg_21_1)
	if not arg_21_1 then
		return true
	end

	if string.find(IndexConst.StrAnd(arg_21_1, IndexConst.StrLShift("1", IndexConst.EquipSkinThemeAll)), "1") ~= nil then
		return true
	end

	if self.count > 0 and self.isSkin then
		for iter_21_0, iter_21_1 in ipairs(IndexConst.EquipSkinThemeTypes) do
			if string.find(IndexConst.StrAnd(arg_21_1, IndexConst.StrLShift("1", iter_21_0)), "1") ~= nil and table.contains(pg.equip_skin_theme_template[pg.equip_skin_theme_template[pg.equip_skin_theme_template.all[iter_21_1 - 1]].id].ids, self.id) then
				return true
			end
		end
	end

	return
end

IndexConst.SpWeaponTypeQvZhu = bit.lshift(1, 0)
IndexConst.SpWeaponTypeQingXvn = bit.lshift(1, 1)
IndexConst.SpWeaponTypeZhongXvn = bit.lshift(1, 2)
IndexConst.SpWeaponTypeZhanLie = bit.lshift(1, 3)
IndexConst.SpWeaponTypeHangMu = bit.lshift(1, 4)
IndexConst.SpWeaponTypeWeiXiu = bit.lshift(1, 5)
IndexConst.SpWeaponTypeQianTing = bit.lshift(1, 6)
IndexConst.SpWeaponTypeQiTa = bit.lshift(1, 7)
IndexConst.SpWeaponTypeIndexs = {
	IndexConst.SpWeaponTypeQvZhu,
	IndexConst.SpWeaponTypeQingXvn,
	IndexConst.SpWeaponTypeZhongXvn,
	IndexConst.SpWeaponTypeZhanLie,
	IndexConst.SpWeaponTypeHangMu,
	IndexConst.SpWeaponTypeWeiXiu,
	IndexConst.SpWeaponTypeQianTing,
	IndexConst.SpWeaponTypeQiTa
}
IndexConst.SpWeaponTypeAll = IndexConst.BitAll(IndexConst.SpWeaponTypeIndexs)

table.insert(IndexConst.SpWeaponTypeIndexs, 1, IndexConst.SpWeaponTypeAll)

function IndexConst:filterSpWeaponByType(arg_22_1)
	if not arg_22_1 or arg_22_1 == IndexConst.SpWeaponTypeAll then
		return true
	end

	local var_22_0 = self:GetWearableShipTypes()

	for iter_22_0 = 0, #IndexConst.SpWeaponTypeIndexs - 2 do
		if bit.band(bit.lshift(1, iter_22_0), arg_22_1) > 0 and _.any(ShipIndexCfg.type[4 + iter_22_0].types, function(arg_23_0)
			return table.contains(var_22_0, arg_23_0)
		end) then
			return true
		end
	end

	return false
end

IndexConst.SpWeaponTypeNames = {
	"word_equipment_all",
	"spweapon_ui_index_shipType_quZhu",
	"spweapon_ui_index_shipType_qinXun",
	"spweapon_ui_index_shipType_zhongXun",
	"spweapon_ui_index_shipType_zhanLie",
	"spweapon_ui_index_shipType_hangMu",
	"spweapon_ui_index_shipType_weiXiu",
	"spweapon_ui_index_shipType_qianTing",
	"spweapon_ui_index_shipType_other"
}
IndexConst.SpWeaponRarityNames = {
	"index_all",
	"index_rare3",
	"index_rare4",
	"index_rare5"
}
IndexConst.SpWeaponRarity1 = bit.lshift(1, 0)
IndexConst.SpWeaponRarity2 = bit.lshift(1, 1)
IndexConst.SpWeaponRarity3 = bit.lshift(1, 2)
IndexConst.SpWeaponRarityIndexs = {
	IndexConst.SpWeaponRarity1,
	IndexConst.SpWeaponRarity2,
	IndexConst.SpWeaponRarity3
}
IndexConst.SpWeaponRarityAll = IndexConst.BitAll(IndexConst.SpWeaponRarityIndexs)

table.insert(IndexConst.SpWeaponRarityIndexs, 1, IndexConst.SpWeaponRarityAll)

function IndexConst:filterSpWeaponByRarity(arg_24_1)
	if not arg_24_1 or arg_24_1 == IndexConst.SpWeaponRarityAll then
		return true
	end

	return bit.band(bit.lshift(1, (math.max(self:GetRarity() - 2, 0))), arg_24_1) > 0
end

IndexConst.LABEL_COUNT = 9
IndexConst.ECodeLabelNames = {}
IndexConst.ECodeLabelIndexs = {}

for iter_0_4 = 1, IndexConst.LABEL_COUNT do
	local var_0_1 = bit.lshift(1, iter_0_4 - 1)

	table.insert(IndexConst.ECodeLabelNames, "equip_share_label_" .. iter_0_4)
	table.insert(IndexConst.ECodeLabelIndexs, var_0_1)
end

local var_0_2 = IndexConst.BitAll(IndexConst.ECodeLabelIndexs)

table.insert(IndexConst.ECodeLabelNames, 1, "index_all")
table.insert(IndexConst.ECodeLabelIndexs, 1, var_0_2)

function IndexConst:filterEquipCodeByLable(arg_25_1)
	if not arg_25_1 or arg_25_1 == var_0_2 then
		return true
	end

	for iter_25_0, iter_25_1 in ipairs(self:GetLabels()) do
		if bit.band(bit.lshift(1, iter_25_1 - 1), arg_25_1) > 0 then
			return true
		end
	end

	return false
end

return IndexConst
