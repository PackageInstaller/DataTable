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

function ys.Battle.BattleTorpedoBulletFactory:onBulletHitFunc(arg_3_1, arg_3_2)
	local var_3_0 = self:GetBulletData():GetTemplate().hit_type
	local var_3_1 = var_0_1.GetDataProxy()
	local var_3_2 = self:GetBulletData()
	local var_3_3 = var_3_2:GetTemplate()

	var_0_0.Battle.PlayBattleSFX(var_3_2:GetHitSFX())

	local var_3_4 = {
		_bullet = var_3_2
	}

	var_3_4.equipIndex = var_3_2:GetWeapon():GetEquipmentIndex()
	var_3_4.bulletTag = var_3_2:GetExtraTag()

	var_3_2:BuffTrigger(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_BANG, var_3_4)

	local var_3_5 = var_3_2:GetDiveFilter()
	local var_3_6

	local function var_3_7(arg_4_0)
		if var_3_0.decay then
			var_3_6:UpdateDistanceInfo()
		end

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				var_3_1:HandleDamage(var_3_2, var_0_1:GetSceneMediator():GetCharacter(iter_4_1.UID):GetUnitData(), (var_3_0.decay or nil) and var_3_6:GetDistance(iter_4_1.UID) / (var_3_0.range * 0.5) * var_3_0.decay)
			end
		end

		return
	end

	var_3_6 = var_3_0.range and var_3_1:SpawnColumnArea(var_3_2:GetEffectField(), var_3_2:GetIFF(), pg.Tool.FilterY(self:GetPosition():Clone()), var_3_0.range, var_3_0.time, var_3_7) or var_3_1:SpawnCubeArea(var_3_2:GetEffectField(), var_3_2:GetIFF(), pg.Tool.FilterY(self:GetPosition():Clone()), var_3_0.width, var_3_0.height, var_3_0.time, var_3_7)

	var_3_6:SetDiveFilter(var_3_5)

	local var_3_8, var_3_9 = var_0_1.GetFXPool():GetFX(self:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_3_8, var_3_9:Add(self:GetTf().localPosition), true)

	if var_3_2:GetPierceCount() <= 0 then
		var_3_1:RemoveBulletUnit(var_3_2:GetUniqueID())
	end

	return
end

function ys.Battle.BattleTorpedoBulletFactory.onBulletMissFunc(arg_5_0)
	var_0_1.onBulletHitFunc(arg_5_0)

	return
end

function ys.Battle.BattleTorpedoBulletFactory:MakeModel(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetBulletData()
	local var_6_1 = var_6_0:GetTemplate()

	if not self:GetBulletPool():InstBullet(arg_6_1:GetModleID(), function(arg_7_0)
		arg_6_1:AddModel(arg_7_0)

		return
	end) then
		arg_6_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_6_1:SetSpawn(arg_6_2)
	arg_6_1:SetFXFunc(self.onBulletHitFunc, self.onBulletMissFunc)
	self:GetSceneMediator():AddBullet(arg_6_1)

	if var_6_0:GetIFF() ~= self:GetDataProxy():GetFriendlyCode() and var_6_1.alert_fx ~= "" then
		arg_6_1:MakeAlert(self:GetFXPool():GetFX(var_6_1.alert_fx))
	end

	return
end

return
