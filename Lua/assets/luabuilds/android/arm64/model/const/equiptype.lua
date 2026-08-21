local var_0_0 = class("EquipType")

var_0_0.CannonQuZhu = 1
var_0_0.CannonQingXun = 2
var_0_0.CannonZhongXun = 3
var_0_0.CannonZhanlie = 4
var_0_0.Torpedo = 5
var_0_0.AntiAircraft = 6
var_0_0.FighterAircraft = 7
var_0_0.TorpedoAircraft = 8
var_0_0.BomberAircraft = 9
var_0_0.Equipment = 10
var_0_0.CannonZhongXun2 = 11
var_0_0.SeaPlane = 12
var_0_0.SubmarineTorpedo = 13
var_0_0.Sonar = 14
var_0_0.AntiSubAircraft = 15
var_0_0.Helicopter = 17
var_0_0.Goods = 18
var_0_0.Missile = 20
var_0_0.RangedAntiAircraft = 21
var_0_0.AmmoType_1 = 1
var_0_0.AmmoType_2 = 2
var_0_0.AmmoType_3 = 3
var_0_0.AmmoType_4 = 4
var_0_0.AmmoType_5 = 5
var_0_0.AmmoType_6 = 6
var_0_0.AmmoType_7 = 7
var_0_0.AmmoType_8 = 8
var_0_0.AmmoType_8 = 9
var_0_0.AmmoType_8 = 10
var_0_0.CannonEquipTypes = {
	var_0_0.CannonQuZhu,
	var_0_0.CannonQingXun,
	var_0_0.CannonZhongXun,
	var_0_0.CannonZhanlie,
	var_0_0.CannonZhongXun2
}
var_0_0.AirProtoEquipTypes = {
	var_0_0.FighterAircraft,
	var_0_0.TorpedoAircraft,
	var_0_0.BomberAircraft
}
var_0_0.AirEquipTypes = {
	var_0_0.FighterAircraft,
	var_0_0.TorpedoAircraft,
	var_0_0.BomberAircraft,
	var_0_0.SeaPlane
}
var_0_0.AirExtendEquipTypes = {
	var_0_0.FighterAircraft,
	var_0_0.TorpedoAircraft,
	var_0_0.BomberAircraft,
	var_0_0.SeaPlane,
	var_0_0.AntiSubAircraft,
	var_0_0.Helicopter
}
var_0_0.AirDomainEquip = {
	var_0_0.FighterAircraft,
	var_0_0.TorpedoAircraft,
	var_0_0.BomberAircraft,
	var_0_0.SeaPlane
}
var_0_0.TorpedoEquipTypes = {
	var_0_0.Torpedo,
	var_0_0.SubmarineTorpedo
}
var_0_0.DeviceEquipTypes = {
	var_0_0.Equipment,
	var_0_0.AntiSubAircraft,
	var_0_0.Sonar,
	var_0_0.Helicopter,
	var_0_0.Goods
}
var_0_0.AircraftSkinType = {
	var_0_0.FighterAircraft,
	var_0_0.TorpedoAircraft,
	var_0_0.BomberAircraft,
	var_0_0.SeaPlane,
	var_0_0.AntiSubAircraft
}

local var_0_1 = {
	i18n("word_primary_weapons"),
	i18n("word_sub_cannons"),
	i18n("word_torpedo"),
	i18n("word_air_defense_artillery"),
	i18n("word_shipboard_aircraft"),
	i18n("word_device"),
	i18n("word_submarine_torpedo"),
	i18n("wrod_sub_weapons"),
	i18n("word_main_cannons"),
	i18n("word_cannon"),
	i18n("word_equipment_aircraft"),
	i18n("word_fighter"),
	i18n("word_bomber"),
	i18n("word_attacker"),
	i18n("word_seaplane"),
	i18n("word_equipment"),
	i18n("word_missile")
}
local var_0_2 = {
	"cannon",
	"cannon",
	"cannon",
	"cannon",
	"torpedo",
	"antiair",
	"fighter",
	"attacker",
	"bomber",
	"equipment",
	"cannon",
	"seaplane",
	"torpedo",
	"equipment",
	"equipment",
	nil,
	"equipment",
	"equipment",
	nil,
	"missile",
	"antiair"
}

function var_0_0.Type2Name(arg_1_0)
	return pg.equip_data_by_type[arg_1_0].type_name
end

function var_0_0.Type2Name2(arg_2_0)
	return pg.equip_data_by_type[arg_2_0].type_name2
end

function var_0_0.type2Tag(arg_3_0)
	var_0_0.tagPrints = var_0_0.tagPrints or {
		"4",
		"4",
		"4",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"4",
		"12",
		"5",
		"10",
		"13",
		nil,
		"14",
		"15",
		nil,
		"16",
		"6"
	}

	return var_0_0.tagPrints[arg_3_0]
end

