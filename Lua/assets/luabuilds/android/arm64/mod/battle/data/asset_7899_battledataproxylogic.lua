local var_0_0 = ys.Battle.BattleDataProxy
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleDataFunction
local var_0_6 = ys.Battle.BattleAttr

function ys.Battle.BattleDataProxy.SetupCalculateDamage(arg_1_0, arg_1_1)
	arg_1_0._calculateDamage = arg_1_1 or var_0_2.CreateContextCalculateDamage()

	return
end

function ys.Battle.BattleDataProxy.SetupDamageKamikazeAir(arg_2_0, arg_2_1)
	arg_2_0._calculateDamageKamikazeAir = arg_2_1 or var_0_2.CalculateDamageFromAircraftToMainShip

	return
end

function ys.Battle.BattleDataProxy.SetupDamageKamikazeShip(arg_3_0, arg_3_1)
	arg_3_0._calculateDamageKamikazeShip = arg_3_1 or var_0_2.CalculateDamageFromShipToMainShip

	return
end

function ys.Battle.BattleDataProxy.SetupDamageCrush(arg_4_0, arg_4_1)
	arg_4_0._calculateDamageCrush = arg_4_1 or var_0_2.CalculateCrashDamage

	return
end

function ys.Battle.BattleDataProxy.ClearFormulas(arg_5_0)
	arg_5_0._calculateDamage = nil
	arg_5_0._calculateDamageKamikazeAir = nil
	arg_5_0._calculateDamageKamikazeShip = nil
	arg_5_0._calculateDamageCrush = nil

	return
end

function ys.Battle.BattleDataProxy.HandleBulletHit(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		assert(false, "HandleBulletHit, but no vehicleData")

		return false
	elseif not arg_6_1 then
		assert(false, "HandleBulletHit, but no bulletData")

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

	var_6_0.equipIndex = arg_6_1:GetWeapon():GetEquipmentIndex()
	var_6_0.bulletTag = arg_6_1:GetExtraTag()

	arg_6_1:BuffTrigger(ys.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE, var_6_0)

	if arg_6_2:GetUnitType() == var_0_3.UnitType.PLAYER_UNIT and arg_6_2:GetIFF() == var_0_4.FRIENDLY_CODE and not arg_6_1:IsSpectreBullet() then
		ys.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0_3.ShakeType.HIT])
	end

	return true
end

