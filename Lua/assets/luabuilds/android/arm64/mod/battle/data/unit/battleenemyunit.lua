ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.UnitState
local var_0_7 = class("BattleEnemyUnit", ys.Battle.BattleUnit)

ys.Battle.BattleEnemyUnit = var_0_7
var_0_7.__name = "BattleEnemyUnit"

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0_1.UnitType.ENEMY_UNIT
	arg_1_0._level = arg_1_0._battleProxy:GetDungeonLevel()

	return
end

function var_0_7.Dispose(arg_2_0)
	if arg_2_0._aimBias then
		arg_2_0._aimBias:Dispose()
	end

	var_0_7.super.Dispose(arg_2_0)

	return
end

function var_0_7.SetBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	var_0_7.super.SetBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)

	arg_3_0._weaponRightBound = arg_3_4
	arg_3_0._weaponLowerBound = arg_3_2

	return
end

function var_0_7.UpdateAction(arg_4_0)
	if arg_4_0._oxyState and arg_4_0._oxyState:GetCurrentDiveState() == var_0_1.OXY_STATE.DIVE then
		if arg_4_0:GetSpeed().x > 0 then
			arg_4_0._unitState:ChangeState(var_0_6.STATE_DIVELEFT)
		else
			arg_4_0._unitState:ChangeState(var_0_6.STATE_DIVE)
		end
	elseif arg_4_0:GetSpeed().x > 0 then
		arg_4_0._unitState:ChangeState(var_0_6.STATE_MOVELEFT)
	else
		arg_4_0._unitState:ChangeState(var_0_6.STATE_MOVE)
	end

	return
end

function var_0_7.UpdateHP(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0._phaseSwitcher then
		arg_5_0._phaseSwitcher:UpdateHP(arg_5_0:GetHPRate())
	end

	return (var_0_7.super.UpdateHP(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4))
end

function var_0_7.SetMaster(arg_6_0, arg_6_1)
	arg_6_0._master = arg_6_1

	return
end

function var_0_7.GetMaster(arg_7_0)
	return arg_7_0._master
end

function var_0_7.SetTemplate(arg_8_0, arg_8_1, arg_8_2)
	var_0_7.super.SetTemplate(arg_8_0, arg_8_1)

	arg_8_0._tmpData = var_0_0.GetMonsterTmpDataFromID(arg_8_0._tmpID)

	arg_8_0:configWeaponQueueParallel()
	arg_8_0:InitCldComponent()
	arg_8_0:SetAttr()

	arg_8_2 = arg_8_2 or {}

	local var_8_0 = arg_8_0:GetExtraInfo()

	for iter_8_0, iter_8_1 in pairs(arg_8_2) do
		var_8_0[iter_8_0] = iter_8_1
	end

	arg_8_0:setStandardLabelTag()

	return
end

function var_0_7.SetTeamVO(arg_9_0, arg_9_1)
	arg_9_0._team = arg_9_1

	return
end

function var_0_7.SetFormationIndex(arg_10_0, arg_10_1)
	arg_10_0._formationIndex = arg_10_1

	return
end

function var_0_7.SetWaveIndex(arg_11_0, arg_11_1)
	arg_11_0._waveIndex = arg_11_1

	return
end

function var_0_7.SetAttr(arg_12_0)
	var_0_3.SetEnemyAttr(arg_12_0)
	var_0_3.InitDOTAttr(arg_12_0._attr, arg_12_0._tmpData)

	return
end

function var_0_7.GetTemplate(arg_13_0)
	return arg_13_0._tmpData
end

function var_0_7.GetRarity(arg_14_0)
	return arg_14_0._tmpData.rarity
end

function var_0_7.GetLevel(arg_15_0)
	return arg_15_0._overrideLevel or arg_15_0._level or 1
end

function var_0_7.GetTeam(arg_16_0)
	return arg_16_0._team
end

function var_0_7.GetWaveIndex(arg_17_0)
	return arg_17_0._waveIndex
end

function var_0_7.IsShowHPBar(arg_18_0)
	return arg_18_0._IFF ~= var_0_4.FRIENDLY_CODE
end

function var_0_7.IsSpectre(arg_19_0)
	local var_19_0 = arg_19_0:GetAttr()[var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY] ~= nil and arg_19_0:GetAttrByName(var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) or arg_19_0._tmpData.battle_unit_type

	return var_19_0 <= var_0_4.SPECTRE_UNIT_TYPE, var_19_0
end

function var_0_7.InitCldComponent(arg_20_0)
	var_0_7.super.InitCldComponent(arg_20_0)
	arg_20_0._cldComponent:SetCldData({
		type = var_0_1.CldType.SHIP,
		IFF = arg_20_0:GetIFF(),
		UID = arg_20_0:GetUniqueID(),
		Mass = var_0_1.CldMass.L1,
		IsBoss = arg_20_0._isBoss
	})

	if arg_20_0:GetTemplate().friendly_cld ~= 0 then
		arg_20_0._cldComponent:ActiveFriendlyCld()
	end

	return
end

function var_0_7.ConfigBubbleFX(arg_21_0)
	arg_21_0._bubbleFX = arg_21_0._tmpData.bubble_fx[1]

	arg_21_0._oxyState:SetBubbleTemplate(arg_21_0._tmpData.bubble_fx[2], arg_21_0._tmpData.bubble_fx[3])

	return
end

return
