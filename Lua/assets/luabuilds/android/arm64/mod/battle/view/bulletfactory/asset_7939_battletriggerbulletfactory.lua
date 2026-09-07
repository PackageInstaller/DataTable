ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTriggerBulletFactory = singletonClass("BattleTriggerBulletFactory", ys.Battle.BattleBombBulletFactory)
ys.Battle.BattleTriggerBulletFactory.__name = "BattleTriggerBulletFactory"

local var_0_1 = ys.Battle.BattleTriggerBulletFactory

function ys.Battle.BattleTriggerBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTriggerBulletFactory:OutRangeFunc()
	local var_2_0 = self:GetTemplate()
	local var_2_1 = var_2_0.hit_type
	local var_2_2 = var_2_0.extra_param.multy or 1
	local var_2_3 = var_0_1.GetDataProxy()
	local var_2_4

	var_2_4 = var_2_3:SpawnTriggerColumnArea(self:GetEffectField(), self:GetIFF(), self:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, false, var_2_0.miss_fx, function(arg_3_0)
		if var_2_1.decay then
			var_2_4:UpdateDistanceInfo()
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1.Active then
				local var_3_0 = 0

				if var_2_1.decay then
					var_3_0 = var_2_4:GetDistance(iter_3_1.UID) / (var_2_1.range * 0.5) * var_2_1.decay
				end

				local var_3_1 = var_0_1.GetSceneMediator():GetCharacter(iter_3_1.UID):GetUnitData()

				while var_3_1:IsAlive() and 0 < var_2_2 do
					var_2_3:HandleDamage(self, var_3_1, var_3_0)
				end
			end
		end

		var_0_0.Battle.PlayBattleSFX(self:GetHitSFX())
		var_2_3:SpawnEffect(var_2_0.hit_fx, self:GetExplodePostion())

		return
	end)

	;(nil):SetDiveFilter((self:GetDiveFilter()))
	var_2_3:RemoveBulletUnit(self:GetUniqueID())

	return
end

function ys.Battle.BattleTriggerBulletFactory.onBulletHitFunc(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.BattleTriggerBulletFactory.CreateBulletAlert(arg_5_0)
	return
end

return
