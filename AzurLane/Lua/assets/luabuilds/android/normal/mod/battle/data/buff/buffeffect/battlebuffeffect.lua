ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleBuffEffect = var_0_10003("BattleBuffEffect")
var_0.Battle.BattleBuffEffect.__name = "BattleBuffEffect"

local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle.BattleBuffEffect

var_0_4.FX_TYPE_NOR = 0
var_0_4.FX_TYPE_MOD_ATTR = 1
var_0_4.FX_TYPE_CASTER = 2
var_0_4.FX_TYPE_LINK = 3
var_0_4.FX_TYPE_MOD_VELOCTIY = 4
var_0_4.FX_TYPE_DOT = 5
var_0_4.FX_TTPE_MOD_BATTLE_UNIT_TYPE = 6
var_0_4.FX_TYPE_COUNTER = 7
var_0_4.FX_TYPE_MOD_MODEL_SCALE = 8

function var_0_4.Ctor(arg_1_0, arg_1_1)
	Clone = var_1_10002
	arg_1_0._tempData = var_1_10002(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	local var_1_0

	if not arg_1_0._tempData.arg_list.quota then
		var_1_0 = -1
	end

	arg_1_0._quota = var_1_0
	arg_1_0._indexRequire = var_2.index
	arg_1_0._damageAttrRequire = var_2.damageAttr
	arg_1_0._damageReasonRequire = var_2.damageReason
	arg_1_0._damageSrcTagRequire = var_2.srcTag
	arg_1_0._deathCauseRequire = var_2.deathCause
	arg_1_0._countType = var_2.countType
	arg_1_0._behit = var_2.be_hit_condition
	arg_1_0._ammoTypeRequire = var_2.ammoType
	arg_1_0._ammoIndexRequire = var_2.ammoIndex
	arg_1_0._bulletTagRequire = var_2.bulletTag
	arg_1_0._victimTagRequire = var_2.victimTag
	arg_1_0._buffStateIDRequire = var_2.buff_state_id
	arg_1_0._cloakRequire = var_2.cloak_state
	arg_1_0._fleetAttrRequire = var_2.fleetAttr
	arg_1_0._fleetAttrDeltaRequire = var_2.fleetAttrDelta
	arg_1_0._stackRequire = var_2.stack_require

	arg_1_0:ConfigHPTrigger()
	arg_1_0:ConfigAttrTrigger()
	arg_1_0:SetActive()

	return
end

function var_0_4.GetEffectType(arg_2_0)
	return var_0_4.FX_TYPE_NOR
end

function var_0_4.GetPopConfig(arg_3_0)
	return arg_3_0._tempData.pop
end

function var_0_4.HaveQuota(arg_4_0)
	if arg_4_0._quota == 0 then
		return false
	else
		return true
	end

	return
end

function var_0_4.GetEffectAttachData(arg_5_0)
	return nil
end

function var_0_4.ConfigHPTrigger(arg_6_0)
	arg_6_0._hpUpperBound = arg_6_0._tempData.arg_list.hpUpperBound
	arg_6_0._hpLowerBound = var_1.hpLowerBound

	if arg_6_0._hpUpperBound and arg_6_0._hpLowerBound == nil then
		arg_6_0._hpLowerBound = 0
	end

	if arg_6_0._hpLowerBound and arg_6_0._hpUpperBound == nil then
		arg_6_0._hpUpperBound = 1
	end

	local var_6_0

	if not var_1.hpSigned then
		var_6_0 = -1
	end

	arg_6_0._hpSigned = var_6_0
	arg_6_0._hpOutInterval = var_1.hpOutInterval
	arg_6_0._dHPGreater = var_1.dhpGreater
	arg_6_0._dhpSmaller = var_1.dhpSmaller
	arg_6_0._dHPGreaterMaxHP = var_1.dhpGreaterMaxhp
	arg_6_0._dhpSmallerMaxhp = var_1.dhpSmallerMaxhp

	return
end

function var_0_4.ConfigAttrTrigger(arg_7_0)
	arg_7_0._attrLowerBound = arg_7_0._tempData.arg_list.attrLowerBound
	arg_7_0._attrUpperBound = var_1.attrUpperBound
	arg_7_0._attrInterval = var_1.attrInterval

	return
end

function var_0_4.SetCaster(arg_8_0, arg_8_1)
	arg_8_0._caster = arg_8_1

	return
end

function var_0_4.SetCommander(arg_9_0, arg_9_1)
	arg_9_0._commander = arg_9_1

	return
end

function var_0_4.SetBullet(arg_10_0, arg_10_1)
	return
end

function var_0_4.SetArgs(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_4.SetOrb(arg_12_0)
	return
end

function var_0_4.Trigger(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0[arg_13_1](arg_13_0, arg_13_2, arg_13_3, arg_13_4)

	return
end

function var_0_4.onAttach(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:onTrigger(arg_14_1, arg_14_2)

	return
end

function var_0_4.onRemove(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:onTrigger(arg_15_1, arg_15_2)

	return
end

function var_0_4.onBuffAdded(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0:buffStateRequire(arg_16_3.buffID) then
		return
	end

	arg_16_0:onTrigger(arg_16_1, arg_16_2)

	return
end

function var_0_4.onBuffRemoved(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0:buffStateRequire(arg_17_3.buffID) then
		return
	end

	arg_17_0:onTrigger(arg_17_1, arg_17_2)

	return
end

function var_0_4.onUpdate(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:onTrigger(arg_18_1, arg_18_2, arg_18_3)

	return
end

function var_0_4.onStack(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:onTrigger(arg_19_1, arg_19_2)

	return
end

function var_0_4.onBulletHit(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_0:equipIndexRequire(arg_20_3.equipIndex) then
		return
	end

	if not arg_20_0:bulletTagRequire(arg_20_3.bulletTag) then
		return
	end

	if not arg_20_0:victimRequire(arg_20_3.target, arg_20_1) then
		return
	end

	arg_20_0:onTrigger(arg_20_1, arg_20_2, arg_20_3)

	return
end

function var_0_4.onTeammateBulletHit(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:onBulletHit(arg_21_1, arg_21_2, arg_21_3)

	return
end

function var_0_4.onBeHit(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0._behit then
		if arg_22_0._behit.damage_type == arg_22_3.weaponType and arg_22_0._behit.bullet_type == arg_22_3.bulletType then
			arg_22_0:onTrigger(arg_22_1, arg_22_2)
		end
	else
		arg_22_0:onTrigger(arg_22_1, arg_22_2)
	end

	return
end

function var_0_4.onFire(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if not arg_23_0:equipIndexRequire(arg_23_3.equipIndex) then
		return
	end

	arg_23_0:onTrigger(arg_23_1, arg_23_2)

	return
end

function var_0_4.onCombo(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if not arg_24_0:equipIndexRequire(arg_24_3.equipIndex) then
		return
	end

	local var_24_0 = arg_24_3.matchUnitCount
	local var_24_1 = arg_24_0._tempData.arg_list.upperBound
	local var_24_2 = arg_24_0._tempData.arg_list.lowerBound

	if var_24_1 and var_24_0 <= var_24_1 then
		arg_24_0:onTrigger(arg_24_1, arg_24_2)
	elseif var_24_2 and var_24_2 <= var_24_0 then
		arg_24_0:onTrigger(arg_24_1, arg_24_2)
	end

	return
end

function var_0_4.stackRequire(arg_25_0, arg_25_1)
	if arg_25_0._stackRequire then
		local var_25_0 = arg_25_1:GetStack()

		return var_0_1.simpleCompare(arg_25_0._stackRequire, var_25_0)
	else
		return true
	end

	return
end

function var_0_4.fleetAttrRequire(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0._fleetAttrRequire then
		string = var_3

		local var_26_0, var_26_1 = var_3.find(arg_26_0._fleetAttrRequire, "%p+")

		string = var_5

		local var_26_2 = var_5.sub(arg_26_0._fleetAttrRequire, 1, var_26_0 - 1)

		if arg_26_2 ~= nil and var_26_2 ~= arg_26_2 then
			return false
		elseif arg_26_1:GetFleetVO() then
			local var_26_3 = arg_26_1:GetFleetVO()
			local var_26_4 = var_6.GetFleetAttr(var_26_3)

			return var_0_1.parseCompare(arg_26_0._fleetAttrRequire, var_26_4)
		else
			return false
		end
	end

	return true
end

function var_0_4.fleetAttrDelatRequire(arg_27_0, arg_27_1)
	if arg_27_0._fleetAttrDeltaRequire then
		return arg_27_1 and var_0_1.simpleCompare(arg_27_0._fleetAttrDeltaRequire, arg_27_1)
	end

	return true
end

function var_0_4.fleetAttrRepeatConsume(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._caster
	local var_28_1 = var_2.GetFleetVO(var_28_0)
	local var_28_2 = var_2.GetFleetAttr(var_28_1)
	local var_28_3 = var_2.GetCurrent(var_28_2, arg_28_1.attrName)

	math = var_28_2

	local var_28_4 = var_28_2.modf(var_28_3 / arg_28_1.value)

	if arg_28_1.repeatCeil then
		math = var_5
		var_28_4 = var_5.min(arg_28_1.repeatCeil, var_28_4)
	end

	local var_28_5 = var_28_4 * arg_28_1.value

	var_2:SetCurrent(arg_28_1.attrName, var_28_3 - var_28_5)

	return var_28_4
end

function var_0_4.repeatCountParse(arg_29_0, arg_29_1)
	type = var_1_10002

	if var_1_10002(arg_29_1) == "number" then
		return arg_29_1
	elseif var_2 == "string" then
		string = var_3

		local var_29_0, var_29_1 = var_3.find(arg_29_1, "%p+")

		string = var_5

		local var_29_2 = var_5.sub(arg_29_1, 1, var_29_0 - 1)

		string = var_6

		local var_29_3 = var_6.sub(arg_29_1, var_29_1 + 1, #arg_29_1)

		if var_29_2 == "fleetAttr" then
			local var_29_4 = arg_29_0._caster
			local var_29_5 = var_7.GetFleetVO(var_29_4)
			local var_29_6 = var_7.GetFleetAttr(var_29_5)

			return var_7.GetCurrent(var_29_6, var_29_3)
		elseif var_29_2 == "attr" then
			local var_29_7 = arg_29_0._caster

			return var_7.GetAttrByName(var_29_7, var_29_3)
		end
	end

	return
end

function var_0_4.equipIndexRequire(arg_30_0, arg_30_1)
	if not arg_30_0._indexRequire then
		return true
	else
		ipairs = var_2

		for iter_30_0, iter_30_1 in var_2(arg_30_0._indexRequire) do
			if iter_30_1 == arg_30_1 then
				return true
			end
		end

		return false
	end

	return
end

function var_0_4.ammoRequire(arg_31_0, arg_31_1)
	if not arg_31_0._ammoTypeRequire then
		return true
	elseif not arg_31_1:GetWeaponByIndex(arg_31_0._ammoIndexRequire) or var_2:GetPrimalAmmoType() ~= arg_31_0._ammoTypeRequire then
		return false
	else
		return true
	end

	return
end

function var_0_4.bulletTagRequire(arg_32_0, arg_32_1)
	if not arg_32_0._bulletTagRequire then
		return true
	else
		ipairs = var_2

		for iter_32_0, iter_32_1 in var_2(arg_32_0._bulletTagRequire) do
			table = var_1_10007

			if var_1_10007.contains(arg_32_1, iter_32_1) then
				return true
			else
				return false
			end
		end
	end

	return
end

function var_0_4.buffStateRequire(arg_33_0, arg_33_1)
	if not arg_33_0._buffStateIDRequire then
		return true
	else
		return arg_33_1 == arg_33_0._buffStateIDRequire
	end

	return
end

function var_0_4.onWeaponSteday(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:onFire(arg_34_1, arg_34_2, arg_34_3)

	return
end

function var_0_4.onChargeWeaponFire(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0:onFire(arg_35_1, arg_35_2, arg_35_3)

	return
end

function var_0_4.onTorpedoWeaponFire(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0:onFire(arg_36_1, arg_36_2, arg_36_3)

	return
end

function var_0_4.onAntiAirWeaponFireFar(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0:onFire(arg_37_1, arg_37_2, arg_37_3)

	return
end

function var_0_4.onAntiAirWeaponFireNear(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0:onFire(arg_38_1, arg_38_2, arg_38_3)

	return
end

function var_0_4.onManualMissileFire(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0:onFire(arg_39_1, arg_39_2, arg_39_3)

	return
end

function var_0_4.onAllInStrike(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_0:onFire(arg_40_1, arg_40_2, arg_40_3)

	return
end

function var_0_4.onAllInStrikeSteady(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	arg_41_0:onFire(arg_41_1, arg_41_2, arg_41_3)

	return
end

function var_0_4.onPointStrikeReady(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0:onFire(arg_42_1, arg_42_2, arg_42_3)

	return
end

function var_0_4.onPointStrikeSteady(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0:onFire(arg_43_1, arg_43_2, arg_43_3)

	return
end

function var_0_4.onPointStrike(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0:onFire(arg_44_1, arg_44_2, arg_44_3)

	return
end

function var_0_4.onWeaonInterrupt(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0:onTrigger(arg_45_1, arg_45_2)

	return
end

function var_0_4.onWeaponSuccess(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	arg_46_0:onTrigger(arg_46_1, arg_46_2)

	return
end

function var_0_4.onChargeWeaponReady(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0:onTrigger(arg_47_1, arg_47_2)

	return
end

function var_0_4.onManualTorpedoReady(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_0:onTrigger(arg_48_1, arg_48_2)

	return
end

function var_0_4.onAirAssistReady(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	arg_49_0:onTrigger(arg_49_1, arg_49_2)

	return
end

function var_0_4.onManualMissileReady(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	arg_50_0:onTrigger(arg_50_1, arg_50_2)

	return
end

function var_0_4.onTorpedoButtonPush(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	arg_51_0:onTrigger(arg_51_1, arg_51_2)

	return
end

function var_0_4.onBeforeFatalDamage(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0:onTrigger(arg_52_1, arg_52_2)

	return
end

function var_0_4.onAircraftCreate(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	arg_53_0:onTrigger(arg_53_1, arg_53_2, arg_53_3)

	return
end

function var_0_4.onFriendlyAircraftDying(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_0._tempData.arg_list.templateID then
		local var_54_0 = arg_54_3.unit

		if var_4.GetTemplateID(var_54_0) == arg_54_0._tempData.arg_list.templateID then
			arg_54_0:onTrigger(arg_54_1, arg_54_2)
		end
	else
		arg_54_0:onTrigger(arg_54_1, arg_54_2)
	end

	return
end

function var_0_4.onTeammateShipDying(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0:onTrigger(arg_55_1, arg_55_2)

	return
end

function var_0_4.onFoeAircraftDying(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if arg_56_0._tempData.arg_list.inside then
		local var_56_0 = arg_56_3.unit
		local var_56_1 = arg_56_1:GetFleetVO()
		local var_56_2 = var_5.GetFleetAntiAirWeapon(var_56_1)

		if not var_5.IsOutOfRange(var_56_2, var_56_0) then
			arg_56_0:onTrigger(arg_56_1, arg_56_2)
		end
	elseif arg_56_0._tempData.arg_list.killer then
		if arg_56_0:killerRequire(arg_56_0._tempData.arg_list.killer, arg_56_3.killer, arg_56_1) then
			arg_56_0:onTrigger(arg_56_1, arg_56_2)
		end
	else
		arg_56_0:onTrigger(arg_56_1, arg_56_2)
	end

	return
end

function var_0_4.onFoeDying(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	if arg_57_0._tempData.arg_list.killer then
		if arg_57_0:killerRequire(arg_57_0._tempData.arg_list.killer, arg_57_3.killer, arg_57_1) then
			arg_57_0:onTrigger(arg_57_1, arg_57_2)
		end
	elseif arg_57_0:victimRequire(arg_57_3.unit, arg_57_1) then
		arg_57_0:onTrigger(arg_57_1, arg_57_2)
	else
		arg_57_0:onTrigger(arg_57_1, arg_57_2)
	end

	return
end

function var_0_4.onSink(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_0:deathCauseRequire(arg_58_1) then
		arg_58_0:onTrigger(arg_58_1, arg_58_2)
	end

	return
end

function var_0_4.deathCauseRequire(arg_59_0, arg_59_1)
	if not arg_59_0._deathCauseRequire then
		return true
	end

	local var_59_0 = arg_59_1
	local var_59_1 = arg_59_1.GetDeathReason(var_59_0)

	table = var_59_0

	return var_59_0.contains(arg_59_0._deathCauseRequire, var_59_1)
end

function var_0_4.killerRequire(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_2 then
		return false
	end

	local var_60_0
	local var_60_1

	if arg_60_2.__name == var_0.Battle.BattlePlayerUnit.__name or var_6 == var_0.Battle.BattleNPCUnit.__name or var_6 == var_0.Battle.BattleMinionUnit.__name or var_6 == var_0.Battle.BattleEnemyUnit.__name or var_6 == var_0.Battle.BattleAircraftUnit.__name or var_6 == var_0.Battle.BattleAirFighterUnit.__name then
		var_60_0 = arg_60_2
	else
		var_60_0 = arg_60_2:GetHost()
	end

	if var_60_0 then
		if var_60_0.__name == var_0.Battle.BattleAircraftUnit.__name then
			var_60_1 = var_60_0:GetMotherUnit()
		elseif var_7 == var_0.Battle.BattleMinionUnit.__name then
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

function var_0_4.victimRequire(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_0._victimTagRequire then
		return true
	elseif arg_61_1:ContainsLabelTag(arg_61_0._victimTagRequire) then
		return true
	else
		return false
	end

	return
end

function var_0_4.killerWeaponRequire(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	if not arg_62_2 then
		return false
	end

	if not arg_62_2.GetWeapon then
		return false
	end

	local var_62_0 = arg_62_2:GetWeapon()
	local var_62_1 = var_4.GetWeaponId(var_62_0)

	table = var_62_0

	if var_62_0.contains(arg_62_1, var_62_1) then
		return true
	end

	return
end

function var_0_4.DamageSourceRequire(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0._damageSrcTagRequire then
		return true
	else
		if not arg_63_1 then
			return false
		end

		local var_63_0 = var_0.Battle.BattleDataProxy.GetInstance()

		if not var_3.GetUnitList(var_63_0)[arg_63_1] then
			return false
		end

		if var_4:ContainsLabelTag(arg_63_0._damageSrcTagRequire) then
			return true
		else
			return false
		end
	end

	return
end

function var_0_4.onInitGame(arg_64_0, arg_64_1, arg_64_2)
	arg_64_0:onTrigger(arg_64_1, arg_64_2)

	return
end

function var_0_4.onStartGame(arg_65_0, arg_65_1, arg_65_2)
	arg_65_0:onTrigger(arg_65_1, arg_65_2)

	return
end

function var_0_4.onFinishGame(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0:onTrigger(arg_66_1, arg_66_2)

	return
end

function var_0_4.onManual(arg_67_0, arg_67_1, arg_67_2)
	arg_67_0:onTrigger(arg_67_1, arg_67_2)

	return
end

function var_0_4.onAutoBot(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0:onTrigger(arg_68_1, arg_68_2)

	return
end

function var_0_4.onFlagShip(arg_69_0, arg_69_1, arg_69_2)
	arg_69_0:onTrigger(arg_69_1, arg_69_2)

	return
end

function var_0_4.onDALCollabFlagShip(arg_70_0, arg_70_1, arg_70_2)
	arg_70_0:onTrigger(arg_70_1, arg_70_2)

	return
end

function var_0_4.onUpperConsort(arg_71_0, arg_71_1, arg_71_2)
	arg_71_0:onTrigger(arg_71_1, arg_71_2)

	return
end

function var_0_4.onLowerConsort(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0:onTrigger(arg_72_1, arg_72_2)

	return
end

function var_0_4.onLeader(arg_73_0, arg_73_1, arg_73_2)
	arg_73_0:onTrigger(arg_73_1, arg_73_2)

	return
end

function var_0_4.onCenter(arg_74_0, arg_74_1, arg_74_2)
	arg_74_0:onTrigger(arg_74_1, arg_74_2)

	return
end

function var_0_4.onRear(arg_75_0, arg_75_1, arg_75_2)
	arg_75_0:onTrigger(arg_75_1, arg_75_2)

	return
end

function var_0_4.onSubLeader(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0:onTrigger(arg_76_1, arg_76_2)

	return
end

function var_0_4.onUpperSubConsort(arg_77_0, arg_77_1, arg_77_2)
	arg_77_0:onTrigger(arg_77_1, arg_77_2)

	return
end

function var_0_4.onLowerSubConsort(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0:onTrigger(arg_78_1, arg_78_2)

	return
end

function var_0_4.onBulletCollide(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	if not arg_79_0:equipIndexRequire(arg_79_3.equipIndex) then
		return
	end

	arg_79_0:onTrigger(arg_79_1, arg_79_2)

	return
end

function var_0_4.onBulletCollideBefore(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	if not arg_80_0:equipIndexRequire(arg_80_3.equipIndex) then
		return
	end

	arg_80_0:onTrigger(arg_80_1, arg_80_2)

	return
end

function var_0_4.onBombBulletBang(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	if not arg_81_0:equipIndexRequire(arg_81_3.equipIndex) then
		return
	end

	arg_81_0:onTrigger(arg_81_1, arg_81_2)

	return
end

function var_0_4.onTorpedoBulletBang(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	if not arg_82_0:equipIndexRequire(arg_82_3.equipIndex) then
		return
	end

	arg_82_0:onTrigger(arg_82_1, arg_82_2)

	return
end

function var_0_4.onBulletHitBefore(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	if arg_83_0._behit then
		if arg_83_0._behit.damage_type == arg_83_3.weaponType and arg_83_0._behit.bullet_type == arg_83_3.bulletType then
			arg_83_0:onTrigger(arg_83_1, arg_83_2)
		end
	else
		arg_83_0:onTrigger(arg_83_1, arg_83_2)
	end

	return
end

function var_0_4.onBulletCreate(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	if not arg_84_0:equipIndexRequire(arg_84_3.equipIndex) then
		return
	end

	arg_84_0:onTrigger(arg_84_1, arg_84_2, arg_84_3)

	return
end

function var_0_4.onChargeWeaponBulletCreate(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	arg_85_0:onBulletCreate(arg_85_1, arg_85_2, arg_85_3)

	return
end

function var_0_4.onTorpedoWeaponBulletCreate(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	arg_86_0:onBulletCreate(arg_86_1, arg_86_2, arg_86_3)

	return
end

function var_0_4.onInternalBulletCreate(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
	if not arg_87_0:equipIndexRequire(arg_87_3.equipIndex) then
		return
	end

	arg_87_0:onTrigger(arg_87_1, arg_87_2, arg_87_3)

	return
end

function var_0_4.onManualBulletCreate(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	if not arg_88_0:equipIndexRequire(arg_88_3.equipIndex) then
		return
	end

	arg_88_0:onTrigger(arg_88_1, arg_88_2, arg_88_3)

	return
end

function var_0_4.onBeforeTakeDamage(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	if arg_89_0:damageCheck(arg_89_3) then
		arg_89_0:onTrigger(arg_89_1, arg_89_2, arg_89_3)
	end

	return
end

function var_0_4.onTakeDamage(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	if arg_90_0:damageCheck(arg_90_3) then
		arg_90_0:onTrigger(arg_90_1, arg_90_2, arg_90_3)
	end

	return
end

function var_0_4.onTakeHealing(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	arg_91_0:onTrigger(arg_91_1, arg_91_2, arg_91_3)

	return
end

function var_0_4.onShieldAbsorb(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
	arg_92_0:onTrigger(arg_92_1, arg_92_2, arg_92_3)

	return
end

function var_0_4.onDamageFix(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	arg_93_0:onTrigger(arg_93_1, arg_93_2, arg_93_3)

	return
end

function var_0_4.onDamageConclude(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	arg_94_0:onTrigger(arg_94_1, arg_94_2, arg_94_3)

	return
end

function var_0_4.onOverHealing(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	arg_95_0:onTrigger(arg_95_1, arg_95_2, arg_95_3)

	return
end

function var_0_4.onFleetAttrUpdate(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	arg_96_0:onTrigger(arg_96_1, arg_96_2, arg_96_3)

	return
end

function var_0_4.damageCheck(arg_97_0, arg_97_1)
	local var_97_0

	if arg_97_0:damageAttrRequire(arg_97_1.damageAttr) then
		var_97_0 = arg_97_0:damageReasonRequire(arg_97_1.damageReason)
	end

	return var_97_0
end

function var_0_4.damageAttrRequire(arg_98_0, arg_98_1)
	if arg_98_0._damageAttrRequire then
		table = var_2

		if var_2.contains(arg_98_0._damageAttrRequire, arg_98_1) then
			return true
		else
			return false
		end

		return
	end
end

function var_0_4.damageReasonRequire(arg_99_0, arg_99_1)
	if arg_99_0._damageReasonRequire then
		table = var_2

		if var_2.contains(arg_99_0._damageReasonRequire, arg_99_1) then
			return true
		else
			return false
		end

		return
	end
end

function var_0_4.hpIntervalRequire(arg_100_0, arg_100_1, arg_100_2)
	if arg_100_0._hpUpperBound == nil and arg_100_0._hpLowerBound == nil then
		return true
	end

	if not arg_100_2 or arg_100_0._hpSigned == 0 then
		-- block empty
	elseif arg_100_2 * arg_100_0._hpSigned < 0 then
		return false
	end

	local var_100_0

	if arg_100_0._hpOutInterval then
		if arg_100_1 >= arg_100_0._hpUpperBound or arg_100_1 <= arg_100_0._hpLowerBound then
			var_100_0 = true
		end
	elseif arg_100_1 <= arg_100_0._hpUpperBound and arg_100_1 >= arg_100_0._hpLowerBound then
		var_100_0 = true
	end

	return var_100_0
end

function var_0_4.dhpRequire(arg_101_0, arg_101_1, arg_101_2)
	if arg_101_0._dHPGreater then
		if arg_101_2 * arg_101_0._dHPGreater > 0 then
			math = var_3

			local var_101_0 = var_3.abs(arg_101_2)

			math = var_4

			local var_101_1

			if not (var_101_0 > var_4.abs(arg_101_0._dHPGreater)) then
				var_101_1 = false
			else
				var_101_1 = true
			end

			do return var_101_1 end

			goto label_101_0

			if arg_101_0._dHPGreaterMaxHP then
				if arg_101_2 * (arg_101_0._dHPGreaterMaxHP * arg_101_1) > 0 then
					math = var_4

					local var_101_2 = var_4.abs(arg_101_2)

					math = var_5

					local var_101_3

					if not (var_101_2 > var_5.abs(var_3)) then
						var_101_3 = false
					else
						var_101_3 = true
					end

					do return var_101_3 end

					goto label_101_0

					if arg_101_0._dhpSmaller then
						if arg_101_2 * arg_101_0._dhpSmaller > 0 then
							math = var_3

							local var_101_4 = var_3.abs(arg_101_2)

							math = var_4

							local var_101_5

							if not (var_101_4 < var_4.abs(arg_101_0._dhpSmaller)) then
								var_101_5 = false
							else
								var_101_5 = true
							end

							do return var_101_5 end

							goto label_101_0

							if arg_101_0._dhpSmallerMaxhp then
								if arg_101_2 * (arg_101_0._dhpSmallerMaxhp * arg_101_1) > 0 then
									math = var_4

									do
										local var_101_6 = var_4.abs(arg_101_2)

										math = var_5

										local var_101_7

										if not (var_101_6 < var_5.abs(var_3)) then
											var_101_7 = false
										else
											var_101_7 = true
										end

										do return var_101_7 end

										if false then
											return true
										end
									end

									::label_101_0::

									return
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_4.attrIntervalRequire(arg_102_0, arg_102_1)
	local var_102_0 = true

	if arg_102_0._attrUpperBound and arg_102_1 >= arg_102_0._attrUpperBound then
		var_102_0 = false
	end

	if arg_102_0._attrLowerBound and arg_102_1 <= arg_102_0._attrLowerBound then
		var_102_0 = false
	end

	return var_102_0
end

function var_0_4.onHPRatioUpdate(arg_103_0, arg_103_1, arg_103_2, arg_103_3)
	local var_103_0 = arg_103_1:GetHPRate()
	local var_103_1 = arg_103_3.dHP

	if arg_103_0:hpIntervalRequire(var_103_0, var_103_1) and arg_103_0:dhpRequire(arg_103_1:GetMaxHP(), var_103_1) then
		arg_103_0:doOnHPRatioUpdate(arg_103_1, arg_103_2, arg_103_3)
	end

	return
end

function var_0_4.onFriendlyHpRatioUpdate(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	local var_104_0 = arg_104_3.unit
	local var_104_1 = arg_104_3.dHP
	local var_104_2 = var_104_0:GetHPRate()

	if arg_104_0:hpIntervalRequire(var_104_2, var_104_1) and arg_104_0:dhpRequire(var_104_0:GetMaxHP(), var_104_1) then
		arg_104_0:doOnHPRatioUpdate(arg_104_1, arg_104_2, arg_104_3)
	end

	return
end

function var_0_4.onTeammateHpRatioUpdate(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	arg_105_0:onFriendlyHpRatioUpdate(arg_105_1, arg_105_2, arg_105_3)

	return
end

function var_0_4.onBulletKill(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	if arg_106_0._tempData.arg_list.killer_weapon_id then
		if arg_106_0:killerWeaponRequire(arg_106_0._tempData.arg_list.killer_weapon_id, arg_106_3.killer, arg_106_1) then
			arg_106_0:onTrigger(arg_106_1, arg_106_2)
		end
	else
		arg_106_0:onTrigger(arg_106_1, arg_106_2)
	end

	return
end

function var_0_4.onBattleBuffCount(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	local var_107_0 = arg_107_3.buffFX

	if var_4.GetCountType(var_107_0) == arg_107_0._countType then
		if var_4:Repeater() then
			while var_4:GetCountProgress() >= 1 do
				arg_107_0:onTrigger(arg_107_1, arg_107_2)
				var_4:ConsumeCount()
			end
		elseif arg_107_0:onTrigger(arg_107_1, arg_107_2) ~= "overheat" then
			var_4:ResetCount()
		end
	end

	return
end

function var_0_4.onShieldBroken(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
	if arg_108_3.shieldBuffID == arg_108_0._tempData.arg_list.shieldBuffID then
		arg_108_0:onTrigger(arg_108_1, arg_108_2)
	end

	return
end

function var_0_4.onTrigger(arg_109_0, arg_109_1, arg_109_2, arg_109_3)
	if arg_109_0._quota > 0 then
		arg_109_0._quota = arg_109_0._quota - 1
	end

	return
end

function var_0_4.doOnHPRatioUpdate(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	arg_110_0:onTrigger(arg_110_1, arg_110_2, arg_110_3)

	return
end

function var_0_4.doOnFriendlyHPRatioUpdate(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	arg_111_0:onTrigger(arg_111_1, arg_111_2, arg_111_3)

	return
end

function var_0_4.onSubmarineDive(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
	arg_112_0:onTrigger(arg_112_1, arg_112_2, arg_112_3)

	return
end

function var_0_4.onSubmarineRaid(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	arg_113_0:onTrigger(arg_113_1, arg_113_2, arg_113_3)

	return
end

function var_0_4.onSubmarineFloat(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	arg_114_0:onTrigger(arg_114_1, arg_114_2, arg_114_3)

	return
end

function var_0_4.onSubmarineRetreat(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	arg_115_0:onTrigger(arg_115_1, arg_115_2, arg_115_3)

	return
end

function var_0_4.onSubmarineAid(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	arg_116_0:onTrigger(arg_116_1, arg_116_2, arg_116_3)

	return
end

function var_0_4.onSubmarinFreeDive(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	arg_117_0:onTrigger(arg_117_1, arg_117_2, arg_117_3)

	return
end

function var_0_4.onSubmarinFreeFloat(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
	arg_118_0:onTrigger(arg_118_1, arg_118_2, arg_118_3)

	return
end

function var_0_4.onSubmarineFreeSpecial(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	arg_119_0:onTrigger(arg_119_1, arg_119_2, arg_119_3)

	return
end

function var_0_4.onSubDetected(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	arg_120_0:onTrigger(arg_120_1, arg_120_2, arg_120_3)

	return
end

function var_0_4.onSubUnDetected(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	arg_121_0:onTrigger(arg_121_1, arg_121_2, arg_121_3)

	return
end

function var_0_4.onAntiSubHateChain(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
	local var_122_0 = arg_122_0
	local var_122_1 = arg_122_0.onTrigger
	local var_122_2 = arg_122_1
	local var_122_3 = arg_122_2

	attach = var_1_10008

	var_122_1(var_122_0, var_122_2, var_122_3, var_1_10008)

	return
end

function var_0_4.onRetreat(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	arg_123_0:onTrigger(arg_123_1, arg_123_2, arg_123_3)

	return
end

function var_0_4.onCloakUpdate(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	if arg_124_0:cloakStateRequire(arg_124_3.cloakState) then
		arg_124_0:onTrigger(arg_124_1, arg_124_2, arg_124_3)
	end

	return
end

function var_0_4.onTeammateCloakUpdate(arg_125_0, arg_125_1, arg_125_2, arg_125_3)
	if arg_125_0:cloakStateRequire(arg_125_3.cloakState) then
		arg_125_0:onTrigger(arg_125_1, arg_125_2, arg_125_3)
	end

	return
end

function var_0_4.cloakStateRequire(arg_126_0, arg_126_1)
	if not arg_126_0._cloakRequire then
		return true
	else
		return arg_126_0._cloakRequire == arg_126_1
	end

	return
end

function var_0_4.Interrupt(arg_127_0)
	return
end

function var_0_4.Clear(arg_128_0)
	arg_128_0._commander = nil

	return
end

function var_0_4.getTargetList(arg_129_0, arg_129_1, arg_129_2, arg_129_3, arg_129_4)
	type = var_1_10005

	if var_1_10005(arg_129_2) == "string" then
		arg_129_2 = {
			arg_129_2
		}
	end

	local var_129_0 = arg_129_3

	table = var_6

	if var_6.contains(arg_129_2, "TargetDamageSource") then
		Clone = var_6
		var_129_0 = var_6(arg_129_3)
		var_129_0.damageSourceID = arg_129_4.damageSrc
	end

	local var_129_1

	ipairs = var_7

	for iter_129_0, iter_129_1 in var_7(arg_129_2) do
		var_129_1 = var_0.Battle.BattleTargetChoise[iter_129_1](arg_129_1, var_129_0, var_129_1)
	end

	return var_129_1
end

function var_0_4.commanderRequire(arg_130_0, arg_130_1)
	if arg_130_0._tempData.arg_list.CMDBuff_id then
		local var_130_0 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_130_1, var_130_2 = var_2.GetCommanderBuff(var_130_0)
		local var_130_3
		local var_130_4 = arg_130_1
		local var_130_5 = arg_130_1.GetTemplate(var_130_4).type

		table = var_130_4

		local var_130_6 = var_130_4.contains

		ShipType = var_1_10007

		if var_130_6(var_1_10007.SubShipType, var_130_5) then
			var_130_3 = var_130_2
		else
			var_130_3 = var_130_1
		end

		local var_130_7 = {}
		local var_130_8 = arg_130_0._tempData.arg_list.CMDBuff_id

		ipairs = var_8

		for iter_130_0, iter_130_1 in var_8(var_130_3) do
			if iter_130_1.id == var_130_8 then
				table = var_13

				var_13.insert(var_130_7, iter_130_1)
			end
		end

		return #var_130_7 > 0
	else
		return true
	end

	return
end

function var_0_4.IsActive(arg_131_0)
	return arg_131_0._isActive
end

function var_0_4.SetActive(arg_132_0)
	arg_132_0._isActive = true

	return
end

function var_0_4.NotActive(arg_133_0)
	arg_133_0._isActive = false

	return
end

function var_0_4.IsLock(arg_134_0)
	return arg_134_0._isLock
end

function var_0_4.SetLock(arg_135_0)
	arg_135_0._isLock = true

	return
end

function var_0_4.NotLock(arg_136_0)
	arg_136_0._isLock = false

	return
end

function var_0_4.Dispose(arg_137_0)
	return
end

return
