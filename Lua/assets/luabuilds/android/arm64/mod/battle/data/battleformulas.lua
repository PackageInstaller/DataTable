ys.Battle.BattleFormulas = ys.Battle.BattleFormulas or {}

local var_0_0 = ys.Battle.BattleFormulas
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = pg.gameset
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = ys.Battle.BattleConfig.AnitAirRepeaterConfig
local var_0_5 = pg.bfConsts.SECONDs / ys.Battle.BattleConfig.viewFPS * ys.Battle.BattleConfig.BulletSpeedConvertConst
local var_0_6 = pg.bfConsts.SECONDs / ys.Battle.BattleConfig.calcFPS * ys.Battle.BattleConfig.ShipSpeedConvertConst
local var_0_7 = pg.bfConsts.SECONDs / ys.Battle.BattleConfig.viewFPS * ys.Battle.BattleConfig.AircraftSpeedConvertConst
local var_0_8 = ys.Battle.BattleConfig.AIR_ASSIST_RELOAD_RATIO * pg.bfConsts.PERCENT
local var_0_10 = ys.Battle.BattleConfig.AMMO_DAMAGE_ENHANCE
local var_0_11 = ys.Battle.BattleConfig.AMMO_DAMAGE_REDUCE
local var_0_12 = ys.Battle.BattleConfig.SHIP_TYPE_ACCURACY_ENHANCE

function ys.Battle.BattleFormulas.GetFleetTotalHP(arg_1_0)
	local var_1_0 = arg_1_0:GetFlagShip()
	local var_1_1 = var_0.NUM0

	for iter_1_0, iter_1_1 in ipairs((arg_1_0:GetUnitList())) do
		var_1_1 = iter_1_1 == var_1_0 and var_1_1 + var_0_3.GetCurrent(iter_1_1, "maxHP") * var_0.HP_CONST or var_1_1 + var_0_3.GetCurrent(iter_1_1, "maxHP")
	end

	return var_1_1
end

function ys.Battle.BattleFormulas.GetFleetVelocity(arg_2_0)
	if arg_2_0[1] then
		local var_2_0 = var_0_3.GetCurrent(arg_2_0[1], "fleetVelocity")

		if var_2_0 > var_0.NUM0 then
			return var_2_0 * var_0.PERCENT
		end
	end

	local var_2_1 = var_0.NUM0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		var_2_1 = var_2_1 + iter_2_1:GetAttrByName("velocity")
	end

	return var_2_1 / #arg_2_0 * (var_0.NUM1 - var_0.SPEED_CONST * (#arg_2_0 - var_0.NUM1))
end

function ys.Battle.BattleFormulas.GetFleetReload(arg_3_0)
	local var_3_0 = var_0.NUM0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0 = var_3_0 + iter_3_1:GetReload()
	end

	return var_3_0
end

function ys.Battle.BattleFormulas.GetFleetTorpedoPower(arg_4_0)
	local var_4_0 = var_0.NUM0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_4_0 = var_4_0 + iter_4_1:GetTorpedoPower()
	end

	return var_4_0
end

function ys.Battle.BattleFormulas.AttrFixer(arg_5_0, arg_5_1)
	if arg_5_0 == SYSTEM_DUEL then
		local var_5_0, var_5_1 = ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_5_0, arg_5_1.level)

		arg_5_1.durability = arg_5_1.durability * var_5_0 + var_5_1
	end

	return
end

function ys.Battle.BattleFormulas.HealFixer(arg_6_0, arg_6_1)
	local var_6_0 = 1

	if arg_6_0 == SYSTEM_DUEL then
		var_6_0 = ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_6_0, arg_6_1.level)
	end

	return var_6_0
end

function ys.Battle.BattleFormulas.ConvertShipSpeed(arg_7_0)
	return arg_7_0 * var_0_6
end

function ys.Battle.BattleFormulas.ConvertAircraftSpeed(arg_8_0)
	if arg_8_0 then
		return arg_8_0 * var_0_7
	else
		return nil
	end

	return
end

function ys.Battle.BattleFormulas.ConvertBulletSpeed(arg_9_0)
	return arg_9_0 * var_0_5
end

function ys.Battle.BattleFormulas.ConvertBulletDataSpeed(arg_10_0)
	return arg_10_0 / var_0_5
end

