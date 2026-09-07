ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleMainFleetCharacterFactory = singletonClass("BattleMainFleetCharacterFactory", ys.Battle.BattlePlayerCharacterFactory)
ys.Battle.BattleMainFleetCharacterFactory.__name = "BattleMainFleetCharacterFactory"

local var_0_1 = ys.Battle.BattleMainFleetCharacterFactory

function ys.Battle.BattleMainFleetCharacterFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/MainArrow"

	return
end

function ys.Battle.BattleMainFleetCharacterFactory.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleMainFleetCharacter.New()
end

function ys.Battle.BattleMainFleetCharacterFactory:MakeModel(arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		self:GetSceneMediator():AddPlayerCharacter(arg_3_1)
		self:MakeUIComponentContainer(arg_3_1)
		self:MakeFXContainer(arg_3_1)
		self:MakePopNumPool(arg_3_1)
		self:MakeBloodBar(arg_3_1)
		self:MakeWaveFX(arg_3_1)
		self:MakeSmokeFX(arg_3_1)
		self:MakeArrowBar(arg_3_1)

		return
	end

	self:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

return
