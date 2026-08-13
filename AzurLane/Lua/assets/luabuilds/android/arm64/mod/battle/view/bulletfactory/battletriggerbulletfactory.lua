ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleTriggerBulletFactory = var_0_10002("BattleTriggerBulletFactory", var_0.Battle.BattleBombBulletFactory)
var_0.Battle.BattleTriggerBulletFactory.__name = "BattleTriggerBulletFactory"

local var_0_2 = var_0.Battle.BattleTriggerBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.OutRangeFunc(arg_2_0)
	local var_2_0 = arg_2_0:GetTemplate().hit_type
	local var_2_1

	if not var_1.extra_param.multy then
		var_2_1 = 1
	end

	local var_2_2 = var_0_2.GetDataProxy()
	local var_2_3 = arg_2_0:GetDiveFilter()
	local var_2_4

	local function var_2_5(arg_3_0)
		if var_2_0.decay then
			local var_3_0 = var_2_4

			var_2_10002.UpdateDistanceInfo(var_3_0)
		end

		ipairs = var_2_10002

		for iter_3_0, iter_3_1 in var_2_10002(arg_3_0) do
			if iter_3_1.Active then
				local var_3_1 = iter_3_1.UID
				local var_3_2 = 0

				if var_1 then
					local var_3_3 = var_2_4

					var_3_2 = var_9.GetDistance(var_3_3, var_3_1) / (var_2_0.range * 0.5) * var_1
				end

				local var_3_4 = var_0_2.GetSceneMediator()
				local var_3_5 = var_9.GetCharacter(var_3_4, var_3_1)
				local var_3_6 = var_9.GetUnitData(var_3_5)
				local var_3_7 = 0

				while var_3_6:IsAlive() and var_3_7 < var_2_1 do
					local var_3_8 = var_2_2

					var_11.HandleDamage(var_3_8, arg_2_0, var_3_6, var_3_2)

					var_3_7 = var_3_7 + 1
				end
			end
		end

		local var_3_9 = var_0.Battle.PlayBattleSFX
		local var_3_10 = arg_2_0

		var_3_9(var_4.GetHitSFX(var_3_10))

		local var_3_11 = var_2_2
		local var_3_12 = var_2.SpawnEffect
		local var_3_13 = var_0.hit_fx
		local var_3_14 = arg_2_0

		var_3_12(var_3_11, var_3_13, var_6.GetExplodePostion(var_3_14))

		return
	end

	local var_2_6 = var_2_2:SpawnTriggerColumnArea(arg_2_0:GetEffectField(), arg_2_0:GetIFF(), arg_2_0:GetExplodePostion(), var_2_0.range, var_2_0.time, false, var_1.miss_fx, var_2_5)

	var_2_4.SetDiveFilter(var_2_6, var_2_3)
	var_2_2:RemoveBulletUnit(arg_2_0:GetUniqueID())

	return
end

function var_0_2.onBulletHitFunc(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_2.CreateBulletAlert(arg_5_0)
	return
end

return
