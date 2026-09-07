ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleEffectBulletFactory = singletonClass("BattleEffectBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleEffectBulletFactory.__name = "BattleEffectBulletFactory"

local var_0_1 = ys.Battle.BattleEffectBulletFactory

function ys.Battle.BattleEffectBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleEffectBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleTorpedoBullet.New()
end

function ys.Battle.BattleEffectBulletFactory:onBulletHitFunc(arg_3_1, arg_3_2)
	local var_3_0 = self:GetBulletData()
	local var_3_1 = var_3_0:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_3_0:GetHitSFX())

	if not var_3_0:IsFlare() then
		var_3_0:spawnArea()
	end

	local var_3_2, var_3_3 = var_0_1.GetFXPool():GetFX(self:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_3_2, var_3_3:Add(self:GetTf().localPosition), true)

	if var_3_0:GetPierceCount() <= 0 then
		var_0_1.GetDataProxy():RemoveBulletUnit(var_3_0:GetUniqueID())
	end

	return
end

function ys.Battle.BattleEffectBulletFactory.onBulletMissFunc(arg_4_0)
	var_0_1.onBulletHitFunc(arg_4_0)

	return
end

function ys.Battle.BattleEffectBulletFactory:MakeModel(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetBulletData():GetTemplate()
	local var_5_1 = self:GetDataProxy()

	if not self:GetBulletPool():InstBullet(arg_5_1:GetModleID(), function(arg_6_0)
		arg_5_1:AddModel(arg_6_0)

		return
	end) then
		arg_5_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_5_1:SetSpawn(arg_5_2)
	arg_5_1:SetFXFunc(self.onBulletHitFunc, self.onBulletMissFunc)
	self:GetSceneMediator():AddBullet(arg_5_1)

	return
end

return
