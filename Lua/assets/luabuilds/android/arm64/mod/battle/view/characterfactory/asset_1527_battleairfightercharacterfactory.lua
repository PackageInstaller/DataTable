ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleAirFighterCharacterFactory = singletonClass("BattleAirFighterCharacterFactory", ys.Battle.BattleAircraftCharacterFactory)
ys.Battle.BattleAirFighterCharacterFactory.__name = "BattleAirFighterCharacterFactory"

function ys.Battle.BattleAirFighterCharacterFactory.Ctor(arg_1_0)
	var_0_0.Battle.BattleAirFighterCharacterFactory.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE

	return
end

function ys.Battle.BattleAirFighterCharacterFactory.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleAirFighterCharacter.New()
end

function ys.Battle.BattleAirFighterCharacterFactory:MakeModel(arg_3_1)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:InitWeapon()
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		self:GetSceneMediator():AddAirCraftCharacter(arg_3_1)
		self:MakeUIComponentContainer(arg_3_1)
		self:MakeFXContainer(arg_3_1)
		self:MakePopNumPool(arg_3_1)
		self:MakeBloodBar(arg_3_1)
		self:MakeShadow(arg_3_1)

		return
	end

	self:GetCharacterPool():InstAirCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function ys.Battle.BattleAirFighterCharacterFactory:MakeBloodBar(arg_6_1)
	local var_6_0 = self:GetHPBarPool():GetHPBar(self.HP_BAR_NAME)

	arg_6_1:AddHPBar(var_6_0)
	var_6_0:SetActive(false)
	arg_6_1:UpdateHPBarPosition()

	return
end

return
