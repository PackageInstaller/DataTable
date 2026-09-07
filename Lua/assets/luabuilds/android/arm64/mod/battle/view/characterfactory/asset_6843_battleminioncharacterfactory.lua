ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleMinionCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleMinionCharacterFactory = var_0_1
var_0_1.__name = "BattleMinionCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleMinionCharacter.New()
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
		arg_3_1:UpdateDiveInvisible(true)
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

function var_0_1:MakeBloodBar(arg_6_1)
	local var_6_0 = arg_6_1:GetUnitData()
	local var_6_1 = var_6_0:GetIFF() == var_0_0.Battle.BattleConfig.FRIENDLY_CODE and var_0_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY or var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE
	local var_6_2 = self:GetHPBarPool()
	local var_6_3 = var_6_2:GetHPBar(var_6_1)
	local var_6_4 = var_6_0:GetTemplate().icon_type

	if var_6_2 then
		SetActive(findTF(var_6_3, "type"), false)
	end

	arg_6_1:AddHPBar(var_6_3)
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_1.MakeAimBiasBar(arg_7_0, arg_7_1)
	arg_7_1:AddAimBiasBar((arg_7_1._HPBarTf:Find("biasBar")))
	arg_7_1:AddAimBiasFogFX()

	return
end

function var_0_1.MakeWaveFX(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetUnitData():GetTemplate().wave_fx

	if var_8_0 ~= "" then
		arg_8_1:AddWaveFX(var_8_0)
	end

	return
end

function var_0_1.RemoveCharacter(arg_9_0, arg_9_1)
	var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	var_0_1.super.RemoveCharacter(arg_9_0, arg_9_1)

	return
end

return
