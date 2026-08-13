ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleNPCCharacterFactory", var_0.Battle.BattleEnemyCharacterFactory)

var_0.Battle.BattleNPCCharacterFactory = var_0_1
var_0_1.__name = "BattleNPCCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0.Battle.BattleHPBarManager.HP_BAR_FOE

	return
end

function var_0_1.CreateCharacter(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.extraInfo
	local var_2_1 = arg_2_1.unit
	local var_2_2 = arg_2_0:MakeCharacter()

	var_4.SetFactory(var_2_2, arg_2_0)
	var_4:SetUnitData(var_2_1)

	if var_2_0.modleID then
		var_4:SetModleID(var_2_0.modleID)
	end

	if var_2_0.HPColor then
		var_4:SetHPColor(var_2_0.HPColor)
	end

	if var_2_0.isUnvisible then
		var_4:SetUnvisible()
	end

	arg_2_0:MakeModel(var_4)

	return var_4
end

function var_0_1.MakeModel(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetUnitData()

	local function var_3_1(arg_4_0)
		local var_4_0 = arg_3_1

		var_1.AddModel(var_4_0, arg_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_1.GetSceneMediator(var_4_1)
		local var_4_3 = arg_3_1
		local var_4_4 = var_2.CameraOrthogonal
		local var_4_5 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_4_4(var_4_3, var_4.GetCamera(var_4_5))
		var_4_2:AddEnemyCharacter(arg_3_1)

		local var_4_6 = arg_3_0

		var_2.MakeUIComponentContainer(var_4_6, arg_3_1)

		local var_4_7 = arg_3_0

		var_2.MakeFXContainer(var_4_7, arg_3_1)

		local var_4_8 = arg_3_0

		var_2.MakePopNumPool(var_4_8, arg_3_1)

		local var_4_9 = arg_3_0

		var_2.MakeBloodBar(var_4_9, arg_3_1)

		local var_4_10 = arg_3_0

		var_2.MakeWaveFX(var_4_10, arg_3_1)

		local var_4_11 = arg_3_0

		var_2.MakeSmokeFX(var_4_11, arg_3_1)

		local var_4_12 = arg_3_0

		var_2.MakeArrowBar(var_4_12, arg_3_1)

		local var_4_13 = var_3_0
		local var_4_14 = var_2.GetTemplate(var_4_13).appear_fx

		ipairs = var_4_13

		for iter_4_0, iter_4_1 in var_4_13(var_4_14) do
			local var_4_15 = arg_3_1

			var_8.AddFX(var_4_15, iter_4_1)
		end

		local var_4_16 = arg_3_1

		var_3.MakeVisible(var_4_16)

		return
	end

	local var_3_2 = arg_3_0:GetCharacterPool()

	var_4.InstCharacter(var_3_2, arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_1.MakeCharacter(arg_6_0)
	return var_0.Battle.BattleNPCCharacter.New()
end

function var_0_1.MakeBloodBar(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetHPBarPool()
	local var_7_1 = var_2.GetHPBar(var_7_0, arg_7_0.HP_BAR_NAME).transform

	if arg_7_1:GetHPColor() then
		local var_7_2 = var_7_1:Find("blood")
		local var_7_3 = var_5.GetComponent

		typeof = var_7
		Image = var_1_10008
		var_7_3(var_7_2, var_7(var_1_10008)).color = var_4
	end

	arg_7_1:AddHPBar(var_2)
	arg_7_1:UpdateHPBarPosition()

	return
end

return
