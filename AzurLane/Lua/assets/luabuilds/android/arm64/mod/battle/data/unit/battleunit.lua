ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleBuffEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleVariable
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleAttr
local var_0_6 = ys.Battle.BattleDataFunction
local var_0_7 = ys.Battle.UnitState
local var_0_8 = class("BattleUnit")

ys.Battle.BattleUnit = var_0_8
var_0_8.__name = "BattleUnit"

function var_0_8.Ctor(arg_1_0, arg_1_1, arg_1_2)
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

function var_0_8.Retreat(arg_2_0)
	arg_2_0:TriggerBuff(var_0_2.BuffEffectType.ON_RETREAT, {})

	return
end

function var_0_8.SetMotion(arg_3_0, arg_3_1)
	arg_3_0._move:SetMotionVO(arg_3_1)

	return
end

function var_0_8.SetBound(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._move:SetCorpsArea(arg_4_5, arg_4_6)
	arg_4_0._move:SetBorder(arg_4_3, arg_4_4, arg_4_1, arg_4_2)

	return
end

function var_0_8.ActiveCldBox(arg_5_0)
	arg_5_0._cldComponent:SetActive(true)

	return
end

function var_0_8.DeactiveCldBox(arg_6_0)
	arg_6_0._cldComponent:SetActive(false)

	return
end

function var_0_8.SetCldBoxImmune(arg_7_0, arg_7_1)
	arg_7_0._cldComponent:SetImmuneCLD(arg_7_1)

	return
end

function var_0_8.Init(arg_8_0)
	arg_8_0._hostileCldList = {}
	arg_8_0._currentHPRate = 1
	arg_8_0._currentDMGRate = 0
	arg_8_0._tagCount = 0
	arg_8_0._tagIndex = 0
	arg_8_0._tagList = {}
	arg_8_0._aliveState = true
	arg_8_0._isMainFleetUnit = false
	arg_8_0._bulletCache = {}
	arg_8_0._speed = Vector3.zero
	arg_8_0._dir = var_0_2.UnitDir.RIGHT
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

function var_0_8.Update(arg_9_0, arg_9_1)
	if arg_9_0:IsAlive() and not arg_9_0._isSickness then
		arg_9_0._move:Update()
		arg_9_0._move:FixSpeed(arg_9_0._cldComponent)
		arg_9_0._move:Move(arg_9_0:GetSpeedRatio())
	end

	arg_9_0:UpdateAction()

	return
end

function var_0_8.UpdateWeapon(arg_10_0, arg_10_1)
	if not arg_10_0:IsAlive() or arg_10_0._isSickness then
		return
	end

	if not arg_10_0._antiSubVigilanceState or arg_10_0._antiSubVigilanceState:IsWeaponUseable() then
		local var_10_0 = arg_10_0._move:GetPos()

		if (arg_10_0._weaponRightBound == nil or arg_10_0._weaponRightBound > var_10_0.x) and (arg_10_0._weaponLowerBound == nil or arg_10_0._weaponLowerBound < var_10_0.z) then
			arg_10_0._weaponQueue:Update(arg_10_1)
		end
	end

	if not arg_10_0:IsAlive() then
		return
	end

	arg_10_0:UpdateBuff(arg_10_1)

	return
end

function var_0_8.UpdateAirAssist(arg_11_0)
	if arg_11_0._airAssistList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._airAssistList) do
			iter_11_1:Update()
		end
	end

	return
end

function var_0_8.UpdatePhaseSwitcher(arg_12_0)
	if arg_12_0._phaseSwitcher then
		arg_12_0._phaseSwitcher:Update()
	end

	return
end

function var_0_8.SetInterruptSickness(arg_13_0, arg_13_1)
	arg_13_0._isSickness = arg_13_1

	return
end

function var_0_8.SummonSickness(arg_14_0, arg_14_1)
	if arg_14_0._isSickness == true then
		return
	end

	local function var_14_0()
		arg_14_0:RemoveSummonSickness()

		return
	end

	arg_14_0._isSickness = true
	arg_14_0._sicknessTimer = pg.TimeMgr.GetInstance():AddBattleTimer("summonSickness", 0, arg_14_1, var_14_0, true)

	return
end

function var_0_8.RemoveSummonSickness(arg_16_0)
	arg_16_0._isSickness = false

	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_0._sicknessTimer)

	arg_16_0._sicknessTimer = nil

	return
end

function var_0_8.GetTargetedPriority(arg_17_0)
	local var_17_0

	if arg_17_0._aimBias then
		local var_17_1 = arg_17_0._aimBias:GetCurrentState()

		var_17_0 = (var_17_1 == arg_17_0._aimBias.STATE_SKILL_EXPOSE or var_17_1 == arg_17_0._aimBias.STATE_TOTAL_EXPOSE) and arg_17_0:GetTemplate().battle_unit_type or -200
	else
		var_17_0 = arg_17_0:GetTemplate().battle_unit_type
	end

	return var_17_0
end

function var_0_8.PlayFX(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:DispatchEvent(var_0.Event.New(var_0_0.PLAY_FX, {
		fxName = arg_18_1,
		notAttach = not arg_18_2
	}))

	return
end

function var_0_8.SwitchShader(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0:DispatchEvent(var_0.Event.New(var_0_0.SWITCH_SHADER, {
		shader = arg_19_1,
		color = arg_19_2,
		args = arg_19_3
	}))

	return
end

function var_0_8.SendAttackTrigger(arg_20_0)
	arg_20_0:DispatchEvent(var_0.Event.New(var_0_0.SPAWN_CACHE_BULLET, {}))

	return
end

function var_0_8.HandleDamageToDeath(arg_21_0)
	arg_21_0:UpdateHP(math.floor(-arg_21_0._currentHP), {
		isMiss = false,
		isCri = true,
		isHeal = false,
		damageReason = var_0_2.UnitDeathReason.DESTRUCT
	})

	return
end

function var_0_8.UpdateHP(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:IsAlive()

	if not var_22_0 then
		return 0
	end

	local var_22_1 = arg_22_2.isMiss
	local var_22_2 = arg_22_2.isCri
	local var_22_3 = arg_22_2.isHeal
	local var_22_4 = arg_22_2.font
	local var_22_5 = arg_22_2.cldPos
	local var_22_6 = arg_22_2.spectreBullet
	local var_22_7
	local var_22_8

	if not arg_22_2.isHeal then
		var_22_8 = {
			damage = -arg_22_1,
			isShare = arg_22_2.isShare,
			miss = var_22_1,
			cri = var_22_2,
			damageSrc = arg_22_2.srcID,
			damageAttr = arg_22_2.attr,
			damageReason = arg_22_2.damageReason,
			isReflect = arg_22_2.isReflect,
			ignoreShield = arg_22_2.ignoreShield
		}

		if not arg_22_2.isShare then
			arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_BEFORE_TAKE_DAMAGE, var_22_8)

			if var_22_8.capFlag then
				arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_DAMAGE_FIX, var_22_8)
			end
		end

		var_22_7 = -var_22_8.damage

		arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_TAKE_DAMAGE, var_22_8)

		if arg_22_0._currentHP <= var_22_8.damage then
			arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_22_1 = -var_22_8.damage

		if var_22_7 ~= -var_22_8.damage then
			({}).absorb = var_22_7 - arg_22_1

			arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_SHIELD_ABSORB, var_22_8)
		end

		if var_0_5.IsInvincible(arg_22_0) and not arg_22_2.ignoreInvincible then
			return 0
		end
	else
		var_22_7 = arg_22_1

		arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_TAKE_HEALING, {
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = arg_22_2.incorrupt
		})

		var_22_3 = ({
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = arg_22_2.incorrupt
		}).isHeal
		arg_22_1 = ({
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = arg_22_2.incorrupt
		}).damage

		local var_22_9 = math.max(0, arg_22_0._currentHP + ({
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = arg_22_2.incorrupt
		}).damage - arg_22_0:GetMaxHP())

		if var_22_9 > 0 then
			arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_OVER_HEALING, {
				overHealing = var_22_9
			})
		end
	end

	local var_22_10 = math.min(arg_22_0:GetMaxHP(), math.max(0, arg_22_0._currentHP + arg_22_1))

	arg_22_0:SetCurrentHP(var_22_10)

	if not var_22_3 then
		var_22_8.validDHP = var_22_10 - arg_22_0._currentHP

		arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_DAMAGE_CONCLUDE, var_22_8)
	end

	if var_22_5 and not var_22_5:EqualZero() then
		local var_22_11 = arg_22_0:GetPosition()
		local var_22_12 = arg_22_0:GetBoxSize().x
		local var_22_13 = var_22_5:Clone()

		var_22_13.x = Mathf.Clamp(var_22_13.x, var_22_11.x - var_22_12, var_22_11.x + var_22_12)
		;({
			preShieldHP = var_22_7,
			dHP = arg_22_1,
			validDHP = var_22_10 - arg_22_0._currentHP,
			isMiss = var_22_1,
			isCri = var_22_2,
			isHeal = var_22_3,
			font = var_22_4
		}).posOffset = var_22_11 - var_22_13
	end

	if not var_22_6 then
		arg_22_0:UpdateHPAction({
			preShieldHP = var_22_7,
			dHP = arg_22_1,
			validDHP = var_22_10 - arg_22_0._currentHP,
			isMiss = var_22_1,
			isCri = var_22_2,
			isHeal = var_22_3,
			font = var_22_4
		})
	end

	if not arg_22_0:IsAlive() and var_22_0 then
		arg_22_0:SetDeathReason(arg_22_2.damageReason)
		arg_22_0:SetDeathSrcID(arg_22_2.srcID)
		arg_22_0:DeadAction()
	end

	if arg_22_0:IsAlive() then
		arg_22_0:TriggerBuff(var_0_2.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_22_1,
			unit = arg_22_0,
			validDHP = var_22_10 - arg_22_0._currentHP
		})
	end

	return arg_22_1
