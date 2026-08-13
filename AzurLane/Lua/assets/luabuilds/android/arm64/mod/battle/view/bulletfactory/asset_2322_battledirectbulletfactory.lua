ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_2 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_3 = var_0.Battle

singletonClass = var_0_10004
var_0_3.BattleDirectBulletFactory = var_0_10004("BattleDirectBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleDirectBulletFactory.__name = "BattleDirectBulletFactory"

local var_0_4 = var_0.Battle.BattleDirectBulletFactory

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.CreateBullet(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:PlayFireFX(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, nil)

	if arg_2_2:GetDirectHitUnit() == nil then
		return
	end

	local var_2_0 = var_6:GetUniqueID()
	local var_2_1 = var_6
	local var_2_2 = var_6.GetUnitType(var_2_1)
	local var_2_3

	table = var_2_1

	if var_2_1.contains(var_0_1, var_2_2) then
		local var_2_4 = var_0_4.GetSceneMediator()

		var_2_3 = var_10.GetAircraft(var_2_4, var_2_0)
	else
		table = var_10

		if var_10.contains(var_0_2, var_2_2) then
			local var_2_5 = var_0_4.GetSceneMediator()

			var_2_3 = var_10.GetCharacter(var_2_5, var_2_0)
		end
	end

	if var_2_3 then
		var_2_3:AddFX(arg_2_2:GetTemplate().hit_fx)

		local var_2_6 = arg_2_0:GetDataProxy()

		var_10.HandleDamage(var_2_6, arg_2_2, var_6)
	end

	return
end

return
