ys = var_0_10000

local var_0_0 = var_0_10000.Battle.BattleDataProxy

ys = var_0_10001

local var_0_1 = var_0_10001.Battle.BattleEvent

ys = var_0_10002

local var_0_2 = var_0_10002.Battle.BattleFormulas

ys = var_0_10003

local var_0_3 = var_0_10003.Battle.BattleConst

ys = var_0_10004

local var_0_4 = var_0_10004.Battle.BattleConfig

ys = var_0_10005

local var_0_5 = var_0_10005.Battle.BattleDataFunction

ys = var_0_10006

local var_0_6 = var_0_10006.Battle.BattleAttr

ys = var_0_10007

local var_0_7 = var_0_10007.Battle.BattleVariable

function var_0_0.SetupCalculateDamage(arg_1_0, arg_1_1)
	arg_1_0._calculateDamage = arg_1_1 or var_0_2.CreateContextCalculateDamage()

	return
end

function var_0_0.SetupDamageKamikazeAir(arg_2_0, arg_2_1)
	arg_2_0._calculateDamageKamikazeAir = arg_2_1 or var_0_2.CalculateDamageFromAircraftToMainShip

	return
end

function var_0_0.SetupDamageKamikazeShip(arg_3_0, arg_3_1)
	arg_3_0._calculateDamageKamikazeShip = arg_3_1 or var_0_2.CalculateDamageFromShipToMainShip

	return
end

function var_0_0.SetupDamageCrush(arg_4_0, arg_4_1)
	arg_4_0._calculateDamageCrush = arg_4_1 or var_0_2.CalculateCrashDamage

	return
end

function var_0_0.ClearFormulas(arg_5_0)
	arg_5_0._calculateDamage = nil
	arg_5_0._calculateDamageKamikazeAir = nil
	arg_5_0._calculateDamageKamikazeShip = nil
	arg_5_0._calculateDamageCrush = nil

	return
end

