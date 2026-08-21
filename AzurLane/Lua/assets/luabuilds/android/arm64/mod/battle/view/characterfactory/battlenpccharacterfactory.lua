ys = ys or {}

local var_0_0 = singletonClass("BattleNPCCharacterFactory", ys.Battle.BattleEnemyCharacterFactory)

ys.Battle.BattleNPCCharacterFactory = var_0_0
var_0_0.__name = "BattleNPCCharacterFactory"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FOE

	return
end

function var_0_0.CreateCharacter(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:MakeCharacter()

	var_2_0:SetFactory(arg_2_0)
	var_2_0:SetUnitData(arg_2_1.unit)

	if arg_2_1.extraInfo.modleID then
		var_2_0:SetModleID(arg_2_1.extraInfo.modleID)
	end

	if arg_2_1.extraInfo.HPColor then
		var_2_0:SetHPColor(arg_2_1.extraInfo.HPColor)
	end

	if arg_2_1.extraInfo.isUnvisible then
		var_2_0:SetUnvisible()
	end

	arg_2_0:MakeModel(var_2_0)

	return var_2_0
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

		for iter_4_0, iter_4_1 in ipairs(var_3_0:GetTemplate().appear_fx) do
			arg_3_1:AddFX(iter_4_1)
		end

		arg_3_1:MakeVisible()

		return
	end

	arg_3_0:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_0.MakeCharacter(arg_6_0)
	return var_0.Battle.BattleNPCCharacter.New()
end

function var_0_0.MakeBloodBar(arg_7_0, arg_7_1)
	local var_7_9000
	local var_7_0 = arg_7_0:GetHPBarPool()
	local var_7_1 = var_7_0.GetHPBar(var_7_9000, arg_7_0.HP_BAR_NAME)

	if var_7_0 then
		var_7_1.transform:Find("blood"):GetComponent(typeof(Image)).color = arg_7_1:GetHPColor()
	end

	arg_7_1:AddHPBar(var_7_1)
	arg_7_1:UpdateHPBarPosition()

	return
end

return