function ys.Battle.BattleFormulas.CreateContextCalculateDamage(arg_11_0)
	return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = var_0.NUM1
		local var_12_1 = var_0.NUM0
		local var_12_2 = var_0.NUM10000
		local var_12_3 = var_0.DRATE
		local var_12_5 = arg_12_0:GetWeaponHostAttr()
		local var_12_6 = arg_12_0:GetWeapon()
		local var_12_7 = arg_12_0:GetWeaponTempData()
		local var_12_9 = var_12_7.attack_attribute
		local var_12_10 = arg_12_0:GetTemplate()
		local var_12_11 = var_12_10.damage_type
		local var_12_12 = var_12_10.random_damage_rate
		local var_12_13 = arg_12_1._attr
		local var_12_14 = arg_12_3 or var_12_0

		arg_12_2 = arg_12_2 or var_12_1

		local var_12_15 = var_12_13.armorType
		local var_12_16 = var_12_5.formulaLevel - var_12_13.formulaLevel
		local var_12_17 = var_12_0
		local var_12_19 = false
		local var_12_20 = var_12_0
		local var_12_21 = (var_12_0 + arg_12_0:GetWeaponAtkAttr() * var_12_6:GetConvertedAtkAttr()) * arg_12_0:GetCorrectedDMG()

		if var_12_9 == var_0_1.WeaponDamageAttr.CANNON then
			var_12_14 = var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByCannon") + var_0_3.GetCurrent(arg_12_0, "damageRatioByCannon")
		elseif var_12_9 == var_0_1.WeaponDamageAttr.TORPEDO then
			var_12_14 = var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByBulletTorpedo") + var_0_3.GetCurrent(arg_12_0, "damageRatioByBulletTorpedo")
		elseif var_12_9 == var_0_1.WeaponDamageAttr.AIR then
			local var_12_22 = var_0_3.GetCurrent(arg_12_0, "airResistPierceActive") == 1 and var_0_3.GetCurrent(arg_12_0, "airResistPierce") or 0

			var_12_14 = var_12_14 * math.min(var_12_3[7] / (var_12_13.antiAirPower + var_12_3[7]) + var_12_22, 1) * (var_12_0 + var_0_3.GetCurrent(arg_12_1, "injureRatioByAir") + var_0_3.GetCurrent(arg_12_0, "damageRatioByAir"))
		elseif var_12_9 == var_0_1.WeaponDamageAttr.ANTI_AIR then
			-- block empty
		elseif var_12_9 == var_0_1.WeaponDamageAttr.ANIT_SUB then
			-- block empty
		end

		local var_12_23 = var_12_5.luck - var_12_13.luck
		local var_12_24 = math.max(var_12_5.attackRating, 0)
		local var_12_25 = var_0_3.GetCurrent(arg_12_1, "perfectDodge") >= 1 and true or not var_0_0.IsHappen(math.max(var_12_3[5], math.min(var_12_0, var_12_4[1] + var_12_24 / (var_12_24 + var_12_13.dodgeRate + var_12_4[2]) + (var_12_23 + var_12_16) * var_0.PERCENT1 + var_0_3.GetCurrent(arg_12_0, "accuracyRateExtra") + var_0_3.GetCurrent(arg_12_0, var_0_12[arg_12_1:GetTemplate().type]) - var_0_3.GetCurrent(arg_12_1, "dodgeRateExtra"))) * var_12_2)

		if not var_12_25 then
			var_12_20 = math.random(var_0.RANDOM_DAMAGE_MIN, var_0.RANDOM_DAMAGE_MAX) + var_12_21

			if var_0_0.IsHappen((var_0_3.GetCurrent(arg_12_0, "GCT") == 1 and 1 or var_0.DFT_CRIT_RATE + var_12_24 / (var_12_24 + var_12_13.dodgeRate + var_12_3[4]) + (var_12_23 + var_12_16) * var_12_3[3] + var_0_3.GetCurrent(arg_12_0, "cri") + var_0_3.GetTagAttrCri(arg_12_0, arg_12_1)) * var_12_2) then
				var_12_19 = true
				var_12_17 = math.max(1, var_0.DFT_CRIT_EFFECT + var_0_3.GetTagAttrCriDmg(arg_12_0, arg_12_1) + var_0_3.GetCurrent(arg_12_0, "criDamage") - var_0_3.GetCurrent(arg_12_1, "criDamageResist"))
			else
				var_12_19 = false
			end
		else
			var_12_20 = var_12_1

			return var_12_1, {
				isMiss = true,
				isDamagePrevent = false,
				isCri = var_12_19
			}
		end

		local var_12_27 = var_0.NUM1
		local var_12_28 = var_12_6:GetFixAmmo() or var_12_11[var_12_15] or var_12_27
		local var_12_29 = math.max(var_12_27, math.floor(var_12_20 * var_12_14 * (var_12_27 - arg_12_2) * (var_12_28 + var_0_3.GetCurrent(arg_12_0, var_0.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE[var_12_15])) * (var_12_27 + var_0_3.GetCurrent(arg_12_0, var_0.DAMAGE_TO_ARMOR_RATE_ENHANCE[var_12_15])) * var_12_17 * (var_12_27 + var_0_3.GetCurrent(arg_12_0, "damageRatioBullet")) * var_0_3.GetTagAttr(arg_12_0, arg_12_1, arg_11_0) * (var_12_27 + var_0_3.GetCurrent(arg_12_1, "injureRatio")) * (var_12_27 + var_0_3.GetCurrent(arg_12_0, var_0_10[var_12_10.ammo_type]) - var_0_3.GetCurrent(arg_12_1, var_0_11[var_12_10.ammo_type])) * (var_12_27 + var_0_3.GetCurrent(arg_12_1, (var_0_3.GetCurrent(arg_12_0, "comboTag")))) * (var_12_27 + math.min(var_12_3[1], math.max(-var_12_3[1], var_12_16)) * var_12_3[2])))

		if arg_12_1:GetCurrentOxyState() == var_0_1.OXY_STATE.DIVE then
			var_12_29 = math.floor(var_12_29 * var_12_10.antisub_enhancement)
		end

		local var_12_30 = {
			isMiss = var_12_25,
			isCri = var_12_19,
			damageAttr = var_12_9
		}
		local var_12_31 = arg_12_0:GetDamageEnhance()

		if var_12_31 ~= 1 then
			var_12_29 = math.floor(var_12_29 * var_12_31)
		end

		local var_12_32 = var_12_29 * var_12_13.repressReduce

		if var_12_12 ~= 0 then
			var_12_32 = var_12_32 * (Mathf.RandomFloat(var_12_12) + 1)
		end

		local var_12_33 = var_0_3.GetCurrent(arg_12_0, "damageEnhanceProjectile")
		local var_12_34 = math.max(0, var_12_32 + var_12_33)

		if arg_11_0 then
			var_12_34 = var_12_34 * (var_0.NUM1 + var_0_3.GetCurrent(arg_12_0, "worldBuffResistance"))
		end

		local var_12_35 = math.floor(var_12_34)
		local var_12_36 = var_12_10.DMG_font[var_12_15]

		if var_12_33 < 0 then
			var_12_36 = var_0.BULLET_DECREASE_DMG_FONT
		end

		return var_12_35, var_12_30, var_12_36
	end
