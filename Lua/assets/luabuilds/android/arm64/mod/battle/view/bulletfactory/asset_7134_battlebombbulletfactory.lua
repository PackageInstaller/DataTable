ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBombBulletFactory = singletonClass("BattleBombBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleBombBulletFactory.__name = "BattleBombBulletFactory"

local var_0_1 = ys.Battle.BattleBombBulletFactory

function ys.Battle.BattleBombBulletFactory.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleBombBulletFactory:OutRangeFunc()
	local var_2_0 = self:GetTemplate()
	local var_2_1 = var_2_0.hit_type
	local var_2_2 = var_0_1.GetDataProxy()
	local var_2_3 = var_2_0.extra_param
	local var_2_4 = self:GetDiveFilter()
	local var_2_5 = {
		_bullet = self
	}

	var_2_5.equipIndex = self:GetWeapon():GetEquipmentIndex()
	var_2_5.bulletTag = self:GetExtraTag()

	self:BuffTrigger(var_0_0.Battle.BattleConst.BuffEffectType.ON_BOMB_BULLET_BANG, var_2_5)

	if var_2_0.extra_param.directDMG then
		local var_2_6 = var_2_0.extra_param.buff_id
		local var_2_7 = var_2_0.extra_param.buff_level or 1

		var_2_2:SpawnLastingColumnArea(self:GetEffectField(), self:GetIFF(), self:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, function(arg_3_0)
			if self:CanDealDamage() then
				for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
					if iter_3_1.Active then
						local var_3_0 = var_0_1.GetSceneMediator():GetCharacter(iter_3_1.UID):GetUnitData()

						var_3_0:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_2_6, var_2_7)))
						var_2_2:HandleDirectDamage(var_3_0, var_2_3.directDMG, self)
					end
				end

				self:DealDamage()
			end

			return
		end, function(arg_4_0)
			if arg_4_0.Active then
				var_0_1:GetSceneMediator():GetCharacter(arg_4_0.UID):GetUnitData():RemoveBuff(var_2_6)
			end

			return
		end, false, var_2_0.extra_param.area_FX or var_2_0.hit_fx, function(arg_5_0)
			for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
				if iter_5_1.Active then
					local var_5_0 = var_0_1:GetSceneMediator():GetCharacter(iter_5_1.UID):GetUnitData()

					if var_5_0:IsAlive() then
						var_5_0:RemoveBuff(var_2_6)
					end
				end
			end

			var_2_2:RemoveBulletUnit(self:GetUniqueID())

			return
		end, true):SetDiveFilter(var_2_4)
		self:HideBullet()
	else
		local var_2_8

		local function var_2_9(arg_6_0)
			if var_2_1.decay then
				var_2_8:UpdateDistanceInfo()
			end

			for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
				if iter_6_1.Active then
					var_2_2:HandleDamage(self, var_0_1.GetSceneMediator():GetCharacter(iter_6_1.UID):GetUnitData(), (var_2_1.decay or nil) and var_2_8:GetDistance(iter_6_1.UID) / (var_2_1.range * 0.5) * var_2_1.decay)
				end
			end

			return
		end

		var_2_8 = var_2_2:SpawnColumnArea(self:GetEffectField(), self:GetIFF(), self:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, var_2_9)

		;(nil):SetDiveFilter(var_2_4)

		if var_2_0.extra_param.friendlyFire then
			var_2_2:SpawnColumnArea(self:GetEffectField(), var_2_2.GetOppoSideCode(self:GetIFF()), self:GetExplodePostion(), var_2_0.hit_type.range, var_2_0.hit_type.time, var_2_9):SetDiveFilter(var_2_4)
		end

		var_2_8:SetIndiscriminate(var_2_0.extra_param.indiscriminate)
		var_2_2:RemoveBulletUnit(self:GetUniqueID())
	end

	return
end

function ys.Battle.BattleBombBulletFactory.MakeBullet(arg_7_0)
	return var_0_0.Battle.BattleBombBullet.New()
end

function ys.Battle.BattleBombBulletFactory:onBulletHitFunc(arg_8_1, arg_8_2)
	local var_8_0 = self:GetBulletData()
	local var_8_1 = var_8_0:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_8_0:GetHitSFX())

	local var_8_2, var_8_3 = var_0_1.GetFXPool():GetFX(self:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_8_2, pg.Tool.FilterY(var_8_0:GetPosition()):Add(var_8_3), true)

	return
end

function ys.Battle.BattleBombBulletFactory.onBulletMissFunc()
	return
end

function ys.Battle.BattleBombBulletFactory:MakeModel(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetBulletData()
	local var_10_1, var_10_2, var_10_3, var_10_4 = self:GetDataProxy():GetTotalBounds()

	if var_10_0:GetExplodePostion().z > var_10_1 + 3 then
		self:GetDataProxy():RemoveBulletUnit(var_10_0:GetUniqueID())

		return
	end

	local var_10_5 = var_10_0:GetTemplate()

	if not self:GetBulletPool():InstBullet(arg_10_1:GetModleID(), function(arg_11_0)
		arg_10_1:AddModel(arg_11_0)

		return
	end) then
		arg_10_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_10_1:SetSpawn(arg_10_2)

	if var_10_0:GetIFF() ~= self:GetDataProxy():GetFriendlyCode() and var_10_0:GetExist() and var_10_5.alert_fx ~= "" then
		var_0_1.CreateBulletAlert(var_10_0)
	end

	var_10_0:SetExist(true)
	arg_10_1:SetFXFunc(self.onBulletHitFunc, self.onBulletMissFunc)
	self:GetSceneMediator():AddBullet(arg_10_1)

	return
end

function ys.Battle.BattleBombBulletFactory:CreateBulletAlert()
	local var_12_0 = self:GetTemplate().hit_type.range
	local var_12_1 = self:GetTemplate().alert_fx
	local var_12_2 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(var_12_1)

	var_12_2.transform.localScale = Vector3(var_12_0, (pg.effect_offset[var_12_1] and pg.effect_offset[var_12_1].y_scale == true or nil) and var_12_0, var_12_0)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_12_2, self:GetExplodePostion())

	return
end

return
