ys = var_0_10000

local var_0_0 = var_0_10000.Battle

ys = var_0_10001

local var_0_1

if not var_0_10001.Battle.BattleFormulas then
	var_0_1 = {}
end

var_0_0.BattleFormulas = var_0_1
ys = var_0_0

local var_0_2 = var_0_0.Battle.BattleFormulas

ys = var_0_1

local var_0_3 = var_0_1.Battle.BattleConst

pg = var_0_10002

local var_0_4 = var_0_10002.gameset

ys = var_0_10003

local var_0_5 = var_0_10003.Battle.BattleAttr

ys = var_0_10004

local var_0_6 = var_0_10004.Battle.BattleConfig

ys = var_0_10005

local var_0_7 = var_0_10005.Battle.BattleConfig.AnitAirRepeaterConfig

pg = var_0_10006

local var_0_8 = var_0_10006.bfConsts.SECONDs / var_0_6.viewFPS * var_0_6.BulletSpeedConvertConst
local var_0_9 = var_6.SECONDs / var_0_6.calcFPS * var_0_6.ShipSpeedConvertConst
local var_0_10 = var_6.SECONDs / var_0_6.viewFPS * var_0_6.AircraftSpeedConvertConst
local var_0_11 = var_0_6.AIR_ASSIST_RELOAD_RATIO * var_6.PERCENT
local var_0_12 = var_0_6.DAMAGE_ENHANCE_FROM_SHIP_TYPE
local var_0_13 = var_0_6.AMMO_DAMAGE_ENHANCE
local var_0_14 = var_0_6.AMMO_DAMAGE_REDUCE
local var_0_15 = var_0_6.SHIP_TYPE_ACCURACY_ENHANCE

function var_0_2.GetFleetTotalHP(arg_1_0)
	local var_1_0 = arg_1_0:GetFlagShip()
	local var_1_1 = arg_1_0:GetUnitList()
	local var_1_2 = var_0.NUM0

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(var_1_1) do
		if iter_1_1 == var_1_0 then
			var_1_2 = var_1_2 + var_0_5.GetCurrent(iter_1_1, "maxHP") * var_0.HP_CONST
		else
			var_1_2 = var_1_2 + var_0_5.GetCurrent(iter_1_1, "maxHP")
		end
	end

	return var_1_2
end

function var_0_2.GetFleetVelocity(arg_2_0)
	if arg_2_0[1] and var_0_5.GetCurrent(var_1, "fleetVelocity") > var_0.NUM0 then
		return var_2 * var_0.PERCENT
	end

	local var_2_0 = var_0.NUM0
	local var_2_1 = #arg_2_0

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0) do
		var_2_0 = var_2_0 + iter_2_1:GetAttrByName("velocity")
	end

	local var_2_2 = var_0.NUM1 - var_0.SPEED_CONST * (var_2_1 - var_0.NUM1)

	return var_2_0 / var_2_1 * var_2_2
end

function var_0_2.GetFleetReload(arg_3_0)
	local var_3_0 = var_0.NUM0

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0) do
		var_3_0 = var_3_0 + iter_3_1:GetReload()
	end

	return var_3_0
end

function var_0_2.GetFleetTorpedoPower(arg_4_0)
	local var_4_0 = var_0.NUM0

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0) do
		var_4_0 = var_4_0 + iter_4_1:GetTorpedoPower()
	end

	return var_4_0
end

function var_0_2.AttrFixer(arg_5_0, arg_5_1)
	SYSTEM_DUEL = var_1_10002

	if arg_5_0 == var_1_10002 then
		local var_5_0 = arg_5_1.level
		local var_5_1 = arg_5_1.durability

		ys = var_1_10004

		local var_5_2, var_5_3 = var_1_10004.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_5_0, var_5_0)

		arg_5_1.durability = var_5_1 * var_5_2 + var_5_3
	end

	return
end

function var_0_2.HealFixer(arg_6_0, arg_6_1)
	local var_6_0 = 1

	SYSTEM_DUEL = var_1_10003

	if arg_6_0 == var_1_10003 then
		local var_6_1 = arg_6_1.level

		ys = var_1_10004
		var_6_0 = var_1_10004.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_2.ConvertShipSpeed(arg_7_0)
	return arg_7_0 * var_0_9
end

function var_0_2.ConvertAircraftSpeed(arg_8_0)
	if arg_8_0 then
		return arg_8_0 * var_0_10
	else
		return nil
	end

	return
end

function var_0_2.ConvertBulletSpeed(arg_9_0)
	return arg_9_0 * var_0_8
end

function var_0_2.ConvertBulletDataSpeed(arg_10_0)
	return arg_10_0 / var_0_8
end

