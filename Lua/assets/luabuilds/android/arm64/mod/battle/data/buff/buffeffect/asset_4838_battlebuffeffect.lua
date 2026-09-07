ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleFormulas

ys.Battle.BattleBuffEffect = class("BattleBuffEffect")
ys.Battle.BattleBuffEffect.__name = "BattleBuffEffect"

local var_0_3 = ys.Battle.BattleBuffEffect

ys.Battle.BattleBuffEffect.FX_TYPE_NOR = 0
ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR = 1
ys.Battle.BattleBuffEffect.FX_TYPE_CASTER = 2
ys.Battle.BattleBuffEffect.FX_TYPE_LINK = 3
ys.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY = 4
ys.Battle.BattleBuffEffect.FX_TYPE_DOT = 5
ys.Battle.BattleBuffEffect.FX_TTPE_MOD_BATTLE_UNIT_TYPE = 6
ys.Battle.BattleBuffEffect.FX_TYPE_COUNTER = 7
ys.Battle.BattleBuffEffect.FX_TYPE_MOD_MODEL_SCALE = 8

function ys.Battle.BattleBuffEffect:Ctor(arg_1_1)
	self._tempData = Clone(arg_1_1)
	self._type = self._tempData.type
	self._quota = self._tempData.arg_list.quota or -1
	self._indexRequire = self._tempData.arg_list.index
	self._damageAttrRequire = self._tempData.arg_list.damageAttr
	self._damageReasonRequire = self._tempData.arg_list.damageReason
	self._damageSrcTagRequire = self._tempData.arg_list.srcTag
	self._deathCauseRequire = self._tempData.arg_list.deathCause
	self._countType = self._tempData.arg_list.countType
	self._behit = self._tempData.arg_list.be_hit_condition
	self._ammoTypeRequire = self._tempData.arg_list.ammoType
	self._ammoIndexRequire = self._tempData.arg_list.ammoIndex
	self._bulletTagRequire = self._tempData.arg_list.bulletTag
	self._victimTagRequire = self._tempData.arg_list.victimTag
	self._buffStateIDRequire = self._tempData.arg_list.buff_state_id
	self._cloakRequire = self._tempData.arg_list.cloak_state
	self._fleetAttrRequire = self._tempData.arg_list.fleetAttr
	self._fleetAttrDeltaRequire = self._tempData.arg_list.fleetAttrDelta
	self._stackRequire = self._tempData.arg_list.stack_require

	self:ConfigHPTrigger()
	self:ConfigAttrTrigger()
	self:SetActive()

	return
end

function ys.Battle.BattleBuffEffect.GetEffectType(arg_2_0)
	return var_0_3.FX_TYPE_NOR
end

function ys.Battle.BattleBuffEffect:GetPopConfig()
	return self._tempData.pop
end

function ys.Battle.BattleBuffEffect:HaveQuota()
	if self._quota == 0 then
		return false
	else
		return true
	end

	return
end

function ys.Battle.BattleBuffEffect.GetEffectAttachData(arg_5_0)
	return nil
end

function ys.Battle.BattleBuffEffect:ConfigHPTrigger()
	self._hpUpperBound = self._tempData.arg_list.hpUpperBound
	self._hpLowerBound = self._tempData.arg_list.hpLowerBound

	if self._hpUpperBound and self._hpLowerBound == nil then
		self._hpLowerBound = 0
	end

	if self._hpLowerBound and self._hpUpperBound == nil then
		self._hpUpperBound = 1
	end

	self._hpSigned = self._tempData.arg_list.hpSigned or -1
	self._hpOutInterval = self._tempData.arg_list.hpOutInterval
	self._dHPGreater = self._tempData.arg_list.dhpGreater
	self._dhpSmaller = self._tempData.arg_list.dhpSmaller
	self._dHPGreaterMaxHP = self._tempData.arg_list.dhpGreaterMaxhp
	self._dhpSmallerMaxhp = self._tempData.arg_list.dhpSmallerMaxhp

	return
end

function ys.Battle.BattleBuffEffect:ConfigAttrTrigger()
	self._attrLowerBound = self._tempData.arg_list.attrLowerBound
	self._attrUpperBound = self._tempData.arg_list.attrUpperBound
	self._attrInterval = self._tempData.arg_list.attrInterval

	return
end

function ys.Battle.BattleBuffEffect.SetCaster(arg_8_0, arg_8_1)
	arg_8_0._caster = arg_8_1

	return
end

function ys.Battle.BattleBuffEffect.SetCommander(arg_9_0, arg_9_1)
	arg_9_0._commander = arg_9_1

	return
end

function ys.Battle.BattleBuffEffect.SetBullet(arg_10_0, arg_10_1)
	return
end

