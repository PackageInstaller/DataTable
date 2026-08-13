ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleAirFighterCharacterFactory = var_0_10002("BattleAirFighterCharacterFactory", var_0.Battle.BattleAircraftCharacterFactory)
var_0.Battle.BattleAirFighterCharacterFactory.__name = "BattleAirFighterCharacterFactory"

function var_0.Battle.BattleAirFighterCharacterFactory.Ctor(arg_1_0)
	var_0.Battle.BattleAirFighterCharacterFactory.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FOE

	return
end

function var_0.Battle.BattleAirFighterCharacterFactory.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleAirFighterCharacter.New()
end

function var_0.Battle.BattleAirFighterCharacterFactory.MakeModel(arg_3_0, arg_3_1)
	local function var_3_0(arg_4_0)
		local var_4_0 = arg_3_1

		var_1.AddModel(var_4_0, arg_4_0)

		local var_4_1 = arg_3_1

		var_1.InitWeapon(var_4_1)

		local var_4_2 = arg_3_0
		local var_4_3 = var_1.GetSceneMediator(var_4_2)
		local var_4_4 = arg_3_1
		local var_4_5 = var_2.CameraOrthogonal
		local var_4_6 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_4_5(var_4_4, var_4.GetCamera(var_4_6))
		var_4_3:AddAirCraftCharacter(arg_3_1)

		local var_4_7 = arg_3_0

		var_2.MakeUIComponentContainer(var_4_7, arg_3_1)

		local var_4_8 = arg_3_0

		var_2.MakeFXContainer(var_4_8, arg_3_1)

		local var_4_9 = arg_3_0

		var_2.MakePopNumPool(var_4_9, arg_3_1)

		local var_4_10 = arg_3_0

		var_2.MakeBloodBar(var_4_10, arg_3_1)

		local var_4_11 = arg_3_0

		var_2.MakeShadow(var_4_11, arg_3_1)

		return
	end

	local var_3_1 = arg_3_0:GetCharacterPool()

	var_3.InstAirCharacter(var_3_1, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0.Battle.BattleAirFighterCharacterFactory.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetHPBarPool()
	local var_6_1 = var_2.GetHPBar(var_6_0, arg_6_0.HP_BAR_NAME)

	arg_6_1:AddHPBar(var_6_1)
	var_6_1:SetActive(false)
	arg_6_1:UpdateHPBarPosition()

	return
end

return
