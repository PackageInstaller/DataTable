local var_0_0 = class("IndexConst")

function var_0_0.Flags2Bits(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		var_1_0 = bit.bor(var_1_0, bit.lshift(1, iter_1_1))
	end

	return var_1_0
end

function var_0_0.FlagRange2Bits(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = arg_2_0, arg_2_1 do
		var_2_0 = bit.bor(var_2_0, bit.lshift(1, iter_2_0))
	end

	return var_2_0
end

function var_0_0.ToggleBits(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0
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
				local var_4_0 = arg_4_1 ~= arg_3_2 and bit.lshift(1, arg_4_1) or 0

				return arg_4_0 + var_4_0
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

function var_0_0.SingleToggleBits(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_1 = bit.lshift(1, arg_5_3)

	return arg_5_0 == var_5_1 and bit.lshift(1, arg_5_2) or var_5_1
end

function var_0_0.StrLShift(arg_6_0, arg_6_1)
	for iter_6_0 = 1, arg_6_1 do
		arg_6_0 = arg_6_0 .. "0"
	end

	return arg_6_0 .. ""
end

function var_0_0.StrAnd(arg_7_0, arg_7_1)
	local var_7_0 = ""
	local var_7_1 = string.len(arg_7_0) > string.len(arg_7_1) and arg_7_0 or arg_7_1
	local var_7_2 = var_7_1 == arg_7_0 and arg_7_1 or arg_7_0
	local var_7_3 = string.len(var_7_1)
	local var_7_4 = string.len(var_7_1 == arg_7_0 and arg_7_1 or arg_7_0)

	for iter_7_0 = 1, var_7_4 do
		var_7_0 = string.sub(var_7_2, iter_7_0, iter_7_0) == "1" and string.sub(var_7_1, var_7_3 - var_7_4 + iter_7_0, var_7_3 - var_7_4 + iter_7_0) == "1" and var_7_0 .. "1" or var_7_0 .. "0"
	end

	local var_7_5 = ""

	for iter_7_1 = 1, var_7_3 - var_7_4 do
		var_7_5 = var_7_5 .. "0"
	end

	return var_7_5 .. var_7_0
end

function var_0_0.StrOr(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = string.len(arg_8_0) > string.len(arg_8_1) and arg_8_0 or arg_8_1
	local var_8_2 = var_8_1 == arg_8_0 and arg_8_1 or arg_8_0
	local var_8_3 = string.len(var_8_1)
	local var_8_4 = string.len(var_8_1 == arg_8_0 and arg_8_1 or arg_8_0)

	for iter_8_0 = 1, var_8_4 do
		var_8_0 = (string.sub(var_8_2, iter_8_0, iter_8_0) == "1" or string.sub(var_8_1, var_8_3 - var_8_4 + iter_8_0, var_8_3 - var_8_4 + iter_8_0) == "1") and var_8_0 .. "1" or var_8_0 .. "0"
	end

	return string.sub(var_8_1, 1, var_8_3 - var_8_4) .. var_8_0
end

function var_0_0.Flags2Str(arg_9_0)
	local var_9_0 = ""

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		var_9_0 = var_0_0.StrOr(var_9_0, var_0_0.StrLShift("1", iter_9_1))
	end

	return var_9_0
end

function var_0_0.FlagRange2Str(arg_10_0, arg_10_1)
	local var_10_0 = ""

	for iter_10_0 = arg_10_0, arg_10_1 do
		var_10_0 = var_0_0.StrOr(var_10_0, var_0_0.StrLShift("1", iter_10_0))
	end

	return var_10_0
end

function var_0_0.ToggleStr(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0
	local var_11_1 = var_0_0.StrLShift("1", arg_11_3)

	if arg_11_2 then
		local var_11_2 = var_0_0.StrLShift("1", arg_11_2)
		local var_11_3 = ""

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			if iter_11_1 ~= arg_11_2 then
				var_11_3 = var_0_0.StrOr(var_11_3, var_0_0.StrLShift("1", iter_11_1))
			end
		end

		if var_11_1 == var_11_2 or var_11_0 == var_11_3 then
			var_11_0 = var_11_2
		else
			if string.find(var_0_0.StrAnd(var_11_0, var_11_2), "1") ~= nil then
				var_11_0 = var_11_1
			else
				local var_11_4 = var_0_0.StrOr(var_11_0, var_11_1)
				local var_11_5 = string.len(var_11_4) - arg_11_3

				var_11_0 = string.sub(var_11_4, 1, var_11_5 - 1) .. (string.find(var_0_0.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1") .. string.sub(var_11_4, var_11_5 + 1)
			end

			if var_11_0 == var_11_3 or string.find(var_11_0, "1") == nil then
				var_11_0 = var_11_2
			end
		end
	else
		local var_11_6 = var_0_0.StrOr(var_11_0, var_11_1)
		local var_11_7 = string.len(var_11_6) - arg_11_3

		var_11_0 = string.sub(var_11_6, 1, var_11_7 - 1) .. (string.find(var_0_0.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1") .. string.sub(var_11_6, var_11_7 + 1)
	end

	return var_11_0
end

function var_0_0.BitAll(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		var_12_0 = bit.bor(iter_12_1, var_12_0)
	end

	return var_12_0
end

var_0_0.EquipmentTypeSmallCannon = bit.lshift(1, 0)
var_0_0.EquipmentTypeMediumCannon = bit.lshift(1, 1)
var_0_0.EquipmentTypeBigCannon = bit.lshift(1, 2)
var_0_0.EquipmentTypeWarshipTorpedo = bit.lshift(1, 3)
var_0_0.EquipmentTypeSubmaraineTorpedo = bit.lshift(1, 4)
var_0_0.EquipmentTypeAntiAircraft = bit.lshift(1, 5)
var_0_0.EquipmentTypeFighter = bit.lshift(1, 6)
var_0_0.EquipmentTypeBomber = bit.lshift(1, 7)
var_0_0.EquipmentTypeTorpedoBomber = bit.lshift(1, 8)
var_0_0.EquipmentTypeEquip = bit.lshift(1, 9)
var_0_0.EquipmentTypeOther = bit.lshift(1, 10)
var_0_0.EquipmentTypeIndexs = {
	var_0_0.EquipmentTypeSmallCannon,
	var_0_0.EquipmentTypeMediumCannon,
	var_0_0.EquipmentTypeBigCannon,
	var_0_0.EquipmentTypeWarshipTorpedo,
	var_0_0.EquipmentTypeSubmaraineTorpedo,
	var_0_0.EquipmentTypeAntiAircraft,
	var_0_0.EquipmentTypeFighter,
	var_0_0.EquipmentTypeBomber,
	var_0_0.EquipmentTypeTorpedoBomber,
	var_0_0.EquipmentTypeEquip,
	var_0_0.EquipmentTypeOther
}
var_0_0.EquipmentTypeAll = var_0_0.BitAll(var_0_0.EquipmentTypeIndexs)

table.insert(var_0_0.EquipmentTypeIndexs, 1, var_0_0.EquipmentTypeAll)

function var_0_0.filterEquipByType(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_1 == var_0_0.EquipmentTypeAll then
		return true
	end

	for iter_13_0 = 2, #EquipmentSortCfg.index do
		if bit.band(bit.lshift(1, iter_13_0 - 2), arg_13_1) > 0 and table.contains(EquipmentSortCfg.index[iter_13_0].types, arg_13_0:getConfig("type")) then
			return true
		end
	end

	return false
end

var_0_0.EquipmentTypeNames = {
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
var_0_0.EquipCampUS = bit.lshift(1, 0)
var_0_0.EquipCampEN = bit.lshift(1, 1)
var_0_0.EquipCampJP = bit.lshift(1, 2)
var_0_0.EquipCampDE = bit.lshift(1, 3)
var_0_0.EquipCampCN = bit.lshift(1, 4)
var_0_0.EquipCampITA = bit.lshift(1, 5)
var_0_0.EquipCampSN = bit.lshift(1, 6)
var_0_0.EquipCampFR = bit.lshift(1, 7)
var_0_0.EquipCampMNF = bit.lshift(1, 8)
var_0_0.EquipCampMOT = bit.lshift(1, 9)
var_0_0.EquipCampLINK = bit.lshift(1, 10)
var_0_0.EquipCampOther = bit.lshift(1, 11)
var_0_0.EquipCampIndexs = {
	var_0_0.EquipCampUS,
	var_0_0.EquipCampEN,
	var_0_0.EquipCampJP,
	var_0_0.EquipCampDE,
	var_0_0.EquipCampCN,
	var_0_0.EquipCampITA,
	var_0_0.EquipCampSN,
	var_0_0.EquipCampFR,
	var_0_0.EquipCampMNF,
	var_0_0.EquipCampMOT,
	var_0_0.EquipCampLINK,
	var_0_0.EquipCampOther
}
var_0_0.EquipCampNames = {
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
var_0_0.EquipCampAll = var_0_0.BitAll(var_0_0.EquipCampIndexs)

table.insert(var_0_0.EquipCampIndexs, 1, var_0_0.EquipCampAll)

function var_0_0.filterEquipByCamp(arg_14_0, arg_14_1)
	if not arg_14_1 or arg_14_1 == var_0_0.EquipmentTypeAll then
		return true
	end

	for iter_14_0 = 2, #EquipmentSortCfg.campIndex do
		if bit.band(bit.lshift(1, iter_14_0 - 2), arg_14_1) > 0 then
			for iter_14_1, iter_14_2 in ipairs(EquipmentSortCfg.campIndex[iter_14_0].types) do
				if iter_14_2 == Nation.LINK then
					if arg_14_0:getNation() >= Nation.LINK then
						return true
					end
				elseif iter_14_2 == arg_14_0:getNation() then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.EquipProperty_Cannon = bit.lshift(1, 0)
var_0_0.EquipProperty_Air = bit.lshift(1, 1)
var_0_0.EquipProperty_Dodge = bit.lshift(1, 2)
var_0_0.EquipProperty_AntiAircraft = bit.lshift(1, 3)
var_0_0.EquipProperty_Torpedo = bit.lshift(1, 4)
var_0_0.EquipProperty_Reload = bit.lshift(1, 5)
var_0_0.EquipProperty_Durability = bit.lshift(1, 6)
var_0_0.EquipProperty_Antisub = bit.lshift(1, 7)
var_0_0.EquipProperty_Oxy = bit.lshift(1, 8)
var_0_0.EquipProperty_Speed = bit.lshift(1, 9)
var_0_0.EquipProperty_Hit = bit.lshift(1, 10)
var_0_0.EquipProperty_Luck = bit.lshift(1, 11)
var_0_0.EquipPropertyIndexs = {
	var_0_0.EquipProperty_Cannon,
	var_0_0.EquipProperty_Air,
	var_0_0.EquipProperty_Dodge,
	var_0_0.EquipProperty_AntiAircraft,
	var_0_0.EquipProperty_Torpedo,
	var_0_0.EquipProperty_Reload,
	var_0_0.EquipProperty_Durability,
	var_0_0.EquipProperty_Antisub,
	var_0_0.EquipProperty_Oxy,
	var_0_0.EquipProperty_Speed,
	var_0_0.EquipProperty_Hit,
	var_0_0.EquipProperty_Luck
}
var_0_0.EquipPropertyAll = var_0_0.BitAll(var_0_0.EquipPropertyIndexs)

table.insert(var_0_0.EquipPropertyIndexs, 1, var_0_0.EquipPropertyAll)

var_0_0.EquipPropertyNames = {
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

function var_0_0.filterEquipByProperty(arg_15_0, arg_15_1)
	if arg_15_0:getConfig("attribute_1") then
		table.insert({}, arg_15_0:getConfig("attribute_1"))
	end

	if arg_15_0:getConfig("attribute_2") then
		table.insert({}, arg_15_0:getConfig("attribute_2"))
	end

	if arg_15_0:getConfig("attribute_3") then
		table.insert({}, arg_15_0:getConfig("attribute_3"))
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if not iter_15_1 or iter_15_1 == var_0_0.EquipPropertyAll then
			var_15_0 = var_15_0 + 1
		else
			for iter_15_2 = 2, #EquipmentSortCfg.propertyIndex do
				if bit.band(bit.lshift(1, iter_15_2 - 2), iter_15_1) > 0 then
					for iter_15_3 = #{}, 1, -1 do
						if table.contains(EquipmentSortCfg.propertyIndex[iter_15_2].types, ({})[iter_15_3]) then
							var_15_0 = var_15_0 + 1

							table.remove({}, iter_15_3)

							break
						end
					end
				end
			end
		end
	end

	return var_15_0 >= #arg_15_1
end

var_0_0.EquipAmmoChuanjia = bit.lshift(1, 0)
var_0_0.EquipAmmoGaobao = bit.lshift(1, 1)
var_0_0.EquipAmmoTongchangDan = bit.lshift(1, 2)
var_0_0.EquipAmmoQita = bit.lshift(1, 3)
var_0_0.EquipAmmoIndexs_1 = {
	var_0_0.EquipAmmoChuanjia,
	var_0_0.EquipAmmoGaobao,
	var_0_0.EquipAmmoTongchangDan,
	var_0_0.EquipAmmoQita
}
var_0_0.EquipAmmoAll_1 = var_0_0.BitAll(var_0_0.EquipAmmoIndexs_1)

table.insert(var_0_0.EquipAmmoIndexs_1, 1, var_0_0.EquipAmmoAll_1)

var_0_0.EquipAmmoIndexs_1_Names = {
	"attribute_ammo",
	"equip_ammo_type_1",
	"equip_ammo_type_2",
	"equip_ammo_type_3",
	"word_shipType_other"
}

function var_0_0.filterEquipAmmo1(arg_16_0, arg_16_1)
	if not arg_16_1 or arg_16_1 == var_0_0.EquipAmmoAll_1 then
		return true
	end

	for iter_16_0 = 2, #EquipmentSortCfg.ammoIndex1 do
		if bit.band(bit.lshift(1, iter_16_0 - 2), arg_16_1) > 0 and table.contains(EquipmentSortCfg.ammoIndex1[iter_16_0].types, arg_16_0:getConfig("ammo")) then
			return true
		end
	end

	return false
end

var_0_0.EquipAmmoShengdao = bit.lshift(1, 0)
var_0_0.EquipAmmoTongchang = bit.lshift(1, 1)
var_0_0.EquipAmmoIndexs_2 = {
	var_0_0.EquipAmmoShengdao,
	var_0_0.EquipAmmoTongchang
}
var_0_0.EquipAmmoAll_2 = var_0_0.BitAll(var_0_0.EquipAmmoIndexs_2)

table.insert(var_0_0.EquipAmmoIndexs_2, 1, var_0_0.EquipAmmoAll_2)

var_0_0.EquipAmmoIndexs_2_Names = {
	"attribute_ammo",
	"equip_ammo_type_4",
	"equip_ammo_type_5"
}

function var_0_0.filterEquipAmmo2(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == var_0_0.EquipAmmoAll_2 then
		return true
	end

	for iter_17_0 = 2, #EquipmentSortCfg.ammoIndex2 do
		if bit.band(bit.lshift(1, iter_17_0 - 2), arg_17_1) > 0 and table.contains(EquipmentSortCfg.ammoIndex2[iter_17_0].types, arg_17_0:getConfig("ammo")) then
			return true
		end
	end

	return false
end

var_0_0.EquipmentRarity1 = bit.lshift(1, 0)
var_0_0.EquipmentRarity2 = bit.lshift(1, 1)
var_0_0.EquipmentRarity3 = bit.lshift(1, 2)
var_0_0.EquipmentRarity4 = bit.lshift(1, 3)
var_0_0.EquipmentRarity5 = bit.lshift(1, 4)
var_0_0.EquipmentRarityIndexs = {
	var_0_0.EquipmentRarity1,
	var_0_0.EquipmentRarity2,
	var_0_0.EquipmentRarity3,
	var_0_0.EquipmentRarity4,
	var_0_0.EquipmentRarity5
}
var_0_0.EquipmentRarityAll = var_0_0.BitAll(var_0_0.EquipmentRarityIndexs)

table.insert(var_0_0.EquipmentRarityIndexs, 1, var_0_0.EquipmentRarityAll)

var_0_0.RarityNames = {
	"index_all",
	"index_rare2",
	"index_rare3",
	"index_rare4",
	"index_rare5",
	"index_rare6"
}

function var_0_0.filterEquipByRarity(arg_18_0, arg_18_1)
	if not arg_18_1 or arg_18_1 == var_0_0.EquipmentRarityAll then
		return true
	end

	local var_18_0 = bit.band(bit.lshift(1, (math.max(arg_18_0:getConfig("rarity") - 2, 0))), arg_18_1)

	return var_18_0 > 0
end

var_0_0.EquipmentExtraNames = {
	"index_without_limit",
	"index_equip",
	"index_strengthen",
	"index_reform"
}
var_0_0.EquipmentExtraEquiping = bit.lshift(1, 0)
var_0_0.EquipmentExtraStrengthen = bit.lshift(1, 1)
var_0_0.EquipmentExtraTransform = bit.lshift(1, 2)
var_0_0.EquipmentExtraIndexs = {
	var_0_0.EquipmentExtraEquiping,
	var_0_0.EquipmentExtraStrengthen,
	var_0_0.EquipmentExtraTransform
}
var_0_0.EquipmentExtraNone = 0

table.insert(var_0_0.EquipmentExtraIndexs, 1, var_0_0.EquipmentExtraNone)

function var_0_0.filterEquipByExtra(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or 0

	if bit.band(arg_19_1, var_0_0.EquipmentExtraEquiping) > 0 and not arg_19_0.shipId then
		return false
	end

	if bit.band(arg_19_1, var_0_0.EquipmentExtraStrengthen) > 0 then
		if not pg.equip_data_template[arg_19_0.id] or not pg.equip_data_template[arg_19_0.id].next or pg.equip_data_template[arg_19_0.id].next == 0 then
			return false
		end
	end

	if bit.band(arg_19_1, var_0_0.EquipmentExtraTransform) > 0 then
		local var_19_0 = EquipmentProxy.EquipTransformTargetDict[Equipment.GetEquipRootStatic(arg_19_0.id)]

		if not var_19_0 or not var_19_0.targets then
			return false
		end
	end

	return true
end

var_0_0.DisplayEquipSkinSort = 6
var_0_0.DisplayEquipSkinIndex = 7
var_0_0.DisplayEquipSkinTheme = 8
var_0_0.EquipSkinSortType = 1
var_0_0.EquipSkinSortTypes = {
	var_0_0.EquipSkinSortType
}
var_0_0.EquipSkinSortNames = {
	i18n("word_equipskin_type")
}
var_0_0.EquipSkinIndexAll = 1
var_0_0.EquipSkinIndexCannon = 2
var_0_0.EquipSkinIndexTarpedo = 3
var_0_0.EquipSkinIndexAircraft = 4
var_0_0.EquipSkinIndexAux = 5
var_0_0.EquipSkinIndexTypes = {
	var_0_0.EquipSkinIndexAll,
	var_0_0.EquipSkinIndexCannon,
	var_0_0.EquipSkinIndexTarpedo,
	var_0_0.EquipSkinIndexAircraft,
	var_0_0.EquipSkinIndexAux
}
var_0_0.EquipSkinIndexNames = {
	i18n("word_equipskin_all"),
	i18n("word_equipskin_cannon"),
	i18n("word_equipskin_tarpedo"),
	i18n("word_equipskin_aircraft"),
	i18n("word_equipskin_aux")
}
var_0_0.EquipSkinThemeAll = 1
var_0_0.EquipSkinThemeEnd = nil
var_0_0.EquipSkinThemeTypes = {
	var_0_0.EquipSkinThemeAll
}

for iter_0_0, iter_0_1 in ipairs(pg.equip_skin_theme_template.all) do
	table.insert(var_0_0.EquipSkinThemeTypes, iter_0_0 + var_0_0.EquipSkinThemeAll)

	if iter_0_0 == #pg.equip_skin_theme_template.all then
		var_0_0.EquipSkinThemeEnd = iter_0_0 + var_0_0.EquipSkinThemeAll + 1
	end
end

var_0_0.EquipSkinThemeNames = {
	i18n("word_equipskin_all")
}

for iter_0_2, iter_0_3 in ipairs(pg.equip_skin_theme_template.all) do
	table.insert(var_0_0.EquipSkinThemeNames, pg.equip_skin_theme_template[iter_0_3].name)
end

function var_0_0.filterEquipSkinByIndex(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return true
	end

	if bit.band(arg_20_1, bit.lshift(1, var_0_0.EquipSkinIndexAll)) > 0 then
		return true
	end

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(var_0_0.EquipSkinIndexTypes) do
		if bit.band(arg_20_1, bit.lshift(1, iter_20_1)) > 0 then
			for iter_20_2, iter_20_3 in ipairs(EquipmentSortCfg.skinIndex[({
				1,
				2,
				3,
				4,
				5
			})[iter_20_1]].types) do
				table.insert(var_20_0, iter_20_3)
			end
		end
	end

	if arg_20_0.count > 0 and arg_20_0.isSkin then
		for iter_20_4, iter_20_5 in pairs(pg.equip_skin_template[arg_20_0.id].equip_type) do
			if table.contains(var_20_0, iter_20_5) then
				return true
			end
		end
	end

	return
end

function var_0_0.filterEquipSkinByTheme(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return true
	end

	if string.find(var_0_0.StrAnd(arg_21_1, var_0_0.StrLShift("1", var_0_0.EquipSkinThemeAll)), "1") ~= nil then
		return true
	end

	if arg_21_0.count > 0 and arg_21_0.isSkin then
		for iter_21_0, iter_21_1 in ipairs(var_0_0.EquipSkinThemeTypes) do
			if string.find(var_0_0.StrAnd(arg_21_1, var_0_0.StrLShift("1", iter_21_0)), "1") ~= nil and table.contains(pg.equip_skin_theme_template[pg.equip_skin_theme_template[pg.equip_skin_theme_template.all[iter_21_1 - 1]].id].ids, arg_21_0.id) then
				return true
			end
		end
	end

	return
end

var_0_0.SpWeaponTypeQvZhu = bit.lshift(1, 0)
var_0_0.SpWeaponTypeQingXvn = bit.lshift(1, 1)
var_0_0.SpWeaponTypeZhongXvn = bit.lshift(1, 2)
var_0_0.SpWeaponTypeZhanLie = bit.lshift(1, 3)
var_0_0.SpWeaponTypeHangMu = bit.lshift(1, 4)
var_0_0.SpWeaponTypeWeiXiu = bit.lshift(1, 5)
var_0_0.SpWeaponTypeQianTing = bit.lshift(1, 6)
var_0_0.SpWeaponTypeQiTa = bit.lshift(1, 7)
var_0_0.SpWeaponTypeIndexs = {
	var_0_0.SpWeaponTypeQvZhu,
	var_0_0.SpWeaponTypeQingXvn,
	var_0_0.SpWeaponTypeZhongXvn,
	var_0_0.SpWeaponTypeZhanLie,
	var_0_0.SpWeaponTypeHangMu,
	var_0_0.SpWeaponTypeWeiXiu,
	var_0_0.SpWeaponTypeQianTing,
	var_0_0.SpWeaponTypeQiTa
}
var_0_0.SpWeaponTypeAll = var_0_0.BitAll(var_0_0.SpWeaponTypeIndexs)

table.insert(var_0_0.SpWeaponTypeIndexs, 1, var_0_0.SpWeaponTypeAll)

function var_0_0.filterSpWeaponByType(arg_22_0, arg_22_1)
	if not arg_22_1 or arg_22_1 == var_0_0.SpWeaponTypeAll then
		return true
	end

	local var_22_0 = arg_22_0:GetWearableShipTypes()

	for iter_22_0 = 0, #var_0_0.SpWeaponTypeIndexs - 2 do
		if bit.band(bit.lshift(1, iter_22_0), arg_22_1) > 0 and _.any(ShipIndexCfg.type[4 + iter_22_0].types, function(arg_23_0)
			return table.contains(var_22_0, arg_23_0)
		end) then
			return true
		end
	end

	return false
end

var_0_0.SpWeaponTypeNames = {
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
var_0_0.SpWeaponRarityNames = {
	"index_all",
	"index_rare3",
	"index_rare4",
	"index_rare5"
}
var_0_0.SpWeaponRarity1 = bit.lshift(1, 0)
var_0_0.SpWeaponRarity2 = bit.lshift(1, 1)
var_0_0.SpWeaponRarity3 = bit.lshift(1, 2)
var_0_0.SpWeaponRarityIndexs = {
	var_0_0.SpWeaponRarity1,
	var_0_0.SpWeaponRarity2,
	var_0_0.SpWeaponRarity3
}
var_0_0.SpWeaponRarityAll = var_0_0.BitAll(var_0_0.SpWeaponRarityIndexs)

table.insert(var_0_0.SpWeaponRarityIndexs, 1, var_0_0.SpWeaponRarityAll)

function var_0_0.filterSpWeaponByRarity(arg_24_0, arg_24_1)
	if not arg_24_1 or arg_24_1 == var_0_0.SpWeaponRarityAll then
		return true
	end

	local var_24_0 = bit.band(bit.lshift(1, (math.max(arg_24_0:GetRarity() - 2, 0))), arg_24_1)

	return var_24_0 > 0
end

var_0_0.LABEL_COUNT = 9
var_0_0.ECodeLabelNames = {}
var_0_0.ECodeLabelIndexs = {}

for iter_0_4 = 1, var_0_0.LABEL_COUNT do
	local var_0_1 = bit.lshift(1, iter_0_4 - 1)

	table.insert(var_0_0.ECodeLabelNames, "equip_share_label_" .. iter_0_4)
	table.insert(var_0_0.ECodeLabelIndexs, var_0_1)
end

local var_0_2 = var_0_0.BitAll(var_0_0.ECodeLabelIndexs)

table.insert(var_0_0.ECodeLabelNames, 1, "index_all")
table.insert(var_0_0.ECodeLabelIndexs, 1, (var_0_0.BitAll(var_0_0.ECodeLabelIndexs)))

function var_0_0.filterEquipCodeByLable(arg_25_0, arg_25_1)
	if not arg_25_1 or arg_25_1 == var_0_2 then
		return true
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0:GetLabels()) do
		if bit.band(bit.lshift(1, iter_25_1 - 1), arg_25_1) > 0 then
			return true
		end
	end

	return false
end

return var_0_0
