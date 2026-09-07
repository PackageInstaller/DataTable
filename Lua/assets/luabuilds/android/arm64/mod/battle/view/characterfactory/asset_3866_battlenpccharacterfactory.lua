ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleNPCCharacterFactory", ys.Battle.BattleEnemyCharacterFactory)

ys.Battle.BattleNPCCharacterFactory = var_0_1
var_0_1.__name = "BattleNPCCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.HP_BAR_NAME = var_0_0.Battle.BattleHPBarManager.HP_BAR_FOE

	return
end

function var_0_1:CreateCharacter(arg_2_1)
	local var_2_0 = self:MakeCharacter()

	var_2_0:SetFactory(self)
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

	self:MakeModel(var_2_0)

	return var_2_0
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

		for iter_4_0, iter_4_1 in ipairs(var_3_0:GetTemplate().appear_fx) do
			arg_3_1:AddFX(iter_4_1)
		end

		arg_3_1:MakeVisible()

		return
	end

	self:GetCharacterPool():InstCharacter(arg_3_1:GetModleID(), function(arg_5_0)
		var_3_1(arg_5_0)

		return
	end)

	return
end

function var_0_1.MakeCharacter(arg_6_0)
	return var_0_0.Battle.BattleNPCCharacter.New()
end

function var_0_1:MakeBloodBar(arg_7_1)
	local var_7_0 = self:GetHPBarPool()
	local var_7_1 = var_7_0:GetHPBar(self.HP_BAR_NAME)

	if var_7_0 then
		var_7_1.transform:Find("blood"):GetComponent(typeof(Image)).color = arg_7_1:GetHPColor()
	end

	arg_7_1:AddHPBar(var_7_1)
	arg_7_1:UpdateHPBarPosition()

	return
end

return
