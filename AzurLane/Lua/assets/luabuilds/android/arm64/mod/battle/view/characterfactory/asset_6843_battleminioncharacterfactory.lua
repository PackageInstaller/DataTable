ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleMinionCharacterFactory", var_0.Battle.BattleCharacterFactory)

var_0.Battle.BattleMinionCharacterFactory = var_0_1
var_0_1.__name = "BattleMinionCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleMinionCharacter.New()
end

function var_0_1.MakeModel(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetUnitData()

	local function var_3_1(arg_4_0)
		local var_4_0 = arg_3_1

		var_1.AddModel(var_4_0, arg_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_1.GetSceneMediator(var_4_1)
		local var_4_3 = arg_3_1
		local var_4_4 = var_2.CameraOrthogonal
		local var_4_5 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_4_4(var_4_3, var_5.GetCamera(var_4_5))
		var_4_2:AddEnemyCharacter(arg_3_1)

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

		local var_4_12 = arg_3_1

		var_2.UpdateDiveInvisible(var_4_12, true)

		local var_4_13 = arg_3_1

		var_2.UpdateBlindInvisible(var_4_13)

		local var_4_14 = var_3_0
		local var_4_15 = var_2.GetTemplate(var_4_14).appear_fx

		ipairs = var_4_1

		for iter_4_0, iter_4_1 in var_4_1(var_4_15) do
			local var_4_16 = arg_3_1

			var_8.AddFX(var_4_16, iter_4_1)
		end

		local var_4_17 = arg_3_1
		local var_4_18 = var_3.GetUnitData(var_4_17)

		if var_3.GetAimBias(var_4_18) then
			local var_4_19 = arg_3_0

			var_3.MakeAimBiasBar(var_4_19, arg_3_1)
		end

		return
	end

	local var_3_2 = arg_3_0:GetCharacterPool()

	var_4.InstCharacter(var_3_2, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_1.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetUnitData()
	local var_6_1

	if var_6_0:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
		var_6_1 = var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY
	else
		var_6_1 = var_0.Battle.BattleHPBarManager.HP_BAR_FOE
	end

	local var_6_2 = arg_6_0:GetHPBarPool()
	local var_6_3 = var_4.GetHPBar(var_6_2, var_6_1)
	local var_6_4 = var_6_0
	local var_6_5 = var_6_0.GetTemplate(var_6_4).icon_type

	findTF = var_6_2

	if var_6_2(var_6_3, "type") then
		SetActive = var_6_4

		var_6_4(var_6, false)
	end

	arg_6_1:AddHPBar(var_6_3)
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_1.MakeAimBiasBar(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1._HPBarTf
	local var_7_1 = var_2.Find(var_7_0, "biasBar")

	arg_7_1:AddAimBiasBar(var_7_1)
	arg_7_1:AddAimBiasFogFX()

	return
end

function var_0_1.MakeWaveFX(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetUnitData()

	if var_2.GetTemplate(var_8_0).wave_fx ~= "" then
		arg_8_1:AddWaveFX(var_2)
	end

	return
end

function var_0_1.RemoveCharacter(arg_9_0, arg_9_1)
	local var_9_0 = var_0.Battle.BattleCameraUtil.GetInstance()
	local var_9_1 = var_2.StartShake

	pg = var_1_10005

	var_9_1(var_9_0, var_1_10005.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_1.super.RemoveCharacter(arg_9_0, arg_9_1)

	return
end

return