function var_0_2.CreateContextCalculateDamage(arg_11_0)
	return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = var_0.NUM1
		local var_12_1 = var_0.NUM0
		local var_12_2 = var_0.NUM10000
		local var_12_3 = var_0.DRATE
		local var_12_4 = var_0.ACCURACY
		local var_12_5 = arg_12_0:GetWeaponHostAttr()
		local var_12_6 = arg_12_0:GetWeapon()
		local var_12_7 = arg_12_0:GetWeaponTempData().type
		local var_12_8 = var_11.attack_attribute
		local var_12_9 = var_12_6:GetConvertedAtkAttr()
		local var_12_10 = arg_12_0:GetTemplate().damage_type
		local var_12_11 = var_15.random_damage_rate
		local var_12_12 = arg_12_1._attr
		local var_12_13 = arg_12_3 or var_12_0

		arg_12_2 = arg_12_2 or var_12_1

		local var_12_14 = var_12_12.armorType
		local var_12_15 = var_12_5.formulaLevel - var_12_12.formulaLevel
		local var_12_16 = var_12_0
		local var_12_17 = false
		local var_12_18 = false
		local var_12_19 = var_12_0
		local var_12_20 = arg_12_0:GetCorrectedDMG()
		local var_12_21 = (var_12_0 + arg_12_0:GetWeaponAtkAttr() * var_12_9) * var_12_20

		if var_12_8 == var_0_3.WeaponDamageAttr.CANNON then
			var_12_13 = var_12_0 + var_0_5.GetCurrent(arg_12_1, "injureRatioByCannon") + var_0_5.GetCurrent(arg_12_0, "damageRatioByCannon")
		elseif var_12_8 == var_0_3.WeaponDamageAttr.TORPEDO then
			var_12_13 = var_12_0 + var_0_5.GetCurrent(arg_12_1, "injureRatioByBulletTorpedo") + var_0_5.GetCurrent(arg_12_0, "damageRatioByBulletTorpedo")
		elseif var_12_8 == var_0_3.WeaponDamageAttr.AIR then
			local var_12_22

			if not (var_0_5.GetCurrent(arg_12_0, "airResistPierceActive") == 1) or not var_0_5.GetCurrent(arg_12_0, "airResistPierce") then
				var_12_22 = 0
			end

			math = var_30
			var_12_13 = var_12_13 * var_30.min(var_12_3[7] / (var_12_12.antiAirPower + var_12_3[7]) + var_12_22, 1) * (var_12_0 + var_0_5.GetCurrent(arg_12_1, "injureRatioByAir") + var_0_5.GetCurrent(arg_12_0, "damageRatioByAir"))
		elseif var_12_8 == var_0_3.WeaponDamageAttr.ANTI_AIR then
			-- block empty
		elseif var_12_8 == var_0_3.WeaponDamageAttr.ANIT_SUB then
			-- block empty
		end

		local var_12_23 = var_12_5.luck - var_12_12.luck
		local var_12_24 = var_0_5.GetCurrent(arg_12_1, "perfectDodge")

		math = var_30

		local var_12_25 = var_30.max(var_12_5.attackRating, 0)

		if var_12_24 >= 1 then
			var_12_17 = true
		else
			local var_12_26 = var_12_4[1] + var_12_25 / (var_12_25 + var_12_12.dodgeRate + var_12_4[2]) + (var_12_23 + var_12_15) * var_0.PERCENT1
			local var_12_27 = var_0_5.GetCurrent(arg_12_0, "accuracyRateExtra")
			local var_12_28 = var_0_5.GetCurrent
			local var_12_29 = arg_12_0
			local var_12_30 = var_0_15
			local var_12_31 = arg_12_1
			local var_12_32 = var_12_28(var_12_29, var_12_30[arg_12_1.GetTemplate(var_12_31).type])
			local var_12_33 = var_0_5.GetCurrent(arg_12_1, "dodgeRateExtra")

			math = var_35

			local var_12_34 = var_35.max
			local var_12_35 = var_12_3[5]

			math = var_12_31

			local var_12_36 = var_12_34(var_12_35, var_12_31.min(var_12_0, var_12_26 + var_12_27 + var_12_32 - var_12_33))

			var_12_17 = not var_0_2.IsHappen(var_12_36 * var_12_2)
		end

		if not var_12_17 then
			local var_12_37
			local var_12_38 = var_0_5.GetCurrent(arg_12_0, "GCT") == 1 and 1 or var_0.DFT_CRIT_RATE + var_12_25 / (var_12_25 + var_12_12.dodgeRate + var_12_3[4]) + (var_12_23 + var_12_15) * var_12_3[3] + var_0_5.GetCurrent(arg_12_0, "cri") + var_0_5.GetTagAttrCri(arg_12_0, arg_12_1)

			math = var_32
			var_12_19 = var_32.random(var_0_6.RANDOM_DAMAGE_MIN, var_0_6.RANDOM_DAMAGE_MAX) + var_12_21

			if var_0_2.IsHappen(var_12_38 * var_12_2) then
				var_12_18 = true

				local var_12_39 = var_0.DFT_CRIT_EFFECT + var_0_5.GetTagAttrCriDmg(arg_12_0, arg_12_1) + var_0_5.GetCurrent(arg_12_0, "criDamage") - var_0_5.GetCurrent(arg_12_1, "criDamageResist")

				math = var_34
				var_12_16 = var_34.max(1, var_12_39)
			else
				var_12_18 = false
			end
		else
			var_12_19 = var_12_1

			local var_12_40 = {
				isMiss = true,
				isDamagePrevent = false,
				isCri = var_12_18
			}

			return var_12_19, var_12_40
		end

		local var_12_41 = var_0.NUM1
		local var_12_42 = var_0_5.GetCurrent(arg_12_0, "damageRatioBullet")
		local var_12_43 = var_0_5.GetTagAttr(arg_12_0, arg_12_1, arg_11_0)
		local var_12_44 = var_0_5.GetCurrent(arg_12_1, "injureRatio")
		local var_12_45

		if not var_12_6:GetFixAmmo() and not var_12_10[var_12_14] then
			var_12_45 = var_12_41
		end

		local var_12_46 = var_12_45 + var_0_5.GetCurrent(arg_12_0, var_0_6.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE[var_12_14])
		local var_12_47 = var_0_5.GetCurrent(arg_12_0, var_0_6.DAMAGE_TO_ARMOR_RATE_ENHANCE[var_12_14])
		local var_12_48 = var_0_5.GetCurrent(arg_12_0, var_0_13[var_15.ammo_type])
		local var_12_49 = var_0_5.GetCurrent(arg_12_1, var_0_14[var_15.ammo_type])
		local var_12_50 = var_0_5.GetCurrent(arg_12_0, "comboTag")
		local var_12_51 = var_0_5.GetCurrent(arg_12_1, var_12_50)

		math = var_41

		local var_12_52 = var_41.max
		local var_12_53 = var_12_41

		math = var_2_10043

		local var_12_54 = var_2_10043.floor
		local var_12_55 = var_12_19 * var_12_13 * (var_12_41 - arg_12_2) * var_12_46 * (var_12_41 + var_12_47) * var_12_16 * (var_12_41 + var_12_42) * var_12_43 * (var_12_41 + var_12_44) * (var_12_41 + var_12_48 - var_12_49) * (var_12_41 + var_12_51)

		math = var_45

		local var_12_56 = var_45.min
		local var_12_57 = var_12_3[1]

		math = var_2_10047

		local var_12_58 = var_12_52(var_12_53, var_12_54(var_12_55 * (var_12_41 + var_12_56(var_12_57, var_2_10047.max(-var_12_3[1], var_12_15)) * var_12_3[2])))

		if arg_12_1:GetCurrentOxyState() == var_0_3.OXY_STATE.DIVE then
			math = var_41
			var_12_58 = var_41.floor(var_12_58 * var_15.antisub_enhancement)
		end

		local var_12_59 = {
			isMiss = var_12_17,
			isCri = var_12_18,
			damageAttr = var_12_8
		}
		local var_12_60 = arg_12_0

		if arg_12_0.GetDamageEnhance(var_12_60) ~= 1 then
			math = var_12_60
			var_12_58 = var_12_60.floor(var_12_58 * var_42)
		end

		local var_12_61 = var_12_58 * var_12_12.repressReduce

		if var_12_11 ~= 0 then
			Mathf = var_43
			var_12_61 = var_12_61 * (var_43.RandomFloat(var_12_11) + 1)
		end

		local var_12_62 = var_0_5.GetCurrent(arg_12_0, "damageEnhanceProjectile")

		math = var_44

		local var_12_63 = var_44.max(0, var_12_61 + var_12_62)

		if arg_11_0 then
			var_12_63 = var_12_63 * (var_0.NUM1 + var_0_5.GetCurrent(arg_12_0, "worldBuffResistance"))
		end

		math = var_44

		local var_12_64 = var_44.floor(var_12_63)
		local var_12_65 = var_15.DMG_font[var_12_14]

		if var_12_62 < 0 then
			var_12_65 = var_0_6.BULLET_DECREASE_DMG_FONT
		end

		return var_12_64, var_12_59, var_12_65
	end
