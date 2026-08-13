ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleEffectBulletFactory = var_0_10002("BattleEffectBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleEffectBulletFactory.__name = "BattleEffectBulletFactory"

local var_0_2 = var_0.Battle.BattleEffectBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.MakeBullet(arg_2_0)
	return var_0.Battle.BattleTorpedoBullet.New()
end

function var_0_2.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_2.GetDataProxy()
	local var_3_1 = arg_3_0:GetBulletData()
	local var_3_2 = var_4.GetTemplate(var_3_1)

	var_0.Battle.PlayBattleSFX(var_4:GetHitSFX())

	if not var_4:IsFlare() then
		var_4:spawnArea()
	end

	local var_3_3 = var_0_2.GetFXPool()
	local var_3_4, var_3_5 = var_6.GetFX(var_3_3, arg_3_0:GetFXID())
	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.GetTf(var_3_6).localPosition

	pg = var_3_6

	local var_3_8 = var_3_6.EffectMgr.GetInstance()

	var_9.PlayBattleEffect(var_3_8, var_3_4, var_3_5:Add(var_3_7), true)

	if var_4:GetPierceCount() <= 0 then
		var_3_0:RemoveBulletUnit(var_4:GetUniqueID())
	end

	return
end

function var_0_2.onBulletMissFunc(arg_4_0)
	var_0_2.onBulletHitFunc(arg_4_0)

	return
end

function var_0_2.MakeModel(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetBulletData()
	local var_5_1 = var_3.GetTemplate(var_5_0)
	local var_5_2 = arg_5_0:GetDataProxy()
	local var_5_3 = arg_5_0:GetBulletPool()

	if not var_6.InstBullet(var_5_3, arg_5_1:GetModleID(), function(arg_6_0)
		local var_6_0 = arg_5_1

		var_1.AddModel(var_6_0, arg_6_0)

		return
	end) then
		local var_5_4 = arg_5_1
		local var_5_5 = arg_5_1.AddTempModel
		local var_5_6 = arg_5_0:GetTempGOPool()

		var_5_5(var_5_4, var_9.GetObject(var_5_6))
	end

	arg_5_1:SetSpawn(arg_5_2)
	arg_5_1:SetFXFunc(arg_5_0.onBulletHitFunc, arg_5_0.onBulletMissFunc)

	local var_5_7 = arg_5_0:GetSceneMediator()

	var_7.AddBullet(var_5_7, arg_5_1)

	return
end

return
