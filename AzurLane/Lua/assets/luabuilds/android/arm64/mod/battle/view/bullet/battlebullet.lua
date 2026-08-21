ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleBullet = class("BattleBullet", ys.Battle.BattleSceneObject)
ys.Battle.BattleBullet.__name = "BattleBullet"

local var_0_4 = ys.Battle.BattleBullet

function ys.Battle.BattleBullet.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)
	var_0_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.resMgr = var_0_0.Battle.BattleResourceManager.GetInstance()
	arg_1_0._cacheSpeed = Vector3.zero
	arg_1_0._calcSpeed = Vector3.zero
	arg_1_0._cacheTFPos = Vector3.zero

	return
end

function ys.Battle.BattleBullet.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._bulletData:GetSpeed()

	arg_2_0._calcSpeed:Set(var_2_0.x, var_2_0.y, var_2_0.z)

	local var_2_1 = arg_2_0._bulletData:GetVerticalSpeed()

	if var_2_1 ~= 0 then
		arg_2_0._calcSpeed.y = arg_2_0._calcSpeed.y + var_2_1
	end

	if arg_2_0._cacheSpeed ~= arg_2_0._calcSpeed then
		if arg_2_0._rotateScript then
			arg_2_0._rotateScript:SetSpeed(arg_2_0._calcSpeed)
		end

		arg_2_0._cacheSpeed:Set(arg_2_0._calcSpeed.x, arg_2_0._calcSpeed.y, arg_2_0._calcSpeed.z)
	end

	if math.abs(arg_2_0._calcSpeed.x) >= 0.01 or math.abs(arg_2_0._calcSpeed.z) >= 0.01 or math.abs(arg_2_0._calcSpeed.y) >= 0.01 then
		arg_2_0:UpdatePosition()
	else
		local var_2_2 = arg_2_0:GetPosition()

		if math.abs(arg_2_0._cacheTFPos.x - var_2_2.x) >= 0.1 or math.abs(arg_2_0._cacheTFPos.z - var_2_2.z) >= 0.1 or math.abs(arg_2_0._cacheTFPos.y - var_2_2.y) >= 0.1 then
			arg_2_0:UpdatePosition()
		end
	end

	return
end

function ys.Battle.BattleBullet.UpdatePosition(arg_3_0)
	local var_3_0 = arg_3_0:GetPosition()

	arg_3_0._tf.localPosition = var_3_0

	arg_3_0._cacheTFPos:Set(var_3_0.x, var_3_0.y, var_3_0.z)

	return
end

function ys.Battle.BattleBullet.DoOutRange(arg_4_0)
	arg_4_0:_bulletMissFunc()

	return
end

function ys.Battle.BattleBullet.SetBulletData(arg_5_0, arg_5_1)
	arg_5_0._bulletData = arg_5_1

	arg_5_0._bulletData:SetStartTimeStamp(pg.TimeMgr.GetInstance():GetCombatTime())

	arg_5_0._cfgTpl = arg_5_1:GetTemplate()
	arg_5_0._IFF = arg_5_1:GetIFF()

	arg_5_0:AddBulletEvent()

	return
end

function ys.Battle.BattleBullet.AddBulletEvent(arg_6_0)
	arg_6_0._bulletData:RegisterEventListener(arg_6_0, var_0_1.HIT, arg_6_0.onBulletHit)
	arg_6_0._bulletData:RegisterEventListener(arg_6_0, var_0_1.INTERCEPTED, arg_6_0.onIntercepted)
	arg_6_0._bulletData:RegisterEventListener(arg_6_0, var_0_1.OUT_RANGE, arg_6_0.onOutRange)

	return
end

function ys.Battle.BattleBullet.RemoveBulletEvent(arg_7_0)
	arg_7_0._bulletData:UnregisterEventListener(arg_7_0, var_0_1.HIT)
	arg_7_0._bulletData:UnregisterEventListener(arg_7_0, var_0_1.INTERCEPTED)
	arg_7_0._bulletData:UnregisterEventListener(arg_7_0, var_0_1.OUT_RANGE)

	return
end

