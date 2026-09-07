ys.Battle.BattleCardPuzzleFormulas = ys.Battle.BattleCardPuzzleFormulas or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleAttr
local var_0_3 = ys.Battle.BattleConfig
local var_0_5 = pg.bfConsts
local var_0_6 = ys.Battle.BattleConfig.AMMO_DAMAGE_ENHANCE
local var_0_7 = ys.Battle.BattleConfig.AMMO_DAMAGE_REDUCE

ys.Battle.BattleCardPuzzleFormulas.CUSTOM_FORMULA = {
	double_energy = "energy*5+combo+2"
}

function ys.Battle.BattleCardPuzzleFormulas:CreateContextCalculateDamage(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_5.NUM1
	local var_1_1 = var_0_5.NUM0
	local var_1_3 = var_0_5.DRATE
	local var_1_5 = self:GetWeaponHostAttr()
	local var_1_6 = self:GetWeapon()
	local var_1_9 = self:GetWeaponTempData().attack_attribute
	local var_1_10 = self:GetTemplate()
	local var_1_11 = var_1_10.damage_type
	local var_1_12 = var_1_10.random_damage_rate
	local var_1_13 = arg_1_1._attr
	local var_1_14 = arg_1_3 or var_1_0

	arg_1_2 = arg_1_2 or var_1_1

	local var_1_15 = var_1_13.armorType
	local var_1_16 = var_1_5.formulaLevel - var_1_13.formulaLevel
	local var_1_17 = var_1_0
	local var_1_18 = false
	local var_1_19 = false
	local var_1_20 = var_1_0
	local var_1_21 = (var_1_0 + self:GetWeaponAtkAttr() * var_1_6:GetConvertedAtkAttr()) * self:GetCorrectedDMG()

	if var_1_9 == var_0_0.WeaponDamageAttr.CANNON then
		var_1_14 = var_1_0 + var_0_2.GetCurrent(arg_1_1, "injureRatioByCannon") + var_0_2.GetCurrent(self, "damageRatioByCannon")
	elseif var_1_9 == var_0_0.WeaponDamageAttr.TORPEDO then
		var_1_14 = var_1_0 + var_0_2.GetCurrent(arg_1_1, "injureRatioByBulletTorpedo") + var_0_2.GetCurrent(self, "damageRatioByBulletTorpedo")
	elseif var_1_9 == var_0_0.WeaponDamageAttr.AIR then
		var_1_14 = var_1_14 * math.min(var_1_3[7] / (var_1_13.antiAirPower + var_1_3[7]) + (var_0_2.GetCurrent(self, "airResistPierceActive") == 1 and var_0_2.GetCurrent(self, "airResistPierce") or 0), 1) * (var_1_0 + var_0_2.GetCurrent(arg_1_1, "injureRatioByAir") + var_0_2.GetCurrent(self, "damageRatioByAir"))
	elseif var_1_9 == var_0_0.WeaponDamageAttr.ANTI_AIR then
		-- block empty
	elseif var_1_9 == var_0_0.WeaponDamageAttr.ANIT_SUB then
		-- block empty
	end

	if var_0_2.GetCurrent(arg_1_1, "perfectDodge") == 1 then
		var_1_18 = true
	end

	if not var_1_18 then
		var_1_20 = var_1_21

		if var_0_2.GetCurrent(self, "GCT") == 1 then
			var_1_19 = true
			var_1_17 = math.max(1, var_0_5.DFT_CRIT_EFFECT + var_0_2.GetCurrent(self, "criDamage") - var_0_2.GetCurrent(arg_1_1, "criDamageResist"))
		else
			var_1_19 = false
		end
	else
		var_1_20 = var_1_1

		return var_1_1, {
			isMiss = true,
			isDamagePrevent = false,
			isCri = var_1_19
		}
	end

	local var_1_23 = var_0_5.NUM1
	local var_1_24 = math.max(var_1_23, math.floor(var_1_20 * var_1_14 * (var_1_23 - arg_1_2) * ((var_1_6:GetFixAmmo() or var_1_11[var_1_15] or var_1_23) + var_0_2.GetCurrent(self, var_0_3.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE[var_1_15])) * (var_1_23 + var_0_2.GetCurrent(self, var_0_3.DAMAGE_TO_ARMOR_RATE_ENHANCE[var_1_15])) * var_1_17 * (var_1_23 + var_0_2.GetCurrent(self, "damageRatioBullet")) * var_0_2.GetTagAttr(self, arg_1_1) * (var_1_23 + var_0_2.GetCurrent(arg_1_1, "injureRatio")) * (var_1_23 + var_0_2.GetCurrent(self, var_0_6[var_1_10.ammo_type]) - var_0_2.GetCurrent(arg_1_1, var_0_7[var_1_10.ammo_type])) * (var_1_23 + var_0_2.GetCurrent(arg_1_1, (var_0_2.GetCurrent(self, "comboTag")))) * (var_1_23 + math.min(var_1_3[1], math.max(-var_1_3[1], var_1_16)) * var_1_3[2])))

	if arg_1_1:GetCurrentOxyState() == var_0_0.OXY_STATE.DIVE then
		var_1_24 = math.floor(var_1_24 * var_1_10.antisub_enhancement)
	end

	local var_1_25 = {
		isMiss = var_1_18,
		isCri = var_1_19,
		damageAttr = var_1_9
	}
	local var_1_26 = self:GetDamageEnhance()

	if var_1_26 ~= 1 then
		var_1_24 = math.floor(var_1_24 * var_1_26)
	end

	local var_1_27 = var_1_24 * var_1_13.repressReduce

	if var_1_12 ~= 0 then
		var_1_27 = var_1_27 * (Mathf.RandomFloat(var_1_12) + 1)
	end

	local var_1_28 = var_0_2.GetCurrent(self, "damageEnhanceProjectile")

	return math.floor(math.max(0, var_1_27 + var_1_28) * self:GetWeaponCardPuzzleEnhance()), var_1_25, (var_1_28 < 0 or nil) and var_0_3.BULLET_DECREASE_DMG_FONT
end

function ys.Battle.BattleCardPuzzleFormulas.parseCompare(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = string.find(arg_2_0, "%p+")
	local var_2_2 = string.sub(arg_2_0, 1, var_2_0 - 1)
	local var_2_3 = string.sub(arg_2_0, var_2_1 + 1, #arg_2_0)

	return getCompareFuncByPunctuation((string.sub(arg_2_0, var_2_0, var_2_1)))(tonumber(var_2_2) or arg_2_1:GetCurrent(var_2_2), tonumber(var_2_3) or arg_2_1:GetCurrent(var_2_3))
end

function ys.Battle.BattleCardPuzzleFormulas.parseFormula(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0 in string.gmatch(arg_3_0, "%w+%.?%w*") do
		table.insert(var_3_0, iter_3_0)
	end

	for iter_3_1 in string.gmatch(arg_3_0, "[^%w%.]") do
		table.insert(var_3_1, iter_3_1)
	end

	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4 = 1
	local var_3_5 = var_3_0[1]

	var_3_5 = tonumber(var_3_0[1]) or arg_3_1:GetCurrent(var_3_5)

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		var_3_4 = var_3_4 + 1

		local var_3_6 = tonumber(var_3_0[var_3_4]) or arg_3_1:GetCurrent(var_3_0[var_3_4])

		if iter_3_3 == "+" or iter_3_3 == "-" then
			table.insert(var_3_3, var_3_5)

			var_3_5 = var_3_6

			table.insert(var_3_2, iter_3_3)
		elseif iter_3_3 == "*" or iter_3_3 == "/" then
			var_3_5 = getArithmeticFuncByOperator(iter_3_3)(var_3_5, var_3_6)
		end
	end

	table.insert(var_3_3, var_3_5)

	local var_3_7 = 1
	local var_3_8 = var_3_3[1]

	while var_3_7 < #var_3_3 do
		var_3_7 = var_3_7 + 1
		var_3_8 = getArithmeticFuncByOperator(var_3_2[var_3_7])(var_3_8, var_3_3[var_3_7])
	end

	return var_3_8
end

return