function ys.Battle.BattleBuffEffect.SetArgs(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.BattleBuffEffect.SetOrb(arg_12_0)
	return
end

function ys.Battle.BattleBuffEffect:Trigger(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self[arg_13_1](self, arg_13_2, arg_13_3, arg_13_4)

	return
end

function ys.Battle.BattleBuffEffect:onAttach(arg_14_1, arg_14_2)
	self:onTrigger(arg_14_1, arg_14_2)

	return
end

function ys.Battle.BattleBuffEffect:onRemove(arg_15_1, arg_15_2)
	self:onTrigger(arg_15_1, arg_15_2)

	return
end

function ys.Battle.BattleBuffEffect:onBuffAdded(arg_16_1, arg_16_2, arg_16_3)
	if not self:buffStateRequire(arg_16_3.buffID) then
		return
	end

	self:onTrigger(arg_16_1, arg_16_2)

	return
end

function ys.Battle.BattleBuffEffect:onBuffRemoved(arg_17_1, arg_17_2, arg_17_3)
	if not self:buffStateRequire(arg_17_3.buffID) then
		return
	end

	self:onTrigger(arg_17_1, arg_17_2)

	return
end

function ys.Battle.BattleBuffEffect:onUpdate(arg_18_1, arg_18_2, arg_18_3)
	self:onTrigger(arg_18_1, arg_18_2, arg_18_3)

	return
end

function ys.Battle.BattleBuffEffect:onStack(arg_19_1, arg_19_2)
	self:onTrigger(arg_19_1, arg_19_2)

	return
end

function ys.Battle.BattleBuffEffect:onBulletHit(arg_20_1, arg_20_2, arg_20_3)
	if not self:equipIndexRequire(arg_20_3.equipIndex) then
		return
	end

	if not self:bulletTagRequire(arg_20_3.bulletTag) then
		return
	end

	if not self:victimRequire(arg_20_3.target, arg_20_1) then
		return
	end

	self:onTrigger(arg_20_1, arg_20_2, arg_20_3)

	return
end

function ys.Battle.BattleBuffEffect:onTeammateBulletHit(arg_21_1, arg_21_2, arg_21_3)
	self:onBulletHit(arg_21_1, arg_21_2, arg_21_3)

	return
end

function ys.Battle.BattleBuffEffect:onBeHit(arg_22_1, arg_22_2, arg_22_3)
	if self._behit then
		if self._behit.damage_type == arg_22_3.weaponType and self._behit.bullet_type == arg_22_3.bulletType then
			self:onTrigger(arg_22_1, arg_22_2)
		end
	else
		self:onTrigger(arg_22_1, arg_22_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onFire(arg_23_1, arg_23_2, arg_23_3)
	if not self:equipIndexRequire(arg_23_3.equipIndex) then
		return
	end

	self:onTrigger(arg_23_1, arg_23_2)

	return
end

function ys.Battle.BattleBuffEffect:onCombo(arg_24_1, arg_24_2, arg_24_3)
	if not self:equipIndexRequire(arg_24_3.equipIndex) then
		return
	end

	local var_24_0 = arg_24_3.matchUnitCount

	if self._tempData.arg_list.upperBound and var_24_0 <= self._tempData.arg_list.upperBound then
		self:onTrigger(arg_24_1, arg_24_2)
	elseif self._tempData.arg_list.lowerBound and self._tempData.arg_list.lowerBound <= var_24_0 then
		self:onTrigger(arg_24_1, arg_24_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:stackRequire(arg_25_1)
	if self._stackRequire then
		return var_0_1.simpleCompare(self._stackRequire, (arg_25_1:GetStack()))
	else
		return true
	end

	return
end

function ys.Battle.BattleBuffEffect:fleetAttrRequire(arg_26_1, arg_26_2)
	if self._fleetAttrRequire then
		local var_26_0, var_26_1 = string.find(self._fleetAttrRequire, "%p+")

		if arg_26_2 ~= nil and string.sub(self._fleetAttrRequire, 1, var_26_0 - 1) ~= arg_26_2 then
			return false
		elseif arg_26_1:GetFleetVO() then
			return var_0_1.parseCompare(self._fleetAttrRequire, (arg_26_1:GetFleetVO():GetFleetAttr()))
		else
			return false
		end
	end

	return true
end

function ys.Battle.BattleBuffEffect:fleetAttrDelatRequire(arg_27_1)
	if self._fleetAttrDeltaRequire then
		return arg_27_1 and var_0_1.simpleCompare(self._fleetAttrDeltaRequire, arg_27_1)
	end

	return true
end

function ys.Battle.BattleBuffEffect:fleetAttrRepeatConsume(arg_28_1)
	local var_28_0 = self._caster:GetFleetVO():GetFleetAttr()
	local var_28_1 = var_28_0:GetCurrent(arg_28_1.attrName)
	local var_28_2 = math.modf(var_28_1 / arg_28_1.value)

	if arg_28_1.repeatCeil then
		var_28_2 = math.min(arg_28_1.repeatCeil, var_28_2)
	end

	var_28_0:SetCurrent(arg_28_1.attrName, var_28_1 - var_28_2 * arg_28_1.value)

	return var_28_2
end

function ys.Battle.BattleBuffEffect:repeatCountParse(arg_29_1)
	local var_29_0 = type(arg_29_1)

	if var_29_0 == "number" then
		return arg_29_1
	elseif var_29_0 == "string" then
		local var_29_1, var_29_2 = string.find(arg_29_1, "%p+")
		local var_29_3 = string.sub(arg_29_1, 1, var_29_1 - 1)
		local var_29_4 = string.sub(arg_29_1, var_29_2 + 1, #arg_29_1)

		if var_29_3 == "fleetAttr" then
			return self._caster:GetFleetVO():GetFleetAttr():GetCurrent(var_29_4)
		elseif var_29_3 == "attr" then
			return self._caster:GetAttrByName(var_29_4)
		end
	end

	return
end

function ys.Battle.BattleBuffEffect:equipIndexRequire(arg_30_1)
	if not self._indexRequire then
		return true
	else
		for iter_30_0, iter_30_1 in ipairs(self._indexRequire) do
			if iter_30_1 == arg_30_1 then
				return true
			end
		end

		return false
	end

	return
end

function ys.Battle.BattleBuffEffect:ammoRequire(arg_31_1)
	if not self._ammoTypeRequire then
		return true
	else
		local var_31_0 = arg_31_1:GetWeaponByIndex(self._ammoIndexRequire)

		if not var_31_0 or var_31_0:GetPrimalAmmoType() ~= self._ammoTypeRequire then
			return false
		else
			return true
		end
	end

	return
end

function ys.Battle.BattleBuffEffect:bulletTagRequire(arg_32_1)
	if not self._bulletTagRequire then
		return true
	else
		for iter_32_0, iter_32_1 in ipairs(self._bulletTagRequire) do
			if table.contains(arg_32_1, iter_32_1) then
				return true
			else
				return false
			end
		end
	end

	return
end

function ys.Battle.BattleBuffEffect:buffStateRequire(arg_33_1)
	if not self._buffStateIDRequire then
		return true
	else
		return arg_33_1 == self._buffStateIDRequire
	end

	return
end

function ys.Battle.BattleBuffEffect:onWeaponSteday(arg_34_1, arg_34_2, arg_34_3)
	self:onFire(arg_34_1, arg_34_2, arg_34_3)

	return
end

function ys.Battle.BattleBuffEffect:onChargeWeaponFire(arg_35_1, arg_35_2, arg_35_3)
	self:onFire(arg_35_1, arg_35_2, arg_35_3)

	return
end

function ys.Battle.BattleBuffEffect:onTorpedoWeaponFire(arg_36_1, arg_36_2, arg_36_3)
	self:onFire(arg_36_1, arg_36_2, arg_36_3)

	return
end

function ys.Battle.BattleBuffEffect:onAntiAirWeaponFireFar(arg_37_1, arg_37_2, arg_37_3)
	self:onFire(arg_37_1, arg_37_2, arg_37_3)

	return
end

function ys.Battle.BattleBuffEffect:onAntiAirWeaponFireNear(arg_38_1, arg_38_2, arg_38_3)
	self:onFire(arg_38_1, arg_38_2, arg_38_3)

	return
end

function ys.Battle.BattleBuffEffect:onManualMissileFire(arg_39_1, arg_39_2, arg_39_3)
	self:onFire(arg_39_1, arg_39_2, arg_39_3)

	return
end

function ys.Battle.BattleBuffEffect:onAllInStrike(arg_40_1, arg_40_2, arg_40_3)
	self:onFire(arg_40_1, arg_40_2, arg_40_3)

	return
end

function ys.Battle.BattleBuffEffect:onAllInStrikeSteady(arg_41_1, arg_41_2, arg_41_3)
	self:onFire(arg_41_1, arg_41_2, arg_41_3)

	return
end

function ys.Battle.BattleBuffEffect:onPointStrikeReady(arg_42_1, arg_42_2, arg_42_3)
	self:onFire(arg_42_1, arg_42_2, arg_42_3)

	return
end

function ys.Battle.BattleBuffEffect:onPointStrikeSteady(arg_43_1, arg_43_2, arg_43_3)
	self:onFire(arg_43_1, arg_43_2, arg_43_3)

	return
end

function ys.Battle.BattleBuffEffect:onPointStrike(arg_44_1, arg_44_2, arg_44_3)
	self:onFire(arg_44_1, arg_44_2, arg_44_3)

	return
end

function ys.Battle.BattleBuffEffect:onWeaonInterrupt(arg_45_1, arg_45_2, arg_45_3)
	self:onTrigger(arg_45_1, arg_45_2)

	return
end

function ys.Battle.BattleBuffEffect:onWeaponSuccess(arg_46_1, arg_46_2, arg_46_3)
	self:onTrigger(arg_46_1, arg_46_2)

	return
end

function ys.Battle.BattleBuffEffect:onChargeWeaponReady(arg_47_1, arg_47_2, arg_47_3)
	self:onTrigger(arg_47_1, arg_47_2)

	return
end

function ys.Battle.BattleBuffEffect:onManualTorpedoReady(arg_48_1, arg_48_2, arg_48_3)
	self:onTrigger(arg_48_1, arg_48_2)

	return
end

function ys.Battle.BattleBuffEffect:onAirAssistReady(arg_49_1, arg_49_2, arg_49_3)
	self:onTrigger(arg_49_1, arg_49_2)

	return
end

function ys.Battle.BattleBuffEffect:onManualMissileReady(arg_50_1, arg_50_2, arg_50_3)
	self:onTrigger(arg_50_1, arg_50_2)

	return
end

function ys.Battle.BattleBuffEffect:onTorpedoButtonPush(arg_51_1, arg_51_2, arg_51_3)
	self:onTrigger(arg_51_1, arg_51_2)

	return
end

function ys.Battle.BattleBuffEffect:onBeforeFatalDamage(arg_52_1, arg_52_2)
	self:onTrigger(arg_52_1, arg_52_2)

	return
end

function ys.Battle.BattleBuffEffect:onAircraftCreate(arg_53_1, arg_53_2, arg_53_3)
	self:onTrigger(arg_53_1, arg_53_2, arg_53_3)

	return
end

function ys.Battle.BattleBuffEffect:onFriendlyAircraftDying(arg_54_1, arg_54_2, arg_54_3)
	if self._tempData.arg_list.templateID then
		if arg_54_3.unit:GetTemplateID() == self._tempData.arg_list.templateID then
			self:onTrigger(arg_54_1, arg_54_2)
		end
	else
		self:onTrigger(arg_54_1, arg_54_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTeammateShipDying(arg_55_1, arg_55_2)
	self:onTrigger(arg_55_1, arg_55_2)

	return
end

function ys.Battle.BattleBuffEffect:onFoeAircraftDying(arg_56_1, arg_56_2, arg_56_3)
	if self._tempData.arg_list.inside then
		if not arg_56_1:GetFleetVO():GetFleetAntiAirWeapon():IsOutOfRange(arg_56_3.unit) then
			self:onTrigger(arg_56_1, arg_56_2)
		end
	elseif self._tempData.arg_list.killer then
		if self:killerRequire(self._tempData.arg_list.killer, arg_56_3.killer, arg_56_1) then
			self:onTrigger(arg_56_1, arg_56_2)
		end
	else
		self:onTrigger(arg_56_1, arg_56_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onFoeDying(arg_57_1, arg_57_2, arg_57_3)
	if self._tempData.arg_list.killer then
		if self:killerRequire(self._tempData.arg_list.killer, arg_57_3.killer, arg_57_1) then
			self:onTrigger(arg_57_1, arg_57_2)
		end
	elseif self:victimRequire(arg_57_3.unit, arg_57_1) then
		self:onTrigger(arg_57_1, arg_57_2)
	else
		self:onTrigger(arg_57_1, arg_57_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onSink(arg_58_1, arg_58_2)
	if self:deathCauseRequire(arg_58_1) then
		self:onTrigger(arg_58_1, arg_58_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:deathCauseRequire(arg_59_1)
	if not self._deathCauseRequire then
		return true
	end

	return table.contains(self._deathCauseRequire, (arg_59_1:GetDeathReason()))
end

function ys.Battle.BattleBuffEffect.killerRequire(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_2 then
		return false
	end

	local var_60_0
	local var_60_1

	var_60_0 = (arg_60_2.__name == var_0_0.Battle.BattlePlayerUnit.__name or arg_60_2.__name == var_0_0.Battle.BattleNPCUnit.__name or arg_60_2.__name == var_0_0.Battle.BattleMinionUnit.__name or arg_60_2.__name == var_0_0.Battle.BattleEnemyUnit.__name or arg_60_2.__name == var_0_0.Battle.BattleAircraftUnit.__name or arg_60_2.__name == var_0_0.Battle.BattleAirFighterUnit.__name) and arg_60_2 or arg_60_2:GetHost()

	if var_60_0 then
		if var_60_0.__name == var_0_0.Battle.BattleAircraftUnit.__name then
			var_60_1 = var_60_0:GetMotherUnit()
		elseif var_60_0.__name == var_0_0.Battle.BattleMinionUnit.__name then
			var_60_1 = var_60_0:GetMaster()
		else
			var_60_1 = var_60_0
			var_60_0 = nil
		end
	else
		return false
	end

	if arg_60_1 == "self" then
		if var_60_1 == arg_60_3 and not var_60_0 then
			return true
		end
	elseif arg_60_1 == "child" and var_60_1 == arg_60_3 and var_60_0 then
		return true
	end

	return false
end

function ys.Battle.BattleBuffEffect:victimRequire(arg_61_1, arg_61_2)
	if not self._victimTagRequire then
		return true
	elseif arg_61_1:ContainsLabelTag(self._victimTagRequire) then
		return true
	else
		return false
	end

	return
end

function ys.Battle.BattleBuffEffect.killerWeaponRequire(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	if not arg_62_2 then
		return false
	end

	if not arg_62_2.GetWeapon then
		return false
	end

	if table.contains(arg_62_1, (arg_62_2:GetWeapon():GetWeaponId())) then
		return true
	end

	return
end

function ys.Battle.BattleBuffEffect:DamageSourceRequire(arg_63_1, arg_63_2)
	if not self._damageSrcTagRequire then
		return true
	else
		if not arg_63_1 then
			return false
		end

		local var_63_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetUnitList()[arg_63_1]

		if not var_63_0 then
			return false
		end

		if var_63_0:ContainsLabelTag(self._damageSrcTagRequire) then
			return true
		else
			return false
		end
	end

	return
end

function ys.Battle.BattleBuffEffect:onInitGame(arg_64_1, arg_64_2)
	self:onTrigger(arg_64_1, arg_64_2)

	return
end

function ys.Battle.BattleBuffEffect:onStartGame(arg_65_1, arg_65_2)
	self:onTrigger(arg_65_1, arg_65_2)

	return
end

function ys.Battle.BattleBuffEffect:onFinishGame(arg_66_1, arg_66_2)
	self:onTrigger(arg_66_1, arg_66_2)

	return
end

function ys.Battle.BattleBuffEffect:onManual(arg_67_1, arg_67_2)
	self:onTrigger(arg_67_1, arg_67_2)

	return
end

function ys.Battle.BattleBuffEffect:onAutoBot(arg_68_1, arg_68_2)
	self:onTrigger(arg_68_1, arg_68_2)

	return
end

function ys.Battle.BattleBuffEffect:onFlagShip(arg_69_1, arg_69_2)
	self:onTrigger(arg_69_1, arg_69_2)

	return
end

function ys.Battle.BattleBuffEffect:onDALCollabFlagShip(arg_70_1, arg_70_2)
	self:onTrigger(arg_70_1, arg_70_2)

	return
end

function ys.Battle.BattleBuffEffect:onUpperConsort(arg_71_1, arg_71_2)
	self:onTrigger(arg_71_1, arg_71_2)

	return
end

function ys.Battle.BattleBuffEffect:onLowerConsort(arg_72_1, arg_72_2)
	self:onTrigger(arg_72_1, arg_72_2)

	return
end

function ys.Battle.BattleBuffEffect:onLeader(arg_73_1, arg_73_2)
	self:onTrigger(arg_73_1, arg_73_2)

	return
end

function ys.Battle.BattleBuffEffect:onCenter(arg_74_1, arg_74_2)
	self:onTrigger(arg_74_1, arg_74_2)

	return
end

function ys.Battle.BattleBuffEffect:onRear(arg_75_1, arg_75_2)
	self:onTrigger(arg_75_1, arg_75_2)

	return
end

function ys.Battle.BattleBuffEffect:onSubLeader(arg_76_1, arg_76_2)
	self:onTrigger(arg_76_1, arg_76_2)

	return
end

function ys.Battle.BattleBuffEffect:onUpperSubConsort(arg_77_1, arg_77_2)
	self:onTrigger(arg_77_1, arg_77_2)

	return
end

function ys.Battle.BattleBuffEffect:onLowerSubConsort(arg_78_1, arg_78_2)
	self:onTrigger(arg_78_1, arg_78_2)

	return
end

function ys.Battle.BattleBuffEffect:onBulletCollide(arg_79_1, arg_79_2, arg_79_3)
	if not self:equipIndexRequire(arg_79_3.equipIndex) then
		return
	end

	self:onTrigger(arg_79_1, arg_79_2)

	return
end

function ys.Battle.BattleBuffEffect:onBulletCollideBefore(arg_80_1, arg_80_2, arg_80_3)
	if not self:equipIndexRequire(arg_80_3.equipIndex) then
		return
	end

	self:onTrigger(arg_80_1, arg_80_2)

	return
end

function ys.Battle.BattleBuffEffect:onBombBulletBang(arg_81_1, arg_81_2, arg_81_3)
	if not self:equipIndexRequire(arg_81_3.equipIndex) then
		return
	end

	self:onTrigger(arg_81_1, arg_81_2)

	return
end

function ys.Battle.BattleBuffEffect:onTorpedoBulletBang(arg_82_1, arg_82_2, arg_82_3)
	if not self:equipIndexRequire(arg_82_3.equipIndex) then
		return
	end

	self:onTrigger(arg_82_1, arg_82_2)

	return
end

function ys.Battle.BattleBuffEffect:onBulletHitBefore(arg_83_1, arg_83_2, arg_83_3)
	if self._behit then
		if self._behit.damage_type == arg_83_3.weaponType and self._behit.bullet_type == arg_83_3.bulletType then
			self:onTrigger(arg_83_1, arg_83_2)
		end
	else
		self:onTrigger(arg_83_1, arg_83_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onBulletCreate(arg_84_1, arg_84_2, arg_84_3)
	if not self:equipIndexRequire(arg_84_3.equipIndex) then
		return
	end

	self:onTrigger(arg_84_1, arg_84_2, arg_84_3)

	return
end

function ys.Battle.BattleBuffEffect:onChargeWeaponBulletCreate(arg_85_1, arg_85_2, arg_85_3)
	self:onBulletCreate(arg_85_1, arg_85_2, arg_85_3)

	return
end

function ys.Battle.BattleBuffEffect:onTorpedoWeaponBulletCreate(arg_86_1, arg_86_2, arg_86_3)
	self:onBulletCreate(arg_86_1, arg_86_2, arg_86_3)

	return
end

function ys.Battle.BattleBuffEffect:onInternalBulletCreate(arg_87_1, arg_87_2, arg_87_3)
	if not self:equipIndexRequire(arg_87_3.equipIndex) then
		return
	end

	self:onTrigger(arg_87_1, arg_87_2, arg_87_3)

	return
end

function ys.Battle.BattleBuffEffect:onManualBulletCreate(arg_88_1, arg_88_2, arg_88_3)
	if not self:equipIndexRequire(arg_88_3.equipIndex) then
		return
	end

	self:onTrigger(arg_88_1, arg_88_2, arg_88_3)

	return
end

function ys.Battle.BattleBuffEffect:onBeforeTakeDamage(arg_89_1, arg_89_2, arg_89_3)
	if self:damageCheck(arg_89_3) then
		self:onTrigger(arg_89_1, arg_89_2, arg_89_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTakeDamage(arg_90_1, arg_90_2, arg_90_3)
	if self:damageCheck(arg_90_3) then
		self:onTrigger(arg_90_1, arg_90_2, arg_90_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTakeHealing(arg_91_1, arg_91_2, arg_91_3)
	self:onTrigger(arg_91_1, arg_91_2, arg_91_3)

	return
end

function ys.Battle.BattleBuffEffect:onShieldAbsorb(arg_92_1, arg_92_2, arg_92_3)
	self:onTrigger(arg_92_1, arg_92_2, arg_92_3)

	return
end

function ys.Battle.BattleBuffEffect:onDamageFix(arg_93_1, arg_93_2, arg_93_3)
	self:onTrigger(arg_93_1, arg_93_2, arg_93_3)

	return
end

function ys.Battle.BattleBuffEffect:onDamageConclude(arg_94_1, arg_94_2, arg_94_3)
	self:onTrigger(arg_94_1, arg_94_2, arg_94_3)

	return
end

function ys.Battle.BattleBuffEffect:onOverHealing(arg_95_1, arg_95_2, arg_95_3)
	self:onTrigger(arg_95_1, arg_95_2, arg_95_3)

	return
end

function ys.Battle.BattleBuffEffect:onFleetAttrUpdate(arg_96_1, arg_96_2, arg_96_3)
	self:onTrigger(arg_96_1, arg_96_2, arg_96_3)

	return
end

function ys.Battle.BattleBuffEffect:damageCheck(arg_97_1)
	return self:damageAttrRequire(arg_97_1.damageAttr) and self:damageReasonRequire(arg_97_1.damageReason)
end

function ys.Battle.BattleBuffEffect:damageAttrRequire(arg_98_1)
	if not self._damageAttrRequire or table.contains(self._damageAttrRequire, arg_98_1) then
		return true
	else
		return false
	end

	return
end

function ys.Battle.BattleBuffEffect:damageReasonRequire(arg_99_1)
	if not self._damageReasonRequire or table.contains(self._damageReasonRequire, arg_99_1) then
		return true
	else
		return false
	end

	return
end

function ys.Battle.BattleBuffEffect:hpIntervalRequire(arg_100_1, arg_100_2)
	if self._hpUpperBound == nil and self._hpLowerBound == nil then
		return true
	end

	if not arg_100_2 or self._hpSigned == 0 then
		-- block empty
	elseif arg_100_2 * self._hpSigned < 0 then
		return false
	end

	local var_100_0

	if self._hpOutInterval then
		if arg_100_1 >= self._hpUpperBound or arg_100_1 <= self._hpLowerBound then
			var_100_0 = true
		end
	elseif arg_100_1 <= self._hpUpperBound and arg_100_1 >= self._hpLowerBound then
		var_100_0 = true
	end

	return var_100_0
end

function ys.Battle.BattleBuffEffect:dhpRequire(arg_101_1, arg_101_2)
	if self._dHPGreater then
		return arg_101_2 * self._dHPGreater > 0 and math.abs(arg_101_2) > math.abs(self._dHPGreater)
	elseif self._dHPGreaterMaxHP then
		return arg_101_2 * (self._dHPGreaterMaxHP * arg_101_1) > 0 and math.abs(arg_101_2) > math.abs(self._dHPGreaterMaxHP * arg_101_1)
	elseif self._dhpSmaller then
		return arg_101_2 * self._dhpSmaller > 0 and math.abs(arg_101_2) < math.abs(self._dhpSmaller)
	elseif self._dhpSmallerMaxhp then
		return arg_101_2 * (self._dhpSmallerMaxhp * arg_101_1) > 0 and math.abs(arg_101_2) < math.abs(self._dhpSmallerMaxhp * arg_101_1)
	else
		return true
	end

	return
end

function ys.Battle.BattleBuffEffect:attrIntervalRequire(arg_102_1)
	return (self._attrLowerBound and arg_102_1 <= self._attrLowerBound or nil) and false
end

function ys.Battle.BattleBuffEffect:onHPRatioUpdate(arg_103_1, arg_103_2, arg_103_3)
	if self:hpIntervalRequire(arg_103_1:GetHPRate(), arg_103_3.dHP) and self:dhpRequire(arg_103_1:GetMaxHP(), arg_103_3.dHP) then
		self:doOnHPRatioUpdate(arg_103_1, arg_103_2, arg_103_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:onFriendlyHpRatioUpdate(arg_104_1, arg_104_2, arg_104_3)
	if self:hpIntervalRequire(arg_104_3.unit:GetHPRate(), arg_104_3.dHP) and self:dhpRequire(arg_104_3.unit:GetMaxHP(), arg_104_3.dHP) then
		self:doOnHPRatioUpdate(arg_104_1, arg_104_2, arg_104_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTeammateHpRatioUpdate(arg_105_1, arg_105_2, arg_105_3)
	self:onFriendlyHpRatioUpdate(arg_105_1, arg_105_2, arg_105_3)

	return
end

function ys.Battle.BattleBuffEffect:onBulletKill(arg_106_1, arg_106_2, arg_106_3)
	if self._tempData.arg_list.killer_weapon_id then
		if self:killerWeaponRequire(self._tempData.arg_list.killer_weapon_id, arg_106_3.killer, arg_106_1) then
			self:onTrigger(arg_106_1, arg_106_2)
		end
	else
		self:onTrigger(arg_106_1, arg_106_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onBattleBuffCount(arg_107_1, arg_107_2, arg_107_3)
	if arg_107_3.buffFX:GetCountType() == self._countType then
		if arg_107_3.buffFX:Repeater() then
			while arg_107_3.buffFX:GetCountProgress() >= 1 do
				self:onTrigger(arg_107_1, arg_107_2)
				arg_107_3.buffFX:ConsumeCount()
			end
		elseif self:onTrigger(arg_107_1, arg_107_2) ~= "overheat" then
			arg_107_3.buffFX:ResetCount()
		end
	end

	return
end

function ys.Battle.BattleBuffEffect:onShieldBroken(arg_108_1, arg_108_2, arg_108_3)
	if arg_108_3.shieldBuffID == self._tempData.arg_list.shieldBuffID then
		self:onTrigger(arg_108_1, arg_108_2)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTrigger(arg_109_1, arg_109_2, arg_109_3)
	if self._quota > 0 then
		self._quota = self._quota - 1
	end

	return
end

function ys.Battle.BattleBuffEffect:doOnHPRatioUpdate(arg_110_1, arg_110_2, arg_110_3)
	self:onTrigger(arg_110_1, arg_110_2, arg_110_3)

	return
end

function ys.Battle.BattleBuffEffect:doOnFriendlyHPRatioUpdate(arg_111_1, arg_111_2, arg_111_3)
	self:onTrigger(arg_111_1, arg_111_2, arg_111_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineDive(arg_112_1, arg_112_2, arg_112_3)
	self:onTrigger(arg_112_1, arg_112_2, arg_112_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineRaid(arg_113_1, arg_113_2, arg_113_3)
	self:onTrigger(arg_113_1, arg_113_2, arg_113_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineFloat(arg_114_1, arg_114_2, arg_114_3)
	self:onTrigger(arg_114_1, arg_114_2, arg_114_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineRetreat(arg_115_1, arg_115_2, arg_115_3)
	self:onTrigger(arg_115_1, arg_115_2, arg_115_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineAid(arg_116_1, arg_116_2, arg_116_3)
	self:onTrigger(arg_116_1, arg_116_2, arg_116_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarinFreeDive(arg_117_1, arg_117_2, arg_117_3)
	self:onTrigger(arg_117_1, arg_117_2, arg_117_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarinFreeFloat(arg_118_1, arg_118_2, arg_118_3)
	self:onTrigger(arg_118_1, arg_118_2, arg_118_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubmarineFreeSpecial(arg_119_1, arg_119_2, arg_119_3)
	self:onTrigger(arg_119_1, arg_119_2, arg_119_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubDetected(arg_120_1, arg_120_2, arg_120_3)
	self:onTrigger(arg_120_1, arg_120_2, arg_120_3)

	return
end

function ys.Battle.BattleBuffEffect:onSubUnDetected(arg_121_1, arg_121_2, arg_121_3)
	self:onTrigger(arg_121_1, arg_121_2, arg_121_3)

	return
end

function ys.Battle.BattleBuffEffect:onAntiSubHateChain(arg_122_1, arg_122_2, arg_122_3)
	self:onTrigger(arg_122_1, arg_122_2, attach)

	return
end

function ys.Battle.BattleBuffEffect:onRetreat(arg_123_1, arg_123_2, arg_123_3)
	self:onTrigger(arg_123_1, arg_123_2, arg_123_3)

	return
end

function ys.Battle.BattleBuffEffect:onCloakUpdate(arg_124_1, arg_124_2, arg_124_3)
	if self:cloakStateRequire(arg_124_3.cloakState) then
		self:onTrigger(arg_124_1, arg_124_2, arg_124_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:onTeammateCloakUpdate(arg_125_1, arg_125_2, arg_125_3)
	if self:cloakStateRequire(arg_125_3.cloakState) then
		self:onTrigger(arg_125_1, arg_125_2, arg_125_3)
	end

	return
end

function ys.Battle.BattleBuffEffect:cloakStateRequire(arg_126_1)
	if not self._cloakRequire then
		return true
	else
		return self._cloakRequire == arg_126_1
	end

	return
end

function ys.Battle.BattleBuffEffect.Interrupt(arg_127_0)
	return
end

function ys.Battle.BattleBuffEffect.Clear(arg_128_0)
	arg_128_0._commander = nil

	return
end

function ys.Battle.BattleBuffEffect.getTargetList(arg_129_0, arg_129_1, arg_129_2, arg_129_3, arg_129_4)
	if type(arg_129_2) == "string" then
		arg_129_2 = {
			arg_129_2
		}
	end

	local var_129_0 = arg_129_3

	if table.contains(arg_129_2, "TargetDamageSource") then
		var_129_0 = Clone(arg_129_3)
		var_129_0.damageSourceID = arg_129_4.damageSrc
	end

	local var_129_1

	for iter_129_0, iter_129_1 in ipairs(arg_129_2) do
		var_129_1 = var_0_0.Battle.BattleTargetChoise[iter_129_1](arg_129_1, var_129_0, var_129_1)
	end

	return var_129_1
end

function ys.Battle.BattleBuffEffect:commanderRequire(arg_130_1)
	if self._tempData.arg_list.CMDBuff_id then
		local var_130_0, var_130_1 = var_0_0.Battle.BattleDataProxy.GetInstance():GetCommanderBuff()
		local var_130_3 = {}

		for iter_130_0, iter_130_1 in ipairs(table.contains(ShipType.SubShipType, arg_130_1:GetTemplate().type) and var_130_1 or var_130_0) do
			if iter_130_1.id == self._tempData.arg_list.CMDBuff_id then
				table.insert(var_130_3, iter_130_1)
			end
		end

		return #var_130_3 > 0
	else
		return true
	end

	return
end

function ys.Battle.BattleBuffEffect:IsActive()
	return self._isActive
end

function ys.Battle.BattleBuffEffect.SetActive(arg_132_0)
	arg_132_0._isActive = true

	return
end

function ys.Battle.BattleBuffEffect.NotActive(arg_133_0)
	arg_133_0._isActive = false

	return
end

function ys.Battle.BattleBuffEffect:IsLock()
	return self._isLock
end

function ys.Battle.BattleBuffEffect.SetLock(arg_135_0)
	arg_135_0._isLock = true

	return
end

function ys.Battle.BattleBuffEffect.NotLock(arg_136_0)
	arg_136_0._isLock = false

	return
end

function ys.Battle.BattleBuffEffect.Dispose(arg_137_0)
	return
end

return
