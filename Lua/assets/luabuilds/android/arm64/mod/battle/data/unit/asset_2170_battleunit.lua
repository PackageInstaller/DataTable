ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleBuffEvent
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleVariable
local var_0_5 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleAttr
local var_0_7 = ys.Battle.BattleDataFunction
local var_0_8 = ys.Battle.UnitState
local BattleUnit = class("BattleUnit")

ys.Battle.BattleUnit = BattleUnit
BattleUnit.__name = "BattleUnit"

function BattleUnit:Ctor(arg_1_1, arg_1_2)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._uniqueID = arg_1_1
	self._speedExemptKey = "unit_" .. arg_1_1
	self._unitState = var_0_0.Battle.UnitState.New(self)
	self._move = var_0_0.Battle.MoveComponent.New()
	self._weaponQueue = var_0_0.Battle.WeaponQueue.New()

	self:Init()
	self:SetIFF(arg_1_2)

	self._distanceBackup = {}
	self._battleProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._frame = 0

	return
end

function BattleUnit:Retreat()
	self:TriggerBuff(var_0_3.BuffEffectType.ON_RETREAT, {})

	return
end

function BattleUnit:SetMotion(arg_3_1)
	self._move:SetMotionVO(arg_3_1)

	return
end

function BattleUnit:SetBound(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	self._move:SetCorpsArea(arg_4_5, arg_4_6)
	self._move:SetBorder(arg_4_3, arg_4_4, arg_4_1, arg_4_2)

	return
end

function BattleUnit:ActiveCldBox()
	self._cldComponent:SetActive(true)

	return
end

function BattleUnit:DeactiveCldBox()
	self._cldComponent:SetActive(false)

	return
end

function BattleUnit:SetCldBoxImmune(arg_7_1)
	self._cldComponent:SetImmuneCLD(arg_7_1)

	return
end

function BattleUnit:Init()
	self._hostileCldList = {}
	self._currentHPRate = 1
	self._currentDMGRate = 0
	self._tagCount = 0
	self._tagIndex = 0
	self._tagList = {}
	self._aliveState = true
	self._isMainFleetUnit = false
	self._bulletCache = {}
	self._speed = Vector3.zero
	self._dir = var_0_3.UnitDir.RIGHT
	self._extraInfo = {}
	self._GCDTimerList = {}
	self._buffList = {}
	self._buffStockList = {}
	self._labelTagList = {}
	self._exposedToSnoar = false
	self._moveCast = true
	self._remoteBoundBone = {}

	return
end

function BattleUnit:Update(arg_9_1)
	if self:IsAlive() and not self._isSickness then
		self._move:Update()
		self._move:FixSpeed(self._cldComponent)
		self._move:Move(self:GetSpeedRatio())
	end

	self:UpdateAction()

	return
end

function BattleUnit:UpdateWeapon(arg_10_1)
	if not self:IsAlive() or self._isSickness then
		return
	end

	if not self._antiSubVigilanceState or self._antiSubVigilanceState:IsWeaponUseable() then
		local var_10_0 = self._move:GetPos()

		if (self._weaponRightBound == nil or self._weaponRightBound > var_10_0.x) and (self._weaponLowerBound == nil or self._weaponLowerBound < var_10_0.z) then
			self._weaponQueue:Update(arg_10_1)
		end
	end

	if not self:IsAlive() then
		return
	end

	self:UpdateBuff(arg_10_1)

	return
end

function BattleUnit:UpdateAirAssist()
	if self._airAssistList then
		for iter_11_0, iter_11_1 in ipairs(self._airAssistList) do
			iter_11_1:Update()
		end
	end

	return
end

function BattleUnit:UpdatePhaseSwitcher()
	if self._phaseSwitcher then
		self._phaseSwitcher:Update()
	end

	return
end

function BattleUnit:SetInterruptSickness(arg_13_1)
	self._isSickness = arg_13_1

	return
end

function BattleUnit:SummonSickness(arg_14_1)
	if self._isSickness == true then
		return
	end

	self._isSickness = true
	self._sicknessTimer = pg.TimeMgr.GetInstance():AddBattleTimer("summonSickness", 0, arg_14_1, function()
		self:RemoveSummonSickness()

		return
	end, true)

	return
end

function BattleUnit:RemoveSummonSickness()
	self._isSickness = false

	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._sicknessTimer)

	self._sicknessTimer = nil

	return
end

function BattleUnit:GetTargetedPriority()
	local var_17_0

	if self._aimBias then
		local var_17_1 = self._aimBias:GetCurrentState()

		var_17_0 = (var_17_1 == self._aimBias.STATE_SKILL_EXPOSE or var_17_1 == self._aimBias.STATE_TOTAL_EXPOSE) and self:GetTemplate().battle_unit_type or -200
	else
		var_17_0 = self:GetTemplate().battle_unit_type
	end

	return var_17_0
end

function BattleUnit:PlayFX(arg_18_1, arg_18_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.PLAY_FX, {
		fxName = arg_18_1,
		notAttach = not arg_18_2
	}))

	return
end

function BattleUnit:SwitchShader(arg_19_1, arg_19_2, arg_19_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SWITCH_SHADER, {
		shader = arg_19_1,
		color = arg_19_2,
		args = arg_19_3
	}))

	return
end

function BattleUnit:SendAttackTrigger()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SPAWN_CACHE_BULLET, {}))

	return
end

function BattleUnit:HandleDamageToDeath()
	self:UpdateHP(math.floor(-self._currentHP), {
		isMiss = false,
		isCri = true,
		isHeal = false,
		damageReason = var_0_3.UnitDeathReason.DESTRUCT
	})

	return
end

