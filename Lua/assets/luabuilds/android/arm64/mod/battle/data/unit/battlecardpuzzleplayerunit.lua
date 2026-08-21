ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_3 = ys.Battle.BattleAttr
local var_0_6 = ys.Battle.BattleCardPuzzleEvent
local var_0_7 = ys.Battle.BattleAttr

ys.Battle.BattleCardPuzzlePlayerUnit = class("BattleCardPuzzlePlayerUnit", ys.Battle.BattlePlayerUnit)
ys.Battle.BattleCardPuzzlePlayerUnit.__name = "BattleCardPuzzlePlayerUnit"

local var_0_8 = ys.Battle.BattleCardPuzzlePlayerUnit

function ys.Battle.BattleCardPuzzlePlayerUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_8.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.UpdateHP(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0:IsAlive() then
		return
	end

	local var_2_0 = arg_2_0:IsAlive()

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_2.isMiss
	local var_2_2 = arg_2_2.isCri
	local var_2_3 = arg_2_2.isHeal
	local var_2_4 = arg_2_2.font
	local var_2_5 = arg_2_2.cldPos
	local var_2_6 = arg_2_1
	local var_2_7 = arg_2_0:GetCurrentHP()

	if not arg_2_2.isHeal then
		arg_2_0:TriggerBuff(var_0.BuffEffectType.ON_TAKE_DAMAGE, {
			damage = -arg_2_1,
			isShare = arg_2_2.isShare,
			miss = var_2_1,
			cri = var_2_2,
			damageSrc = arg_2_2.srcID,
			damageAttr = arg_2_2.attr
		})

		if var_2_7 <= ({
			damage = -arg_2_1,
			isShare = arg_2_2.isShare,
			miss = var_2_1,
			cri = var_2_2,
			damageSrc = arg_2_2.srcID,
			damageAttr = arg_2_2.attr
		}).damage then
			arg_2_0:TriggerBuff(var_0.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_2_1 = -({
			damage = -arg_2_1,
			isShare = arg_2_2.isShare,
			miss = var_2_1,
			cri = var_2_2,
			damageSrc = arg_2_2.srcID,
			damageAttr = arg_2_2.attr
		}).damage

		if var_0_7.IsInvincible(arg_2_0) then
			return 0
		end
	else
		local var_2_8 = {
			damage = arg_2_1,
			isHeal = var_2_3
		}

		arg_2_0:TriggerBuff(var_0.BuffEffectType.ON_TAKE_HEALING, {
			damage = arg_2_1,
			isHeal = var_2_3
		})

		var_2_3 = var_2_8.isHeal
		arg_2_1 = var_2_8.damage
	end

	;({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	}).validDHP = math.min(arg_2_0:GetMaxHP(), math.max(0, var_2_7 + arg_2_1)) - var_2_7
	;({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	}).isMiss = var_2_1
	;({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	}).isCri = var_2_2
	;({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	}).isHeal = var_2_3
	;({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	}).font = var_2_4

	if var_2_5 and not var_2_5:EqualZero() then
		local var_2_9 = arg_2_0:GetPosition()
		local var_2_10 = arg_2_0:GetBoxSize().x
		local var_2_11 = var_2_5:Clone()

		var_2_11.x = Mathf.Clamp(var_2_11.x, var_2_9.x - var_2_10, var_2_9.x + var_2_10)
		;({
			preShieldHP = var_2_6,
			dHP = arg_2_1
		}).posOffset = var_2_9 - var_2_11
	end

	arg_2_0:UpdateHPAction({
		preShieldHP = var_2_6,
		dHP = arg_2_1
	})

	if not arg_2_0:IsAlive() and var_2_0 then
		arg_2_0:SetDeathReason(arg_2_2.damageReason)
		arg_2_0:DeadAction()
	end

	if arg_2_0:IsAlive() then
		arg_2_0:TriggerBuff(var_0.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_2_1,
			unit = arg_2_0
		})
	end

	return arg_2_1
end

function ys.Battle.BattleCardPuzzlePlayerUnit.UpdateHPAction(arg_3_0, arg_3_1)
	arg_3_0:DispatchEvent(var_0_0.Event.New(var_0_6.UPDATE_COMMON_HP, arg_3_1))
	var_0_8.super.UpdateHPAction(arg_3_0, arg_3_1)

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetTemplate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._tmpID = arg_4_1
	arg_4_0._tmpData = Clone(var_0_1.GetPuzzleShipDataTemplate(arg_4_0._tmpID))
	arg_4_0._tmpData.scale = 100
	arg_4_0._tmpData.parallel_max = {
		1,
		1,
		1
	}

	arg_4_0:configWeaponQueueParallel()
	arg_4_0:overrideSkin(arg_4_0._tmpData.skin_id, true)
	arg_4_0:InitCldComponent()
	arg_4_0:setAttrFromOutBattle(arg_4_2, arg_4_3)

	arg_4_0._personality = var_0_1.GetShipPersonality(2)

	var_0_3.SetCurrent(arg_4_0, "srcShipType", arg_4_0._tmpData.type)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._tmpData.tag) do
		arg_4_0:AddLabelTag(iter_4_1)
	end

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.GetTemplate(arg_5_0)
	return arg_5_0._tmpData
