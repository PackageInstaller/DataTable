ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.AircraftUnitType
local var_0_1 = ys.Battle.BattleConst.CharacterUnitType

ys.Battle.BattleBeamBulletFactory = singletonClass("BattleBeamBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleBeamBulletFactory.__name = "BattleBeamBulletFactory"

local var_0_2 = ys.Battle.BattleBeamBulletFactory

function ys.Battle.BattleBeamBulletFactory.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleBeamBulletFactory:CreateBullet(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = arg_2_2:GetDirectHitUnit()

	if var_2_0 == nil then
		return
	end

	local var_2_1 = var_2_0:GetUniqueID()
	local var_2_2 = var_2_0:GetUnitType()
	local var_2_3

	if table.contains(var_0_0, var_2_2) then
		var_2_3 = var_0_2.GetSceneMediator():GetAircraft(var_2_1)
	elseif table.contains(var_0_1, var_2_2) then
		var_2_3 = var_0_2.GetSceneMediator():GetCharacter(var_2_1)
	end

	if var_2_3 then
		var_2_3:AddFX(arg_2_2:GetTemplate().hit_fx)
		self:GetDataProxy():HandleDamage(arg_2_2, var_2_0)
	end

	return
end

return
