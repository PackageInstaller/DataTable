ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattlePlayerCharacterFactory", var_0.Battle.BattleCharacterFactory)

var_0.Battle.BattlePlayerCharacterFactory = var_0_1
var_0_1.__name = "BattlePlayerCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY
	arg_1_0.CD_BAR_NAME = "CDBarContainer/chargeWeaponCD"
	arg_1_0.CHARGE_AREA_NAME = "ChargeAreaContainer/ChargeArea"
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"
	arg_1_0.SUB_ARROW_BAR = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0.Battle.BattlePlayerCharacter.New()
end

function var_0_1.MakeModel(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		local var_4_0 = arg_3_1

		var_1.AddModel(var_4_0, arg_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_1.GetSceneMediator(var_4_1)
		local var_4_3 = arg_3_1
		local var_4_4 = var_2.CameraOrthogonal
		local var_4_5 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_4_4(var_4_3, var_5.GetCamera(var_4_5))
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

		var_2.MakeArrowBar(var_4_10, arg_3_1)

		local var_4_11 = arg_3_0

		var_2.MakeWaveFX(var_4_11, arg_3_1)

		local var_4_12 = arg_3_0

		var_2.MakeSmokeFX(var_4_12, arg_3_1)

		local var_4_13 = arg_3_0

		var_2.MakeSkinOrbit(var_4_13, arg_3_1)

		local var_4_14 = arg_3_1
		local var_4_15 = var_2.GetUnitData(var_4_14)

		if var_2.GetCloak(var_4_15) then
			local var_4_16 = arg_3_0

			var_3.MakeCloakBar(var_4_16, arg_3_1)
		end

		local var_4_17 = arg_3_1

		var_3.UpdateDiveInvisible(var_4_17)

		if #var_2:GetTorpedoList() > 0 then
			local var_4_18 = arg_3_0

			var_3.MakeTorpedoTrack(var_4_18, arg_3_1)
		end

		if var_2:GetAimBias() then
			local var_4_19 = var_2:GetAimBias()

			if var_3.GetHost(var_4_19) == var_2 then
				local var_4_20 = arg_3_0

				var_3.MakeAimBiasBar(var_4_20, arg_3_1)
			end
		end

		return
	end

	local var_3_1 = arg_3_0:GetCharacterPool()

	var_4.InstCharacter(var_3_1, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_1.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetHPBarPool()
	local var_6_1 = var_2.GetHPBar(var_6_0, arg_6_0.HP_BAR_NAME).transform

	LuaHelper = var_6_0

	var_6_0.SetTFChildActive(var_6_1, "torpedoIcons", true)
	arg_6_1:AddHPBar(var_2)

	return
end

function var_0_1.MakeAimBiasBar(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1._HPBarTf
	local var_7_1 = var_2.Find(var_7_0, "biasBar")

	arg_7_1:AddAimBiasBar(var_7_1)

	return
end

function var_0_1.MakeShieldBar(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1._HPBarTf
	local var_8_1 = var_2.Find(var_8_0, "shieldBar")

	arg_8_1:AddShieldBar(var_8_1)

	return
end

function var_0_1.MakeChargeArea(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetSceneMediator()
	local var_9_1 = var_2.InstantiateCharacterComponent(var_9_0, arg_9_0.CHARGE_AREA_NAME).transform

	Vector3 = var_9_0
	var_9_1.localEulerAngles = var_9_0(60, 0, 0)

	arg_9_1:AddChargeArea(var_2)

	return
end

function var_0_1.MakeTorpedoTrack(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetFXPool()
	local var_10_1 = var_2.GetFX(var_10_0, "SquareAlert", arg_10_1:GetTf())

	arg_10_1:AddTorpedoTrack(var_10_1)

	return
end

function var_0_1.RemoveCharacter(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetSceneMediator()

	if arg_11_2 and arg_11_2 ~= var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		local var_11_1 = var_0.Battle.BattleCameraUtil.GetInstance()
		local var_11_2 = var_4.StartShake

		pg = var_1_10007

		var_11_2(var_11_1, var_1_10007.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	end

	var_0_1.super.RemoveCharacter(arg_11_0, arg_11_1, arg_11_2)

	return
end

return