end

function var_0_8.UpdateHPAction(arg_23_0, arg_23_1)
	arg_23_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_HP, arg_23_1))

	return
end

function var_0_8.DeadAction(arg_24_0)
	arg_24_0:TriggerBuff(var_0_2.BuffEffectType.ON_SINK, {})
	arg_24_0:DeacActionClear()

	return
end

function var_0_8.DeacActionClear(arg_25_0)
	arg_25_0._aliveState = false

	var_0_5.Spirit(arg_25_0)
	var_0_5.AppendInvincible(arg_25_0)
	arg_25_0:DeadActionEvent()

	return
end

function var_0_8.DeadActionEvent(arg_26_0)
	arg_26_0:DispatchEvent(var_0.Event.New(var_0_0.WILL_DIE, {}))
	arg_26_0:DispatchEvent(var_0.Event.New(var_0_0.DYING, {}))

	return
end

function var_0_8.SendDeadEvent(arg_27_0)
	arg_27_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.DYING, {}))

	return
end

function var_0_8.SetDeathReason(arg_28_0, arg_28_1)
	arg_28_0._deathReason = arg_28_1

	return
end

function var_0_8.GetDeathReason(arg_29_0)
	return arg_29_0._deathReason or var_0_2.UnitDeathReason.KILLED
end

function var_0_8.SetDeathSrcID(arg_30_0, arg_30_1)
	arg_30_0._deathSrcID = arg_30_1

	return
end

function var_0_8.GetDeathSrcID(arg_31_0)
	return arg_31_0._deathSrcID
end

function var_0_8.DispatchScorePoint(arg_32_0, arg_32_1)
	arg_32_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.UPDATE_SCORE, {
		score = arg_32_1
	}))

	return
end