function BattleUnit:UpdateHP(arg_22_1, arg_22_2)
	local var_22_0 = self:IsAlive()

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
			self:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_TAKE_DAMAGE, var_22_8)

			if var_22_8.capFlag then
				self:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_FIX, var_22_8)
			end
		end

		var_22_7 = -var_22_8.damage

		self:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_DAMAGE, var_22_8)

		if self._currentHP <= var_22_8.damage then
			self:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_22_1 = -var_22_8.damage

		if var_22_7 ~= -var_22_8.damage then
			({}).absorb = var_22_7 - arg_22_1

			self:TriggerBuff(var_0_3.BuffEffectType.ON_SHIELD_ABSORB, var_22_8)
		end

		if var_0_6.IsInvincible(self) and not arg_22_2.ignoreInvincible then
			return 0
		end
	else
		var_22_7 = arg_22_1

		local var_22_9 = {
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = arg_22_2.incorrupt
		}

		self:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_HEALING, var_22_9)

		var_22_3 = var_22_9.isHeal
		arg_22_1 = var_22_9.damage

		local var_22_10 = math.max(0, self._currentHP + var_22_9.damage - self:GetMaxHP())

		if var_22_10 > 0 then
			self:TriggerBuff(var_0_3.BuffEffectType.ON_OVER_HEALING, {
				overHealing = var_22_10
			})
		end
	end

	local var_22_11 = math.min(self:GetMaxHP(), math.max(0, self._currentHP + arg_22_1))

	self:SetCurrentHP(var_22_11)

	local var_22_12 = {
		preShieldHP = var_22_7,
		dHP = arg_22_1,
		validDHP = var_22_11 - self._currentHP,
		isMiss = var_22_1,
		isCri = var_22_2,
		isHeal = var_22_3,
		font = var_22_4
	}

	if not var_22_3 then
		var_22_8.validDHP = var_22_11 - self._currentHP

		self:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_CONCLUDE, var_22_8)
	end

	if var_22_5 and not var_22_5:EqualZero() then
		local var_22_13 = self:GetPosition()
		local var_22_14 = self:GetBoxSize().x
		local var_22_15 = var_22_5:Clone()

		var_22_15.x = Mathf.Clamp(var_22_15.x, var_22_13.x - var_22_14, var_22_13.x + var_22_14)
		var_22_12.posOffset = var_22_13 - var_22_15
	end

	if not var_22_6 then
		self:UpdateHPAction(var_22_12)
	end

	if not self:IsAlive() and var_22_0 then
		self:SetDeathReason(arg_22_2.damageReason)
		self:SetDeathSrcID(arg_22_2.srcID)
		self:DeadAction()
	end

	if self:IsAlive() then
		self:TriggerBuff(var_0_3.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_22_1,
			unit = self,
			validDHP = var_22_11 - self._currentHP
		})
	end

	return arg_22_1
end

function BattleUnit:UpdateHPAction(arg_23_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_HP, arg_23_1))

	return
end

function BattleUnit:DeadAction()
	self:TriggerBuff(var_0_3.BuffEffectType.ON_SINK, {})
	self:DeacActionClear()

	return
end

function BattleUnit:DeacActionClear()
	self._aliveState = false

	var_0_6.Spirit(self)
	var_0_6.AppendInvincible(self)
	self:DeadActionEvent()

	return
end

function BattleUnit:DeadActionEvent()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.WILL_DIE, {}))
	self:DispatchEvent(var_0_0.Event.New(var_0_1.DYING, {}))

	return
end

function BattleUnit:SendDeadEvent()
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.DYING, {}))

	return
end

function BattleUnit:SetDeathReason(arg_28_1)
	self._deathReason = arg_28_1

	return
end

function BattleUnit:GetDeathReason()
	return self._deathReason or var_0_3.UnitDeathReason.KILLED
end

function BattleUnit:SetDeathSrcID(arg_30_1)
	self._deathSrcID = arg_30_1

	return
end

function BattleUnit:GetDeathSrcID()
	return self._deathSrcID
end

function BattleUnit:DispatchScorePoint(arg_32_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.UPDATE_SCORE, {
		score = arg_32_1
	}))

	return
end

function BattleUnit:SetTemplate(arg_33_1, arg_33_2)
	self._tmpID = arg_33_1

	return
end

function BattleUnit:GetTemplateID()
	return self._tmpID
end

function BattleUnit:SetOverrideLevel(arg_35_1)
	self._overrideLevel = arg_35_1

	return
end

function BattleUnit:SetSkinId()
	return
end

function BattleUnit:SetGearScore(arg_37_1)
	self._GS = arg_37_1

	return
end

function BattleUnit:GetGearScore()
	return self._GS or 0
end

function BattleUnit:GetSkinID()
	return self._tmpID
end

function BattleUnit:GetDefaultSkinID()
	return self._tmpID
end

function BattleUnit:GetSkinAttachmentInfo()
	return self._orbitSkinIDList
end

function BattleUnit:GetWeaponBoundBone()
	return self._tmpData.bound_bone
end

function BattleUnit:ActionKeyOffsetUseable()
	return true
end

function BattleUnit:RemoveRemoteBoundBone(arg_44_1)
	self._remoteBoundBone[arg_44_1] = nil

	return
end

