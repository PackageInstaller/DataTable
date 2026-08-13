ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleBuffEvent
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleVariable
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleAttr
local var_0_7 = var_0.Battle.BattleDataFunction
local var_0_8 = var_0.Battle.UnitState

class = var_0_10009

local var_0_9 = var_0_10009("BattleUnit")

var_0.Battle.BattleUnit = var_0_9
var_0_9.__name = "BattleUnit"

function var_0_9.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._uniqueID = arg_1_1
	arg_1_0._speedExemptKey = "unit_" .. arg_1_1
	arg_1_0._unitState = var_0.Battle.UnitState.New(arg_1_0)
	arg_1_0._move = var_0.Battle.MoveComponent.New()
	arg_1_0._weaponQueue = var_0.Battle.WeaponQueue.New()

	arg_1_0:Init()
	arg_1_0:SetIFF(arg_1_2)

	arg_1_0._distanceBackup = {}
	arg_1_0._battleProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_1_0._frame = 0

	return
end

function var_0_9.Retreat(arg_2_0)
	arg_2_0:TriggerBuff(var_0_3.BuffEffectType.ON_RETREAT, {})

	return
end

function var_0_9.SetMotion(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._move

	var_2.SetMotionVO(var_3_0, arg_3_1)

	return
end

function var_0_9.SetBound(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = arg_4_0._move

	var_7.SetCorpsArea(var_4_0, arg_4_5, arg_4_6)

	local var_4_1 = arg_4_0._move

	var_7.SetBorder(var_4_1, arg_4_3, arg_4_4, arg_4_1, arg_4_2)

	return
end

function var_0_9.ActiveCldBox(arg_5_0)
	local var_5_0 = arg_5_0._cldComponent

	var_1.SetActive(var_5_0, true)

	return
end

function var_0_9.DeactiveCldBox(arg_6_0)
	local var_6_0 = arg_6_0._cldComponent

	var_1.SetActive(var_6_0, false)

	return
end

function var_0_9.SetCldBoxImmune(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._cldComponent

	var_2.SetImmuneCLD(var_7_0, arg_7_1)

	return
end

function var_0_9.Init(arg_8_0)
	arg_8_0._hostileCldList = {}
	arg_8_0._currentHPRate = 1
	arg_8_0._currentDMGRate = 0
	arg_8_0._tagCount = 0
	arg_8_0._tagIndex = 0
	arg_8_0._tagList = {}
	arg_8_0._aliveState = true
	arg_8_0._isMainFleetUnit = false
	arg_8_0._bulletCache = {}
	Vector3 = var_1
	arg_8_0._speed = var_1.zero
	arg_8_0._dir = var_0_3.UnitDir.RIGHT
	arg_8_0._extraInfo = {}
	arg_8_0._GCDTimerList = {}
	arg_8_0._buffList = {}
	arg_8_0._buffStockList = {}
	arg_8_0._labelTagList = {}
	arg_8_0._exposedToSnoar = false
	arg_8_0._moveCast = true
	arg_8_0._remoteBoundBone = {}

	return
end

function var_0_9.Update(arg_9_0, arg_9_1)
	if arg_9_0:IsAlive() and not arg_9_0._isSickness then
		local var_9_0 = arg_9_0._move

		var_2.Update(var_9_0)

		local var_9_1 = arg_9_0._move

		var_2.FixSpeed(var_9_1, arg_9_0._cldComponent)

		local var_9_2 = arg_9_0._move

		var_2.Move(var_9_2, arg_9_0:GetSpeedRatio())
	end

	arg_9_0:UpdateAction()

	return
end

function var_0_9.UpdateWeapon(arg_10_0, arg_10_1)
	if not arg_10_0:IsAlive() or arg_10_0._isSickness then
		return
	end

	if arg_10_0._antiSubVigilanceState then
		local var_10_0 = arg_10_0._antiSubVigilanceState

		if var_2.IsWeaponUseable(var_10_0) then
			local var_10_1 = arg_10_0._move
			local var_10_2 = var_2.GetPos(var_10_1)
			local var_10_3 = arg_10_0._weaponRightBound
			local var_10_4 = arg_10_0._weaponLowerBound

			if (var_10_3 == nil or var_10_3 > var_10_2.x) and (var_10_4 == nil or var_10_4 < var_10_2.z) then
				local var_10_5 = arg_10_0._weaponQueue

				var_5.Update(var_10_5, arg_10_1)
			end
		end

		if not arg_10_0:IsAlive() then
			return
		end

		arg_10_0:UpdateBuff(arg_10_1)

		return
	end
end

function var_0_9.UpdateAirAssist(arg_11_0)
	if arg_11_0._airAssistList then
		ipairs = var_1

		for iter_11_0, iter_11_1 in var_1(arg_11_0._airAssistList) do
			iter_11_1:Update()
		end
	end

	return
end

function var_0_9.UpdatePhaseSwitcher(arg_12_0)
	if arg_12_0._phaseSwitcher then
		local var_12_0 = arg_12_0._phaseSwitcher

		var_1.Update(var_12_0)
	end

	return
end

function var_0_9.SetInterruptSickness(arg_13_0, arg_13_1)
	arg_13_0._isSickness = arg_13_1

	return
end

function var_0_9.SummonSickness(arg_14_0, arg_14_1)
	if arg_14_0._isSickness == true then
		return
	end

	local function var_14_0()
		local var_15_0 = arg_14_0

		var_0.RemoveSummonSickness(var_15_0)

		return
	end

	arg_14_0._isSickness = true
	pg = var_3

	local var_14_1 = var_3.TimeMgr.GetInstance()

	arg_14_0._sicknessTimer = var_3.AddBattleTimer(var_14_1, "summonSickness", 0, arg_14_1, var_14_0, true)

	return
end

function var_0_9.RemoveSummonSickness(arg_16_0)
	arg_16_0._isSickness = false
	pg = var_1

	local var_16_0 = var_1.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_16_0, arg_16_0._sicknessTimer)

	arg_16_0._sicknessTimer = nil

	return
end

function var_0_9.GetTargetedPriority(arg_17_0)
	local var_17_0

	if arg_17_0._aimBias then
		local var_17_1 = arg_17_0._aimBias

		if var_2.GetCurrentState(var_17_1) == arg_17_0._aimBias.STATE_SKILL_EXPOSE or var_2 == arg_17_0._aimBias.STATE_TOTAL_EXPOSE then
			var_17_0 = arg_17_0:GetTemplate().battle_unit_type
		else
			var_17_0 = -200
		end
	else
		var_17_0 = arg_17_0:GetTemplate().battle_unit_type
	end

	return var_17_0
end

function var_0_9.PlayFX(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:DispatchEvent(var_0.Event.New(var_0_1.PLAY_FX, {
		fxName = arg_18_1,
		notAttach = not arg_18_2
	}))

	return
end

function var_0_9.SwitchShader(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0:DispatchEvent(var_0.Event.New(var_0_1.SWITCH_SHADER, {
		shader = arg_19_1,
		color = arg_19_2,
		args = arg_19_3
	}))

	return
end

function var_0_9.SendAttackTrigger(arg_20_0)
	arg_20_0:DispatchEvent(var_0.Event.New(var_0_1.SPAWN_CACHE_BULLET, {}))

	return
end

function var_0_9.HandleDamageToDeath(arg_21_0)
	local var_21_0 = {
		isMiss = false,
		isCri = true,
		isHeal = false,
		damageReason = var_0_3.UnitDeathReason.DESTRUCT
	}
	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.UpdateHP

	math = var_1_10004

	var_21_2(var_21_1, var_1_10004.floor(-arg_21_0._currentHP), var_21_0)

	return
end

function var_0_9.UpdateHP(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0:IsAlive() then
		return 0
	end

	local var_22_0 = arg_22_2.isMiss
	local var_22_1 = arg_22_2.isCri
	local var_22_2 = arg_22_2.isHeal
	local var_22_3 = arg_22_2.isShare
	local var_22_4 = arg_22_2.attr
	local var_22_5 = arg_22_2.damageReason
	local var_22_6 = arg_22_2.font
	local var_22_7 = arg_22_2.cldPos
	local var_22_8 = arg_22_2.incorrupt
	local var_22_9 = arg_22_2.isReflect
	local var_22_10 = arg_22_2.spectreBullet
	local var_22_11 = arg_22_2.ignoreInvincible
	local var_22_12 = arg_22_2.ignoreShield
	local var_22_13
	local var_22_14

	if not var_22_2 then
		var_22_14 = {
			damage = -arg_22_1,
			isShare = var_22_3,
			miss = var_22_0,
			cri = var_22_1,
			damageSrc = arg_22_2.srcID,
			damageAttr = var_22_4,
			damageReason = var_22_5,
			isReflect = var_22_9,
			ignoreShield = var_22_12
		}

		if not var_22_3 then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_TAKE_DAMAGE, var_22_14)

			if var_22_14.capFlag then
				arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_FIX, var_22_14)
			end
		end

		var_22_13 = -var_22_14.damage

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_DAMAGE, var_22_14)

		if arg_22_0._currentHP <= var_22_14.damage then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		if var_22_13 ~= -var_22_14.damage then
			var_1_10019 = {
				absorb = var_22_13 - arg_22_1
			}

			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_SHIELD_ABSORB, var_22_14)
		end

		if var_0_6.IsInvincible(arg_22_0) and not var_22_11 then
			return 0
		end
	else
		var_22_13 = arg_22_1
		var_1_10019 = {
			damage = arg_22_1,
			isHeal = var_22_2,
			incorrupt = var_22_8
		}

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_HEALING, var_1_10019)

		var_22_2 = var_1_10019.isHeal
		arg_22_1 = var_1_10019.damage
		math = var_20

		if var_20.max(0, arg_22_0._currentHP + arg_22_1 - arg_22_0:GetMaxHP()) > 0 then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_OVER_HEALING, {
				overHealing = var_20
			})
		end
	end

	math = var_1_10019

	local var_22_15 = var_1_10019.min
	local var_22_16 = arg_22_0
	local var_22_17 = arg_22_0.GetMaxHP(var_22_16)

	math = var_22_16

	local var_22_18 = var_22_15(var_22_17, var_22_16.max(0, arg_22_0._currentHP + arg_22_1)) - arg_22_0._currentHP

	arg_22_0:SetCurrentHP(var_19)

	local var_22_19 = {
		preShieldHP = var_22_13,
		dHP = arg_22_1,
		validDHP = var_22_18,
		isMiss = var_22_0,
		isCri = var_22_1,
		isHeal = var_22_2,
		font = var_22_6
	}

	if not var_22_2 then
		var_22_14.validDHP = var_22_18

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_CONCLUDE, var_22_14)
	end

	if var_22_7 and not var_22_7:EqualZero() then
		local var_22_20 = arg_22_0:GetPosition()
		local var_22_21 = arg_22_0:GetBoxSize().x
		local var_22_22 = var_22_20.x - var_22_21
		local var_22_23 = var_22_20.x + var_22_21
		local var_22_24 = var_22_7
		local var_22_25 = var_22_7.Clone(var_22_24)

		Mathf = var_22_24
		var_22_25.x = var_22_24.Clamp(var_22_25.x, var_22_22, var_22_23)
		var_22_19.posOffset = var_22_20 - var_22_25
	end

	if not var_22_10 then
		arg_22_0:UpdateHPAction(var_22_19)
	end

	if not arg_22_0:IsAlive() and var_3 then
		arg_22_0:SetDeathReason(arg_22_2.damageReason)
		arg_22_0:SetDeathSrcID(arg_22_2.srcID)
		arg_22_0:DeadAction()
	end

	if arg_22_0:IsAlive() then
		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_22_1,
			unit = arg_22_0,
			validDHP = var_22_18
		})
	end

	return arg_22_1
