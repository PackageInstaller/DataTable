ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleBossCharacterFactory", ys.Battle.BattleEnemyCharacterFactory)

ys.Battle.BattleBossCharacterFactory = var_0_1
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

function var_0_1:CreateCharacter(arg_2_1)
	local var_2_0 = self:MakeCharacter()

	var_2_0:SetFactory(self)
	var_2_0:SetUnitData(arg_2_1.unit)
	var_2_0:SetBossData(arg_2_1.bossData)
	self:MakeModel(var_2_0)
	self:MakeCastClock(var_2_0)
	self:MakeBarrierClock(var_2_0)

	return var_2_0
end

function var_0_1.MakeCharacter(arg_3_0)
	return var_0_0.Battle.BattleBossCharacter:New()
end

function var_0_1:MakeBloodBar(arg_4_1)
	local var_4_0 = self:GetSceneMediator()
	local var_4_1 = arg_4_1:GetBossIndex()

	if var_4_1 then
		arg_4_1:AddHPBar(var_4_0:InstantiateCharacterComponent(self.DUAL_BAR_NAME[var_4_1]))
	else
		arg_4_1:AddHPBar(var_4_0:InstantiateCharacterComponent(self.HP_BAR_NAME), true)
	end

	return
end

function var_0_1:MakeAimBiasBar(arg_5_1)
	local var_5_0 = self:GetHPBarPool():GetHPBar(var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE).transform

	setActive(var_5_0:Find("bg"), false)
	setActive(var_5_0:Find("blood"), false)
	arg_5_1:AddAimBiasBar(var_5_0)
	arg_5_1:AddAimBiasFogFX()

	return
end

function var_0_1.RemoveCharacter(arg_6_0, arg_6_1)
	var_0_1.super.RemoveCharacter(arg_6_0, arg_6_1)

	return
end

return