function BattleUnit:SetRemoteBoundBone(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = self._remoteBoundBone[arg_45_1] or {}

	var_45_0[arg_45_2] = arg_45_3
	self._remoteBoundBone[arg_45_1] = var_45_0

	return
end

function BattleUnit:GetRemoteBoundBone(arg_46_1)
	for iter_46_0, iter_46_1 in pairs(self._remoteBoundBone) do
		if iter_46_1[arg_46_1] then
			local var_46_0 = var_0_0.Battle.BattleTargetChoise.TargetFleetIndex(self, {
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

function BattleUnit:GetLabelTag()
	return self._labelTagList
end

function BattleUnit:ContainsLabelTag(arg_48_1)
	if self._labelTagList == nil then
		return false
	end

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		if table.contains(self._labelTagList, iter_48_1) then
			return true
		end
	end

	return false
end

function BattleUnit:AddLabelTag(arg_49_1)
	table.insert(self._labelTagList, arg_49_1)

	local var_49_0 = var_0_6.GetCurrent(self, "labelTag")

	var_49_0[arg_49_1] = (var_49_0[arg_49_1] or 0) + 1

	return
end

function BattleUnit:RemoveLabelTag(arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(self._labelTagList) do
		if iter_50_1 == arg_50_1 then
			table.remove(self._labelTagList, iter_50_0)

			local var_50_0 = var_0_6.GetCurrent(self, "labelTag")

			var_50_0[arg_50_1] = var_50_0[arg_50_1] - 1

			break
		end
	end

	return
end

function BattleUnit:setStandardLabelTag()
	self:AddLabelTag("N_" .. self._tmpData.nationality)
	self:AddLabelTag("T_" .. self._tmpData.type)

	return
end

function BattleUnit:GetRarity()
	return
end

function BattleUnit:GetIntimacy()
	return 0
end

function BattleUnit:IsBoss()
	return false
end

function BattleUnit:GetSpeedRatio()
	return var_0_4.GetSpeedRatio(self:GetSpeedExemptKey(), self._IFF)
end

function BattleUnit:GetSpeedExemptKey()
	return self._speedExemptKey
end

function BattleUnit:SetMoveCast(arg_57_1)
	self._moveCast = arg_57_1

	return
end

function BattleUnit:IsMoveCast()
	return self._moveCast
end

function BattleUnit:SetCrash(arg_59_1)
	self._isCrash = arg_59_1

	if arg_59_1 then
		self:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_5.SHIP_CLD_BUFF)))
	else
		self:RemoveBuff(var_0_5.SHIP_CLD_BUFF)
	end

	return
end

function BattleUnit:IsCrash()
	return self._isCrash
end

function BattleUnit:OverrideDeadFX(arg_61_1)
	self._deadFX = arg_61_1

	return
end

function BattleUnit:GetDeadFX()
	return self._deadFX
end

function BattleUnit:SetEquipment(arg_63_1)
	self._equipmentList = arg_63_1
	self._autoWeaponList = {}
	self._manualTorpedoList = {}
	self._chargeList = {}
	self._AAList = {}
	self._fleetAAList = {}
	self._fleetRangeAAList = {}
	self._hiveList = {}
	self._totalWeapon = {}

	self:setWeapon(arg_63_1)

	return
end

function BattleUnit:GetEquipment()
	return self._equipmentList
end

function BattleUnit:SetProficiencyList(arg_65_1)
	self._proficiencyList = arg_65_1

	return
end

function BattleUnit:SetSpWeapon(arg_66_1)
	self._spWeapon = arg_66_1

	return
end

function BattleUnit:GetSpWeapon()
	return self._spWeapon
end

function BattleUnit:setWeapon(arg_68_1)
	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		local var_68_0 = iter_68_1.equipment.weapon_id

		for iter_68_2, iter_68_3 in ipairs(iter_68_1.equipment.weapon_id) do
			if iter_68_3 ~= -1 then
				local var_68_1 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_68_3, self, nil, iter_68_0)

				self._totalWeapon[#self._totalWeapon + 1] = var_68_1

				local var_68_2 = var_68_1:GetTemplateData().type

				if var_68_2 == var_0_3.EquipmentType.MANUAL_TORPEDO then
					self._manualTorpedoList[#self._manualTorpedoList + 1] = var_68_1

					self._weaponQueue:AppendWeapon(var_68_1)
				elseif var_68_2 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					-- block empty
				else
					assert(#var_68_0 < 2, "自动武器一组不允许配置多个")
					self:AddAutoWeapon(var_68_1)
				end

				if var_68_2 == var_0_3.EquipmentType.INTERCEPT_AIRCRAFT or var_68_2 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					self._hiveList[#self._hiveList + 1] = var_68_1
				end

				if var_68_2 == var_0_3.EquipmentType.ANTI_AIR then
					self._AAList[#self._AAList + 1] = var_68_1
				end
			end
		end
	end

	return
end

function BattleUnit:CheckWeaponInitial()
	self._weaponQueue:CheckWeaponInitalCD()

	if self._airAssistQueue then
		self._airAssistQueue:CheckWeaponInitalCD()
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_COOL_DOWN, {}))

	return
end

function BattleUnit:FlushReloadingWeapon()
	self._weaponQueue:FlushWeaponReloadRequire()

	if self._airAssistQueue then
		self._airAssistQueue:FlushWeaponReloadRequire()
	end

	return
end

function BattleUnit:AddNewAutoWeapon(arg_71_1)
	local var_71_0 = var_0_7.CreateWeaponUnit(arg_71_1, self)

	self:AddAutoWeapon(var_71_0)
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleBuffEvent.BUFF_EFFECT_NEW_WEAPON, {
		weapon = var_71_0
	}))

	return var_71_0
end

function BattleUnit:AddAutoWeapon(arg_72_1)
	self._autoWeaponList[#self._autoWeaponList + 1] = arg_72_1

	self._weaponQueue:AppendWeapon(arg_72_1)

	return
end

function BattleUnit:RemoveAutoWeapon(arg_73_1)
	self._weaponQueue:RemoveWeapon(arg_73_1)

	while 1 <= #self._autoWeaponList do
		if self._autoWeaponList[1] == arg_73_1 then
			self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_WEAPON, {
				weapon = arg_73_1
			}))
			table.remove(self._autoWeaponList, 1)

			break
		end
	end

	return
end

