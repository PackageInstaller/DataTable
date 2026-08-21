ys = ys or {}

local var_0_0 = singletonClass("BattleEnemyCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleEnemyCharacterFactory = var_0_0
var_0_0.__name = "BattleEnemyCharacterFactory"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FOE
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/EnemyArrow"

	return
end

function var_0_0.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleEnemyCharacter.New()
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
		arg_3_0:MakeArrowBar(arg_3_1)
		arg_3_1:UpdateDiveInvisible(true)
		arg_3_1:UpdateCharacterForceDetected()
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

function var_0_0.MakeArrowBar(arg_6_0, arg_6_1)
	arg_6_1:AddArrowBar((arg_6_0:GetArrowPool():GetArrow()))
	arg_6_1:UpdateArrowBarPosition()

	return
end

function var_0_0.GetArrowPool(arg_7_0)
	return var_0.Battle.BattleArrowManager.GetInstance()
end

function var_0_0.MakeBloodBar(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetHPBarPool():GetHPBar(arg_8_0.HP_BAR_NAME)
	local var_8_1 = findTF(var_8_0, "type")

	if arg_8_1:GetUnitData():GetTemplate().icon_type ~= 0 then
		local var_8_2 = GetSpriteFromAtlas("shiptype", shipType2print(arg_8_1:GetUnitData():GetTemplate().icon_type))

		setImageSprite(var_8_1, var_8_2, true)
		setImageSprite(findTF(var_8_1, "type"), var_8_2, true)
		SetActive(var_8_1, true)
	else
		SetActive(var_8_1, false)
	end

	arg_8_1:AddHPBar(var_8_0)
	arg_8_1:UpdateHPBarPosition()

	return
end

function var_0_0.MakeAimBiasBar(arg_9_0, arg_9_1)
	arg_9_1:AddAimBiasBar((arg_9_1._HPBarTf:Find("biasBar")))
	arg_9_1:AddAimBiasFogFX()

	return
end

function var_0_0.MakeWaveFX(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetUnitData():GetTemplate().wave_fx

	if var_10_0 ~= "" then
		arg_10_1:AddWaveFX(var_10_0)
	end

	return
end

function var_0_0.RemoveCharacter(arg_11_0, arg_11_1)
	var_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_0.super.RemoveCharacter(arg_11_0, arg_11_1)

	return
end

return
