ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleMainFleetCharacterFactory = singletonClass("BattleMainFleetCharacterFactory", ys.Battle.BattlePlayerCharacterFactory)
ys.Battle.BattleMainFleetCharacterFactory.__name = "BattleMainFleetCharacterFactory"

local var_0_1 = ys.Battle.BattleMainFleetCharacterFactory

function ys.Battle.BattleMainFleetCharacterFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"

	return
end

function ys.Battle.BattleMainFleetCharacterFactory.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleMainFleetCharacter.New()
end

function ys.Battle.BattleMainFleetCharacterFactory.MakeModel(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		arg_3_0:GetSceneMediator():AddPlayerCharacter(arg_3_1)
		arg_3_0:MakeUIComponentContainer(arg_3_1)
		arg_3_0:MakeFXContainer(arg_3_1)
		arg_3_0:MakePopNumPool(arg_3_1)
		arg_3_0:MakeBloodBar(arg_3_1)
		arg_3_0:MakeWaveFX(arg_3_1)
		arg_3_0:MakeSmokeFX(arg_3_1)
		arg_3_0:MakeArrowBar(arg_3_1)

		return
	end

	arg_3_0:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

return
