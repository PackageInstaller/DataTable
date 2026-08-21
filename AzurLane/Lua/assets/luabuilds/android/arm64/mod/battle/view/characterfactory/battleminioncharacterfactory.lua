ys = ys or {}

local var_0_0 = singletonClass("BattleMinionCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleMinionCharacterFactory = var_0_0
var_0_0.__name = "BattleMinionCharacterFactory"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function var_0_0.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleMinionCharacter.New()
end

function var_0_0.MakeModel(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetUnitData()

	local function var_3_1(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		arg_3_0:GetSceneMediator():AddEnemyCharacter(arg_3_1)
		arg_3_0:MakeUIComponentContainer(arg_3_1)
		arg_3_0:MakeFXContainer(arg_3_1)
		arg_3_0:MakePopNumPool(arg_3_1)
		arg_3_0:MakeBloodBar(arg_3_1)
		arg_3_0:MakeWaveFX(arg_3_1)
		arg_3_0:MakeSmokeFX(arg_3_1)
		arg_3_1:UpdateDiveInvisible(true)
		arg_3_1:UpdateBlindInvisible()

		for iter_4_0, iter_4_1 in ipairs(var_3_0:GetTemplate().appear_fx) do
			arg_3_1:AddFX(iter_4_1)
		end

		if arg_3_1:GetUnitData():GetAimBias() then
			arg_3_0:MakeAimBiasBar(arg_3_1)
		end

		return
	end

	arg_3_0:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_0.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_9000
	local var_6_0 = arg_6_1:GetUnitData()
	local var_6_1 = var_6_0:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE and var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY or var_0.Battle.BattleHPBarManager.HP_BAR_FOE
	local var_6_2 = arg_6_0:GetHPBarPool()
	local var_6_3 = var_6_2.GetHPBar(var_6_9000, var_6_1)
	local var_6_4 = var_6_0:GetTemplate().icon_type

	if var_6_2 then
		SetActive(findTF(var_6_3, "type"), false)
	end

	arg_6_1:AddHPBar(var_6_3)
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_0.MakeAimBiasBar(arg_7_0, arg_7_1)
	arg_7_1:AddAimBiasBar((arg_7_1._HPBarTf:Find("biasBar")))
	arg_7_1:AddAimBiasFogFX()

	return
end

function var_0_0.MakeWaveFX(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetUnitData():GetTemplate().wave_fx

	if var_8_0 ~= "" then
		arg_8_1:AddWaveFX(var_8_0)
	end

	return
end

function var_0_0.RemoveCharacter(arg_9_0, arg_9_1)
	var_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_0.super.RemoveCharacter(arg_9_0, arg_9_1)

	return
end

return
