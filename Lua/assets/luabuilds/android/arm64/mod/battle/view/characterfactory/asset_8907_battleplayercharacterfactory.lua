ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattlePlayerCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattlePlayerCharacterFactory = var_0_1
var_0_1.__name = "BattlePlayerCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY
	arg_1_0.CD_BAR_NAME = "CDBarContainer/chargeWeaponCD"
	arg_1_0.CHARGE_AREA_NAME = "ChargeAreaContainer/ChargeArea"
	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"
	arg_1_0.SUB_ARROW_BAR = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattlePlayerCharacter.New()
end

function var_0_1:MakeModel(arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		self:GetSceneMediator():AddPlayerCharacter(arg_3_1)
		self:MakeUIComponentContainer(arg_3_1)
		self:MakeFXContainer(arg_3_1)
		self:MakePopNumPool(arg_3_1)
		self:MakeBloodBar(arg_3_1)
		self:MakeArrowBar(arg_3_1)
		self:MakeWaveFX(arg_3_1)
		self:MakeSmokeFX(arg_3_1)
		self:MakeSkinOrbit(arg_3_1)

		local var_4_0 = arg_3_1:GetUnitData()

		if var_4_0:GetCloak() then
			self:MakeCloakBar(arg_3_1)
		end

		arg_3_1:UpdateDiveInvisible()

		if #var_4_0:GetTorpedoList() > 0 then
			self:MakeTorpedoTrack(arg_3_1)
		end

		if var_4_0:GetAimBias() then
			if var_4_0:GetAimBias():GetHost() == var_4_0 then
				self:MakeAimBiasBar(arg_3_1)
			end
		end

		return
	end

	self:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_1:MakeBloodBar(arg_6_1)
	local var_6_0 = self:GetHPBarPool():GetHPBar(self.HP_BAR_NAME)

	LuaHelper.SetTFChildActive(var_6_0.transform, "torpedoIcons", true)
	arg_6_1:AddHPBar(var_6_0)

	return
end

function var_0_1.MakeAimBiasBar(arg_7_0, arg_7_1)
	arg_7_1:AddAimBiasBar((arg_7_1._HPBarTf:Find("biasBar")))

	return
end

function var_0_1.MakeShieldBar(arg_8_0, arg_8_1)
	arg_8_1:AddShieldBar((arg_8_1._HPBarTf:Find("shieldBar")))

	return
end

function var_0_1:MakeChargeArea(arg_9_1)
	local var_9_0 = self:GetSceneMediator():InstantiateCharacterComponent(self.CHARGE_AREA_NAME)

	var_9_0.transform.localEulerAngles = Vector3(60, 0, 0)

	arg_9_1:AddChargeArea(var_9_0)

	return
end

function var_0_1:MakeTorpedoTrack(arg_10_1)
	arg_10_1:AddTorpedoTrack((self:GetFXPool():GetFX("SquareAlert", arg_10_1:GetTf())))

	return
end

function var_0_1:RemoveCharacter(arg_11_1, arg_11_2)
	local var_11_0 = self:GetSceneMediator()

	if arg_11_2 and arg_11_2 ~= var_0_0.Battle.BattleConst.UnitDeathReason.KILLED then
		-- block empty
	else
		var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0_0.Battle.BattleConst.ShakeType.UNIT_DIE])
	end

	var_0_1.super.RemoveCharacter(self, arg_11_1, arg_11_2)

	return
end

return
