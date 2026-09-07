local AttributeType = class("AttributeType")

AttributeType.Durability = "durability"
AttributeType.Cannon = "cannon"
AttributeType.Torpedo = "torpedo"
AttributeType.AntiAircraft = "antiaircraft"
AttributeType.AntiSub = "antisub"
AttributeType.Air = "air"
AttributeType.Reload = "reload"
AttributeType.ArmorType = "armor_type"
AttributeType.Armor = "armor"
AttributeType.Hit = "hit"
AttributeType.Speed = "speed"
AttributeType.Luck = "luck"
AttributeType.Dodge = "dodge"
AttributeType.Expend = "expend"
AttributeType.Intimacy = "intimacy"
AttributeType.AirDominate = "AirDominate"
AttributeType.Damage = "damage"
AttributeType.CD = "cd"
AttributeType.Healthy = "healthy"
AttributeType.Speciality = "speciality"
AttributeType.Range = "range"
AttributeType.Angle = "angle"
AttributeType.Scatter = "scatter"
AttributeType.Ammo = "ammo"
AttributeType.HuntingRange = "hunting_range"
AttributeType.AirDurability = "AirDurability"
AttributeType.AntiSiren = "anti_siren"
AttributeType.Corrected = "corrected"
AttributeType.OxyMax = "oxy_max"
AttributeType.OxyCost = "oxy_cost"
AttributeType.OxyRecovery = "oxy_recovery"
AttributeType.OxyRecoverySurface = "oxy_recovery_surface"
AttributeType.OxyRecoveryBench = "oxy_recovery_bench"
AttributeType.OxyAttackDuration = "attack_duration"
AttributeType.OxyRaidDistance = "raid_distance"
AttributeType.SonarRange = "sonarRange"
AttributeType.Tactics = "tactics"
AttributeType.WorldPower = "world_power"

function AttributeType:Type2Name()
	return i18n("attribute_" .. self)
end

AttributeType.eliteConditionTip = {
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

function AttributeType:eliteConditionCompareTip()
	return i18n(var_0_1[self])
end

function AttributeType:EliteCondition2Name(...)
	return i18n(AttributeType.eliteConditionTip[self], ...)
end

function AttributeType:EliteConditionCompare(arg_4_1, arg_4_2)
	if self == 0 then
		return arg_4_1 == arg_4_2
	elseif self == 1 then
		return arg_4_2 < arg_4_1
	elseif self == -1 then
		return arg_4_1 < arg_4_2
	elseif self == 2 then
		return arg_4_2 <= arg_4_1
	elseif self == -2 then
		return arg_4_1 <= arg_4_2
	else
		assert(false, "compare type error")
	end

	return
end

AttributeType.attrNameTable = {
	[AttributeType.Durability] = "maxHP",
	[AttributeType.Cannon] = "cannonPower",
	[AttributeType.Torpedo] = "torpedoPower",
	[AttributeType.AntiAircraft] = "antiAirPower",
	[AttributeType.AntiSub] = "antiSubPower",
	[AttributeType.Air] = "airPower",
	[AttributeType.Reload] = "loadSpeed",
	[AttributeType.Hit] = "attackRating",
	[AttributeType.Speed] = "speed",
	[AttributeType.Luck] = "luck",
	[AttributeType.Dodge] = "dodgeRate",
	[AttributeType.OxyMax] = "oxyMax",
	[AttributeType.OxyCost] = "oxyCost",
	[AttributeType.OxyRecovery] = "oxyRecovery",
	[AttributeType.OxyRecoveryBench] = "oxyRecoveryBench",
	[AttributeType.OxyRecoverySurface] = "oxyRecoverySurface",
	[AttributeType.OxyAttackDuration] = "oxyAtkDuration",
	[AttributeType.OxyRaidDistance] = "raidDist"
}

function AttributeType:ConvertBattleAttrName()
	if AttributeType.attrNameTable[self] then
		return AttributeType.attrNameTable[self]
	else
		return self
	end

	return
end

AttributeType.PrimalAttr = {
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

function AttributeType:IsPrimalBattleAttr()
	return AttributeType.PrimalAttr[self]
end

return AttributeType