function var_0_8.SetTemplate(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._tmpID = arg_33_1

	return
end

function var_0_8.GetTemplateID(arg_34_0)
	return arg_34_0._tmpID
end

function var_0_8.SetOverrideLevel(arg_35_0, arg_35_1)
	arg_35_0._overrideLevel = arg_35_1

	return
end

function var_0_8.SetSkinId(arg_36_0)
	return
end

function var_0_8.SetGearScore(arg_37_0, arg_37_1)
	arg_37_0._GS = arg_37_1

	return
end

function var_0_8.GetGearScore(arg_38_0)
	return arg_38_0._GS or 0
end

function var_0_8.GetSkinID(arg_39_0)
	return arg_39_0._tmpID
end

function var_0_8.GetDefaultSkinID(arg_40_0)
	return arg_40_0._tmpID
end

function var_0_8.GetSkinAttachmentInfo(arg_41_0)
	return arg_41_0._orbitSkinIDList
end

function var_0_8.GetWeaponBoundBone(arg_42_0)
	return arg_42_0._tmpData.bound_bone
end

function var_0_8.ActionKeyOffsetUseable(arg_43_0)
	return true
end

function var_0_8.RemoveRemoteBoundBone(arg_44_0, arg_44_1)
	arg_44_0._remoteBoundBone[arg_44_1] = nil

	return
end

function var_0_8.SetRemoteBoundBone(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_0._remoteBoundBone[arg_45_1] or {}

	var_45_0[arg_45_2] = arg_45_3
	arg_45_0._remoteBoundBone[arg_45_1] = var_45_0

	return
end

function var_0_8.GetRemoteBoundBone(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in pairs(arg_46_0._remoteBoundBone) do
		if iter_46_1[arg_46_1] then
			local var_46_0 = var_0.Battle.BattleTargetChoise.TargetFleetIndex(arg_46_0, {
				fleetPos = iter_46_1[arg_46_1]
			})[1]

			if var_46_0 and var_46_0:IsAlive() then
				local var_46_1 = Clone(var_46_0:GetPosition())

				var_46_1:Set(var_46_1.x, 1.5, var_46_1.z)

				return var_46_1
			end
		end
	end

	return
end

function var_0_8.GetLabelTag(arg_47_0)
	return arg_47_0._labelTagList
end

function var_0_8.ContainsLabelTag(arg_48_0, arg_48_1)
	if arg_48_0._labelTagList == nil then
		return false
	end

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		if table.contains(arg_48_0._labelTagList, iter_48_1) then
			return true
		end
	end

	return false
end

function var_0_8.AddLabelTag(arg_49_0, arg_49_1)
	table.insert(arg_49_0._labelTagList, arg_49_1)

	local var_49_0 = var_0_5.GetCurrent(arg_49_0, "labelTag")
	local var_49_1 = var_49_0[arg_49_1] or 0

	var_49_0[arg_49_1] = var_49_1 + 1

	return
end

function var_0_8.RemoveLabelTag(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0._labelTagList) do
		if iter_50_1 == arg_50_1 then
			table.remove(arg_50_0._labelTagList, iter_50_0)

			local var_50_0 = var_0_5.GetCurrent(arg_50_0, "labelTag")

			var_50_0[arg_50_1] = var_50_0[arg_50_1] - 1

			break
		end
	end

	return
end

function var_0_8.setStandardLabelTag(arg_51_0)
	arg_51_0:AddLabelTag("N_" .. arg_51_0._tmpData.nationality)
	arg_51_0:AddLabelTag("T_" .. arg_51_0._tmpData.type)

	return
end

function var_0_8.GetRarity(arg_52_0)
	return
end

function var_0_8.GetIntimacy(arg_53_0)
	return 0
end

function var_0_8.IsBoss(arg_54_0)
	return false
end

function var_0_8.GetSpeedRatio(arg_55_0)
	return var_0_3.GetSpeedRatio(arg_55_0:GetSpeedExemptKey(), arg_55_0._IFF)
end

function var_0_8.GetSpeedExemptKey(arg_56_0)
	return arg_56_0._speedExemptKey
end

function var_0_8.SetMoveCast(arg_57_0, arg_57_1)
	arg_57_0._moveCast = arg_57_1

	return
end

function var_0_8.IsMoveCast(arg_58_0)
	return arg_58_0._moveCast
end

function var_0_8.SetCrash(arg_59_0, arg_59_1)
	arg_59_0._isCrash = arg_59_1

	if arg_59_1 then
		arg_59_0:AddBuff((var_0.Battle.BattleBuffUnit.New(var_0_4.SHIP_CLD_BUFF)))
	else
		arg_59_0:RemoveBuff(var_0_4.SHIP_CLD_BUFF)
	end

	return
end

function var_0_8.IsCrash(arg_60_0)
	return arg_60_0._isCrash
end

function var_0_8.OverrideDeadFX(arg_61_0, arg_61_1)
	arg_61_0._deadFX = arg_61_1

	return
end

function var_0_8.GetDeadFX(arg_62_0)
	return arg_62_0._deadFX
end

function var_0_8.SetEquipment(arg_63_0, arg_63_1)
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

function var_0_8.GetEquipment(arg_64_0)
	return arg_64_0._equipmentList
end

function var_0_8.SetProficiencyList(arg_65_0, arg_65_1)
	arg_65_0._proficiencyList = arg_65_1

	return
end

function var_0_8.SetSpWeapon(arg_66_0, arg_66_1)
	arg_66_0._spWeapon = arg_66_1

	return
end

function var_0_8.GetSpWeapon(arg_67_0)
	return arg_67_0._spWeapon
end

function var_0_8.setWeapon(arg_68_0, arg_68_1)
	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		local var_68_0 = iter_68_1.equipment.weapon_id

		for iter_68_2, iter_68_3 in ipairs(iter_68_1.equipment.weapon_id) do
			if iter_68_3 ~= -1 then
				local var_68_1 = var_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_68_3, arg_68_0, nil, iter_68_0)

				arg_68_0._totalWeapon[#arg_68_0._totalWeapon + 1] = var_68_1

				local var_68_2 = var_68_1:GetTemplateData().type

				if var_68_2 == var_0_2.EquipmentType.MANUAL_TORPEDO then
					arg_68_0._manualTorpedoList[#arg_68_0._manualTorpedoList + 1] = var_68_1

					arg_68_0._weaponQueue:AppendWeapon(var_68_1)
				elseif var_68_2 == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
					-- block empty
				else
					assert(#var_68_0 < 2, "自动武器一组不允许配置多个")
					arg_68_0:AddAutoWeapon(var_68_1)
				end

				if var_68_2 == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or var_68_2 == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
					arg_68_0._hiveList[#arg_68_0._hiveList + 1] = var_68_1
				end

				if var_68_2 == var_0_2.EquipmentType.ANTI_AIR then
					arg_68_0._AAList[#arg_68_0._AAList + 1] = var_68_1
				end
			end
		end
	end

	return
end

function var_0_8.CheckWeaponInitial(arg_69_0)
	arg_69_0._weaponQueue:CheckWeaponInitalCD()

	if arg_69_0._airAssistQueue then
		arg_69_0._airAssistQueue:CheckWeaponInitalCD()
	end

	arg_69_0:DispatchEvent(var_0.Event.New(var_0_0.INIT_COOL_DOWN, {}))

	return
end

function var_0_8.FlushReloadingWeapon(arg_70_0)
	arg_70_0._weaponQueue:FlushWeaponReloadRequire()

	if arg_70_0._airAssistQueue then
		arg_70_0._airAssistQueue:FlushWeaponReloadRequire()
	end

	return
end

function var_0_8.AddNewAutoWeapon(arg_71_0, arg_71_1)
	local var_71_0 = var_0_6.CreateWeaponUnit(arg_71_1, arg_71_0)

	arg_71_0:AddAutoWeapon(var_71_0)
	arg_71_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleBuffEvent.BUFF_EFFECT_NEW_WEAPON, {
		weapon = var_71_0
	}))

	return var_71_0
end

function var_0_8.AddAutoWeapon(arg_72_0, arg_72_1)
	arg_72_0._autoWeaponList[#arg_72_0._autoWeaponList + 1] = arg_72_1

	arg_72_0._weaponQueue:AppendWeapon(arg_72_1)

	return
end

function var_0_8.RemoveAutoWeapon(arg_73_0, arg_73_1)
	arg_73_0._weaponQueue:RemoveWeapon(arg_73_1)

	while 1 <= #arg_73_0._autoWeaponList do
		if arg_73_0._autoWeaponList[1] == arg_73_1 then
			arg_73_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_WEAPON, {
				weapon = arg_73_1
			}))
			table.remove(arg_73_0._autoWeaponList, 1)

			break
		end
	end

	return
end

function var_0_8.RemoveAutoWeaponByWeaponID(arg_74_0, arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(arg_74_0._autoWeaponList) do
		if iter_74_1:GetWeaponId() == arg_74_1 then
			iter_74_1:Clear()
			arg_74_0:RemoveAutoWeapon(iter_74_1)

			break
		end
	end

	return
end

function var_0_8.RemoveAllAutoWeapon(arg_75_0)
	while #arg_75_0._autoWeaponList > 0 do
		arg_75_0._autoWeaponList[#arg_75_0._autoWeaponList]:Clear()
		arg_75_0:RemoveAutoWeapon(arg_75_0._autoWeaponList[#arg_75_0._autoWeaponList])
	end

	return
end

function var_0_8.AddFleetAntiAirWeapon(arg_76_0, arg_76_1)
	return
end

function var_0_8.RemoveFleetAntiAirWeapon(arg_77_0, arg_77_1)
	return
end

function var_0_8.AttachFleetRangeAAWeapon(arg_78_0, arg_78_1)
	arg_78_0._fleetRangeAA = arg_78_1

	arg_78_0:DispatchEvent(var_0.Event.New(var_0_0.CREATE_TEMPORARY_WEAPON, {
		weapon = arg_78_1
	}))

	return
end

function var_0_8.DetachFleetRangeAAWeapon(arg_79_0)
	arg_79_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_WEAPON, {
		weapon = arg_79_0._fleetRangeAA
	}))

	arg_79_0._fleetRangeAA = nil

	return
end

function var_0_8.GetFleetRangeAAWeapon(arg_80_0)
	return arg_80_0._fleetRangeAA
end

function var_0_8.ShiftWeapon(arg_81_0, arg_81_1, arg_81_2)
	for iter_81_0, iter_81_1 in ipairs(arg_81_1) do
		arg_81_0:RemoveAutoWeaponByWeaponID(iter_81_1)
	end

	for iter_81_2, iter_81_3 in ipairs(arg_81_2) do
		arg_81_0:AddNewAutoWeapon(iter_81_3):InitialCD()
	end

	return
end

function var_0_8.ExpandWeaponMount(arg_82_0, arg_82_1)
	if arg_82_1 == "airAssist" then
		var_0_6.ExpandAllinStrike(arg_82_0)
	end

	return
end

function var_0_8.ReduceWeaponMount(arg_83_0, arg_83_1)
	return
end

function var_0_8.CeaseAllWeapon(arg_84_0, arg_84_1)
	arg_84_0._ceaseFire = arg_84_1

	return
end

function var_0_8.IsCease(arg_85_0)
	return arg_85_0._ceaseFire
end

function var_0_8.GetAllWeapon(arg_86_0)
	return arg_86_0._totalWeapon
end

function var_0_8.GetTotalWeapon(arg_87_0)
	return arg_87_0._weaponQueue:GetTotalWeaponUnit()
end

function var_0_8.GetAutoWeapons(arg_88_0)
	return arg_88_0._autoWeaponList
end

function var_0_8.GetChargeList(arg_89_0)
	return arg_89_0._chargeList
end

function var_0_8.GetChargeQueue(arg_90_0)
	return arg_90_0._weaponQueue:GetChargeWeaponQueue()
end

function var_0_8.GetAntiAirWeapon(arg_91_0)
	return arg_91_0._AAList
end

function var_0_8.GetFleetAntiAirList(arg_92_0)
	return arg_92_0._fleetAAList
end

function var_0_8.GetFleetRangeAntiAirList(arg_93_0)
	return arg_93_0._fleetRangeAAList
end

function var_0_8.GetTorpedoList(arg_94_0)
	return arg_94_0._manualTorpedoList
end

function var_0_8.GetTorpedoQueue(arg_95_0)
	return arg_95_0._weaponQueue:GetManualTorpedoQueue()
end

function var_0_8.GetWeaponByIndex(arg_96_0, arg_96_1)
	for iter_96_0, iter_96_1 in ipairs(arg_96_0._totalWeapon) do
		if iter_96_1:GetEquipmentIndex() == arg_96_1 then
			return iter_96_1
		end
	end

	return
end

function var_0_8.GetHiveList(arg_97_0)
	return arg_97_0._hiveList
end

function var_0_8.SetAirAssistList(arg_98_0, arg_98_1)
	arg_98_0._airAssistList = arg_98_1
	arg_98_0._airAssistQueue = var_0.Battle.ManualWeaponQueue.New(arg_98_0:GetManualWeaponParallel()[var_0_2.ManualWeaponIndex.AIR_ASSIST])

	for iter_98_0, iter_98_1 in ipairs(arg_98_0._airAssistList) do
		arg_98_0._airAssistQueue:AppendWeapon(iter_98_1)
	end

	return
end

function var_0_8.GetAirAssistList(arg_99_0)
	return arg_99_0._airAssistList
end

function var_0_8.GetAirAssistQueue(arg_100_0)
	return arg_100_0._airAssistQueue
end

function var_0_8.GetManualWeaponParallel(arg_101_0)
	return {
		1,
		1,
		1
	}
end

function var_0_8.configWeaponQueueParallel(arg_102_0)
	local var_102_0 = arg_102_0:GetManualWeaponParallel()

	arg_102_0._weaponQueue:ConfigParallel(var_102_0[var_0_2.ManualWeaponIndex.CALIBRATION], var_102_0[var_0_2.ManualWeaponIndex.TORPEDO])

	return
end

function var_0_8.ClearWeapon(arg_103_0)
	arg_103_0._weaponQueue:ClearAllWeapon()

	if arg_103_0._airAssistList then
		for iter_103_0, iter_103_1 in ipairs(arg_103_0._airAssistList) do
			iter_103_1:Clear()
		end
	end

	return
end

function var_0_8.GetSpeed(arg_104_0)
	return arg_104_0._move:GetSpeed()
end

function var_0_8.GetPosition(arg_105_0)
	return arg_105_0._move:GetPos()
end

function var_0_8.GetBornPosition(arg_106_0)
	return arg_106_0._bornPos
end

function var_0_8.GetCLDZCenterPosition(arg_107_0)
	if arg_107_0._zCenterFrame ~= arg_107_0._battleProxy.FrameIndex then
		arg_107_0._zCenterFrame = arg_107_0._battleProxy.FrameIndex

		local var_107_0 = arg_107_0:GetCldBox()

		arg_107_0._cldZCenterCache = (var_107_0.min + var_107_0.max) * 0.5
	end

	return arg_107_0._cldZCenterCache
end

function var_0_8.GetBeenAimedPosition(arg_108_0)
	local var_108_0 = arg_108_0:GetCLDZCenterPosition()

	if not var_108_0 then
		return var_108_0
	end

	local var_108_1 = arg_108_0:GetTemplate() and arg_108_0:GetTemplate().aim_offset

	if not var_108_1 then
		return var_108_0
	end

	local var_108_2 = Vector3(var_108_0.x + var_108_1[1], var_108_0.y + var_108_1[2], var_108_0.z + var_108_1[3])

	arg_108_0:biasAimPosition(var_108_2)

	return var_108_2
end

function var_0_8.biasAimPosition(arg_109_0, arg_109_1)
	local var_109_0 = var_0_5.GetCurrent(arg_109_0, "aimBias")

	if var_109_0 > 0 then
		arg_109_1:Set(arg_109_1.x + (math.random() * (var_109_0 * 2) - var_109_0), arg_109_1.y, arg_109_1.z + (math.random() * (var_109_0 * 2) - var_109_0))
	end

	return arg_109_1
end

function var_0_8.CancelFollowTeam(arg_110_0)
	arg_110_0._move:CancelFormationCtrl()

	return
end

function var_0_8.UpdateFormationOffset(arg_111_0, arg_111_1)
	arg_111_0._move:SetFormationCtrlInfo(Vector3(arg_111_1.x, arg_111_1.y, arg_111_1.z))

	return
end

function var_0_8.GetDistance(arg_112_0, arg_112_1)
	if arg_112_0._frame ~= arg_112_0._battleProxy.FrameIndex then
		arg_112_0._distanceBackup = {}
		arg_112_0._frame = arg_112_0._battleProxy.FrameIndex
	end

	local var_112_0 = arg_112_0._distanceBackup[arg_112_1]

	if arg_112_0._distanceBackup[arg_112_1] == nil then
		var_112_0 = Vector3.Distance(arg_112_0:GetPosition(), arg_112_1:GetPosition())
		arg_112_0._distanceBackup[arg_112_1] = var_112_0

		arg_112_1:backupDistance(arg_112_0, var_112_0)
	end

	return var_112_0
end

function var_0_8.backupDistance(arg_113_0, arg_113_1, arg_113_2)
	if arg_113_0._frame ~= arg_113_0._battleProxy.FrameIndex then
		arg_113_0._distanceBackup = {}
		arg_113_0._frame = arg_113_0._battleProxy.FrameIndex
	end

	arg_113_0._distanceBackup[arg_113_1] = arg_113_2

	return
end

function var_0_8.GetDirection(arg_114_0)
	return arg_114_0._dir
end

function var_0_8.SetBornPosition(arg_115_0, arg_115_1)
	arg_115_0._bornPos = arg_115_1

	return
end

function var_0_8.SetPosition(arg_116_0, arg_116_1)
	arg_116_0._move:SetPos(arg_116_1)

	return
end

function var_0_8.IsMoving(arg_117_0)
	local var_117_0 = arg_117_0._move:GetSpeed()

	return var_117_0.x ~= 0 or var_117_0.z ~= 0
end

function var_0_8.SetUncontrollableSpeedWithYAngle(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
	arg_118_0:SetUncontrollableSpeed(Vector3(math.cos(math.deg2Rad * arg_118_1), 0, math.sin(math.deg2Rad * arg_118_1)), arg_118_2, arg_118_3)

	return
end

function var_0_8.SetUncontrollableSpeedWithDir(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	arg_119_0:SetUncontrollableSpeed(arg_119_1 / math.sqrt(arg_119_1.x * arg_119_1.x + arg_119_1.z * arg_119_1.z), arg_119_2, arg_119_3)

	return
end

function var_0_8.SetUncontrollableSpeed(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	if not arg_120_2 or not arg_120_3 then
		return
	end

	arg_120_0._move:SetForceMove(arg_120_1, arg_120_2, arg_120_3, arg_120_2 / arg_120_3)

	return
end

function var_0_8.ClearUncontrollableSpeed(arg_121_0)
	arg_121_0._move:ClearForceMove()

	return
end

function var_0_8.SetAdditiveSpeed(arg_122_0, arg_122_1)
	arg_122_0._move:UpdateAdditiveSpeed(arg_122_1)

	return
end

function var_0_8.RemoveAdditiveSpeed(arg_123_0)
	arg_123_0._move:RemoveAdditiveSpeed()

	return
end

function var_0_8.Boost(arg_124_0, arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)
	arg_124_0._move:SetForceMove(arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)

	return
end

function var_0_8.ActiveUnstoppable(arg_125_0, arg_125_1)
	arg_125_0._move:ActiveUnstoppable(arg_125_1)

	return
end

function var_0_8.SetImmuneCommonBulletCLD(arg_126_0)
	arg_126_0._immuneCommonBulletCLD = true

	return
end

function var_0_8.IsImmuneCommonBulletCLD(arg_127_0)
	return arg_127_0._immuneCommonBulletCLD
end

function var_0_8.SetWeaponPreCastBound(arg_128_0, arg_128_1)
	arg_128_0._preCastBound = arg_128_1

	arg_128_0:UpdatePrecastMoveLimit()

	return
end

function var_0_8.EnterGCD(arg_129_0, arg_129_1, arg_129_2)
	if arg_129_0._GCDTimerList[arg_129_2] ~= nil then
		return
	end

	local function var_129_0()
		arg_129_0:RemoveGCDTimer(arg_129_2)

		return
	end

	arg_129_0._weaponQueue:QueueEnterGCD(arg_129_2, arg_129_1)

	arg_129_0._GCDTimerList[arg_129_2] = pg.TimeMgr.GetInstance():AddBattleTimer("weaponGCD", 0, arg_129_1, var_129_0, true)

	arg_129_0:UpdatePrecastMoveLimit()

	return
end

function var_0_8.RemoveGCDTimer(arg_131_0, arg_131_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_131_0._GCDTimerList[arg_131_1])

	arg_131_0._GCDTimerList[arg_131_1] = nil

	arg_131_0:UpdatePrecastMoveLimit()

	return
end

function var_0_8.UpdatePrecastMoveLimit(arg_132_0)
	arg_132_0:UpdateMoveLimit()

	return
end

function var_0_8.UpdateMoveLimit(arg_133_0)
	arg_133_0._move:SetStaticState(not arg_133_0:IsMoveAble())

	return
end

function var_0_8.AddBuff(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = arg_134_1:GetID()
	local var_134_1 = arg_134_0:GetBuff(var_134_0)

	if var_134_1 then
		if arg_134_2 then
			local var_134_2 = arg_134_0._buffStockList[var_134_0] or {}

			table.insert(var_134_2, arg_134_1)

			arg_134_0._buffStockList[var_134_0] = var_134_2
		else
			({
				unit_id = arg_134_0._uniqueID,
				buff_id = var_134_0
			}).buff_level = math.max(var_134_1:GetLv(), (arg_134_1:GetLv()))

			if var_134_1:IsForceStack() or arg_134_1:GetGroupLevel() <= var_134_1:GetGroupLevel() then
				var_134_1:Stack(arg_134_0)

				;({
					unit_id = arg_134_0._uniqueID,
					buff_id = var_134_0
				}).stack_count = var_134_1:GetStack()

				arg_134_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_STACK, {
					unit_id = arg_134_0._uniqueID,
					buff_id = var_134_0
				}))
			else
				arg_134_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_CAST, {
					unit_id = arg_134_0._uniqueID,
					buff_id = var_134_0
				}))
				arg_134_0:RemoveBuff(var_134_0)

				arg_134_0._buffList[var_134_0] = arg_134_1

				arg_134_1:Attach(arg_134_0)
				arg_134_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_ATTACH, {
					unit_id = arg_134_0._uniqueID,
					buff_id = var_134_0
				}))
			end
		end
	else
		arg_134_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_CAST, {
			unit_id = arg_134_0._uniqueID,
			buff_id = var_134_0
		}))

		arg_134_0._buffList[var_134_0] = arg_134_1

		arg_134_1:Attach(arg_134_0)

		;({
			unit_id = arg_134_0._uniqueID,
			buff_id = var_134_0
		}).buff_level = arg_134_1:GetLv()

		arg_134_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_ATTACH, {
			unit_id = arg_134_0._uniqueID,
			buff_id = var_134_0
		}))
	end

	arg_134_0:TriggerBuff(var_0_2.BuffEffectType.ON_BUFF_ADDED, {
		buffID = var_134_0
	})

	return
