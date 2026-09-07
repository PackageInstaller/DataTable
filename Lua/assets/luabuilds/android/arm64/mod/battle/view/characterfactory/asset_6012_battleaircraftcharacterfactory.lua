ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = singletonClass("BattleAircraftCharacterFactory", ys.Battle.BattleCharacterFactory)

ys.Battle.BattleAircraftCharacterFactory = var_0_2
var_0_2.__name = "BattleAircraftCharacterFactory"
var_0_2.BOMB_FX_NAME = "feijibaozha"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleAircraftCharacter.New()
end

function var_0_2:MakeModel(arg_3_1)
	local function var_3_0(arg_4_0)
		arg_3_1:AddModel(arg_4_0)
		arg_3_1:InitWeapon()
		arg_3_1:CameraOrthogonal(var_0_0.Battle.BattleCameraUtil.GetInstance():GetCamera())
		self:GetSceneMediator():AddAirCraftCharacter(arg_3_1)
		self:MakeUIComponentContainer(arg_3_1)
		self:MakeFXContainer(arg_3_1)
		self:MakeShadow(arg_3_1)

		if arg_3_1:GetUnitData():GetIFF() == var_0_1.FOE_CODE then
			self:MakePopNumPool(arg_3_1)
			self:MakeBloodBar(arg_3_1)
		end

		return
	end

	self:GetCharacterPool():InstAirCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_0(arg_5_0)

		return
	end)

	return
end

function var_0_2:MakeBloodBar(arg_6_1)
	arg_6_1:AddHPBar(arg_6_1:GetUnitData():IsPlayerAircraft() and self:GetHPBarPool():GetHPBar(var_0_0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY) or self:GetHPBarPool():GetHPBar(var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE))
	arg_6_1:UpdateHPBarPosition()

	return
end

function var_0_2.SetHPBarWidth(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1.transform.sizeDelta = Vector2(40, arg_7_1.transform.rect.height)

	local var_7_0 = arg_7_1.transform:Find("blood").transform

	var_7_0.sizeDelta = Vector2(40 - arg_7_2 or 0, var_7_0.rect.height)

	return
end

function var_0_2.MakeShadow(arg_8_0, arg_8_1)
	arg_8_1:AddShadow()
	arg_8_1:UpdateShadow()

	return
end

return
