ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_3 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_4 = var_0.Battle

singletonClass = var_0_10005
var_0_4.BattleElectricArcBulletFactory = var_0_10005("BattleElectricArcBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleElectricArcBulletFactory.__name = "BattleElectricArcBulletFactory"

local var_0_5 = var_0.Battle.BattleElectricArcBulletFactory

function var_0_5.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)

	return
end

function var_0_5.CreateBullet(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:PlayFireFX(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, nil)

	if arg_2_2:GetDirectHitUnit() == nil then
		return
	end

	local var_2_0 = var_6:GetUniqueID()
	local var_2_1 = var_6
	local var_2_2 = var_6.GetUnitType(var_2_1)
	local var_2_3

	table = var_2_1

	if var_2_1.contains(var_0_2, var_2_2) then
		local var_2_4 = var_0_5.GetSceneMediator()

		var_2_3 = var_10.GetAircraft(var_2_4, var_2_0)
	else
		table = var_10

		if var_10.contains(var_0_3, var_2_2) then
			local var_2_5 = var_0_5.GetSceneMediator()

			var_2_3 = var_10.GetCharacter(var_2_5, var_2_0)
		end
	end

	if var_2_3 then
		var_2_3:AddFX(arg_2_2:GetTemplate().hit_fx)

		local var_2_6 = arg_2_0:GetDataProxy()

		var_10.HandleDamage(var_2_6, arg_2_2, var_6)

		local var_2_7 = arg_2_2:GetWeapon()

		if var_10.GetHost(var_2_7) then
			local var_2_8 = arg_2_2:GetWeapon()
			local var_2_9 = var_11.GetTemplateData(var_2_8).spawn_bound
			local var_2_10 = arg_2_0:GetSceneMediator()
			local var_2_11 = var_12.GetCharacter(var_2_10, var_10:GetUniqueID())
			local var_2_12 = arg_2_0:GetSceneMediator()

			var_13.AddArcEffect(var_2_12, arg_2_2:GetTemplate().modle_ID, var_2_11, var_6, var_2_9)
		end
	end

	return
end

return
