ys = ys or {}

local var_0_0 = {}

ys.Battle.BattleAttr = {}
;({}).AttrListInheritance = {
	"level",
	"formulaLevel",
	"repressReduce",
	"cannonPower",
	"torpedoPower",
	"antiAirPower",
	"airPower",
	"antiSubPower",
	"fleetGS",
	"loadSpeed",
	"attackRating",
	"dodgeRate",
	"velocity",
	"luck",
	"cri",
	"criDamage",
	"criDamageResist",
	"hiveExtraHP",
	"GCT",
	"bulletSpeedRatio",
	"torpedoSpeedExtra",
	"damageRatioBullet",
	"damageEnhanceProjectile",
	"healingEnhancement",
	"injureRatio",
	"injureRatioByCannon",
	"injureRatioByBulletTorpedo",
	"injureRatioByAir",
	"damageRatioByCannon",
	"damageRatioByBulletTorpedo",
	"damageRatioByAir",
	"damagePreventRantTorpedo",
	"accuracyRateExtra",
	"dodgeRateExtra",
	"perfectDodge",
	"immuneDirectHit",
	"chargeBulletAccuracy",
	"dropBombAccuracy",
	"aircraftBooster",
	"manualEnhancement",
	"initialEnhancement",
	"worldBuffResistance",
	"airResistPierceActive",
	"airResistPierce"
}
;({}).InsertInheritedAttr = function(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_0_0.AttrListInheritance[#var_0_0.AttrListInheritance + 1] = iter_1_1
	end

	return
end

;({}).InsertInheritedAttr(ys.Battle.BattleConfig.AMMO_DAMAGE_ENHANCE)
;({}).InsertInheritedAttr(ys.Battle.BattleConfig.AMMO_DAMAGE_REDUCE)
;({}).InsertInheritedAttr(ys.Battle.BattleConfig.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE)
;({}).InsertInheritedAttr(ys.Battle.BattleConfig.DAMAGE_TO_ARMOR_RATE_ENHANCE)
;({}).InsertInheritedAttr(ys.Battle.BattleConfig.SHIP_TYPE_ACCURACY_ENHANCE)

;({}).TAG_EHC_KEY = "DMG_TAG_EHC_"
;({}).FROM_TAG_EHC_KEY = "DMG_FROM_TAG_"
;({}).TAG_CRI_EHC_KEY = "CRI_TAG_EHC_"
;({}).TAG_CRIDMG_EHC_KEY = "CRIDMG_TAG_EHC_"
;({}).ATTACK_ATTR_TYPE = {
	[ys.Battle.BattleConst.WeaponDamageAttr.CANNON] = "cannonPower",
	[ys.Battle.BattleConst.WeaponDamageAttr.TORPEDO] = "torpedoPower",
	[ys.Battle.BattleConst.WeaponDamageAttr.ANTI_AIR] = "antiAirPower",
	[ys.Battle.BattleConst.WeaponDamageAttr.AIR] = "airPower",
	[ys.Battle.BattleConst.WeaponDamageAttr.ANIT_SUB] = "antiSubPower"
}
;({}).GetAtkAttrByType = function(arg_2_0, arg_2_1)
	return math.max(arg_2_0[var_0_0.ATTACK_ATTR_TYPE[arg_2_1]], 0)
end
;({}).SetAttr = function(arg_3_0, arg_3_1)
	arg_3_0._attr = setmetatable({}, {
		__index = arg_3_1
	})

	return
end
;({}).GetAttr = function(arg_4_0)
	return arg_4_0._attr
end
;({}).SetBaseAttr = function(arg_5_0)
	arg_5_0._baseAttr = Clone(arg_5_0._attr)

	return
end
;({}).IsInvincible = function(arg_6_0)
	return arg_6_0._attr.isInvincible and arg_6_0._attr.isInvincible > 0
end
;({}).AppendInvincible = function(arg_7_0)
	local var_7_0 = arg_7_0._attr.isInvincible or 0

	arg_7_0._attr.isInvincible = var_7_0 + 1

	return
end
;({}).AddImmuneAreaLimit = function(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._attr.immuneAreaLimit or 0
	local var_8_1 = var_8_0 + arg_8_1

	arg_8_0._attr.immuneAreaLimit = var_8_0 + arg_8_1

	arg_8_0._move:ImmuneAreaLimit(var_8_1 > 0)

	return
end
;({}).AddImmuneMaxAreaLimit = function(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._attr.immuneMaxAreaLimit or 0
	local var_9_1 = var_9_0 + arg_9_1

	arg_9_0._attr.immuneMaxAreaLimit = var_9_0 + arg_9_1

	arg_9_0._move:ImmuneMaxAreaLimit(var_9_1 > 0)

	return
end
;({}).IsImmuneAreaLimit = function(arg_10_0)
	return arg_10_0._attr.immuneAreaLimit and arg_10_0._attr.immuneAreaLimit > 0
end
;({}).IsImmuneMaxAreaLimit = function(arg_11_0)
	return arg_11_0._attr.immuneMaxAreaLimit and arg_11_0._attr.immuneMaxAreaLimit > 0
end
;({}).IsVisitable = function(arg_12_0)
	local var_12_0 = arg_12_0._attr.isUnVisitable

	return not arg_12_0._attr.isUnVisitable or var_12_0 <= 0
end
;({}).UnVisitable = function(arg_13_0)
	local var_13_0 = arg_13_0._attr.isUnVisitable or 0

	arg_13_0._attr.isUnVisitable = var_13_0 + 1

	return
end
;({}).Visitable = function(arg_14_0)
	local var_14_0 = arg_14_0._attr.isUnVisitable or 0

	arg_14_0._attr.isUnVisitable = var_14_0 - 1

	return
end
;({}).IsSpirit = function(arg_15_0)
	return arg_15_0._attr.isSpirit and arg_15_0._attr.isSpirit > 0
end
;({}).Spirit = function(arg_16_0)
	local var_16_0 = arg_16_0._attr.isSpirit or 0

	arg_16_0._attr.isSpirit = var_16_0 + 1

	return
end
;({}).Entity = function(arg_17_0)
	local var_17_0 = arg_17_0._attr.isSpirit or 0

	arg_17_0._attr.isSpirit = var_17_0 - 1

	return
end
;({}).IsStun = function(arg_18_0)
	return arg_18_0._attr.isStun and arg_18_0._attr.isStun > 0
end
;({}).Stun = function(arg_19_0)
	local var_19_0 = arg_19_0._attr.isStun or 0

	arg_19_0._attr.isStun = var_19_0 + 1

	return
end
;({}).CancelStun = function(arg_20_0)
	local var_20_0 = arg_20_0._attr.isStun or 0

	arg_20_0._attr.isStun = var_20_0 - 1

	return
end
;({}).IsCloak = function(arg_21_0)
	local var_21_0 = arg_21_0._attr.isCloak or 0

	return var_21_0 == 1
end
;({}).Cloak = function(arg_22_0)
	arg_22_0._attr.isCloak = 1
	arg_22_0._attr.airResistPierceActive = 1

	return
end
;({}).Uncloak = function(arg_23_0)
	arg_23_0._attr.isCloak = 0
	arg_23_0._attr.airResistPierceActive = 0

	return
end
;({}).IsLockAimBias = function(arg_24_0)
	local var_24_0 = arg_24_0._attr.lockAimBias or 0

	return var_24_0 >= 1
end
;({}).IsUnitCldImmune = function(arg_25_0)
	local var_25_0 = arg_25_0._attr.unitCldImmune or 0

	return var_25_0 >= 1
end
;({}).UnitCldImmune = function(arg_26_0)
	local var_26_0 = arg_26_0._attr.unitCldImmune or 0

	arg_26_0._attr.unitCldImmune = var_26_0 + 1

	return
end
;({}).UnitCldEnable = function(arg_27_0)
	local var_27_0 = arg_27_0._attr.unitCldImmune or 0

	arg_27_0._attr.unitCldImmune = var_27_0 - 1

	return
end
;({}).GetCurrentTargetSelect = function(arg_28_0)
	local var_28_0

	for iter_28_0, iter_28_1 in ipairs((var_0_0.GetCurrent(arg_28_0, "TargetChoise"))) do
		if not var_28_0 or ys.Battle.BattleConfig.TARGET_SELECT_PRIORITY[iter_28_1] > ys.Battle.BattleConfig.TARGET_SELECT_PRIORITY[var_28_0] then
			var_28_0 = iter_28_1
		end
	end

	return var_28_0
end
;({}).AddTargetSelect = function(arg_29_0, arg_29_1)
	table.insert(var_0_0.GetCurrent(arg_29_0, "TargetChoise"), arg_29_1)

	return
end
;({}).RemoveTargetSelect = function(arg_30_0, arg_30_1)
	local var_30_0 = var_0_0.GetCurrent(arg_30_0, "TargetChoise")

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		if iter_30_1 == arg_30_1 then
			table.remove(var_30_0, iter_30_0)

			break
		end
	end

	return
end
;({}).GetCurrentGuardianID = function(arg_31_0)
	local var_31_0 = var_0_0.GetCurrent(arg_31_0, "guardian")

	if #var_31_0 == 0 then
		return nil
	else
		return var_31_0[#var_31_0]
	end

	return
end
;({}).AddGuardianID = function(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0.GetCurrent(arg_32_0, "guardian")

	if not table.contains(var_32_0, arg_32_1) then
		table.insert(var_32_0, arg_32_1)
	end

	return
end
;({}).RemoveGuardianID = function(arg_33_0, arg_33_1)
	local var_33_0 = var_0_0.GetCurrent(arg_33_0, "guardian")

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if iter_33_1 == arg_33_1 then
			table.remove(var_33_0, iter_33_0)

			return
		end
	end

	return
end
;({}).SetPlayerAttrFromOutBattle = function(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0._attr or {}

	arg_34_0._attr = var_34_0
	var_34_0.id = arg_34_1.id
	var_34_0.battleUID = arg_34_0:GetUniqueID()
	var_34_0.level = arg_34_1.level
	var_34_0.formulaLevel = arg_34_1.level
	var_34_0.maxHP = arg_34_1.durability
	var_34_0.HPRate = 1
	var_34_0.DMGRate = 0
	var_34_0.cannonPower = arg_34_1.cannon
	var_34_0.torpedoPower = arg_34_1.torpedo
	var_34_0.antiAirPower = arg_34_1.antiaircraft
	var_34_0.antiSubPower = arg_34_1.antisub or 0

	if arg_34_2 then
		var_34_0.baseAntiSubPower = arg_34_2.antisub or arg_34_1.antisub
		var_34_0.airPower = arg_34_1.air
		var_34_0.loadSpeed = arg_34_1.reload
		var_34_0.armorType = arg_34_1.armorType
		var_34_0.attackRating = arg_34_1.hit
		var_34_0.dodgeRate = arg_34_1.dodge
		var_34_0.velocity = ys.Battle.BattleFormulas.ConvertShipSpeed(arg_34_1.speed)
		var_34_0.baseVelocity = var_34_0.velocity
		var_34_0.luck = arg_34_1.luck
		var_34_0.repressReduce = arg_34_1.repressReduce or 1
		var_34_0.oxyMax = arg_34_1.oxy_max
		var_34_0.oxyCost = arg_34_1.oxy_cost
		var_34_0.oxyRecovery = arg_34_1.oxy_recovery
		var_34_0.oxyRecoverySurface = arg_34_1.oxy_recovery_surface
		var_34_0.oxyRecoveryBench = arg_34_1.oxy_recovery_bench
		var_34_0.oxyAtkDuration = arg_34_1.attack_duration
		var_34_0.raidDist = arg_34_1.raid_distance
		var_34_0.sonarRange = arg_34_1.sonarRange or 0

		if arg_34_2 then
			var_34_0.cloakExposeBase = arg_34_2.dodge + ys.Battle.BattleConfig.CLOAK_EXPOSE_CONST or 0
			var_34_0.cloakExposeExtra = 0
			var_34_0.cloakRestore = var_34_0.cloakExposeBase + var_34_0.cloakExposeExtra + ys.Battle.BattleConfig.CLOAK_BASE_RESTORE_DELTA
			var_34_0.cloakRecovery = ys.Battle.BattleConfig.CLOAK_RECOVERY
			var_34_0.cloakStrikeAdditive = ys.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE
			var_34_0.cloakBombardAdditive = ys.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE
			var_34_0.airResistPierce = ys.Battle.BattleConfig.BASE_ARP
			var_34_0.aimBias = 0
			var_34_0.aimBiasDecaySpeed = 0
			var_34_0.aimBiasDecaySpeedRatio = 0
			var_34_0.aimBiasExtraACC = 0
			var_34_0.baseScale = arg_34_1.scale / 50
			var_34_0.modelScale = var_34_0.baseScale
			var_34_0.healingRate = 1
			var_34_0.DMG_TAG_EHC_N_99 = arg_34_1[AttributeType.AntiSiren] or 0
			var_34_0.comboTag = "combo_" .. var_34_0.battleUID
			var_34_0.labelTag = {}
			var_34_0.barrageCounterMod = 1
			var_34_0.TargetChoise = {}
			var_34_0.guardian = {}
			var_34_0.injureRatioKamikazeAir = 1
			var_34_0.injureRatioKamikazeShip = 1
			var_34_0.nationality = arg_34_0:GetTemplate().nationality

			var_0_0.SetBaseAttr(arg_34_0)

			return
		end
	end
end
;({}).AttrFixer = function(arg_35_0, arg_35_1)
	if arg_35_0 == SYSTEM_SCENARIO then
		arg_35_1.repressReduce = ys.Battle.BattleDataProxy.GetInstance():GetRepressReduce()

		goto label_35_0
	end

	::label_35_0::

	if arg_35_0 ~= SYSTEM_DUEL then
		if arg_35_0 == SYSTEM_SHAM then
			local var_35_0, var_35_1 = ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_35_0, arg_35_1.level)

			arg_35_1.durability = arg_35_1.durability * var_35_0 + var_35_1
		end

		return
	end
end
;({}).InitDOTAttr = function(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(ys.Battle.BattleConfig.DOT_CONFIG) do
		for iter_36_2, iter_36_3 in pairs(iter_36_1) do
			arg_36_0[iter_36_3] = iter_36_2 == "hit" and (arg_36_1[iter_36_3] or ys.Battle.BattleConfig.DOT_CONFIG_DEFAULT[iter_36_2]) or ys.Battle.BattleConfig.DOT_CONFIG_DEFAULT[iter_36_2]
		end
	end

	return
end
;({}).SetEnemyAttr = function(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetLevel()
	local var_37_1 = arg_37_0._attr or {}

	arg_37_0._attr = var_37_1
	var_37_1.battleUID = arg_37_0:GetUniqueID()
	var_37_1.level = var_37_0
	var_37_1.formulaLevel = var_37_0
	var_37_1.maxHP = math.ceil(arg_37_0._tmpData.durability + arg_37_0._tmpData.durability_growth * ((var_37_0 - 1) / 1000))
	var_37_1.HPRate = 1
	var_37_1.DMGRate = 0
	var_37_1.cannonPower = arg_37_0._tmpData.cannon + arg_37_0._tmpData.cannon_growth * ((var_37_0 - 1) / 1000)
	var_37_1.torpedoPower = arg_37_0._tmpData.torpedo + arg_37_0._tmpData.torpedo_growth * ((var_37_0 - 1) / 1000)
	var_37_1.antiAirPower = arg_37_0._tmpData.antiaircraft + arg_37_0._tmpData.antiaircraft_growth * ((var_37_0 - 1) / 1000)
	var_37_1.airPower = arg_37_0._tmpData.air + arg_37_0._tmpData.air_growth * ((var_37_0 - 1) / 1000)
	var_37_1.antiSubPower = arg_37_0._tmpData.antisub + arg_37_0._tmpData.antisub_growth * ((var_37_0 - 1) / 1000)
	var_37_1.loadSpeed = arg_37_0._tmpData.reload + arg_37_0._tmpData.reload_growth * ((var_37_0 - 1) / 1000)
	var_37_1.armorType = arg_37_0._tmpData.armor_type
	var_37_1.attackRating = arg_37_0._tmpData.hit + arg_37_0._tmpData.hit_growth * ((var_37_0 - 1) / 1000)
	var_37_1.dodgeRate = arg_37_0._tmpData.dodge + arg_37_0._tmpData.dodge_growth * ((var_37_0 - 1) / 1000)
	var_37_1.velocity = ys.Battle.BattleFormulas.ConvertShipSpeed(arg_37_0._tmpData.speed + arg_37_0._tmpData.speed_growth * ((var_37_0 - 1) / 1000))
	var_37_1.baseVelocity = var_37_1.velocity
	var_37_1.luck = arg_37_0._tmpData.luck + arg_37_0._tmpData.luck_growth * ((var_37_0 - 1) / 1000)
	var_37_1.bulletSpeedRatio = 0
	var_37_1.id = "enemy_" .. tostring(arg_37_0._tmpData.id)
	var_37_1.nationality = arg_37_0._tmpData.nationality
	var_37_1.repressReduce = 1
	var_37_1.healingRate = 1
	var_37_1.comboTag = "combo_" .. var_37_1.battleUID
	var_37_1.baseScale = arg_37_0._tmpData.scale / 50
	var_37_1.modelScale = var_37_1.baseScale
	var_37_1.labelTag = {}
	var_37_1.TargetChoise = {}
	var_37_1.guardian = {}

	var_0_0.SetBaseAttr(arg_37_0)

	return
end
;({}).SetEnemyWorldEnhance = function(arg_38_0)
	arg_38_0._attr.maxHP = arg_38_0._attr.maxHP * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[1], arg_38_0._attr.level)
	arg_38_0._attr.cannonPower = arg_38_0._attr.cannonPower * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[2], arg_38_0._attr.level)
	arg_38_0._attr.torpedoPower = arg_38_0._attr.torpedoPower * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[3], arg_38_0._attr.level)
	arg_38_0._attr.antiAirPower = arg_38_0._attr.antiAirPower * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[4], arg_38_0._attr.level)
	arg_38_0._attr.airPower = arg_38_0._attr.airPower * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[5], arg_38_0._attr.level)
	arg_38_0._attr.attackRating = arg_38_0._attr.attackRating * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[6], arg_38_0._attr.level)
	arg_38_0._attr.dodgeRate = arg_38_0._attr.dodgeRate * ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_38_0._tmpData.world_enhancement[7], arg_38_0._attr.level)

	local var_38_0 = ys.Battle.BattleDataProxy.GetInstance():GetInitData()
	local var_38_1, var_38_2, var_38_3 = ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance(var_38_0.EnemyMapRewards, var_38_0.FleetMapRewards)

	arg_38_0._attr.cannonPower = arg_38_0._attr.cannonPower * (1 + var_38_1)
	arg_38_0._attr.torpedoPower = arg_38_0._attr.torpedoPower * (1 + var_38_1)
	arg_38_0._attr.airPower = arg_38_0._attr.airPower * (1 + var_38_1)
	arg_38_0._attr.antiAirPower = arg_38_0._attr.antiAirPower * (1 + var_38_1)
	arg_38_0._attr.antiSubPower = arg_38_0._attr.antiSubPower * (1 + var_38_1)
	arg_38_0._attr.maxHP = math.ceil(arg_38_0._attr.maxHP * (1 + var_38_2))
	arg_38_0._attr.worldBuffResistance = var_38_3

	var_0_0.SetBaseAttr(arg_38_0)

	return
end
;({}).SetMinionAttr = function(arg_39_0, arg_39_1)
	local var_39_0 = var_0_0.GetAttr((arg_39_0:GetMaster()))
	local var_39_1 = arg_39_0._tmpData
	local var_39_2 = arg_39_0._attr or {}

	arg_39_0._attr = var_39_2
	var_39_2.battleUID = arg_39_0:GetUniqueID()

	for iter_39_0, iter_39_1 in ipairs(var_0_0.AttrListInheritance) do
		var_39_2[iter_39_1] = var_39_0[iter_39_1]
	end

	for iter_39_2, iter_39_3 in pairs(var_39_0) do
		if string.find(iter_39_2, var_0_0.TAG_EHC_KEY) then
			var_39_2[iter_39_2] = iter_39_3
		end
	end

	for iter_39_4, iter_39_5 in pairs(var_39_0) do
		if string.find(iter_39_4, var_0_0.TAG_CRI_EHC_KEY) then
			var_39_2[iter_39_4] = iter_39_5
		end
	end

	var_39_2.id = var_39_0.id
	var_39_2.level = var_39_0.level
	var_39_2.formulaLevel = var_39_0.level
	var_39_2.baseScale = arg_39_0._tmpData.scale / 50
	var_39_2.modelScale = var_39_2.baseScale
	var_39_2.HPRate = 1
	var_39_2.DMGRate = 0

	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("durability", "maxHP")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("cannon", "cannonPower")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("torpedo", "torpedoPower")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("antiaircraft", "antiAirPower")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("air", "airPower")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("antisub", "antiSubPower")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("reload", "loadSpeed")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("hit", "attackRating")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("dodge", "dodgeRate")
	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("luck", "luck")

	var_39_2.armorType = arg_39_0._tmpData.armor_type

	;(function(arg_40_0, arg_40_1)
		var_39_2[arg_40_1] = var_39_1[arg_40_0 .. "_growth"] == 0 and var_39_1[arg_40_0] or var_39_1[arg_40_0 .. "_growth"] == -1 and (arg_40_0 == "durability" and var_0:GetCurrentHP() or var_39_0[arg_40_1]) or var_39_0[arg_40_1] * var_39_1[arg_40_0 .. "_growth"] * 0.0001

		return
	end)("speed", "velocity")

	var_39_2.velocity = ys.Battle.BattleFormulas.ConvertShipSpeed(var_39_2.velocity)
	var_39_2.baseVelocity = var_39_2.velocity
	var_39_2.bulletSpeedRatio = 0
	var_39_2.repressReduce = 1
	var_39_2.healingRate = 1
	var_39_2.comboTag = "combo_" .. var_39_2.battleUID
	var_39_2.labelTag = {}
	var_39_2.TargetChoise = {}
	var_39_2.guardian = {}
	var_39_2.nationality = arg_39_0._tmpData.nationality

	var_0_0.SetBaseAttr(arg_39_0)

	return
end
;({}).IsWorldMapRewardAttrWarning = function(arg_41_0, arg_41_1)
	for iter_41_0 = 1, 3 do
		local var_41_0 = arg_41_1[iter_41_0]

		if arg_41_0[iter_41_0] ~= 0 then
			local var_41_1 = arg_41_0[iter_41_0] or 1
			local var_41_2 = var_41_0 / var_41_1

			if var_41_2 < pg.gameset.world_mapbuff_tips.key_value / 16 then
				return true
			end
		end
	end

	return false
end
;({}).MonsterAttrFixer = function(arg_42_0, arg_42_1)
	if arg_42_0 == SYSTEM_SCENARIO then
		local var_42_0 = ys.Battle.BattleDataProxy.GetInstance()
		local var_42_1 = var_42_0:IsCompletelyRepress() and var_42_0:GetRepressLevel() or 0

		var_0_0.SetCurrent(arg_42_1, "formulaLevel", math.max(1, var_0_0.GetCurrent(arg_42_1, "level") - var_42_1))
	elseif arg_42_0 == SYSTEM_WORLD then
		var_0_0.SetEnemyWorldEnhance(arg_42_1)
	end

	return
end
;({}).SetAircraftAttFromMother = function(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._attr or {}

	arg_43_0._attr = var_43_0
	var_43_0.battleUID = arg_43_0:GetUniqueID()
	var_43_0.hostUID = arg_43_1:GetUniqueID()

	if not type(arg_43_1._attr.id) == "string" or string.find(arg_43_1._attr.id, "enemy_") == nil then
		var_43_0.id = arg_43_1._attr.id
	end

	local var_43_1 = var_0_0.GetAttr(arg_43_1)

	for iter_43_0, iter_43_1 in ipairs(var_0_0.AttrListInheritance) do
		var_43_0[iter_43_1] = var_43_1[iter_43_1]
	end

	for iter_43_2, iter_43_3 in pairs(var_43_1) do
		if string.find(iter_43_2, var_0_0.TAG_EHC_KEY) then
			var_43_0[iter_43_2] = iter_43_3
		end
	end

	for iter_43_4, iter_43_5 in pairs(var_43_1) do
		if string.find(iter_43_4, var_0_0.TAG_CRI_EHC_KEY) then
			var_43_0[iter_43_4] = iter_43_5
		end
	end

	var_43_0.armorType = 0
	var_43_0.velocity = var_0_0.GetCurrent(arg_43_1, "baseVelocity")
	var_43_0.labelTag = {}
	var_43_0.TargetChoise = {}
	var_43_0.guardian = {}
	var_43_0.comboTag = "combo_" .. var_43_0.hostUID

	return
end
;({}).SetAircraftAttFromTemp = function(arg_44_0)
	arg_44_0._attr = arg_44_0._attr or {}
	arg_44_0._attr.velocity = arg_44_0._attr.velocity or ys.Battle.BattleFormulas.ConvertAircraftSpeed(arg_44_0._tmpData.speed)

	local var_44_0 = arg_44_0._attr.level or 1
	local var_44_1 = arg_44_0._attr

	var_44_1.maxHP = arg_44_0._attr.maxHP or arg_44_0._tmpData.max_hp + arg_44_0._tmpData.hp_growth / 1000 * (var_44_0 - 1) + var_0_0.GetCurrent(arg_44_0, "hiveExtraHP")
	arg_44_0._attr.crashDMG = arg_44_0._tmpData.crash_DMG
	arg_44_0._attr.dodge = arg_44_0._tmpData.dodge
	arg_44_0._attr.dodgeLimit = arg_44_0._tmpData.dodge_limit

	return
end
;({}).SetAirFighterAttr = function(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._attr or {}

	arg_45_0._attr = var_45_0

	local var_45_1 = ys.Battle.BattleDataProxy.GetInstance()
	local var_45_2 = var_45_1:GetDungeonLevel()

	var_45_0.battleUID = arg_45_0:GetUniqueID()
	var_45_0.hostUID = 0
	var_45_0.id = 0
	var_45_0.level = var_45_2
	var_45_0.formulaLevel = var_45_2

	if var_45_1:IsCompletelyRepress() then
		var_45_0.formulaLevel = math.max(var_45_0.formulaLevel - 10, 1)
	end

	local var_45_3 = (var_45_2 - 1) / 1000

	var_45_0.maxHP = math.floor(arg_45_1.max_hp + arg_45_1.hp_growth * ((var_45_2 - 1) / 1000))
	var_45_0.attackRating = arg_45_1.accuracy + arg_45_1.ACC_growth * var_45_3
	var_45_0.dodge = arg_45_1.dodge
	var_45_0.dodgeLimit = arg_45_1.dodge_limit
	var_45_0.cannonPower = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3
	var_45_0.torpedoPower = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3
	var_45_0.antiAirPower = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3
	var_45_0.antiSubPower = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3
	var_45_0.airPower = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3
	var_45_0.loadSpeed = 0
	var_45_0.armorType = 1
	var_45_0.dodgeRate = 0
	var_45_0.luck = 50
	var_45_0.velocity = ys.Battle.BattleFormulas.ConvertAircraftSpeed(arg_45_1.speed)
	var_45_0.repressReduce = 1
	var_45_0.TargetChoise = {}
	var_45_0.guardian = {}
	var_45_0.crashDMG = arg_45_1.crash_DMG

	return
end
;({}).SetFusionAttrFromElement = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = var_0_0.GetAttr(arg_46_1)
	local var_46_1 = arg_46_0._attr or {}

	arg_46_0._attr = var_46_1
	var_46_1.id = var_46_0.id
	var_46_1.level = var_46_0.level
	var_46_1.formulaLevel = var_46_0.level
	var_46_1.battleUID = arg_46_0:GetUniqueID()

	for iter_46_0, iter_46_1 in ipairs(var_0_0.AttrListInheritance) do
		var_46_1[iter_46_1] = var_46_0[iter_46_1]
	end

	for iter_46_2, iter_46_3 in pairs(var_46_0) do
		if string.find(iter_46_2, var_0_0.TAG_EHC_KEY) then
			var_46_1[iter_46_2] = iter_46_3
		end
	end

	for iter_46_4, iter_46_5 in pairs(var_46_0) do
		if string.find(iter_46_4, var_0_0.TAG_CRI_EHC_KEY) then
			var_46_1[iter_46_4] = iter_46_5
		end
	end

	local var_46_2 = arg_46_1:GetHP()

	for iter_46_6, iter_46_7 in ipairs(arg_46_2) do
		var_46_2 = var_46_2 + iter_46_7:GetHP()
	end

	var_46_1.maxHP = var_46_2
	var_46_1.hpProvideRate = {}
	var_46_1.hpProvideRate[var_0_0.GetCurrent(arg_46_1, "id")] = arg_46_1:GetHP() / var_46_2

	for iter_46_8, iter_46_9 in ipairs(arg_46_2) do
		var_46_1.hpProvideRate[var_0_0.GetCurrent(iter_46_9, "id")] = iter_46_9:GetHP() / var_46_2
	end

	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("cannonPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("torpedoPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("antiAirPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("antiSubPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("baseAntiSubPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("airPower")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("loadSpeed")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("attackRating")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("dodgeRate")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("luck")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("velocity")
	;(function(arg_47_0)
		local var_47_0 = arg_46_3[arg_47_0] or 1

		var_46_1[arg_47_0] = var_0_0.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("baseVelocity")

	var_46_1.armorType = var_0_0.GetCurrent(arg_46_1, "armorType")
	var_46_1.aimBias = 0
	var_46_1.aimBiasDecaySpeed = 0
	var_46_1.aimBiasDecaySpeedRatio = 0
	var_46_1.aimBiasExtraACC = 0
	var_46_1.healingRate = 1
	var_46_1.comboTag = "combo_" .. var_46_1.battleUID
	var_46_1.labelTag = {}
	var_46_1.barrageCounterMod = 1
	var_46_1.TargetChoise = {}
	var_46_1.guardian = {}

	var_0_0.SetBaseAttr(arg_46_0)

	return
end
;({}).FlashByBuff = function(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0._baseAttr[arg_48_1] or 0

	arg_48_0._attr[arg_48_1] = arg_48_2 + var_48_0

	if string.find(arg_48_1, var_0_0.FROM_TAG_EHC_KEY) then
		local var_48_1 = 0

		for iter_48_0, iter_48_1 in pairs(arg_48_0._attr) do
			if string.find(iter_48_0, var_0_0.FROM_TAG_EHC_KEY) and iter_48_1 ~= 0 then
				var_48_1 = 1

				break
			end
		end

		var_0_0.SetCurrent(arg_48_0, var_0_0.FROM_TAG_EHC_KEY, var_48_1)
	end

	return
end
;({}).FlashVelocity = function(arg_49_0, arg_49_1, arg_49_2)
	var_0_0.SetCurrent(arg_49_0, "velocity", (Mathf.Clamp(arg_49_0._baseAttr.velocity * arg_49_1 + arg_49_2, var_0_0.GetBase(arg_49_0, "velocity") * 0.2, var_0_0.GetBase(arg_49_0, "velocity") * 1.8)))

	return
end
;({}).HasSonar = function(arg_50_0)
	return ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[arg_50_0:GetTemplate().type] ~= nil
end
;({}).SetCurrent = function(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0._attr[arg_51_1] = arg_51_2

	return
end
;({}).GetCurrent = function(arg_52_0, arg_52_1)
	local var_52_0 = AttributeType.IsPrimalBattleAttr(arg_52_1) or false

	return var_0_0._attrFunc[var_52_0](arg_52_0, arg_52_1)
end
;({})._getPrimalAttr = function(arg_53_0, arg_53_1)
	return math.max(arg_53_0._attr[arg_53_1], 0)
end
;({})._getSecondaryAttr = function(arg_54_0, arg_54_1)
	return arg_54_0._attr[arg_54_1] or 0
end
;({})._attrFunc = {
	[true] = ({})._getPrimalAttr,
	[false] = ({})._getSecondaryAttr
}
;({}).GetBase = function(arg_55_0, arg_55_1)
	return arg_55_0._baseAttr[arg_55_1] or 0
end
;({}).GetCurrentTags = function(arg_56_0)
	return arg_56_0._attr.labelTag or {}
end
;({}).Increase = function(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 then
		local var_57_0 = arg_57_0._attr[arg_57_1] or 0

		arg_57_0._attr[arg_57_1] = var_57_0 + arg_57_2
	end

	return
end
;({}).RatioIncrease = function(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_2 then
		arg_58_0._attr[arg_58_1] = arg_58_0._attr[arg_58_1] + arg_58_0._baseAttr[arg_58_1] * arg_58_2 / 16
	end

	return
end
;({}).GetTagAttr = function(arg_59_0, arg_59_1, arg_59_2)
	for iter_59_0, iter_59_1 in ipairs((arg_59_1:GetLabelTag())) do
		({})[var_0_0.TAG_EHC_KEY .. iter_59_1] = true
	end

	local var_59_0 = 1

	for iter_59_2, iter_59_3 in pairs({}) do
		local var_59_1 = var_0_0.GetCurrent(arg_59_0, iter_59_2)

		if var_59_1 ~= 0 then
			if arg_59_2 then
				var_59_1 = ys.Battle.BattleDataFunction.GetLimitAttributeRange(iter_59_2, var_59_1)
			end

			var_59_0 = var_59_0 * (1 + var_59_1)
		end
	end

	if var_0_0.GetCurrent(arg_59_1, var_0_0.FROM_TAG_EHC_KEY) > 0 then
		local var_59_2 = var_0_0.FROM_TAG_EHC_KEY .. arg_59_0:GetWeaponTempData().attack_attribute .. "_"

		for iter_59_4, iter_59_5 in pairs((var_0_0.GetCurrentTags(arg_59_0))) do
			if iter_59_5 > 0 then
				local var_59_3 = var_0_0.GetCurrent(arg_59_1, var_59_2 .. iter_59_4)

				if var_59_3 ~= 0 then
					var_59_0 = var_59_0 * (1 + var_59_3)
				end
			end
		end
	end

	return var_59_0
end
;({}).GetTagAttrCri = function(arg_60_0, arg_60_1)
	for iter_60_0, iter_60_1 in ipairs((arg_60_1:GetLabelTag())) do
		({})[var_0_0.TAG_CRI_EHC_KEY .. iter_60_1] = true
	end

	local var_60_0 = 0

	for iter_60_2, iter_60_3 in pairs({}) do
		local var_60_1 = var_0_0.GetCurrent(arg_60_0, iter_60_2)

		if var_60_1 ~= 0 then
			var_60_0 = var_60_0 + var_60_1
		end
	end

	return var_60_0
end
;({}).GetTagAttrCriDmg = function(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in ipairs((arg_61_1:GetLabelTag())) do
		({})[var_0_0.TAG_CRIDMG_EHC_KEY .. iter_61_1] = true
	end

	local var_61_0 = 0

	for iter_61_2, iter_61_3 in pairs({}) do
		local var_61_1 = var_0_0.GetCurrent(arg_61_0, iter_61_2)

		if var_61_1 ~= 0 then
			var_61_0 = var_61_0 + var_61_1
		end
	end

	return var_61_0
end

return
