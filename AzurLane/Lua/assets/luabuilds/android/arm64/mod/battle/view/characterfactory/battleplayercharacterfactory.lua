ys = ys or {}

local var_0_0 = singletonClass("BattlePlayerCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattlePlayerCharacterFactory = var_0_0
var_0_0.__name = "BattlePlayerCharacterFactory"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY
	arg_1_0.CD_BAR_NAME = "CDBarContainer/chargeWeaponCD"
	arg_1_0.CHARGE_AREA_NAME = "ChargeAreaContainer/ChargeArea"
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"
	arg_1_0.SUB_ARROW_BAR = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_0.MakeCharacter(arg_2_0)
	return var_0.Battle.BattlePlayerCharacter.New()
end

function var_0_0.MakeModel(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		arg_3_0:GetSceneMediator():AddPlayerCharacter(arg_3_1)
		arg_3_0:MakeUIComponentContainer(arg_3_1)
		arg_3_0:MakeFXContainer(arg_3_1)
		arg_3_0:MakePopNumPool(arg_3_1)
		arg_3_0:MakeBloodBar(arg_3_1)
		arg_3_0:MakeArrowBar(arg_3_1)
		arg_3_0:MakeWaveFX(arg_3_1)
		arg_3_0:MakeSmokeFX(arg_3_1)
		arg_3_0:MakeSkinOrbit(arg_3_1)

		local var_4_0 = arg_3_1:GetUnitData()

		if var_4_0:GetCloak() then
			arg_3_0:MakeCloakBar(arg_3_1)
		end

		arg_3_1:UpdateDiveInvisible()

		if #var_4_0:GetTorpedoList() > 0 then
			arg_3_0:MakeTorpedoTrack(arg_3_1)
		end

		if var_4_0:GetAimBias() then
			if var_4_0:GetAimBias():GetHost() == var_4_0 then
				arg_3_0:MakeAimBiasBar(arg_3_1)
			end
		end

		return
	end

	arg_3_0:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_0.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetHPBarPool():GetHPBar(arg_6_0.HP_BAR_NAME)

	LuaHelper.SetTFChildActive(var_6_0.transform, "torpedoIcons", true)
	arg_6_1:AddHPBar(var_6_0)

	return
end

function var_0_0.MakeAimBiasBar(arg_7_0, arg_7_1)
	arg_7_1:AddAimBiasBar((arg_7_1._HPBarTf:Find("biasBar")))

	return
end

function var_0_0.MakeShieldBar(arg_8_0, arg_8_1)
	arg_8_1:AddShieldBar((arg_8_1._HPBarTf:Find("shieldBar")))

	return
end

function var_0_0.MakeChargeArea(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetSceneMediator():InstantiateCharacterComponent(arg_9_0.CHARGE_AREA_NAME)

	var_9_0.transform.localEulerAngles = Vector3(60, 0, 0)

	arg_9_1:AddChargeArea(var_9_0)

	return
end

function var_0_0.MakeTorpedoTrack(arg_10_0, arg_10_1)
	arg_10_1:AddTorpedoTrack((arg_10_0:GetFXPool():GetFX("SquareAlert", arg_10_1:GetTf())))

	return
end

function var_0_0.RemoveCharacter(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetSceneMediator()

	if arg_11_2 and arg_11_2 ~= var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		var_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	end

	var_0_0.super.RemoveCharacter(arg_11_0, arg_11_1, arg_11_2)

	return
end

return