end

function var_0_8.SetBuffStack(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	if arg_135_3 <= 0 then
		arg_135_0:RemoveBuff(arg_135_1)
	else
		local var_135_0 = arg_135_0:GetBuff(arg_135_1)

		if var_135_0 then
			var_135_0:UpdateStack(arg_135_0, arg_135_3)

			return var_135_0
		else
			local var_135_1 = var_0.Battle.BattleBuffUnit.New(arg_135_1, arg_135_2)

			arg_135_0:AddBuff(var_135_1)
			var_135_1:UpdateStack(arg_135_0, arg_135_3)

			return var_135_1
		end
	end

	return
end

function var_0_8.UpdateBuff(arg_136_0, arg_136_1)
	for iter_136_0, iter_136_1 in pairs(arg_136_0._buffList) do
		iter_136_1:Update(arg_136_0, arg_136_1)

		if not arg_136_0:IsAlive() then
			break
		end
	end

	return
end

function var_0_8.ConsumeBuffStack(arg_137_0, arg_137_1, arg_137_2)
	local var_137_0 = arg_137_0:GetBuff(arg_137_1)

	if var_137_0 then
		if not arg_137_2 then
			arg_137_0:RemoveBuff(arg_137_1)
		else
			local var_137_1 = math.max(0, var_137_0:GetStack() - arg_137_2)

			if var_137_1 == 0 then
				arg_137_0:RemoveBuff(arg_137_1)
			else
				var_137_0:UpdateStack(arg_137_0, var_137_1)
			end
		end
	end

	return
end

function var_0_8.RemoveBuff(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_2 and arg_138_0._buffStockList[arg_138_1] then
		local var_138_0 = table.remove(arg_138_0._buffStockList[arg_138_1])

		if var_138_0 then
			var_138_0:Clear()

			return
		end
	end

	local var_138_1 = arg_138_0:GetBuff(arg_138_1)

	if var_138_1 then
		var_138_1:Remove()
	end

	arg_138_0:TriggerBuff(var_0_2.BuffEffectType.ON_BUFF_REMOVED, {
		buffID = arg_138_1
	})

	return
end

function var_0_8.ClearBuff(arg_139_0)
	for iter_139_0, iter_139_1 in pairs(arg_139_0._buffList) do
		iter_139_1:Clear()
	end

	for iter_139_2, iter_139_3 in pairs(arg_139_0._buffStockList) do
		for iter_139_4, iter_139_5 in pairs(iter_139_3) do
			iter_139_5:Clear()
		end
	end

	return
end

function var_0_8.TriggerBuff(arg_140_0, arg_140_1, arg_140_2)
	var_0.Battle.BattleBuffUnit.Trigger(arg_140_0, arg_140_1, arg_140_2)

	return
end

function var_0_8.GetBuffList(arg_141_0)
	return arg_141_0._buffList
end

function var_0_8.GetBuff(arg_142_0, arg_142_1)
	arg_142_0._buffList = arg_142_0._buffList

	return arg_142_0._buffList[arg_142_1]
end

function var_0_8.DispatchSkillFloat(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	arg_143_0:DispatchEvent(var_0.Event.New(var_0_0.SKILL_FLOAT, {
		coverHrzIcon = arg_143_3,
		commander = arg_143_2,
		skillName = arg_143_1
	}))

	return
end

function var_0_8.DispatchCutIn(arg_144_0, arg_144_1, arg_144_2)
	arg_144_0:DispatchEvent(var_0.Event.New(var_0_0.CUT_INT, {
		caster = arg_144_0,
		skill = arg_144_1
	}))

	return
end

function var_0_8.DispatchCastClock(arg_145_0, arg_145_1, arg_145_2, arg_145_3, arg_145_4, arg_145_5)
	arg_145_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_BUFF_CLOCK, {
		isActive = arg_145_1,
		buffEffect = arg_145_2,
		iconType = arg_145_3,
		interrupt = arg_145_4,
		reverse = arg_145_5
	}))

	return
end

function var_0_8.SetAI(arg_146_0, arg_146_1)
	arg_146_0._autoPilotAI = var_0.Battle.AutoPilot.New(arg_146_0, (var_0_6.GetAITmpDataFromID(arg_146_1))), arg_146_0._move:CancelFormationCtrl()

	return
end

function var_0_8.AddPhaseSwitcher(arg_147_0, arg_147_1)
	arg_147_0._phaseSwitcher = arg_147_1

	return
end

function var_0_8.GetPhaseSwitcher(arg_148_0)
	return arg_148_0._phaseSwitcher
end

function var_0_8.StateChange(arg_149_0, arg_149_1, arg_149_2)
	arg_149_0._unitState:ChangeState(arg_149_1, arg_149_2)

	return
end

function var_0_8.UpdateAction(arg_150_0)
	local var_150_0 = arg_150_0:GetSpeed().x * arg_150_0._IFF

	if arg_150_0._oxyState and arg_150_0._oxyState:GetCurrentDiveState() == var_0_2.OXY_STATE.DIVE then
		if var_150_0 >= 0 then
			arg_150_0._unitState:ChangeState(var_0_7.STATE_DIVE)
		else
			arg_150_0._unitState:ChangeState(var_0_7.STATE_DIVELEFT)
		end
	elseif var_150_0 >= 0 then
		arg_150_0._unitState:ChangeState(var_0_7.STATE_MOVE)
	else
		arg_150_0._unitState:ChangeState(var_0_7.STATE_MOVELEFT)
	end

	return
end

function var_0_8.SetActionKeyOffset(arg_151_0, arg_151_1)
	arg_151_0._actionKeyOffset = arg_151_1

	arg_151_0._unitState:FreshActionKeyOffset()

	return
end

function var_0_8.GetActionKeyOffset(arg_152_0)
	return arg_152_0._actionKeyOffset
end

function var_0_8.GetCurrentState(arg_153_0)
	return arg_153_0._unitState:GetCurrentStateName()
end

function var_0_8.NeedWeaponCache(arg_154_0)
	return arg_154_0._unitState:NeedWeaponCache()
end

function var_0_8.CharacterActionTriggerCallback(arg_155_0)
	arg_155_0._unitState:OnActionTrigger()

	return
end

function var_0_8.CharacterActionEndCallback(arg_156_0)
	arg_156_0._unitState:OnActionEnd()

	return
end

function var_0_8.CharacterActionStartCallback(arg_157_0)
	return
end

function var_0_8.DispatchChat(arg_158_0, arg_158_1, arg_158_2, arg_158_3)
	if not arg_158_1 or #arg_158_1 == 0 then
		return
	end

	arg_158_0:DispatchEvent(var_0.Event.New(var_0_0.POP_UP, {
		content = HXSet.hxLan(arg_158_1),
		duration = arg_158_2,
		key = arg_158_3
	}))

	return
end

function var_0_8.DispatchVoice(arg_159_0, arg_159_1)
	local var_159_0, var_159_1, var_159_2 = ShipWordHelper.GetWordAndCV(arg_159_0:GetSkinID(), arg_159_1, 1, true, (arg_159_0:GetIntimacy()))

	if var_159_1 then
		arg_159_0:DispatchEvent(var_0.Event.New(var_0_0.VOICE, {
			content = var_159_1,
			key = arg_159_1
		}))
	end

	return
end

function var_0_8.GetHostileCldList(arg_160_0)
	return arg_160_0._hostileCldList
end

function var_0_8.AppendHostileCld(arg_161_0, arg_161_1, arg_161_2)
	arg_161_0._hostileCldList[arg_161_1] = arg_161_2

	return
end

function var_0_8.RemoveHostileCld(arg_162_0, arg_162_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_162_0._hostileCldList[arg_162_1])

	arg_162_0._hostileCldList[arg_162_1] = nil

	return
end

function var_0_8.GetExtraInfo(arg_163_0)
	return arg_163_0._extraInfo
end

function var_0_8.GetTemplate(arg_164_0)
	return nil
end

function var_0_8.GetGroupID(arg_165_0)
	return nil
end

function var_0_8.GetTemplateValue(arg_166_0, arg_166_1)
	return arg_166_0:GetTemplate()[arg_166_1]
end

function var_0_8.GetUniqueID(arg_167_0)
	return arg_167_0._uniqueID
end

function var_0_8.SetIFF(arg_168_0, arg_168_1)
	arg_168_0._IFF = arg_168_1

	if arg_168_1 == var_0_4.FRIENDLY_CODE then
		arg_168_0._dir = var_0_2.UnitDir.RIGHT
	elseif arg_168_1 == var_0_4.FOE_CODE then
		arg_168_0._dir = var_0_2.UnitDir.LEFT
	end

	return
end

function var_0_8.GetIFF(arg_169_0)
	return arg_169_0._IFF
end

function var_0_8.GetUnitType(arg_170_0)
	return arg_170_0._type
end

function var_0_8.GetHPRate(arg_171_0)
	return arg_171_0._currentHPRate
end

function var_0_8.GetHP(arg_172_0)
	local var_172_1 = arg_172_0:GetMaxHP()
end

function var_0_8.GetCurrentHP(arg_173_0)
	return arg_173_0._currentHP
end

function var_0_8.SetCurrentHP(arg_174_0, arg_174_1)
	arg_174_0._currentHP = arg_174_1
	arg_174_0._currentHPRate = arg_174_0._currentHP / arg_174_0:GetMaxHP()
	arg_174_0._currentDMGRate = 1 - arg_174_0._currentHPRate

	var_0_5.SetCurrent(arg_174_0, "HPRate", arg_174_0._currentHPRate)
	var_0_5.SetCurrent(arg_174_0, "DMGRate", arg_174_0._currentDMGRate)

	return
end

function var_0_8.GetAttr(arg_175_0)
	return var_0_5.GetAttr(arg_175_0)
end

function var_0_8.GetAttrByName(arg_176_0, arg_176_1)
	return var_0_5.GetCurrent(arg_176_0, arg_176_1)
end

function var_0_8.GetMaxHP(arg_177_0)
	return arg_177_0:GetAttrByName("maxHP")
end

function var_0_8.GetReload(arg_178_0)
	return arg_178_0:GetAttrByName("loadSpeed")
end

function var_0_8.GetTorpedoPower(arg_179_0)
	return arg_179_0:GetAttrByName("torpedoPower")
end

function var_0_8.CanDoAntiSub(arg_180_0)
	return arg_180_0:GetAttrByName("antiSubPower") > 0
end

function var_0_8.IsShowHPBar(arg_181_0)
	return false
end

function var_0_8.IsAlive(arg_182_0)
	return arg_182_0._aliveState and arg_182_0:GetCurrentHP() > 0
end

function var_0_8.SetMainFleetUnit(arg_183_0)
	arg_183_0._isMainFleetUnit = true

	arg_183_0:SetMainUnitStatic(true)

	return
end

function var_0_8.IsMainFleetUnit(arg_184_0)
	return arg_184_0._isMainFleetUnit
end

function var_0_8.SetMainUnitStatic(arg_185_0, arg_185_1)
	arg_185_0._isMainStatic = arg_185_1

	arg_185_0._move:SetStaticState(arg_185_1)

	return
end

function var_0_8.SetMainUnitIndex(arg_186_0, arg_186_1)
	arg_186_0._mainUnitIndex = arg_186_1

	return
end

function var_0_8.GetMainUnitIndex(arg_187_0)
	return arg_187_0._mainUnitIndex or 1
end

function var_0_8.IsMoveAble(arg_188_0)
	local var_188_0 = table.getCount(arg_188_0._GCDTimerList) > 0 or arg_188_0._preCastBound
	local var_188_1 = var_0_5.IsStun(arg_188_0)
	local var_188_2 = arg_188_0:IsMoveCast()

	return not arg_188_0._isMainStatic and (var_188_2 or not var_188_0) and not var_188_1
end

function var_0_8.Reinforce(arg_189_0)
	arg_189_0._isReinforcement = true

	return
end

function var_0_8.IsReinforcement(arg_190_0)
	return arg_190_0._isReinforcement
end

function var_0_8.SetReinforceCastTime(arg_191_0, arg_191_1)
	arg_191_0._reinforceCastTime = arg_191_1

	return
end

function var_0_8.GetReinforceCastTime(arg_192_0)
	return arg_192_0._reinforceCastTime
end

function var_0_8.GetFleetVO(arg_193_0)
	return
end

function var_0_8.SetFormationIndex(arg_194_0, arg_194_1)
	return
end

function var_0_8.SetMaster(arg_195_0)
	return
end

function var_0_8.GetMaster(arg_196_0)
	return nil
end

function var_0_8.IsSpectre(arg_197_0)
	return
end

function var_0_8.Clear(arg_198_0)
	arg_198_0._aliveState = false

	for iter_198_0, iter_198_1 in pairs(arg_198_0._hostileCldList) do
		arg_198_0:RemoveHostileCld(iter_198_0)
	end

	arg_198_0:ClearWeapon()
	arg_198_0:ClearBuff()

	arg_198_0._distanceBackup = {}

	return
end

function var_0_8.Dispose(arg_199_0)
	arg_199_0._exposedList = nil
	arg_199_0._phaseSwitcher = nil

	arg_199_0._weaponQueue:Dispose()

	if arg_199_0._airAssistQueue then
		arg_199_0._airAssistQueue:Clear()

		arg_199_0._airAssistQueue = nil
	end

	arg_199_0._equipmentList = nil
	arg_199_0._totalWeapon = nil

	if arg_199_0._airAssistList then
		for iter_199_0, iter_199_1 in ipairs(arg_199_0._airAssistList) do
			iter_199_1:Dispose()
		end
	end

	for iter_199_2, iter_199_3 in ipairs(arg_199_0._fleetAAList) do
		iter_199_3:Dispose()
	end

	for iter_199_4, iter_199_5 in ipairs(arg_199_0._fleetRangeAAList) do
		iter_199_5:Dispose()
	end

	for iter_199_6, iter_199_7 in pairs(arg_199_0._buffList) do
		iter_199_7:Dispose()
	end

	for iter_199_8, iter_199_9 in pairs(arg_199_0._buffStockList) do
		for iter_199_10, iter_199_11 in pairs(iter_199_9) do
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

function var_0_8.InitCldComponent(arg_200_0)
	local var_200_0 = arg_200_0:GetTemplate().cld_box
	local var_200_1 = arg_200_0:GetTemplate().cld_offset
	local var_200_2 = var_200_1[1]

	if arg_200_0:GetDirection() == var_0_2.UnitDir.LEFT then
		var_200_2 = var_200_2 * -1
	end

	arg_200_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(var_200_0[1], var_200_0[2], var_200_0[3], var_200_2, var_200_1[3] + var_200_0[3] / 2)

	return
end

function var_0_8.GetBoxSize(arg_201_0)
	return arg_201_0._cldComponent:GetCldBoxSize()
end

function var_0_8.GetCldBox(arg_202_0)
	return arg_202_0._cldComponent:GetCldBox(arg_202_0:GetPosition())
end

function var_0_8.GetCldData(arg_203_0)
	return arg_203_0._cldComponent:GetCldData()
end

function var_0_8.ShiftCldComponent(arg_204_0, arg_204_1, arg_204_2)
	arg_204_0:updateCldComponet(arg_204_1, arg_204_2)

	return
end

function var_0_8.ResetCldComponent(arg_205_0)
	arg_205_0:updateCldComponet(arg_205_0:GetTemplate().cld_box, arg_205_0:GetTemplate().cld_offset)

	return
end

function var_0_8.updateCldComponet(arg_206_0, arg_206_1, arg_206_2)
	local var_206_0 = arg_206_2[1]

	if arg_206_0:GetDirection() == var_0_2.UnitDir.LEFT then
		var_206_0 = var_206_0 * -1
	end

	arg_206_0._cldComponent:ResetOffset(var_206_0, arg_206_2[3] + arg_206_1[3] / 2)
	arg_206_0._cldComponent:ResetSize(arg_206_1[1], arg_206_1[2], arg_206_1[3])

	return
end

function var_0_8.InitOxygen(arg_207_0)
	arg_207_0._maxOxy = arg_207_0:GetAttrByName("oxyMax")
	arg_207_0._currentOxy = arg_207_0:GetAttrByName("oxyMax")
	arg_207_0._oxyRecovery = arg_207_0:GetAttrByName("oxyRecovery")
	arg_207_0._oxyRecoveryBench = arg_207_0:GetAttrByName("oxyRecoveryBench")
	arg_207_0._oxyRecoverySurface = arg_207_0:GetAttrByName("oxyRecoverySurface")
	arg_207_0._oxyConsume = arg_207_0:GetAttrByName("oxyCost")
	arg_207_0._oxyState = var_0.Battle.OxyState.New(arg_207_0)

	arg_207_0._oxyState:OnDiveState()
	arg_207_0:ConfigBubbleFX()

	return arg_207_0._oxyState
end

function var_0_8.UpdateOxygen(arg_208_0, arg_208_1)
	if arg_208_0._oxyState then
		arg_208_0._lastOxyUpdateStamp = arg_208_0._lastOxyUpdateStamp or arg_208_1

		arg_208_0._oxyState:UpdateOxygen()

		if arg_208_0._oxyState:GetNextBubbleStamp() and arg_208_1 > arg_208_0._oxyState:GetNextBubbleStamp() then
			arg_208_0._oxyState:FlashBubbleStamp(arg_208_1)
			arg_208_0:PlayFX(arg_208_0._bubbleFX, true)
		end

		arg_208_0._lastOxyUpdateStamp = arg_208_1

		arg_208_0:updateSonarExposeTag()
	end

	return
end

function var_0_8.OxyRecover(arg_209_0, arg_209_1)
	local var_209_0 = arg_209_1 == var_0.Battle.OxyState.STATE_FREE_BENCH and arg_209_0._oxyRecoveryBench or arg_209_1 == var_0.Battle.OxyState.STATE_FREE_FLOAT and arg_209_0._oxyRecovery or arg_209_0._oxyRecoverySurface
	local var_209_1 = pg.TimeMgr.GetInstance()

	arg_209_0._currentOxy = math.min(arg_209_0._maxOxy, arg_209_0._currentOxy + var_209_0 * (var_209_1:GetCombatTime() - arg_209_0._lastOxyUpdateStamp))

	return
end

function var_0_8.OxyConsume(arg_210_0)
	arg_210_0._currentOxy = math.max(0, arg_210_0._currentOxy - arg_210_0._oxyConsume * (pg.TimeMgr.GetInstance():GetCombatTime() - arg_210_0._lastOxyUpdateStamp))

	return
end

function var_0_8.ChangeOxygenState(arg_211_0, arg_211_1)
	arg_211_0._oxyState:ChangeState(arg_211_1)

	return
end

function var_0_8.ChangeWeaponDiveState(arg_212_0)
	for iter_212_0, iter_212_1 in ipairs(arg_212_0._autoWeaponList) do
		iter_212_1:ChangeDiveState()
	end

	return
end

function var_0_8.GetOxygenProgress(arg_213_0)
	return arg_213_0._currentOxy / arg_213_0._maxOxy
end

function var_0_8.GetCuurentOxygen(arg_214_0)
	return arg_214_0._currentOxy or 0
end

function var_0_8.ConfigBubbleFX(arg_215_0)
	return
end

function var_0_8.SetDiveInvisible(arg_216_0, arg_216_1)
	arg_216_0._diveInvisible = arg_216_1

	arg_216_0:DispatchEvent(var_0.Event.New(var_0_0.SUBMARINE_VISIBLE))
	arg_216_0:DispatchEvent(var_0.Event.New(var_0_0.SUBMARINE_DETECTED))
	arg_216_0:dispatchDetectedTrigger()

	return
end

function var_0_8.GetDiveInvisible(arg_217_0)
	return arg_217_0._diveInvisible
end

function var_0_8.GetOxygenVisible(arg_218_0)
	return arg_218_0._oxyState and arg_218_0._oxyState:GetBarVisible()
end

function var_0_8.SetForceVisible(arg_219_0)
	arg_219_0:DispatchEvent(var_0.Event.New(var_0_0.SUBMARINE_FORCE_DETECTED))

	return
end

function var_0_8.Detected(arg_220_0, arg_220_1)
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
		arg_220_0:DispatchEvent(var_0.Event.New(var_0_0.SUBMARINE_DETECTED, {}))
		arg_220_0:dispatchDetectedTrigger()
	end

	return
end

function var_0_8.Undetected(arg_221_0)
	arg_221_0._exposedToSnoar = false

	arg_221_0:updateExposeTimeStamp(var_0_4.SUB_EXPOSE_LASTING_DURATION)

	return
end

function var_0_8.RemoveSonarExpose(arg_222_0)
	arg_222_0._exposedToSnoar = false
	arg_222_0._exposedOverTimeStamp = nil

	return
end

function var_0_8.updateSonarExposeTag(arg_223_0)
	if arg_223_0._exposedOverTimeStamp and not arg_223_0._exposedToSnoar then
		if pg.TimeMgr.GetInstance():GetCombatTime() > arg_223_0._exposedOverTimeStamp then
			arg_223_0._exposedOverTimeStamp = nil

			arg_223_0:DispatchEvent(var_0.Event.New(var_0_0.SUBMARINE_DETECTED, {
				detected = false
			}))
			arg_223_0:dispatchDetectedTrigger()
		end
	end

	return
end

function var_0_8.updateExposeTimeStamp(arg_224_0, arg_224_1)
	local var_224_0 = pg.TimeMgr.GetInstance():GetCombatTime() + arg_224_1

	arg_224_0._exposedOverTimeStamp = arg_224_0._exposedOverTimeStamp or 0

	if var_224_0 < arg_224_0._exposedOverTimeStamp then
		arg_224_0._exposedOverTimeStamp = arg_224_0._exposedOverTimeStamp or var_224_0

		return
	end
end

function var_0_8.IsRunMode(arg_225_0)
	return arg_225_0._oxyState and arg_225_0._oxyState:GetRundMode()
end

function var_0_8.GetDiveDetected(arg_226_0)
	local var_226_0 = arg_226_0:GetDiveInvisible()

	if var_226_0 then
		var_226_0 = arg_226_0._exposedOverTimeStamp or arg_226_0._exposedToSnoar
	end

	return var_226_0
end

function var_0_8.GetForceExpose(arg_227_0)
	return arg_227_0._oxyState and arg_227_0._oxyState:GetForceExpose()
end

function var_0_8.dispatchDetectedTrigger(arg_228_0)
	if arg_228_0:GetDiveDetected() then
		arg_228_0:TriggerBuff(var_0_2.BuffEffectType.ON_SUB_DETECTED, {})
	else
		arg_228_0:TriggerBuff(var_0_2.BuffEffectType.ON_SUB_UNDETECTED, {})
	end

	return
end

function var_0_8.GetRaidDuration(arg_229_0)
	return arg_229_0:GetAttrByName("oxyMax") / arg_229_0:GetAttrByName("oxyCost")
end

function var_0_8.EnterRaidRange(arg_230_0)
	if arg_230_0:GetPosition().x > arg_230_0._subRaidLine then
		return true
	else
		return false
	end

	return
end

function var_0_8.EnterRetreatRange(arg_231_0)
	if arg_231_0:GetPosition().x < arg_231_0._subRetreatLine then
		return true
	else
		return false
	end

	return
end

function var_0_8.GetOxyState(arg_232_0)
	return arg_232_0._oxyState
end

function var_0_8.GetCurrentOxyState(arg_233_0)
	if not arg_233_0._oxyState then
		return var_0_2.OXY_STATE.FLOAT
	else
		return arg_233_0._oxyState:GetCurrentDiveState()
	end

	return
end

function var_0_8.InitAntiSubState(arg_234_0, arg_234_1, arg_234_2)
	arg_234_0._antiSubVigilanceState = var_0.Battle.AntiSubState.New(arg_234_0)

	arg_234_0:DispatchEvent(var_0.Event.New(var_0_0.INIT_ANIT_SUB_VIGILANCE, {
		sonarRange = arg_234_1
	}))

	return arg_234_0._antiSubVigilanceState
end

function var_0_8.GetAntiSubState(arg_235_0)
	return arg_235_0._antiSubVigilanceState
end

function var_0_8.UpdateBlindInvisibleBySpectre(arg_236_0)
	local var_236_0, var_236_1 = arg_236_0:IsSpectre()

	if var_236_1 <= var_0_4.SPECTRE_UNIT_TYPE and var_236_1 ~= var_0_4.VISIBLE_SPECTRE_UNIT_TYPE then
		arg_236_0:SetBlindInvisible(true)
	else
		arg_236_0:SetBlindInvisible(false)
	end

	return
end

function var_0_8.SetBlindInvisible(arg_237_0, arg_237_1)
	if arg_237_1 then
		local var_237_0 = {}

		if not {} then
			var_237_0 = nil
		end

		arg_237_0._exposedList = var_237_0
		arg_237_0._blindInvisible = arg_237_1

		arg_237_0:DispatchEvent(var_0.Event.New(var_0_0.BLIND_VISIBLE))

		return
	end
end

function var_0_8.GetBlindInvisible(arg_238_0)
	return arg_238_0._blindInvisible
end

function var_0_8.GetExposed(arg_239_0)
	if not arg_239_0._blindInvisible then
		return true
	end

	for iter_239_0, iter_239_1 in pairs(arg_239_0._exposedList) do
		return true
	end

	return
end

function var_0_8.AppendExposed(arg_240_0, arg_240_1)
	if not arg_240_0._blindInvisible then
		return
	end

	local var_240_0 = arg_240_0._exposedList[arg_240_1]

	arg_240_0._exposedList[arg_240_1] = true

	if not var_240_0 then
		arg_240_0:DispatchEvent(var_0.Event.New(var_0_0.BLIND_EXPOSE))
	end

	return
end

function var_0_8.RemoveExposed(arg_241_0, arg_241_1)
	if not arg_241_0._blindInvisible then
		return
	end

	arg_241_0._exposedList[arg_241_1] = nil

	arg_241_0:DispatchEvent(var_0.Event.New(var_0_0.BLIND_EXPOSE))

	return
end

function var_0_8.SetWorldDeathMark(arg_242_0)
	arg_242_0._worldDeathMark = true

	return
end

function var_0_8.GetWorldDeathMark(arg_243_0)
	return arg_243_0._worldDeathMark
end

function var_0_8.InitCloak(arg_244_0)
	arg_244_0._cloak = var_0.Battle.BattleUnitCloakComponent.New(arg_244_0)

	arg_244_0:DispatchEvent(var_0.Event.New(var_0_0.INIT_CLOAK))

	return arg_244_0._cloak
end

function var_0_8.CloakOnFire(arg_245_0, arg_245_1)
	if arg_245_0._cloak then
		arg_245_0._cloak:UpdateDotExpose(arg_245_1)
	end

	return
end

function var_0_8.CloakExpose(arg_246_0, arg_246_1)
	if arg_246_0._cloak then
		arg_246_0._cloak:AppendExpose(arg_246_1)
	end

	return
end

function var_0_8.StrikeExpose(arg_247_0)
	if arg_247_0._cloak then
		arg_247_0._cloak:AppendStrikeExpose()
	end

	return
end

function var_0_8.BombardExpose(arg_248_0)
	if arg_248_0._cloak then
		arg_248_0._cloak:AppendBombardExpose()
	end

	return
end

function var_0_8.UpdateCloak(arg_249_0, arg_249_1)
	arg_249_0._cloak:Update(arg_249_1)

	return
end

function var_0_8.UpdateCloakConfig(arg_250_0)
	if arg_250_0._cloak then
		arg_250_0._cloak:UpdateCloakConfig()
		arg_250_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_CLOAK_CONFIG))
	end

	return
