ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConst.AircraftUnitType
local var_0_3 = ys.Battle.BattleConst.CharacterUnitType

ys.Battle.BattleAAMissileFactory = singletonClass("BattleAAMissileFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleAAMissileFactory.__name = "BattleAAMissileFactory"

local var_0_4 = ys.Battle.BattleAAMissileFactory

function ys.Battle.BattleAAMissileFactory.MakeBullet(arg_1_0)
	return var_0_0.Battle.BattleTorpedoBullet.New()
end

function ys.Battle.BattleAAMissileFactory:onBulletHitFunc(arg_2_1, arg_2_2)
	local var_2_0 = self:GetBulletData()
	local var_2_1 = var_2_0:getTrackingTarget()

	if var_2_1 == -1 then
		var_0_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(self, arg_2_1, arg_2_2)

		return
	end

	local var_2_2 = var_2_0:GetTemplate()
	local var_2_3 = var_0_4.GetDataProxy()
	local var_2_4

	if table.contains(var_0_2, arg_2_2) then
		var_2_4 = var_0_4.GetSceneMediator():GetAircraft(arg_2_1):GetUnitData()
	elseif table.contains(var_0_3, arg_2_2) then
		var_2_4 = var_0_4.GetSceneMediator():GetCharacter(arg_2_1):GetUnitData()
	end

	if not var_2_4 or not var_2_1 or var_2_4:GetUniqueID() ~= var_2_1:GetUniqueID() then
		return
	end

	var_0_0.Battle.PlayBattleSFX(var_2_0:GetHitSFX())

	local var_2_5, var_2_6 = var_0_4.GetFXPool():GetFX(self:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_2_5, var_2_6:Add(self:GetTf().localPosition), true)

	local var_2_7, var_2_8 = var_2_3:HandleDamage(var_2_0, var_2_4)

	if var_2_0:GetPierceCount() <= 0 then
		var_2_0:CleanAimMark()
		var_2_3:RemoveBulletUnit(var_2_0:GetUniqueID())
	end

	return
end

function ys.Battle.BattleAAMissileFactory.onBulletMissFunc(arg_3_0)
	var_0_4.onBulletHitFunc(arg_3_0)

	return
end

function ys.Battle.BattleAAMissileFactory:MakeModel(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetBulletData()
	local var_4_1 = var_4_0:GetTemplate()

	if not self:GetBulletPool():InstBullet(arg_4_1:GetModleID(), function(arg_5_0)
		arg_4_1:AddModel(arg_5_0)

		return
	end) then
		arg_4_1:AddTempModel(self:GetTempGOPool():GetObject())
	end

	arg_4_1:SetSpawn(arg_4_2)
	arg_4_1:SetFXFunc(self.onBulletHitFunc, self.onBulletMissFunc)
	self:GetSceneMediator():AddBullet(arg_4_1)

	if var_4_0:GetIFF() ~= self:GetDataProxy():GetFriendlyCode() and var_4_1.alert_fx ~= "" then
		arg_4_1:MakeAlert(self:GetFXPool():GetFX(var_4_1.alert_fx))
	end

	return
end

return
