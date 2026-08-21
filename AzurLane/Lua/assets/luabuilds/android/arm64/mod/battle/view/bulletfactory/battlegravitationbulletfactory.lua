ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleGravitationBulletFactory = singletonClass("BattleGravitationBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleGravitationBulletFactory.__name = "BattleGravitationBulletFactory"

local var_0_1 = ys.Battle.BattleGravitationBulletFactory

function ys.Battle.BattleGravitationBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleGravitationBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleTorpedoBullet.New()
end

function ys.Battle.BattleGravitationBulletFactory.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetBulletData()

	if var_3_0:GetPierceCount() <= 0 then
		return
	end

	local var_3_1 = var_3_0:GetTemplate().hit_type
	local var_3_2 = var_0_1.GetDataProxy()
	local var_3_3 = arg_3_0:GetBulletData()
	local var_3_4 = var_3_3:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_3_3:GetHitSFX())

	local var_3_5 = var_3_3:GetDiveFilter()
	local var_3_6 = var_3_3:GetPosition():Clone()
	local var_3_7 = var_3_3:GetTemplate().extra_param
	local var_3_8 = var_3_7.buff_id
	local var_3_9

	if not var_3_7.buff_level then
		var_3_9 = 1
	end

	var_0_1.GetDataProxy():SpawnLastingColumnArea(var_3_3:GetEffectField(), var_3_3:GetIFF(), pg.Tool.FilterY((var_3_3:GetPosition():Clone())), var_3_1.range, var_3_1.time, function(arg_4_0)
		if var_3_3:CanDealDamage() then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
				if iter_4_1.Active then
					local var_4_0 = var_0_1:GetSceneMediator():GetCharacter(iter_4_1.UID):GetUnitData()

					var_4_0:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_3_8, var_3_9)))

					if not var_3_7.noIntervalDMG then
						var_3_2:HandleDamage(var_3_3, var_4_0)
					end

					local var_4_1 = var_3_7.force or 0.1
					local var_4_2 = pg.Tool.FilterY(var_3_6 - var_4_0:GetPosition())

					if var_4_1 > var_4_2.magnitude then
						var_4_0:SetUncontrollableSpeed(var_4_2, 0.001, 1e-06)
					else
						var_4_0:SetUncontrollableSpeed(var_4_2, var_4_1, 1e-07)
					end
				end
			end

			var_3_3:DealDamage()
		end

		return
	end, function(arg_5_0)
		if arg_5_0.Active then
			local var_5_0 = var_0_1:GetSceneMediator():GetCharacter(arg_5_0.UID):GetUnitData()

			var_5_0:ClearUncontrollableSpeed()
			var_5_0:RemoveBuff(var_3_8)
		end

		return
	end, false, arg_3_0:GetFXID(), function(arg_6_0)
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			if iter_6_1.Active then
				local var_6_0 = var_0_1:GetSceneMediator():GetCharacter(iter_6_1.UID):GetUnitData()
				local var_6_1 = false
				local var_6_2 = var_6_0:GetCurrentOxyState()

				for iter_6_2, iter_6_3 in ipairs(var_3_5) do
					if var_6_2 == iter_6_3 then
						var_6_1 = true
					end
				end

				if not var_6_1 then
					var_3_2:HandleDirectDamage(var_6_0, var_3_7.exploDMG, var_3_3)

					if var_6_0:IsAlive() then
						local var_6_3 = pg.Tool.FilterY(var_6_0:GetPosition() - var_3_6)

						if var_3_7.knockBack ~= false then
							var_6_0:SetUncontrollableSpeed(var_6_3, 1, 0.2, 6)
						end

						var_6_0:RemoveBuff(var_3_8)
					end
				end
			end
		end

		local var_6_4, var_6_5 = var_0_1.GetFXPool():GetFX(arg_3_0:GetMissFXID())

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_6_4, var_6_5:Add(var_3_6), true)
		var_3_2:RemoveBulletUnit(var_3_3:GetUniqueID())

		return
	end, true):SetDiveFilter((var_3_3:GetDiveFilter()))

	return
end

function ys.Battle.BattleGravitationBulletFactory.onBulletMissFunc(arg_7_0)
	var_0_1.onBulletHitFunc(arg_7_0)

	return
end

function ys.Battle.BattleGravitationBulletFactory.MakeModel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetBulletData()
	local var_8_1 = var_8_0:GetTemplate()

	if not arg_8_0:GetBulletPool():InstBullet(arg_8_1:GetModleID(), function(arg_9_0)
		arg_8_1:AddModel(arg_9_0)

		return
	end) then
		arg_8_1:AddTempModel(arg_8_0:GetTempGOPool():GetObject())
	end

	arg_8_1:SetSpawn(arg_8_2)
	arg_8_1:SetFXFunc(arg_8_0.onBulletHitFunc, arg_8_0.onBulletMissFunc)
	arg_8_0:GetSceneMediator():AddBullet(arg_8_1)

	if var_8_0:GetIFF() ~= arg_8_0:GetDataProxy():GetFriendlyCode() and var_8_1.alert_fx ~= "" then
		arg_8_1:MakeAlert(arg_8_0:GetFXPool():GetFX(var_8_1.alert_fx))
	end

	return
end

return
