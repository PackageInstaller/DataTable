ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleMissileFactory", ys.Battle.BattleBombBulletFactory)

var_0_1.__name = "BattleMissileFactory"
ys.Battle.BattleMissileFactory = var_0_1

function var_0_1:MakeModel(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetBulletData()
	local var_1_1 = self:GetBulletPool():InstFX(arg_1_1:GetModleID())

	if var_1_1 then
		arg_1_1:AddModel(var_1_1)
	else
		arg_1_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_1_1:SetSpawn(arg_1_2)
	arg_1_1:SetFXFunc(self.onBulletHitFunc, self.onBulletHitFunc)
	self:GetSceneMediator():AddBullet(arg_1_1)

	return
end

function var_0_1:CreateBulletAlert()
	local var_2_0 = self:GetTemplate()

	if self:GetIFF() == var_0_1.GetDataProxy():GetFriendlyCode() then
		return
	end

	if #var_2_0.alert_fx <= 0 then
		return
	end

	local var_2_1 = var_2_0.hit_type.range
	local var_2_2 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(var_2_0.alert_fx)

	var_2_2.transform.localScale = Vector3(var_2_1, (pg.effect_offset[var_2_0.alert_fx] and pg.effect_offset[var_2_0.alert_fx].y_scale == true or nil) and var_2_1, var_2_1)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_2_2, self:GetExplodePostion())

	return
end

return
