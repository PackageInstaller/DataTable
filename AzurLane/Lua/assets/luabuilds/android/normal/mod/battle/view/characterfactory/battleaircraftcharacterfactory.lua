ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

singletonClass = var_0_10002

local var_0_2 = var_0_10002("BattleAircraftCharacterFactory", var_0.Battle.BattleCharacterFactory)

var_0.Battle.BattleAircraftCharacterFactory = var_0_2
var_0_2.__name = "BattleAircraftCharacterFactory"
var_0_2.BOMB_FX_NAME = "feijibaozha"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleAircraftCharacter.New()
end

function var_0_2.MakeModel(arg_3_0, arg_3_1)
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

		var_2.MakeShadow(var_4_9, arg_3_1)

		local var_4_10 = arg_3_1
		local var_4_11 = var_2.GetUnitData(var_4_10)

		if var_2.GetIFF(var_4_11) == var_0_1.FOE_CODE then
			local var_4_12 = arg_3_0

			var_2.MakePopNumPool(var_4_12, arg_3_1)

			local var_4_13 = arg_3_0

			var_2.MakeBloodBar(var_4_13, arg_3_1)
		end

		return
	end

	local var_3_1 = arg_3_0:GetCharacterPool()

	var_3.InstAirCharacter(var_3_1, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_2.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = arg_6_1:GetUnitData()

	if var_3.IsPlayerAircraft(var_6_1) then
		local var_6_2 = arg_6_0:GetHPBarPool()

		var_6_0 = var_3.GetHPBar(var_6_2, var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY)
	else
		local var_6_3 = arg_6_0:GetHPBarPool()

		var_6_0 = var_3.GetHPBar(var_6_3, var_0.Battle.BattleHPBarManager.HP_BAR_FOE)
	end

	arg_6_1:AddHPBar(var_6_0)
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_2.SetHPBarWidth(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 40
	local var_7_1 = arg_7_1.transform.rect.height

	Vector2 = var_1_10006
	var_4.sizeDelta = var_1_10006(var_7_0, var_7_1)

	local var_7_2 = var_4:Find("blood").transform.rect.height

	Vector2 = var_7

	local var_7_3

	if not (var_7_0 - arg_7_2) then
		var_7_3 = 0
	end

	var_6.sizeDelta = var_7(var_7_3, var_7_2)

	return
end

function var_0_2.MakeShadow(arg_8_0, arg_8_1)
	arg_8_1:AddShadow()
	arg_8_1:UpdateShadow()

	return
end

return
