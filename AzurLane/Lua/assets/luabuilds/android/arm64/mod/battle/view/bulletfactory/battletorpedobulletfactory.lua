ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTorpedoBulletFactory = singletonClass("BattleTorpedoBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleTorpedoBulletFactory.__name = "BattleTorpedoBulletFactory"

local var_0_1 = ys.Battle.BattleTorpedoBulletFactory

function ys.Battle.BattleTorpedoBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTorpedoBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleTorpedoBullet.New()
end

function ys.Battle.BattleTorpedoBulletFactory.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetBulletData():GetTemplate().hit_type
	local var_3_1 = var_0_1.GetDataProxy()
	local var_3_2 = arg_3_0:GetBulletData()
	local var_3_3 = var_3_2:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_3_2:GetHitSFX())

	;({
		_bullet = var_3_2
	}).equipIndex = var_3_2:GetWeapon():GetEquipmentIndex()
	;({
		_bullet = var_3_2
	}).bulletTag = var_3_2:GetExtraTag()

	var_3_2:BuffTrigger(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_BANG, {
		_bullet = var_3_2
	})

	local var_3_4 = var_3_2:GetDiveFilter()
	local var_3_5 = var_3_0.range and var_3_1:SpawnColumnArea(var_3_2:GetEffectField(), var_3_2:GetIFF(), pg.Tool.FilterY(arg_3_0:GetPosition():Clone()), var_3_0.range, var_3_0.time, function(arg_4_0)
		if var_3_0.decay then
			var_3_5:UpdateDistanceInfo()
		end

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				local var_4_0 = 0

				if var_3_0.decay then
					var_4_0 = var_3_5:GetDistance(iter_4_1.UID) / (var_3_0.range * 0.5) * var_3_0.decay
				end

				local var_4_1 = var_0_1:GetSceneMediator():GetCharacter(iter_4_1.UID)

				var_3_1:HandleDamage(var_3_2, var_4_1:GetUnitData(), var_4_0)
			end
		end

		return
	end) or var_3_1:SpawnCubeArea(var_3_2:GetEffectField(), var_3_2:GetIFF(), pg.Tool.FilterY(arg_3_0:GetPosition():Clone()), var_3_0.width, var_3_0.height, var_3_0.time, function(arg_4_0)
		if var_3_0.decay then
			var_3_5:UpdateDistanceInfo()
		end

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				local var_4_0 = 0

				if var_3_0.decay then
					var_4_0 = var_3_5:GetDistance(iter_4_1.UID) / (var_3_0.range * 0.5) * var_3_0.decay
				end

				local var_4_1 = var_0_1:GetSceneMediator():GetCharacter(iter_4_1.UID)

				var_3_1:HandleDamage(var_3_2, var_4_1:GetUnitData(), var_4_0)
			end
		end

		return
	end)

	var_3_5:SetDiveFilter(var_3_4)

	local var_3_6, var_3_7 = var_0_1.GetFXPool():GetFX(arg_3_0:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_3_6, var_3_7:Add(arg_3_0:GetTf().localPosition), true)

	if var_3_2:GetPierceCount() <= 0 then
		var_3_1:RemoveBulletUnit(var_3_2:GetUniqueID())
	end

	return
end

function ys.Battle.BattleTorpedoBulletFactory.onBulletMissFunc(arg_5_0)
	var_0_1.onBulletHitFunc(arg_5_0)

	return
end

function ys.Battle.BattleTorpedoBulletFactory.MakeModel(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetBulletData()
	local var_6_1 = var_6_0:GetTemplate()

	if not arg_6_0:GetBulletPool():InstBullet(arg_6_1:GetModleID(), function(arg_7_0)
		arg_6_1:AddModel(arg_7_0)

		return
	end) then
		arg_6_1:AddTempModel(arg_6_0:GetTempGOPool():GetObject())
	end

	arg_6_1:SetSpawn(arg_6_2)
	arg_6_1:SetFXFunc(arg_6_0.onBulletHitFunc, arg_6_0.onBulletMissFunc)
	arg_6_0:GetSceneMediator():AddBullet(arg_6_1)

	if var_6_0:GetIFF() ~= arg_6_0:GetDataProxy():GetFriendlyCode() and var_6_1.alert_fx ~= "" then
		arg_6_1:MakeAlert(arg_6_0:GetFXPool():GetFX(var_6_1.alert_fx))
	end

	return
end

return