function BattleUnit:RemoveAutoWeaponByWeaponID(arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(self._autoWeaponList) do
		if iter_74_1:GetWeaponId() == arg_74_1 then
			iter_74_1:Clear()
			self:RemoveAutoWeapon(iter_74_1)

			break
		end
	end

	return
end

function BattleUnit:RemoveAllAutoWeapon()
	while #self._autoWeaponList > 0 do
		self._autoWeaponList[#self._autoWeaponList]:Clear()
		self:RemoveAutoWeapon(self._autoWeaponList[#self._autoWeaponList])
	end

	return
end

function BattleUnit:AddFleetAntiAirWeapon(arg_76_1)
	return
end

function BattleUnit:RemoveFleetAntiAirWeapon(arg_77_1)
	return
end

function BattleUnit:AttachFleetRangeAAWeapon(arg_78_1)
	self._fleetRangeAA = arg_78_1

	self:DispatchEvent(var_0_0.Event.New(var_0_1.CREATE_TEMPORARY_WEAPON, {
		weapon = arg_78_1
	}))

	return
end

function BattleUnit:DetachFleetRangeAAWeapon()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_WEAPON, {
		weapon = self._fleetRangeAA
	}))

	self._fleetRangeAA = nil

	return
end

function BattleUnit:GetFleetRangeAAWeapon()
	return self._fleetRangeAA
end

function BattleUnit:ShiftWeapon(arg_81_1, arg_81_2)
	for iter_81_0, iter_81_1 in ipairs(arg_81_1) do
		self:RemoveAutoWeaponByWeaponID(iter_81_1)
	end

	for iter_81_2, iter_81_3 in ipairs(arg_81_2) do
		self:AddNewAutoWeapon(iter_81_3):InitialCD()
	end

	return
end

function BattleUnit:ExpandWeaponMount(arg_82_1)
	if arg_82_1 == "airAssist" then
		var_0_7.ExpandAllinStrike(self)
	end

	return
end

function BattleUnit:ReduceWeaponMount(arg_83_1)
	return
end

function BattleUnit:CeaseAllWeapon(arg_84_1)
	self._ceaseFire = arg_84_1

	return
end

function BattleUnit:IsCease()
	return self._ceaseFire
end

function BattleUnit:GetAllWeapon()
	return self._totalWeapon
end

function BattleUnit:GetTotalWeapon()
	return self._weaponQueue:GetTotalWeaponUnit()
end

function BattleUnit:GetAutoWeapons()
	return self._autoWeaponList
end

function BattleUnit:GetChargeList()
	return self._chargeList
end

function BattleUnit:GetChargeQueue()
	return self._weaponQueue:GetChargeWeaponQueue()
end

function BattleUnit:GetAntiAirWeapon()
	return self._AAList
end

function BattleUnit:GetFleetAntiAirList()
	return self._fleetAAList
end

function BattleUnit:GetFleetRangeAntiAirList()
	return self._fleetRangeAAList
end

function BattleUnit:GetTorpedoList()
	return self._manualTorpedoList
end

function BattleUnit:GetTorpedoQueue()
	return self._weaponQueue:GetManualTorpedoQueue()
end

function BattleUnit:GetWeaponByIndex(arg_96_1)
	for iter_96_0, iter_96_1 in ipairs(self._totalWeapon) do
		if iter_96_1:GetEquipmentIndex() == arg_96_1 then
			return iter_96_1
		end
	end

	return
end

function BattleUnit:GetHiveList()
	return self._hiveList
end

function BattleUnit:SetAirAssistList(arg_98_1)
	self._airAssistList = arg_98_1
	self._airAssistQueue = var_0_0.Battle.ManualWeaponQueue.New(self:GetManualWeaponParallel()[var_0_3.ManualWeaponIndex.AIR_ASSIST])

	for iter_98_0, iter_98_1 in ipairs(self._airAssistList) do
		self._airAssistQueue:AppendWeapon(iter_98_1)
	end

	return
end

function BattleUnit:GetAirAssistList()
	return self._airAssistList
end

function BattleUnit:GetAirAssistQueue()
	return self._airAssistQueue
end

function BattleUnit:GetManualWeaponParallel()
	return {
		1,
		1,
		1
	}
end

function BattleUnit:configWeaponQueueParallel()
	local var_102_0 = self:GetManualWeaponParallel()

	self._weaponQueue:ConfigParallel(var_102_0[var_0_3.ManualWeaponIndex.CALIBRATION], var_102_0[var_0_3.ManualWeaponIndex.TORPEDO])

	return
end

function BattleUnit:ClearWeapon()
	self._weaponQueue:ClearAllWeapon()

	if self._airAssistList then
		for iter_103_0, iter_103_1 in ipairs(self._airAssistList) do
			iter_103_1:Clear()
		end
	end

	return
end

function BattleUnit:GetSpeed()
	return self._move:GetSpeed()
end

function BattleUnit:GetPosition()
	return self._move:GetPos()
end

function BattleUnit:GetBornPosition()
	return self._bornPos
end

function BattleUnit:GetCLDZCenterPosition()
	if self._zCenterFrame ~= self._battleProxy.FrameIndex then
		self._zCenterFrame = self._battleProxy.FrameIndex

		local var_107_0 = self:GetCldBox()

		self._cldZCenterCache = (var_107_0.min + var_107_0.max) * 0.5
	end

	return self._cldZCenterCache
end

function BattleUnit:GetBeenAimedPosition()
	local var_108_0 = self:GetCLDZCenterPosition()

	if not var_108_0 then
		return var_108_0
	end

	local var_108_1 = self:GetTemplate() and self:GetTemplate().aim_offset

	if not var_108_1 then
		return var_108_0
	end

	local var_108_2 = Vector3(var_108_0.x + var_108_1[1], var_108_0.y + var_108_1[2], var_108_0.z + var_108_1[3])

	self:biasAimPosition(var_108_2)

	return var_108_2
end

function BattleUnit:biasAimPosition(arg_109_1)
	local var_109_0 = var_0_6.GetCurrent(self, "aimBias")

	if var_109_0 > 0 then
		arg_109_1:Set(arg_109_1.x + (math.random() * (var_109_0 * 2) - var_109_0), arg_109_1.y, arg_109_1.z + (math.random() * (var_109_0 * 2) - var_109_0))
	end

	return arg_109_1
end

function BattleUnit:CancelFollowTeam()
	self._move:CancelFormationCtrl()

	return
end

function BattleUnit:UpdateFormationOffset(arg_111_1)
	self._move:SetFormationCtrlInfo(Vector3(arg_111_1.x, arg_111_1.y, arg_111_1.z))

	return
end

function BattleUnit:GetDistance(arg_112_1)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	local var_112_0 = self._distanceBackup[arg_112_1]

	if self._distanceBackup[arg_112_1] == nil then
		var_112_0 = Vector3.Distance(self:GetPosition(), arg_112_1:GetPosition())
		self._distanceBackup[arg_112_1] = var_112_0

		arg_112_1:backupDistance(self, var_112_0)
	end

	return var_112_0
end

function BattleUnit:backupDistance(arg_113_1, arg_113_2)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	self._distanceBackup[arg_113_1] = arg_113_2

	return
end

function BattleUnit:GetDirection()
	return self._dir
end

function BattleUnit:SetBornPosition(arg_115_1)
	self._bornPos = arg_115_1

	return
end

function BattleUnit:SetPosition(arg_116_1)
	self._move:SetPos(arg_116_1)

	return
end

function BattleUnit:IsMoving()
	local var_117_0 = self._move:GetSpeed()

	return var_117_0.x ~= 0 or var_117_0.z ~= 0
end

function BattleUnit:SetUncontrollableSpeedWithYAngle(arg_118_1, arg_118_2, arg_118_3)
	self:SetUncontrollableSpeed(Vector3(math.cos(math.deg2Rad * arg_118_1), 0, math.sin(math.deg2Rad * arg_118_1)), arg_118_2, arg_118_3)

	return
end

function BattleUnit:SetUncontrollableSpeedWithDir(arg_119_1, arg_119_2, arg_119_3)
	self:SetUncontrollableSpeed(arg_119_1 / math.sqrt(arg_119_1.x * arg_119_1.x + arg_119_1.z * arg_119_1.z), arg_119_2, arg_119_3)

	return
end

function BattleUnit:SetUncontrollableSpeed(arg_120_1, arg_120_2, arg_120_3)
	if not arg_120_2 or not arg_120_3 then
		return
	end

	self._move:SetForceMove(arg_120_1, arg_120_2, arg_120_3, arg_120_2 / arg_120_3)

	return
end

function BattleUnit:ClearUncontrollableSpeed()
	self._move:ClearForceMove()

	return
end

function BattleUnit:SetAdditiveSpeed(arg_122_1)
	self._move:UpdateAdditiveSpeed(arg_122_1)

	return
end

function BattleUnit:RemoveAdditiveSpeed()
	self._move:RemoveAdditiveSpeed()

	return
end

function BattleUnit:Boost(arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)
	self._move:SetForceMove(arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)

	return
end

function BattleUnit:ActiveUnstoppable(arg_125_1)
	self._move:ActiveUnstoppable(arg_125_1)

	return
end

function BattleUnit:SetImmuneCommonBulletCLD()
	self._immuneCommonBulletCLD = true

	return
end

function BattleUnit:IsImmuneCommonBulletCLD()
	return self._immuneCommonBulletCLD
end

function BattleUnit:SetWeaponPreCastBound(arg_128_1)
	self._preCastBound = arg_128_1

	self:UpdatePrecastMoveLimit()

	return
end

function BattleUnit:EnterGCD(arg_129_1, arg_129_2)
	if self._GCDTimerList[arg_129_2] ~= nil then
		return
	end

	local function var_129_0()
		self:RemoveGCDTimer(arg_129_2)

		return
	end

	self._weaponQueue:QueueEnterGCD(arg_129_2, arg_129_1)

	self._GCDTimerList[arg_129_2] = pg.TimeMgr.GetInstance():AddBattleTimer("weaponGCD", 0, arg_129_1, var_129_0, true)

	self:UpdatePrecastMoveLimit()

	return
end

function BattleUnit:RemoveGCDTimer(arg_131_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._GCDTimerList[arg_131_1])

	self._GCDTimerList[arg_131_1] = nil

	self:UpdatePrecastMoveLimit()

	return
end

function BattleUnit:UpdatePrecastMoveLimit()
	self:UpdateMoveLimit()

	return
end

function BattleUnit:UpdateMoveLimit()
	self._move:SetStaticState(not self:IsMoveAble())

	return
end

function BattleUnit:AddBuff(arg_134_1, arg_134_2)
	local var_134_0 = arg_134_1:GetID()
	local var_134_1 = {
		unit_id = self._uniqueID,
		buff_id = var_134_0
	}
	local var_134_2 = self:GetBuff(var_134_0)

	if var_134_2 then
		if arg_134_2 then
			local var_134_3 = self._buffStockList[var_134_0] or {}

			table.insert(var_134_3, arg_134_1)

			self._buffStockList[var_134_0] = var_134_3
		else
			var_134_1.buff_level = math.max(var_134_2:GetLv(), (arg_134_1:GetLv()))

			if var_134_2:IsForceStack() or arg_134_1:GetGroupLevel() <= var_134_2:GetGroupLevel() then
				var_134_2:Stack(self)

				var_134_1.stack_count = var_134_2:GetStack()

				self:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_STACK, var_134_1))
			else
				self:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_CAST, var_134_1))
				self:RemoveBuff(var_134_0)

				self._buffList[var_134_0] = arg_134_1

				arg_134_1:Attach(self)
				self:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
			end
		end
	else
		self:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_CAST, var_134_1))

		self._buffList[var_134_0] = arg_134_1

		arg_134_1:Attach(self)

		var_134_1.buff_level = arg_134_1:GetLv()

		self:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
	end

	self:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_ADDED, {
		buffID = var_134_0
	})

	return