end

function ys.Battle.BattleCardPuzzlePlayerUnit.InitCurrentHP(arg_6_0)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.InitFleetCurrentHP(arg_7_0, arg_7_1)
	arg_7_0:TriggerBuff(var_0.BuffEffectType.ON_HP_RATIO_UPDATE, {})

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetCurrentHP(arg_8_0, arg_8_1)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.GetCurrentHP(arg_9_0)
	return arg_9_0._fleetCardPuzzleComponent:GetCurrentCommonHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit.GetMaxHP(arg_10_0)
	return arg_10_0._fleetCardPuzzleComponent:GetTotalCommonHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit.GetHP(arg_11_0)
	local var_11_0 = arg_11_0:GetCurrentHP()
	local var_11_1 = arg_11_0:GetMaxHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit.GetHPRate(arg_12_0)
	return arg_12_0:GetCurrentHP() / arg_12_0:GetMaxHP()
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetFleetVO(arg_13_0, arg_13_1)
	var_0_8.super.SetFleetVO(arg_13_0, arg_13_1)

	arg_13_0._fleetCardPuzzleComponent = arg_13_1:GetCardPuzzleComponent()

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.LeaderSetting(arg_14_0)
	arg_14_0._warningValue = 1

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.SetMainFleetUnit(arg_15_0, arg_15_1)
	arg_15_0._isMainFleetUnit = true

	arg_15_0:SetMainUnitStatic(true)

	arg_15_0._mainUnitWarningValue = 1

	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.CheckWeaponInitial(arg_16_0)
	return
end

function ys.Battle.BattleCardPuzzlePlayerUnit.setWeapon(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._tmpData.default_equip) do
		if iter_17_1 ~= 0 then
			local var_17_0 = var_0_1.GetWeaponDataFromID(iter_17_1)

			for iter_17_2, iter_17_3 in ipairs(var_17_0) do
				if iter_17_3 ~= -1 then
					local var_17_1 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_17_3, arg_17_0, nil, iter_17_0)

					arg_17_0._totalWeapon[#arg_17_0._totalWeapon + 1] = var_17_1

					if weaponType == var_0.EquipmentType.STRIKE_AIRCRAFT then
						-- block empty
					else
						assert(#var_17_0 < 2, "自动武器一组不允许配置多个")
						arg_17_0:AddAutoWeapon(var_17_1)
					end

					if weaponType == var_0.EquipmentType.INTERCEPT_AIRCRAFT or weaponType == var_0.EquipmentType.STRIKE_AIRCRAFT then
						arg_17_0._hiveList[#arg_17_0._hiveList + 1] = var_17_1
					end

					if weaponType == var_0.EquipmentType.ANTI_AIR then
						arg_17_0._AAList[#arg_17_0._AAList + 1] = var_17_1
					end
				end
			end
		end
	end

	return
end

return
