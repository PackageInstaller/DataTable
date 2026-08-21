ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBombBulletFactory = singletonClass("BattleBombBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleBombBulletFactory.__name = "BattleBombBulletFactory"

local var_0_1 = ys.Battle.BattleBombBulletFactory

function ys.Battle.BattleBombBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleBombBulletFactory.OutRangeFunc(arg_2_0)
	local var_2_0 = arg_2_0:GetTemplate()
	local var_2_1 = var_2_0.hit_type
	local var_2_2 = var_0_1.GetDataProxy()
	local var_2_3 = var_2_0.extra_param
	local var_2_4 = arg_2_0:GetDiveFilter()

	;({
		_bullet = arg_2_0
	}).equipIndex = arg_2_0:GetWeapon():GetEquipmentIndex()
	;({
		_bullet = arg_2_0
	}).bulletTag = arg_2_0:GetExtraTag()

	arg_2_0:BuffTrigger(var_0_0.Battle.BattleConst.BuffEffectType.ON_BOMB_BULLET_BANG, {
		_bullet = arg_2_0
	})

	if var_2_0.extra_param.directDMG then
		local var_2_5 = var_2_0.extra_param.buff_id
		local var_2_6

		if not var_2_0.extra_param.buff_level then
			var_2_6 = 1
		end

		var_2_2:SpawnLastingColumnArea(arg_2_0:GetEffectField(), arg_2_0:GetIFF(), arg_2_0:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, function(arg_3_0)
			if arg_2_0:CanDealDamage() then
				for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
					if iter_3_1.Active then
						local var_3_0 = var_0_1.GetSceneMediator():GetCharacter(iter_3_1.UID):GetUnitData()

						var_3_0:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_2_5, var_2_6)))
						var_2_2:HandleDirectDamage(var_3_0, var_2_3.directDMG, arg_2_0)
					end
				end

				arg_2_0:DealDamage()
			end

			return
		end, function(arg_4_0)
			if arg_4_0.Active then
				var_0_1:GetSceneMediator():GetCharacter(arg_4_0.UID):GetUnitData():RemoveBuff(var_2_5)
			end

			return
		end, false, var_2_7, function(arg_5_0)
			for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
				if iter_5_1.Active then
					local var_5_0 = var_0_1:GetSceneMediator():GetCharacter(iter_5_1.UID):GetUnitData()

					if var_5_0:IsAlive() then
						var_5_0:RemoveBuff(var_2_5)
					end
				end
			end

			var_2_2:RemoveBulletUnit(arg_2_0:GetUniqueID())

			return
		end, true):SetDiveFilter(var_2_4)
		arg_2_0:HideBullet()
	else
		local var_2_8

		var_2_8 = var_2_2:SpawnColumnArea(arg_2_0:GetEffectField(), arg_2_0:GetIFF(), arg_2_0:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, function(arg_6_0)
			if var_2_1.decay then
				var_2_8:UpdateDistanceInfo()
			end

			for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
				if iter_6_1.Active then
					local var_6_0 = 0

					if var_2_1.decay then
						var_6_0 = var_2_8:GetDistance(iter_6_1.UID) / (var_2_1.range * 0.5) * var_2_1.decay
					end

					local var_6_1 = var_0_1.GetSceneMediator():GetCharacter(iter_6_1.UID)

					var_2_2:HandleDamage(arg_2_0, var_6_1:GetUnitData(), var_6_0)
				end
			end

			return
		end)

		;(nil):SetDiveFilter(var_2_4)

		if var_2_0.extra_param.friendlyFire then
			var_2_2:SpawnColumnArea(arg_2_0:GetEffectField(), var_2_2.GetOppoSideCode(arg_2_0:GetIFF()), arg_2_0:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, function(arg_6_0)
				if var_2_1.decay then
					var_2_8:UpdateDistanceInfo()
				end

				for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
					if iter_6_1.Active then
						local var_6_0 = 0

						if var_2_1.decay then
							var_6_0 = var_2_8:GetDistance(iter_6_1.UID) / (var_2_1.range * 0.5) * var_2_1.decay
						end

						local var_6_1 = var_0_1.GetSceneMediator():GetCharacter(iter_6_1.UID)

						var_2_2:HandleDamage(arg_2_0, var_6_1:GetUnitData(), var_6_0)
					end
				end

				return
			end):SetDiveFilter(var_2_4)
		end

		var_2_8:SetIndiscriminate(var_2_0.extra_param.indiscriminate)
		var_2_2:RemoveBulletUnit(arg_2_0:GetUniqueID())
	end

	return
end

function ys.Battle.BattleBombBulletFactory.MakeBullet(arg_7_0)
	return var_0_0.Battle.BattleBombBullet.New()
end

function ys.Battle.BattleBombBulletFactory.onBulletHitFunc(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetBulletData()
	local var_8_1 = var_8_0:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_8_0:GetHitSFX())

	local var_8_2, var_8_3 = var_0_1.GetFXPool():GetFX(arg_8_0:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_8_2, pg.Tool.FilterY(var_8_0:GetPosition()):Add(var_8_3), true)

	return
end

function ys.Battle.BattleBombBulletFactory.onBulletMissFunc()
	return
end

function ys.Battle.BattleBombBulletFactory.MakeModel(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetBulletData()
	local var_10_1, var_10_2, var_10_3, var_10_4 = arg_10_0:GetDataProxy():GetTotalBounds()

	if var_10_0:GetExplodePostion().z > var_10_1 + 3 then
		arg_10_0:GetDataProxy():RemoveBulletUnit(var_10_0:GetUniqueID())

		return
	end

	local var_10_5 = var_10_0:GetTemplate()

	if not arg_10_0:GetBulletPool():InstBullet(arg_10_1:GetModleID(), function(arg_11_0)
		arg_10_1:AddModel(arg_11_0)

		return
	end) then
		arg_10_1:AddTempModel(arg_10_0:GetTempGOPool():GetObject())
	end

	arg_10_1:SetSpawn(arg_10_2)

	if var_10_0:GetIFF() ~= arg_10_0:GetDataProxy():GetFriendlyCode() and var_10_0:GetExist() and var_10_5.alert_fx ~= "" then
		var_0_1.CreateBulletAlert(var_10_0)
	end

	var_10_0:SetExist(true)
	arg_10_1:SetFXFunc(arg_10_0.onBulletHitFunc, arg_10_0.onBulletMissFunc)
	arg_10_0:GetSceneMediator():AddBullet(arg_10_1)

	return
end

function ys.Battle.BattleBombBulletFactory.CreateBulletAlert(arg_12_0)
	local var_12_0 = arg_12_0:GetTemplate().hit_type.range
	local var_12_1 = arg_12_0:GetTemplate().alert_fx
	local var_12_2 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(var_12_1)
	local var_12_3 = 0

	if pg.effect_offset[var_12_1] and pg.effect_offset[var_12_1].y_scale == true then
		var_12_3 = var_12_0
	end

	var_12_2.transform.localScale = Vector3(var_12_0, var_12_3, var_12_0)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_12_2, arg_12_0:GetExplodePostion())

	return
end

return