end

function BattleUnit:SetBuffStack(arg_135_1, arg_135_2, arg_135_3)
	if arg_135_3 <= 0 then
		self:RemoveBuff(arg_135_1)
	else
		local var_135_0 = self:GetBuff(arg_135_1)

		if var_135_0 then
			var_135_0:UpdateStack(self, arg_135_3)

			return var_135_0
		else
			local var_135_1 = var_0_0.Battle.BattleBuffUnit.New(arg_135_1, arg_135_2)

			self:AddBuff(var_135_1)
			var_135_1:UpdateStack(self, arg_135_3)

			return var_135_1
		end
	end

	return
end

function BattleUnit:UpdateBuff(arg_136_1)
	for iter_136_0, iter_136_1 in pairs(self._buffList) do
		iter_136_1:Update(self, arg_136_1)

		if not self:IsAlive() then
			break
		end
	end

	return
end

function BattleUnit:ConsumeBuffStack(arg_137_1, arg_137_2)
	local var_137_0 = self:GetBuff(arg_137_1)

	if var_137_0 then
		if not arg_137_2 then
			self:RemoveBuff(arg_137_1)
		else
			local var_137_1 = math.max(0, var_137_0:GetStack() - arg_137_2)

			if var_137_1 == 0 then
				self:RemoveBuff(arg_137_1)
			else
				var_137_0:UpdateStack(self, var_137_1)
			end
		end
	end

	return
end

function BattleUnit:RemoveBuff(arg_138_1, arg_138_2)
	if arg_138_2 and self._buffStockList[arg_138_1] then
		local var_138_0 = table.remove(self._buffStockList[arg_138_1])

		if var_138_0 then
			var_138_0:Clear()

			return
		end
	end

	local var_138_1 = self:GetBuff(arg_138_1)

	if var_138_1 then
		var_138_1:Remove()
	end

	self:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_REMOVED, {
		buffID = arg_138_1
	})

	return
end

function BattleUnit:ClearBuff()
	for iter_139_0, iter_139_1 in pairs(self._buffList) do
		iter_139_1:Clear()
	end

	for iter_139_2, iter_139_3 in pairs(self._buffStockList) do
		for iter_139_4, iter_139_5 in pairs(iter_139_3) do
			iter_139_5:Clear()
		end
	end

	return
end

function BattleUnit:TriggerBuff(arg_140_1, arg_140_2)
	var_0_0.Battle.BattleBuffUnit.Trigger(self, arg_140_1, arg_140_2)

	return
end

function BattleUnit:GetBuffList()
	return self._buffList
end

function BattleUnit:GetBuff(arg_142_1)
	self._buffList = self._buffList

	return self._buffList[arg_142_1]
end

function BattleUnit:DispatchSkillFloat(arg_143_1, arg_143_2, arg_143_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SKILL_FLOAT, {
		coverHrzIcon = arg_143_3,
		commander = arg_143_2,
		skillName = arg_143_1
	}))

	return
end

function BattleUnit:DispatchCutIn(arg_144_1, arg_144_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.CUT_INT, {
		caster = self,
		skill = arg_144_1
	}))

	return
end

function BattleUnit:DispatchCastClock(arg_145_1, arg_145_2, arg_145_3, arg_145_4, arg_145_5)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_BUFF_CLOCK, {
		isActive = arg_145_1,
		buffEffect = arg_145_2,
		iconType = arg_145_3,
		interrupt = arg_145_4,
		reverse = arg_145_5
	}))

	return
end

function BattleUnit:SetAI(arg_146_1)
	self._autoPilotAI = var_0_0.Battle.AutoPilot.New(self, (var_0_7.GetAITmpDataFromID(arg_146_1))), self._move:CancelFormationCtrl()

	return
end

function BattleUnit:AddPhaseSwitcher(arg_147_1)
	self._phaseSwitcher = arg_147_1

	return
end

function BattleUnit:GetPhaseSwitcher()
	return self._phaseSwitcher
end

function BattleUnit:StateChange(arg_149_1, arg_149_2)
	self._unitState:ChangeState(arg_149_1, arg_149_2)

	return
end

function BattleUnit:UpdateAction()
	local var_150_0 = self:GetSpeed().x * self._IFF

	if self._oxyState and self._oxyState:GetCurrentDiveState() == var_0_3.OXY_STATE.DIVE then
		if var_150_0 >= 0 then
			self._unitState:ChangeState(var_0_8.STATE_DIVE)
		else
			self._unitState:ChangeState(var_0_8.STATE_DIVELEFT)
		end
	elseif var_150_0 >= 0 then
		self._unitState:ChangeState(var_0_8.STATE_MOVE)
	else
		self._unitState:ChangeState(var_0_8.STATE_MOVELEFT)
	end

	return
