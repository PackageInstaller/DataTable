class = var_0_10000

local var_0_0 = var_0_10000("AttributeType")

var_0_0.Durability = "durability"
var_0_0.Cannon = "cannon"
var_0_0.Torpedo = "torpedo"
var_0_0.AntiAircraft = "antiaircraft"
var_0_0.AntiSub = "antisub"
var_0_0.Air = "air"
var_0_0.Reload = "reload"
var_0_0.ArmorType = "armor_type"
var_0_0.Armor = "armor"
var_0_0.Hit = "hit"
var_0_0.Speed = "speed"
var_0_0.Luck = "luck"
var_0_0.Dodge = "dodge"
var_0_0.Expend = "expend"
var_0_0.Intimacy = "intimacy"
var_0_0.AirDominate = "AirDominate"
var_0_0.Damage = "damage"
var_0_0.CD = "cd"
var_0_0.Healthy = "healthy"
var_0_0.Speciality = "speciality"
var_0_0.Range = "range"
var_0_0.Angle = "angle"
var_0_0.Scatter = "scatter"
var_0_0.Ammo = "ammo"
var_0_0.HuntingRange = "hunting_range"
var_0_0.AirDurability = "AirDurability"
var_0_0.AntiSiren = "anti_siren"
var_0_0.Corrected = "corrected"
var_0_0.OxyMax = "oxy_max"
var_0_0.OxyCost = "oxy_cost"
var_0_0.OxyRecovery = "oxy_recovery"
var_0_0.OxyRecoverySurface = "oxy_recovery_surface"
var_0_0.OxyRecoveryBench = "oxy_recovery_bench"
var_0_0.OxyAttackDuration = "attack_duration"
var_0_0.OxyRaidDistance = "raid_distance"
var_0_0.SonarRange = "sonarRange"
var_0_0.Tactics = "tactics"
var_0_0.WorldPower = "world_power"

function var_0_0.Type2Name(arg_1_0)
	i18n = var_1_10001

	return var_1_10001("attribute_" .. arg_1_0)
end

var_0_0.eliteConditionTip = {
	cannon = "elite_condition_cannon",
	antiaircraft = "elite_condition_antiaircraft",
	reload = "elite_condition_reload",
	torpedo = "elite_condition_torpedo",
	durability = "elite_condition_durability",
	air = "elite_condition_air",
	fleet_totle_level = "elite_condition_fleet_totle_level",
	dodge = "elite_condition_dodge",
	antisub = "elite_condition_antisub",
	level = "elite_condition_level"
}

local var_0_1 = {
	[0] = "common_compare_smaller",
	-2,
	"common_compare_not_more_than",
	common_compare_equal = "common_compare_larger",
	common_compare_not_less_than = -1
}

function var_0_0.eliteConditionCompareTip(arg_2_0)
	i18n = var_1_10001

	return var_1_10001(var_0_1[arg_2_0])
end

function var_0_0.EliteCondition2Name(arg_3_0, ...)
	i18n = var_1_10001

	return var_1_10001(var_0_0.eliteConditionTip[arg_3_0], ...)
end

function var_0_0.EliteConditionCompare(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 == 0 then
		var_1_10003 = arg_4_1 == arg_4_2

		return var_1_10003
	elseif arg_4_0 == 1 then
		var_1_10003 = arg_4_2 < arg_4_1

		return var_1_10003
	elseif arg_4_0 == -1 then
		var_1_10003 = arg_4_1 < arg_4_2

		return var_1_10003
	elseif arg_4_0 == 2 then
		var_1_10003 = arg_4_2 <= arg_4_1

		return var_1_10003
	elseif arg_4_0 == -2 then
		var_1_10003 = arg_4_1 <= arg_4_2

		return var_1_10003
	else
		assert = var_1_10003

		var_1_10003(false, "compare type error")
	end

	return
end

var_0_0.attrNameTable = {
	[var_0_0.Durability] = "maxHP",
	[var_0_0.Cannon] = "cannonPower",
	[var_0_0.Torpedo] = "torpedoPower",
	[var_0_0.AntiAircraft] = "antiAirPower",
	[var_0_0.AntiSub] = "antiSubPower",
	[var_0_0.Air] = "airPower",
	[var_0_0.Reload] = "loadSpeed",
	[var_0_0.Hit] = "attackRating",
	[var_0_0.Speed] = "speed",
	[var_0_0.Luck] = "luck",
	[var_0_0.Dodge] = "dodgeRate",
	[var_0_0.OxyMax] = "oxyMax",
	[var_0_0.OxyCost] = "oxyCost",
	[var_0_0.OxyRecovery] = "oxyRecovery",
	[var_0_0.OxyRecoveryBench] = "oxyRecoveryBench",
	[var_0_0.OxyRecoverySurface] = "oxyRecoverySurface",
	[var_0_0.OxyAttackDuration] = "oxyAtkDuration",
	[var_0_0.OxyRaidDistance] = "raidDist"
}

function var_0_0.ConvertBattleAttrName(arg_5_0)
	if var_0_0.attrNameTable[arg_5_0] then
		return var_0_0.attrNameTable[arg_5_0]
	else
		return arg_5_0
	end

	return
end

var_0_0.PrimalAttr = {
	velocity = true,
	loadSpeed = true,
	antiSubPower = true,
	antiAirPower = true,
	dodgeRate = true,
	airPower = true,
	attackRating = true,
	cannonPower = true,
	torpedoPower = true
}

function var_0_0.IsPrimalBattleAttr(arg_6_0)
	return var_0_0.PrimalAttr[arg_6_0]
end

return var_0_0
