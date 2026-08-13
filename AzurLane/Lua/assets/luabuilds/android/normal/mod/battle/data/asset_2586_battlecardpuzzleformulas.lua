ys = var_0_10000

local var_0_0 = var_0_10000.Battle

ys = var_0_10001

local var_0_1

if not var_0_10001.Battle.BattleCardPuzzleFormulas then
	var_0_1 = {}
end

var_0_0.BattleCardPuzzleFormulas = var_0_1
ys = var_0_0

local var_0_2 = var_0_0.Battle.BattleCardPuzzleFormulas

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

local var_0_8 = var_0_10006.bfConsts
local var_0_9 = var_0_6.AMMO_DAMAGE_ENHANCE
local var_0_10 = var_0_6.AMMO_DAMAGE_REDUCE

var_0_2.CUSTOM_FORMULA = {
	double_energy = "energy*5+combo+2"
}

function var_0_2.CreateContextCalculateDamage(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_8.NUM1
	local var_1_1 = var_0_8.NUM0
	local var_1_2 = var_0_8.NUM10000
	local var_1_3 = var_0_8.DRATE
	local var_1_4 = var_0_8.ACCURACY
	local var_1_5 = arg_1_0:GetWeaponHostAttr()
	local var_1_6 = arg_1_0:GetWeapon()
	local var_1_7 = arg_1_0:GetWeaponTempData().type
	local var_1_8 = var_11.attack_attribute
	local var_1_9 = var_1_6:GetConvertedAtkAttr()
	local var_1_10 = arg_1_0:GetTemplate().damage_type
	local var_1_11 = var_15.random_damage_rate
	local var_1_12 = arg_1_1._attr
	local var_1_13 = arg_1_3 or var_1_0

	arg_1_2 = arg_1_2 or var_1_1

	local var_1_14 = var_1_12.armorType
	local var_1_15 = var_1_5.formulaLevel - var_1_12.formulaLevel
	local var_1_16 = var_1_0
	local var_1_17 = false
	local var_1_18 = false
	local var_1_19 = var_1_0
	local var_1_20 = arg_1_0:GetCorrectedDMG()
	local var_1_21 = (var_1_0 + arg_1_0:GetWeaponAtkAttr() * var_1_9) * var_1_20

	if var_1_8 == var_0_3.WeaponDamageAttr.CANNON then
		var_1_13 = var_1_0 + var_0_5.GetCurrent(arg_1_1, "injureRatioByCannon") + var_0_5.GetCurrent(arg_1_0, "damageRatioByCannon")
	elseif var_1_8 == var_0_3.WeaponDamageAttr.TORPEDO then
		var_1_13 = var_1_0 + var_0_5.GetCurrent(arg_1_1, "injureRatioByBulletTorpedo") + var_0_5.GetCurrent(arg_1_0, "damageRatioByBulletTorpedo")
	elseif var_1_8 == var_0_3.WeaponDamageAttr.AIR then
		local var_1_22

		if not (var_0_5.GetCurrent(arg_1_0, "airResistPierceActive") == 1) or not var_0_5.GetCurrent(arg_1_0, "airResistPierce") then
			var_1_22 = 0
		end

		math = var_30
		var_1_13 = var_1_13 * var_30.min(var_1_3[7] / (var_1_12.antiAirPower + var_1_3[7]) + var_1_22, 1) * (var_1_0 + var_0_5.GetCurrent(arg_1_1, "injureRatioByAir") + var_0_5.GetCurrent(arg_1_0, "damageRatioByAir"))
	elseif var_1_8 == var_0_3.WeaponDamageAttr.ANTI_AIR then
		-- block empty
	elseif var_1_8 == var_0_3.WeaponDamageAttr.ANIT_SUB then
		-- block empty
	end

	local var_1_23 = var_1_5.luck - var_1_12.luck

	if var_0_5.GetCurrent(arg_1_1, "perfectDodge") == 1 then
		var_1_17 = true
	end

	if not var_1_17 then
		var_1_19 = var_1_21

		if var_0_5.GetCurrent(arg_1_0, "GCT") == 1 then
			var_1_18 = true
			math = var_30
			var_1_16 = var_30.max(1, var_0_8.DFT_CRIT_EFFECT + var_0_5.GetCurrent(arg_1_0, "criDamage") - var_0_5.GetCurrent(arg_1_1, "criDamageResist"))
		else
			var_1_18 = false
		end
	else
		var_1_19 = var_1_1

		local var_1_24 = {
			isMiss = true,
			isDamagePrevent = false,
			isCri = var_1_18
		}

		return var_1_19, var_1_24
	end

	local var_1_25 = var_0_8.NUM1
	local var_1_26 = var_0_5.GetCurrent(arg_1_0, "damageRatioBullet")
	local var_1_27 = var_0_5.GetTagAttr(arg_1_0, arg_1_1)
	local var_1_28 = var_0_5.GetCurrent(arg_1_1, "injureRatio")
	local var_1_29

	if not var_1_6:GetFixAmmo() and not var_1_10[var_1_14] then
		var_1_29 = var_1_25
	end

	local var_1_30 = var_1_29 + var_0_5.GetCurrent(arg_1_0, var_0_6.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE[var_1_14])
	local var_1_31 = var_0_5.GetCurrent(arg_1_0, var_0_6.DAMAGE_TO_ARMOR_RATE_ENHANCE[var_1_14])
	local var_1_32 = var_0_5.GetCurrent(arg_1_0, var_0_9[var_15.ammo_type])
	local var_1_33 = var_0_5.GetCurrent(arg_1_1, var_0_10[var_15.ammo_type])
	local var_1_34 = var_0_5.GetCurrent(arg_1_0, "comboTag")
	local var_1_35 = var_0_5.GetCurrent(arg_1_1, var_1_34)

	math = var_40

	local var_1_36 = var_40.max
	local var_1_37 = var_1_25

	math = var_1_10042

	local var_1_38 = var_1_10042.floor
	local var_1_39 = var_1_19 * var_1_13 * (var_1_25 - arg_1_2) * var_1_30 * (var_1_25 + var_1_31) * var_1_16 * (var_1_25 + var_1_26) * var_1_27 * (var_1_25 + var_1_28) * (var_1_25 + var_1_32 - var_1_33) * (var_1_25 + var_1_35)

	math = var_44

	local var_1_40 = var_44.min
	local var_1_41 = var_1_3[1]

	math = var_1_10046

	local var_1_42 = var_1_36(var_1_37, var_1_38(var_1_39 * (var_1_25 + var_1_40(var_1_41, var_1_10046.max(-var_1_3[1], var_1_15)) * var_1_3[2])))

	if arg_1_1:GetCurrentOxyState() == var_0_3.OXY_STATE.DIVE then
		math = var_40
		var_1_42 = var_40.floor(var_1_42 * var_15.antisub_enhancement)
	end

	local var_1_43 = {
		isMiss = var_1_17,
		isCri = var_1_18,
		damageAttr = var_1_8
	}
	local var_1_44 = arg_1_0

	if arg_1_0.GetDamageEnhance(var_1_44) ~= 1 then
		math = var_1_44
		var_1_42 = var_1_44.floor(var_1_42 * var_41)
	end

	local var_1_45 = var_1_42 * var_1_12.repressReduce

	if var_1_11 ~= 0 then
		Mathf = var_42
		var_1_45 = var_1_45 * (var_42.RandomFloat(var_1_11) + 1)
	end

	local var_1_46 = var_0_5.GetCurrent(arg_1_0, "damageEnhanceProjectile")

	math = var_43

	local var_1_47 = var_43.max(0, var_1_45 + var_1_46)
	local var_1_48 = arg_1_0
	local var_1_49 = var_1_47 * arg_1_0.GetWeaponCardPuzzleEnhance(var_1_48)

	math = var_1_48

	local var_1_50 = var_1_48.floor(var_1_49)
	local var_1_51 = var_15.DMG_font[var_1_14]

	if var_1_46 < 0 then
		var_1_51 = var_0_6.BULLET_DECREASE_DMG_FONT
	end

	return var_1_50, var_1_43, var_1_51
end

function var_0_2.parseCompare(arg_2_0, arg_2_1)
	string = var_1_10002

	local var_2_0, var_2_1 = var_1_10002.find(arg_2_0, "%p+")

	string = var_4

	local var_2_2 = var_4.sub(arg_2_0, var_2_0, var_2_1)

	string = var_5

	local var_2_3 = var_5.sub(arg_2_0, 1, var_2_0 - 1)

	string = var_6

	local var_2_4 = var_6.sub(arg_2_0, var_2_1 + 1, #arg_2_0)

	getCompareFuncByPunctuation = var_7

	local var_2_5 = var_7(var_2_2)

	tonumber = var_8

	local var_2_6, var_2_7

	if not var_8(var_2_3) then
		var_2_6 = arg_2_1
		var_2_7 = arg_2_1.GetCurrent(var_2_6, var_2_3)
	end

	tonumber = var_2_6

	local var_2_8

	if not var_2_6(var_2_4) then
		var_2_8 = arg_2_1:GetCurrent(var_2_4)
	end

	return var_2_5(var_2_7, var_2_8)
end

function var_0_2.parseFormula(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	string = var_1_10004

	for iter_3_0 in var_1_10004.gmatch(arg_3_0, "%w+%.?%w*") do
		table = var_1_10008

		var_1_10008.insert(var_3_0, iter_3_0)
	end

	string = var_4

	for iter_3_1 in var_4.gmatch(arg_3_0, "[^%w%.]") do
		table = var_1_10008

		var_1_10008.insert(var_3_1, iter_3_1)
	end

	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4 = 1
	local var_3_5 = var_3_0[1]

	tonumber = var_1_10008
	var_3_5 = var_1_10008(var_3_5) or arg_3_1:GetCurrent(var_3_5)
	ipairs = var_8

	for iter_3_2, iter_3_3 in var_8(var_3_1) do
		var_3_4 = var_3_4 + 1
		tonumber = var_1_10013

		local var_3_6

		if not var_1_10013(var_3_0[var_3_4]) then
			var_3_6 = arg_3_1
			var_1_10013 = arg_3_1.GetCurrent(var_3_6, var_3_0[var_3_4])
		end

		if iter_3_3 == "+" or iter_3_3 == "-" then
			table = var_3_6

			var_3_6.insert(var_3_3, var_3_5)

			var_3_5 = var_1_10013
			table = var_3_6

			var_3_6.insert(var_3_2, iter_3_3)
		elseif iter_3_3 == "*" or iter_3_3 == "/" then
			getArithmeticFuncByOperator = var_3_6
			var_3_5 = var_3_6(iter_3_3)(var_3_5, var_1_10013)
		end
	end

	table = var_8

	var_8.insert(var_3_3, var_3_5)

	local var_3_7 = var_3_3[1]

	while var_3_9 < #var_3_3 do
		getArithmeticFuncByOperator = var_3_8

		local var_3_8 = var_3_8(var_3_2[var_3_9])
		local var_3_9 = var_3_9 + 1

		var_3_7 = var_3_8(var_3_7, var_3_3[var_3_9])
	end

	return var_3_7
end

return
