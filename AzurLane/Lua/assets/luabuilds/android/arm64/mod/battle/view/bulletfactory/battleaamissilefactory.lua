ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.UnitType
local var_0_2 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_3 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_4 = var_0.Battle

singletonClass = var_0_10005
var_0_4.BattleAAMissileFactory = var_0_10005("BattleAAMissileFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleAAMissileFactory.__name = "BattleAAMissileFactory"

local var_0_5 = var_0.Battle.BattleAAMissileFactory

function var_0_5.MakeBullet(arg_1_0)
	return var_0.Battle.BattleTorpedoBullet.New()
end

function var_0_5.onBulletHitFunc(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetBulletData()

	if var_3.getTrackingTarget(var_2_0) == -1 then
		var_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	local var_2_1 = var_3:GetTemplate()
	local var_2_2 = var_0_5.GetDataProxy()
	local var_2_3

	table = var_1_10008

	if var_1_10008.contains(var_0_2, arg_2_2) then
		local var_2_4 = var_0_5.GetSceneMediator()
		local var_2_5 = var_8.GetAircraft(var_2_4, arg_2_1)

		var_2_3 = var_8.GetUnitData(var_2_5)
	else
		table = var_8

		if var_8.contains(var_0_3, arg_2_2) then
			local var_2_6 = var_0_5.GetSceneMediator()
			local var_2_7 = var_8.GetCharacter(var_2_6, arg_2_1)

			var_2_3 = var_8.GetUnitData(var_2_7)
		end
	end

	if not var_2_3 or not var_4 or var_2_3:GetUniqueID() ~= var_4:GetUniqueID() then
		return
	end

	var_0.Battle.PlayBattleSFX(var_3:GetHitSFX())

	local var_2_8 = var_0_5.GetFXPool()
	local var_2_9, var_2_10 = var_8.GetFX(var_2_8, arg_2_0:GetFXID())
	local var_2_11 = arg_2_0:GetTf().localPosition

	pg = var_11

	local var_2_12 = var_11.EffectMgr.GetInstance()

	var_11.PlayBattleEffect(var_2_12, var_2_9, var_2_10:Add(var_2_11), true)

	local var_2_13, var_2_14 = var_2_2:HandleDamage(var_3, var_2_3)

	if var_3:GetPierceCount() <= 0 then
		var_3:CleanAimMark()
		var_2_2:RemoveBulletUnit(var_3:GetUniqueID())
	end

	return
end

function var_0_5.onBulletMissFunc(arg_3_0)
	var_0_5.onBulletHitFunc(arg_3_0)

	return
end

function var_0_5.MakeModel(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetBulletData()
	local var_4_1 = var_3.GetTemplate(var_4_0)
	local var_4_2 = arg_4_0:GetDataProxy()
	local var_4_3 = arg_4_0:GetBulletPool()

	if not var_6.InstBullet(var_4_3, arg_4_1:GetModleID(), function(arg_5_0)
		local var_5_0 = arg_4_1

		var_1.AddModel(var_5_0, arg_5_0)

		return
	end) then
		local var_4_4 = arg_4_1
		local var_4_5 = arg_4_1.AddTempModel
		local var_4_6 = arg_4_0:GetTempGOPool()

		var_4_5(var_4_4, var_10.GetObject(var_4_6))
	end

	arg_4_1:SetSpawn(arg_4_2)
	arg_4_1:SetFXFunc(arg_4_0.onBulletHitFunc, arg_4_0.onBulletMissFunc)

	local var_4_7 = arg_4_0:GetSceneMediator()

	var_7.AddBullet(var_4_7, arg_4_1)

	if var_3:GetIFF() ~= var_4_2:GetFriendlyCode() and var_4_1.alert_fx ~= "" then
		local var_4_8 = arg_4_1
		local var_4_9 = arg_4_1.MakeAlert
		local var_4_10 = arg_4_0:GetFXPool()

		var_4_9(var_4_8, var_10.GetFX(var_4_10, var_4_1.alert_fx))
	end

	return
end

return
