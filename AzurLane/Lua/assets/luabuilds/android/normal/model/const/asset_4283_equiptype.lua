class = var_0_10000

local var_0_0 = var_0_10000("EquipType")

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

local var_0_1 = {}

i18n = var_2
var_0_1[1] = var_2("word_primary_weapons")
i18n = var_2
var_0_1[2] = var_2("word_sub_cannons")
i18n = var_2
var_0_1[3] = var_2("word_torpedo")
i18n = var_2
var_0_1[4] = var_2("word_air_defense_artillery")
i18n = var_2
var_0_1[5] = var_2("word_shipboard_aircraft")
i18n = var_2
var_0_1[6] = var_2("word_device")
i18n = var_2
var_0_1[7] = var_2("word_submarine_torpedo")
i18n = var_2
var_0_1[8] = var_2("wrod_sub_weapons")
i18n = var_2
var_0_1[9] = var_2("word_main_cannons")
i18n = var_2
var_0_1[10] = var_2("word_cannon")
i18n = var_2
var_0_1[11] = var_2("word_equipment_aircraft")
i18n = var_2
var_0_1[12] = var_2("word_fighter")
i18n = var_2
var_0_1[13] = var_2("word_bomber")
i18n = var_2
var_0_1[14] = var_2("word_attacker")
i18n = var_2
var_0_1[15] = var_2("word_seaplane")
i18n = var_2
var_0_1[16] = var_2("word_equipment")
i18n = var_2
var_0_1[17] = var_2("word_missile")

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
	pg = var_1_10001

	return var_1_10001.equip_data_by_type[arg_1_0].type_name
end

function var_0_0.Type2Name2(arg_2_0)
	pg = var_1_10001

	return var_1_10001.equip_data_by_type[arg_2_0].type_name2
end

function var_0_0.type2Tag(arg_3_0)
	if not var_0_0.tagPrints then
		var_0_0.tagPrints = {
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
	end

	return var_0_0.tagPrints[arg_3_0]
end

function var_0_0.getCompareGroup(arg_4_0)
	Equipment = var_1_10001

	local var_4_0 = var_1_10001.getConfigData(arg_4_0).type

	pg = var_2

	return var_2.equip_data_by_type[var_4_0].compare_group
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
	_ = var_1_10001

	if var_1_10001.all(arg_6_0, function(arg_7_0)
		table = var_2_10001

		return var_2_10001.contains(var_0_6, arg_7_0)
	end) then
		return "equipment"
	else
		_ = var_1

		if var_1.all(arg_6_0, function(arg_8_0)
			table = var_2_10001

			return var_2_10001.contains(var_0_3, arg_8_0)
		end) then
			return "main_cannons"
		elseif #arg_6_0 == 1 then
			return var_0_2[arg_6_0[1]]
		elseif #arg_6_0 > 1 then
			_ = var_1

			if var_1.all(arg_6_0, function(arg_9_0)
				table = var_2_10001

				return var_2_10001.contains(var_0_4, arg_9_0)
			end) then
				return "equipment_aircraft"
			else
				return "primary_weapons"
			end
		end
	end

	return ""
end

local function var_0_8(arg_10_0, arg_10_1)
	_ = var_1_10002

	if var_1_10002.all(arg_10_1, function(arg_11_0)
		table = var_2_10001

		return var_2_10001.contains(var_0_3, arg_11_0)
	end) then
		_ = var_3

		if var_3.is_equal(arg_10_0, arg_10_1) then
			do return "main_cannons" end

			goto label_10_0
		end
	end

	_ = var_3

	if var_3.all(arg_10_0, function(arg_12_0)
		table = var_2_10001

		return var_2_10001.contains(var_0_6, arg_12_0)
	end) then
		return "equipment"
	else
		_ = var_3

		if var_3.all(arg_10_0, function(arg_13_0)
			table = var_2_10001

			return var_2_10001.contains(var_0_5, arg_13_0)
		end) then
			return "sub_cannons"
		elseif #arg_10_0 == 1 then
			return var_0_2[arg_10_0[1]]
		elseif #arg_10_0 > 1 then
			_ = var_3

			if var_3.all(arg_10_0, function(arg_14_0)
				table = var_2_10001

				return var_2_10001.contains(var_0_4, arg_14_0)
			end) then
				return "equipment_aircraft"
			else
				return "sub_weapons"
			end
		end
	end

	::label_10_0::

	return ""
end

local function var_0_9(arg_15_0)
	_ = var_1_10001

	if var_1_10001.all(arg_15_0, function(arg_16_0)
		table = var_2_10001

		return var_2_10001.contains(var_0_6, arg_16_0)
	end) then
		return "equipment"
	else
		local var_15_0

		if #arg_15_0 == 2 then
			table = var_15_0
			var_15_0 = var_15_0.contains

			local var_15_1 = arg_15_0

			EquipType = var_3

			if var_15_0(var_15_1, var_3.AntiAircraft) then
				table = var_15_0
				var_15_0 = var_15_0.contains

				local var_15_2 = arg_15_0

				EquipType = var_3

				if var_15_0(var_15_2, var_3.RangedAntiAircraft) then
					do return "antiair" end

					goto label_15_0
				end
			end
		end

		_ = var_15_0

		if var_15_0.all(arg_15_0, function(arg_17_0)
			table = var_2_10001

			return var_2_10001.contains(var_0_5, arg_17_0)
		end) then
			return "sub_cannons"
		elseif #arg_15_0 == 1 then
			return var_0_2[arg_15_0[1]]
		elseif #arg_15_0 > 1 then
			_ = var_1

			if var_1.all(arg_15_0, function(arg_18_0)
				table = var_2_10001

				return var_2_10001.contains(var_0_4, arg_18_0)
			end) then
				return "equipment_aircraft"
			else
				return "sub_weapons"
			end
		end
	end

	::label_15_0::

	return ""
end

function var_0_0.Types2Title(arg_19_0, arg_19_1)
	pg = var_1_10002

	local var_19_0 = var_1_10002.ship_data_template[arg_19_1]["equip_" .. arg_19_0]

	if arg_19_0 == 1 then
		return var_0_7(var_19_0)
	elseif arg_19_0 == 2 then
		local var_19_1 = var_2.equip_1

		return var_0_8(var_19_0, var_19_1)
	elseif arg_19_0 == 3 then
		return var_0_9(var_19_0)
	elseif arg_19_0 == 4 or arg_19_0 == 5 then
		return var_0_2[var_19_0[1]]
	end

	return
end

function var_0_0.LabelToName(arg_20_0)
	if arg_20_0 == "antiair" then
		arg_20_0 = "air_defense_artillery"
	elseif arg_20_0 == "equipment" then
		arg_20_0 = "device"
	end

	i18n = var_1_10001

	return var_1_10001("word_" .. arg_20_0)
end

return var_0_0
