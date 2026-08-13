ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_2 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_3 = var_0.Battle

singletonClass = var_0_10004
var_0_3.BattleBeamBulletFactory = var_0_10004("BattleBeamBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleBeamBulletFactory.__name = "BattleBeamBulletFactory"

local var_0_4 = var_0.Battle.BattleBeamBulletFactory

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.CreateBullet(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_2:GetDirectHitUnit() == nil then
		return
	end

	local var_2_0 = var_6:GetUniqueID()
	local var_2_1 = var_6:GetUnitType()
	local var_2_2

	table = var_1_10010

	if var_1_10010.contains(var_0_1, var_2_1) then
		local var_2_3 = var_0_4.GetSceneMediator()

		var_2_2 = var_10.GetAircraft(var_2_3, var_2_0)
	else
		table = var_10

		if var_10.contains(var_0_2, var_2_1) then
			local var_2_4 = var_0_4.GetSceneMediator()

			var_2_2 = var_10.GetCharacter(var_2_4, var_2_0)
		end
	end

	if var_2_2 then
		var_2_2:AddFX(arg_2_2:GetTemplate().hit_fx)

		local var_2_5 = arg_2_0:GetDataProxy()

		var_10.HandleDamage(var_2_5, arg_2_2, var_6)
	end

	return
end

return