end

function var_0_8.DispatchCloakStateUpdate(arg_251_0)
	if arg_251_0._cloak then
		arg_251_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_CLOAK_STATE))
	end

	return
end

function var_0_8.GetCloak(arg_252_0)
	return arg_252_0._cloak
end

function var_0_8.AttachAimBias(arg_253_0, arg_253_1)
	arg_253_0._aimBias = arg_253_1

	arg_253_0:DispatchEvent(var_0.Event.New(var_0_0.INIT_AIMBIAS))

	return
end

function var_0_8.DetachAimBias(arg_254_0)
	arg_254_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIMBIAS))
	arg_254_0._aimBias:RemoveCrew(arg_254_0)

	arg_254_0._aimBias = nil

	return
end

function var_0_8.ExitSmokeArea(arg_255_0)
	arg_255_0._aimBias:SmokeExitPause()

	return
end

function var_0_8.UpdateAimBiasSkillState(arg_256_0)
	if arg_256_0._aimBias and arg_256_0._aimBias:GetHost() == arg_256_0 then
		arg_256_0._aimBias:UpdateSkillLock()
	end

	return
end

function var_0_8.HostAimBias(arg_257_0)
	if arg_257_0._aimBias then
		arg_257_0:DispatchEvent(var_0.Event.New(var_0_0.HOST_AIMBIAS))
	end

	return
