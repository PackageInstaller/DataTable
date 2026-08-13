ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.UnitType
local var_0_2 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_3 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_4 = var_0.Battle

singletonClass = var_0_10005
var_0_4.BattleCannonBulletFactory = var_0_10005("BattleCannonBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleCannonBulletFactory.__name = "BattleCannonBulletFactory"

local var_0_5 = var_0.Battle.BattleCannonBulletFactory

function var_0_5.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)

	return
end

function var_0_5.MakeBullet(arg_2_0)
	return var_0.Battle.BattleCannonBullet.New()
end

Quaternion = var_5

local var_0_6 = var_5.Euler(-90, 0, 0)

function var_0_5.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_5.GetDataProxy()
	local var_3_1 = arg_3_0:GetBulletData()
	local var_3_2 = var_4.GetTemplate(var_3_1)
	local var_3_3

	table = var_1_10007

	if var_1_10007.contains(var_0_2, arg_3_2) then
		local var_3_4 = var_0_5.GetSceneMediator()

		var_3_3 = var_7.GetAircraft(var_3_4, arg_3_1)
	else
		table = var_7

		if var_7.contains(var_0_3, arg_3_2) then
			local var_3_5 = var_0_5.GetSceneMediator()

			var_3_3 = var_7.GetCharacter(var_3_5, arg_3_1)
		end
	end

	if not var_3_3 then
		return
	end

	local var_3_6 = var_3_3:GetUnitData()
	local var_3_7 = {
		_bullet = var_4
	}
	local var_3_8 = var_4:GetWeapon()

	var_3_7.equipIndex = var_9.GetEquipmentIndex(var_3_8)
	var_3_7.bulletTag = var_4:GetExtraTag()

	var_4:BuffTrigger(var_0.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE_BEFORE, var_3_7)

	local var_3_9, var_3_10 = var_3_0:HandleDamage(var_4, var_3_6)
	local var_3_11

	if var_3_3:GetGO() then
		if var_3_9 then
			local var_3_12 = var_0_5.GetFXPool()
			local var_3_13, var_3_14 = var_12.GetFX(var_3_12, arg_3_0:GetMissFXID())
			local var_3_15 = var_3_3:GetUnitData()
			local var_3_16 = var_14.GetBoxSize(var_3_15)

			math = var_3_15

			local var_3_17

			if var_3_15.random(0, 1) == 0 then
				var_3_17 = -1
			end

			math = var_16

			local var_3_18 = (var_16.random() - 0.5) * var_3_16.x

			Vector3 = var_17
			var_1_10018 = var_17(var_3_18, 0, var_3_16.z * var_3_17)

			local var_3_19 = var_17.Add(var_1_10018, var_3_3:GetPosition())

			pg = var_1_10018

			local var_3_20 = var_1_10018.EffectMgr.GetInstance()

			var_1_10018.PlayBattleEffect(var_3_20, var_3_13, var_3_19:Add(var_3_14), true)
			var_0.Battle.PlayBattleSFX(var_4:GetMissSFX())
		else
			var_3_11 = var_3_3:AddFX(arg_3_0:GetFXID())

			var_0.Battle.PlayBattleSFX(var_4:GetHitSFX())

			local var_3_21 = var_3_6:GetDirection()

			var_13.x = (arg_3_0:GetPosition() - var_3_3:GetPosition()).x * var_3_21

			local var_3_22 = var_3_11.transform.localPosition
			local var_3_23 = var_0_6
			local var_3_24 = var_3_3
			local var_3_25 = (var_3_23 * var_3_3.GetTf(var_3_24).localRotation).eulerAngles.x

			math = var_3_24

			local var_3_26 = var_3_24.cos

			math = var_1_10018
			var_13.y = var_3_26(var_1_10018.deg2Rad * var_3_25) * var_13.z
			var_13.z = 0

			local var_3_27 = var_13 / var_3_3:GetInitScale()

			var_3_22:Add(var_3_27)

			var_3_11.transform.localPosition = var_3_22
		end
	end

	if var_3_11 then
		local var_3_28 = var_3_6:GetIFF()
		local var_3_29 = var_3_0

		if var_3_28 == var_3_0.GetFoeCode(var_3_29) then
			local var_3_30 = var_3_11.transform.localRotation

			Vector3 = var_3_29
			var_12.localRotation = var_3_29(var_3_30.x, 180, var_3_30.z)
		end
	end

	if var_4:GetPierceCount() <= 0 then
		var_3_0:RemoveBulletUnit(var_4:GetUniqueID())
	end

	return
end

function var_0_5.onBulletMissFunc(arg_4_0)
	local var_4_0 = arg_4_0:GetBulletData()
	local var_4_1 = var_1.GetTemplate(var_4_0)
	local var_4_2 = var_0_5.GetFXPool()
	local var_4_3, var_4_4 = var_3.GetFX(var_4_2, arg_4_0:GetMissFXID())

	pg = var_5

	local var_4_5 = var_5.EffectMgr.GetInstance()

	var_5.PlayBattleEffect(var_4_5, var_4_3, var_4_4:Add(arg_4_0:GetPosition()), true)
	var_0.Battle.PlayBattleSFX(var_1:GetMissSFX())

	return
end

function var_0_5.MakeModel(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0:GetDataProxy()
	local var_5_1 = arg_5_1:GetBulletData()
	local var_5_2 = arg_5_0:GetBulletPool()

	if not var_7.InstBullet(var_5_2, arg_5_1:GetModleID(), function(arg_6_0)
		local var_6_0 = arg_5_1

		var_1.AddModel(var_6_0, arg_6_0)

		return
	end) then
		local var_5_3 = arg_5_1
		local var_5_4 = arg_5_1.AddTempModel
		local var_5_5 = arg_5_0:GetTempGOPool()

		var_5_4(var_5_3, var_10.GetObject(var_5_5))
	end

	arg_5_1:SetSpawn(arg_5_2)
	arg_5_1:SetFXFunc(arg_5_0.onBulletHitFunc, arg_5_0.onBulletMissFunc)

	local var_5_6 = arg_5_0:GetSceneMediator()

	var_8.AddBullet(var_5_6, arg_5_1)

	return
end

return