end

function BattleUnit:SetActionKeyOffset(arg_151_1)
	self._actionKeyOffset = arg_151_1

	self._unitState:FreshActionKeyOffset()

	return
end

function BattleUnit:GetActionKeyOffset()
	return self._actionKeyOffset
end

function BattleUnit:GetCurrentState()
	return self._unitState:GetCurrentStateName()
end

function BattleUnit:NeedWeaponCache()
	return self._unitState:NeedWeaponCache()
end

function BattleUnit:CharacterActionTriggerCallback()
	self._unitState:OnActionTrigger()

	return
end

function BattleUnit:CharacterActionEndCallback()
	self._unitState:OnActionEnd()

	return
end

function BattleUnit:CharacterActionStartCallback()
	return
end

function BattleUnit:DispatchChat(arg_158_1, arg_158_2, arg_158_3)
	if not arg_158_1 or #arg_158_1 == 0 then
		return
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.POP_UP, {
		content = HXSet.hxLan(arg_158_1),
		duration = arg_158_2,
		key = arg_158_3
	}))

	return
end

function BattleUnit:DispatchVoice(arg_159_1)
	local var_159_0, var_159_1, var_159_2 = ShipWordHelper.GetWordAndCV(self:GetSkinID(), arg_159_1, 1, true, (self:GetIntimacy()))

	if var_159_1 then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.VOICE, {
			content = var_159_1,
			key = arg_159_1
		}))
	end

	return
end

function BattleUnit:GetHostileCldList()
	return self._hostileCldList
end

function BattleUnit:AppendHostileCld(arg_161_1, arg_161_2)
	self._hostileCldList[arg_161_1] = arg_161_2

	return
end

function BattleUnit:RemoveHostileCld(arg_162_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._hostileCldList[arg_162_1])

	self._hostileCldList[arg_162_1] = nil

	return
end

function BattleUnit:GetExtraInfo()
	return self._extraInfo
end

function BattleUnit:GetTemplate()
	return nil
end

function BattleUnit:GetGroupID()
	return nil
end

function BattleUnit:GetTemplateValue(arg_166_1)
	return self:GetTemplate()[arg_166_1]
end

function BattleUnit:GetUniqueID()
	return self._uniqueID
end

function BattleUnit:SetIFF(arg_168_1)
	self._IFF = arg_168_1

	if arg_168_1 == var_0_5.FRIENDLY_CODE then
		self._dir = var_0_3.UnitDir.RIGHT
	elseif arg_168_1 == var_0_5.FOE_CODE then
		self._dir = var_0_3.UnitDir.LEFT
	end

	return
end

function BattleUnit:GetIFF()
	return self._IFF
end

function BattleUnit:GetUnitType()
	return self._type
end

function BattleUnit:GetHPRate()
	return self._currentHPRate
end

function BattleUnit:GetHP()
	local var_172_1 = self:GetMaxHP()
end

function BattleUnit:GetCurrentHP()
	return self._currentHP
end

function BattleUnit:SetCurrentHP(arg_174_1)
	self._currentHP = arg_174_1
	self._currentHPRate = self._currentHP / self:GetMaxHP()
	self._currentDMGRate = 1 - self._currentHPRate

	var_0_6.SetCurrent(self, "HPRate", self._currentHPRate)
	var_0_6.SetCurrent(self, "DMGRate", self._currentDMGRate)

	return
end

function BattleUnit:GetAttr()
	return var_0_6.GetAttr(self)
end

function BattleUnit:GetAttrByName(arg_176_1)
	return var_0_6.GetCurrent(self, arg_176_1)
end

function BattleUnit:GetMaxHP()
	return self:GetAttrByName("maxHP")
end

function BattleUnit:GetReload()
	return self:GetAttrByName("loadSpeed")
end

function BattleUnit:GetTorpedoPower()
	return self:GetAttrByName("torpedoPower")
end

function BattleUnit:CanDoAntiSub()
	return self:GetAttrByName("antiSubPower") > 0
end

function BattleUnit:IsShowHPBar()
	return false
end

function BattleUnit:IsAlive()
	return self._aliveState and self:GetCurrentHP() > 0
end

function BattleUnit:SetMainFleetUnit()
	self._isMainFleetUnit = true

	self:SetMainUnitStatic(true)

	return
end

function BattleUnit:IsMainFleetUnit()
	return self._isMainFleetUnit
end

function BattleUnit:SetMainUnitStatic(arg_185_1)
	self._isMainStatic = arg_185_1

	self._move:SetStaticState(arg_185_1)

	return
end

function BattleUnit:SetMainUnitIndex(arg_186_1)
	self._mainUnitIndex = arg_186_1

	return
end

function BattleUnit:GetMainUnitIndex()
	return self._mainUnitIndex or 1
end

function BattleUnit:IsMoveAble()
	return not self._isMainStatic and (self:IsMoveCast() or not (table.getCount(self._GCDTimerList) > 0 or self._preCastBound)) and not var_0_6.IsStun(self)
end

function BattleUnit:Reinforce()
	self._isReinforcement = true

	return
end

function BattleUnit:IsReinforcement()
	return self._isReinforcement
end

function BattleUnit:SetReinforceCastTime(arg_191_1)
	self._reinforceCastTime = arg_191_1

	return
end

function BattleUnit:GetReinforceCastTime()
	return self._reinforceCastTime
end

function BattleUnit:GetFleetVO()
	return
end

function BattleUnit:SetFormationIndex(arg_194_1)
	return
end

function BattleUnit:SetMaster()
	return
end

function BattleUnit:GetMaster()
	return nil
end

function BattleUnit:IsSpectre()
	return
end

function BattleUnit:Clear()
	self._aliveState = false

	for iter_198_0, iter_198_1 in pairs(self._hostileCldList) do
		self:RemoveHostileCld(iter_198_0)
	end

	self:ClearWeapon()
	self:ClearBuff()

	self._distanceBackup = {}

	return
end