function ys.Battle.BattleBullet.onBulletHit(arg_8_0, arg_8_1)
	arg_8_0:_bulletHitFunc(arg_8_1.Data.UID, arg_8_1.Data.type)

	return
end

function ys.Battle.BattleBullet.onIntercepted(arg_9_0)
	local var_9_0, var_9_1 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(arg_9_0:GetBulletData():GetTemplate().hit_fx)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_9_0, var_9_1:Add(arg_9_0:GetPosition()), true)

	return
end

function ys.Battle.BattleBullet.onOutRange(arg_10_0, arg_10_1)
	arg_10_0:DoOutRange()

	return
end

function ys.Battle.BattleBullet.GetBulletData(arg_11_0)
	return arg_11_0._bulletData
end

function ys.Battle.BattleBullet.GetPosition(arg_12_0)
	return arg_12_0._bulletData:GetPosition()
end

function ys.Battle.BattleBullet.Dispose(arg_13_0)
	if arg_13_0._rotateScript then
		arg_13_0._rotateScript:SetSpeed(Vector3.zero)
	end

	arg_13_0:RemoveBulletEvent()

	if arg_13_0._isTempGO then
		arg_13_0._factory:RecyleTempModel(arg_13_0._go)
	else
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_13_0._go)
	end

	if arg_13_0._trackFX then
		arg_13_0.resMgr.GetInstance():DestroyOb(arg_13_0._trackFX)
	end

	arg_13_0._skeleton = nil
	arg_13_0._go = nil
	arg_13_0._tf = nil
	arg_13_0._trackFX = nil

	var_0_0.EventListener.DetachEventListener(arg_13_0)

	return
end

function ys.Battle.BattleBullet.GetModleID(arg_14_0)
	return arg_14_0._bulletData:GetModleID()
end

function ys.Battle.BattleBullet.GetFXID(arg_15_0)
	return arg_15_0._cfgTpl.hit_fx
end

function ys.Battle.BattleBullet.GetMissFXID(arg_16_0)
	return arg_16_0._cfgTpl.miss_fx
end

function ys.Battle.BattleBullet.GetTrackFXID(arg_17_0)
	return arg_17_0._cfgTpl.track_fx
end

function ys.Battle.BattleBullet.AddModel(arg_18_0, arg_18_1)
	if arg_18_0._isTempGO and arg_18_0._go == nil then
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_18_1)

		return false
	else
		if arg_18_0._isTempGO then
			LuaHelper.CopyTransformInfoGO(arg_18_1, arg_18_0._go)
			arg_18_0._factory:RecyleTempModel(arg_18_0._go)

			arg_18_0._isTempGO = false
		end

		arg_18_0:SetGO(arg_18_1)
		arg_18_0._bulletData:ActiveCldBox()

		if arg_18_0._bulletData:IsAutoRotate() then
			arg_18_0:AddRotateScript()
		end

		local var_18_0 = arg_18_0._tf:Find("bullet")

		if var_18_0 and var_18_0:GetComponent(typeof(SpineAnim)) then
			arg_18_0._skeleton = var_18_0:GetComponent("SkeletonAnimation")
			arg_18_0._spineBullet = true

			var_18_0:GetComponent(typeof(SpineAnim)):SetAction("normal", 0, false)
		end

		local var_18_1 = arg_18_0._tf:Find("bullet_random")

		if var_18_1 and var_18_1:GetComponent(typeof(SpineAnim)) then
			arg_18_0._skeleton = var_18_1:GetComponent("SkeletonAnimation")
			arg_18_0._spineBullet = true

			var_18_1:GetComponent(typeof(SpineAnim)):SetAction(tostring(math.random(3)), 0, false)
		end

		return true
	end

	return
end

function ys.Battle.BattleBullet.SetAnimaSpeed(arg_19_0, arg_19_1)
	if arg_19_0._skeleton then
		arg_19_1 = arg_19_1 or 1
		arg_19_0._skeleton.timeScale = arg_19_1
	end

	return
end

function ys.Battle.BattleBullet.AddRotateScript(arg_20_0)
	arg_20_0._rotateScript = arg_20_0.resMgr:GetRotateScript(arg_20_0._go)

	return
