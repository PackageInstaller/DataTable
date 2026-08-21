ys = ys or {}
ys.Battle.BattleNPCCharacter = class("BattleNPCCharacter", ys.Battle.BattleEnemyCharacter)
ys.Battle.BattleNPCCharacter.__name = "BattleNPCCharacter"

local var_0_1 = ys.Battle.BattleNPCCharacter

function ys.Battle.BattleNPCCharacter.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function ys.Battle.BattleNPCCharacter.SetHPColor(arg_2_0, arg_2_1)
	arg_2_0._HPColor = arg_2_1

	return
end

function ys.Battle.BattleNPCCharacter.GetHPColor(arg_3_0)
	return arg_3_0._HPColor
end

function ys.Battle.BattleNPCCharacter.SetModleID(arg_4_0, arg_4_1)
	arg_4_0._prefab = arg_4_1

	return
end

function ys.Battle.BattleNPCCharacter.GetModleID(arg_5_0)
	if arg_5_0._prefab then
		return arg_5_0._prefab
	else
		return arg_5_0._unitData:GetTemplate().prefab
	end

	return
end

function ys.Battle.BattleNPCCharacter.SetUnvisible(arg_6_0)
	arg_6_0._isUnvisible = true

	return
end

function ys.Battle.BattleNPCCharacter.MakeVisible(arg_7_0)
	if arg_7_0._isUnvisible then
		arg_7_0._go:SetActive(false)
		arg_7_0._HPBar:SetActive(false)
		arg_7_0._buffBar:SetActive(false)
	end

	return
end

return
