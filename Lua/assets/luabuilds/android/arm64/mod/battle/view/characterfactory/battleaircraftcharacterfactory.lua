ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = singletonClass("BattleAircraftCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleAircraftCharacterFactory = var_0_1
var_0_1.__name = "BattleAircraftCharacterFactory"
var_0_1.BOMB_FX_NAME = "feijibaozha"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleAircraftCharacter.New()
end

function var_0_1.MakeModel(arg_3_0, arg_3_1)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:InitWeapon()
		arg_3_1:CameraOrthogonal(var_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		arg_3_0:GetSceneMediator():AddAirCraftCharacter(arg_3_1)
		arg_3_0:MakeUIComponentContainer(arg_3_1)
		arg_3_0:MakeFXContainer(arg_3_1)
		arg_3_0:MakeShadow(arg_3_1)

		if arg_3_1:GetUnitData():GetIFF() == var_0_0.FOE_CODE then
			arg_3_0:MakePopNumPool(arg_3_1)
			arg_3_0:MakeBloodBar(arg_3_1)
		end

		return
	end

	arg_3_0:GetCharacterPool():InstAirCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_1.MakeBloodBar(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetUnitData():IsPlayerAircraft() and arg_6_0:GetHPBarPool():GetHPBar(var_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY) or arg_6_0:GetHPBarPool():GetHPBar(var_0.Battle.BattleHPBarManager.HP_BAR_FOE)

	arg_6_1:AddHPBar(var_6_0)
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_1.SetHPBarWidth(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1.transform.sizeDelta = Vector2(40, arg_7_1.transform.rect.height)

	local var_7_0 = arg_7_1.transform:Find("blood").transform
	local var_7_1 = 40 - arg_7_2 or 0

	var_7_0.sizeDelta = Vector2(var_7_1, var_7_0.rect.height)

	return
end

function var_0_1.MakeShadow(arg_8_0, arg_8_1)
	arg_8_1:AddShadow()
	arg_8_1:UpdateShadow()

	return
end

return
