ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleBossCharacterFactory", var_0.Battle.BattleEnemyCharacterFactory)

var_0.Battle.BattleBossCharacterFactory = var_0_1
var_0_1.__name = "BattleBossCharacterFactory"
var_0_1.BOMB_FX_NAME = "Bossbomb"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = "BossBarContainer/heroBlood"
	arg_1_0.DUAL_BAR_NAME = {
		"BossBarContainer/heroBlood_ivory",
		"BossBarContainer/heroBlood_ebony"
	}

	return
end

function var_0_1.CreateCharacter(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.unit
	local var_2_1 = arg_2_0:MakeCharacter()

	var_3.SetFactory(var_2_1, arg_2_0)
	var_3:SetUnitData(var_2_0)
	var_3:SetBossData(arg_2_1.bossData)
	arg_2_0:MakeModel(var_3)
	arg_2_0:MakeCastClock(var_3)
	arg_2_0:MakeBarrierClock(var_3)

	return var_3
end

function var_0_1.MakeCharacter(arg_3_0)
	local var_3_0 = var_0.Battle.BattleBossCharacter

	return var_1.New(var_3_0)
end

function var_0_1.MakeBloodBar(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetSceneMediator()

	if arg_4_1:GetBossIndex() then
		arg_4_1:AddHPBar(var_4_0:InstantiateCharacterComponent(arg_4_0.DUAL_BAR_NAME[var_3]))
	else
		arg_4_1:AddHPBar(var_4_0:InstantiateCharacterComponent(arg_4_0.HP_BAR_NAME), true)
	end

	return
end

function var_0_1.MakeAimBiasBar(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetHPBarPool()
	local var_5_1 = var_2.GetHPBar(var_5_0, var_0.Battle.BattleHPBarManager.HP_BAR_FOE).transform

	setActive = var_5_0

	var_5_0(var_5_1:Find("bg"), false)

	setActive = var_5_0

	var_5_0(var_5_1:Find("blood"), false)
	arg_5_1:AddAimBiasBar(var_5_1)
	arg_5_1:AddAimBiasFogFX()

	return
end

function var_0_1.RemoveCharacter(arg_6_0, arg_6_1)
	var_0_1.super.RemoveCharacter(arg_6_0, arg_6_1)

	return
end

return