end

function var_0_2.CalculateIgniteDamage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._attr
	local var_13_1 = arg_13_0:GetWeapon()

	return var_4.GetCorrectedDMG(var_13_1) * (1 + var_13_0[arg_13_1] * var_0.PERCENT) * arg_13_2
end

function var_0_2.WeaponDamagePreCorrection(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetTemplateData()
	local var_14_1 = arg_14_1 or var_14_0.damage
	local var_14_2 = var_14_0.corrected

	return var_14_1 * arg_14_0:GetPotential() * var_14_2 * var_0.PERCENT
end

function var_0_2.WeaponAtkAttrPreRatio(arg_15_0)
	return arg_15_0:GetTemplateData().attack_attribute_ratio * var_0.PERCENT2
end

function var_0_2.GetMeteoDamageRatio(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = var_0.METEO_RATE[1]

	if arg_16_0 >= var_2[2] then
		for iter_16_0 = 1, arg_16_0 + 1 do
			var_16_0[iter_16_0] = var_16_1
		end

		return var_16_0
	else
		local var_16_2 = 1 - var_16_1 * arg_16_0

		for iter_16_1 = 1, arg_16_0 do
			math = var_1_10009
			var_16_0[iter_16_1] = var_1_10009.random() * var_16_2 * (var_2[3] + var_2[4] * (iter_16_1 - 1) / arg_16_0) + var_16_1
			math = var_10
			var_16_2 = var_10.max(0, var_16_2 - var_1_10009)
		end

		var_16_0[arg_16_0 + 1] = var_16_2

		return var_16_0
	end

	return
end

function var_0_2.CalculateFleetAntiAirTotalDamage(arg_17_0)
	local var_17_0 = arg_17_0:GetCrewUnitList()
	local var_17_1 = 0

	pairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(var_17_0) do
		local var_17_2 = var_0_5.GetCurrent(iter_17_0, "antiAirPower")

		ipairs = var_9

		for iter_17_2, iter_17_3 in var_9(iter_17_1) do
			local var_17_3 = iter_17_3:GetConvertedAtkAttr()
			local var_17_4 = iter_17_3
			local var_17_5 = iter_17_3.GetCorrectedDMG(var_17_4)

			math = var_17_4
			var_17_1 = var_17_1 + var_17_4.max(1, (var_17_2 * var_17_3 + 1) * var_17_5)
		end
	end

	return var_17_1
end

function var_0_2.CalculateRepaterAnitiAirTotalDamage(arg_18_0)
	local var_18_0 = arg_18_0:GetHost()
	local var_18_1 = arg_18_0:GetConvertedAtkAttr()
	local var_18_2 = arg_18_0:GetCorrectedDMG()
	local var_18_3 = var_0_5.GetCurrent(var_18_0, "antiAirPower")

	math = var_5

	return (var_5.max(1, (var_18_3 * var_18_1 + 1) * var_18_2))
end

function var_0_2.RollRepeaterHitDice(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetHost()
	local var_19_1 = var_0_5.GetCurrent(var_19_0, "antiAirPower")

	math = var_4

	local var_19_2 = var_4.max(var_0_5.GetCurrent(var_19_0, "attackRating"), 0)
	local var_19_3 = var_0_5.GetCurrent(arg_19_1, "airPower")
	local var_19_4 = var_0_5.GetCurrent(arg_19_1, "dodgeLimit")
	local var_19_5 = var_0_5.GetCurrent(arg_19_1, "dodge")
	local var_19_6 = (var_19_3 / var_0_7.const_A + var_0_7.const_B) / (var_19_1 * var_19_5 + var_8 + var_0_7.const_C)

	math = var_10

	local var_19_7 = var_10.min(var_19_4, var_19_6)

	return var_0_2.IsHappen(var_19_7 * var_0.NUM10000)
end

function var_0_2.AntiAirPowerWeight(arg_20_0)
	return arg_20_0 * arg_20_0
end

function var_0_2.CalculateDamageFromAircraftToMainShip(arg_21_0, arg_21_1)
	local var_21_0 = var_0_5.GetCurrent(arg_21_0, "airPower")
	local var_21_1 = var_0_5.GetCurrent(arg_21_1, "antiAirPower")
	local var_21_2 = var_0_5.GetCurrent(arg_21_0, "crashDMG")
	local var_21_3 = arg_21_0:GetHPRate()
	local var_21_4 = var_0_5.GetCurrent(arg_21_0, "formulaLevel")
	local var_21_5 = var_0_5.GetCurrent(arg_21_1, "formulaLevel")
	local var_21_6 = var_0_5.GetCurrent(arg_21_1, "injureRatio")
	local var_21_7 = var_0_5.GetCurrent(arg_21_1, "injureRatioByAir")
	local var_21_8 = var_0.PLANE_LEAK_RATE

	math = var_11

	local var_21_9 = var_11.max
	local var_21_10 = var_21_8[1]

	math = var_1_10013

	local var_21_11 = var_21_9(var_21_10, var_1_10013.floor((var_21_2 * (var_21_8[2] + var_21_0 * var_21_8[3]) + var_21_4 * var_21_8[4]) * (var_21_3 * var_21_8[5] + var_21_8[6]) * (var_21_8[7] + (var_21_4 - var_21_5) * var_21_8[8]) * (var_21_8[9] / (var_21_1 + var_21_8[10])) * (var_21_8[11] + var_21_6) * (var_21_8[12] + var_21_7)))

	math = var_21_10

	return (var_21_10.floor(var_21_11 * var_0_5.GetCurrent(arg_21_1, "repressReduce") * var_0_5.GetCurrent(arg_21_1, "injureRatioKamikazeAir")))
end

function var_0_2.CalculateDamageFromShipToMainShip(arg_22_0, arg_22_1)
	local var_22_0 = var_0_5.GetCurrent(arg_22_0, "cannonPower")
	local var_22_1 = var_0_5.GetCurrent(arg_22_0, "torpedoPower")
	local var_22_2 = arg_22_0:GetHPRate()
	local var_22_3 = var_0_5.GetCurrent(arg_22_0, "formulaLevel")
	local var_22_4 = var_0_5.GetCurrent(arg_22_1, "formulaLevel")
	local var_22_5 = var_0_5.GetCurrent(arg_22_1, "injureRatio")
	local var_22_6 = var_0.LEAK_RATE

	math = var_9

	local var_22_7 = var_9.max
	local var_22_8 = var_22_6[1]

	math = var_1_10011

	local var_22_9 = var_22_7(var_22_8, var_1_10011.floor(((var_22_0 + var_22_1) * var_22_6[2] + var_22_3 * var_22_6[7]) * (var_22_6[5] + var_22_5) * (var_22_2 * var_22_6[3] + var_22_6[4]) * (var_22_6[5] + (var_22_3 - var_22_4) * var_22_6[6])))

	math = var_22_8

	return (var_22_8.floor(var_22_9 * var_0_5.GetCurrent(arg_22_1, "repressReduce") * var_0_5.GetCurrent(arg_22_1, "injureRatioKamikazeShip")))
end

function var_0_2.CalculateDamageFromSubmarinToMainShip(arg_23_0, arg_23_1)
	local var_23_0 = var_0_5.GetCurrent(arg_23_0, "torpedoPower")
	local var_23_1 = arg_23_0:GetHPRate()
	local var_23_2 = var_0_5.GetCurrent(arg_23_0, "formulaLevel")
	local var_23_3 = var_0_5.GetCurrent(arg_23_1, "formulaLevel")
	local var_23_4 = var_0_5.GetCurrent(arg_23_1, "injureRatio")
	local var_23_5 = var_0.SUBMARINE_KAMIKAZE

	math = var_8

	local var_23_6 = var_8.max
	local var_23_7 = var_23_5[1]

	math = var_1_10010

	return (var_23_6(var_23_7, var_1_10010.floor((var_23_0 * var_23_5[2] + var_23_2 * var_23_5[3]) * (var_23_5[4] + var_23_4) * (var_23_1 * var_23_5[5] + var_23_5[6]) * (var_23_5[7] + (var_23_2 - var_23_3) * var_23_5[8]))))
end

function var_0_2.RollSubmarineDualDice(arg_24_0)
	local var_24_0 = var_1 / (var_0_5.GetCurrent(arg_24_0, "dodgeRate") + var_0_6.MONSTER_SUB_KAMIKAZE_DUAL_K) * var_0_6.MONSTER_SUB_KAMIKAZE_DUAL_P

	return var_0_2.IsHappen(var_24_0 * var_0.NUM10000)
end

function var_0_2.CalculateCrashDamage(arg_25_0, arg_25_1)
	local var_25_0 = var_0_5.GetCurrent(arg_25_0, "maxHP")
	local var_25_1 = var_0_5.GetCurrent(arg_25_1, "maxHP")
	local var_25_2 = var_25_0 * var_0.CRASH_RATE[1]
	local var_25_3 = var_25_1 * var_0.CRASH_RATE[1]
	local var_25_4 = var_0_5.GetCurrent(arg_25_0, "hammerDamageRatio")
	local var_25_5 = var_0_5.GetCurrent(arg_25_1, "hammerDamageRatio")
	local var_25_6 = var_0_5.GetCurrent(arg_25_0, "hammerDamagePrevent")
	local var_25_7 = var_0_5.GetCurrent(arg_25_1, "hammerDamagePrevent")

	math = var_10

	local var_25_8 = var_10.min(var_25_6, var_0_6.HammerCFG.PreventUpperBound)

	math = var_10

	local var_25_9 = var_10.min(var_25_7, var_0_6.HammerCFG.PreventUpperBound)

	math = var_10

	local var_25_10 = var_10.sqrt(var_25_0 * var_25_1) * var_0.CRASH_RATE[2]

	math = var_11

	local var_25_11 = var_11.min(var_25_2, var_25_10)

	math = var_12

	local var_25_12 = var_12.min(var_25_3, var_25_10)

	math = var_13

	local var_25_13 = var_13.floor(var_25_11 * (1 + var_25_5) * (1 - var_25_8))

	math = var_14

	local var_25_14 = var_14.floor(var_25_13 * var_0_5.GetCurrent(arg_25_0, "repressReduce"))

	math = var_14

	local var_25_15 = var_14.floor(var_25_12 * (1 + var_25_4) * (1 - var_25_9))

	math = var_15

	local var_25_16 = var_15.floor(var_25_15 * var_0_5.GetCurrent(arg_25_1, "repressReduce"))

	return var_25_14, var_25_16
end

function var_0_2.CalculateFleetDamage(arg_26_0)
	return arg_26_0 * var_0.SCORE_RATE[1]
end

function var_0_2.CalculateFleetOverDamage(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0:GetFlagShip() then
		return var_0_5.GetCurrent(arg_27_1, "maxHP") * var_0.SCORE_RATE[2]
	else
		return var_0_5.GetCurrent(arg_27_1, "maxHP") * var_0.SCORE_RATE[3]
	end

	return
end

function var_0_2.CalculateReloadTime(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0 / var_0_6.K1

	math = var_1_10003

	return var_28_0 / var_1_10003.sqrt((arg_28_1 + var_0_6.K2) * var_0_6.K3)
end

function var_0_2.CaclulateReloaded(arg_29_0, arg_29_1)
	math = var_1_10002

	return var_1_10002.sqrt((arg_29_1 + var_0_6.K2) * var_0_6.K3) * arg_29_0 * var_0_6.K1
end

function var_0_2.CaclulateReloadAttr(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0 / var_0_6.K1 / arg_30_1

	math = var_1_10003

	return var_1_10003.max(var_30_0 * var_30_0 / var_0_6.K3 - var_0_6.K2, 0)
end

function var_0_2.CaclulateAirAssistReloadMax(arg_31_0)
	local var_31_0 = 0

	ipairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0) do
		var_31_0 = var_31_0 + iter_31_1:GetTemplateData().reload_max
	end

	return var_31_0 / #arg_31_0 * var_0_11
end

function var_0_2.CaclulateDOTPlace(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_1.arg_list.tagOnly and not arg_32_3:ContainsLabelTag(var_4.tagOnly) then
		return false
	end

	local var_32_0 = var_0_6.DOT_CONFIG[var_4.dotType]
	local var_32_1

	if not arg_32_2 or not arg_32_2:GetAttrByName(var_32_0.hit) then
		var_32_1 = var_0.NUM0
	end

	local var_32_2

	if not arg_32_3 or not arg_32_3:GetAttrByName(var_32_0.resist) then
		var_32_2 = var_0.NUM0
	end

	return var_0_2.IsHappen(arg_32_0 * (var_0.NUM1 + var_32_1) * (var_0.NUM1 - var_32_2))
end

function var_0_2.CaclulateDOTDuration(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.arg_list
	local var_33_1 = var_0_6.DOT_CONFIG[var_33_0.dotType]
	local var_33_2

	if not arg_33_1 or not arg_33_1:GetAttrByName(var_33_1.prolong) then
		var_33_2 = var_0.NUM0
	end

	local var_33_3

	if not arg_33_2 or not arg_33_2:GetAttrByName(var_33_1.shorten) then
		var_33_3 = var_0.NUM0
	end

	return var_33_2 - var_33_3
end

function var_0_2.CaclulateDOTDamageEnhanceRate(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.arg_list
	local var_34_1 = var_0_6.DOT_CONFIG[var_34_0.dotType]
	local var_34_2

	if not arg_34_1 or not arg_34_1:GetAttrByName(var_34_1.enhance) then
		var_34_2 = var_0.NUM0
	end

	local var_34_3

	if not arg_34_2 or not arg_34_2:GetAttrByName(var_34_1.reduce) then
		var_34_3 = var_0.NUM0
	end

	return (var_34_2 - var_34_3) * var_0.PERCENT2
end

function var_0_2.CaclulateMetaDotaDamage(arg_35_0, arg_35_1)
	ys = var_1_10002

	local var_35_0 = var_1_10002.Battle.BattleDataFunction.GetMetaBossTemplate(arg_35_0)

	type = var_3

	if var_3(var_35_0.state) == "string" then
		return 0
	end

	local var_35_1 = var_35_0.state

	os = var_4

	local var_35_2 = var_4.time({
		year = var_35_1[1][1][1],
		month = var_35_1[1][1][2],
		day = var_35_1[1][1][3],
		hour = var_35_1[1][2][1],
		minute = var_35_1[1][2][2],
		second = var_35_1[1][2][3]
	})

	os = var_5

	local var_35_3 = var_5.time({
		year = var_35_1[2][1][1],
		month = var_35_1[2][1][2],
		day = var_35_1[2][1][3],
		hour = var_35_1[2][2][1],
		minute = var_35_1[2][2][2],
		second = var_35_1[2][2][3]
	})

	os = var_6

	local var_35_4 = var_6.difftime(var_35_3, var_35_2)

	math = var_7

	local var_35_5 = var_7.floor(var_35_4 / 0)

	math = var_8

	local var_35_6 = var_8.floor

	os = var_1_10009

	local var_35_7 = var_1_10009.difftime

	pg = var_1_10010

	local var_35_8 = var_1_10010.TimeMgr.GetInstance()
	local var_35_9 = var_35_6(var_35_7(var_10.GetServerTime(var_35_8), var_35_2) / 0)

	pg = var_9

	local var_35_10 = var_9.gameset.world_metaboss_supportattack.description[1]
	local var_35_11 = var_35_5 - var_9[2]
	local var_35_12 = var_9[3]
	local var_35_13 = var_9[4]
	local var_35_14 = var_9[5]

	ys = var_1_10015

	local var_35_15 = var_1_10015.Battle.BattleDataFunction.GetMetaBossLevelTemplate(arg_35_0, arg_35_1).hp

	math = var_17

	local var_35_16 = var_17.floor
	local var_35_17 = var_35_15 * var_35_12 / var_35_14 / (1 + 0.5 * var_35_13) / (var_35_11 - var_35_10)

	math = var_19

	local var_35_18 = var_35_16(var_35_17 * var_19.min(var_35_9 - var_35_10 + 1, var_35_11 - var_35_10))

	math = var_18

	local var_35_19 = var_18.random

	math = var_19

	return var_35_18 + var_35_19(var_19.floor(var_35_13 * var_35_18))
end

function var_0_2.CalculateMaxAimBiasRange(arg_36_0)
	local var_36_0 = var_0_6.AIM_BIAS_FLEET_RANGE_MOD
	local var_36_1
	local var_36_2

	if #arg_36_0 == 1 then
		var_36_2 = arg_36_0[1]
		var_36_1 = var_0_5.GetCurrent(arg_36_0[1], "dodgeRate") * var_36_0
	else
		var_36_2 = {}
		ipairs = var_1_10004

		for iter_36_0, iter_36_1 in var_1_10004(arg_36_0) do
			table = var_1_10009

			var_1_10009.insert(var_36_2, var_0_5.GetCurrent(iter_36_1, "dodgeRate"))
		end

		table = var_4

		var_4.sort(var_36_2, function(arg_37_0, arg_37_1)
			return arg_37_1 < arg_37_0
		end)

		local var_36_3 = var_36_2[1] + var_36_2[2] * 0.6
		local var_36_4

		if not var_36_2[3] then
			var_36_4 = 0
		end

		var_36_1 = (var_36_3 + var_36_4 * 0.3) / #var_36_2 * var_36_0
	end

	math = var_36_2

	return (var_36_2.min(var_36_1, var_0_6.AIM_BIAS_MAX_RANGE_SCOUT))
end

function var_0_2.CalculateMaxAimBiasRangeSub(arg_38_0)
	local var_38_0 = var_0_5.GetCurrent(arg_38_0[1], "dodgeRate") * var_0_6.AIM_BIAS_SUB_RANGE_MOD

	math = var_3

	return (var_3.min(var_38_0, var_0_6.AIM_BIAS_MAX_RANGE_SUB))
end

function var_0_2.CalculateMaxAimBiasRangeMonster(arg_39_0)
	local var_39_0 = var_0_5.GetCurrent(arg_39_0[1], "dodgeRate") * var_0_6.AIM_BIAS_MONSTER_RANGE_MOD

	math = var_3

	return (var_3.min(var_39_0, var_0_6.AIM_BIAS_MAX_RANGE_MONSTER))
end

function var_0_2.CalculateBiasDecay(arg_40_0)
	local var_40_0 = arg_40_0 * var_0_6.AIM_BIAS_DECAY_MOD_MONSTER

	math = var_1_10002

	return (var_1_10002.min(var_40_0, var_0_6.AIM_BIAS_DECAY_SPEED_MAX_SCOUT))
end

function var_0_2.CalculateBiasDecayMonster(arg_41_0)
	local var_41_0 = arg_41_0 * var_0_6.AIM_BIAS_DECAY_MOD

	math = var_1_10002

	return (var_1_10002.min(var_41_0, var_0_6.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function var_0_2.CalculateBiasDecayMonsterInSmoke(arg_42_0)
	local var_42_0 = arg_42_0 * var_0_6.AIM_BIAS_DECAY_MOD * var_0_6.AIM_BIAS_DECAY_SMOKE

	math = var_2

	return (var_2.min(var_42_0, var_0_6.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function var_0_2.CalculateBiasDecayDiving(arg_43_0)
	math = var_1_10001

	local var_43_0 = var_1_10001.max(0, arg_43_0 - var_0_6.AIM_BIAS_DECAY_SUB_CONST) * var_0_6.AIM_BIAS_DECAY_MOD

	math = var_3

	return (var_3.min(var_43_0, var_0_6.AIM_BIAS_DECAY_SPEED_MAX_SUB))
end

function var_0_2.WorldEnemyAttrEnhance(arg_44_0, arg_44_1)
	return 1 + arg_44_0 / (1 + var_0_6.WORLD_ENEMY_ENHANCEMENT_CONST_C^(var_0_6.WORLD_ENEMY_ENHANCEMENT_CONST_B - arg_44_1))
end

setmetatable = var_15

local var_0_16 = var_15({}, {
	__index = function(arg_45_0, arg_45_1)
		return 0
	end
})

function var_0_2.WorldMapRewardAttrEnhance(arg_46_0, arg_46_1)
	arg_46_0 = arg_46_0 or var_0_16
	arg_46_1 = arg_46_1 or var_0_16

	local var_46_0
	local var_46_1
	local var_46_2
	local var_46_3 = {
		{
			var_0_4.attr_world_value_X1.key_value / 16,
			var_0_4.attr_world_value_X2.key_value / 16
		},
		{
			var_0_4.attr_world_value_Y1.key_value / 16,
			var_0_4.attr_world_value_Y2.key_value / 16
		},
		{
			var_0_4.attr_world_value_Z1.key_value / 16,
			var_0_4.attr_world_value_Z2.key_value / 16
		}
	}
	local var_46_4 = var_0_4.attr_world_damage_fix.key_value / 16
	local var_46_5

	if arg_46_0[1] == 0 then
		var_46_5 = var_46_3[1][2]
	else
		var_46_5 = arg_46_1[1] / arg_46_0[1]
	end

	math = var_8

	local var_46_6 = 1 - var_8.clamp(var_46_5, var_46_3[1][1], var_46_3[1][2])

	if arg_46_0[2] == 0 then
		var_46_5 = var_46_3[2][2]
	else
		var_46_5 = arg_46_1[2] / arg_46_0[2]
	end

	math = var_8

	local var_46_7 = 1 - var_8.clamp(var_46_5, var_46_3[2][1], var_46_3[2][2])

	if arg_46_0[3] == 0 then
		var_46_5 = var_46_3[3][2]
	else
		var_46_5 = arg_46_1[3] / arg_46_0[3]
	end

	math = var_8

	local var_46_8 = var_8.max

	math = var_9

	local var_46_9 = var_46_8(1 - var_9.clamp(var_46_5, var_46_3[3][1], var_46_3[3][2]), -var_46_4)

	return var_46_6, var_46_7, var_46_9
end

function var_0_2.WorldMapRewardHealingRate(arg_47_0, arg_47_1)
	local var_47_0 = {
		var_0_4.attr_world_value_H1.key_value / 16,
		var_0_4.attr_world_value_H2.key_value / 16
	}

	arg_47_0 = arg_47_0 or var_0_16
	arg_47_1 = arg_47_1 or var_0_16

	local var_47_1

	if arg_47_0[3] == 0 then
		var_47_1 = var_47_0[2]
	else
		var_47_1 = arg_47_1[3] / arg_47_0[3]
	end

	math = var_4

	return var_4.clamp(var_47_1, var_47_0[1], var_47_0[2])
end

function var_0_2.CalcDamageLock()
	return 0, {
		false,
		true,
		false
	}
end

function var_0_2.CalcDamageLockA2M()
	return 0
end

function var_0_2.CalcDamageLockS2M()
	return 0
end

function var_0_2.CalcDamageLockCrush()
	return 0, 0
end

function var_0_2.UnilateralCrush()
	return 0, 100000
end

function var_0_2.ChapterRepressReduce(arg_53_0)
	return 1 - arg_53_0 * 0.01
end

function var_0_2.IsHappen(arg_54_0)
	if arg_54_0 <= 0 then
		return false
	elseif 10000 <= arg_54_0 then
		return true
	else
		math = var_1

		return arg_54_0 >= var_1.random(10000)
	end

	return
end

function var_0_2.WeightRandom(arg_55_0)
	local var_55_0, var_55_1 = var_0_2.GenerateWeightList(arg_55_0)

	return (var_0_2.WeightListRandom(var_55_0, var_55_1))
end

function var_0_2.WeightListRandom(arg_56_0, arg_56_1)
	math = var_1_10002

	local var_56_0 = var_1_10002.random(0, arg_56_1)

	pairs = var_3

	for iter_56_0, iter_56_1 in var_3(arg_56_0) do
		local var_56_1 = iter_56_0.min
		local var_56_2 = iter_56_0.max

		if var_56_1 <= var_56_0 and var_56_0 <= var_56_2 then
			return iter_56_1
		end
	end

	return
end

function var_0_2.GenerateWeightList(arg_57_0)
	local var_57_0 = {}
	local var_57_1 = -1

	ipairs = var_1_10003

	for iter_57_0, iter_57_1 in var_1_10003(arg_57_0) do
		local var_57_2 = iter_57_1.weight
		local var_57_3 = iter_57_1.rst
		local var_57_4 = var_57_1 + 1
		local var_57_5
		local var_57_6 = var_57_1 + var_57_2

		var_57_0[{
			min = var_57_4,
			max = var_57_6
		}] = var_57_3
	end

	return var_57_0, var_57_1
end

function var_0_2.IsListHappen(arg_58_0)
	ipairs = var_1_10001

	for iter_58_0, iter_58_1 in var_1_10001(arg_58_0) do
		if var_0_2.IsHappen(iter_58_1[1]) then
			return true, iter_58_1[2]
		end
	end

	return false, nil
end

function var_0_2.BulletYAngle(arg_59_0, arg_59_1)
	math = var_1_10002

	local var_59_0 = var_1_10002.rad2Deg

	math = var_1_10003

	return var_59_0 * var_1_10003.atan2(arg_59_1.z - arg_59_0.z, arg_59_1.x - arg_59_0.x)
end

function var_0_2.RandomPosNull(arg_60_0, arg_60_1)
	arg_60_1 = arg_60_1 or 10

	local var_60_0

	if not arg_60_0.distance then
		var_60_0 = 10
	end

	local var_60_1 = var_60_0 * var_60_0

	ys = var_1_10003

	local var_60_2 = var_1_10003.Battle.BattleTargetChoise.TargetAll()
	local var_60_3
	local var_60_4

	for iter_60_0 = 1, arg_60_1 do
		local var_60_5 = true
		local var_60_6 = var_0_2.RandomPos(arg_60_0)

		pairs = var_10

		for iter_60_1, iter_60_2 in var_10(var_60_2) do
			local var_60_7 = iter_60_2
			local var_60_8 = iter_60_2.GetPosition(var_60_7)

			Vector3 = var_60_7

			if var_60_1 > var_60_7.SqrDistance(var_60_6, var_60_8) then
				var_60_5 = false

				break
			end
		end

		if var_60_5 then
			return var_60_6
		end
	end

	return nil
end

function var_0_2.RandomPos(arg_61_0)
	local var_61_0

	if not arg_61_0[1] then
		var_61_0 = 0
	end

	local var_61_1

	if not arg_61_0[2] then
		var_61_1 = 0
	end

	local var_61_2

	if not arg_61_0[3] then
		var_61_2 = 0
	end

	if arg_61_0.rangeX or arg_61_0.rangeY or arg_61_0.rangeZ then
		local var_61_3 = var_0_2.RandomDelta(arg_61_0.rangeX)
		local var_61_4 = var_0_2.RandomDelta(arg_61_0.rangeY)
		local var_61_5 = var_0_2.RandomDelta(arg_61_0.rangeZ)

		Vector3 = var_7

		return var_7(var_61_0 + var_61_3, var_61_1 + var_61_4, var_61_2 + var_61_5)
	else
		local var_61_6 = var_0_2.RandomPosXYZ(arg_61_0, "X1", "X2")
		local var_61_7 = var_0_2.RandomPosXYZ(arg_61_0, "Y1", "Y2")
		local var_61_8 = var_0_2.RandomPosXYZ(arg_61_0, "Z1", "Z2")

		Vector3 = var_7

		return var_7(var_61_0 + var_61_6, var_61_1 + var_61_7, var_61_2 + var_61_8)
	end

	return
end

function var_0_2.RandomPosXYZ(arg_62_0, arg_62_1, arg_62_2)
	arg_62_1 = arg_62_0[arg_62_1]
	arg_62_2 = arg_62_0[arg_62_2]

	if arg_62_1 and arg_62_2 then
		math = var_1_10003

		return var_1_10003.random(arg_62_1, arg_62_2)
	else
		return 0
	end

	return
end

function var_0_2.RandomPosCenterRange(arg_63_0)
	local var_63_0 = var_0_2.RandomDelta(arg_63_0.rangeX)
	local var_63_1 = var_0_2.RandomDelta(arg_63_0.rangeY)
	local var_63_2 = var_0_2.RandomDelta(arg_63_0.rangeZ)

	Vector3 = var_4

	return var_4(var_63_0, var_63_1, var_63_2)
end

function var_0_2.RandomDelta(arg_64_0)
	if arg_64_0 and 0 < arg_64_0 then
		math = var_1

		return var_1.random(arg_64_0 + arg_64_0) - arg_64_0
	else
		return 0
	end

	return
end

function var_0_2.simpleCompare(arg_65_0, arg_65_1)
	string = var_1_10002

	local var_65_0, var_65_1 = var_1_10002.find(arg_65_0, "%p+")

	string = var_4

	local var_65_2 = var_4.sub(arg_65_0, var_65_0, var_65_1)

	string = var_5

	local var_65_3 = var_5.sub(arg_65_0, var_65_1 + 1, #arg_65_0)

	getCompareFuncByPunctuation = var_6

	local var_65_4 = var_6(var_65_2)

	tonumber = var_7

	local var_65_5 = var_7(var_65_3)

	return var_65_4(arg_65_1, var_65_5)
end

function var_0_2.parseCompareUnitAttr(arg_66_0, arg_66_1, arg_66_2)
	string = var_1_10003

	local var_66_0, var_66_1 = var_1_10003.find(arg_66_0, "%p+")

	string = var_5

	local var_66_2 = var_5.sub(arg_66_0, var_66_0, var_66_1)

	string = var_6

	local var_66_3 = var_6.sub(arg_66_0, 1, var_66_0 - 1)

	string = var_7

	local var_66_4 = var_7.sub(arg_66_0, var_66_1 + 1, #arg_66_0)

	getCompareFuncByPunctuation = var_8

	local var_66_5 = var_8(var_66_2)

	tonumber = var_9

	local var_66_6, var_66_7

	if not var_9(var_66_3) then
		var_66_6 = arg_66_1
		var_66_7 = arg_66_1.GetAttrByName(var_66_6, var_66_3)
	end

	tonumber = var_66_6

	local var_66_8

	if not var_66_6(var_66_4) then
		var_66_8 = arg_66_2:GetAttrByName(var_66_4)
	end

	return var_66_5(var_66_7, var_66_8)
end

function var_0_2.parseCompareUnitTemplate(arg_67_0, arg_67_1, arg_67_2)
	string = var_1_10003

	local var_67_0, var_67_1 = var_1_10003.find(arg_67_0, "%p+")

	string = var_5

	local var_67_2 = var_5.sub(arg_67_0, var_67_0, var_67_1)

	string = var_6

	local var_67_3 = var_6.sub(arg_67_0, 1, var_67_0 - 1)

	string = var_7

	local var_67_4 = var_7.sub(arg_67_0, var_67_1 + 1, #arg_67_0)

	getCompareFuncByPunctuation = var_8

	local var_67_5 = var_8(var_67_2)

	tonumber = var_9

	local var_67_6, var_67_7

	if not var_9(var_67_3) then
		var_67_6 = arg_67_1
		var_67_7 = arg_67_1.GetTemplateValue(var_67_6, var_67_3)
	end

	tonumber = var_67_6

	local var_67_8

	if not var_67_6(var_67_4) then
		var_67_8 = arg_67_2:GetTemplateValue(var_67_4)
	end

	return var_67_5(var_67_7, var_67_8)
end

function var_0_2.parseCompareBuffAttachData(arg_68_0, arg_68_1)
	string = var_1_10002

	local var_68_0, var_68_1 = var_1_10002.find(arg_68_0, "%p+")

	string = var_4

	local var_68_2 = var_4.sub(arg_68_0, var_68_0, var_68_1)

	string = var_5

	local var_68_3 = var_5.sub(arg_68_0, 1, var_68_0 - 1)

	if arg_68_1.__name ~= var_68_3 then
		return true
	end

	tonumber = var_6
	string = var_7

	local var_68_4 = var_6(var_7.sub(arg_68_0, var_68_1 + 1, #arg_68_0))
	local var_68_5 = arg_68_1
	local var_68_6 = arg_68_1.GetEffectAttachData(var_68_5)

	getCompareFuncByPunctuation = var_68_5

	return var_68_5(var_68_2)(var_68_6, var_68_4)
end

function var_0_2.parseCompare(arg_69_0, arg_69_1)
	string = var_1_10002

	local var_69_0, var_69_1 = var_1_10002.find(arg_69_0, "%p+")

	string = var_4

	local var_69_2 = var_4.sub(arg_69_0, var_69_0, var_69_1)

	string = var_5

	local var_69_3 = var_5.sub(arg_69_0, 1, var_69_0 - 1)

	string = var_6

	local var_69_4 = var_6.sub(arg_69_0, var_69_1 + 1, #arg_69_0)

	getCompareFuncByPunctuation = var_7

	local var_69_5 = var_7(var_69_2)

	tonumber = var_8

	local var_69_6, var_69_7

	if not var_8(var_69_3) then
		var_69_6 = arg_69_1
		var_69_7 = arg_69_1.GetCurrent(var_69_6, var_69_3)
	end

	tonumber = var_69_6

	local var_69_8

	if not var_69_6(var_69_4) then
		var_69_8 = arg_69_1:GetCurrent(var_69_4)
	end

	return var_69_5(var_69_7, var_69_8)
end

function var_0_2.parseFormula(arg_70_0, arg_70_1)
	local var_70_0 = {}
	local var_70_1 = {}

	string = var_1_10004

	for iter_70_0 in var_1_10004.gmatch(arg_70_0, "%w+%.?%w*") do
		table = var_1_10008

		var_1_10008.insert(var_70_0, iter_70_0)
	end

	string = var_4

	for iter_70_1 in var_4.gmatch(arg_70_0, "[^%w%.]") do
		table = var_1_10008

		var_1_10008.insert(var_70_1, iter_70_1)
	end

	local var_70_2 = {}
	local var_70_3 = {}
	local var_70_4 = 1
	local var_70_5 = var_70_0[1]

	tonumber = var_1_10008
	var_70_5 = var_1_10008(var_70_5) or arg_70_1:GetCurrent(var_70_5)
	ipairs = var_8

	for iter_70_2, iter_70_3 in var_8(var_70_1) do
		var_70_4 = var_70_4 + 1
		tonumber = var_1_10013

		local var_70_6

		if not var_1_10013(var_70_0[var_70_4]) then
			var_70_6 = arg_70_1
			var_1_10013 = arg_70_1.GetCurrent(var_70_6, var_70_0[var_70_4])
		end

		if iter_70_3 == "+" or iter_70_3 == "-" then
			table = var_70_6

			var_70_6.insert(var_70_3, var_70_5)

			var_70_5 = var_1_10013
			table = var_70_6

			var_70_6.insert(var_70_2, iter_70_3)
		elseif iter_70_3 == "*" or iter_70_3 == "/" then
			getArithmeticFuncByOperator = var_70_6
			var_70_5 = var_70_6(iter_70_3)(var_70_5, var_1_10013)
		end
	end

	table = var_8

	var_8.insert(var_70_3, var_70_5)

	local var_70_7 = var_70_3[1]

	while var_70_9 < #var_70_3 do
		getArithmeticFuncByOperator = var_70_8

		local var_70_8 = var_70_8(var_70_2[var_70_9])
		local var_70_9 = var_70_9 + 1

		var_70_7 = var_70_8(var_70_7, var_70_3[var_70_9])
	end

	return var_70_7
end

return