end

function ys.Battle.BattleFormulas.CalculateIgniteDamage(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:GetWeapon():GetCorrectedDMG() * (1 + arg_13_0._attr[arg_13_1] * var_0.PERCENT) * arg_13_2
end

function ys.Battle.BattleFormulas.WeaponDamagePreCorrection(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetTemplateData()

	return (arg_14_1 or var_14_0.damage) * arg_14_0:GetPotential() * var_14_0.corrected * var_0.PERCENT
end

function ys.Battle.BattleFormulas.WeaponAtkAttrPreRatio(arg_15_0)
	return arg_15_0:GetTemplateData().attack_attribute_ratio * var_0.PERCENT2
end

function ys.Battle.BattleFormulas.GetMeteoDamageRatio(arg_16_0)
	if arg_16_0 >= var_0.METEO_RATE[2] then
		for iter_16_0 = 1, arg_16_0 + 1 do
			({})[iter_16_0] = var_0.METEO_RATE[1]
		end

		return {}
	else
		local var_16_0 = 1 - var_0.METEO_RATE[1] * arg_16_0

		for iter_16_1 = 1, arg_16_0 do
			local var_16_1 = math.random() * var_16_0 * (var_0.METEO_RATE[3] + var_0.METEO_RATE[4] * (iter_16_1 - 1) / arg_16_0)

			;({})[iter_16_1] = var_16_1 + var_0.METEO_RATE[1]
			var_16_0 = math.max(0, var_16_0 - var_16_1)
		end

		;({})[arg_16_0 + 1] = var_16_0

		return {}
	end

	return
end

function ys.Battle.BattleFormulas.CalculateFleetAntiAirTotalDamage(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs((arg_17_0:GetCrewUnitList())) do
		local var_17_1 = var_0_3.GetCurrent(iter_17_0, "antiAirPower")

		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			var_17_0 = var_17_0 + math.max(1, (var_17_1 * iter_17_3:GetConvertedAtkAttr() + 1) * iter_17_3:GetCorrectedDMG())
		end
	end

	return var_17_0
end

function ys.Battle.BattleFormulas.CalculateRepaterAnitiAirTotalDamage(arg_18_0)
	return (math.max(1, (var_0_3.GetCurrent(arg_18_0:GetHost(), "antiAirPower") * arg_18_0:GetConvertedAtkAttr() + 1) * arg_18_0:GetCorrectedDMG()))
end

function ys.Battle.BattleFormulas.RollRepeaterHitDice(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetHost()
	local var_19_1 = math.max(var_0_3.GetCurrent(var_19_0, "attackRating"), 0)
	local var_19_2 = var_0_3.GetCurrent(arg_19_1, "airPower") / var_0_4.const_A + var_0_4.const_B

	return var_0_0.IsHappen(math.min(var_0_3.GetCurrent(arg_19_1, "dodgeLimit"), var_19_2 / (var_0_3.GetCurrent(var_19_0, "antiAirPower") * var_0_3.GetCurrent(arg_19_1, "dodge") + var_19_2 + var_0_4.const_C)) * var_0.NUM10000)
end

function ys.Battle.BattleFormulas.AntiAirPowerWeight(arg_20_0)
	return arg_20_0 * arg_20_0
end

function ys.Battle.BattleFormulas.CalculateDamageFromAircraftToMainShip(arg_21_0, arg_21_1)
	local var_21_0 = var_0_3.GetCurrent(arg_21_0, "formulaLevel")

	return (math.floor(math.max(var_0.PLANE_LEAK_RATE[1], math.floor((var_0_3.GetCurrent(arg_21_0, "crashDMG") * (var_0.PLANE_LEAK_RATE[2] + var_0_3.GetCurrent(arg_21_0, "airPower") * var_0.PLANE_LEAK_RATE[3]) + var_21_0 * var_0.PLANE_LEAK_RATE[4]) * (arg_21_0:GetHPRate() * var_0.PLANE_LEAK_RATE[5] + var_0.PLANE_LEAK_RATE[6]) * (var_0.PLANE_LEAK_RATE[7] + (var_21_0 - var_0_3.GetCurrent(arg_21_1, "formulaLevel")) * var_0.PLANE_LEAK_RATE[8]) * (var_0.PLANE_LEAK_RATE[9] / (var_0_3.GetCurrent(arg_21_1, "antiAirPower") + var_0.PLANE_LEAK_RATE[10])) * (var_0.PLANE_LEAK_RATE[11] + var_0_3.GetCurrent(arg_21_1, "injureRatio")) * (var_0.PLANE_LEAK_RATE[12] + var_0_3.GetCurrent(arg_21_1, "injureRatioByAir")))) * var_0_3.GetCurrent(arg_21_1, "repressReduce") * var_0_3.GetCurrent(arg_21_1, "injureRatioKamikazeAir")))
end

function ys.Battle.BattleFormulas.CalculateDamageFromShipToMainShip(arg_22_0, arg_22_1)
	local var_22_0 = var_0_3.GetCurrent(arg_22_0, "formulaLevel")

	return (math.floor(math.max(var_0.LEAK_RATE[1], math.floor(((var_0_3.GetCurrent(arg_22_0, "cannonPower") + var_0_3.GetCurrent(arg_22_0, "torpedoPower")) * var_0.LEAK_RATE[2] + var_22_0 * var_0.LEAK_RATE[7]) * (var_0.LEAK_RATE[5] + var_0_3.GetCurrent(arg_22_1, "injureRatio")) * (arg_22_0:GetHPRate() * var_0.LEAK_RATE[3] + var_0.LEAK_RATE[4]) * (var_0.LEAK_RATE[5] + (var_22_0 - var_0_3.GetCurrent(arg_22_1, "formulaLevel")) * var_0.LEAK_RATE[6]))) * var_0_3.GetCurrent(arg_22_1, "repressReduce") * var_0_3.GetCurrent(arg_22_1, "injureRatioKamikazeShip")))
end

function ys.Battle.BattleFormulas.CalculateDamageFromSubmarinToMainShip(arg_23_0, arg_23_1)
	local var_23_0 = var_0_3.GetCurrent(arg_23_0, "formulaLevel")

	return (math.max(var_0.SUBMARINE_KAMIKAZE[1], math.floor((var_0_3.GetCurrent(arg_23_0, "torpedoPower") * var_0.SUBMARINE_KAMIKAZE[2] + var_23_0 * var_0.SUBMARINE_KAMIKAZE[3]) * (var_0.SUBMARINE_KAMIKAZE[4] + var_0_3.GetCurrent(arg_23_1, "injureRatio")) * (arg_23_0:GetHPRate() * var_0.SUBMARINE_KAMIKAZE[5] + var_0.SUBMARINE_KAMIKAZE[6]) * (var_0.SUBMARINE_KAMIKAZE[7] + (var_23_0 - var_0_3.GetCurrent(arg_23_1, "formulaLevel")) * var_0.SUBMARINE_KAMIKAZE[8]))))
end

function ys.Battle.BattleFormulas.RollSubmarineDualDice(arg_24_0)
	local var_24_0 = var_0_3.GetCurrent(arg_24_0, "dodgeRate")

	return var_0_0.IsHappen(var_24_0 / (var_24_0 + var_0.MONSTER_SUB_KAMIKAZE_DUAL_K) * var_0.MONSTER_SUB_KAMIKAZE_DUAL_P * var_0.NUM10000)
end

function ys.Battle.BattleFormulas.CalculateCrashDamage(arg_25_0, arg_25_1)
	local var_25_0 = var_0_3.GetCurrent(arg_25_0, "maxHP")
	local var_25_1 = var_0_3.GetCurrent(arg_25_1, "maxHP")
	local var_25_2 = math.sqrt(var_25_0 * var_25_1) * var_0.CRASH_RATE[2]

	return math.floor(math.floor(math.min(var_25_0 * var_0.CRASH_RATE[1], var_25_2) * (1 + var_0_3.GetCurrent(arg_25_1, "hammerDamageRatio")) * (1 - math.min(var_0_3.GetCurrent(arg_25_0, "hammerDamagePrevent"), var_0.HammerCFG.PreventUpperBound))) * var_0_3.GetCurrent(arg_25_0, "repressReduce")), (math.floor(math.floor(math.min(var_25_1 * var_0.CRASH_RATE[1], var_25_2) * (1 + var_0_3.GetCurrent(arg_25_0, "hammerDamageRatio")) * (1 - math.min(var_0_3.GetCurrent(arg_25_1, "hammerDamagePrevent"), var_0.HammerCFG.PreventUpperBound))) * var_0_3.GetCurrent(arg_25_1, "repressReduce")))
end

function ys.Battle.BattleFormulas.CalculateFleetDamage(arg_26_0)
	return arg_26_0 * var_0.SCORE_RATE[1]
end

function ys.Battle.BattleFormulas.CalculateFleetOverDamage(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0:GetFlagShip() then
		return var_0_3.GetCurrent(arg_27_1, "maxHP") * var_0.SCORE_RATE[2]
	else
		return var_0_3.GetCurrent(arg_27_1, "maxHP") * var_0.SCORE_RATE[3]
	end

	return
end

function ys.Battle.BattleFormulas.CalculateReloadTime(arg_28_0, arg_28_1)
	return arg_28_0 / var_0.K1 / math.sqrt((arg_28_1 + var_0.K2) * var_0.K3)
end

function ys.Battle.BattleFormulas.CaclulateReloaded(arg_29_0, arg_29_1)
	return math.sqrt((arg_29_1 + var_0.K2) * var_0.K3) * arg_29_0 * var_0.K1
end

function ys.Battle.BattleFormulas.CaclulateReloadAttr(arg_30_0, arg_30_1)
	return math.max(arg_30_0 / var_0.K1 / arg_30_1 * (arg_30_0 / var_0.K1 / arg_30_1) / var_0.K3 - var_0.K2, 0)
end

function ys.Battle.BattleFormulas.CaclulateAirAssistReloadMax(arg_31_0)
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		var_31_0 = var_31_0 + iter_31_1:GetTemplateData().reload_max
	end

	return var_31_0 / #arg_31_0 * var_0_8
end

function ys.Battle.BattleFormulas.CaclulateDOTPlace(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_1.arg_list.tagOnly and not arg_32_3:ContainsLabelTag(arg_32_1.arg_list.tagOnly) then
		return false
	end

	local var_32_0 = var_0.DOT_CONFIG[arg_32_1.arg_list.dotType]
	local var_32_1 = arg_32_2 and arg_32_2:GetAttrByName(var_32_0.hit) or var_0.NUM0
	local var_32_2 = arg_32_3 and arg_32_3:GetAttrByName(var_32_0.resist) or var_0.NUM0

	return var_0_0.IsHappen(arg_32_0 * (var_0.NUM1 + var_32_1) * (var_0.NUM1 - var_32_2))
end

function ys.Battle.BattleFormulas.CaclulateDOTDuration(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = var_0.DOT_CONFIG[arg_33_0.arg_list.dotType]
	local var_33_1 = arg_33_1 and arg_33_1:GetAttrByName(var_33_0.prolong) or var_0.NUM0
	local var_33_2 = arg_33_2 and arg_33_2:GetAttrByName(var_33_0.shorten) or var_0.NUM0

	return var_33_1 - var_33_2
end

function ys.Battle.BattleFormulas.CaclulateDOTDamageEnhanceRate(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = var_0.DOT_CONFIG[arg_34_0.arg_list.dotType]
	local var_34_1 = arg_34_1 and arg_34_1:GetAttrByName(var_34_0.enhance) or var_0.NUM0
	local var_34_2 = arg_34_2 and arg_34_2:GetAttrByName(var_34_0.reduce) or var_0.NUM0

	return (var_34_1 - var_34_2) * var_0.PERCENT2
end

function ys.Battle.BattleFormulas.CaclulateMetaDotaDamage(arg_35_0, arg_35_1)
	local var_35_0 = ys.Battle.BattleDataFunction.GetMetaBossTemplate(arg_35_0)
	local var_35_1

	if type(var_35_0.state) == "string" then
		do return 0 end

		var_35_1 = os.time({
			year = var_35_0.state[1][1][1],
			month = var_35_0.state[1][1][2],
			day = var_35_0.state[1][1][3],
			hour = var_35_0.state[1][2][1],
			minute = var_35_0.state[1][2][2],
			second = var_35_0.state[1][2][3]
		})
	end

	;({
		year = var_35_0.state[2][1][1],
		month = var_35_0.state[2][1][2],
		day = var_35_0.state[2][1][3],
		hour = var_35_0.state[2][2][1],
		minute = var_35_0.state[2][2][2]
	}).second = var_35_0.state[2][2][3]

	local var_35_2 = math.floor(os.difftime(os.time({
		year = var_35_0.state[2][1][1],
		month = var_35_0.state[2][1][2],
		day = var_35_0.state[2][1][3],
		hour = var_35_0.state[2][2][1],
		minute = var_35_0.state[2][2][2]
	}), var_35_1) / 0) - pg.gameset.world_metaboss_supportattack.description[2]
	local var_35_3 = math.floor(ys.Battle.BattleDataFunction.GetMetaBossLevelTemplate(arg_35_0, arg_35_1).hp * pg.gameset.world_metaboss_supportattack.description[3] / pg.gameset.world_metaboss_supportattack.description[5] / (1 + 0.5 * pg.gameset.world_metaboss_supportattack.description[4]) / (var_35_2 - pg.gameset.world_metaboss_supportattack.description[1]) * math.min(math.floor(os.difftime(pg.TimeMgr.GetInstance():GetServerTime(), var_35_1) / 0) - pg.gameset.world_metaboss_supportattack.description[1] + 1, var_35_2 - pg.gameset.world_metaboss_supportattack.description[1]))

	return var_35_3 + math.random(math.floor(pg.gameset.world_metaboss_supportattack.description[4] * var_35_3))
end

function ys.Battle.BattleFormulas.CalculateMaxAimBiasRange(arg_36_0)
	local var_36_0

	if #arg_36_0 == 1 then
		var_36_0 = var_0_3.GetCurrent(arg_36_0[1], "dodgeRate") * var_0.AIM_BIAS_FLEET_RANGE_MOD
	else
		local var_36_2 = {}

		for iter_36_0, iter_36_1 in ipairs(arg_36_0) do
			table.insert(var_36_2, var_0_3.GetCurrent(iter_36_1, "dodgeRate"))
		end

		table.sort(var_36_2, function(arg_37_0, arg_37_1)
			return arg_37_1 < arg_37_0
		end)

		local var_36_3 = var_36_2[3] or 0
		local var_36_4 = var_36_2[1] + var_36_2[2] * 0.6 + var_36_3 * 0.3

		var_36_0 = var_36_4 / #var_36_2 * var_0.AIM_BIAS_FLEET_RANGE_MOD
	end

	return (math.min(var_36_0, var_0.AIM_BIAS_MAX_RANGE_SCOUT))
end

function ys.Battle.BattleFormulas.CalculateMaxAimBiasRangeSub(arg_38_0)
	return (math.min(var_0_3.GetCurrent(arg_38_0[1], "dodgeRate") * var_0.AIM_BIAS_SUB_RANGE_MOD, var_0.AIM_BIAS_MAX_RANGE_SUB))
end

function ys.Battle.BattleFormulas.CalculateMaxAimBiasRangeMonster(arg_39_0)
	return (math.min(var_0_3.GetCurrent(arg_39_0[1], "dodgeRate") * var_0.AIM_BIAS_MONSTER_RANGE_MOD, var_0.AIM_BIAS_MAX_RANGE_MONSTER))
end

function ys.Battle.BattleFormulas.CalculateBiasDecay(arg_40_0)
	return (math.min(arg_40_0 * var_0.AIM_BIAS_DECAY_MOD_MONSTER, var_0.AIM_BIAS_DECAY_SPEED_MAX_SCOUT))
end

function ys.Battle.BattleFormulas.CalculateBiasDecayMonster(arg_41_0)
	return (math.min(arg_41_0 * var_0.AIM_BIAS_DECAY_MOD, var_0.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function ys.Battle.BattleFormulas.CalculateBiasDecayMonsterInSmoke(arg_42_0)
	return (math.min(arg_42_0 * var_0.AIM_BIAS_DECAY_MOD * var_0.AIM_BIAS_DECAY_SMOKE, var_0.AIM_BIAS_DECAY_SPEED_MAX_MONSTER))
end

function ys.Battle.BattleFormulas.CalculateBiasDecayDiving(arg_43_0)
	return (math.min(math.max(0, arg_43_0 - var_0.AIM_BIAS_DECAY_SUB_CONST) * var_0.AIM_BIAS_DECAY_MOD, var_0.AIM_BIAS_DECAY_SPEED_MAX_SUB))
end

function ys.Battle.BattleFormulas.WorldEnemyAttrEnhance(arg_44_0, arg_44_1)
	return 1 + arg_44_0 / (1 + var_0.WORLD_ENEMY_ENHANCEMENT_CONST_C^(var_0.WORLD_ENEMY_ENHANCEMENT_CONST_B - arg_44_1))
end

local var_0_13 = setmetatable({}, {
	__index = function(arg_45_0, arg_45_1)
		return 0
	end
})

function ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance(arg_46_0, arg_46_1)
	arg_46_0 = arg_46_0 or var_0_13
	arg_46_1 = arg_46_1 or var_0_13

	local var_46_3 = {
		{
			var_0_2.attr_world_value_X1.key_value / 16,
			var_0_2.attr_world_value_X2.key_value / 16
		},
		{
			var_0_2.attr_world_value_Y1.key_value / 16,
			var_0_2.attr_world_value_Y2.key_value / 16
		},
		{
			var_0_2.attr_world_value_Z1.key_value / 16,
			var_0_2.attr_world_value_Z2.key_value / 16
		}
	}
	local var_46_4 = var_0_2.attr_world_damage_fix.key_value / 16
	local var_46_5 = arg_46_0[1] == 0 and var_46_3[1][2] or arg_46_1[1] / arg_46_0[1]
	local var_46_6 = 1 - math.clamp(var_46_5, var_46_3[1][1], var_46_3[1][2])

	var_46_5 = arg_46_0[2] == 0 and var_46_3[2][2] or arg_46_1[2] / arg_46_0[2]

	local var_46_7 = 1 - math.clamp(var_46_5, var_46_3[2][1], var_46_3[2][2])

	var_46_5 = arg_46_0[3] == 0 and var_46_3[3][2] or arg_46_1[3] / arg_46_0[3]

	return var_46_6, var_46_7, (math.max(1 - math.clamp(var_46_5, var_46_3[3][1], var_46_3[3][2]), -var_46_4))
end

function ys.Battle.BattleFormulas.WorldMapRewardHealingRate(arg_47_0, arg_47_1)
	arg_47_0 = arg_47_0 or var_0_13
	arg_47_1 = arg_47_1 or var_0_13

	local var_47_0 = arg_47_0[3] == 0 and ({
		var_0_2.attr_world_value_H1.key_value / 16,
		var_0_2.attr_world_value_H2.key_value / 16
	})[2] or arg_47_1[3] / arg_47_0[3]

	return math.clamp(var_47_0, ({
		var_0_2.attr_world_value_H1.key_value / 16,
		var_0_2.attr_world_value_H2.key_value / 16
	})[1], ({
		var_0_2.attr_world_value_H1.key_value / 16,
		var_0_2.attr_world_value_H2.key_value / 16
	})[2])
end

function ys.Battle.BattleFormulas.CalcDamageLock()
	return 0, {
		false,
		true,
		false
	}
end

function ys.Battle.BattleFormulas.CalcDamageLockA2M()
	return 0
end

function ys.Battle.BattleFormulas.CalcDamageLockS2M()
	return 0
end

function ys.Battle.BattleFormulas.CalcDamageLockCrush()
	return 0, 0
end

function ys.Battle.BattleFormulas.UnilateralCrush()
	return 0, 100000
end

function ys.Battle.BattleFormulas.ChapterRepressReduce(arg_53_0)
	return 1 - arg_53_0 * 0.01
end

function ys.Battle.BattleFormulas.IsHappen(arg_54_0)
	if arg_54_0 <= 0 then
		return false
	elseif arg_54_0 >= 10000 then
		return true
	else
		return arg_54_0 >= math.random(10000)
	end

	return
end

function ys.Battle.BattleFormulas.WeightRandom(arg_55_0)
	local var_55_0, var_55_1 = var_0_0.GenerateWeightList(arg_55_0)

	return (var_0_0.WeightListRandom(var_55_0, var_55_1))
end

function ys.Battle.BattleFormulas.WeightListRandom(arg_56_0, arg_56_1)
	local var_56_0 = math.random(0, arg_56_1)

	for iter_56_0, iter_56_1 in pairs(arg_56_0) do
		if iter_56_0.min <= var_56_0 and var_56_0 <= iter_56_0.max then
			return iter_56_1
		end
	end

	return
end

function ys.Battle.BattleFormulas.GenerateWeightList(arg_57_0)
	local var_57_0 = -1

	for iter_57_0, iter_57_1 in ipairs(arg_57_0) do
		var_57_0 = var_57_0 + iter_57_1.weight
		;({})[{
			min = var_57_0 + 1,
			max = var_57_0
		}] = iter_57_1.rst
	end

	return {}, var_57_0
end

function ys.Battle.BattleFormulas.IsListHappen(arg_58_0)
	for iter_58_0, iter_58_1 in ipairs(arg_58_0) do
		if var_0_0.IsHappen(iter_58_1[1]) then
			return true, iter_58_1[2]
		end
	end

	return false, nil
end

function ys.Battle.BattleFormulas.BulletYAngle(arg_59_0, arg_59_1)
	return math.rad2Deg * math.atan2(arg_59_1.z - arg_59_0.z, arg_59_1.x - arg_59_0.x)
end

function ys.Battle.BattleFormulas.RandomPosNull(arg_60_0, arg_60_1)
	arg_60_1 = arg_60_1 or 10

	local var_60_0 = arg_60_0.distance or 10
	local var_60_1 = var_60_0 * var_60_0
	local var_60_2 = ys.Battle.BattleTargetChoise.TargetAll()

	for iter_60_0 = 1, arg_60_1 do
		local var_60_5 = true
		local var_60_6 = var_0_0.RandomPos(arg_60_0)

		for iter_60_1, iter_60_2 in pairs(var_60_2) do
			if var_60_1 > Vector3.SqrDistance(var_60_6, (iter_60_2:GetPosition())) then
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

function ys.Battle.BattleFormulas.RandomPos(arg_61_0)
	local var_61_0 = arg_61_0[1] or 0
	local var_61_1 = arg_61_0[2] or 0
	local var_61_2 = arg_61_0[3] or 0

	if not arg_61_0.rangeX and not arg_61_0.rangeY then
		if arg_61_0.rangeZ then
			return Vector3(var_61_0 + var_0_0.RandomDelta(arg_61_0.rangeX), var_61_1 + var_0_0.RandomDelta(arg_61_0.rangeY), var_61_2 + var_0_0.RandomDelta(arg_61_0.rangeZ))
		else
			return Vector3(var_61_0 + var_0_0.RandomPosXYZ(arg_61_0, "X1", "X2"), var_61_1 + var_0_0.RandomPosXYZ(arg_61_0, "Y1", "Y2"), var_61_2 + var_0_0.RandomPosXYZ(arg_61_0, "Z1", "Z2"))
		end

		return
	end
end

function ys.Battle.BattleFormulas.RandomPosXYZ(arg_62_0, arg_62_1, arg_62_2)
	arg_62_1 = arg_62_0[arg_62_1]
	arg_62_2 = arg_62_0[arg_62_2]

	if arg_62_1 and arg_62_2 then
		return math.random(arg_62_1, arg_62_2)
	else
		return 0
	end

	return
end

function ys.Battle.BattleFormulas.RandomPosCenterRange(arg_63_0)
	return Vector3(var_0_0.RandomDelta(arg_63_0.rangeX), var_0_0.RandomDelta(arg_63_0.rangeY), (var_0_0.RandomDelta(arg_63_0.rangeZ)))
end

function ys.Battle.BattleFormulas.RandomDelta(arg_64_0)
	if arg_64_0 and arg_64_0 > 0 then
		return math.random(arg_64_0 + arg_64_0) - arg_64_0
	else
		return 0
	end

	return
end

function ys.Battle.BattleFormulas.simpleCompare(arg_65_0, arg_65_1)
	local var_65_0, var_65_1 = string.find(arg_65_0, "%p+")

	return getCompareFuncByPunctuation((string.sub(arg_65_0, var_65_0, var_65_1)))(arg_65_1, (tonumber((string.sub(arg_65_0, var_65_1 + 1, #arg_65_0)))))
end

function ys.Battle.BattleFormulas.parseCompareUnitAttr(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0, var_66_1 = string.find(arg_66_0, "%p+")
	local var_66_2 = string.sub(arg_66_0, 1, var_66_0 - 1)
	local var_66_3 = string.sub(arg_66_0, var_66_1 + 1, #arg_66_0)
	local var_66_4 = tonumber(var_66_2) or arg_66_1:GetAttrByName(var_66_2)
	local var_66_5 = tonumber(var_66_3) or arg_66_2:GetAttrByName(var_66_3)

	return getCompareFuncByPunctuation((string.sub(arg_66_0, var_66_0, var_66_1)))(var_66_4, var_66_5)
end

function ys.Battle.BattleFormulas.parseCompareUnitTemplate(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0, var_67_1 = string.find(arg_67_0, "%p+")
	local var_67_2 = string.sub(arg_67_0, 1, var_67_0 - 1)
	local var_67_3 = string.sub(arg_67_0, var_67_1 + 1, #arg_67_0)
	local var_67_4 = tonumber(var_67_2) or arg_67_1:GetTemplateValue(var_67_2)
	local var_67_5 = tonumber(var_67_3) or arg_67_2:GetTemplateValue(var_67_3)

	return getCompareFuncByPunctuation((string.sub(arg_67_0, var_67_0, var_67_1)))(var_67_4, var_67_5)
end

function ys.Battle.BattleFormulas.parseCompareBuffAttachData(arg_68_0, arg_68_1)
	local var_68_0, var_68_1 = string.find(arg_68_0, "%p+")

	if arg_68_1.__name ~= string.sub(arg_68_0, 1, var_68_0 - 1) then
		return true
	end

	return getCompareFuncByPunctuation((string.sub(arg_68_0, var_68_0, var_68_1)))(arg_68_1:GetEffectAttachData(), (tonumber(string.sub(arg_68_0, var_68_1 + 1, #arg_68_0))))
end

function ys.Battle.BattleFormulas.parseCompare(arg_69_0, arg_69_1)
	local var_69_0, var_69_1 = string.find(arg_69_0, "%p+")
	local var_69_2 = string.sub(arg_69_0, 1, var_69_0 - 1)
	local var_69_3 = string.sub(arg_69_0, var_69_1 + 1, #arg_69_0)
	local var_69_4 = tonumber(var_69_2) or arg_69_1:GetCurrent(var_69_2)
	local var_69_5 = tonumber(var_69_3) or arg_69_1:GetCurrent(var_69_3)

	return getCompareFuncByPunctuation((string.sub(arg_69_0, var_69_0, var_69_1)))(var_69_4, var_69_5)
end

function ys.Battle.BattleFormulas.parseFormula(arg_70_0, arg_70_1)
	for iter_70_0 in string.gmatch(arg_70_0, "%w+%.?%w*") do
		table.insert({}, iter_70_0)
	end

	for iter_70_1 in string.gmatch(arg_70_0, "[^%w%.]") do
		table.insert({}, iter_70_1)
	end

	local var_70_0 = 1
	local var_70_1 = ({})[1]

	var_70_1 = tonumber(({})[1]) or arg_70_1:GetCurrent(var_70_1)

	for iter_70_2, iter_70_3 in ipairs({}) do
		var_70_0 = var_70_0 + 1

		local var_70_2 = tonumber(({})[var_70_0]) or arg_70_1:GetCurrent(({})[var_70_0])

		if iter_70_3 == "+" or iter_70_3 == "-" then
			table.insert({}, var_70_1)

			var_70_1 = var_70_2

			table.insert({}, iter_70_3)
		elseif iter_70_3 == "*" or iter_70_3 == "/" then
			var_70_1 = getArithmeticFuncByOperator(iter_70_3)(var_70_1, var_70_2)
		end
	end

	table.insert({}, var_70_1)

	local var_70_3 = 1
	local var_70_4 = ({})[1]

	while var_70_3 < #{} do
		var_70_3 = var_70_3 + 1
		var_70_4 = getArithmeticFuncByOperator(({})[var_70_3])(var_70_4, ({})[var_70_3])
	end

	return var_70_4
end

return
