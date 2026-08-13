ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleBombBulletFactory = var_0_10002("BattleBombBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleBombBulletFactory.__name = "BattleBombBulletFactory"

local var_0_2 = var_0.Battle.BattleBombBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.OutRangeFunc(arg_2_0)
	local var_2_0 = arg_2_0:GetTemplate().hit_type
	local var_2_1 = var_0_2.GetDataProxy()
	local var_2_2 = var_1.extra_param
	local var_2_3 = arg_2_0:GetDiveFilter()
	local var_2_4 = {
		_bullet = arg_2_0
	}
	local var_2_5 = arg_2_0:GetWeapon()

	var_2_4.equipIndex = var_7.GetEquipmentIndex(var_2_5)
	var_2_4.bulletTag = arg_2_0:GetExtraTag()

	arg_2_0:BuffTrigger(var_0.Battle.BattleConst.BuffEffectType.ON_BOMB_BULLET_BANG, var_2_4)

	if var_2_2.directDMG then
		local var_2_6 = var_2_2.buff_id
		local var_2_7

		if not var_2_2.buff_level then
			var_2_7 = 1
		end

		local var_2_8

		if not var_2_2.area_FX then
			var_2_8 = var_1.hit_fx
		end

		local function var_2_9(arg_3_0)
			local var_3_0 = arg_2_0

			if var_1.CanDealDamage(var_3_0) then
				ipairs = var_1

				for iter_3_0, iter_3_1 in var_1(arg_3_0) do
					if iter_3_1.Active then
						local var_3_1 = iter_3_1.UID
						local var_3_2 = var_0_2.GetSceneMediator()
						local var_3_3 = var_7.GetCharacter(var_3_2, var_3_1)
						local var_3_4 = var_7.GetUnitData(var_3_3)
						local var_3_5 = var_0.Battle.BattleBuffUnit.New(var_2_6, var_2_7)

						var_3_4:AddBuff(var_3_5)

						local var_3_6 = var_2_1

						var_9.HandleDirectDamage(var_3_6, var_3_4, var_2_2.directDMG, arg_2_0)
					end
				end

				local var_3_7 = arg_2_0

				var_1.DealDamage(var_3_7)
			end

			return
		end

		local function var_2_10(arg_4_0)
			if arg_4_0.Active then
				local var_4_0 = var_0_2
				local var_4_1 = var_1.GetSceneMediator(var_4_0)
				local var_4_2 = var_1.GetCharacter(var_4_1, arg_4_0.UID)
				local var_4_3 = var_1.GetUnitData(var_4_2)

				var_1.RemoveBuff(var_4_3, var_2_6)
			end

			return
		end

		local function var_2_11(arg_5_0)
			ipairs = var_2_10001

			for iter_5_0, iter_5_1 in var_2_10001(arg_5_0) do
				if iter_5_1.Active then
					local var_5_0 = var_0_2
					local var_5_1 = var_6.GetSceneMediator(var_5_0)
					local var_5_2 = var_6.GetCharacter(var_5_1, iter_5_1.UID)
					local var_5_3 = var_6.GetUnitData(var_5_2)

					if var_6.IsAlive(var_5_3) then
						var_6:RemoveBuff(var_2_6)
					end
				end
			end

			local var_5_4 = var_2_1
			local var_5_5 = var_1.RemoveBulletUnit
			local var_5_6 = arg_2_0

			var_5_5(var_5_4, var_4.GetUniqueID(var_5_6))

			return
		end

		local var_2_12 = var_2_1:SpawnLastingColumnArea(arg_2_0:GetEffectField(), arg_2_0:GetIFF(), arg_2_0:GetExplodePostion(), var_2_0.range, var_2_0.time, var_2_9, var_2_10, false, var_2_8, var_2_11, true)

		var_13.SetDiveFilter(var_2_12, var_2_3)
		arg_2_0:HideBullet()
	else
		local var_2_13

		local function var_2_14(arg_6_0)
			if var_2_0.decay then
				local var_6_0 = var_2_13

				var_2_10002.UpdateDistanceInfo(var_6_0)
			end

			ipairs = var_2_10002

			for iter_6_0, iter_6_1 in var_2_10002(arg_6_0) do
				if iter_6_1.Active then
					local var_6_1 = iter_6_1.UID
					local var_6_2 = 0

					if var_1 then
						local var_6_3 = var_2_13

						var_6_2 = var_9.GetDistance(var_6_3, var_6_1) / (var_2_0.range * 0.5) * var_1
					end

					local var_6_4 = var_0_2.GetSceneMediator()
					local var_6_5 = var_9.GetCharacter(var_6_4, var_6_1)
					local var_6_6 = var_9.GetUnitData(var_6_5)
					local var_6_7 = var_2_1

					var_10.HandleDamage(var_6_7, arg_2_0, var_6_6, var_6_2)
				end
			end

			return
		end

		local var_2_15 = var_2_1:SpawnColumnArea(arg_2_0:GetEffectField(), arg_2_0:GetIFF(), arg_2_0:GetExplodePostion(), var_2_0.range, var_2_0.time, var_2_14)

		var_2_13.SetDiveFilter(var_2_15, var_2_3)

		if var_2_2.friendlyFire then
			local var_2_16 = var_2_1:SpawnColumnArea(arg_2_0:GetEffectField(), var_2_1.GetOppoSideCode(arg_2_0:GetIFF()), arg_2_0:GetExplodePostion(), var_2_0.range, var_2_0.time, var_2_14)

			var_9.SetDiveFilter(var_2_16, var_2_3)
		end

		var_2_13:SetIndiscriminate(var_2_2.indiscriminate)
		var_2_1:RemoveBulletUnit(arg_2_0:GetUniqueID())
	end

	return
end

function var_0_2.MakeBullet(arg_7_0)
	return var_0.Battle.BattleBombBullet.New()
end

function var_0_2.onBulletHitFunc(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetBulletData()
	local var_8_1 = var_3.GetTemplate(var_8_0)

	var_0.Battle.PlayBattleSFX(var_3:GetHitSFX())

	local var_8_2 = var_0_2.GetFXPool()
	local var_8_3, var_8_4 = var_5.GetFX(var_8_2, arg_8_0:GetFXID())

	pg = var_8_2

	local var_8_5 = var_8_2.Tool.FilterY(var_3:GetPosition())

	pg = var_8

	local var_8_6 = var_8.EffectMgr.GetInstance()

	var_8.PlayBattleEffect(var_8_6, var_8_3, var_8_5:Add(var_8_4), true)

	return
end

function var_0_2.onBulletMissFunc()
	return
end

function var_0_2.MakeModel(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetBulletData()
	local var_10_1 = var_3.GetExplodePostion(var_10_0)
	local var_10_2 = arg_10_0:GetDataProxy()
	local var_10_3, var_10_4, var_10_5, var_10_6 = var_5.GetTotalBounds(var_10_2)

	if var_10_1.z > var_10_3 + 3 then
		local var_10_7 = arg_10_0:GetDataProxy()

		var_9.RemoveBulletUnit(var_10_7, var_3:GetUniqueID())

		return
	end

	local var_10_8 = var_3:GetTemplate()
	local var_10_9 = arg_10_0:GetBulletPool()

	if not var_10.InstBullet(var_10_9, arg_10_1:GetModleID(), function(arg_11_0)
		local var_11_0 = arg_10_1

		var_1.AddModel(var_11_0, arg_11_0)

		return
	end) then
		local var_10_10 = arg_10_1
		local var_10_11 = arg_10_1.AddTempModel
		local var_10_12 = arg_10_0:GetTempGOPool()

		var_10_11(var_10_10, var_14.GetObject(var_10_12))
	end

	arg_10_1:SetSpawn(arg_10_2)

	local var_10_13 = var_3:GetIFF()
	local var_10_14 = arg_10_0:GetDataProxy()

	if var_10_13 ~= var_12.GetFriendlyCode(var_10_14) and var_3:GetExist() and var_10_8.alert_fx ~= "" then
		var_0_2.CreateBulletAlert(var_3)
	end

	var_3:SetExist(true)
	arg_10_1:SetFXFunc(arg_10_0.onBulletHitFunc, arg_10_0.onBulletMissFunc)

	local var_10_15 = arg_10_0:GetSceneMediator()

	var_11.AddBullet(var_10_15, arg_10_1)

	return
end

function var_0_2.CreateBulletAlert(arg_12_0)
	local var_12_0 = arg_12_0:GetTemplate().hit_type.range
	local var_12_1 = arg_12_0:GetTemplate().alert_fx
	local var_12_2 = var_0.Battle.BattleFXPool.GetInstance()
	local var_12_3 = var_3.GetFX(var_12_2, var_12_1).transform
	local var_12_4 = 0

	pg = var_6

	if var_6.effect_offset[var_12_1] and var_6[var_12_1].y_scale == true then
		var_12_4 = var_12_0
	end

	Vector3 = var_7
	var_12_3.localScale = var_7(var_12_0, var_12_4, var_12_0)
	pg = var_7

	local var_12_5 = var_7.EffectMgr.GetInstance()

	var_7.PlayBattleEffect(var_12_5, var_3, arg_12_0:GetExplodePostion())

	return
end

return