end

function ys.Battle.BattleBullet.AddTempModel(arg_21_0, arg_21_1)
	arg_21_0._isTempGO = true

	arg_21_0:SetGO(arg_21_1)

	if arg_21_0._bulletData:IsAutoRotate() then
		arg_21_0:AddRotateScript()
	end

	return
end

function ys.Battle.BattleBullet.AddTrack(arg_22_0, arg_22_1)
	arg_22_0._trackFX = arg_22_1

	LuaHelper.SetGOParentTF(arg_22_1, arg_22_0._tf, false)

	return
end

function ys.Battle.BattleBullet.SetSpawn(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = arg_23_0:getHeightAdjust(arg_23_1)
	local var_23_2 = var_23_0:Clone()

	var_23_2.z = var_23_2.z + var_23_1
	arg_23_0._tf.localPosition = var_23_2

	arg_23_0._bulletData:SetSpawnPosition(var_23_2)

	local var_23_3, var_23_4, var_23_5 = arg_23_0._bulletData:GetRotateInfo()

	if var_23_3 then
		local var_23_6 = arg_23_0._bulletData:GetOffsetPriority() and math.rad2Deg * math.atan2(var_23_3.z - var_23_0.z, var_23_3.x - var_23_2.x) or math.rad2Deg * math.atan2(var_23_3.z - var_23_0.z - var_23_1, var_23_3.x - var_23_2.x)

		arg_23_0._bulletData:InitSpeed(var_23_6)
	else
		arg_23_0._bulletData:InitSpeed(nil)
	end

	return
end

function ys.Battle.BattleBullet.getHeightAdjust(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._bulletData:GetTemplate().extra_param

	if var_24_0.airdrop then
		local var_24_1 = arg_24_0._bulletData:GetExplodePostion()
		local var_24_2 = 0

		if var_24_0.dropOffset then
			var_24_2 = math.sqrt(math.abs(var_24_0.offsetY * 2 / arg_24_0._bulletData._gravity)) * arg_24_0._bulletData:GetConvertedVelocity()

			if arg_24_0._bulletData:GetHost():GetDirection() < 0 then
				var_24_2 = var_24_2 * -1
			end
		end

		local var_24_4 = var_24_0.offsetY or arg_24_1.y

		return var_24_3(var_24_1.x - var_24_2, var_24_4, var_24_1.z), 0
	else
		local var_24_5, var_24_6 = arg_24_0._bulletData:GetOffset()
		local var_24_7 = arg_24_1.x + var_24_5
		local var_24_8 = arg_24_1.z + var_24_6

		if arg_24_0._bulletData:IsGravitate() then
			return Vector3(var_24_7, arg_24_1.y, var_24_8), 0
		else
			local var_24_9 = 0
			local var_24_10

			if var_0_2.BulletHeight >= arg_24_1.y then
				var_24_10 = arg_24_1.y
			else
				var_24_10 = var_0_2.BulletHeight
				var_24_9 = arg_24_0.GetZExtraOffset(arg_24_1.y)
			end

			return Vector3(var_24_7, var_24_10, var_24_8), var_24_9
		end
	end

	return
end

function ys.Battle.BattleBullet.GetZExtraOffset(arg_25_0)
	return var_0_2.HeightOffsetRate * (arg_25_0 - var_0_2.BulletHeight)
end

function ys.Battle.BattleBullet.GetFactory(arg_26_0)
	return arg_26_0._factory
end

function ys.Battle.BattleBullet.SetFactory(arg_27_0, arg_27_1)
	arg_27_0._factory = arg_27_1

	return
end

function ys.Battle.BattleBullet.SetFXFunc(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._bulletHitFunc = arg_28_1
	arg_28_0._bulletMissFunc = arg_28_2

	return
end

function ys.Battle.BattleBullet.Neutrailze(arg_29_0)
	if arg_29_0._bulletMissFunc then
		arg_29_0:_bulletMissFunc()
	end

	SetActive(arg_29_0._go, false)

	return
end

return
