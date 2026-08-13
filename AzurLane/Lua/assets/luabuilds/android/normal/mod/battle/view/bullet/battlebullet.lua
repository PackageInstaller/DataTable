ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleVariable
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleBullet = var_0_10005("BattleBullet", var_0.Battle.BattleSceneObject)
var_0.Battle.BattleBullet.__name = "BattleBullet"

local var_0_5 = var_0.Battle.BattleBullet

function var_0_5.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.resMgr = var_0.Battle.BattleResourceManager.GetInstance()
	Vector3 = var_1
	arg_1_0._cacheSpeed = var_1.zero
	Vector3 = var_1
	arg_1_0._calcSpeed = var_1.zero
	Vector3 = var_1
	arg_1_0._cacheTFPos = var_1.zero

	return
end

function var_0_5.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._bulletData
	local var_2_1 = var_2.GetSpeed(var_2_0)
	local var_2_2 = arg_2_0._calcSpeed

	var_3.Set(var_2_2, var_2_1.x, var_2_1.y, var_2_1.z)

	local var_2_3 = arg_2_0._bulletData

	if var_3.GetVerticalSpeed(var_2_3) ~= 0 then
		arg_2_0._calcSpeed.y = arg_2_0._calcSpeed.y + var_3
	end

	if arg_2_0._cacheSpeed ~= arg_2_0._calcSpeed then
		if arg_2_0._rotateScript then
			local var_2_4 = arg_2_0._rotateScript

			var_4.SetSpeed(var_2_4, arg_2_0._calcSpeed)
		end

		local var_2_5 = arg_2_0._cacheSpeed

		var_4.Set(var_2_5, arg_2_0._calcSpeed.x, arg_2_0._calcSpeed.y, arg_2_0._calcSpeed.z)
	end

	math = var_4

	if not (var_4.abs(arg_2_0._calcSpeed.x) >= 0.01) then
		math = var_4

		if not (var_4.abs(arg_2_0._calcSpeed.z) >= 0.01) then
			math = var_4

			if var_4.abs(arg_2_0._calcSpeed.y) >= 0.01 then
				arg_2_0:UpdatePosition()

				goto label_2_0
			end

			local var_2_6 = arg_2_0
			local var_2_7 = arg_2_0.GetPosition(var_2_6)

			math = var_2_6

			if not (var_2_6.abs(arg_2_0._cacheTFPos.x - var_2_7.x) >= 0.1) then
				math = var_5

				if not (var_5.abs(arg_2_0._cacheTFPos.z - var_2_7.z) >= 0.1) then
					math = var_5

					if var_5.abs(arg_2_0._cacheTFPos.y - var_2_7.y) >= 0.1 then
						arg_2_0:UpdatePosition()
					end

					::label_2_0::

					return
				end
			end
		end
	end
end

function var_0_5.UpdatePosition(arg_3_0)
	local var_3_0 = arg_3_0:GetPosition()

	arg_3_0._tf.localPosition = var_3_0

	local var_3_1 = arg_3_0._cacheTFPos

	var_2.Set(var_3_1, var_3_0.x, var_3_0.y, var_3_0.z)

	return
end

function var_0_5.DoOutRange(arg_4_0)
	arg_4_0._bulletMissFunc(arg_4_0)

	return
end

function var_0_5.SetBulletData(arg_5_0, arg_5_1)
	arg_5_0._bulletData = arg_5_1

	local var_5_0 = arg_5_0._bulletData
	local var_5_1 = var_2.SetStartTimeStamp

	pg = var_1_10004

	local var_5_2 = var_1_10004.TimeMgr.GetInstance()

	var_5_1(var_5_0, var_4.GetCombatTime(var_5_2))

	arg_5_0._cfgTpl = arg_5_1:GetTemplate()
	arg_5_0._IFF = arg_5_1:GetIFF()

	arg_5_0:AddBulletEvent()

	return
end

