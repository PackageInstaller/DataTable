ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleEnemyCharacterFactory", var_0.Battle.BattleCharacterFactory)

var_0.Battle.BattleEnemyCharacterFactory = var_0_1
var_0_1.__name = "BattleEnemyCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FOE
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/EnemyArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleEnemyCharacter.New()
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

		local var_4_12 = arg_3_0

		var_2.MakeArrowBar(var_4_12, arg_3_1)

		local var_4_13 = arg_3_1

		var_2.UpdateDiveInvisible(var_4_13, true)

		local var_4_14 = arg_3_1

		var_2.UpdateCharacterForceDetected(var_4_14)

		local var_4_15 = arg_3_1

		var_2.UpdateBlindInvisible(var_4_15)

		local var_4_16 = var_3_0
		local var_4_17 = var_2.GetTemplate(var_4_16).appear_fx

		ipairs = var_4_1

		for iter_4_0, iter_4_1 in var_4_1(var_4_17) do
			local var_4_18 = arg_3_1

			var_8.AddFX(var_4_18, iter_4_1)
		end

		local var_4_19 = arg_3_1
		local var_4_20 = var_3.GetUnitData(var_4_19)

		if var_3.GetAimBias(var_4_20) then
			local var_4_21 = arg_3_0

			var_3.MakeAimBiasBar(var_4_21, arg_3_1)
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

function var_0_1.MakeArrowBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetArrowPool()
	local var_6_1 = var_2.GetArrow(var_6_0)

	arg_6_1:AddArrowBar(var_6_1)
	arg_6_1:UpdateArrowBarPosition()

	return
end

function var_0_1.GetArrowPool(arg_7_0)
	return var_0.Battle.BattleArrowManager.GetInstance()
end

function var_0_1.MakeBloodBar(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetHPBarPool()
	local var_8_1 = var_2.GetHPBar(var_8_0, arg_8_0.HP_BAR_NAME)
	local var_8_2 = arg_8_1:GetUnitData()
	local var_8_3 = var_3.GetTemplate(var_8_2).icon_type

	findTF = var_8_0

	local var_8_4 = var_8_0(var_8_1, "type")

	if var_8_3 ~= 0 then
		GetSpriteFromAtlas = var_8_2

		local var_8_5 = "shiptype"

		shipType2print = var_1_10008

		local var_8_6 = arg_8_1:GetUnitData()

		var_8_2 = var_8_2(var_8_5, var_1_10008(var_10.GetTemplate(var_8_6).icon_type))
		setImageSprite = var_6

		var_6(var_8_4, var_8_2, true)

		findTF = var_6

		local var_8_7 = var_6(var_8_4, "type")

		setImageSprite = var_8_5

		var_8_5(var_8_7, var_8_2, true)

		SetActive = var_8_5

		var_8_5(var_8_4, true)
	else
		SetActive = var_8_2

		var_8_2(var_8_4, false)
	end

	arg_8_1:AddHPBar(var_8_1)
	arg_8_1:UpdateHPBarPosition()

	return
end

function var_0_1.MakeAimBiasBar(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1._HPBarTf
	local var_9_1 = var_2.Find(var_9_0, "biasBar")

	arg_9_1:AddAimBiasBar(var_9_1)
	arg_9_1:AddAimBiasFogFX()

	return
end

function var_0_1.MakeWaveFX(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetUnitData()

	if var_2.GetTemplate(var_10_0).wave_fx ~= "" then
		arg_10_1:AddWaveFX(var_2)
	end

	return
end

function var_0_1.RemoveCharacter(arg_11_0, arg_11_1)
	local var_11_0 = var_0.Battle.BattleCameraUtil.GetInstance()
	local var_11_1 = var_2.StartShake

	pg = var_1_10005

	var_11_1(var_11_0, var_1_10005.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_1.super.RemoveCharacter(arg_11_0, arg_11_1)

	return
end

return
