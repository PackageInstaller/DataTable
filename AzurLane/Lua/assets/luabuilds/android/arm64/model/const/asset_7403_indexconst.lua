class = var_0_10000

local var_0_0 = var_0_10000("IndexConst")

function var_0_0.Flags2Bits(arg_1_0)
	local var_1_0 = 0

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(arg_1_0) do
		bit = var_1_10007
		var_1_10007 = var_1_10007.bor

		local var_1_1 = var_1_0

		bit = var_1_10010
		var_1_0 = var_1_10007(var_1_1, var_1_10010.lshift(1, iter_1_1))
	end

	return var_1_0
end

function var_0_0.FlagRange2Bits(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = arg_2_0, arg_2_1 do
		bit = var_1_10007
		var_1_10007 = var_1_10007.bor

		local var_2_1 = var_2_0

		bit = var_1_10010
		var_2_0 = var_1_10007(var_2_1, var_1_10010.lshift(1, iter_2_0))
	end

	return var_2_0
end

function var_0_0.ToggleBits(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0

	bit = var_1_10005

	local var_3_1 = var_1_10005.lshift(1, arg_3_3)

	if arg_3_2 then
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, arg_3_2)
		_ = var_7

		local var_3_2 = var_7.reduce(arg_3_1, 0, function(arg_4_0, arg_4_1)
			if arg_4_1 ~= arg_3_2 then
				bit = var_2

				local var_4_0

				if not var_2.lshift(1, arg_4_1) then
					var_4_0 = 0
				end

				return arg_4_0 + var_4_0
			end
		end)

		if var_3_1 == var_1_10006 then
			var_3_0 = var_1_10006
		else
			bit = var_8

			if var_8.band(var_3_0, var_1_10006) > 0 then
				var_3_0 = var_3_0 - var_1_10006
			end

			bit = var_8

			if var_8.band(var_3_0, var_3_1) > 0 then
				var_3_1 = -var_3_1
			end

			if var_3_0 + var_3_1 == var_3_2 or var_3_0 == 0 then
				var_3_0 = var_1_10006
			end
		end
	else
		bit = var_1_10006

		if var_1_10006.band(var_3_0, var_3_1) > 0 then
			var_3_1 = -var_3_1
		end

		var_3_0 = var_3_0 + var_3_1
	end

	return var_3_0
end

function var_0_0.SingleToggleBits(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0

	bit = var_1_10005

	if var_5_0 == var_1_10005.lshift(1, arg_5_3) then
		bit = var_1_10006
		var_5_0 = var_1_10006.lshift(1, arg_5_2)
	else
		var_5_0 = var_5
	end

	return var_5_0
end

function var_0_0.StrLShift(arg_6_0, arg_6_1)
	local var_6_0 = ""

	for iter_6_0 = 1, arg_6_1 do
		arg_6_0 = arg_6_0 .. "0"
	end

	return arg_6_0 .. var_6_0
end

function var_0_0.StrAnd(arg_7_0, arg_7_1)
	local var_7_0 = ""

	string = var_1_10003

	local var_7_1 = var_1_10003.len(arg_7_0)

	string = var_1_10004

	local var_7_2 = (var_7_1 > var_1_10004.len(arg_7_1) and arg_7_0 or arg_7_1) == arg_7_0 and arg_7_1 or arg_7_0

	string = var_5

	local var_7_3 = var_5.len(var_3)

	string = var_6

	local var_7_4 = var_6.len(var_7_2)

	for iter_7_0 = 1, var_7_4 do
		string = var_1_10011

		if var_1_10011.sub(var_7_2, iter_7_0, iter_7_0) == "1" then
			string = var_1_10011

			if var_1_10011.sub(var_3, var_7_3 - var_7_4 + iter_7_0, var_7_3 - var_7_4 + iter_7_0) == "1" then
				var_7_0 = var_7_0 .. "1"

				goto label_7_0
			end
		end

		var_7_0 = var_7_0 .. "0"

		::label_7_0::
	end

	local var_7_5 = ""

	for iter_7_1 = 1, var_7_3 - var_7_4 do
		var_7_5 = var_7_5 .. "0"
	end

	return var_7_5 .. var_7_0
end

function var_0_0.StrOr(arg_8_0, arg_8_1)
	local var_8_0 = ""

	string = var_1_10003

	local var_8_1 = var_1_10003.len(arg_8_0)

	string = var_1_10004

	local var_8_2 = (var_8_1 > var_1_10004.len(arg_8_1) and arg_8_0 or arg_8_1) == arg_8_0 and arg_8_1 or arg_8_0

	string = var_5

	local var_8_3 = var_5.len(var_3)

	string = var_6

	local var_8_4 = var_6.len(var_8_2)

	for iter_8_0 = 1, var_8_4 do
		string = var_1_10011

		if var_1_10011.sub(var_8_2, iter_8_0, iter_8_0) ~= "1" then
			string = var_1_10011

			if var_1_10011.sub(var_3, var_8_3 - var_8_4 + iter_8_0, var_8_3 - var_8_4 + iter_8_0) == "1" then
				var_8_0 = var_8_0 .. "1"
			else
				var_8_0 = var_8_0 .. "0"
			end
		end
	end

	string = var_7

	return var_7.sub(var_3, 1, var_8_3 - var_8_4) .. var_8_0
end

function var_0_0.Flags2Str(arg_9_0)
	local var_9_0 = ""

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0) do
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

		ipairs = var_8

		for iter_11_0, iter_11_1 in var_8(arg_11_1) do
			if iter_11_1 ~= arg_11_2 then
				var_11_3 = var_0_0.StrOr(var_11_3, var_0_0.StrLShift("1", iter_11_1))
			end
		end

		if var_11_1 == var_11_2 or var_11_0 == var_11_3 then
			var_11_0 = var_11_2

			goto label_11_0
		end

		string = var_8

		local var_11_4

		if var_8.find(var_0_0.StrAnd(var_11_0, var_11_2), "1") ~= nil then
			var_11_0 = var_11_1
		else
			var_11_4 = var_0_0.StrOr(var_11_0, var_11_1)
			string = var_9

			local var_11_5 = var_9.len(var_11_4) - arg_11_3

			string = var_10

			local var_11_6 = var_10.find(var_0_0.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1"

			string = var_11

			local var_11_7 = var_11.sub(var_11_4, 1, var_11_5 - 1)
			local var_11_8 = var_11_6

			string = var_13
			var_11_0 = var_11_7 .. var_11_8 .. var_13.sub(var_11_4, var_11_5 + 1)
		end

		if var_11_0 ~= var_11_3 then
			string = var_11_4

			if var_11_4.find(var_11_0, "1") == nil then
				var_11_0 = var_11_2

				goto label_11_0

				local var_11_9 = var_0_0.StrOr(var_11_0, var_11_1)

				string = var_11_3

				local var_11_10 = var_11_3.len(var_11_9) - arg_11_3

				string = var_8

				local var_11_11 = var_8.find(var_0_0.StrAnd(var_11_0, var_11_1), "1") ~= nil and "0" or "1"

				string = var_9

				local var_11_12 = var_9.sub(var_11_9, 1, var_11_10 - 1)
				local var_11_13 = var_11_11

				string = var_11
				var_11_0 = var_11_12 .. var_11_13 .. var_11.sub(var_11_9, var_11_10 + 1)
			end

			::label_11_0::

			return var_11_0
		end
	end
end

function var_0_0.BitAll(arg_12_0)
	local var_12_0 = 0

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0) do
		bit = var_1_10007
		var_12_0 = var_1_10007.bor(iter_12_1, var_12_0)
	end

	return var_12_0
end

bit = var_1
var_0_0.EquipmentTypeSmallCannon = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipmentTypeMediumCannon = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipmentTypeBigCannon = var_1.lshift(1, 2)
bit = var_1
var_0_0.EquipmentTypeWarshipTorpedo = var_1.lshift(1, 3)
bit = var_1
var_0_0.EquipmentTypeSubmaraineTorpedo = var_1.lshift(1, 4)
bit = var_1
var_0_0.EquipmentTypeAntiAircraft = var_1.lshift(1, 5)
bit = var_1
var_0_0.EquipmentTypeFighter = var_1.lshift(1, 6)
bit = var_1
var_0_0.EquipmentTypeBomber = var_1.lshift(1, 7)
bit = var_1
var_0_0.EquipmentTypeTorpedoBomber = var_1.lshift(1, 8)
bit = var_1
var_0_0.EquipmentTypeEquip = var_1.lshift(1, 9)
bit = var_1
var_0_0.EquipmentTypeOther = var_1.lshift(1, 10)
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
table = var_1

var_1.insert(var_0_0.EquipmentTypeIndexs, 1, var_0_0.EquipmentTypeAll)

function var_0_0.filterEquipByType(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_1 == var_0_0.EquipmentTypeAll then
		return true
	end

	local var_13_0 = 2

	EquipmentSortCfg = var_1_10003

	for iter_13_0 = var_13_0, #var_1_10003.index do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_13_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_13_1)

		if 0 < var_1_10007 then
			EquipmentSortCfg = var_1_10007
			var_1_10007 = var_1_10007.index[iter_13_0].types
			table = var_8

			if var_8.contains(var_1_10007, arg_13_0:getConfig("type")) then
				return true
			end
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
bit = var_1
var_0_0.EquipCampUS = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipCampEN = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipCampJP = var_1.lshift(1, 2)
bit = var_1
var_0_0.EquipCampDE = var_1.lshift(1, 3)
bit = var_1
var_0_0.EquipCampCN = var_1.lshift(1, 4)
bit = var_1
var_0_0.EquipCampITA = var_1.lshift(1, 5)
bit = var_1
var_0_0.EquipCampSN = var_1.lshift(1, 6)
bit = var_1
var_0_0.EquipCampFR = var_1.lshift(1, 7)
bit = var_1
var_0_0.EquipCampMNF = var_1.lshift(1, 8)
bit = var_1
var_0_0.EquipCampMOT = var_1.lshift(1, 9)
bit = var_1
var_0_0.EquipCampLINK = var_1.lshift(1, 10)
bit = var_1
var_0_0.EquipCampOther = var_1.lshift(1, 11)
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
table = var_1

var_1.insert(var_0_0.EquipCampIndexs, 1, var_0_0.EquipCampAll)

function var_0_0.filterEquipByCamp(arg_14_0, arg_14_1)
	if not arg_14_1 or arg_14_1 == var_0_0.EquipmentTypeAll then
		return true
	end

	local var_14_0 = 2

	EquipmentSortCfg = var_1_10003

	for iter_14_0 = var_14_0, #var_1_10003.campIndex do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_14_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_14_1)

		if 0 < var_1_10007 then
			EquipmentSortCfg = var_1_10007
			var_1_10007 = var_1_10007.campIndex[iter_14_0].types
			ipairs = var_8

			for iter_14_1, iter_14_2 in var_8(var_1_10007) do
				Nation = var_1_10013

				if iter_14_2 == var_1_10013.LINK then
					var_1_10013 = arg_14_0:getNation()
					Nation = var_1_10014

					if var_1_10014.LINK <= var_1_10013 then
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

bit = var_1
var_0_0.EquipProperty_Cannon = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipProperty_Air = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipProperty_Dodge = var_1.lshift(1, 2)
bit = var_1
var_0_0.EquipProperty_AntiAircraft = var_1.lshift(1, 3)
bit = var_1
var_0_0.EquipProperty_Torpedo = var_1.lshift(1, 4)
bit = var_1
var_0_0.EquipProperty_Reload = var_1.lshift(1, 5)
bit = var_1
var_0_0.EquipProperty_Durability = var_1.lshift(1, 6)
bit = var_1
var_0_0.EquipProperty_Antisub = var_1.lshift(1, 7)
bit = var_1
var_0_0.EquipProperty_Oxy = var_1.lshift(1, 8)
bit = var_1
var_0_0.EquipProperty_Speed = var_1.lshift(1, 9)
bit = var_1
var_0_0.EquipProperty_Hit = var_1.lshift(1, 10)
bit = var_1
var_0_0.EquipProperty_Luck = var_1.lshift(1, 11)
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
table = var_1

var_1.insert(var_0_0.EquipPropertyIndexs, 1, var_0_0.EquipPropertyAll)

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
	local var_15_0 = {}

	if arg_15_0:getConfig("attribute_1") then
		table = var_3

		var_3.insert(var_15_0, arg_15_0:getConfig("attribute_1"))
	end

	if arg_15_0:getConfig("attribute_2") then
		table = var_3

		var_3.insert(var_15_0, arg_15_0:getConfig("attribute_2"))
	end

	if arg_15_0:getConfig("attribute_3") then
		table = var_3

		var_3.insert(var_15_0, arg_15_0:getConfig("attribute_3"))
	end

	local var_15_1 = 0

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(arg_15_1) do
		if not iter_15_1 or iter_15_1 == var_0_0.EquipPropertyAll then
			var_15_1 = var_15_1 + 1
		else
			local var_15_2 = 2

			EquipmentSortCfg = var_1_10010

			for iter_15_2 = var_15_2, #var_1_10010.propertyIndex do
				bit = var_1_10013
				var_1_10013 = var_1_10013.lshift(1, iter_15_2 - 2)
				bit = var_1_10014

				if var_1_10014.band(var_1_10013, iter_15_1) > 0 then
					EquipmentSortCfg = var_1_10014
					var_1_10014 = var_1_10014.propertyIndex[iter_15_2].types

					for iter_15_3 = #var_15_0, 1, -1 do
						local var_15_3 = var_15_0[iter_15_3]

						table = var_1_10020

						if var_1_10020.contains(var_1_10014, var_15_3) then
							var_15_1 = var_15_1 + 1
							table = var_1_10020

							var_1_10020.remove(var_15_0, iter_15_3)

							break
						end
					end
				end
			end
		end
	end

	return var_15_1 >= #arg_15_1
end

bit = var_1
var_0_0.EquipAmmoChuanjia = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipAmmoGaobao = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipAmmoTongchangDan = var_1.lshift(1, 2)
bit = var_1
var_0_0.EquipAmmoQita = var_1.lshift(1, 3)
var_0_0.EquipAmmoIndexs_1 = {
	var_0_0.EquipAmmoChuanjia,
	var_0_0.EquipAmmoGaobao,
	var_0_0.EquipAmmoTongchangDan,
	var_0_0.EquipAmmoQita
}
var_0_0.EquipAmmoAll_1 = var_0_0.BitAll(var_0_0.EquipAmmoIndexs_1)
table = var_1

var_1.insert(var_0_0.EquipAmmoIndexs_1, 1, var_0_0.EquipAmmoAll_1)

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

	local var_16_0 = 2

	EquipmentSortCfg = var_1_10003

	for iter_16_0 = var_16_0, #var_1_10003.ammoIndex1 do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_16_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_16_1)

		if 0 < var_1_10007 then
			EquipmentSortCfg = var_1_10007
			var_1_10007 = var_1_10007.ammoIndex1[iter_16_0].types
			table = var_8

			if var_8.contains(var_1_10007, arg_16_0:getConfig("ammo")) then
				return true
			end
		end
	end

	return false
end

bit = var_1
var_0_0.EquipAmmoShengdao = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipAmmoTongchang = var_1.lshift(1, 1)
var_0_0.EquipAmmoIndexs_2 = {
	var_0_0.EquipAmmoShengdao,
	var_0_0.EquipAmmoTongchang
}
var_0_0.EquipAmmoAll_2 = var_0_0.BitAll(var_0_0.EquipAmmoIndexs_2)
table = var_1

var_1.insert(var_0_0.EquipAmmoIndexs_2, 1, var_0_0.EquipAmmoAll_2)

var_0_0.EquipAmmoIndexs_2_Names = {
	"attribute_ammo",
	"equip_ammo_type_4",
	"equip_ammo_type_5"
}

function var_0_0.filterEquipAmmo2(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == var_0_0.EquipAmmoAll_2 then
		return true
	end

	local var_17_0 = 2

	EquipmentSortCfg = var_1_10003

	for iter_17_0 = var_17_0, #var_1_10003.ammoIndex2 do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_17_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_17_1)

		if 0 < var_1_10007 then
			EquipmentSortCfg = var_1_10007
			var_1_10007 = var_1_10007.ammoIndex2[iter_17_0].types
			table = var_8

			if var_8.contains(var_1_10007, arg_17_0:getConfig("ammo")) then
				return true
			end
		end
	end

	return false
end

bit = var_1
var_0_0.EquipmentRarity1 = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipmentRarity2 = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipmentRarity3 = var_1.lshift(1, 2)
bit = var_1
var_0_0.EquipmentRarity4 = var_1.lshift(1, 3)
bit = var_1
var_0_0.EquipmentRarity5 = var_1.lshift(1, 4)
var_0_0.EquipmentRarityIndexs = {
	var_0_0.EquipmentRarity1,
	var_0_0.EquipmentRarity2,
	var_0_0.EquipmentRarity3,
	var_0_0.EquipmentRarity4,
	var_0_0.EquipmentRarity5
}
var_0_0.EquipmentRarityAll = var_0_0.BitAll(var_0_0.EquipmentRarityIndexs)
table = var_1

var_1.insert(var_0_0.EquipmentRarityIndexs, 1, var_0_0.EquipmentRarityAll)

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

	math = var_1_10002

	local var_18_0 = var_1_10002.max(arg_18_0:getConfig("rarity") - 2, 0)

	bit = var_1_10003

	local var_18_1 = var_1_10003.lshift(1, var_18_0)

	bit = var_4

	return var_4.band(var_18_1, arg_18_1) > 0
end

var_0_0.EquipmentExtraNames = {
	"index_without_limit",
	"index_equip",
	"index_strengthen",
	"index_reform"
}
bit = var_1
var_0_0.EquipmentExtraEquiping = var_1.lshift(1, 0)
bit = var_1
var_0_0.EquipmentExtraStrengthen = var_1.lshift(1, 1)
bit = var_1
var_0_0.EquipmentExtraTransform = var_1.lshift(1, 2)
var_0_0.EquipmentExtraIndexs = {
	var_0_0.EquipmentExtraEquiping,
	var_0_0.EquipmentExtraStrengthen,
	var_0_0.EquipmentExtraTransform
}
var_0_0.EquipmentExtraNone = 0
table = var_1

var_1.insert(var_0_0.EquipmentExtraIndexs, 1, var_0_0.EquipmentExtraNone)

function var_0_0.filterEquipByExtra(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or 0
	bit = var_1_10002

	if var_1_10002.band(arg_19_1, var_0_0.EquipmentExtraEquiping) > 0 and not arg_19_0.shipId then
		return false
	end

	bit = var_2

	if var_2.band(arg_19_1, var_0_0.EquipmentExtraStrengthen) > 0 then
		pg = var_2

		if not var_2.equip_data_template[arg_19_0.id] or not var_2.next or var_2.next == 0 then
			return false
		end
	end

	bit = var_2

	local var_19_0 = var_2.band(arg_19_1, var_0_0.EquipmentExtraTransform)

	if 0 < var_19_0 then
		EquipmentProxy = var_19_0

		local var_19_1 = var_19_0.EquipTransformTargetDict

		Equipment = var_3

		if not var_19_1[var_3.GetEquipRootStatic(arg_19_0.id)] or not var_2.targets then
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

local var_0_1 = {}

i18n = var_2
var_0_1[1] = var_2("word_equipskin_type")
var_0_0.EquipSkinSortNames = var_0_1
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

local var_0_2 = {}

i18n = var_2
var_0_2[1] = var_2("word_equipskin_all")
i18n = var_2
var_0_2[2] = var_2("word_equipskin_cannon")
i18n = var_2
var_0_2[3] = var_2("word_equipskin_tarpedo")
i18n = var_2
var_0_2[4] = var_2("word_equipskin_aircraft")
i18n = var_2
var_0_2[5] = var_2("word_equipskin_aux")
var_0_0.EquipSkinIndexNames = var_0_2
var_0_0.EquipSkinThemeAll = 1
var_0_0.EquipSkinThemeEnd = nil
var_0_0.EquipSkinThemeTypes = {
	var_0_0.EquipSkinThemeAll
}
ipairs = var_1
pg = var_3

for iter_0_0, iter_0_1 in var_1(var_3.equip_skin_theme_template.all) do
	table = var_0_10006

	var_0_10006.insert(var_0_0.EquipSkinThemeTypes, iter_0_0 + var_0_0.EquipSkinThemeAll)

	pg = var_0_10006

	if iter_0_0 == #var_0_10006.equip_skin_theme_template.all then
		var_0_0.EquipSkinThemeEnd = iter_0_0 + var_0_0.EquipSkinThemeAll + 1
	end
end

local var_0_3 = {}

i18n = var_2
var_0_3[1] = var_2("word_equipskin_all")
var_0_0.EquipSkinThemeNames = var_0_3
ipairs = var_0_3
pg = var_3

for iter_0_2, iter_0_3 in var_0_3(var_3.equip_skin_theme_template.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.equip_skin_theme_template[iter_0_3].name
	table = var_0_10007

	var_0_10007.insert(var_0_0.EquipSkinThemeNames, var_0_10006)
end

function var_0_0.filterEquipSkinByIndex(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return true
	end

	bit = var_1_10002

	local var_20_0 = var_1_10002.band
	local var_20_1 = arg_20_1

	bit = var_1_10005

	if var_20_0(var_20_1, var_1_10005.lshift(1, var_0_0.EquipSkinIndexAll)) > 0 then
		return true
	end

	local var_20_2 = {}
	local var_20_3 = {
		1,
		2,
		3,
		4,
		5
	}

	ipairs = var_20_1

	for iter_20_0, iter_20_1 in var_20_1(var_0_0.EquipSkinIndexTypes) do
		bit = var_1_10009
		var_1_10009 = var_1_10009.band

		local var_20_4 = arg_20_1

		bit = var_1_10012
		var_1_10009 = var_1_10009(var_20_4, var_1_10012.lshift(1, iter_20_1))

		if 0 < var_1_10009 then
			var_1_10009 = var_20_3[iter_20_1]
			EquipmentSortCfg = var_10

			local var_20_5 = var_10.skinIndex[var_1_10009].types

			ipairs = var_20_4

			for iter_20_2, iter_20_3 in var_20_4(var_20_5) do
				table = var_1_10016

				var_1_10016.insert(var_20_2, iter_20_3)
			end
		end
	end

	pg = var_4

	local var_20_6 = var_4.equip_skin_template

	if arg_20_0.count > 0 and arg_20_0.isSkin then
		local var_20_7 = var_20_6[arg_20_0.id].equip_type

		pairs = iter_20_0

		for iter_20_4, iter_20_5 in iter_20_0(var_20_7) do
			table = var_1_10012

			if var_1_10012.contains(var_20_2, iter_20_5) then
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

	string = var_1_10002

	if var_1_10002.find(var_0_0.StrAnd(arg_21_1, var_0_0.StrLShift("1", var_0_0.EquipSkinThemeAll)), "1") ~= nil then
		return true
	end

	pg = var_2

	local var_21_0 = var_2.equip_skin_template

	pg = var_1_10003

	local var_21_1 = var_1_10003.equip_skin_theme_template

	if arg_21_0.count > 0 and arg_21_0.isSkin then
		local var_21_2 = var_21_0[arg_21_0.id].themeid
		local var_21_3

		ipairs = var_7

		for iter_21_0, iter_21_1 in var_7(var_0_0.EquipSkinThemeTypes) do
			string = var_1_10012

			if var_1_10012.find(var_0_0.StrAnd(arg_21_1, var_0_0.StrLShift("1", iter_21_0)), "1") ~= nil then
				pg = var_1_10012

				local var_21_4 = var_21_1[var_21_1[var_1_10012.equip_skin_theme_template.all[iter_21_1 - 1]].id].ids

				table = var_14

				if var_14.contains(var_21_4, var_4) then
					return true
				end
			end
		end
	end

	return
end

bit = var_1
var_0_0.SpWeaponTypeQvZhu = var_1.lshift(1, 0)
bit = var_1
var_0_0.SpWeaponTypeQingXvn = var_1.lshift(1, 1)
bit = var_1
var_0_0.SpWeaponTypeZhongXvn = var_1.lshift(1, 2)
bit = var_1
var_0_0.SpWeaponTypeZhanLie = var_1.lshift(1, 3)
bit = var_1
var_0_0.SpWeaponTypeHangMu = var_1.lshift(1, 4)
bit = var_1
var_0_0.SpWeaponTypeWeiXiu = var_1.lshift(1, 5)
bit = var_1
var_0_0.SpWeaponTypeQianTing = var_1.lshift(1, 6)
bit = var_1
var_0_0.SpWeaponTypeQiTa = var_1.lshift(1, 7)
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
table = var_1

var_1.insert(var_0_0.SpWeaponTypeIndexs, 1, var_0_0.SpWeaponTypeAll)

function var_0_0.filterSpWeaponByType(arg_22_0, arg_22_1)
	if not arg_22_1 or arg_22_1 == var_0_0.SpWeaponTypeAll then
		return true
	end

	local var_22_0 = arg_22_0:GetWearableShipTypes()

	for iter_22_0 = 0, #var_0_0.SpWeaponTypeIndexs - 2 do
		bit = var_1_10007
		var_1_10007 = var_1_10007.lshift(1, iter_22_0)
		bit = var_1_10008

		if var_1_10008.band(var_1_10007, arg_22_1) > 0 then
			ShipIndexCfg = var_1_10008
			var_1_10008 = var_1_10008.type[4 + iter_22_0].types
			_ = var_9

			if var_9.any(var_1_10008, function(arg_23_0)
				table = var_2_10001

				return var_2_10001.contains(var_22_0, arg_23_0)
			end) then
				return true
			end
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
bit = var_1
var_0_0.SpWeaponRarity1 = var_1.lshift(1, 0)
bit = var_1
var_0_0.SpWeaponRarity2 = var_1.lshift(1, 1)
bit = var_1
var_0_0.SpWeaponRarity3 = var_1.lshift(1, 2)
var_0_0.SpWeaponRarityIndexs = {
	var_0_0.SpWeaponRarity1,
	var_0_0.SpWeaponRarity2,
	var_0_0.SpWeaponRarity3
}
var_0_0.SpWeaponRarityAll = var_0_0.BitAll(var_0_0.SpWeaponRarityIndexs)
table = var_1

var_1.insert(var_0_0.SpWeaponRarityIndexs, 1, var_0_0.SpWeaponRarityAll)

function var_0_0.filterSpWeaponByRarity(arg_24_0, arg_24_1)
	if not arg_24_1 or arg_24_1 == var_0_0.SpWeaponRarityAll then
		return true
	end

	math = var_1_10002

	local var_24_0 = var_1_10002.max(arg_24_0:GetRarity() - 2, 0)

	bit = var_1_10003

	local var_24_1 = var_1_10003.lshift(1, var_24_0)

	bit = var_4

	return var_4.band(var_24_1, arg_24_1) > 0
end

var_0_0.LABEL_COUNT = 9
var_0_0.ECodeLabelNames = {}
var_0_0.ECodeLabelIndexs = {}

for iter_0_4 = 1, var_0_0.LABEL_COUNT do
	bit = var_0_4

	local var_0_4 = var_0_4.lshift(1, iter_0_4 - 1)

	table = var_0_10006

	var_0_10006.insert(var_0_0.ECodeLabelNames, "equip_share_label_" .. iter_0_4)

	table = var_0_10006

	var_0_10006.insert(var_0_0.ECodeLabelIndexs, var_0_4)
end

local var_0_5 = var_0_0.BitAll(var_0_0.ECodeLabelIndexs)

table = var_2

var_2.insert(var_0_0.ECodeLabelNames, 1, "index_all")

table = var_2

var_2.insert(var_0_0.ECodeLabelIndexs, 1, var_0_5)

function var_0_0.filterEquipCodeByLable(arg_25_0, arg_25_1)
	if not arg_25_1 or arg_25_1 == var_0_5 then
		return true
	end

	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0:GetLabels()) do
		bit = var_1_10007
		var_1_10007 = var_1_10007.band
		bit = var_1_10009

		if var_1_10007(var_1_10009.lshift(1, iter_25_1 - 1), arg_25_1) > 0 then
			return true
		end
	end

	return false
end

return var_0_0
