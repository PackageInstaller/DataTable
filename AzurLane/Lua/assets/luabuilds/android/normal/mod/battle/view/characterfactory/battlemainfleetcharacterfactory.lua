ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleMainFleetCharacterFactory = var_0_10002("BattleMainFleetCharacterFactory", var_0.Battle.BattlePlayerCharacterFactory)
var_0.Battle.BattleMainFleetCharacterFactory.__name = "BattleMainFleetCharacterFactory"

local var_0_2 = var_0.Battle.BattleMainFleetCharacterFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"

	return
end

function var_0_2.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleMainFleetCharacter.New()
end

function var_0_2.MakeModel(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		local var_4_0 = arg_3_1

		var_1.AddModel(var_4_0, arg_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_1.GetSceneMediator(var_4_1)
		local var_4_3 = arg_3_1
		local var_4_4 = var_2.CameraOrthogonal
		local var_4_5 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_4_4(var_4_3, var_4.GetCamera(var_4_5))
		var_4_2:AddPlayerCharacter(arg_3_1)

		local var_4_6 = arg_3_0

		var_2.MakeUIComponentContainer(var_4_6, arg_3_1)

		local var_4_7 = arg_3_0

		var_2.MakeFXContainer(var_4_7, arg_3_1)

		local var_4_8 = arg_3_0

		var_2.MakePopNumPool(var_4_8, arg_3_1)

		local var_4_9 = arg_3_0

		var_2.MakeBloodBar(var_4_9, arg_3_1)

		local var_4_10 = arg_3_0

		var_2.MakeWaveFX(var_4_10, arg_3_1)

		local var_4_11 = arg_3_0

		var_2.MakeSmokeFX(var_4_11, arg_3_1)

		local var_4_12 = arg_3_0

		var_2.MakeArrowBar(var_4_12, arg_3_1)

		return
	end

	local var_3_1 = arg_3_0:GetCharacterPool()

	var_4.InstCharacter(var_3_1, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

return