function var_0_5.AddBulletEvent(arg_6_0)
	local var_6_0 = arg_6_0._bulletData

	var_1.RegisterEventListener(var_6_0, arg_6_0, var_0_1.HIT, arg_6_0.onBulletHit)

	local var_6_1 = arg_6_0._bulletData

	var_1.RegisterEventListener(var_6_1, arg_6_0, var_0_1.INTERCEPTED, arg_6_0.onIntercepted)

	local var_6_2 = arg_6_0._bulletData

	var_1.RegisterEventListener(var_6_2, arg_6_0, var_0_1.OUT_RANGE, arg_6_0.onOutRange)

	return
end

function var_0_5.RemoveBulletEvent(arg_7_0)
	local var_7_0 = arg_7_0._bulletData

	var_1.UnregisterEventListener(var_7_0, arg_7_0, var_0_1.HIT)

	local var_7_1 = arg_7_0._bulletData

	var_1.UnregisterEventListener(var_7_1, arg_7_0, var_0_1.INTERCEPTED)

	local var_7_2 = arg_7_0._bulletData

	var_1.UnregisterEventListener(var_7_2, arg_7_0, var_0_1.OUT_RANGE)

	return
end

function var_0_5.onBulletHit(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.Data
	local var_8_1 = arg_8_1.Data.UID
	local var_8_2 = arg_8_1.Data.type

	arg_8_0._bulletHitFunc(arg_8_0, var_8_1, var_8_2)

	return
end

function var_0_5.onIntercepted(arg_9_0)
	local var_9_0 = var_0.Battle.BattleFXPool.GetInstance()
	local var_9_1 = var_1.GetFX
	local var_9_2 = arg_9_0:GetBulletData()
	local var_9_3, var_9_4 = var_9_1(var_9_0, var_3.GetTemplate(var_9_2).hit_fx)

	pg = var_3

	local var_9_5 = var_3.EffectMgr.GetInstance()

	var_3.PlayBattleEffect(var_9_5, var_9_3, var_9_4:Add(arg_9_0:GetPosition()), true)

	return
end

function var_0_5.onOutRange(arg_10_0, arg_10_1)
	arg_10_0:DoOutRange()

	return
end

function var_0_5.GetBulletData(arg_11_0)
	return arg_11_0._bulletData
end

function var_0_5.GetPosition(arg_12_0)
	local var_12_0 = arg_12_0._bulletData

	return var_1.GetPosition(var_12_0)
end

function var_0_5.Dispose(arg_13_0)
	if arg_13_0._rotateScript then
		local var_13_0 = arg_13_0._rotateScript
		local var_13_1 = var_1.SetSpeed

		Vector3 = var_1_10003

		var_13_1(var_13_0, var_1_10003.zero)
	end

	arg_13_0:RemoveBulletEvent()

	if arg_13_0._isTempGO then
		local var_13_2 = arg_13_0._factory

		var_1.RecyleTempModel(var_13_2, arg_13_0._go)
	else
		local var_13_3 = var_0.Battle.BattleResourceManager.GetInstance()

		var_1.DestroyOb(var_13_3, arg_13_0._go)
	end

	if arg_13_0._trackFX then
		local var_13_4 = arg_13_0.resMgr.GetInstance()

		var_1.DestroyOb(var_13_4, arg_13_0._trackFX)
	end

	arg_13_0._skeleton = nil
	arg_13_0._go = nil
	arg_13_0._tf = nil
	arg_13_0._trackFX = nil

	var_0.EventListener.DetachEventListener(arg_13_0)

	return
end

function var_0_5.GetModleID(arg_14_0)
	local var_14_0 = arg_14_0._bulletData

	return var_1.GetModleID(var_14_0)
end

function var_0_5.GetFXID(arg_15_0)
	return arg_15_0._cfgTpl.hit_fx
end

function var_0_5.GetMissFXID(arg_16_0)
	return arg_16_0._cfgTpl.miss_fx
end

function var_0_5.GetTrackFXID(arg_17_0)
	return arg_17_0._cfgTpl.track_fx
end

function var_0_5.AddModel(arg_18_0, arg_18_1)
	if arg_18_0._isTempGO and arg_18_0._go == nil then
		local var_18_0 = var_0.Battle.BattleResourceManager.GetInstance()

		var_2.DestroyOb(var_18_0, arg_18_1)

		return false
	else
		if arg_18_0._isTempGO then
			LuaHelper = var_2

			var_2.CopyTransformInfoGO(arg_18_1, arg_18_0._go)

			local var_18_1 = arg_18_0._factory

			var_2.RecyleTempModel(var_18_1, arg_18_0._go)

			arg_18_0._isTempGO = false
		end

		arg_18_0:SetGO(arg_18_1)

		local var_18_2 = arg_18_0._bulletData

		var_2.ActiveCldBox(var_18_2)

		local var_18_3 = arg_18_0._bulletData

		if var_2.IsAutoRotate(var_18_3) then
			arg_18_0:AddRotateScript()
		end

		local var_18_4 = arg_18_0._tf

		if var_2.Find(var_18_4, "bullet") then
			local var_18_5 = var_2
			local var_18_6 = var_2.GetComponent

			typeof = var_1_10005
			SpineAnim = var_1_10006

			if var_18_6(var_18_5, var_1_10005(var_1_10006)) then
				arg_18_0._skeleton = var_2:GetComponent("SkeletonAnimation")
				arg_18_0._spineBullet = true

				local var_18_7 = var_2
				local var_18_8 = var_2.GetComponent

				typeof = var_5
				SpineAnim = var_1_10006

				local var_18_9 = var_18_8(var_18_7, var_5(var_1_10006))

				var_3.SetAction(var_18_9, "normal", 0, false)
			end
		end

		local var_18_10 = arg_18_0._tf

		if var_3.Find(var_18_10, "bullet_random") then
			local var_18_11 = var_3
			local var_18_12 = var_3.GetComponent

			typeof = var_1_10006
			SpineAnim = var_1_10007

			if var_18_12(var_18_11, var_1_10006(var_1_10007)) then
				arg_18_0._skeleton = var_3:GetComponent("SkeletonAnimation")
				arg_18_0._spineBullet = true

				local var_18_13 = var_3
				local var_18_14 = var_3.GetComponent

				typeof = var_6
				SpineAnim = var_1_10007

				local var_18_15 = var_18_14(var_18_13, var_6(var_1_10007))

				tostring = var_18_13
				math = var_6

				local var_18_16 = var_18_13(var_6.random(3))

				var_18_15:SetAction(var_18_16, 0, false)
			end
		end

		return true
	end

	return
end

function var_0_5.SetAnimaSpeed(arg_19_0, arg_19_1)
	if arg_19_0._skeleton then
		arg_19_1 = arg_19_1 or 1
		arg_19_0._skeleton.timeScale = arg_19_1
	end

	return
end

function var_0_5.AddRotateScript(arg_20_0)
	local var_20_0 = arg_20_0.resMgr

	arg_20_0._rotateScript = var_1.GetRotateScript(var_20_0, arg_20_0._go)

	return
end

function var_0_5.AddTempModel(arg_21_0, arg_21_1)
	arg_21_0._isTempGO = true

	arg_21_0:SetGO(arg_21_1)

	local var_21_0 = arg_21_0._bulletData

	if var_2.IsAutoRotate(var_21_0) then
		arg_21_0:AddRotateScript()
	end

	return
end

function var_0_5.AddTrack(arg_22_0, arg_22_1)
	arg_22_0._trackFX = arg_22_1
	LuaHelper = var_1_10002

	var_1_10002.SetGOParentTF(arg_22_1, arg_22_0._tf, false)

	return
end

function var_0_5.SetSpawn(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = arg_23_0:getHeightAdjust(arg_23_1)

	var_4.z = var_23_0:Clone().z + var_23_1
	arg_23_0._tf.localPosition = var_4

	local var_23_2 = arg_23_0._bulletData

	var_5.SetSpawnPosition(var_23_2, var_4)

	local var_23_3 = arg_23_0._bulletData
	local var_23_4, var_23_5, var_23_6 = var_5.GetRotateInfo(var_23_3)

	if var_23_4 then
		local var_23_7
		local var_23_8 = arg_23_0._bulletData
		local var_23_9

		if var_9.GetOffsetPriority(var_23_8) then
			math = var_23_9
			var_23_9 = var_23_9.rad2Deg
			math = var_23_8
			var_23_7 = var_23_9 * var_23_8.atan2(var_23_4.z - var_23_0.z, var_23_4.x - var_4.x)
		else
			math = var_23_9

			local var_23_10 = var_23_9.rad2Deg

			math = var_23_8
			var_23_7 = var_23_10 * var_23_8.atan2(var_23_4.z - var_23_0.z - var_23_1, var_23_4.x - var_4.x)
		end

		local var_23_11 = arg_23_0._bulletData

		var_9.InitSpeed(var_23_11, var_23_7)
	else
		local var_23_12 = arg_23_0._bulletData

		var_8.InitSpeed(var_23_12, nil)
	end

	return
end

function var_0_5.getHeightAdjust(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._bulletData

	if var_2.GetTemplate(var_24_0).extra_param.airdrop then
		local var_24_1 = arg_24_0._bulletData
		local var_24_2 = var_3.GetExplodePostion(var_24_1)
		local var_24_3 = 0
		local var_24_4

		if var_2.dropOffset then
			math = var_24_4
			var_24_4 = var_24_4.sqrt
			math = var_1_10006
			var_24_4 = var_24_4(var_1_10006.abs(var_2.offsetY * 2 / arg_24_0._bulletData._gravity))

			local var_24_5 = arg_24_0._bulletData

			var_24_3 = var_24_4 * var_6.GetConvertedVelocity(var_24_5)

			local var_24_6 = arg_24_0._bulletData
			local var_24_7 = var_24_4.GetHost(var_24_6)

			if var_24_4.GetDirection(var_24_7) < 0 then
				var_24_3 = var_24_3 * -1
			end
		end

		Vector3 = var_24_4

		local var_24_8 = var_24_2.x - var_24_3
		local var_24_9

		if not var_2.offsetY then
			var_24_9 = arg_24_1.y
		end

		return var_24_4(var_24_8, var_24_9, var_24_2.z), 0
	else
		local var_24_10 = arg_24_0._bulletData
		local var_24_11, var_24_12 = var_3.GetOffset(var_24_10)
		local var_24_13 = arg_24_1.x + var_24_11
		local var_24_14 = arg_24_1.z + var_24_12
		local var_24_15 = arg_24_0._bulletData

		if var_5.IsGravitate(var_24_15) then
			Vector3 = var_5

			return var_5(var_24_13, arg_24_1.y, var_24_14), 0
		else
			local var_24_16 = 0
			local var_24_17
			local var_24_18 = var_0_2.BulletHeight

			if arg_24_1.y <= var_24_18 then
				var_24_17 = arg_24_1.y
			else
				var_24_17 = var_24_18
				var_24_16 = arg_24_0.GetZExtraOffset(arg_24_1.y)
			end

			Vector3 = var_8

			return var_8(var_24_13, var_24_17, var_24_14), var_24_16
		end
	end

	return
end

function var_0_5.GetZExtraOffset(arg_25_0)
	return var_0_2.HeightOffsetRate * (arg_25_0 - var_0_2.BulletHeight)
end

function var_0_5.GetFactory(arg_26_0)
	return arg_26_0._factory
end

function var_0_5.SetFactory(arg_27_0, arg_27_1)
	arg_27_0._factory = arg_27_1

	return
end

function var_0_5.SetFXFunc(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._bulletHitFunc = arg_28_1
	arg_28_0._bulletMissFunc = arg_28_2

	return
end

function var_0_5.Neutrailze(arg_29_0)
	if arg_29_0._bulletMissFunc then
		arg_29_0._bulletMissFunc(arg_29_0)
	end

	SetActive = var_1

	var_1(arg_29_0._go, false)

	return
end

return
