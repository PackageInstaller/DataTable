ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = ys.Battle.BattleConst
local var_0_7 = ys.Battle.BattleCardPuzzleEvent
local var_0_8 = ys.Battle.BattleAttr

ys.Battle.BattleCardPuzzlePlayerUnit = class("BattleCardPuzzlePlayerUnit", ys.Battle.BattlePlayerUnit)
ys.Battle.BattleCardPuzzlePlayerUnit.__name = "BattleCardPuzzlePlayerUnit"

local var_0_9 = ys.Battle.BattleCardPuzzlePlayerUnit

function ys.Battle.BattleCardPuzzlePlayerUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_9.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:UpdateHP(arg_2_1, arg_2_2)
	if not self:IsAlive() then
		return
	end

	local var_2_0 = self:IsAlive()

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_2.isMiss
	local var_2_2 = arg_2_2.isCri
	local var_2_3 = arg_2_2.isHeal
	local var_2_4 = arg_2_2.font
	local var_2_5 = arg_2_2.cldPos
	local var_2_6 = arg_2_1
	local var_2_7 = self:GetCurrentHP()

	if not arg_2_2.isHeal then
		local var_2_8 = {
			damage = -arg_2_1,
			isShare = arg_2_2.isShare,
			miss = var_2_1,
			cri = var_2_2,
			damageSrc = arg_2_2.srcID,
			damageAttr = arg_2_2.attr
		}

		self:TriggerBuff(var_0_4.BuffEffectType.ON_TAKE_DAMAGE, var_2_8)

		if var_2_7 <= var_2_8.damage then
			self:TriggerBuff(var_0_4.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_2_1 = -var_2_8.damage

		if var_0_8.IsInvincible(self) then
			return 0
		end
	end

	local var_2_10

	do
		local var_2_9 = {
			damage = arg_2_1,
			isHeal = var_2_3
		}

		self:TriggerBuff(var_0_4.BuffEffectType.ON_TAKE_HEALING, var_2_9)

		var_2_3 = var_2_9.isHeal
		arg_2_1 = var_2_9.damage
		var_2_10 = {
			preShieldHP = var_2_6,
			dHP = arg_2_1
		}
	end

	var_2_10.validDHP = math.min(self:GetMaxHP(), math.max(0, var_2_7 + arg_2_1)) - var_2_7
	var_2_10.isMiss = var_2_1
	var_2_10.isCri = var_2_2
	var_2_10.isHeal = var_2_3
	var_2_10.font = var_2_4

	if var_2_5 and not var_2_5:EqualZero() then
		local var_2_11 = self:GetPosition()
		local var_2_12 = self:GetBoxSize().x
		local var_2_13 = var_2_5:Clone()

		var_2_13.x = Mathf.Clamp(var_2_13.x, var_2_11.x - var_2_12, var_2_11.x + var_2_12)
		var_2_10.posOffset = var_2_11 - var_2_13
	end

	self:UpdateHPAction(var_2_10)

	if not self:IsAlive() and var_2_0 then
		self:SetDeathReason(arg_2_2.damageReason)
		self:DeadAction()
	end

	if self:IsAlive() then
		self:TriggerBuff(var_0_4.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_2_1,
			unit = self
		})
	end

	return arg_2_1
end

function ys.Battle.BattleCardPuzzlePlayerUnit:UpdateHPAction(arg_3_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_7.UPDATE_COMMON_HP, arg_3_1))
	var_0_9.super.UpdateHPAction(self, arg_3_1)

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:SetTemplate(arg_4_1, arg_4_2, arg_4_3)
	self._tmpID = arg_4_1
	self._tmpData = Clone(var_0_1.GetPuzzleShipDataTemplate(self._tmpID))
	self._tmpData.scale = 100
	self._tmpData.parallel_max = {
		1,
		1,
		1
	}

	self:configWeaponQueueParallel()
	self:overrideSkin(self._tmpData.skin_id, true)
	self:InitCldComponent()
	self:setAttrFromOutBattle(arg_4_2, arg_4_3)

	self._personality = var_0_1.GetShipPersonality(2)

	var_0_3.SetCurrent(self, "srcShipType", self._tmpData.type)

	for iter_4_0, iter_4_1 in ipairs(self._tmpData.tag) do
		self:AddLabelTag(iter_4_1)
	end

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:GetTemplate()
	return self._tmpData
end

function ys.Battle.BattleCardPuzzlePlayerUnit.InitCurrentHP(arg_6_0)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:InitFleetCurrentHP(arg_7_1)
	self:TriggerBuff(var_0_4.BuffEffectType.ON_HP_RATIO_UPDATE, {})

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetCurrentHP(arg_8_0, arg_8_1)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:GetCurrentHP()
	return self._fleetCardPuzzleComponent:GetCurrentCommonHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit:GetMaxHP()
	return self._fleetCardPuzzleComponent:GetTotalCommonHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit:GetHP()
	local var_11_0 = self:GetCurrentHP()
	local var_11_1 = self:GetMaxHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit:GetHPRate()
	return self:GetCurrentHP() / self:GetMaxHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetFleetVO(arg_13_0, arg_13_1)
	var_0_9.super.SetFleetVO(arg_13_0, arg_13_1)

	arg_13_0._fleetCardPuzzleComponent = arg_13_1:GetCardPuzzleComponent()

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.LeaderSetting(arg_14_0)
	arg_14_0._warningValue = 1

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:SetMainFleetUnit(arg_15_1)
	self._isMainFleetUnit = true

	self:SetMainUnitStatic(true)

	self._mainUnitWarningValue = 1

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.CheckWeaponInitial(arg_16_0)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit:setWeapon()
	for iter_17_0, iter_17_1 in ipairs(self._tmpData.default_equip) do
		if iter_17_1 ~= 0 then
			local var_17_0 = var_0_1.GetWeaponDataFromID(iter_17_1)

			for iter_17_2, iter_17_3 in ipairs(var_17_0) do
				if iter_17_3 ~= -1 then
					local var_17_1 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_17_3, self, nil, iter_17_0)

					self._totalWeapon[#self._totalWeapon + 1] = var_17_1

					if weaponType == var_0_4.EquipmentType.STRIKE_AIRCRAFT then
						-- block empty
					else
						assert(#var_17_0 < 2, "自动武器一组不允许配置多个")
						self:AddAutoWeapon(var_17_1)
					end

					if weaponType == var_0_4.EquipmentType.INTERCEPT_AIRCRAFT or weaponType == var_0_4.EquipmentType.STRIKE_AIRCRAFT then
						self._hiveList[#self._hiveList + 1] = var_17_1
					end

					if weaponType == var_0_4.EquipmentType.ANTI_AIR then
						self._AAList[#self._AAList + 1] = var_17_1
					end
				end
			end
		end
	end

	return
end

return