function BattleUnit:Dispose()
	self._exposedList = nil
	self._phaseSwitcher = nil

	self._weaponQueue:Dispose()

	if self._airAssistQueue then
		self._airAssistQueue:Clear()

		self._airAssistQueue = nil
	end

	self._equipmentList = nil
	self._totalWeapon = nil

	if self._airAssistList then
		for iter_199_0, iter_199_1 in ipairs(self._airAssistList) do
			iter_199_1:Dispose()
		end
	end

	for iter_199_2, iter_199_3 in ipairs(self._fleetAAList) do
		iter_199_3:Dispose()
	end

	for iter_199_4, iter_199_5 in ipairs(self._fleetRangeAAList) do
		iter_199_5:Dispose()
	end

	for iter_199_6, iter_199_7 in pairs(self._buffList) do
		iter_199_7:Dispose()
	end

	for iter_199_8, iter_199_9 in pairs(self._buffStockList) do
		for iter_199_10, iter_199_11 in pairs(iter_199_9) do
			iter_199_11:Clear()
		end
	end

	self._fleetRangeAA = nil
	self._aimBias = nil
	self._buffList = nil
	self._buffStockList = nil
	self._cldZCenterCache = nil
	self._remoteBoundBone = nil

	self:RemoveSummonSickness()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)

	return
end

function BattleUnit:InitCldComponent()
	local var_200_0 = self:GetTemplate().cld_box
	local var_200_1 = self:GetTemplate().cld_offset
	local var_200_2 = var_200_1[1]

	if self:GetDirection() == var_0_3.UnitDir.LEFT then
		var_200_2 = var_200_2 * -1
	end

	self._cldComponent = var_0_0.Battle.BattleCubeCldComponent.New(var_200_0[1], var_200_0[2], var_200_0[3], var_200_2, var_200_1[3] + var_200_0[3] / 2)

	return
end

function BattleUnit:GetBoxSize()
	return self._cldComponent:GetCldBoxSize()
end

function BattleUnit:GetCldBox()
	return self._cldComponent:GetCldBox(self:GetPosition())
end

function BattleUnit:GetCldData()
	return self._cldComponent:GetCldData()
end

function BattleUnit:ShiftCldComponent(arg_204_1, arg_204_2)
	self:updateCldComponet(arg_204_1, arg_204_2)

	return
end

function BattleUnit:ResetCldComponent()
	self:updateCldComponet(self:GetTemplate().cld_box, self:GetTemplate().cld_offset)

	return
end

function BattleUnit:updateCldComponet(arg_206_1, arg_206_2)
	local var_206_0 = arg_206_2[1]

	if self:GetDirection() == var_0_3.UnitDir.LEFT then
		var_206_0 = var_206_0 * -1
	end

	self._cldComponent:ResetOffset(var_206_0, arg_206_2[3] + arg_206_1[3] / 2)
	self._cldComponent:ResetSize(arg_206_1[1], arg_206_1[2], arg_206_1[3])

	return
end

function BattleUnit:InitOxygen()
	self._maxOxy = self:GetAttrByName("oxyMax")
	self._currentOxy = self:GetAttrByName("oxyMax")
	self._oxyRecovery = self:GetAttrByName("oxyRecovery")
	self._oxyRecoveryBench = self:GetAttrByName("oxyRecoveryBench")
	self._oxyRecoverySurface = self:GetAttrByName("oxyRecoverySurface")
	self._oxyConsume = self:GetAttrByName("oxyCost")
	self._oxyState = var_0_0.Battle.OxyState.New(self)

	self._oxyState:OnDiveState()
	self:ConfigBubbleFX()

	return self._oxyState
end

function BattleUnit:UpdateOxygen(arg_208_1)
	if self._oxyState then
		self._lastOxyUpdateStamp = self._lastOxyUpdateStamp or arg_208_1

		self._oxyState:UpdateOxygen()

		if self._oxyState:GetNextBubbleStamp() and arg_208_1 > self._oxyState:GetNextBubbleStamp() then
			self._oxyState:FlashBubbleStamp(arg_208_1)
			self:PlayFX(self._bubbleFX, true)
		end

		self._lastOxyUpdateStamp = arg_208_1

		self:updateSonarExposeTag()
	end

	return
end

function BattleUnit:OxyRecover(arg_209_1)
	self._currentOxy = math.min(self._maxOxy, self._currentOxy + (arg_209_1 == var_0_0.Battle.OxyState.STATE_FREE_BENCH and self._oxyRecoveryBench or arg_209_1 == var_0_0.Battle.OxyState.STATE_FREE_FLOAT and self._oxyRecovery or self._oxyRecoverySurface) * (pg.TimeMgr.GetInstance():GetCombatTime() - self._lastOxyUpdateStamp))

	return
end

function BattleUnit:OxyConsume()
	self._currentOxy = math.max(0, self._currentOxy - self._oxyConsume * (pg.TimeMgr.GetInstance():GetCombatTime() - self._lastOxyUpdateStamp))

	return
end

function BattleUnit:ChangeOxygenState(arg_211_1)
	self._oxyState:ChangeState(arg_211_1)

	return
end

function BattleUnit:ChangeWeaponDiveState()
	for iter_212_0, iter_212_1 in ipairs(self._autoWeaponList) do
		iter_212_1:ChangeDiveState()
	end

	return
end

function BattleUnit:GetOxygenProgress()
	return self._currentOxy / self._maxOxy
end

function BattleUnit:GetCuurentOxygen()
	return self._currentOxy or 0
end

function BattleUnit:ConfigBubbleFX()
	return
end

function BattleUnit:SetDiveInvisible(arg_216_1)
	self._diveInvisible = arg_216_1

	self:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_VISIBLE))
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED))
	self:dispatchDetectedTrigger()

	return
end

function BattleUnit:GetDiveInvisible()
	return self._diveInvisible
end

function BattleUnit:GetOxygenVisible()
	return self._oxyState and self._oxyState:GetBarVisible()
end

function BattleUnit:SetForceVisible()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_FORCE_DETECTED))

	return
end

function BattleUnit:Detected(arg_220_1)
	local var_220_0

	if self._exposedToSnoar == false and not self._exposedOverTimeStamp then
		var_220_0 = true
	end

	if arg_220_1 then
		self:updateExposeTimeStamp(arg_220_1)
	else
		self._exposedToSnoar = true
	end

	if var_220_0 then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED, {}))
		self:dispatchDetectedTrigger()
	end

	return
end

function BattleUnit:Undetected()
	self._exposedToSnoar = false

	self:updateExposeTimeStamp(var_0_5.SUB_EXPOSE_LASTING_DURATION)

	return
end

function BattleUnit:RemoveSonarExpose()
	self._exposedToSnoar = false
	self._exposedOverTimeStamp = nil

	return
end

function BattleUnit:updateSonarExposeTag()
	if self._exposedOverTimeStamp and not self._exposedToSnoar then
		if pg.TimeMgr.GetInstance():GetCombatTime() > self._exposedOverTimeStamp then
			self._exposedOverTimeStamp = nil

			self:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED, {
				detected = false
			}))
			self:dispatchDetectedTrigger()
		end
	end

	return
end

