ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}

local var_0_1 = ys
local var_0_2 = {}

ys = var_0_10001

local var_0_3 = var_0_10001.Battle

var_0_3.BattleAttr = var_0_2
ys = var_0_3

local var_0_4 = var_0_3.Battle.BattleConst

var_0_2.AttrListInheritance = {
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

function var_0_2.InsertInheritedAttr(arg_1_0)
	pairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(arg_1_0) do
		var_0_2.AttrListInheritance[#var_0_2.AttrListInheritance + 1] = iter_1_1
	end

	return
end

local var_0_5 = var_0_2.InsertInheritedAttr

ys = var_0_10004

var_0_5(var_0_10004.Battle.BattleConfig.AMMO_DAMAGE_ENHANCE)

local var_0_6 = var_0_2.InsertInheritedAttr

ys = var_4

var_0_6(var_4.Battle.BattleConfig.AMMO_DAMAGE_REDUCE)

local var_0_7 = var_0_2.InsertInheritedAttr

ys = var_4

var_0_7(var_4.Battle.BattleConfig.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE)

local var_0_8 = var_0_2.InsertInheritedAttr

ys = var_4

var_0_8(var_4.Battle.BattleConfig.DAMAGE_TO_ARMOR_RATE_ENHANCE)

local var_0_9 = var_0_2.InsertInheritedAttr

ys = var_4

var_0_9(var_4.Battle.BattleConfig.SHIP_TYPE_ACCURACY_ENHANCE)

var_0_2.TAG_EHC_KEY = "DMG_TAG_EHC_"
var_0_2.FROM_TAG_EHC_KEY = "DMG_FROM_TAG_"
var_0_2.TAG_CRI_EHC_KEY = "CRI_TAG_EHC_"
var_0_2.TAG_CRIDMG_EHC_KEY = "CRIDMG_TAG_EHC_"
var_0_2.ATTACK_ATTR_TYPE = {
	[var_0_4.WeaponDamageAttr.CANNON] = "cannonPower",
	[var_0_4.WeaponDamageAttr.TORPEDO] = "torpedoPower",
	[var_0_4.WeaponDamageAttr.ANTI_AIR] = "antiAirPower",
	[var_0_4.WeaponDamageAttr.AIR] = "airPower",
	[var_0_4.WeaponDamageAttr.ANIT_SUB] = "antiSubPower"
}

function var_0_2.GetAtkAttrByType(arg_2_0, arg_2_1)
	local var_2_0 = var_0_2.ATTACK_ATTR_TYPE[arg_2_1]

	math = var_1_10003

	return var_1_10003.max(arg_2_0[var_2_0], 0)
end

function var_0_2.SetAttr(arg_3_0, arg_3_1)
	setmetatable = var_1_10002
	arg_3_0._attr = var_1_10002({}, {
		__index = arg_3_1
	})

	return
end

function var_0_2.GetAttr(arg_4_0)
	return arg_4_0._attr
end

function var_0_2.SetBaseAttr(arg_5_0)
	Clone = var_1_10001
	arg_5_0._baseAttr = var_1_10001(arg_5_0._attr)

	return
end

function var_0_2.IsInvincible(arg_6_0)
	return arg_6_0._attr.isInvincible and var_1 > 0
end

function var_0_2.AppendInvincible(arg_7_0)
	local var_7_0

	if not arg_7_0._attr.isInvincible then
		var_7_0 = 0
	end

	arg_7_0._attr.isInvincible = var_7_0 + 1

	return
end

function var_0_2.AddImmuneAreaLimit(arg_8_0, arg_8_1)
	local var_8_0

	if not arg_8_0._attr.immuneAreaLimit then
		var_8_0 = 0
	end

	local var_8_1 = var_8_0 + arg_8_1

	arg_8_0._attr.immuneAreaLimit = var_8_1

	local var_8_2 = arg_8_0._move

	var_3.ImmuneAreaLimit(var_8_2, var_8_1 > 0)

	return
end

function var_0_2.AddImmuneMaxAreaLimit(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_0._attr.immuneMaxAreaLimit then
		var_9_0 = 0
	end

	local var_9_1 = var_9_0 + arg_9_1

	arg_9_0._attr.immuneMaxAreaLimit = var_9_1

	local var_9_2 = arg_9_0._move

	var_3.ImmuneMaxAreaLimit(var_9_2, var_9_1 > 0)

	return
end

function var_0_2.IsImmuneAreaLimit(arg_10_0)
	return arg_10_0._attr.immuneAreaLimit and var_1 > 0
end

function var_0_2.IsImmuneMaxAreaLimit(arg_11_0)
	return arg_11_0._attr.immuneMaxAreaLimit and var_1 > 0
end

function var_0_2.IsVisitable(arg_12_0)
	return not arg_12_0._attr.isUnVisitable or var_1 <= 0
end

function var_0_2.UnVisitable(arg_13_0)
	local var_13_0

	if not arg_13_0._attr.isUnVisitable then
		var_13_0 = 0
	end

	arg_13_0._attr.isUnVisitable = var_13_0 + 1

	return
end

function var_0_2.Visitable(arg_14_0)
	local var_14_0

	if not arg_14_0._attr.isUnVisitable then
		var_14_0 = 0
	end

	arg_14_0._attr.isUnVisitable = var_14_0 - 1

	return
end

function var_0_2.IsSpirit(arg_15_0)
	return arg_15_0._attr.isSpirit and var_1 > 0
end

function var_0_2.Spirit(arg_16_0)
	local var_16_0

	if not arg_16_0._attr.isSpirit then
		var_16_0 = 0
	end

	arg_16_0._attr.isSpirit = var_16_0 + 1

	return
end

function var_0_2.Entity(arg_17_0)
	local var_17_0

	if not arg_17_0._attr.isSpirit then
		var_17_0 = 0
	end

	arg_17_0._attr.isSpirit = var_17_0 - 1

	return
end

function var_0_2.IsStun(arg_18_0)
	return arg_18_0._attr.isStun and var_1 > 0
end

function var_0_2.Stun(arg_19_0)
	local var_19_0

	if not arg_19_0._attr.isStun then
		var_19_0 = 0
	end

	arg_19_0._attr.isStun = var_19_0 + 1

	return
end

function var_0_2.CancelStun(arg_20_0)
	local var_20_0

	if not arg_20_0._attr.isStun then
		var_20_0 = 0
	end

	arg_20_0._attr.isStun = var_20_0 - 1

	return
end

function var_0_2.IsCloak(arg_21_0)
	local var_21_0

	if not arg_21_0._attr.isCloak then
		var_21_0 = 0
	end

	return var_21_0 == 1
end

function var_0_2.Cloak(arg_22_0)
	arg_22_0._attr.isCloak = 1
	arg_22_0._attr.airResistPierceActive = 1

	return
end

function var_0_2.Uncloak(arg_23_0)
	arg_23_0._attr.isCloak = 0
	arg_23_0._attr.airResistPierceActive = 0

	return
end

function var_0_2.IsLockAimBias(arg_24_0)
	local var_24_0

	if not arg_24_0._attr.lockAimBias then
		var_24_0 = 0
	end

	return var_24_0 >= 1
end

function var_0_2.IsUnitCldImmune(arg_25_0)
	local var_25_0

	if not arg_25_0._attr.unitCldImmune then
		var_25_0 = 0
	end

	return var_25_0 >= 1
end

function var_0_2.UnitCldImmune(arg_26_0)
	local var_26_0

	if not arg_26_0._attr.unitCldImmune then
		var_26_0 = 0
	end

	arg_26_0._attr.unitCldImmune = var_26_0 + 1

	return
end

function var_0_2.UnitCldEnable(arg_27_0)
	local var_27_0

	if not arg_27_0._attr.unitCldImmune then
		var_27_0 = 0
	end

	arg_27_0._attr.unitCldImmune = var_27_0 - 1

	return
end

function var_0_2.GetCurrentTargetSelect(arg_28_0)
	local var_28_0
	local var_28_1 = var_0_2.GetCurrent(arg_28_0, "TargetChoise")

	ys = var_1_10003

	local var_28_2 = var_1_10003.Battle.BattleConfig.TARGET_SELECT_PRIORITY

	ipairs = var_4

	for iter_28_0, iter_28_1 in var_4(var_28_1) do
		if not var_28_0 or var_28_2[iter_28_1] > var_28_2[var_28_0] then
			var_28_0 = iter_28_1
		end
	end

	return var_28_0
end

function var_0_2.AddTargetSelect(arg_29_0, arg_29_1)
	table = var_1_10002

	var_1_10002.insert(var_0_2.GetCurrent(arg_29_0, "TargetChoise"), arg_29_1)

	return
end

function var_0_2.RemoveTargetSelect(arg_30_0, arg_30_1)
	local var_30_0 = var_0_2.GetCurrent(arg_30_0, "TargetChoise")

	ipairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(var_30_0) do
		if iter_30_1 == arg_30_1 then
			table = var_1_10008

			var_1_10008.remove(var_30_0, iter_30_0)

			break
		end
	end

	return
end

function var_0_2.GetCurrentGuardianID(arg_31_0)
	if #var_0_2.GetCurrent(arg_31_0, "guardian") == 0 then
		return nil
	else
		return var_1[var_2]
	end

	return
end

function var_0_2.AddGuardianID(arg_32_0, arg_32_1)
	local var_32_0 = var_0_2.GetCurrent(arg_32_0, "guardian")

	table = var_1_10003

	if not var_1_10003.contains(var_32_0, arg_32_1) then
		table = var_3

		var_3.insert(var_32_0, arg_32_1)
	end

	return
end

function var_0_2.RemoveGuardianID(arg_33_0, arg_33_1)
	local var_33_0 = var_0_2.GetCurrent(arg_33_0, "guardian")

	ipairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(var_33_0) do
		if iter_33_1 == arg_33_1 then
			table = var_1_10008

			var_1_10008.remove(var_33_0, iter_33_0)

			return
		end
	end

	return
end

function var_0_2.SetPlayerAttrFromOutBattle(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0._attr then
		var_34_0 = {}
	end

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

	local var_34_1

	if not arg_34_1.antisub then
		var_34_1 = 0
	end

	var_34_0.antiSubPower = var_34_1

	local var_34_2

	if not arg_34_2 or not arg_34_2.antisub then
		var_34_2 = arg_34_1.antisub
	end

	var_34_0.baseAntiSubPower = var_34_2
	var_34_0.airPower = arg_34_1.air
	var_34_0.loadSpeed = arg_34_1.reload
	var_34_0.armorType = arg_34_1.armorType
	var_34_0.attackRating = arg_34_1.hit
	var_34_0.dodgeRate = arg_34_1.dodge
	ys = var_4
	var_34_0.velocity = var_4.Battle.BattleFormulas.ConvertShipSpeed(arg_34_1.speed)
	var_34_0.baseVelocity = var_34_0.velocity
	var_34_0.luck = arg_34_1.luck

	local var_34_3

	if not arg_34_1.repressReduce then
		var_34_3 = 1
	end

	var_34_0.repressReduce = var_34_3
	var_34_0.oxyMax = arg_34_1.oxy_max
	var_34_0.oxyCost = arg_34_1.oxy_cost
	var_34_0.oxyRecovery = arg_34_1.oxy_recovery
	var_34_0.oxyRecoverySurface = arg_34_1.oxy_recovery_surface
	var_34_0.oxyRecoveryBench = arg_34_1.oxy_recovery_bench
	var_34_0.oxyAtkDuration = arg_34_1.attack_duration
	var_34_0.raidDist = arg_34_1.raid_distance

	local var_34_4

	if not arg_34_1.sonarRange then
		var_34_4 = 0
	end

	var_34_0.sonarRange = var_34_4

	if arg_34_2 then
		local var_34_5 = arg_34_2.dodge

		ys = var_1_10005

		local var_34_6

		if not (var_34_5 + var_1_10005.Battle.BattleConfig.CLOAK_EXPOSE_CONST) then
			var_34_6 = 0
		end

		var_34_0.cloakExposeBase = var_34_6
		var_34_0.cloakExposeExtra = 0

		local var_34_7 = var_34_0.cloakExposeBase + var_34_0.cloakExposeExtra

		ys = var_5
		var_34_0.cloakRestore = var_34_7 + var_5.Battle.BattleConfig.CLOAK_BASE_RESTORE_DELTA
		ys = var_4
		var_34_0.cloakRecovery = var_4.Battle.BattleConfig.CLOAK_RECOVERY
		ys = var_4
		var_34_0.cloakStrikeAdditive = var_4.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE
		ys = var_4
		var_34_0.cloakBombardAdditive = var_4.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE
		ys = var_4
		var_34_0.airResistPierce = var_4.Battle.BattleConfig.BASE_ARP
		var_34_0.aimBias = 0
		var_34_0.aimBiasDecaySpeed = 0
		var_34_0.aimBiasDecaySpeedRatio = 0
		var_34_0.aimBiasExtraACC = 0
		var_34_0.baseScale = arg_34_1.scale / 50
		var_34_0.modelScale = var_34_0.baseScale
		var_34_0.healingRate = 1
		AttributeType = var_4

		local var_34_8

		if not arg_34_1[var_4.AntiSiren] then
			var_34_8 = 0
		end

		var_34_0.DMG_TAG_EHC_N_99 = var_34_8
		var_34_0.comboTag = "combo_" .. var_34_0.battleUID
		var_34_0.labelTag = {}
		var_34_0.barrageCounterMod = 1
		var_34_0.TargetChoise = {}
		var_34_0.guardian = {}
		var_34_0.injureRatioKamikazeAir = 1
		var_34_0.injureRatioKamikazeShip = 1
		var_34_0.nationality = arg_34_0:GetTemplate().nationality

		var_0_2.SetBaseAttr(arg_34_0)

		return
	end
end

function var_0_2.AttrFixer(arg_35_0, arg_35_1)
	SYSTEM_SCENARIO = var_1_10002

	if arg_35_0 == var_1_10002 then
		ys = var_1_10002

		local var_35_0 = var_1_10002.Battle.BattleDataProxy.GetInstance()

		arg_35_1.repressReduce = var_1_10002.GetRepressReduce(var_35_0)

		goto label_35_0
	end

	SYSTEM_DUEL = var_1_10002

	if arg_35_0 ~= var_1_10002 then
		SYSTEM_SHAM = var_1_10002

		if arg_35_0 == var_1_10002 then
			local var_35_1 = arg_35_1.level
			local var_35_2 = arg_35_1.durability

			ys = var_1_10004

			local var_35_3, var_35_4 = var_1_10004.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_35_0, var_35_1)

			arg_35_1.durability = var_35_2 * var_35_3 + var_35_4
		end

		::label_35_0::

		return
	end
end

function var_0_2.InitDOTAttr(arg_36_0, arg_36_1)
	ys = var_1_10002

	local var_36_0 = var_1_10002.Battle.BattleConfig.DOT_CONFIG_DEFAULT

	ys = var_1_10003

	local var_36_1 = var_1_10003.Battle.BattleConfig.DOT_CONFIG

	ipairs = var_1_10004

	for iter_36_0, iter_36_1 in var_1_10004(var_36_1) do
		pairs = var_1_10009

		for iter_36_2, iter_36_3 in var_1_10009(iter_36_1) do
			if iter_36_2 == "hit" then
				local var_36_2

				if not arg_36_1[iter_36_3] then
					var_36_2 = var_36_0[iter_36_2]
				end

				arg_36_0[iter_36_3] = var_36_2
			else
				arg_36_0[iter_36_3] = var_36_0[iter_36_2]
			end
		end
	end

	return
end

function var_0_2.SetEnemyAttr(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._tmpData
	local var_37_1 = arg_37_0:GetLevel()
	local var_37_2

	if not arg_37_0._attr then
		var_37_2 = {}
	end

	arg_37_0._attr = var_37_2
	var_37_2.battleUID = arg_37_0:GetUniqueID()
	var_37_2.level = var_37_1
	var_37_2.formulaLevel = var_37_1

	local var_37_3 = (var_37_1 - 1) / 1000

	math = var_1_10006
	var_37_2.maxHP = var_1_10006.ceil(var_37_0.durability + var_37_0.durability_growth * var_37_3)
	var_37_2.HPRate = 1
	var_37_2.DMGRate = 0
	var_37_2.cannonPower = var_37_0.cannon + var_37_0.cannon_growth * var_37_3
	var_37_2.torpedoPower = var_37_0.torpedo + var_37_0.torpedo_growth * var_37_3
	var_37_2.antiAirPower = var_37_0.antiaircraft + var_37_0.antiaircraft_growth * var_37_3
	var_37_2.airPower = var_37_0.air + var_37_0.air_growth * var_37_3
	var_37_2.antiSubPower = var_37_0.antisub + var_37_0.antisub_growth * var_37_3
	var_37_2.loadSpeed = var_37_0.reload + var_37_0.reload_growth * var_37_3
	var_37_2.armorType = var_37_0.armor_type
	var_37_2.attackRating = var_37_0.hit + var_37_0.hit_growth * var_37_3
	var_37_2.dodgeRate = var_37_0.dodge + var_37_0.dodge_growth * var_37_3
	ys = var_6
	var_37_2.velocity = var_6.Battle.BattleFormulas.ConvertShipSpeed(var_37_0.speed + var_37_0.speed_growth * var_37_3)
	var_37_2.baseVelocity = var_37_2.velocity
	var_37_2.luck = var_37_0.luck + var_37_0.luck_growth * var_37_3
	var_37_2.bulletSpeedRatio = 0

	local var_37_4 = "enemy_"

	tostring = var_7
	var_37_2.id = var_37_4 .. var_7(var_37_0.id)
	var_37_2.nationality = var_37_0.nationality
	var_37_2.repressReduce = 1
	var_37_2.healingRate = 1
	var_37_2.comboTag = "combo_" .. var_37_2.battleUID
	var_37_2.baseScale = var_37_0.scale / 50
	var_37_2.modelScale = var_37_2.baseScale
	var_37_2.labelTag = {}
	var_37_2.TargetChoise = {}
	var_37_2.guardian = {}

	var_0_2.SetBaseAttr(arg_37_0)

	return
end

function var_0_2.SetEnemyWorldEnhance(arg_38_0)
	local var_38_0 = arg_38_0._tmpData
	local var_38_1 = arg_38_0._attr.level

	ys = var_1_10004

	local var_38_2 = var_1_10004.Battle.BattleDataProxy.GetInstance()
	local var_38_3 = var_38_0.world_enhancement

	ys = var_1_10006

	local var_38_4 = var_1_10006.Battle.BattleFormulas

	var_2.maxHP = var_2.maxHP * var_38_4.WorldEnemyAttrEnhance(var_38_3[1], var_38_1)
	var_2.cannonPower = var_2.cannonPower * var_38_4.WorldEnemyAttrEnhance(var_38_3[2], var_38_1)
	var_2.torpedoPower = var_2.torpedoPower * var_38_4.WorldEnemyAttrEnhance(var_38_3[3], var_38_1)
	var_2.antiAirPower = var_2.antiAirPower * var_38_4.WorldEnemyAttrEnhance(var_38_3[4], var_38_1)
	var_2.airPower = var_2.airPower * var_38_4.WorldEnemyAttrEnhance(var_38_3[5], var_38_1)
	var_2.attackRating = var_2.attackRating * var_38_4.WorldEnemyAttrEnhance(var_38_3[6], var_38_1)
	var_2.dodgeRate = var_2.dodgeRate * var_38_4.WorldEnemyAttrEnhance(var_38_3[7], var_38_1)

	local var_38_5 = var_38_2:GetInitData()
	local var_38_6, var_38_7, var_38_8 = var_38_4.WorldMapRewardAttrEnhance(var_38_5.EnemyMapRewards, var_38_5.FleetMapRewards)

	var_2.cannonPower = var_2.cannonPower * (1 + var_38_6)
	var_2.torpedoPower = var_2.torpedoPower * (1 + var_38_6)
	var_2.airPower = var_2.airPower * (1 + var_38_6)
	var_2.antiAirPower = var_2.antiAirPower * (1 + var_38_6)
	var_2.antiSubPower = var_2.antiSubPower * (1 + var_38_6)
	math = var_11
	var_2.maxHP = var_11.ceil(var_2.maxHP * (1 + var_38_7))
	var_2.worldBuffResistance = var_38_8

	var_0_2.SetBaseAttr(arg_38_0)

	return
end

function var_0_2.SetMinionAttr(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:GetMaster()
	local var_39_1 = var_0_2.GetAttr(var_39_0)
	local var_39_2 = arg_39_0._tmpData
	local var_39_3 = var_39_1.level
	local var_39_4

	if not arg_39_0._attr then
		var_39_4 = {}
	end

	arg_39_0._attr = var_39_4
	var_39_4.battleUID = arg_39_0:GetUniqueID()
	ipairs = var_7

	for iter_39_0, iter_39_1 in var_7(var_0_2.AttrListInheritance) do
		var_39_4[iter_39_1] = var_39_1[iter_39_1]
	end

	pairs = var_7

	for iter_39_2, iter_39_3 in var_7(var_39_1) do
		string = var_1_10012

		if var_1_10012.find(iter_39_2, var_0_2.TAG_EHC_KEY) then
			var_39_4[iter_39_2] = iter_39_3
		end
	end

	pairs = var_7

	for iter_39_4, iter_39_5 in var_7(var_39_1) do
		string = var_1_10012

		if var_1_10012.find(iter_39_4, var_0_2.TAG_CRI_EHC_KEY) then
			var_39_4[iter_39_4] = iter_39_5
		end
	end

	var_39_4.id = var_39_1.id
	var_39_4.level = var_39_3
	var_39_4.formulaLevel = var_39_3
	var_39_4.baseScale = var_39_2.scale / 50
	var_39_4.modelScale = var_39_4.baseScale

	local function var_39_5(arg_40_0, arg_40_1)
		if var_39_2[arg_40_0 .. "_growth"] == 0 then
			var_39_4[arg_40_1] = var_39_2[arg_40_0]
		elseif var_2 == -1 then
			if arg_40_0 == "durability" then
				local var_40_0 = var_39_4
				local var_40_1 = var_39_0

				var_40_0[arg_40_1] = var_4.GetCurrentHP(var_40_1)
			else
				var_39_4[arg_40_1] = var_39_1[arg_40_1]
			end
		else
			var_39_4[arg_40_1] = var_39_1[arg_40_1] * var_2 * 0.0001
		end

		return
	end

	var_39_4.HPRate = 1
	var_39_4.DMGRate = 0

	var_39_5("durability", "maxHP")
	var_39_5("cannon", "cannonPower")
	var_39_5("torpedo", "torpedoPower")
	var_39_5("antiaircraft", "antiAirPower")
	var_39_5("air", "airPower")
	var_39_5("antisub", "antiSubPower")
	var_39_5("reload", "loadSpeed")
	var_39_5("hit", "attackRating")
	var_39_5("dodge", "dodgeRate")
	var_39_5("luck", "luck")

	var_39_4.armorType = var_39_2.armor_type

	var_39_5("speed", "velocity")

	ys = var_8
	var_39_4.velocity = var_8.Battle.BattleFormulas.ConvertShipSpeed(var_39_4.velocity)
	var_39_4.baseVelocity = var_39_4.velocity
	var_39_4.bulletSpeedRatio = 0
	var_39_4.repressReduce = 1
	var_39_4.healingRate = 1
	var_39_4.comboTag = "combo_" .. var_39_4.battleUID
	var_39_4.labelTag = {}
	var_39_4.TargetChoise = {}
	var_39_4.guardian = {}
	var_39_4.nationality = var_39_2.nationality

	var_0_2.SetBaseAttr(arg_39_0)

	return
end

function var_0_2.IsWorldMapRewardAttrWarning(arg_41_0, arg_41_1)
	for iter_41_0 = 1, 3 do
		local var_41_0 = arg_41_1[iter_41_0]
		local var_41_1

		if arg_41_0[iter_41_0] == 0 or not arg_41_0[iter_41_0] then
			var_41_1 = 1
		end

		local var_41_2 = var_41_0 / var_41_1

		pg = var_41_1

		if var_41_2 < var_41_1.gameset.world_mapbuff_tips.key_value / 16 then
			return true
		end
	end

	return false
end

function var_0_2.MonsterAttrFixer(arg_42_0, arg_42_1)
	SYSTEM_SCENARIO = var_1_10002

	if arg_42_0 == var_1_10002 then
		ys = var_1_10002

		local var_42_0 = var_1_10002.Battle.BattleDataProxy.GetInstance()
		local var_42_1

		if not var_1_10002.IsCompletelyRepress(var_42_0) or not var_1_10002:GetRepressLevel() then
			var_42_1 = 0
		end

		local var_42_2 = var_0_2.GetCurrent(arg_42_1, "level")
		local var_42_3 = var_0_2.SetCurrent
		local var_42_4 = arg_42_1
		local var_42_5 = "formulaLevel"

		math = var_1_10009

		var_42_3(var_42_4, var_42_5, var_1_10009.max(1, var_42_2 - var_42_1))
	else
		SYSTEM_WORLD = var_1_10002

		if arg_42_0 == var_1_10002 then
			var_0_2.SetEnemyWorldEnhance(arg_42_1)
		end
	end

	return
end

function var_0_2.SetAircraftAttFromMother(arg_43_0, arg_43_1)
	local var_43_0

	if not arg_43_0._attr then
		var_43_0 = {}
	end

	arg_43_0._attr = var_43_0
	var_43_0.battleUID = arg_43_0:GetUniqueID()
	var_43_0.hostUID = arg_43_1:GetUniqueID()
	type = var_3

	if not var_3(arg_43_1._attr.id) ~= "string" then
		string = var_3

		if var_3.find(arg_43_1._attr.id, "enemy_") == nil then
			var_43_0.id = arg_43_1._attr.id
		end

		local var_43_1 = var_0_2.GetAttr(arg_43_1)

		ipairs = var_1_10004

		for iter_43_0, iter_43_1 in var_1_10004(var_0_2.AttrListInheritance) do
			var_43_0[iter_43_1] = var_43_1[iter_43_1]
		end

		pairs = var_4

		for iter_43_2, iter_43_3 in var_4(var_43_1) do
			string = var_1_10009

			if var_1_10009.find(iter_43_2, var_0_2.TAG_EHC_KEY) then
				var_43_0[iter_43_2] = iter_43_3
			end
		end

		pairs = var_4

		for iter_43_4, iter_43_5 in var_4(var_43_1) do
			string = var_1_10009

			if var_1_10009.find(iter_43_4, var_0_2.TAG_CRI_EHC_KEY) then
				var_43_0[iter_43_4] = iter_43_5
			end
		end

		var_43_0.armorType = 0
		var_43_0.velocity = var_0_2.GetCurrent(arg_43_1, "baseVelocity")
		var_43_0.labelTag = {}
		var_43_0.TargetChoise = {}
		var_43_0.guardian = {}
		var_43_0.comboTag = "combo_" .. var_43_0.hostUID

		return
	end
end

function var_0_2.SetAircraftAttFromTemp(arg_44_0)
	local var_44_0

	if not arg_44_0._attr then
		var_44_0 = {}
	end

	arg_44_0._attr = var_44_0

	local var_44_1 = var_0_2.GetCurrent(arg_44_0, "hiveExtraHP")
	local var_44_2 = arg_44_0._attr
	local var_44_3

	if not arg_44_0._attr.velocity then
		ys = var_44_3
		var_44_3 = var_44_3.Battle.BattleFormulas.ConvertAircraftSpeed(arg_44_0._tmpData.speed)
	end

	var_44_2.velocity = var_44_3

	local var_44_4

	if not arg_44_0._attr.level then
		var_44_4 = 1
	end

	local var_44_5 = arg_44_0._attr
	local var_44_6

	if not arg_44_0._attr.maxHP then
		var_44_6 = arg_44_0._tmpData.max_hp + arg_44_0._tmpData.hp_growth / 1000 * (var_44_4 - 1) + var_44_1
	end

	var_44_5.maxHP = var_44_6
	arg_44_0._attr.crashDMG = arg_44_0._tmpData.crash_DMG
	arg_44_0._attr.dodge = arg_44_0._tmpData.dodge
	arg_44_0._attr.dodgeLimit = arg_44_0._tmpData.dodge_limit

	return
end

function var_0_2.SetAirFighterAttr(arg_45_0, arg_45_1)
	local var_45_0

	if not arg_45_0._attr then
		var_45_0 = {}
	end

	arg_45_0._attr = var_45_0
	ys = var_1_10003

	local var_45_1 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_45_2 = var_3.GetDungeonLevel(var_45_1)

	var_45_0.battleUID = arg_45_0:GetUniqueID()
	var_45_0.hostUID = 0
	var_45_0.id = 0
	var_45_0.level = var_45_2
	var_45_0.formulaLevel = var_45_2

	if var_3:IsCompletelyRepress() then
		math = var_5
		var_45_0.formulaLevel = var_5.max(var_45_0.formulaLevel - 10, 1)
	end

	local var_45_3 = (var_45_2 - 1) / 1000

	math = var_45_1
	var_45_0.maxHP = var_45_1.floor(arg_45_1.max_hp + arg_45_1.hp_growth * var_45_3)
	var_45_0.attackRating = arg_45_1.accuracy + arg_45_1.ACC_growth * var_45_3

	local var_45_4 = arg_45_1.attack_power + arg_45_1.AP_growth * var_45_3

	var_45_0.dodge = arg_45_1.dodge
	var_45_0.dodgeLimit = arg_45_1.dodge_limit
	var_45_0.cannonPower = var_45_4
	var_45_0.torpedoPower = var_45_4
	var_45_0.antiAirPower = var_45_4
	var_45_0.antiSubPower = var_45_4
	var_45_0.airPower = var_45_4
	var_45_0.loadSpeed = 0
	var_45_0.armorType = 1
	var_45_0.dodgeRate = 0
	var_45_0.luck = 50
	ys = var_7
	var_45_0.velocity = var_7.Battle.BattleFormulas.ConvertAircraftSpeed(arg_45_1.speed)
	var_45_0.repressReduce = 1
	var_45_0.TargetChoise = {}
	var_45_0.guardian = {}
	var_45_0.crashDMG = arg_45_1.crash_DMG

	return
end

function var_0_2.SetFusionAttrFromElement(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = var_0_2.GetAttr(arg_46_1).level
	local var_46_1

	if not arg_46_0._attr then
		var_46_1 = {}
	end

	arg_46_0._attr = var_46_1
	var_46_1.id = var_4.id
	var_46_1.level = var_46_0
	var_46_1.formulaLevel = var_46_0
	var_46_1.battleUID = arg_46_0:GetUniqueID()
	ipairs = var_7

	for iter_46_0, iter_46_1 in var_7(var_0_2.AttrListInheritance) do
		var_46_1[iter_46_1] = var_4[iter_46_1]
	end

	pairs = var_7

	for iter_46_2, iter_46_3 in var_7(var_4) do
		string = var_1_10012

		if var_1_10012.find(iter_46_2, var_0_2.TAG_EHC_KEY) then
			var_46_1[iter_46_2] = iter_46_3
		end
	end

	pairs = var_7

	for iter_46_4, iter_46_5 in var_7(var_4) do
		string = var_1_10012

		if var_1_10012.find(iter_46_4, var_0_2.TAG_CRI_EHC_KEY) then
			var_46_1[iter_46_4] = iter_46_5
		end
	end

	local var_46_2 = arg_46_1:GetHP()

	ipairs = var_8

	for iter_46_6, iter_46_7 in var_8(arg_46_2) do
		var_46_2 = var_46_2 + iter_46_7:GetHP()
	end

	var_46_1.maxHP = var_46_2
	var_46_1.hpProvideRate = {}

	local var_46_3 = var_46_1.hpProvideRate

	var_46_3[var_0_2.GetCurrent(arg_46_1, "id")] = arg_46_1:GetHP() / var_46_2
	ipairs = var_46_3

	for iter_46_8, iter_46_9 in var_46_3(arg_46_2) do
		var_46_1.hpProvideRate[var_0_2.GetCurrent(iter_46_9, "id")] = iter_46_9:GetHP() / var_46_2
	end

	;(function(arg_47_0)
		local var_47_0

		if not arg_46_3[arg_47_0] then
			var_47_0 = 1
		end

		var_46_1[arg_47_0] = var_0_2.GetCurrent(arg_46_1, arg_47_0) * var_47_0

		return
	end)("cannonPower")
	var_8("torpedoPower")
	var_8("antiAirPower")
	var_8("antiSubPower")
	var_8("baseAntiSubPower")
	var_8("airPower")
	var_8("loadSpeed")
	var_8("attackRating")
	var_8("dodgeRate")
	var_8("luck")
	var_8("velocity")
	var_8("baseVelocity")

	var_46_1.armorType = var_0_2.GetCurrent(arg_46_1, "armorType")
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

	var_0_2.SetBaseAttr(arg_46_0)

	return
end

function var_0_2.FlashByBuff(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0._attr
	local var_48_1

	if not arg_48_0._baseAttr[arg_48_1] then
		var_48_1 = 0
	end

	var_48_0[arg_48_1] = arg_48_2 + var_48_1
	string = var_48_0

	if var_48_0.find(arg_48_1, var_0_2.FROM_TAG_EHC_KEY) then
		local var_48_2 = 0

		pairs = var_4

		for iter_48_0, iter_48_1 in var_4(arg_48_0._attr) do
			string = var_1_10009

			if var_1_10009.find(iter_48_0, var_0_2.FROM_TAG_EHC_KEY) and iter_48_1 ~= 0 then
				var_48_2 = 1

				break
			end
		end

		var_0_2.SetCurrent(arg_48_0, var_0_2.FROM_TAG_EHC_KEY, var_48_2)
	end

	return
end

function var_0_2.FlashVelocity(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = var_0_2.GetBase(arg_49_0, "velocity") * 1.8
	local var_49_1 = var_0_2.GetBase(arg_49_0, "velocity") * 0.2
	local var_49_2 = arg_49_0._baseAttr.velocity * arg_49_1 + arg_49_2

	Mathf = var_6

	local var_49_3 = var_6.Clamp(var_49_2, var_49_1, var_49_0)

	var_0_2.SetCurrent(arg_49_0, "velocity", var_49_3)

	return
end

function var_0_2.HasSonar(arg_50_0)
	local var_50_0 = arg_50_0:GetTemplate().type

	ys = var_1_10002

	return var_1_10002.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_50_0] ~= nil
end

function var_0_2.SetCurrent(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0._attr[arg_51_1] = arg_51_2

	return
end

function var_0_2.GetCurrent(arg_52_0, arg_52_1)
	AttributeType = var_1_10002

	local var_52_0

	if not var_1_10002.IsPrimalBattleAttr(arg_52_1) then
		var_52_0 = false
	end

	return var_0_2._attrFunc[var_52_0](arg_52_0, arg_52_1)
end

function var_0_2._getPrimalAttr(arg_53_0, arg_53_1)
	math = var_1_10002

	return var_1_10002.max(arg_53_0._attr[arg_53_1], 0)
end

function var_0_2._getSecondaryAttr(arg_54_0, arg_54_1)
	local var_54_0

	if not arg_54_0._attr[arg_54_1] then
		var_54_0 = 0
	end

	return var_54_0
end

var_0_2._attrFunc = {
	[true] = var_0_2._getPrimalAttr,
	[false] = var_0_2._getSecondaryAttr
}

function var_0_2.GetBase(arg_55_0, arg_55_1)
	local var_55_0

	if not arg_55_0._baseAttr[arg_55_1] then
		var_55_0 = 0
	end

	return var_55_0
end

function var_0_2.GetCurrentTags(arg_56_0)
	local var_56_0

	if not arg_56_0._attr.labelTag then
		var_56_0 = {}
	end

	return var_56_0
end

function var_0_2.Increase(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 then
		local var_57_0 = arg_57_0._attr
		local var_57_1

		if not arg_57_0._attr[arg_57_1] then
			var_57_1 = 0
		end

		var_57_0[arg_57_1] = var_57_1 + arg_57_2
	end

	return
end

function var_0_2.RatioIncrease(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_2 then
		arg_58_0._attr[arg_58_1] = arg_58_0._attr[arg_58_1] + arg_58_0._baseAttr[arg_58_1] * arg_58_2 / 16
	end

	return
end

function var_0_2.GetTagAttr(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = arg_59_1
	local var_59_1 = arg_59_1.GetLabelTag(var_59_0)
	local var_59_2 = {}

	ipairs = var_59_0

	for iter_59_0, iter_59_1 in var_59_0(var_59_1) do
		var_59_2[var_0_2.TAG_EHC_KEY .. iter_59_1] = true
	end

	local var_59_3 = 1

	pairs = var_6

	for iter_59_2, iter_59_3 in var_6(var_59_2) do
		if var_0_2.GetCurrent(arg_59_0, iter_59_2) ~= 0 then
			local var_59_4

			if arg_59_2 then
				ys = var_1_10012
				var_59_4 = var_1_10012.Battle.BattleDataFunction.GetLimitAttributeRange(iter_59_2, var_59_4)
			end

			var_59_3 = var_59_3 * (1 + var_59_4)
		end
	end

	if var_0_2.GetCurrent(arg_59_1, var_0_2.FROM_TAG_EHC_KEY) > 0 then
		local var_59_5 = arg_59_0:GetWeaponTempData().attack_attribute
		local var_59_6 = var_0_2.FROM_TAG_EHC_KEY .. var_59_5 .. "_"
		local var_59_7 = var_0_2.GetCurrentTags(arg_59_0)

		pairs = var_10

		for iter_59_4, iter_59_5 in var_10(var_59_7) do
			if iter_59_5 > 0 then
				local var_59_8 = var_59_6 .. iter_59_4

				if var_0_2.GetCurrent(arg_59_1, var_59_8) ~= 0 then
					var_59_3 = var_59_3 * (1 + var_16)
				end
			end
		end
	end

	return var_59_3
end

function var_0_2.GetTagAttrCri(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1
	local var_60_1 = arg_60_1.GetLabelTag(var_60_0)
	local var_60_2 = {}

	ipairs = var_60_0

	for iter_60_0, iter_60_1 in var_60_0(var_60_1) do
		var_60_2[var_0_2.TAG_CRI_EHC_KEY .. iter_60_1] = true
	end

	local var_60_3 = 0

	pairs = var_5

	for iter_60_2, iter_60_3 in var_5(var_60_2) do
		if var_0_2.GetCurrent(arg_60_0, iter_60_2) ~= 0 then
			var_60_3 = var_60_3 + var_10
		end
	end

	return var_60_3
end

function var_0_2.GetTagAttrCriDmg(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_1
	local var_61_1 = arg_61_1.GetLabelTag(var_61_0)
	local var_61_2 = {}

	ipairs = var_61_0

	for iter_61_0, iter_61_1 in var_61_0(var_61_1) do
		var_61_2[var_0_2.TAG_CRIDMG_EHC_KEY .. iter_61_1] = true
	end

	local var_61_3 = 0

	pairs = var_5

	for iter_61_2, iter_61_3 in var_5(var_61_2) do
		if var_0_2.GetCurrent(arg_61_0, iter_61_2) ~= 0 then
			var_61_3 = var_61_3 + var_10
		end
	end

	return var_61_3
end

return
