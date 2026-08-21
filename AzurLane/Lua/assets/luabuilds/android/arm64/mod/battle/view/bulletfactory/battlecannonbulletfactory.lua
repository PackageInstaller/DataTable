ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConst.AircraftUnitType
local var_0_3 = ys.Battle.BattleConst.CharacterUnitType

ys.Battle.BattleCannonBulletFactory = singletonClass("BattleCannonBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleCannonBulletFactory.__name = "BattleCannonBulletFactory"

local var_0_4 = ys.Battle.BattleCannonBulletFactory

function ys.Battle.BattleCannonBulletFactory.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleCannonBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleCannonBullet.New()
end

local var_0_5 = Quaternion.Euler(-90, 0, 0)

function ys.Battle.BattleCannonBulletFactory.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_4.GetDataProxy()
	local var_3_1 = arg_3_0:GetBulletData()
	local var_3_2 = var_3_1:GetTemplate()
	local var_3_3

	if table.contains(var_0_2, arg_3_2) then
		var_3_3 = var_0_4.GetSceneMediator():GetAircraft(arg_3_1)
	elseif table.contains(var_0_3, arg_3_2) then
		var_3_3 = var_0_4.GetSceneMediator():GetCharacter(arg_3_1)
	end

	if not var_3_3 then
		return
	end

	local var_3_4 = var_3_3:GetUnitData()

	;({
		_bullet = var_3_1
	}).equipIndex = var_3_1:GetWeapon():GetEquipmentIndex()
	;({
		_bullet = var_3_1
	}).bulletTag = var_3_1:GetExtraTag()

	var_3_1:BuffTrigger(var_0_0.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE_BEFORE, {
		_bullet = var_3_1
	})

	local var_3_5, var_3_6 = var_3_0:HandleDamage(var_3_1, var_3_4)
	local var_3_7

	if var_3_3:GetGO() then
		if var_3_5 then
			local var_3_8, var_3_9 = var_0_4.GetFXPool():GetFX(arg_3_0:GetMissFXID())
			local var_3_10 = var_3_3:GetUnitData():GetBoxSize()
			local var_3_11 = math.random(0, 1)

			if var_3_11 == 0 then
				var_3_11 = -1
			end

			local var_3_12 = Vector3((math.random() - 0.5) * var_3_10.x, 0, var_3_10.z * var_3_11):Add(var_3_3:GetPosition())

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_3_8, var_3_12:Add(var_3_9), true)
			var_0_0.Battle.PlayBattleSFX(var_3_1:GetMissSFX())
		else
			var_3_7 = var_3_3:AddFX(arg_3_0:GetFXID())

			var_0_0.Battle.PlayBattleSFX(var_3_1:GetHitSFX())

			local var_3_13 = arg_3_0:GetPosition() - var_3_3:GetPosition()

			var_3_13.x = var_3_13.x * var_3_4:GetDirection()
			var_3_13.y = math.cos(math.deg2Rad * (var_0_5 * var_3_3:GetTf().localRotation).eulerAngles.x) * var_3_13.z
			var_3_13.z = 0

			var_3_7.transform.localPosition:Add(var_3_13 / var_3_3:GetInitScale())

			var_3_7.transform.localPosition = var_3_7.transform.localPosition
		end
	end

	if var_3_7 and var_3_4:GetIFF() == var_3_0:GetFoeCode() then
		var_3_7.transform.localRotation = Vector3(var_3_7.transform.localRotation.x, 180, var_3_7.transform.localRotation.z)
	end

	if var_3_1:GetPierceCount() <= 0 then
		var_3_0:RemoveBulletUnit(var_3_1:GetUniqueID())
	end

	return
end

function ys.Battle.BattleCannonBulletFactory.onBulletMissFunc(arg_4_0)
	local var_4_0 = arg_4_0:GetBulletData()
	local var_4_1 = var_4_0:GetTemplate()
	local var_4_2, var_4_3 = var_0_4.GetFXPool():GetFX(arg_4_0:GetMissFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_4_2, var_4_3:Add(arg_4_0:GetPosition()), true)
	var_0_0.Battle.PlayBattleSFX(var_4_0:GetMissSFX())

	return
end

function ys.Battle.BattleCannonBulletFactory.MakeModel(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0:GetDataProxy()
	local var_5_1 = arg_5_1:GetBulletData()

	if not arg_5_0:GetBulletPool():InstBullet(arg_5_1:GetModleID(), function(arg_6_0)
		arg_5_1:AddModel(arg_6_0)

		return
	end) then
		arg_5_1:AddTempModel(arg_5_0:GetTempGOPool():GetObject())
	end

	arg_5_1:SetSpawn(arg_5_2)
	arg_5_1:SetFXFunc(arg_5_0.onBulletHitFunc, arg_5_0.onBulletMissFunc)
	arg_5_0:GetSceneMediator():AddBullet(arg_5_1)

	return
end

return
