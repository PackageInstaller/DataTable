ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

singletonClass = var_0_10003
var_0_2.BattleBulletFactory = var_0_10003("BattleBulletFactory")
var_0.Battle.BattleBulletFactory.__name = "BattleBulletFactory"

local var_0_3 = var_0.Battle.BattleBulletFactory

function var_0_3.Ctor(arg_1_0)
	return
end

function var_0_3.RecyleTempModel(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tempGOPool

	var_2.Recycle(var_2_0, arg_2_1)

	return
end

function var_0_3.Clear(arg_3_0)
	if arg_3_0._tempGOPool then
		local var_3_0 = arg_3_0._tempGOPool

		var_1.Dispose(var_3_0)

		arg_3_0._tempGOPool = nil
	end

	return
end

function var_0_3.CreateBullet(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_2:SetOutRangeCallback(arg_4_0.OutRangeFunc)

	local var_4_0 = arg_4_0:MakeBullet()

	var_6.SetFactory(var_4_0, arg_4_0)
	var_6:SetBulletData(arg_4_2)
	arg_4_0:MakeModel(var_6, arg_4_3, arg_4_4, arg_4_5)

	if arg_4_4 and arg_4_4 ~= "" then
		arg_4_0:PlayFireFX(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, nil)
	end

	return var_6
end

function var_0_3.GetSceneMediator(arg_5_0)
	local var_5_0 = var_0.Battle.BattleState.GetInstance()

	return var_1.GetSceneMediator(var_5_0)
end

function var_0_3.GetDataProxy(arg_6_0)
	return var_0.Battle.BattleDataProxy.GetInstance()
end

function var_0_3.GetFXPool(arg_7_0)
	return var_0.Battle.BattleFXPool.GetInstance()
end

function var_0_3.GetBulletPool(arg_8_0)
	return var_0.Battle.BattleResourceManager.GetInstance()
end

function var_0_3.OutRangeFunc(arg_9_0)
	local var_9_0 = var_0_3.GetDataProxy()

	var_1.RemoveBulletUnit(var_9_0, arg_9_0:GetUniqueID())

	return
end

function var_0_3.GetTempGOPool(arg_10_0)
	if arg_10_0._tempGOPool == nil then
		GameObject = var_1

		local var_10_0 = var_1("temp_bullet_OBJ")

		SetActive = var_1_10002

		var_1_10002(var_10_0, false)

		local var_10_1 = arg_10_0:GetSceneMediator()
		local var_10_2 = var_2.GetBulletRoot(var_10_1).transform

		LuaHelper = var_3

		var_3.SetGOParentTF(var_10_0, var_10_2, false)

		pg = var_3

		local var_10_3 = var_3.Pool.New(var_10_2, var_10_0, 1, 15, false, false)

		arg_10_0._tempGOPool = var_3.InitSize(var_10_3)
	end

	return arg_10_0._tempGOPool
end

function var_0_3.PlayFireFX(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0 = arg_11_2:GetWeaponTempData().effect_move == 1

	if arg_11_4 == "" or arg_11_4 == nil then
		if arg_11_6 then
			arg_11_6()
		end
	else
		local var_11_1
		local var_11_2

		if var_11_0 then
			local var_11_3 = arg_11_0:GetFXPool()

			var_11_1, var_11_2 = var_10.GetFX(var_11_3, arg_11_4, arg_11_1)
		else
			local var_11_4 = arg_11_0:GetFXPool()

			var_11_1, var_11_2 = var_10.GetFX(var_11_4, arg_11_4)
			var_11_2 = var_11_2:Add(arg_11_3)
		end

		if arg_11_5 == var_0_1.UnitDir.LEFT then
			local var_11_5 = var_11_1.transform.localEulerAngles

			var_11_5.y = 180
			var_10.localEulerAngles = var_11_5
		end

		pg = var_10

		local var_11_6 = var_10.EffectMgr.GetInstance()

		var_10.PlayBattleEffect(var_11_6, var_11_1, var_11_2, true, arg_11_6, true)
	end

	return
end

function var_0_3.MakeBullet(arg_12_0)
	return nil
end

function var_0_3.MakeModel(arg_13_0, arg_13_1, arg_13_2)
	return nil
end

function var_0_3.MakeBombPreCastAlter(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:MakeModel(arg_14_1, arg_14_2)
end

function var_0_3.MakeModelAfterBombPreCastAlert(arg_15_0, arg_15_1)
	return nil
end

function var_0_3.MakeTrack(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:AddTrack(arg_16_2)

	pg = var_4

	local var_16_0 = var_4.EffectMgr.GetInstance()

	var_4.PlayBattleEffect(var_16_0, arg_16_2, arg_16_3, true)

	return
end

function var_0_3.RemoveBullet(arg_17_0, arg_17_1)
	arg_17_1:Dispose()

	return
end

function var_0_3.GetFactoryList()
	if var_0_3._factoryList == nil then
		var_0_3._factoryList = {
			[var_0_1.BulletType.CANNON] = var_0.Battle.BattleCannonBulletFactory.GetInstance(),
			[var_0_1.BulletType.BOMB] = var_0.Battle.BattleBombBulletFactory.GetInstance(),
			[var_0_1.BulletType.TORPEDO] = var_0.Battle.BattleTorpedoBulletFactory.GetInstance(),
			[var_0_1.BulletType.DIRECT] = var_0.Battle.BattleDirectBulletFactory.GetInstance(),
			[var_0_1.BulletType.SHRAPNEL] = var_0.Battle.BattleShrapnelBulletFactory.GetInstance(),
			[var_0_1.BulletType.ANTI_AIR] = var_0.Battle.BattleAntiAirBulletFactory.GetInstance(),
			[var_0_1.BulletType.ANTI_SEA] = var_0.Battle.BattleAntiSeaBulletFactory.GetInstance(),
			[var_0_1.BulletType.STRAY] = var_0.Battle.BattleStrayBulletFactory.GetInstance(),
			[var_0_1.BulletType.EFFECT] = var_0.Battle.BattleEffectBulletFactory.GetInstance(),
			[var_0_1.BulletType.BEAM] = var_0.Battle.BattleBeamBulletFactory.GetInstance(),
			[var_0_1.BulletType.G_BULLET] = var_0.Battle.BattleGravitationBulletFactory.GetInstance(),
			[var_0_1.BulletType.ELECTRIC_ARC] = var_0.Battle.BattleElectricArcBulletFactory.GetInstance(),
			[var_0_1.BulletType.SPACE_LASER] = var_0.Battle.BattleSpaceLaserFactory.GetInstance(),
			[var_0_1.BulletType.MISSILE] = var_0.Battle.BattleMissileFactory.GetInstance(),
			[var_0_1.BulletType.SCALE] = var_0.Battle.BattleScaleBulletFactory.GetInstance(),
			[var_0_1.BulletType.TRIGGER_BOMB] = var_0.Battle.BattleTriggerBulletFactory.GetInstance(),
			[var_0_1.BulletType.AAMissile] = var_0.Battle.BattleAAMissileFactory.GetInstance()
		}
	end

	return var_0_3._factoryList
end

function var_0_3.DestroyFactory()
	var_0_3._factoryList = nil

	return
end

function var_0_3.NeutralizeBullet()
	local var_20_0 = var_0.Battle.BattleAntiAirBulletFactory.GetInstance()

	var_0.NeutralizeBullet(var_20_0)

	local var_20_1 = var_0.Battle.BattleAntiSeaBulletFactory.GetInstance()

	var_0.NeutralizeBullet(var_20_1)

	return
end

function var_0_3.GetRandomBone(arg_21_0)
	math = var_1_10001

	local var_21_0 = var_1_10001.floor

	math = var_1_10003

	return arg_21_0[var_21_0(var_1_10003.Random(0, #arg_21_0)) + 1]
end

return