function ys.Battle.BattleDataProxy:HandleDamage(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_2:GetIFF() == var_0_4.FOE_CODE and arg_7_2:IsShowHPBar() then
		self:DispatchEvent(ys.Event.New(var_0_1.HIT_ENEMY, arg_7_2))
	end

	local var_7_0 = arg_7_1:GetWeapon()
	local var_7_1 = arg_7_1:GetWeaponHostAttr()
	local var_7_2 = arg_7_1:GetExtraTag()
	local var_7_3 = var_7_0:GetTemplateData()
	local var_7_4 = {
		weaponType = var_7_3.attack_attribute,
		bulletType = arg_7_1:GetType(),
		bulletTag = var_7_2
	}

	arg_7_2:TriggerBuff(var_0_3.BuffEffectType.ON_BULLET_HIT_BEFORE, var_7_4)

	if var_0_6.IsInvincible(arg_7_2) then
		return
	end

	local var_7_5, var_7_6, var_7_7 = self._calculateDamage(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_8 = var_7_6.isMiss
	local var_7_9 = var_7_6.isCri

	arg_7_1:AppendDamageUnit(arg_7_2:GetUniqueID())

	local var_7_10 = arg_7_1:IsSpectreBullet()

	var_7_5 = var_7_10 and 0 or var_7_5

	local var_7_11 = {
		target = arg_7_2,
		damage = var_7_5,
		weaponType = var_7_3.type,
		equipIndex = var_7_0:GetEquipmentIndex(),
		bulletTag = var_7_2
	}
	local var_7_12 = {
		isHeal = false,
		isMiss = var_7_8,
		isCri = var_7_9,
		attr = var_7_6.damageAttr,
		font = var_7_7,
		cldPos = arg_7_1:GetPosition()
	}

	var_7_12.srcID = var_7_1.hostUID or var_7_1.battleUID
	var_7_12.spectreBullet = var_7_10

	arg_7_1:GetWeapon():WeaponStatistics(var_7_5, var_7_9, var_7_8)
	self:DamageStatistics(var_7_1.id, arg_7_2:GetAttrByName("id"), -arg_7_2:UpdateHP(var_7_5 * -1, var_7_12))

	if not var_7_8 and arg_7_1:GetWeaponTempData().type ~= var_0_3.EquipmentType.ANTI_AIR then
		arg_7_1:BuffTrigger(ys.Battle.BattleConst.BuffEffectType.ON_BULLET_HIT, var_7_11)

		local var_7_13 = arg_7_1:GetHost()

		if var_7_13 and var_7_13:IsAlive() and var_7_13:GetUnitType() ~= ys.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT then
			if table.contains(var_0_3.AircraftUnitType, var_7_13:GetUnitType()) then
				var_7_13 = var_7_13:GetMotherUnit()
			end

			local var_7_14 = var_7_13:GetIFF()

			for iter_7_0, iter_7_1 in pairs(self._unitList) do
				if iter_7_1:GetIFF() == var_7_14 and iter_7_1 ~= var_7_13 then
					iter_7_1:TriggerBuff(ys.Battle.BattleConst.BuffEffectType.ON_TEAMMATE_BULLET_HIT, var_7_11)
				end
			end
		end
	end

	local var_7_15 = arg_7_2:GetUnitType()
	local var_7_16 = not (var_7_15 ~= var_0_3.UnitType.AIRCRAFT_UNIT and var_7_15 ~= var_0_3.UnitType.AIRFIGHTER_UNIT and var_7_15 ~= var_0_3.UnitType.FUNNEL_UNIT and var_7_15 ~= var_0_3.UnitType.UAV_UNIT)

	if arg_7_2:IsAlive() then
		if not var_7_16 then
			for iter_7_2, iter_7_3 in ipairs(arg_7_1:GetAttachBuff()) do
				if iter_7_3.hit_ignore or not var_7_8 then
					var_0_0.HandleBuffPlacer(iter_7_3, arg_7_1, arg_7_2)
				end
			end
		end

		if not var_7_8 then
			arg_7_2:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, var_7_4)
		end
	else
		arg_7_1:BuffTrigger(ys.Battle.BattleConst.BuffEffectType.ON_BULLET_KILL, {
			unit = arg_7_2,
			killer = arg_7_1
		})
		self:obituary(arg_7_2, var_7_16, arg_7_1)
		self:KillCountStatistics(var_7_1.id, arg_7_2:GetAttrByName("id"))
	end

	return var_7_8, var_7_9
end

function ys.Battle.BattleDataProxy:HandleMeteoDamage(arg_8_1, arg_8_2)
	local var_8_0 = var_0_2.GetMeteoDamageRatio(#arg_8_2)

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		self:HandleDamage(arg_8_1, iter_8_1, nil, var_8_0[iter_8_0])
	end

	return
end

function ys.Battle.BattleDataProxy:HandleDirectDamage(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	local var_9_0
	local var_9_2
	local var_9_1

	if arg_9_3 then
		var_9_0 = arg_9_3:GetAttrByName("id")
		var_9_1 = arg_9_1:GetAttrByName("id")
		var_9_2 = arg_9_1:IsAlive()
	end

	self:DamageStatistics(var_9_0, var_9_1, -arg_9_1:UpdateHP(arg_9_2 * -1, {
		isMiss = false,
		isCri = false,
		isHeal = false,
		damageReason = arg_9_4,
		srcID = var_9_0,
		isReflect = arg_9_5,
		ignoreInvincible = arg_9_6,
		ignoreShield = arg_9_7
	}))

	if not var_9_2 and var_9_0 then
		self:KillCountStatistics(var_9_0, var_9_1)
	end

	if not var_9_2 then
		local var_9_3 = arg_9_1:GetUnitType()

		self:obituary(arg_9_1, not (var_9_3 ~= var_0_3.UnitType.AIRCRAFT_UNIT and var_9_3 ~= var_0_3.UnitType.AIRFIGHTER_UNIT and var_9_3 ~= var_0_3.UnitType.FUNNEL_UNIT and var_9_3 ~= var_0_3.UnitType.UAV_UNIT), arg_9_3)
	end

	return
end

function ys.Battle.BattleDataProxy:obituary(arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in pairs(self._unitList) do
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

function ys.Battle.BattleDataProxy:HandleAircraftMissDamage(arg_11_1, arg_11_2)
	if arg_11_2 == nil then
		return
	end

	for iter_11_0, iter_11_1 in ipairs((arg_11_2:GetCloakList())) do
		iter_11_1:CloakExpose(self._airExpose)
	end

	local var_11_0 = arg_11_2:NearestUnitByType(arg_11_1:GetPosition(), ShipType.CloakShipTypeList)

	if var_11_0 then
		var_11_0:CloakExpose(self._airExposeEX)
	end

	local var_11_1 = arg_11_2:RandomMainVictim({
		"immuneDirectHit"
	})

	if var_11_1 then
		var_11_1:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
		self:HandleDirectDamage(var_11_1, self._calculateDamageKamikazeAir(arg_11_1, var_11_1), arg_11_1)
	end

	return
end

function ys.Battle.BattleDataProxy:HandleShipMissDamage(arg_12_1, arg_12_2)
	if arg_12_2 == nil then
		return
	end

	for iter_12_0, iter_12_1 in ipairs((arg_12_2:GetCloakList())) do
		iter_12_1:CloakExpose(self._shipExpose)
	end

	local var_12_0 = arg_12_2:NearestUnitByType(arg_12_1:GetPosition(), ShipType.CloakShipTypeList)

	if var_12_0 then
		var_12_0:CloakExpose(self._shipExposeEX)
	end

	local var_12_1 = arg_12_2:RandomMainVictim({
		"immuneDirectHit"
	})

	if var_12_1 then
		if table.contains(ShipType.SubShipType, arg_12_1:GetTemplate().type) then
			var_12_1:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
			self:HandleDirectDamage(var_12_1, var_0_2.CalculateDamageFromSubmarinToMainShip(arg_12_1, var_12_1), arg_12_1)

			if var_12_1:IsAlive() and var_0_2.RollSubmarineDualDice(arg_12_1) then
				var_12_1:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
				self:HandleDirectDamage(var_12_1, var_0_2.CalculateDamageFromSubmarinToMainShip(arg_12_1, var_12_1), arg_12_1)
			end
		else
			local var_12_2 = self._calculateDamageKamikazeShip(arg_12_1, var_12_1)

			var_12_1:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
			self:HandleDirectDamage(var_12_1, var_12_2, arg_12_1)
		end
	end

	return
end

function ys.Battle.BattleDataProxy:HandleCrashDamage(arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = self._calculateDamageCrush(arg_13_1, arg_13_2)

	self:HandleDirectDamage(arg_13_1, var_13_0, arg_13_2, var_0_3.UnitDeathReason.CRUSH)
	self:HandleDirectDamage(arg_13_2, var_13_1, arg_13_1, var_0_3.UnitDeathReason.CRUSH)

	return
end

function ys.Battle.BattleDataProxy:HandleBuffPlacer(arg_14_1, arg_14_2)
	local var_14_0 = var_0_5.GetBuffTemplate(self.buff_id).effect_list
	local var_14_1 = false

	if var_14_0[1].type == "BattleBuffDOT" then
		if var_0_2.CaclulateDOTPlace(self.rant, var_14_0[1], arg_14_1, arg_14_2) then
			var_14_1 = true
		end
	elseif var_0_2.IsHappen(self.rant or 10000) then
		var_14_1 = true
	end

	if var_14_1 then
		local var_14_4 = ys.Battle.BattleBuffUnit.New(self.buff_id, self.buff_level or self.level, arg_14_1)

		var_14_4:SetGroupLevel(self.group_level)
		var_14_4:SetOrb(arg_14_1, self.level)
		arg_14_2:AddBuff(var_14_4)
	end

	return
end

function ys.Battle.BattleDataProxy:HandleDOTPlace(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:GetAttrByName(var_0_4.DOT_CONFIG[self.arg_list.dotType].hit)

	if var_0_2.IsHappen(self.arg_list.ACC + arg_15_1:GetAttrByName(var_0_4.DOT_CONFIG[self.arg_list.dotType].hit) - arg_15_2:GetAttrByName(var_0_4.DOT_CONFIG[self.arg_list.dotType].resist)) then
		return true
	end

	return false
end

function ys.Battle.BattleDataProxy.HandleShipCrashDamageList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:GetHostileCldList()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if not table.contains(arg_16_2, iter_16_0) then
			arg_16_1:RemoveHostileCld(iter_16_0)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_2) do
		if var_16_0[iter_16_3] == nil then
			arg_16_1:AppendHostileCld(iter_16_3, (pg.TimeMgr.GetInstance():AddBattleTimer("shipCld", nil, var_0_4.SHIP_CLD_INTERVAL, nil, true)))
			var_16_1()

			if not arg_16_1:IsAlive() then
				break
			end
		end
	end

	return
end

function ys.Battle.BattleDataProxy.HandleShipCrashDecelerate(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 0 and arg_18_1:IsCrash() then
		arg_18_1:SetCrash(false)
	elseif arg_18_2 > 0 and not arg_18_1:IsCrash() then
		arg_18_1:SetCrash(true)
	end

	return
end

function ys.Battle.BattleDataProxy.HandleWallHitByBullet(arg_19_0, arg_19_1, arg_19_2)
	return (arg_19_1:GetCldFunc()(arg_19_2))
end

function ys.Battle.BattleDataProxy.HandleWallHitByShip(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1:GetCldFunc()(arg_20_2)

	return
end

function ys.Battle.BattleDataProxy:HandleWallDamage(arg_21_1, arg_21_2)
	if arg_21_2:GetIFF() == var_0_4.FOE_CODE and arg_21_2:IsShowHPBar() then
		self:DispatchEvent(ys.Event.New(var_0_1.HIT_ENEMY, arg_21_2))
	end

	local var_21_0 = var_0_6.GetCurrent(arg_21_1, "id")

	if var_0_6.IsInvincible(arg_21_2) then
		return
	end

	local var_21_1, var_21_2, var_21_3 = self._calculateDamage(arg_21_1, arg_21_2)
	local var_21_4 = var_21_2.isMiss
	local var_21_5 = var_21_2.isCri

	self:DamageStatistics(var_21_0, arg_21_2:GetAttrByName("id"), -arg_21_2:UpdateHP(var_21_1 * -1, {
		isHeal = false,
		isMiss = var_21_2.isMiss,
		isCri = var_21_2.isCri,
		attr = var_21_2.damageAttr,
		font = var_21_3,
		cldPos = arg_21_1:GetPosition(),
		srcID = var_21_0
	}))

	if arg_21_2:IsAlive() then
		if not var_21_4 then
			arg_21_2:TriggerBuff(var_0_3.BuffEffectType.ON_BE_HIT, {})
		end
	else
		self:obituary(arg_21_2, false, arg_21_1)
		self:KillCountStatistics(var_21_0, arg_21_2:GetAttrByName("id"))
	end

	return var_21_4, var_21_5
end

return
