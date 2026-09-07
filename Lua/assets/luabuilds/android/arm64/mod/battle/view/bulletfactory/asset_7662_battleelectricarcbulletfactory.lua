ys = ys or {}

local var_0_1 = ys.Battle.BattleConst.AircraftUnitType
local var_0_2 = ys.Battle.BattleConst.CharacterUnitType

ys.Battle.BattleElectricArcBulletFactory = singletonClass("BattleElectricArcBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleElectricArcBulletFactory.__name = "BattleElectricArcBulletFactory"

local var_0_3 = ys.Battle.BattleElectricArcBulletFactory

function ys.Battle.BattleElectricArcBulletFactory.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleElectricArcBulletFactory:CreateBullet(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self:PlayFireFX(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, nil)

	local var_2_0 = arg_2_2:GetDirectHitUnit()

	if var_2_0 == nil then
		return
	end

	local var_2_1 = var_2_0:GetUniqueID()
	local var_2_2 = var_2_0:GetUnitType()
	local var_2_3

	if table.contains(var_0_1, var_2_2) then
		var_2_3 = var_0_3.GetSceneMediator():GetAircraft(var_2_1)
	elseif table.contains(var_0_2, var_2_2) then
		var_2_3 = var_0_3.GetSceneMediator():GetCharacter(var_2_1)
	end

	if var_2_3 then
		var_2_3:AddFX(arg_2_2:GetTemplate().hit_fx)
		self:GetDataProxy():HandleDamage(arg_2_2, var_2_0)

		local var_2_4 = arg_2_2:GetWeapon():GetHost()

		if var_2_4 then
			self:GetSceneMediator():AddArcEffect(arg_2_2:GetTemplate().modle_ID, self:GetSceneMediator():GetCharacter(var_2_4:GetUniqueID()), var_2_0, arg_2_2:GetWeapon():GetTemplateData().spawn_bound)
		end
	end

	return
end

return