end

function var_0_9.UpdateHPAction(arg_23_0, arg_23_1)
	arg_23_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_HP, arg_23_1))

	return
end

function var_0_9.DeadAction(arg_24_0)
	arg_24_0:TriggerBuff(var_0_3.BuffEffectType.ON_SINK, {})
	arg_24_0:DeacActionClear()

	return
end

function var_0_9.DeacActionClear(arg_25_0)
	arg_25_0._aliveState = false

	var_0_6.Spirit(arg_25_0)
	var_0_6.AppendInvincible(arg_25_0)
	arg_25_0:DeadActionEvent()

	return
end

function var_0_9.DeadActionEvent(arg_26_0)
	arg_26_0:DispatchEvent(var_0.Event.New(var_0_1.WILL_DIE, {}))
	arg_26_0:DispatchEvent(var_0.Event.New(var_0_1.DYING, {}))

	return
end

function var_0_9.SendDeadEvent(arg_27_0)
	arg_27_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.DYING, {}))

	return
end

function var_0_9.SetDeathReason(arg_28_0, arg_28_1)
	arg_28_0._deathReason = arg_28_1

	return
end

function var_0_9.GetDeathReason(arg_29_0)
	local var_29_0

	if not arg_29_0._deathReason then
		var_29_0 = var_0_3.UnitDeathReason.KILLED
	end

	return var_29_0
end

function var_0_9.SetDeathSrcID(arg_30_0, arg_30_1)
	arg_30_0._deathSrcID = arg_30_1

	return
end

function var_0_9.GetDeathSrcID(arg_31_0)
	return arg_31_0._deathSrcID
end

function var_0_9.DispatchScorePoint(arg_32_0, arg_32_1)
	arg_32_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.UPDATE_SCORE, {
		score = arg_32_1
	}))

	return
end

