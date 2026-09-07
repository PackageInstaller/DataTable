ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleEnemyCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleEnemyCharacterFactory = var_0_1
var_0_1.__name = "BattleEnemyCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/EnemyArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleEnemyCharacter.New()
end

function var_0_1:MakeModel(arg_3_1)
	local var_3_0 = arg_3_1:GetUnitData()

	local function var_3_1(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		self:GetSceneMediator():AddEnemyCharacter(arg_3_1)
		self:MakeUIComponentContainer(arg_3_1)
		self:MakeFXContainer(arg_3_1)
		self:MakePopNumPool(arg_3_1)
		self:MakeBloodBar(arg_3_1)
		self:MakeWaveFX(arg_3_1)
		self:MakeSmokeFX(arg_3_1)
		self:MakeArrowBar(arg_3_1)
		arg_3_1:UpdateDiveInvisible(true)
		arg_3_1:UpdateCharacterForceDetected()
		arg_3_1:UpdateBlindInvisible()

		for iter_4_0, iter_4_1 in ipairs(var_3_0:GetTemplate().appear_fx) do
			arg_3_1:AddFX(iter_4_1)
		end

		if arg_3_1:GetUnitData():GetAimBias() then
			self:MakeAimBiasBar(arg_3_1)
		end

		return
	end

	self:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_1:MakeArrowBar(arg_6_1)
	arg_6_1:AddArrowBar((self:GetArrowPool():GetArrow()))
	arg_6_1:UpdateArrowBarPosition()

	return
end

function var_0_1.GetArrowPool(arg_7_0)
	return var_0_0.Battle.BattleArrowManager.GetInstance()
end

function var_0_1:MakeBloodBar(arg_8_1)
	local var_8_0 = self:GetHPBarPool():GetHPBar(self.HP_BAR_NAME)
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

function var_0_1.MakeAimBiasBar(arg_9_0, arg_9_1)
	arg_9_1:AddAimBiasBar((arg_9_1._HPBarTf:Find("biasBar")))
	arg_9_1:AddAimBiasFogFX()

	return
end

function var_0_1.MakeWaveFX(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetUnitData():GetTemplate().wave_fx

	if var_10_0 ~= "" then
		arg_10_1:AddWaveFX(var_10_0)
	end

	return
end

function var_0_1.RemoveCharacter(arg_11_0, arg_11_1)
	var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_1.super.RemoveCharacter(arg_11_0, arg_11_1)

	return
end

return