function var_0_0.getCompareGroup(arg_4_0)
	return pg.equip_data_by_type[Equipment.getConfigData(arg_4_0).type].compare_group
end

function var_0_0.type2Title(arg_5_0, arg_5_1)
	if arg_5_1 <= 4 then
		return var_0_1[arg_5_0]
	elseif arg_5_1 == var_0_0.Torpedo then
		return var_0_1[3]
	elseif arg_5_1 == var_0_0.AntiAircraft or arg_5_1 == var_0_0.RangedAntiAircraft then
		return var_0_1[4]
	elseif arg_5_1 >= 7 and arg_5_1 <= 9 or arg_5_1 == var_0_0.SeaPlane then
		return var_0_0.Type2Name(arg_5_1)
	elseif arg_5_1 == var_0_0.Equipment or arg_5_1 == var_0_0.AntiSubAircraft then
		return var_0_1[6]
	elseif arg_5_1 == var_0_0.SubmarineTorpedo then
		return var_0_1[7]
	elseif arg_5_1 == var_0_0.Missile then
		return var_0_1[17]
	end

	return
end

local var_0_3 = {
	1,
	2,
	3,
	4,
	11
}
local var_0_4 = {
	7,
	8,
	9,
	12
}
local var_0_5 = {
	1,
	2
}
local var_0_6 = {
	10,
	14,
	15,
	17,
	18
}

local function var_0_7(arg_6_0)
	if _.all(arg_6_0, function(arg_7_0)
		return table.contains(var_0_6, arg_7_0)
	end) then
		return "equipment"
	elseif _.all(arg_6_0, function(arg_8_0)
		return table.contains(var_0_3, arg_8_0)
	end) then
		return "main_cannons"
	elseif #arg_6_0 == 1 then
		return var_0_2[arg_6_0[1]]
	elseif #arg_6_0 > 1 then
		if _.all(arg_6_0, function(arg_9_0)
			return table.contains(var_0_4, arg_9_0)
		end) then
			return "equipment_aircraft"
		else
			return "primary_weapons"
		end
	end

	return ""
end

local function var_0_8(arg_10_0, arg_10_1)
	if _.all(arg_10_1, function(arg_11_0)
		return table.contains(var_0_3, arg_11_0)
	end) and _.is_equal(arg_10_0, arg_10_1) then
		return "main_cannons"
	elseif _.all(arg_10_0, function(arg_12_0)
		return table.contains(var_0_6, arg_12_0)
	end) then
		return "equipment"
	elseif _.all(arg_10_0, function(arg_13_0)
		return table.contains(var_0_5, arg_13_0)
	end) then
		return "sub_cannons"
	elseif #arg_10_0 == 1 then
		return var_0_2[arg_10_0[1]]
	elseif #arg_10_0 > 1 then
		if _.all(arg_10_0, function(arg_14_0)
			return table.contains(var_0_4, arg_14_0)
		end) then
			return "equipment_aircraft"
		else
			return "sub_weapons"
		end
	end

	return ""
end

local function var_0_9(arg_15_0)
	if _.all(arg_15_0, function(arg_16_0)
		return table.contains(var_0_6, arg_16_0)
	end) then
		return "equipment"
	elseif #arg_15_0 == 2 and table.contains(arg_15_0, EquipType.AntiAircraft) and table.contains(arg_15_0, EquipType.RangedAntiAircraft) then
		return "antiair"
	elseif _.all(arg_15_0, function(arg_17_0)
		return table.contains(var_0_5, arg_17_0)
	end) then
		return "sub_cannons"
	elseif #arg_15_0 == 1 then
		return var_0_2[arg_15_0[1]]
	elseif #arg_15_0 > 1 then
		if _.all(arg_15_0, function(arg_18_0)
			return table.contains(var_0_4, arg_18_0)
		end) then
			return "equipment_aircraft"
		else
			return "sub_weapons"
		end
	end

	return ""
end

function var_0_0.Types2Title(arg_19_0, arg_19_1)
	if arg_19_0 == 1 then
		return var_0_7(pg.ship_data_template[arg_19_1]["equip_" .. arg_19_0])
	elseif arg_19_0 == 2 then
		return var_0_8(pg.ship_data_template[arg_19_1]["equip_" .. arg_19_0], pg.ship_data_template[arg_19_1].equip_1)
	elseif arg_19_0 == 3 then
		return var_0_9(pg.ship_data_template[arg_19_1]["equip_" .. arg_19_0])
	elseif arg_19_0 == 4 or arg_19_0 == 5 then
		return var_0_2[pg.ship_data_template[arg_19_1]["equip_" .. arg_19_0][1]]
	end

	return
end

function var_0_0.LabelToName(arg_20_0)
	if arg_20_0 == "antiair" then
		arg_20_0 = "air_defense_artillery"
	elseif arg_20_0 == "equipment" then
		arg_20_0 = "device"
	end

	return i18n("word_" .. arg_20_0)
end

return var_0_0