end

function var_0_8.GetAimBias(arg_258_0)
	return arg_258_0._aimBias
end

function var_0_8.SwitchSpine(arg_259_0, arg_259_1, arg_259_2)
	arg_259_0:DispatchEvent(var_0.Event.New(var_0_0.SWITCH_SPINE, {
		skin = arg_259_1,
		HPBarOffset = arg_259_2
	}))

	return
end

function var_0_8.Freeze(arg_260_0)
	for iter_260_0, iter_260_1 in ipairs(arg_260_0._totalWeapon) do
		iter_260_1:StartJamming()
	end

	if arg_260_0._airAssistList then
		for iter_260_2, iter_260_3 in ipairs(arg_260_0._airAssistList) do
			iter_260_3:StartJamming()
		end
	end

	return
end

function var_0_8.ActiveFreeze(arg_261_0)
	for iter_261_0, iter_261_1 in ipairs(arg_261_0._totalWeapon) do
		iter_261_1:JammingEliminate()
	end

	if arg_261_0._airAssistList then
		for iter_261_2, iter_261_3 in ipairs(arg_261_0._airAssistList) do
			iter_261_3:JammingEliminate()
		end
	end

	return
end

function var_0_8.ActiveWeaponSectorView(arg_262_0, arg_262_1, arg_262_2)
	arg_262_0:DispatchEvent(var_0.Event.New(var_0_0.WEAPON_SECTOR, {
		weapon = arg_262_1,
		isActive = arg_262_2
	}))

	return
end

return