function BattleUnit:updateExposeTimeStamp(arg_224_1)
	local var_224_0 = pg.TimeMgr.GetInstance():GetCombatTime() + arg_224_1

	self._exposedOverTimeStamp = self._exposedOverTimeStamp or 0

	if var_224_0 < self._exposedOverTimeStamp then
		self._exposedOverTimeStamp = self._exposedOverTimeStamp or var_224_0
	end

	return
end

function BattleUnit:IsRunMode()
	return self._oxyState and self._oxyState:GetRundMode()
end

function BattleUnit:GetDiveDetected()
	local var_226_0 = self:GetDiveInvisible()

	if var_226_0 then
		var_226_0 = self._exposedOverTimeStamp or self._exposedToSnoar
	end

	return var_226_0
end

function BattleUnit:GetForceExpose()
	return self._oxyState and self._oxyState:GetForceExpose()
end

function BattleUnit:dispatchDetectedTrigger()
	if self:GetDiveDetected() then
		self:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_DETECTED, {})
	else
		self:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_UNDETECTED, {})
	end

	return
end

function BattleUnit:GetRaidDuration()
	return self:GetAttrByName("oxyMax") / self:GetAttrByName("oxyCost")
end

function BattleUnit:EnterRaidRange()
	if self:GetPosition().x > self._subRaidLine then
		return true
	else
		return false
	end

	return
end

function BattleUnit:EnterRetreatRange()
	if self:GetPosition().x < self._subRetreatLine then
		return true
	else
		return false
	end

	return
end

function BattleUnit:GetOxyState()
	return self._oxyState
end

function BattleUnit:GetCurrentOxyState()
	if not self._oxyState then
		return var_0_3.OXY_STATE.FLOAT
	else
		return self._oxyState:GetCurrentDiveState()
	end

	return
end

function BattleUnit:InitAntiSubState(arg_234_1, arg_234_2)
	self._antiSubVigilanceState = var_0_0.Battle.AntiSubState.New(self)

	self:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_ANIT_SUB_VIGILANCE, {
		sonarRange = arg_234_1
	}))

	return self._antiSubVigilanceState
end

function BattleUnit:GetAntiSubState()
	return self._antiSubVigilanceState
end

function BattleUnit:UpdateBlindInvisibleBySpectre()
	local var_236_0, var_236_1 = self:IsSpectre()

	if var_236_1 <= var_0_5.SPECTRE_UNIT_TYPE and var_236_1 ~= var_0_5.VISIBLE_SPECTRE_UNIT_TYPE then
		self:SetBlindInvisible(true)
	else
		self:SetBlindInvisible(false)
	end

	return
end

function BattleUnit:SetBlindInvisible(arg_237_1)
	self._exposedList = arg_237_1 and {} or nil
	self._blindInvisible = arg_237_1

	self:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_VISIBLE))

	return
end

function BattleUnit:GetBlindInvisible()
	return self._blindInvisible
end

function BattleUnit:GetExposed()
	if not self._blindInvisible then
		return true
	end

	for iter_239_0, iter_239_1 in pairs(self._exposedList) do
		return true
	end

	return
end

function BattleUnit:AppendExposed(arg_240_1)
	if not self._blindInvisible then
		return
	end

	self._exposedList[arg_240_1] = true

	if not self._exposedList[arg_240_1] then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_EXPOSE))
	end

	return
end

function BattleUnit:RemoveExposed(arg_241_1)
	if not self._blindInvisible then
		return
	end

	self._exposedList[arg_241_1] = nil

	self:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_EXPOSE))

	return
end

function BattleUnit:SetWorldDeathMark()
	self._worldDeathMark = true

	return
end

function BattleUnit:GetWorldDeathMark()
	return self._worldDeathMark
end

function BattleUnit:InitCloak()
	self._cloak = var_0_0.Battle.BattleUnitCloakComponent.New(self)

	self:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_CLOAK))

	return self._cloak
end

function BattleUnit:CloakOnFire(arg_245_1)
	if self._cloak then
		self._cloak:UpdateDotExpose(arg_245_1)
	end

	return
end

function BattleUnit:CloakExpose(arg_246_1)
	if self._cloak then
		self._cloak:AppendExpose(arg_246_1)
	end

	return
end

function BattleUnit:StrikeExpose()
	if self._cloak then
		self._cloak:AppendStrikeExpose()
	end

	return
end

function BattleUnit:BombardExpose()
	if self._cloak then
		self._cloak:AppendBombardExpose()
	end

	return
end

function BattleUnit:UpdateCloak(arg_249_1)
	self._cloak:Update(arg_249_1)

	return
end

function BattleUnit:UpdateCloakConfig()
	if self._cloak then
		self._cloak:UpdateCloakConfig()
		self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))
	end

	return
end

function BattleUnit:DispatchCloakStateUpdate()
	if self._cloak then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_STATE))
	end

	return
end

function BattleUnit:GetCloak()
	return self._cloak
end

function BattleUnit:AttachAimBias(arg_253_1)
	self._aimBias = arg_253_1

	self:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_AIMBIAS))

	return
end

function BattleUnit:DetachAimBias()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIMBIAS))
	self._aimBias:RemoveCrew(self)

	self._aimBias = nil

	return
end

function BattleUnit:ExitSmokeArea()
	self._aimBias:SmokeExitPause()

	return
end

function BattleUnit:UpdateAimBiasSkillState()
	if self._aimBias and self._aimBias:GetHost() == self then
		self._aimBias:UpdateSkillLock()
	end

	return
end

function BattleUnit:HostAimBias()
	if self._aimBias then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.HOST_AIMBIAS))
	end

	return
end

function BattleUnit:GetAimBias()
	return self._aimBias
end

function BattleUnit:SwitchSpine(arg_259_1, arg_259_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SWITCH_SPINE, {
		skin = arg_259_1,
		HPBarOffset = arg_259_2
	}))

	return
end

function BattleUnit:Freeze()
	for iter_260_0, iter_260_1 in ipairs(self._totalWeapon) do
		iter_260_1:StartJamming()
	end

	if self._airAssistList then
		for iter_260_2, iter_260_3 in ipairs(self._airAssistList) do
			iter_260_3:StartJamming()
		end
	end

	return
end

function BattleUnit:ActiveFreeze()
	for iter_261_0, iter_261_1 in ipairs(self._totalWeapon) do
		iter_261_1:JammingEliminate()
	end

	if self._airAssistList then
		for iter_261_2, iter_261_3 in ipairs(self._airAssistList) do
			iter_261_3:JammingEliminate()
		end
	end

	return
end

function BattleUnit:ActiveWeaponSectorView(arg_262_1, arg_262_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.WEAPON_SECTOR, {
		weapon = arg_262_1,
		isActive = arg_262_2
	}))

	return
end

return
