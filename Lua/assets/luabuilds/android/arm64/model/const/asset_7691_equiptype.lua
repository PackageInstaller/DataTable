local EquipType = class("EquipType")

EquipType.CannonQuZhu = 1
EquipType.CannonQingXun = 2
EquipType.CannonZhongXun = 3
EquipType.CannonZhanlie = 4
EquipType.Torpedo = 5
EquipType.AntiAircraft = 6
EquipType.FighterAircraft = 7
EquipType.TorpedoAircraft = 8
EquipType.BomberAircraft = 9
EquipType.Equipment = 10
EquipType.CannonZhongXun2 = 11
EquipType.SeaPlane = 12
EquipType.SubmarineTorpedo = 13
EquipType.Sonar = 14
EquipType.AntiSubAircraft = 15
EquipType.Helicopter = 17
EquipType.Goods = 18
EquipType.Missile = 20
EquipType.RangedAntiAircraft = 21
EquipType.AmmoType_1 = 1
EquipType.AmmoType_2 = 2
EquipType.AmmoType_3 = 3
EquipType.AmmoType_4 = 4
EquipType.AmmoType_5 = 5
EquipType.AmmoType_6 = 6
EquipType.AmmoType_7 = 7
EquipType.AmmoType_8 = 8
EquipType.AmmoType_8 = 9
EquipType.AmmoType_8 = 10
EquipType.CannonEquipTypes = {
	EquipType.CannonQuZhu,
	EquipType.CannonQingXun,
	EquipType.CannonZhongXun,
	EquipType.CannonZhanlie,
	EquipType.CannonZhongXun2
}
EquipType.AirProtoEquipTypes = {
	EquipType.FighterAircraft,
	EquipType.TorpedoAircraft,
	EquipType.BomberAircraft
}
EquipType.AirEquipTypes = {
	EquipType.FighterAircraft,
	EquipType.TorpedoAircraft,
	EquipType.BomberAircraft,
	EquipType.SeaPlane
}
EquipType.AirExtendEquipTypes = {
	EquipType.FighterAircraft,
	EquipType.TorpedoAircraft,
	EquipType.BomberAircraft,
	EquipType.SeaPlane,
	EquipType.AntiSubAircraft,
	EquipType.Helicopter
}
EquipType.AirDomainEquip = {
	EquipType.FighterAircraft,
	EquipType.TorpedoAircraft,
	EquipType.BomberAircraft,
	EquipType.SeaPlane
}
EquipType.TorpedoEquipTypes = {
	EquipType.Torpedo,
	EquipType.SubmarineTorpedo
}
EquipType.DeviceEquipTypes = {
	EquipType.Equipment,
	EquipType.AntiSubAircraft,
	EquipType.Sonar,
	EquipType.Helicopter,
	EquipType.Goods
}
EquipType.AircraftSkinType = {
	EquipType.FighterAircraft,
	EquipType.TorpedoAircraft,
	EquipType.BomberAircraft,
	EquipType.SeaPlane,
	EquipType.AntiSubAircraft
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

function EquipType:Type2Name()
	return pg.equip_data_by_type[self].type_name
end

function EquipType:Type2Name2()
	return pg.equip_data_by_type[self].type_name2
end

function EquipType:type2Tag()
	EquipType.tagPrints = EquipType.tagPrints or {
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

	return EquipType.tagPrints[self]
end

function EquipType:getCompareGroup()
	return pg.equip_data_by_type[Equipment.getConfigData(self).type].compare_group
end

function EquipType:type2Title(arg_5_1)
	if arg_5_1 <= 4 then
		return var_0_1[self]
	elseif arg_5_1 == EquipType.Torpedo then
		return var_0_1[3]
	elseif arg_5_1 == EquipType.AntiAircraft or arg_5_1 == EquipType.RangedAntiAircraft then
		return var_0_1[4]
	elseif arg_5_1 >= 7 and arg_5_1 <= 9 or arg_5_1 == EquipType.SeaPlane then
		return EquipType.Type2Name(arg_5_1)
	elseif arg_5_1 == EquipType.Equipment or arg_5_1 == EquipType.AntiSubAircraft then
		return var_0_1[6]
	elseif arg_5_1 == EquipType.SubmarineTorpedo then
		return var_0_1[7]
	elseif arg_5_1 == EquipType.Missile then
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

function EquipType:Types2Title(arg_19_1)
	if self == 1 then
		return var_0_7(pg.ship_data_template[arg_19_1]["equip_" .. self])
	elseif self == 2 then
		return var_0_8(pg.ship_data_template[arg_19_1]["equip_" .. self], pg.ship_data_template[arg_19_1].equip_1)
	elseif self == 3 then
		return var_0_9(pg.ship_data_template[arg_19_1]["equip_" .. self])
	elseif self == 4 or self == 5 then
		return var_0_2[pg.ship_data_template[arg_19_1]["equip_" .. self][1]]
	end

	return
end

function EquipType:LabelToName()
	if self == "antiair" then
		self = "air_defense_artillery"
	elseif self == "equipment" then
		self = "device"
	end

	return i18n("word_" .. self)
end

return EquipType