function var_0_0.HandleBulletHit(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		assert = var_1_10003

		var_1_10003(false, "HandleBulletHit, but no vehicleData")

		return false
	elseif not arg_6_1 then
		assert = var_1_10003

		var_1_10003(false, "HandleBulletHit, but no bulletData")

		return false
	end

	if var_0_6.IsSpirit(arg_6_2) then
		return false
	end

	if arg_6_1:IsCollided(arg_6_2:GetUniqueID()) == true then
		return
	end

	arg_6_1:Hit(arg_6_2:GetUniqueID(), arg_6_2:GetUnitType())

	local var_6_0 = {
		_bullet = arg_6_1
	}
	local var_6_1 = arg_6_1:GetWeapon()

	var_6_0.equipIndex = var_6.GetEquipmentIndex(var_6_1)
	var_6_0.bulletTag = arg_6_1:GetExtraTag()

	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.BuffTrigger

	ys = var_9

	var_6_3(var_6_2, var_9.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE, var_6_0)

	if arg_6_2:GetUnitType() == var_0_3.UnitType.PLAYER_UNIT and arg_6_2:GetIFF() == var_0_4.FRIENDLY_CODE and not arg_6_1:IsSpectreBullet() then
		ys = var_6

		local var_6_4 = var_6.Battle.BattleCameraUtil.GetInstance()
		local var_6_5 = var_6.StartShake

		pg = var_9

		var_6_5(var_6_4, var_9.shake_template[var_0_3.ShakeType.HIT])
	end

	return true
end

function var_0_0.HandleDamage(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_2:GetIFF() == var_0_4.FOE_CODE and arg_7_2:IsShowHPBar() then
		local var_7_0 = arg_7_0
		local var_7_1 = arg_7_0.DispatchEvent

		ys = var_1_10009

		var_7_1(var_7_0, var_1_10009.Event.New(var_0_1.HIT_ENEMY, arg_7_2))
	end

	local var_7_2 = arg_7_1:GetWeapon()
	local var_7_3 = arg_7_1:GetWeaponHostAttr()
	local var_7_4 = arg_7_1:GetExtraTag()
	local var_7_5 = var_7_2:GetTemplateData()
	local var_7_6 = {
		weaponType = var_7_5.attack_attribute,
		bulletType = arg_7_1:GetType(),
		bulletTag = var_7_4
	}

	arg_7_2:TriggerBuff(var_0_3.BuffEffectType.ON_BULLET_HIT_BEFORE, var_7_6)

	if var_0_6.IsInvincible(arg_7_2) then
		return
	end

	local var_7_7, var_7_8, var_7_9 = arg_7_0._calculateDamage(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_10 = var_7_8.isMiss
	local var_7_11 = var_7_8.isCri
	local var_7_12 = var_7_8.damageAttr

	arg_7_1:AppendDamageUnit(arg_7_2:GetUniqueID())

	local var_7_13 = var_7_5.type
	local var_7_14 = var_7_2:GetEquipmentIndex()

	var_7_7 = arg_7_1:IsSpectreBullet() and 0 or var_7_7

	local var_7_15 = {
		target = arg_7_2,
		damage = var_7_7,
		weaponType = var_7_13,
		equipIndex = var_7_14,
		bulletTag = var_7_4
	}
	local var_7_16 = {
		isHeal = false,
		isMiss = var_7_10,
		isCri = var_7_11,
		attr = var_7_12,
		font = var_7_9,
		cldPos = arg_7_1:GetPosition()
	}
	local var_7_17

	if not var_7_3.hostUID then
		var_7_17 = var_7_3.battleUID
	end

	var_7_16.srcID = var_7_17
	var_7_16.spectreBullet = var_19

	local var_7_18 = arg_7_1:GetWeapon()

	var_22.WeaponStatistics(var_7_18, var_7_7, var_7_11, var_7_10)

	local var_7_19 = arg_7_2:UpdateHP(var_7_7 * -1, var_7_16)

	arg_7_0:DamageStatistics(var_7_3.id, arg_7_2:GetAttrByName("id"), -var_7_19)

	if not var_7_10 and arg_7_1:GetWeaponTempData().type ~= var_0_3.EquipmentType.ANTI_AIR then
		local var_7_20 = arg_7_1
		local var_7_21 = arg_7_1.BuffTrigger

		ys = var_27

		var_7_21(var_7_20, var_27.Battle.BattleConst.BuffEffectType.ON_BULLET_HIT, var_7_15)

		local var_7_22 = arg_7_1

		if arg_7_1.GetHost(var_7_22) and var_7_24:IsAlive() then
			local var_7_23 = var_7_24:GetUnitType()

			ys = var_7_22

			if var_7_23 ~= var_7_22.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT then
				table = var_7_23

				local var_7_24

				if var_7_23.contains(var_0_3.AircraftUnitType, var_7_24:GetUnitType()) then
					var_7_24 = var_7_24:GetMotherUnit()
				end

				local var_7_25 = var_7_24:GetIFF()

				pairs = var_26

				for iter_7_2, iter_7_1 in var_26(arg_7_0._unitList) do
					if iter_7_1:GetIFF() == var_7_25 and iter_7_1 ~= var_7_24 then
						local var_7_26 = iter_7_1
						local var_7_27 = iter_7_1.TriggerBuff

						ys = var_1_10034

						var_7_27(var_7_26, var_1_10034.Battle.BattleConst.BuffEffectType.ON_TEAMMATE_BULLET_HIT, var_7_15)
					end
				end
			end
		end
	end

	local var_7_28 = arg_7_2:GetUnitType()
	local var_7_29 = true

	if var_7_28 ~= var_0_3.UnitType.AIRCRAFT_UNIT and var_7_28 ~= var_0_3.UnitType.AIRFIGHTER_UNIT and var_7_28 ~= var_0_3.UnitType.FUNNEL_UNIT and var_7_28 ~= var_0_3.UnitType.UAV_UNIT then
		var_7_29 = false
	end

	if arg_7_2:IsAlive() then
		if not var_7_29 then
			ipairs = var_26

			for iter_7_2, iter_7_3 in var_26(arg_7_1:GetAttachBuff()) do
				if iter_7_3.hit_ignore or not var_7_10 then
					var_0_0.HandleBuffPlacer(iter_7_3, arg_7_1, arg_7_2)
				end
			end
		end

		if not var_7_10 then
			arg_7_2:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, var_7_6)
		end
	else
		local var_7_30 = arg_7_1
		local var_7_31 = arg_7_1.BuffTrigger

		ys = iter_7_2

		var_7_31(var_7_30, iter_7_2.Battle.BattleConst.BuffEffectType.ON_BULLET_KILL, {
			unit = arg_7_2,
			killer = arg_7_1
		})
		arg_7_0:obituary(arg_7_2, var_7_29, arg_7_1)
		arg_7_0:KillCountStatistics(var_7_3.id, arg_7_2:GetAttrByName("id"))
	end

	return var_7_10, var_7_11
end

function var_0_0.HandleMeteoDamage(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_2.GetMeteoDamageRatio(#arg_8_2)

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_2) do
		arg_8_0:HandleDamage(arg_8_1, iter_8_1, nil, var_8_0[iter_8_0])
	end

	return
end

function var_0_0.HandleDirectDamage(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	local var_9_0

	if arg_9_3 then
		var_9_0 = arg_9_3:GetAttrByName("id")
	end

	local var_9_1 = {
		isMiss = false,
		isCri = false,
		isHeal = false,
		damageReason = arg_9_4,
		srcID = var_9_0,
		isReflect = arg_9_5,
		ignoreInvincible = arg_9_6,
		ignoreShield = arg_9_7
	}
	local var_9_2 = arg_9_1:GetAttrByName("id")
	local var_9_3 = arg_9_1:UpdateHP(arg_9_2 * -1, var_9_1)
	local var_9_4 = arg_9_1:IsAlive()

	arg_9_0:DamageStatistics(var_9_0, var_9_2, -var_9_3)

	if not var_9_4 and var_9_0 then
		arg_9_0:KillCountStatistics(var_9_0, var_9_2)
	end

	if not var_9_4 then
		local var_9_5 = arg_9_1:GetUnitType()
		local var_9_6 = true

		if var_9_5 ~= var_0_3.UnitType.AIRCRAFT_UNIT and var_9_5 ~= var_0_3.UnitType.AIRFIGHTER_UNIT and var_9_5 ~= var_0_3.UnitType.FUNNEL_UNIT and var_9_5 ~= var_0_3.UnitType.UAV_UNIT then
			var_9_6 = false
		end

		arg_9_0:obituary(arg_9_1, var_9_6, arg_9_3)
	end

	return
end

function var_0_0.obituary(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_0._unitList) do
		if iter_10_1 ~= arg_10_1 then
			if iter_10_1:GetIFF() == arg_10_1:GetIFF() then
				if arg_10_2 then
					iter_10_1:TriggerBuff(var_0_3.BuffEffectType.ON_FRIENDLY_AIRCRAFT_DYING, {
						unit = arg_10_1,
						killer = arg_10_3
					})
				elseif not arg_10_1:GetWorldDeathMark() then
					iter_10_1:TriggerBuff(var_0_3.BuffEffectType.ON_TEAMMATE_SHIP_DYING, {
						unit = arg_10_1,
						killer = arg_10_3
					})
				end
			elseif arg_10_2 then
				iter_10_1:TriggerBuff(var_0_3.BuffEffectType.ON_FOE_AIRCRAFT_DYING, {
					unit = arg_10_1,
					killer = arg_10_3
				})
			else
				iter_10_1:TriggerBuff(var_0_3.BuffEffectType.ON_FOE_DYING, {
					unit = arg_10_1,
					killer = arg_10_3
				})
			end
		end
	end

	return
end

function var_0_0.HandleAircraftMissDamage(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == nil then
		return
	end

	local var_11_0 = arg_11_2:GetCloakList()

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_0) do
		iter_11_1:CloakExpose(arg_11_0._airExpose)
	end

	local var_11_1 = arg_11_1:GetPosition()
	local var_11_2 = arg_11_2
	local var_11_3 = arg_11_2.NearestUnitByType
	local var_11_4 = var_11_1

	ShipType = var_1_10009

	if var_11_3(var_11_2, var_11_4, var_1_10009.CloakShipTypeList) then
		var_5:CloakExpose(arg_11_0._airExposeEX)
	end

	if arg_11_2:RandomMainVictim({
		"immuneDirectHit"
	}) then
		local var_11_5 = arg_11_0._calculateDamageKamikazeAir(arg_11_1, var_6)

		var_6:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
		arg_11_0:HandleDirectDamage(var_6, var_11_5, arg_11_1)
	end

	return
end

function var_0_0.HandleShipMissDamage(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == nil then
		return
	end

	local var_12_0 = arg_12_2:GetCloakList()

	ipairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(var_12_0) do
		iter_12_1:CloakExpose(arg_12_0._shipExpose)
	end

	local var_12_1 = arg_12_1:GetPosition()
	local var_12_2 = arg_12_2
	local var_12_3 = arg_12_2.NearestUnitByType
	local var_12_4 = var_12_1

	ShipType = var_1_10009

	if var_12_3(var_12_2, var_12_4, var_1_10009.CloakShipTypeList) then
		var_5:CloakExpose(arg_12_0._shipExposeEX)
	end

	local var_12_5 = arg_12_2

	if arg_12_2.RandomMainVictim(var_12_5, {
		"immuneDirectHit"
	}) then
		local var_12_6 = arg_12_1:GetTemplate().type

		table = var_12_5

		local var_12_7 = var_12_5.contains

		ShipType = var_1_10010

		if var_12_7(var_1_10010.SubShipType, var_12_6) then
			local var_12_8 = var_0_2.CalculateDamageFromSubmarinToMainShip(arg_12_1, var_6)

			var_6:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
			arg_12_0:HandleDirectDamage(var_6, var_12_8, arg_12_1)

			if var_6:IsAlive() and var_0_2.RollSubmarineDualDice(arg_12_1) then
				local var_12_9 = var_0_2.CalculateDamageFromSubmarinToMainShip(arg_12_1, var_6)

				var_6:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
				arg_12_0:HandleDirectDamage(var_6, var_12_9, arg_12_1)
			end
		else
			local var_12_10 = arg_12_0._calculateDamageKamikazeShip(arg_12_1, var_6)

			var_6:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
			arg_12_0:HandleDirectDamage(var_6, var_12_10, arg_12_1)
		end
	end

	return
end

function var_0_0.HandleCrashDamage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = arg_13_0._calculateDamageCrush(arg_13_1, arg_13_2)

	arg_13_0:HandleDirectDamage(arg_13_1, var_13_0, arg_13_2, var_0_3.UnitDeathReason.CRUSH)
	arg_13_0:HandleDirectDamage(arg_13_2, var_13_1, arg_13_1, var_0_3.UnitDeathReason.CRUSH)

	return
end

function var_0_0.HandleBuffPlacer(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_5.GetBuffTemplate(arg_14_0.buff_id).effect_list
	local var_14_1 = false

	if var_14_0[1].type == "BattleBuffDOT" then
		if var_0_2.CaclulateDOTPlace(arg_14_0.rant, var_14_0[1], arg_14_1, arg_14_2) then
			var_14_1 = true
		end
	else
		local var_14_2 = var_0_2.IsHappen
		local var_14_3

		if not arg_14_0.rant then
			var_14_3 = 10000
		end

		if var_14_2(var_14_3) then
			var_14_1 = true
		end
	end

	if var_14_1 then
		local var_14_4

		if not arg_14_0.buff_level then
			var_14_4 = arg_14_0.level
		end

		ys = var_1_10007

		local var_14_5 = var_1_10007.Battle.BattleBuffUnit.New(arg_14_0.buff_id, var_14_4, arg_14_1)

		var_7.SetGroupLevel(var_14_5, arg_14_0.group_level)
		var_7:SetOrb(arg_14_1, arg_14_0.level)
		arg_14_2:AddBuff(var_7)
	end

	return
end

function var_0_0.HandleDOTPlace(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.arg_list
	local var_15_1 = var_0_4.DOT_CONFIG[var_15_0.dotType]
	local var_15_2 = arg_15_1:GetAttrByName(var_15_1.hit)

	if var_0_2.IsHappen(var_15_0.ACC + arg_15_1:GetAttrByName(var_15_1.hit) - arg_15_2:GetAttrByName(var_15_1.resist)) then
		return true
	end

	return false
end

function var_0_0.HandleShipCrashDamageList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:GetHostileCldList()

	pairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(var_16_0) do
		table = var_1_10009

		if not var_1_10009.contains(arg_16_2, iter_16_0) then
			arg_16_1:RemoveHostileCld(iter_16_0)
		end
	end

	ipairs = var_4

	for iter_16_2, iter_16_3 in var_4(arg_16_2) do
		if var_16_0[iter_16_3] == nil then
			local var_16_1

			local function var_16_2()
				local var_17_0 = arg_16_0

				var_0.HandleCrashDamage(var_17_0, arg_16_0._unitList[iter_16_3], arg_16_1)

				return
			end

			pg = var_1_10010

			local var_16_3 = var_1_10010.TimeMgr.GetInstance()

			var_1_10010 = var_1_10010.AddBattleTimer(var_16_3, "shipCld", nil, var_0_4.SHIP_CLD_INTERVAL, var_16_2, true)

			arg_16_1:AppendHostileCld(iter_16_3, var_1_10010)
			var_16_2()

			if not arg_16_1:IsAlive() then
				break
			end
		end
	end

	return
end

function var_0_0.HandleShipCrashDecelerate(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 0 and arg_18_1:IsCrash() then
		arg_18_1:SetCrash(false)
	elseif arg_18_2 > 0 and not arg_18_1:IsCrash() then
		arg_18_1:SetCrash(true)
	end

	return
end

function var_0_0.HandleWallHitByBullet(arg_19_0, arg_19_1, arg_19_2)
	return (arg_19_1:GetCldFunc()(arg_19_2))
end

function var_0_0.HandleWallHitByShip(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1:GetCldFunc()(arg_20_2)

	return
end

function var_0_0.HandleWallDamage(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2:GetIFF() == var_0_4.FOE_CODE and arg_21_2:IsShowHPBar() then
		local var_21_0 = arg_21_0
		local var_21_1 = arg_21_0.DispatchEvent

		ys = var_1_10007

		var_21_1(var_21_0, var_1_10007.Event.New(var_0_1.HIT_ENEMY, arg_21_2))
	end

	local var_21_2 = var_0_6.GetCurrent(arg_21_1, "id")

	if var_0_6.IsInvincible(arg_21_2) then
		return
	end

	local var_21_3, var_21_4, var_21_5 = arg_21_0._calculateDamage(arg_21_1, arg_21_2)
	local var_21_6 = var_21_4.isMiss
	local var_21_7 = var_21_4.isCri
	local var_21_8 = var_21_4.damageAttr
	local var_21_9 = {
		isHeal = false,
		isMiss = var_21_6,
		isCri = var_21_7,
		attr = var_21_8,
		font = var_21_5,
		cldPos = arg_21_1:GetPosition(),
		srcID = var_21_2
	}
	local var_21_10 = arg_21_2:UpdateHP(var_21_3 * -1, var_21_9)

	arg_21_0:DamageStatistics(var_21_2, arg_21_2:GetAttrByName("id"), -var_21_10)

	if arg_21_2:IsAlive() then
		if not var_21_6 then
			arg_21_2:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
		end
	else
		arg_21_0:obituary(arg_21_2, false, arg_21_1)
		arg_21_0:KillCountStatistics(var_21_2, arg_21_2:GetAttrByName("id"))
	end

	return var_21_6, var_21_7
end

return
