ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleUnitEvent
local var_0_7 = var_0.Battle.UnitState

class = var_0_10008

local var_0_8 = var_0_10008("BattleEnemyUnit", var_0.Battle.BattleUnit)

var_0.Battle.BattleEnemyUnit = var_0_8
var_0_8.__name = "BattleEnemyUnit"

function var_0_8.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_8.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0_2.UnitType.ENEMY_UNIT

	local var_1_0 = arg_1_0._battleProxy

	arg_1_0._level = var_3.GetDungeonLevel(var_1_0)

	return
end

function var_0_8.Dispose(arg_2_0)
	if arg_2_0._aimBias then
		local var_2_0 = arg_2_0._aimBias

		var_1.Dispose(var_2_0)
	end

	var_0_8.super.Dispose(arg_2_0)

	return
end

function var_0_8.SetBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	var_0_8.super.SetBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)

	arg_3_0._weaponRightBound = arg_3_4
	arg_3_0._weaponLowerBound = arg_3_2

	return
end

function var_0_8.UpdateAction(arg_4_0)
	if arg_4_0._oxyState then
		local var_4_0 = arg_4_0._oxyState

		if var_1.GetCurrentDiveState(var_4_0) == var_0_2.OXY_STATE.DIVE then
			if arg_4_0:GetSpeed().x > 0 then
				local var_4_1 = arg_4_0._unitState

				var_1.ChangeState(var_4_1, var_0_7.STATE_DIVELEFT)
			else
				local var_4_2 = arg_4_0._unitState

				var_1.ChangeState(var_4_2, var_0_7.STATE_DIVE)
			end

			goto label_4_0
		end
	end

	if arg_4_0:GetSpeed().x > 0 then
		local var_4_3 = arg_4_0._unitState

		var_1.ChangeState(var_4_3, var_0_7.STATE_MOVELEFT)
	else
		local var_4_4 = arg_4_0._unitState

		var_1.ChangeState(var_4_4, var_0_7.STATE_MOVE)
	end

	::label_4_0::

	return
end

function var_0_8.UpdateHP(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = var_0_8.super.UpdateHP(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	if arg_5_0._phaseSwitcher then
		local var_5_1 = arg_5_0._phaseSwitcher

		var_6.UpdateHP(var_5_1, arg_5_0:GetHPRate())
	end

	return var_5_0
end

function var_0_8.SetMaster(arg_6_0, arg_6_1)
	arg_6_0._master = arg_6_1

	return
end

function var_0_8.GetMaster(arg_7_0)
	return arg_7_0._master
end

function var_0_8.SetTemplate(arg_8_0, arg_8_1, arg_8_2)
	var_0_8.super.SetTemplate(arg_8_0, arg_8_1)

	arg_8_0._tmpData = var_0_1.GetMonsterTmpDataFromID(arg_8_0._tmpID)

	arg_8_0:configWeaponQueueParallel()
	arg_8_0:InitCldComponent()
	arg_8_0:SetAttr()

	arg_8_2 = arg_8_2 or {}

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetExtraInfo(var_8_0)

	pairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(arg_8_2) do
		var_8_1[iter_8_0] = iter_8_1
	end

	arg_8_0:setStandardLabelTag()

	return
end

function var_0_8.SetTeamVO(arg_9_0, arg_9_1)
	arg_9_0._team = arg_9_1

	return
end

function var_0_8.SetFormationIndex(arg_10_0, arg_10_1)
	arg_10_0._formationIndex = arg_10_1

	return
end

function var_0_8.SetWaveIndex(arg_11_0, arg_11_1)
	arg_11_0._waveIndex = arg_11_1

	return
end

function var_0_8.SetAttr(arg_12_0)
	var_0_4.SetEnemyAttr(arg_12_0)
	var_0_4.InitDOTAttr(arg_12_0._attr, arg_12_0._tmpData)

	return
end

function var_0_8.GetTemplate(arg_13_0)
	return arg_13_0._tmpData
end

function var_0_8.GetRarity(arg_14_0)
	return arg_14_0._tmpData.rarity
end

function var_0_8.GetLevel(arg_15_0)
	local var_15_0

	if not arg_15_0._overrideLevel and not arg_15_0._level then
		var_15_0 = 1
	end

	return var_15_0
end

function var_0_8.GetTeam(arg_16_0)
	return arg_16_0._team
end

function var_0_8.GetWaveIndex(arg_17_0)
	return arg_17_0._waveIndex
end

function var_0_8.IsShowHPBar(arg_18_0)
	return arg_18_0._IFF ~= var_0_5.FRIENDLY_CODE
end

function var_0_8.IsSpectre(arg_19_0)
	local var_19_0
	local var_19_1 = var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY

	if arg_19_0:GetAttr()[var_19_1] ~= nil then
		var_19_0 = arg_19_0:GetAttrByName(var_19_1)
	else
		var_19_0 = arg_19_0._tmpData.battle_unit_type
	end

	return var_19_0 <= var_0_5.SPECTRE_UNIT_TYPE, var_19_0
end

function var_0_8.InitCldComponent(arg_20_0)
	var_0_8.super.InitCldComponent(arg_20_0)

	local var_20_0 = {
		type = var_0_2.CldType.SHIP,
		IFF = arg_20_0:GetIFF(),
		UID = arg_20_0:GetUniqueID(),
		Mass = var_0_2.CldMass.L1,
		IsBoss = arg_20_0._isBoss
	}
	local var_20_1 = arg_20_0._cldComponent

	var_2.SetCldData(var_20_1, var_20_0)

	if arg_20_0:GetTemplate().friendly_cld ~= 0 then
		local var_20_2 = arg_20_0._cldComponent

		var_3.ActiveFriendlyCld(var_20_2)
	end

	return
end

function var_0_8.ConfigBubbleFX(arg_21_0)
	arg_21_0._bubbleFX = arg_21_0._tmpData.bubble_fx[1]

	local var_21_0 = arg_21_0._oxyState

	var_1.SetBubbleTemplate(var_21_0, arg_21_0._tmpData.bubble_fx[2], arg_21_0._tmpData.bubble_fx[3])

	return
end

return
