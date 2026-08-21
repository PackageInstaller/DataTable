ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.BattleBulletFactory = singletonClass("BattleBulletFactory")
ys.Battle.BattleBulletFactory.__name = "BattleBulletFactory"

local var_0_2 = ys.Battle.BattleBulletFactory

function ys.Battle.BattleBulletFactory.Ctor(arg_1_0)
	return
end

function ys.Battle.BattleBulletFactory.RecyleTempModel(arg_2_0, arg_2_1)
	arg_2_0._tempGOPool:Recycle(arg_2_1)

	return
end

function ys.Battle.BattleBulletFactory.Clear(arg_3_0)
	if arg_3_0._tempGOPool then
		arg_3_0._tempGOPool:Dispose()

		arg_3_0._tempGOPool = nil
	end

	return
end

function ys.Battle.BattleBulletFactory.CreateBullet(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_2:SetOutRangeCallback(arg_4_0.OutRangeFunc)

	local var_4_0 = arg_4_0:MakeBullet()

	var_4_0:SetFactory(arg_4_0)
	var_4_0:SetBulletData(arg_4_2)
	arg_4_0:MakeModel(var_4_0, arg_4_3, arg_4_4, arg_4_5)

	if arg_4_4 and arg_4_4 ~= "" then
		arg_4_0:PlayFireFX(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, nil)
	end

	return var_4_0
end

function ys.Battle.BattleBulletFactory.GetSceneMediator(arg_5_0)
	return var_0_0.Battle.BattleState.GetInstance():GetSceneMediator()
end

function ys.Battle.BattleBulletFactory.GetDataProxy(arg_6_0)
	return var_0_0.Battle.BattleDataProxy.GetInstance()
end

function ys.Battle.BattleBulletFactory.GetFXPool(arg_7_0)
	return var_0_0.Battle.BattleFXPool.GetInstance()
end

function ys.Battle.BattleBulletFactory.GetBulletPool(arg_8_0)
	return var_0_0.Battle.BattleResourceManager.GetInstance()
end

function ys.Battle.BattleBulletFactory.OutRangeFunc(arg_9_0)
	var_0_2.GetDataProxy():RemoveBulletUnit(arg_9_0:GetUniqueID())

	return
end

function ys.Battle.BattleBulletFactory.GetTempGOPool(arg_10_0)
	if arg_10_0._tempGOPool == nil then
		local var_10_0 = GameObject("temp_bullet_OBJ")

		SetActive(var_10_0, false)

		local var_10_1 = arg_10_0:GetSceneMediator():GetBulletRoot().transform

		LuaHelper.SetGOParentTF(var_10_0, var_10_1, false)

		arg_10_0._tempGOPool = pg.Pool.New(var_10_1, var_10_0, 1, 15, false, false):InitSize()
	end

	return arg_10_0._tempGOPool
end

function ys.Battle.BattleBulletFactory.PlayFireFX(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0 = arg_11_2:GetWeaponTempData().effect_move == 1

	if arg_11_4 == "" or arg_11_4 == nil then
		if arg_11_6 then
			arg_11_6()
		end
	else
		local var_11_1
		local var_11_2

		if var_11_0 then
			var_11_1, var_11_2 = arg_11_0:GetFXPool():GetFX(arg_11_4, arg_11_1)
		else
			var_11_1, var_11_2 = arg_11_0:GetFXPool():GetFX(arg_11_4)
			var_11_2 = var_11_2:Add(arg_11_3)
		end

		if arg_11_5 == var_0_1.UnitDir.LEFT then
			var_11_1.transform.localEulerAngles.y = 180
			var_11_1.transform.localEulerAngles = var_11_1.transform.localEulerAngles
		end

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_11_1, var_11_2, true, arg_11_6, true)
	end

	return
end

function ys.Battle.BattleBulletFactory.MakeBullet(arg_12_0)
	return nil
end

function ys.Battle.BattleBulletFactory.MakeModel(arg_13_0, arg_13_1, arg_13_2)
	return nil
end

function ys.Battle.BattleBulletFactory.MakeBombPreCastAlter(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:MakeModel(arg_14_1, arg_14_2)
end

function ys.Battle.BattleBulletFactory.MakeModelAfterBombPreCastAlert(arg_15_0, arg_15_1)
	return nil
end

function ys.Battle.BattleBulletFactory.MakeTrack(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:AddTrack(arg_16_2)
	pg.EffectMgr.GetInstance():PlayBattleEffect(arg_16_2, arg_16_3, true)

	return
end

function ys.Battle.BattleBulletFactory.RemoveBullet(arg_17_0, arg_17_1)
	arg_17_1:Dispose()

	return
end

function ys.Battle.BattleBulletFactory.GetFactoryList()
	if var_0_2._factoryList == nil then
		var_0_2._factoryList = {
			[var_0_1.BulletType.CANNON] = var_0_0.Battle.BattleCannonBulletFactory.GetInstance(),
			[var_0_1.BulletType.BOMB] = var_0_0.Battle.BattleBombBulletFactory.GetInstance(),
			[var_0_1.BulletType.TORPEDO] = var_0_0.Battle.BattleTorpedoBulletFactory.GetInstance(),
			[var_0_1.BulletType.DIRECT] = var_0_0.Battle.BattleDirectBulletFactory.GetInstance(),
			[var_0_1.BulletType.SHRAPNEL] = var_0_0.Battle.BattleShrapnelBulletFactory.GetInstance(),
			[var_0_1.BulletType.ANTI_AIR] = var_0_0.Battle.BattleAntiAirBulletFactory.GetInstance(),
			[var_0_1.BulletType.ANTI_SEA] = var_0_0.Battle.BattleAntiSeaBulletFactory.GetInstance(),
			[var_0_1.BulletType.STRAY] = var_0_0.Battle.BattleStrayBulletFactory.GetInstance(),
			[var_0_1.BulletType.EFFECT] = var_0_0.Battle.BattleEffectBulletFactory.GetInstance(),
			[var_0_1.BulletType.BEAM] = var_0_0.Battle.BattleBeamBulletFactory.GetInstance(),
			[var_0_1.BulletType.G_BULLET] = var_0_0.Battle.BattleGravitationBulletFactory.GetInstance(),
			[var_0_1.BulletType.ELECTRIC_ARC] = var_0_0.Battle.BattleElectricArcBulletFactory.GetInstance(),
			[var_0_1.BulletType.SPACE_LASER] = var_0_0.Battle.BattleSpaceLaserFactory.GetInstance(),
			[var_0_1.BulletType.MISSILE] = var_0_0.Battle.BattleMissileFactory.GetInstance(),
			[var_0_1.BulletType.SCALE] = var_0_0.Battle.BattleScaleBulletFactory.GetInstance(),
			[var_0_1.BulletType.TRIGGER_BOMB] = var_0_0.Battle.BattleTriggerBulletFactory.GetInstance(),
			[var_0_1.BulletType.AAMissile] = var_0_0.Battle.BattleAAMissileFactory.GetInstance()
		}
	end

	return var_0_2._factoryList
end

function ys.Battle.BattleBulletFactory.DestroyFactory()
	var_0_2._factoryList = nil

	return
end

function ys.Battle.BattleBulletFactory.NeutralizeBullet()
	var_0_0.Battle.BattleAntiAirBulletFactory.GetInstance():NeutralizeBullet()
	var_0_0.Battle.BattleAntiSeaBulletFactory.GetInstance():NeutralizeBullet()

	return
end

function ys.Battle.BattleBulletFactory.GetRandomBone(arg_21_0)
	return arg_21_0[math.floor(math.Random(0, #arg_21_0)) + 1]
end

return