function var_0_9.SetTemplate(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._tmpID = arg_33_1

	return
end

function var_0_9.GetTemplateID(arg_34_0)
	return arg_34_0._tmpID
end

function var_0_9.SetOverrideLevel(arg_35_0, arg_35_1)
	arg_35_0._overrideLevel = arg_35_1

	return
end

function var_0_9.SetSkinId(arg_36_0)
	return
end

function var_0_9.SetGearScore(arg_37_0, arg_37_1)
	arg_37_0._GS = arg_37_1

	return
end

function var_0_9.GetGearScore(arg_38_0)
	local var_38_0

	if not arg_38_0._GS then
		var_38_0 = 0
	end

	return var_38_0
end

function var_0_9.GetSkinID(arg_39_0)
	return arg_39_0._tmpID
end

function var_0_9.GetDefaultSkinID(arg_40_0)
	return arg_40_0._tmpID
end

function var_0_9.GetSkinAttachmentInfo(arg_41_0)
	return arg_41_0._orbitSkinIDList
end

function var_0_9.GetWeaponBoundBone(arg_42_0)
	return arg_42_0._tmpData.bound_bone
end

function var_0_9.ActionKeyOffsetUseable(arg_43_0)
	return true
end

function var_0_9.RemoveRemoteBoundBone(arg_44_0, arg_44_1)
	arg_44_0._remoteBoundBone[arg_44_1] = nil

	return
end

function var_0_9.SetRemoteBoundBone(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0

	if not arg_45_0._remoteBoundBone[arg_45_1] then
		var_45_0 = {}
	end

	var_45_0[arg_45_2] = arg_45_3
	arg_45_0._remoteBoundBone[arg_45_1] = var_45_0

	return
end

function var_0_9.GetRemoteBoundBone(arg_46_0, arg_46_1)
	pairs = var_1_10002

	for iter_46_0, iter_46_1 in var_1_10002(arg_46_0._remoteBoundBone) do
		if iter_46_1[arg_46_1] and var_0.Battle.BattleTargetChoise.TargetFleetIndex(arg_46_0, {
			fleetPos = var_7
		})[1] and var_8:IsAlive() then
			Clone = var_9

			local var_46_0 = var_9(var_8:GetPosition())

			var_9.Set(var_46_0, var_9.x, 1.5, var_9.z)

			return var_9
		end
	end

	return
end

function var_0_9.GetLabelTag(arg_47_0)
	return arg_47_0._labelTagList
end

function var_0_9.ContainsLabelTag(arg_48_0, arg_48_1)
	if arg_48_0._labelTagList == nil then
		return false
	end

	ipairs = var_2

	for iter_48_0, iter_48_1 in var_2(arg_48_1) do
		table = var_1_10007

		if var_1_10007.contains(arg_48_0._labelTagList, iter_48_1) then
			return true
		end
	end

	return false
end

function var_0_9.AddLabelTag(arg_49_0, arg_49_1)
	table = var_1_10002

	var_1_10002.insert(arg_49_0._labelTagList, arg_49_1)

	local var_49_0

	if not var_0_6.GetCurrent(arg_49_0, "labelTag")[arg_49_1] then
		var_49_0 = 0
	end

	var_2[arg_49_1] = var_49_0 + 1

	return
end

function var_0_9.RemoveLabelTag(arg_50_0, arg_50_1)
	ipairs = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10002(arg_50_0._labelTagList) do
		if iter_50_1 == arg_50_1 then
			table = var_1_10007

			var_1_10007.remove(arg_50_0._labelTagList, iter_50_0)

			var_1_10007[arg_50_1] = var_0_6.GetCurrent(arg_50_0, "labelTag")[arg_50_1] - 1

			break
		end
	end

	return
end

function var_0_9.setStandardLabelTag(arg_51_0)
	local var_51_0 = "N_" .. arg_51_0._tmpData.nationality
	local var_51_1 = "T_" .. arg_51_0._tmpData.type

	arg_51_0:AddLabelTag(var_51_0)
	arg_51_0:AddLabelTag(var_51_1)

	return
end

function var_0_9.GetRarity(arg_52_0)
	return
end

function var_0_9.GetIntimacy(arg_53_0)
	return 0
end

function var_0_9.IsBoss(arg_54_0)
	return false
end

function var_0_9.GetSpeedRatio(arg_55_0)
	return var_0_4.GetSpeedRatio(arg_55_0:GetSpeedExemptKey(), arg_55_0._IFF)
end

function var_0_9.GetSpeedExemptKey(arg_56_0)
	return arg_56_0._speedExemptKey
end

function var_0_9.SetMoveCast(arg_57_0, arg_57_1)
	arg_57_0._moveCast = arg_57_1

	return
end

function var_0_9.IsMoveCast(arg_58_0)
	return arg_58_0._moveCast
end

function var_0_9.SetCrash(arg_59_0, arg_59_1)
	arg_59_0._isCrash = arg_59_1

	if arg_59_1 then
		local var_59_0 = var_0.Battle.BattleBuffUnit.New(var_0_5.SHIP_CLD_BUFF)

		arg_59_0:AddBuff(var_59_0)
	else
		arg_59_0:RemoveBuff(var_0_5.SHIP_CLD_BUFF)
	end

	return
end

function var_0_9.IsCrash(arg_60_0)
	return arg_60_0._isCrash
end

function var_0_9.OverrideDeadFX(arg_61_0, arg_61_1)
	arg_61_0._deadFX = arg_61_1

	return
end

function var_0_9.GetDeadFX(arg_62_0)
	return arg_62_0._deadFX
end

function var_0_9.SetEquipment(arg_63_0, arg_63_1)
	arg_63_0._equipmentList = arg_63_1
	arg_63_0._autoWeaponList = {}
	arg_63_0._manualTorpedoList = {}
	arg_63_0._chargeList = {}
	arg_63_0._AAList = {}
	arg_63_0._fleetAAList = {}
	arg_63_0._fleetRangeAAList = {}
	arg_63_0._hiveList = {}
	arg_63_0._totalWeapon = {}

	arg_63_0:setWeapon(arg_63_1)

	return
end

function var_0_9.GetEquipment(arg_64_0)
	return arg_64_0._equipmentList
end

function var_0_9.SetProficiencyList(arg_65_0, arg_65_1)
	arg_65_0._proficiencyList = arg_65_1

	return
end

function var_0_9.SetSpWeapon(arg_66_0, arg_66_1)
	arg_66_0._spWeapon = arg_66_1

	return
end

function var_0_9.GetSpWeapon(arg_67_0)
	return arg_67_0._spWeapon
end

function var_0_9.setWeapon(arg_68_0, arg_68_1)
	ipairs = var_1_10002

	for iter_68_0, iter_68_1 in var_1_10002(arg_68_1) do
		local var_68_0 = iter_68_1.equipment.weapon_id

		ipairs = var_1_10008

		for iter_68_2, iter_68_3 in var_1_10008(var_68_0) do
			if iter_68_3 ~= -1 then
				local var_68_1 = var_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_68_3, arg_68_0, nil, iter_68_0)

				arg_68_0._totalWeapon[#arg_68_0._totalWeapon + 1] = var_68_1

				if var_68_1:GetTemplateData().type == var_0_3.EquipmentType.MANUAL_TORPEDO then
					arg_68_0._manualTorpedoList[#arg_68_0._manualTorpedoList + 1] = var_68_1

					local var_68_2 = arg_68_0._weaponQueue

					var_15.AppendWeapon(var_68_2, var_68_1)
				elseif var_14 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					-- block empty
				else
					assert = var_15

					var_15(#var_68_0 < 2, "自动武器一组不允许配置多个")
					arg_68_0:AddAutoWeapon(var_68_1)
				end

				if var_14 == var_0_3.EquipmentType.INTERCEPT_AIRCRAFT or var_14 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					arg_68_0._hiveList[#arg_68_0._hiveList + 1] = var_68_1
				end

				if var_14 == var_0_3.EquipmentType.ANTI_AIR then
					arg_68_0._AAList[#arg_68_0._AAList + 1] = var_68_1
				end
			end
		end
	end

	return
end

function var_0_9.CheckWeaponInitial(arg_69_0)
	local var_69_0 = arg_69_0._weaponQueue

	var_1.CheckWeaponInitalCD(var_69_0)

	if arg_69_0._airAssistQueue then
		local var_69_1 = arg_69_0._airAssistQueue

		var_1.CheckWeaponInitalCD(var_69_1)
	end

	arg_69_0:DispatchEvent(var_0.Event.New(var_0_1.INIT_COOL_DOWN, {}))

	return
end

function var_0_9.FlushReloadingWeapon(arg_70_0)
	local var_70_0 = arg_70_0._weaponQueue

	var_1.FlushWeaponReloadRequire(var_70_0)

	if arg_70_0._airAssistQueue then
		local var_70_1 = arg_70_0._airAssistQueue

		var_1.FlushWeaponReloadRequire(var_70_1)
	end

	return
end

function var_0_9.AddNewAutoWeapon(arg_71_0, arg_71_1)
	local var_71_0 = var_0_7.CreateWeaponUnit(arg_71_1, arg_71_0)

	arg_71_0:AddAutoWeapon(var_71_0)
	arg_71_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleBuffEvent.BUFF_EFFECT_NEW_WEAPON, {
		weapon = var_71_0
	}))

	return var_71_0
end

function var_0_9.AddAutoWeapon(arg_72_0, arg_72_1)
	arg_72_0._autoWeaponList[#arg_72_0._autoWeaponList + 1] = arg_72_1

	local var_72_0 = arg_72_0._weaponQueue

	var_2.AppendWeapon(var_72_0, arg_72_1)

	return
end

function var_0_9.RemoveAutoWeapon(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0._weaponQueue

	var_2.RemoveWeapon(var_73_0, arg_73_1)

	local var_73_1 = 1
	local var_73_2 = #arg_73_0._autoWeaponList

	while var_73_1 <= var_73_2 do
		if arg_73_0._autoWeaponList[var_73_1] == arg_73_1 then
			arg_73_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_WEAPON, {
				weapon = arg_73_1
			}))

			table = var_4

			var_4.remove(arg_73_0._autoWeaponList, var_73_1)

			break
		end

		var_73_1 = var_73_1 + 1
	end

	return
end

function var_0_9.RemoveAutoWeaponByWeaponID(arg_74_0, arg_74_1)
	ipairs = var_1_10002

	for iter_74_0, iter_74_1 in var_1_10002(arg_74_0._autoWeaponList) do
		if iter_74_1:GetWeaponId() == arg_74_1 then
			iter_74_1:Clear()
			arg_74_0:RemoveAutoWeapon(iter_74_1)

			break
		end
	end

	return
end

function var_0_9.RemoveAllAutoWeapon(arg_75_0)
	local var_75_0 = #arg_75_0._autoWeaponList

	while var_75_0 > 0 do
		local var_75_1 = arg_75_0._autoWeaponList[var_75_0]

		var_2.Clear(var_75_1)
		arg_75_0:RemoveAutoWeapon(var_2)

		var_75_0 = var_75_0 - 1
	end

	return
end

function var_0_9.AddFleetAntiAirWeapon(arg_76_0, arg_76_1)
	return
end

function var_0_9.RemoveFleetAntiAirWeapon(arg_77_0, arg_77_1)
	return
end

function var_0_9.AttachFleetRangeAAWeapon(arg_78_0, arg_78_1)
	arg_78_0._fleetRangeAA = arg_78_1

	arg_78_0:DispatchEvent(var_0.Event.New(var_0_1.CREATE_TEMPORARY_WEAPON, {
		weapon = arg_78_1
	}))

	return
end

function var_0_9.DetachFleetRangeAAWeapon(arg_79_0)
	arg_79_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_WEAPON, {
		weapon = arg_79_0._fleetRangeAA
	}))

	arg_79_0._fleetRangeAA = nil

	return
end

function var_0_9.GetFleetRangeAAWeapon(arg_80_0)
	return arg_80_0._fleetRangeAA
end

function var_0_9.ShiftWeapon(arg_81_0, arg_81_1, arg_81_2)
	ipairs = var_1_10003

	for iter_81_0, iter_81_1 in var_1_10003(arg_81_1) do
		arg_81_0:RemoveAutoWeaponByWeaponID(iter_81_1)
	end

	ipairs = var_3

	for iter_81_2, iter_81_3 in var_3(arg_81_2) do
		local var_81_0 = arg_81_0:AddNewAutoWeapon(iter_81_3)

		var_8.InitialCD(var_81_0)
	end

	return
end

function var_0_9.ExpandWeaponMount(arg_82_0, arg_82_1)
	if arg_82_1 == "airAssist" then
		var_0_7.ExpandAllinStrike(arg_82_0)
	end

	return
end

function var_0_9.ReduceWeaponMount(arg_83_0, arg_83_1)
	return
end

function var_0_9.CeaseAllWeapon(arg_84_0, arg_84_1)
	arg_84_0._ceaseFire = arg_84_1

	return
end

function var_0_9.IsCease(arg_85_0)
	return arg_85_0._ceaseFire
end

function var_0_9.GetAllWeapon(arg_86_0)
	return arg_86_0._totalWeapon
end

function var_0_9.GetTotalWeapon(arg_87_0)
	local var_87_0 = arg_87_0._weaponQueue

	return var_1.GetTotalWeaponUnit(var_87_0)
end

function var_0_9.GetAutoWeapons(arg_88_0)
	return arg_88_0._autoWeaponList
end

function var_0_9.GetChargeList(arg_89_0)
	return arg_89_0._chargeList
end

function var_0_9.GetChargeQueue(arg_90_0)
	local var_90_0 = arg_90_0._weaponQueue

	return var_1.GetChargeWeaponQueue(var_90_0)
end

function var_0_9.GetAntiAirWeapon(arg_91_0)
	return arg_91_0._AAList
end

function var_0_9.GetFleetAntiAirList(arg_92_0)
	return arg_92_0._fleetAAList
end

function var_0_9.GetFleetRangeAntiAirList(arg_93_0)
	return arg_93_0._fleetRangeAAList
end

function var_0_9.GetTorpedoList(arg_94_0)
	return arg_94_0._manualTorpedoList
end

function var_0_9.GetTorpedoQueue(arg_95_0)
	local var_95_0 = arg_95_0._weaponQueue

	return var_1.GetManualTorpedoQueue(var_95_0)
end

function var_0_9.GetWeaponByIndex(arg_96_0, arg_96_1)
	ipairs = var_1_10002

	for iter_96_0, iter_96_1 in var_1_10002(arg_96_0._totalWeapon) do
		if iter_96_1:GetEquipmentIndex() == arg_96_1 then
			return iter_96_1
		end
	end

	return
end

function var_0_9.GetHiveList(arg_97_0)
	return arg_97_0._hiveList
end

function var_0_9.SetAirAssistList(arg_98_0, arg_98_1)
	arg_98_0._airAssistList = arg_98_1
	arg_98_0._airAssistQueue = var_0.Battle.ManualWeaponQueue.New(arg_98_0:GetManualWeaponParallel()[var_0_3.ManualWeaponIndex.AIR_ASSIST])
	ipairs = var_2

	for iter_98_0, iter_98_1 in var_2(arg_98_0._airAssistList) do
		local var_98_0 = arg_98_0._airAssistQueue

		var_7.AppendWeapon(var_98_0, iter_98_1)
	end

	return
end

function var_0_9.GetAirAssistList(arg_99_0)
	return arg_99_0._airAssistList
end

function var_0_9.GetAirAssistQueue(arg_100_0)
	return arg_100_0._airAssistQueue
end

function var_0_9.GetManualWeaponParallel(arg_101_0)
	return {
		1,
		1,
		1
	}
end

function var_0_9.configWeaponQueueParallel(arg_102_0)
	local var_102_0 = arg_102_0:GetManualWeaponParallel()
	local var_102_1 = arg_102_0._weaponQueue

	var_2.ConfigParallel(var_102_1, var_102_0[var_0_3.ManualWeaponIndex.CALIBRATION], var_102_0[var_0_3.ManualWeaponIndex.TORPEDO])

	return
end

function var_0_9.ClearWeapon(arg_103_0)
	local var_103_0 = arg_103_0._weaponQueue

	var_1.ClearAllWeapon(var_103_0)

	if arg_103_0._airAssistList then
		ipairs = var_103_0

		for iter_103_0, iter_103_1 in var_103_0(var_1) do
			iter_103_1:Clear()
		end
	end

	return
end

function var_0_9.GetSpeed(arg_104_0)
	local var_104_0 = arg_104_0._move

	return var_1.GetSpeed(var_104_0)
end

function var_0_9.GetPosition(arg_105_0)
	local var_105_0 = arg_105_0._move

	return var_1.GetPos(var_105_0)
end

function var_0_9.GetBornPosition(arg_106_0)
	return arg_106_0._bornPos
end

function var_0_9.GetCLDZCenterPosition(arg_107_0)
	local var_107_0 = arg_107_0._battleProxy.FrameIndex

	if arg_107_0._zCenterFrame ~= var_107_0 then
		arg_107_0._zCenterFrame = var_107_0
		arg_107_0._cldZCenterCache = (arg_107_0:GetCldBox().min + var_2.max) * 0.5
	end

	return arg_107_0._cldZCenterCache
end

function var_0_9.GetBeenAimedPosition(arg_108_0)
	if not arg_108_0:GetCLDZCenterPosition() then
		return var_1
	end

	local var_108_0 = arg_108_0
	local var_108_1

	if arg_108_0.GetTemplate(var_108_0) then
		var_108_0 = arg_108_0
		var_108_1 = arg_108_0.GetTemplate(var_108_0).aim_offset
	end

	if not var_108_1 then
		return var_1
	end

	Vector3 = var_108_0

	local var_108_2 = var_108_0(var_1.x + var_108_1[1], var_1.y + var_108_1[2], var_1.z + var_108_1[3])

	arg_108_0:biasAimPosition(var_108_2)

	return var_108_2
end

function var_0_9.biasAimPosition(arg_109_0, arg_109_1)
	if var_0_6.GetCurrent(arg_109_0, "aimBias") > 0 then
		local var_109_0 = var_2 * 2

		math = var_4

		local var_109_1 = var_4.random() * var_109_0 - var_2

		math = var_1_10005

		local var_109_2 = var_1_10005.random() * var_109_0 - var_2

		arg_109_1:Set(arg_109_1.x + var_109_1, arg_109_1.y, arg_109_1.z + var_109_2)
	end

	return arg_109_1
end

function var_0_9.CancelFollowTeam(arg_110_0)
	local var_110_0 = arg_110_0._move

	var_1.CancelFormationCtrl(var_110_0)

	return
end

function var_0_9.UpdateFormationOffset(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0._move
	local var_111_1 = var_2.SetFormationCtrlInfo

	Vector3 = var_1_10004

	var_111_1(var_111_0, var_1_10004(arg_111_1.x, arg_111_1.y, arg_111_1.z))

	return
end

function var_0_9.GetDistance(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0._battleProxy.FrameIndex

	if arg_112_0._frame ~= var_112_0 then
		arg_112_0._distanceBackup = {}
		arg_112_0._frame = var_112_0
	end

	local var_112_1

	if arg_112_0._distanceBackup[arg_112_1] == nil then
		Vector3 = var_1_10004
		var_112_1 = var_1_10004.Distance(arg_112_0:GetPosition(), arg_112_1:GetPosition())
		arg_112_0._distanceBackup[arg_112_1] = var_112_1

		arg_112_1:backupDistance(arg_112_0, var_112_1)
	end

	return var_112_1
end

function var_0_9.backupDistance(arg_113_0, arg_113_1, arg_113_2)
	local var_113_0 = arg_113_0._battleProxy.FrameIndex

	if arg_113_0._frame ~= var_113_0 then
		arg_113_0._distanceBackup = {}
		arg_113_0._frame = var_113_0
	end

	arg_113_0._distanceBackup[arg_113_1] = arg_113_2

	return
end

function var_0_9.GetDirection(arg_114_0)
	return arg_114_0._dir
end

function var_0_9.SetBornPosition(arg_115_0, arg_115_1)
	arg_115_0._bornPos = arg_115_1

	return
end

function var_0_9.SetPosition(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_0._move

	var_2.SetPos(var_116_0, arg_116_1)

	return
end

function var_0_9.IsMoving(arg_117_0)
	local var_117_0 = arg_117_0._move

	return var_1.GetSpeed(var_117_0).x ~= 0 or var_1.z ~= 0
end

function var_0_9.SetUncontrollableSpeedWithYAngle(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
	math = var_1_10004

	local var_118_0 = var_1_10004.deg2Rad * arg_118_1

	Vector3 = var_1_10005
	math = var_1_10006

	local var_118_1 = var_1_10006.cos(var_118_0)
	local var_118_2 = 0

	math = var_1_10008

	local var_118_3 = var_1_10005(var_118_1, var_118_2, var_1_10008.sin(var_118_0))

	arg_118_0:SetUncontrollableSpeed(var_118_3, arg_118_2, arg_118_3)

	return
end

function var_0_9.SetUncontrollableSpeedWithDir(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	math = var_1_10004

	local var_119_0 = var_1_10004.sqrt(arg_119_1.x * arg_119_1.x + arg_119_1.z * arg_119_1.z)

	arg_119_0:SetUncontrollableSpeed(arg_119_1 / var_119_0, arg_119_2, arg_119_3)

	return
end

function var_0_9.SetUncontrollableSpeed(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	if not arg_120_2 or not arg_120_3 then
		return
	end

	local var_120_0 = arg_120_0._move

	var_4.SetForceMove(var_120_0, arg_120_1, arg_120_2, arg_120_3, arg_120_2 / arg_120_3)

	return
end

function var_0_9.ClearUncontrollableSpeed(arg_121_0)
	local var_121_0 = arg_121_0._move

	var_1.ClearForceMove(var_121_0)

	return
end

function var_0_9.SetAdditiveSpeed(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0._move

	var_2.UpdateAdditiveSpeed(var_122_0, arg_122_1)

	return
end

function var_0_9.RemoveAdditiveSpeed(arg_123_0)
	local var_123_0 = arg_123_0._move

	var_1.RemoveAdditiveSpeed(var_123_0)

	return
end

function var_0_9.Boost(arg_124_0, arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)
	local var_124_0 = arg_124_0._move

	var_6.SetForceMove(var_124_0, arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)

	return
end

function var_0_9.ActiveUnstoppable(arg_125_0, arg_125_1)
	local var_125_0 = arg_125_0._move

	var_2.ActiveUnstoppable(var_125_0, arg_125_1)

	return
end

function var_0_9.SetImmuneCommonBulletCLD(arg_126_0)
	arg_126_0._immuneCommonBulletCLD = true

	return
end

function var_0_9.IsImmuneCommonBulletCLD(arg_127_0)
	return arg_127_0._immuneCommonBulletCLD
end

function var_0_9.SetWeaponPreCastBound(arg_128_0, arg_128_1)
	arg_128_0._preCastBound = arg_128_1

	arg_128_0:UpdatePrecastMoveLimit()

	return
end

function var_0_9.EnterGCD(arg_129_0, arg_129_1, arg_129_2)
	if arg_129_0._GCDTimerList[arg_129_2] ~= nil then
		return
	end

	local function var_129_0()
		local var_130_0 = arg_129_0

		var_0.RemoveGCDTimer(var_130_0, arg_129_2)

		return
	end

	local var_129_1 = arg_129_0._weaponQueue

	var_4.QueueEnterGCD(var_129_1, arg_129_2, arg_129_1)

	local var_129_2 = arg_129_0._GCDTimerList

	pg = var_129_1

	local var_129_3 = var_129_1.TimeMgr.GetInstance()

	var_129_2[arg_129_2] = var_5.AddBattleTimer(var_129_3, "weaponGCD", 0, arg_129_1, var_129_0, true)

	arg_129_0:UpdatePrecastMoveLimit()

	return
end

function var_0_9.RemoveGCDTimer(arg_131_0, arg_131_1)
	pg = var_1_10002

	local var_131_0 = var_1_10002.TimeMgr.GetInstance()

	var_2.RemoveBattleTimer(var_131_0, arg_131_0._GCDTimerList[arg_131_1])

	arg_131_0._GCDTimerList[arg_131_1] = nil

	arg_131_0:UpdatePrecastMoveLimit()

	return
end

function var_0_9.UpdatePrecastMoveLimit(arg_132_0)
	arg_132_0:UpdateMoveLimit()

	return
end

function var_0_9.UpdateMoveLimit(arg_133_0)
	local var_133_0 = arg_133_0:IsMoveAble()
	local var_133_1 = arg_133_0._move

	var_2.SetStaticState(var_133_1, not var_133_0)

	return
end

function var_0_9.AddBuff(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = arg_134_1:GetID()
	local var_134_1 = {
		unit_id = arg_134_0._uniqueID,
		buff_id = var_134_0
	}

	if arg_134_0:GetBuff(var_134_0) then
		if arg_134_2 then
			local var_134_2

			if not arg_134_0._buffStockList[var_134_0] then
				var_134_2 = {}
			end

			table = var_7

			var_7.insert(var_134_2, arg_134_1)

			arg_134_0._buffStockList[var_134_0] = var_134_2
		else
			local var_134_3 = var_5:GetLv()
			local var_134_4 = arg_134_1:GetLv()
			local var_134_5 = var_5:GetGroupLevel()
			local var_134_6 = arg_134_1
			local var_134_7 = arg_134_1.GetGroupLevel(var_134_6)

			math = var_134_6
			var_134_1.buff_level = var_134_6.max(var_134_3, var_134_4)

			if var_5:IsForceStack() or var_134_7 <= var_134_5 then
				var_5:Stack(arg_134_0)

				var_134_1.stack_count = var_5:GetStack()

				arg_134_0:DispatchEvent(var_0.Event.New(var_0_2.BUFF_STACK, var_134_1))
			else
				arg_134_0:DispatchEvent(var_0.Event.New(var_0_2.BUFF_CAST, var_134_1))
				arg_134_0:RemoveBuff(var_134_0)

				arg_134_0._buffList[var_134_0] = arg_134_1

				arg_134_1:Attach(arg_134_0)
				arg_134_0:DispatchEvent(var_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
			end
		end
	else
		arg_134_0:DispatchEvent(var_0.Event.New(var_0_2.BUFF_CAST, var_134_1))

		arg_134_0._buffList[var_134_0] = arg_134_1

		arg_134_1:Attach(arg_134_0)

		var_134_1.buff_level = arg_134_1:GetLv()

		arg_134_0:DispatchEvent(var_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
	end

	arg_134_0:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_ADDED, {
		buffID = var_134_0
	})

	return
end

function var_0_9.SetBuffStack(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	if arg_135_3 <= 0 then
		arg_135_0:RemoveBuff(arg_135_1)
	elseif arg_135_0:GetBuff(arg_135_1) then
		var_4:UpdateStack(arg_135_0, arg_135_3)

		return var_4
	else
		local var_135_0 = var_0.Battle.BattleBuffUnit.New(arg_135_1, arg_135_2)

		arg_135_0:AddBuff(var_135_0)
		var_135_0:UpdateStack(arg_135_0, arg_135_3)

		return var_135_0
	end

	return
end

function var_0_9.UpdateBuff(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0._buffList

	pairs = var_1_10003

	for iter_136_0, iter_136_1 in var_1_10003(var_136_0) do
		iter_136_1:Update(arg_136_0, arg_136_1)

		if not arg_136_0:IsAlive() then
			break
		end
	end

	return
end

function var_0_9.ConsumeBuffStack(arg_137_0, arg_137_1, arg_137_2)
	if arg_137_0:GetBuff(arg_137_1) then
		if not arg_137_2 then
			arg_137_0:RemoveBuff(arg_137_1)
		else
			local var_137_0 = var_3
			local var_137_1 = var_3.GetStack(var_137_0)

			math = var_137_0

			if var_137_0.max(0, var_137_1 - arg_137_2) == 0 then
				arg_137_0:RemoveBuff(arg_137_1)
			else
				var_3:UpdateStack(arg_137_0, var_5)
			end
		end
	end

	return
end

function var_0_9.RemoveBuff(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_2 and arg_138_0._buffStockList[arg_138_1] then
		table = var_3

		if var_3.remove(arg_138_0._buffStockList[arg_138_1]) then
			var_3:Clear()

			return
		end
	end

	if arg_138_0:GetBuff(arg_138_1) then
		var_3:Remove()
	end

	arg_138_0:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_REMOVED, {
		buffID = arg_138_1
	})

	return
end

function var_0_9.ClearBuff(arg_139_0)
	local var_139_0 = arg_139_0._buffList

	pairs = var_1_10002

	for iter_139_0, iter_139_1 in var_1_10002(var_139_0) do
		var_1_10008 = iter_139_1

		iter_139_1.Clear(var_1_10008)
	end

	local var_139_1 = arg_139_0._buffStockList

	pairs = var_3

	for iter_139_2, iter_139_3 in var_3(var_139_1) do
		pairs = var_1_10008

		for iter_139_4, iter_139_5 in var_1_10008(iter_139_3) do
			iter_139_5:Clear()
		end
	end

	return
end

function var_0_9.TriggerBuff(arg_140_0, arg_140_1, arg_140_2)
	var_0.Battle.BattleBuffUnit.Trigger(arg_140_0, arg_140_1, arg_140_2)

	return
end

function var_0_9.GetBuffList(arg_141_0)
	return arg_141_0._buffList
end

function var_0_9.GetBuff(arg_142_0, arg_142_1)
	arg_142_0._buffList = arg_142_0._buffList

	return arg_142_0._buffList[arg_142_1]
end

function var_0_9.DispatchSkillFloat(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	local var_143_0 = {
		coverHrzIcon = arg_143_3,
		commander = arg_143_2,
		skillName = arg_143_1
	}

	arg_143_0:DispatchEvent(var_0.Event.New(var_0_1.SKILL_FLOAT, var_143_0))

	return
end

function var_0_9.DispatchCutIn(arg_144_0, arg_144_1, arg_144_2)
	local var_144_0 = {
		caster = arg_144_0,
		skill = arg_144_1
	}

	arg_144_0:DispatchEvent(var_0.Event.New(var_0_1.CUT_INT, var_144_0))

	return
end

function var_0_9.DispatchCastClock(arg_145_0, arg_145_1, arg_145_2, arg_145_3, arg_145_4, arg_145_5)
	local var_145_0 = {
		isActive = arg_145_1,
		buffEffect = arg_145_2,
		iconType = arg_145_3,
		interrupt = arg_145_4,
		reverse = arg_145_5
	}

	arg_145_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_BUFF_CLOCK, var_145_0))

	return
end

function var_0_9.SetAI(arg_146_0, arg_146_1)
	local var_146_0 = var_0_7.GetAITmpDataFromID(arg_146_1)
	local var_146_1 = var_0.Battle.AutoPilot.New(arg_146_0, var_146_0)
	local var_146_2 = arg_146_0._move

	var_4.CancelFormationCtrl(var_146_2)

	arg_146_0._autoPilotAI = var_146_1

	return
end

function var_0_9.AddPhaseSwitcher(arg_147_0, arg_147_1)
	arg_147_0._phaseSwitcher = arg_147_1

	return
end

function var_0_9.GetPhaseSwitcher(arg_148_0)
	return arg_148_0._phaseSwitcher
end

function var_0_9.StateChange(arg_149_0, arg_149_1, arg_149_2)
	local var_149_0 = arg_149_0._unitState

	var_3.ChangeState(var_149_0, arg_149_1, arg_149_2)

	return
end

function var_0_9.UpdateAction(arg_150_0)
	local var_150_0 = arg_150_0:GetSpeed().x * arg_150_0._IFF

	if arg_150_0._oxyState then
		local var_150_1 = arg_150_0._oxyState

		if var_2.GetCurrentDiveState(var_150_1) == var_0_3.OXY_STATE.DIVE then
			if var_150_0 >= 0 then
				local var_150_2 = arg_150_0._unitState

				var_2.ChangeState(var_150_2, var_0_8.STATE_DIVE)
			else
				local var_150_3 = arg_150_0._unitState

				var_2.ChangeState(var_150_3, var_0_8.STATE_DIVELEFT)
			end

			goto label_150_0
		end
	end

	if var_150_0 >= 0 then
		local var_150_4 = arg_150_0._unitState

		var_2.ChangeState(var_150_4, var_0_8.STATE_MOVE)
	else
		local var_150_5 = arg_150_0._unitState

		var_2.ChangeState(var_150_5, var_0_8.STATE_MOVELEFT)
	end

	::label_150_0::

	return
end

function var_0_9.SetActionKeyOffset(arg_151_0, arg_151_1)
	arg_151_0._actionKeyOffset = arg_151_1

	local var_151_0 = arg_151_0._unitState

	var_2.FreshActionKeyOffset(var_151_0)

	return
end

function var_0_9.GetActionKeyOffset(arg_152_0)
	return arg_152_0._actionKeyOffset
end

function var_0_9.GetCurrentState(arg_153_0)
	local var_153_0 = arg_153_0._unitState

	return var_1.GetCurrentStateName(var_153_0)
end

function var_0_9.NeedWeaponCache(arg_154_0)
	local var_154_0 = arg_154_0._unitState

	return var_1.NeedWeaponCache(var_154_0)
end

function var_0_9.CharacterActionTriggerCallback(arg_155_0)
	local var_155_0 = arg_155_0._unitState

	var_1.OnActionTrigger(var_155_0)

	return
end

function var_0_9.CharacterActionEndCallback(arg_156_0)
	local var_156_0 = arg_156_0._unitState

	var_1.OnActionEnd(var_156_0)

	return
end

function var_0_9.CharacterActionStartCallback(arg_157_0)
	return
end

function var_0_9.DispatchChat(arg_158_0, arg_158_1, arg_158_2, arg_158_3)
	if not arg_158_1 or #arg_158_1 == 0 then
		return
	end

	local var_158_0 = {}

	HXSet = var_1_10005
	var_158_0.content = var_1_10005.hxLan(arg_158_1)
	var_158_0.duration = arg_158_2
	var_158_0.key = arg_158_3

	arg_158_0:DispatchEvent(var_0.Event.New(var_0_1.POP_UP, var_158_0))

	return
end

function var_0_9.DispatchVoice(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0
	local var_159_1 = arg_159_0.GetIntimacy(var_159_0)

	ShipWordHelper = var_159_0

	local var_159_2, var_159_3, var_159_4 = var_159_0.GetWordAndCV(arg_159_0:GetSkinID(), arg_159_1, 1, true, var_159_1)

	if var_159_3 then
		local var_159_5 = {
			content = var_159_3,
			key = arg_159_1
		}

		arg_159_0:DispatchEvent(var_0.Event.New(var_0_1.VOICE, var_159_5))
	end

	return
end

function var_0_9.GetHostileCldList(arg_160_0)
	return arg_160_0._hostileCldList
end

function var_0_9.AppendHostileCld(arg_161_0, arg_161_1, arg_161_2)
	arg_161_0._hostileCldList[arg_161_1] = arg_161_2

	return
end

function var_0_9.RemoveHostileCld(arg_162_0, arg_162_1)
	pg = var_1_10002

	local var_162_0 = var_1_10002.TimeMgr.GetInstance()

	var_2.RemoveBattleTimer(var_162_0, arg_162_0._hostileCldList[arg_162_1])

	arg_162_0._hostileCldList[arg_162_1] = nil

	return
end

function var_0_9.GetExtraInfo(arg_163_0)
	return arg_163_0._extraInfo
end

function var_0_9.GetTemplate(arg_164_0)
	return nil
end

function var_0_9.GetGroupID(arg_165_0)
	return nil
end

function var_0_9.GetTemplateValue(arg_166_0, arg_166_1)
	return arg_166_0:GetTemplate()[arg_166_1]
end

function var_0_9.GetUniqueID(arg_167_0)
	return arg_167_0._uniqueID
end

function var_0_9.SetIFF(arg_168_0, arg_168_1)
	arg_168_0._IFF = arg_168_1

	if arg_168_1 == var_0_5.FRIENDLY_CODE then
		arg_168_0._dir = var_0_3.UnitDir.RIGHT
	elseif arg_168_1 == var_0_5.FOE_CODE then
		arg_168_0._dir = var_0_3.UnitDir.LEFT
	end

	return
end

function var_0_9.GetIFF(arg_169_0)
	return arg_169_0._IFF
end

function var_0_9.GetUnitType(arg_170_0)
	return arg_170_0._type
end

function var_0_9.GetHPRate(arg_171_0)
	return arg_171_0._currentHPRate
end

function var_0_9.GetHP(arg_172_0)
	local var_172_0 = arg_172_0._currentHP
	local var_172_1 = arg_172_0:GetMaxHP()
end

function var_0_9.GetCurrentHP(arg_173_0)
	return arg_173_0._currentHP
end

function var_0_9.SetCurrentHP(arg_174_0, arg_174_1)
	arg_174_0._currentHP = arg_174_1
	arg_174_0._currentHPRate = arg_174_0._currentHP / arg_174_0:GetMaxHP()
	arg_174_0._currentDMGRate = 1 - arg_174_0._currentHPRate

	var_0_6.SetCurrent(arg_174_0, "HPRate", arg_174_0._currentHPRate)
	var_0_6.SetCurrent(arg_174_0, "DMGRate", arg_174_0._currentDMGRate)

	return
end

function var_0_9.GetAttr(arg_175_0)
	return var_0_6.GetAttr(arg_175_0)
end

function var_0_9.GetAttrByName(arg_176_0, arg_176_1)
	return var_0_6.GetCurrent(arg_176_0, arg_176_1)
end

function var_0_9.GetMaxHP(arg_177_0)
	return arg_177_0:GetAttrByName("maxHP")
end

function var_0_9.GetReload(arg_178_0)
	return arg_178_0:GetAttrByName("loadSpeed")
end

function var_0_9.GetTorpedoPower(arg_179_0)
	return arg_179_0:GetAttrByName("torpedoPower")
end

function var_0_9.CanDoAntiSub(arg_180_0)
	return arg_180_0:GetAttrByName("antiSubPower") > 0
end

function var_0_9.IsShowHPBar(arg_181_0)
	return false
end

function var_0_9.IsAlive(arg_182_0)
	local var_182_0 = arg_182_0:GetCurrentHP()
	local var_182_1

	if arg_182_0._aliveState then
		var_182_1 = var_182_0 > 0
	end

	return var_182_1
end

function var_0_9.SetMainFleetUnit(arg_183_0)
	arg_183_0._isMainFleetUnit = true

	arg_183_0:SetMainUnitStatic(true)

	return
end

function var_0_9.IsMainFleetUnit(arg_184_0)
	return arg_184_0._isMainFleetUnit
end

function var_0_9.SetMainUnitStatic(arg_185_0, arg_185_1)
	arg_185_0._isMainStatic = arg_185_1

	local var_185_0 = arg_185_0._move

	var_2.SetStaticState(var_185_0, arg_185_1)

	return
end

function var_0_9.SetMainUnitIndex(arg_186_0, arg_186_1)
	arg_186_0._mainUnitIndex = arg_186_1

	return
end

function var_0_9.GetMainUnitIndex(arg_187_0)
	local var_187_0

	if not arg_187_0._mainUnitIndex then
		var_187_0 = 1
	end

	return var_187_0
end

function var_0_9.IsMoveAble(arg_188_0)
	table = var_1_10001

	local var_188_0 = var_1_10001.getCount(arg_188_0._GCDTimerList) > 0 or arg_188_0._preCastBound
	local var_188_1 = var_0_6.IsStun(arg_188_0)
	local var_188_2 = arg_188_0:IsMoveCast()

	return not arg_188_0._isMainStatic and (var_188_2 or not var_188_0) and not var_188_1
end

function var_0_9.Reinforce(arg_189_0)
	arg_189_0._isReinforcement = true

	return
end

function var_0_9.IsReinforcement(arg_190_0)
	return arg_190_0._isReinforcement
end

function var_0_9.SetReinforceCastTime(arg_191_0, arg_191_1)
	arg_191_0._reinforceCastTime = arg_191_1

	return
end

function var_0_9.GetReinforceCastTime(arg_192_0)
	return arg_192_0._reinforceCastTime
end

function var_0_9.GetFleetVO(arg_193_0)
	return
end

function var_0_9.SetFormationIndex(arg_194_0, arg_194_1)
	return
end

function var_0_9.SetMaster(arg_195_0)
	return
end

function var_0_9.GetMaster(arg_196_0)
	return nil
end

function var_0_9.IsSpectre(arg_197_0)
	return
end

function var_0_9.Clear(arg_198_0)
	arg_198_0._aliveState = false
	pairs = var_1

	for iter_198_0, iter_198_1 in var_1(arg_198_0._hostileCldList) do
		arg_198_0:RemoveHostileCld(iter_198_0)
	end

	arg_198_0:ClearWeapon()
	arg_198_0:ClearBuff()

	arg_198_0._distanceBackup = {}

	return
end

function var_0_9.Dispose(arg_199_0)
	arg_199_0._exposedList = nil
	arg_199_0._phaseSwitcher = nil

	local var_199_0 = arg_199_0._weaponQueue

	var_1.Dispose(var_199_0)

	if arg_199_0._airAssistQueue then
		var_199_0 = arg_199_0._airAssistQueue

		var_1.Clear(var_199_0)

		arg_199_0._airAssistQueue = nil
	end

	arg_199_0._equipmentList = nil
	arg_199_0._totalWeapon = nil

	if arg_199_0._airAssistList then
		ipairs = var_199_0

		for iter_199_0, iter_199_1 in var_199_0(var_1) do
			iter_199_1:Dispose()
		end
	end

	ipairs = var_199_0

	for iter_199_2, iter_199_3 in var_199_0(arg_199_0._fleetAAList) do
		iter_199_3:Dispose()
	end

	ipairs = var_2

	for iter_199_4, iter_199_5 in var_2(arg_199_0._fleetRangeAAList) do
		iter_199_5:Dispose()
	end

	local var_199_1 = arg_199_0._buffList

	pairs = var_3

	for iter_199_6, iter_199_7 in var_3(var_199_1) do
		var_1_10009 = iter_199_7

		iter_199_7.Dispose(var_1_10009)
	end

	local var_199_2 = arg_199_0._buffStockList

	pairs = var_4

	for iter_199_8, iter_199_9 in var_4(var_199_2) do
		pairs = var_1_10009

		for iter_199_10, iter_199_11 in var_1_10009(iter_199_9) do
			iter_199_11:Clear()
		end
	end

	arg_199_0._fleetRangeAA = nil
	arg_199_0._aimBias = nil
	arg_199_0._buffList = nil
	arg_199_0._buffStockList = nil
	arg_199_0._cldZCenterCache = nil
	arg_199_0._remoteBoundBone = nil

	arg_199_0:RemoveSummonSickness()
	var_0.EventDispatcher.DetachEventDispatcher(arg_199_0)

	return
end

function var_0_9.InitCldComponent(arg_200_0)
	local var_200_0 = arg_200_0:GetTemplate().cld_box
	local var_200_1 = arg_200_0:GetTemplate().cld_offset[1]

	if arg_200_0:GetDirection() == var_0_3.UnitDir.LEFT then
		var_200_1 = var_200_1 * -1
	end

	arg_200_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(var_200_0[1], var_200_0[2], var_200_0[3], var_200_1, var_2[3] + var_200_0[3] / 2)

	return
end

function var_0_9.GetBoxSize(arg_201_0)
	local var_201_0 = arg_201_0._cldComponent

	return var_1.GetCldBoxSize(var_201_0)
end

function var_0_9.GetCldBox(arg_202_0)
	local var_202_0 = arg_202_0._cldComponent

	return var_1.GetCldBox(var_202_0, arg_202_0:GetPosition())
end

function var_0_9.GetCldData(arg_203_0)
	local var_203_0 = arg_203_0._cldComponent

	return var_1.GetCldData(var_203_0)
end

function var_0_9.ShiftCldComponent(arg_204_0, arg_204_1, arg_204_2)
	arg_204_0:updateCldComponet(arg_204_1, arg_204_2)

	return
end

function var_0_9.ResetCldComponent(arg_205_0)
	local var_205_0 = arg_205_0:GetTemplate().cld_box
	local var_205_1 = arg_205_0:GetTemplate().cld_offset

	arg_205_0:updateCldComponet(var_205_0, var_205_1)

	return
end

function var_0_9.updateCldComponet(arg_206_0, arg_206_1, arg_206_2)
	local var_206_0 = arg_206_2[1]

	if arg_206_0:GetDirection() == var_0_3.UnitDir.LEFT then
		var_206_0 = var_206_0 * -1
	end

	local var_206_1 = arg_206_0._cldComponent

	var_4.ResetOffset(var_206_1, var_206_0, arg_206_2[3] + arg_206_1[3] / 2)

	local var_206_2 = arg_206_0._cldComponent

	var_4.ResetSize(var_206_2, arg_206_1[1], arg_206_1[2], arg_206_1[3])

	return
end

function var_0_9.InitOxygen(arg_207_0)
	arg_207_0._maxOxy = arg_207_0:GetAttrByName("oxyMax")
	arg_207_0._currentOxy = arg_207_0:GetAttrByName("oxyMax")
	arg_207_0._oxyRecovery = arg_207_0:GetAttrByName("oxyRecovery")
	arg_207_0._oxyRecoveryBench = arg_207_0:GetAttrByName("oxyRecoveryBench")
	arg_207_0._oxyRecoverySurface = arg_207_0:GetAttrByName("oxyRecoverySurface")
	arg_207_0._oxyConsume = arg_207_0:GetAttrByName("oxyCost")
	arg_207_0._oxyState = var_0.Battle.OxyState.New(arg_207_0)

	local var_207_0 = arg_207_0._oxyState

	var_1.OnDiveState(var_207_0)
	arg_207_0:ConfigBubbleFX()

	return arg_207_0._oxyState
end

function var_0_9.UpdateOxygen(arg_208_0, arg_208_1)
	if arg_208_0._oxyState then
		local var_208_0

		if not arg_208_0._lastOxyUpdateStamp then
			var_208_0 = arg_208_1
		end

		arg_208_0._lastOxyUpdateStamp = var_208_0

		local var_208_1 = arg_208_0._oxyState

		var_2.UpdateOxygen(var_208_1)

		local var_208_2 = arg_208_0._oxyState

		if var_2.GetNextBubbleStamp(var_208_2) then
			local var_208_3 = arg_208_0._oxyState

			if arg_208_1 > var_2.GetNextBubbleStamp(var_208_3) then
				local var_208_4 = arg_208_0._oxyState

				var_2.FlashBubbleStamp(var_208_4, arg_208_1)
				arg_208_0:PlayFX(arg_208_0._bubbleFX, true)
			end
		end

		arg_208_0._lastOxyUpdateStamp = arg_208_1

		arg_208_0:updateSonarExposeTag()
	end

	return
end

function var_0_9.OxyRecover(arg_209_0, arg_209_1)
	local var_209_0

	if arg_209_1 == var_0.Battle.OxyState.STATE_FREE_BENCH then
		var_209_0 = arg_209_0._oxyRecoveryBench
	elseif arg_209_1 == var_0.Battle.OxyState.STATE_FREE_FLOAT then
		var_209_0 = arg_209_0._oxyRecovery
	else
		var_209_0 = arg_209_0._oxyRecoverySurface
	end

	pg = var_3

	local var_209_1 = var_3.TimeMgr.GetInstance()
	local var_209_2 = var_3.GetCombatTime(var_209_1) - arg_209_0._lastOxyUpdateStamp

	math = var_4
	arg_209_0._currentOxy = var_4.min(arg_209_0._maxOxy, arg_209_0._currentOxy + var_209_0 * var_209_2)

	return
end

function var_0_9.OxyConsume(arg_210_0)
	pg = var_1_10001

	local var_210_0 = var_1_10001.TimeMgr.GetInstance()
	local var_210_1 = var_1.GetCombatTime(var_210_0) - arg_210_0._lastOxyUpdateStamp

	math = var_2
	arg_210_0._currentOxy = var_2.max(0, arg_210_0._currentOxy - arg_210_0._oxyConsume * var_210_1)

	return
end

function var_0_9.ChangeOxygenState(arg_211_0, arg_211_1)
	local var_211_0 = arg_211_0._oxyState

	var_2.ChangeState(var_211_0, arg_211_1)

	return
end

function var_0_9.ChangeWeaponDiveState(arg_212_0)
	ipairs = var_1_10001

	for iter_212_0, iter_212_1 in var_1_10001(arg_212_0._autoWeaponList) do
		iter_212_1:ChangeDiveState()
	end

	return
end

function var_0_9.GetOxygenProgress(arg_213_0)
	return arg_213_0._currentOxy / arg_213_0._maxOxy
end

function var_0_9.GetCuurentOxygen(arg_214_0)
	local var_214_0

	if not arg_214_0._currentOxy then
		var_214_0 = 0
	end

	return var_214_0
end

function var_0_9.ConfigBubbleFX(arg_215_0)
	return
end

function var_0_9.SetDiveInvisible(arg_216_0, arg_216_1)
	arg_216_0._diveInvisible = arg_216_1

	arg_216_0:DispatchEvent(var_0.Event.New(var_0_1.SUBMARINE_VISIBLE))
	arg_216_0:DispatchEvent(var_0.Event.New(var_0_1.SUBMARINE_DETECTED))
	arg_216_0:dispatchDetectedTrigger()

	return
end

function var_0_9.GetDiveInvisible(arg_217_0)
	return arg_217_0._diveInvisible
end

function var_0_9.GetOxygenVisible(arg_218_0)
	local var_218_1

	if arg_218_0._oxyState then
		local var_218_0 = arg_218_0._oxyState

		var_218_1 = var_1.GetBarVisible(var_218_0)
	end

	return var_218_1
end

function var_0_9.SetForceVisible(arg_219_0)
	arg_219_0:DispatchEvent(var_0.Event.New(var_0_1.SUBMARINE_FORCE_DETECTED))

	return
end

function var_0_9.Detected(arg_220_0, arg_220_1)
	local var_220_0

	if arg_220_0._exposedToSnoar == false and not arg_220_0._exposedOverTimeStamp then
		var_220_0 = true
	end

	if arg_220_1 then
		arg_220_0:updateExposeTimeStamp(arg_220_1)
	else
		arg_220_0._exposedToSnoar = true
	end

	if var_220_0 then
		arg_220_0:DispatchEvent(var_0.Event.New(var_0_1.SUBMARINE_DETECTED, {}))
		arg_220_0:dispatchDetectedTrigger()
	end

	return
end

function var_0_9.Undetected(arg_221_0)
	arg_221_0._exposedToSnoar = false

	arg_221_0:updateExposeTimeStamp(var_0_5.SUB_EXPOSE_LASTING_DURATION)

	return
end

function var_0_9.RemoveSonarExpose(arg_222_0)
	arg_222_0._exposedToSnoar = false
	arg_222_0._exposedOverTimeStamp = nil

	return
end

function var_0_9.updateSonarExposeTag(arg_223_0)
	if arg_223_0._exposedOverTimeStamp and not arg_223_0._exposedToSnoar then
		pg = var_1

		local var_223_0 = var_1.TimeMgr.GetInstance()

		if var_1.GetCombatTime(var_223_0) > arg_223_0._exposedOverTimeStamp then
			arg_223_0._exposedOverTimeStamp = nil

			arg_223_0:DispatchEvent(var_0.Event.New(var_0_1.SUBMARINE_DETECTED, {
				detected = false
			}))
			arg_223_0:dispatchDetectedTrigger()
		end
	end

	return
end

function var_0_9.updateExposeTimeStamp(arg_224_0, arg_224_1)
	pg = var_1_10002

	local var_224_0 = var_1_10002.TimeMgr.GetInstance()
	local var_224_1 = var_2.GetCombatTime(var_224_0) + arg_224_1
	local var_224_2

	if not arg_224_0._exposedOverTimeStamp then
		var_224_2 = 0
	end

	arg_224_0._exposedOverTimeStamp = var_224_2

	local var_224_3

	if not (var_224_1 < arg_224_0._exposedOverTimeStamp) or not arg_224_0._exposedOverTimeStamp then
		var_224_3 = var_224_1
	end

	arg_224_0._exposedOverTimeStamp = var_224_3

	return
end

function var_0_9.IsRunMode(arg_225_0)
	local var_225_1

	if arg_225_0._oxyState then
		local var_225_0 = arg_225_0._oxyState

		var_225_1 = var_1.GetRundMode(var_225_0)
	end

	return var_225_1
end

function var_0_9.GetDiveDetected(arg_226_0)
	local var_226_0

	if arg_226_0:GetDiveInvisible() and not arg_226_0._exposedOverTimeStamp then
		var_226_0 = arg_226_0._exposedToSnoar
	end

	return var_226_0
end

function var_0_9.GetForceExpose(arg_227_0)
	local var_227_1

	if arg_227_0._oxyState then
		local var_227_0 = arg_227_0._oxyState

		var_227_1 = var_1.GetForceExpose(var_227_0)
	end

	return var_227_1
end

function var_0_9.dispatchDetectedTrigger(arg_228_0)
	if arg_228_0:GetDiveDetected() then
		arg_228_0:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_DETECTED, {})
	else
		arg_228_0:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_UNDETECTED, {})
	end

	return
end

function var_0_9.GetRaidDuration(arg_229_0)
	return arg_229_0:GetAttrByName("oxyMax") / arg_229_0:GetAttrByName("oxyCost")
end

function var_0_9.EnterRaidRange(arg_230_0)
	if arg_230_0:GetPosition().x > arg_230_0._subRaidLine then
		return true
	else
		return false
	end

	return
end

function var_0_9.EnterRetreatRange(arg_231_0)
	if arg_231_0:GetPosition().x < arg_231_0._subRetreatLine then
		return true
	else
		return false
	end

	return
end

function var_0_9.GetOxyState(arg_232_0)
	return arg_232_0._oxyState
end

function var_0_9.GetCurrentOxyState(arg_233_0)
	if not arg_233_0._oxyState then
		return var_0_3.OXY_STATE.FLOAT
	else
		local var_233_0 = arg_233_0._oxyState

		return var_1.GetCurrentDiveState(var_233_0)
	end

	return
end

function var_0_9.InitAntiSubState(arg_234_0, arg_234_1, arg_234_2)
	arg_234_0._antiSubVigilanceState = var_0.Battle.AntiSubState.New(arg_234_0)

	arg_234_0:DispatchEvent(var_0.Event.New(var_0_1.INIT_ANIT_SUB_VIGILANCE, {
		sonarRange = arg_234_1
	}))

	return arg_234_0._antiSubVigilanceState
end

function var_0_9.GetAntiSubState(arg_235_0)
	return arg_235_0._antiSubVigilanceState
end

function var_0_9.UpdateBlindInvisibleBySpectre(arg_236_0)
	local var_236_0, var_236_1 = arg_236_0:IsSpectre()

	if var_236_1 <= var_0_5.SPECTRE_UNIT_TYPE and var_236_1 ~= var_0_5.VISIBLE_SPECTRE_UNIT_TYPE then
		arg_236_0:SetBlindInvisible(true)
	else
		arg_236_0:SetBlindInvisible(false)
	end

	return
end

function var_0_9.SetBlindInvisible(arg_237_0, arg_237_1)
	local var_237_0

	if not arg_237_1 or not {} then
		var_237_0 = nil
	end

	arg_237_0._exposedList = var_237_0
	arg_237_0._blindInvisible = arg_237_1

	arg_237_0:DispatchEvent(var_0.Event.New(var_0_1.BLIND_VISIBLE))

	return
end

function var_0_9.GetBlindInvisible(arg_238_0)
	return arg_238_0._blindInvisible
end

function var_0_9.GetExposed(arg_239_0)
	if not arg_239_0._blindInvisible then
		return true
	end

	pairs = var_1

	for iter_239_0, iter_239_1 in var_1(arg_239_0._exposedList) do
		return true
	end

	return
end

function var_0_9.AppendExposed(arg_240_0, arg_240_1)
	if not arg_240_0._blindInvisible then
		return
	end

	local var_240_0 = arg_240_0._exposedList[arg_240_1]

	arg_240_0._exposedList[arg_240_1] = true

	if not var_240_0 then
		arg_240_0:DispatchEvent(var_0.Event.New(var_0_1.BLIND_EXPOSE))
	end

	return
end

function var_0_9.RemoveExposed(arg_241_0, arg_241_1)
	if not arg_241_0._blindInvisible then
		return
	end

	arg_241_0._exposedList[arg_241_1] = nil

	arg_241_0:DispatchEvent(var_0.Event.New(var_0_1.BLIND_EXPOSE))

	return
end

function var_0_9.SetWorldDeathMark(arg_242_0)
	arg_242_0._worldDeathMark = true

	return
end

function var_0_9.GetWorldDeathMark(arg_243_0)
	return arg_243_0._worldDeathMark
end

function var_0_9.InitCloak(arg_244_0)
	arg_244_0._cloak = var_0.Battle.BattleUnitCloakComponent.New(arg_244_0)

	arg_244_0:DispatchEvent(var_0.Event.New(var_0_1.INIT_CLOAK))

	return arg_244_0._cloak
end

function var_0_9.CloakOnFire(arg_245_0, arg_245_1)
	if arg_245_0._cloak then
		local var_245_0 = arg_245_0._cloak

		var_2.UpdateDotExpose(var_245_0, arg_245_1)
	end

	return
end

function var_0_9.CloakExpose(arg_246_0, arg_246_1)
	if arg_246_0._cloak then
		local var_246_0 = arg_246_0._cloak

		var_2.AppendExpose(var_246_0, arg_246_1)
	end

	return
end

function var_0_9.StrikeExpose(arg_247_0)
	if arg_247_0._cloak then
		local var_247_0 = arg_247_0._cloak

		var_1.AppendStrikeExpose(var_247_0)
	end

	return
end

function var_0_9.BombardExpose(arg_248_0)
	if arg_248_0._cloak then
		local var_248_0 = arg_248_0._cloak

		var_1.AppendBombardExpose(var_248_0)
	end

	return
end

function var_0_9.UpdateCloak(arg_249_0, arg_249_1)
	local var_249_0 = arg_249_0._cloak

	var_2.Update(var_249_0, arg_249_1)

	return
end

function var_0_9.UpdateCloakConfig(arg_250_0)
	if arg_250_0._cloak then
		local var_250_0 = arg_250_0._cloak

		var_1.UpdateCloakConfig(var_250_0)
		arg_250_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))
	end

	return
end

function var_0_9.DispatchCloakStateUpdate(arg_251_0)
	if arg_251_0._cloak then
		arg_251_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_CLOAK_STATE))
	end

	return
end

function var_0_9.GetCloak(arg_252_0)
	return arg_252_0._cloak
end

function var_0_9.AttachAimBias(arg_253_0, arg_253_1)
	arg_253_0._aimBias = arg_253_1

	arg_253_0:DispatchEvent(var_0.Event.New(var_0_1.INIT_AIMBIAS))

	return
end

function var_0_9.DetachAimBias(arg_254_0)
	arg_254_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIMBIAS))

	local var_254_0 = arg_254_0._aimBias

	var_1.RemoveCrew(var_254_0, arg_254_0)

	arg_254_0._aimBias = nil

	return
end

function var_0_9.ExitSmokeArea(arg_255_0)
	local var_255_0 = arg_255_0._aimBias

	var_1.SmokeExitPause(var_255_0)

	return
end

function var_0_9.UpdateAimBiasSkillState(arg_256_0)
	if arg_256_0._aimBias then
		local var_256_0 = arg_256_0._aimBias

		if var_1.GetHost(var_256_0) == arg_256_0 then
			local var_256_1 = arg_256_0._aimBias

			var_1.UpdateSkillLock(var_256_1)
		end
	end

	return
end

function var_0_9.HostAimBias(arg_257_0)
	if arg_257_0._aimBias then
		arg_257_0:DispatchEvent(var_0.Event.New(var_0_1.HOST_AIMBIAS))
	end

	return
end

function var_0_9.GetAimBias(arg_258_0)
	return arg_258_0._aimBias
end

function var_0_9.SwitchSpine(arg_259_0, arg_259_1, arg_259_2)
	arg_259_0:DispatchEvent(var_0.Event.New(var_0_1.SWITCH_SPINE, {
		skin = arg_259_1,
		HPBarOffset = arg_259_2
	}))

	return
end

function var_0_9.Freeze(arg_260_0)
	ipairs = var_1_10001

	for iter_260_0, iter_260_1 in var_1_10001(arg_260_0._totalWeapon) do
		iter_260_1:StartJamming()
	end

	if arg_260_0._airAssistList then
		ipairs = var_1

		for iter_260_2, iter_260_3 in var_1(arg_260_0._airAssistList) do
			iter_260_3:StartJamming()
		end
	end

	return
end

function var_0_9.ActiveFreeze(arg_261_0)
	ipairs = var_1_10001

	for iter_261_0, iter_261_1 in var_1_10001(arg_261_0._totalWeapon) do
		iter_261_1:JammingEliminate()
	end

	if arg_261_0._airAssistList then
		ipairs = var_1

		for iter_261_2, iter_261_3 in var_1(arg_261_0._airAssistList) do
			iter_261_3:JammingEliminate()
		end
	end

	return
end

function var_0_9.ActiveWeaponSectorView(arg_262_0, arg_262_1, arg_262_2)
	local var_262_0 = {
		weapon = arg_262_1,
		isActive = arg_262_2
	}

	arg_262_0:DispatchEvent(var_0.Event.New(var_0_1.WEAPON_SECTOR, var_262_0))

	return
end

return
