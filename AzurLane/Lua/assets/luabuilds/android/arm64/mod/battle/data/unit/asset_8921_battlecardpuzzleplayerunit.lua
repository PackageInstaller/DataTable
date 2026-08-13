ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleAttr
local var_0_4 = var_0.Battle.BattleConst.EquipmentType
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleCardPuzzleEvent
local var_0_7 = var_0.Battle.BattleAttr
local var_0_8 = var_0.Battle

class = var_0_10010
var_0_8.BattleCardPuzzlePlayerUnit = var_0_10010("BattleCardPuzzlePlayerUnit", var_0.Battle.BattlePlayerUnit)
var_0.Battle.BattleCardPuzzlePlayerUnit.__name = "BattleCardPuzzlePlayerUnit"

local var_0_9 = var_0.Battle.BattleCardPuzzlePlayerUnit

function var_0_9.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_9.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_9.UpdateHP(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0:IsAlive() then
		return
	end

	if not arg_2_0:IsAlive() then
		return
	end

	local var_2_0 = arg_2_2.isMiss
	local var_2_1 = arg_2_2.isCri
	local var_2_2 = arg_2_2.isHeal
	local var_2_3 = arg_2_2.isShare
	local var_2_4 = arg_2_2.attr
	local var_2_5 = arg_2_2.font
	local var_2_6 = arg_2_2.cldPos
	local var_2_7 = arg_2_1
	local var_2_8 = arg_2_0:GetCurrentHP()

	if not var_2_2 then
		var_1_10014 = {
			damage = -arg_2_1,
			isShare = var_2_3,
			miss = var_2_0,
			cri = var_2_1,
			damageSrc = arg_2_2.srcID,
			damageAttr = var_2_4
		}
		var_1_10017 = arg_2_0

		arg_2_0.TriggerBuff(var_1_10017, var_0.BuffEffectType.ON_TAKE_DAMAGE, var_1_10014)

		if var_2_8 <= var_1_10014.damage then
			var_1_10017 = arg_2_0

			arg_2_0.TriggerBuff(var_1_10017, var_0.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_2_1 = -var_1_10014.damage

		if var_0_7.IsInvincible(arg_2_0) then
			return 0
		end
	else
		var_1_10014 = {
			damage = arg_2_1,
			isHeal = var_2_2
		}
		var_1_10017 = arg_2_0

		arg_2_0.TriggerBuff(var_1_10017, var_0.BuffEffectType.ON_TAKE_HEALING, var_1_10014)

		var_2_2 = var_1_10014.isHeal
		arg_2_1 = var_1_10014.damage
	end

	math = var_1_10014

	local var_2_9 = var_1_10014.min
	local var_2_10 = arg_2_0:GetMaxHP()

	math = var_1_10017

	local var_2_11 = var_2_9(var_2_10, var_1_10017.max(0, var_2_8 + arg_2_1)) - var_2_8
	local var_2_12 = {
		preShieldHP = var_2_7,
		dHP = arg_2_1,
		validDHP = var_2_11,
		isMiss = var_2_0,
		isCri = var_2_1,
		isHeal = var_2_2,
		font = var_2_5
	}

	if var_2_6 and not var_2_6:EqualZero() then
		local var_2_13 = arg_2_0:GetPosition()
		local var_2_14 = arg_2_0:GetBoxSize().x
		local var_2_15 = var_2_13.x - var_2_14
		local var_2_16 = var_2_13.x + var_2_14
		local var_2_17 = var_2_6:Clone()

		Mathf = var_1_10022
		var_2_17.x = var_1_10022.Clamp(var_2_17.x, var_2_15, var_2_16)
		var_2_12.posOffset = var_2_13 - var_2_17
	end

	arg_2_0:UpdateHPAction(var_2_12)

	if not arg_2_0:IsAlive() and var_4 then
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

function var_0_9.UpdateHPAction(arg_3_0, arg_3_1)
	arg_3_0:DispatchEvent(var_0.Event.New(var_0_6.UPDATE_COMMON_HP, arg_3_1))
	var_0_9.super.UpdateHPAction(arg_3_0, arg_3_1)

	return
end

function var_0_9.SetTemplate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._tmpID = arg_4_1
	Clone = var_1_10004
	arg_4_0._tmpData = var_1_10004(var_0_1.GetPuzzleShipDataTemplate(arg_4_0._tmpID))
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

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(arg_4_0._tmpData.tag) do
		arg_4_0:AddLabelTag(iter_4_1)
	end

	return
end

function var_0_9.GetTemplate(arg_5_0)
	return arg_5_0._tmpData
end

function var_0_9.InitCurrentHP(arg_6_0)
	return
end

function var_0_9.InitFleetCurrentHP(arg_7_0, arg_7_1)
	arg_7_0:TriggerBuff(var_0.BuffEffectType.ON_HP_RATIO_UPDATE, {})

	return
end

function var_0_9.SetCurrentHP(arg_8_0, arg_8_1)
	return
end

function var_0_9.GetCurrentHP(arg_9_0)
	local var_9_0 = arg_9_0._fleetCardPuzzleComponent

	return var_1.GetCurrentCommonHP(var_9_0)
end

function var_0_9.GetMaxHP(arg_10_0)
	local var_10_0 = arg_10_0._fleetCardPuzzleComponent

	return var_1.GetTotalCommonHP(var_10_0)
end

function var_0_9.GetHP(arg_11_0)
	local var_11_0 = arg_11_0:GetCurrentHP()
	local var_11_1 = arg_11_0:GetMaxHP()
end

function var_0_9.GetHPRate(arg_12_0)
	return arg_12_0:GetCurrentHP() / arg_12_0:GetMaxHP()
end

function var_0_9.SetFleetVO(arg_13_0, arg_13_1)
	var_0_9.super.SetFleetVO(arg_13_0, arg_13_1)

	arg_13_0._fleetCardPuzzleComponent = arg_13_1:GetCardPuzzleComponent()

	return
end

function var_0_9.LeaderSetting(arg_14_0)
	arg_14_0._warningValue = 1

	return
end

function var_0_9.SetMainFleetUnit(arg_15_0, arg_15_1)
	arg_15_0._isMainFleetUnit = true

	arg_15_0:SetMainUnitStatic(true)

	arg_15_0._mainUnitWarningValue = 1

	return
end

function var_0_9.CheckWeaponInitial(arg_16_0)
	return
end

function var_0_9.setWeapon(arg_17_0)
	local var_17_0 = arg_17_0._tmpData.default_equip

	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(var_17_0) do
		if iter_17_1 ~= 0 then
			local var_17_1 = var_0_1.GetWeaponDataFromID(iter_17_1)

			ipairs = var_1_10008

			for iter_17_2, iter_17_3 in var_1_10008(var_17_1) do
				if iter_17_3 ~= -1 then
					local var_17_2 = var_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_17_3, arg_17_0, nil, iter_17_0)
					local var_17_3 = arg_17_0._totalWeapon

					var_17_3[#arg_17_0._totalWeapon + 1] = var_17_2
					weaponType = var_17_3

					if var_17_3 == var_0.EquipmentType.STRIKE_AIRCRAFT then
						-- block empty
					else
						assert = var_17_3

						var_17_3(#var_17_1 < 2, "自动武器一组不允许配置多个")
						arg_17_0:AddAutoWeapon(var_17_2)
					end

					weaponType = var_17_3

					if var_17_3 ~= var_0.EquipmentType.INTERCEPT_AIRCRAFT then
						weaponType = var_17_3

						if var_17_3 == var_0.EquipmentType.STRIKE_AIRCRAFT then
							var_17_3 = arg_17_0._hiveList
							var_17_3[#arg_17_0._hiveList + 1] = var_17_2
						end

						weaponType = var_17_3

						if var_17_3 == var_0.EquipmentType.ANTI_AIR then
							arg_17_0._AAList[#arg_17_0._AAList + 1] = var_17_2
						end
					end
				end
			end
		end
	end

	return
end

return
