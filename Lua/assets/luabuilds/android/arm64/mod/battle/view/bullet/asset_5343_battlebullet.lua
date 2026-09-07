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

function ys.Battle.BattleBullet:Update(arg_2_1)
	local var_2_0 = self._bulletData:GetSpeed()

	self._calcSpeed:Set(var_2_0.x, var_2_0.y, var_2_0.z)

	local var_2_1 = self._bulletData:GetVerticalSpeed()

	if var_2_1 ~= 0 then
		self._calcSpeed.y = self._calcSpeed.y + var_2_1
	end

	if self._cacheSpeed ~= self._calcSpeed then
		if self._rotateScript then
			self._rotateScript:SetSpeed(self._calcSpeed)
		end

		self._cacheSpeed:Set(self._calcSpeed.x, self._calcSpeed.y, self._calcSpeed.z)
	end

	if math.abs(self._calcSpeed.x) >= 0.01 or math.abs(self._calcSpeed.z) >= 0.01 or math.abs(self._calcSpeed.y) >= 0.01 then
		self:UpdatePosition()
	else
		local var_2_2 = self:GetPosition()

		if math.abs(self._cacheTFPos.x - var_2_2.x) >= 0.1 or math.abs(self._cacheTFPos.z - var_2_2.z) >= 0.1 or math.abs(self._cacheTFPos.y - var_2_2.y) >= 0.1 then
			self:UpdatePosition()
		end
	end

	return
end

function ys.Battle.BattleBullet:UpdatePosition()
	local var_3_0 = self:GetPosition()

	self._tf.localPosition = var_3_0

	self._cacheTFPos:Set(var_3_0.x, var_3_0.y, var_3_0.z)

	return
end

function ys.Battle.BattleBullet:DoOutRange()
	self:_bulletMissFunc()

	return
end

function ys.Battle.BattleBullet:SetBulletData(arg_5_1)
	self._bulletData = arg_5_1

	self._bulletData:SetStartTimeStamp(pg.TimeMgr.GetInstance():GetCombatTime())

	self._cfgTpl = arg_5_1:GetTemplate()
	self._IFF = arg_5_1:GetIFF()

	self:AddBulletEvent()

	return
end

function ys.Battle.BattleBullet:AddBulletEvent()
	self._bulletData:RegisterEventListener(self, var_0_1.HIT, self.onBulletHit)
	self._bulletData:RegisterEventListener(self, var_0_1.INTERCEPTED, self.onIntercepted)
	self._bulletData:RegisterEventListener(self, var_0_1.OUT_RANGE, self.onOutRange)

	return
end

function ys.Battle.BattleBullet:RemoveBulletEvent()
	self._bulletData:UnregisterEventListener(self, var_0_1.HIT)
	self._bulletData:UnregisterEventListener(self, var_0_1.INTERCEPTED)
	self._bulletData:UnregisterEventListener(self, var_0_1.OUT_RANGE)

	return
end

function ys.Battle.BattleBullet:onBulletHit(arg_8_1)
	self:_bulletHitFunc(arg_8_1.Data.UID, arg_8_1.Data.type)

	return
end

function ys.Battle.BattleBullet:onIntercepted()
	local var_9_0, var_9_1 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(self:GetBulletData():GetTemplate().hit_fx)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_9_0, var_9_1:Add(self:GetPosition()), true)

	return
end

function ys.Battle.BattleBullet:onOutRange(arg_10_1)
	self:DoOutRange()

	return
end

function ys.Battle.BattleBullet:GetBulletData()
	return self._bulletData
end

function ys.Battle.BattleBullet:GetPosition()
	return self._bulletData:GetPosition()
end

function ys.Battle.BattleBullet:Dispose()
	if self._rotateScript then
		self._rotateScript:SetSpeed(Vector3.zero)
	end

	self:RemoveBulletEvent()

	if self._isTempGO then
		self._factory:RecyleTempModel(self._go)
	else
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._go)
	end

	if self._trackFX then
		self.resMgr.GetInstance():DestroyOb(self._trackFX)
	end

	self._skeleton = nil
	self._go = nil
	self._tf = nil
	self._trackFX = nil

	var_0_0.EventListener.DetachEventListener(self)

	return
end

function ys.Battle.BattleBullet:GetModleID()
	return self._bulletData:GetModleID()
end

function ys.Battle.BattleBullet:GetFXID()
	return self._cfgTpl.hit_fx
end

function ys.Battle.BattleBullet:GetMissFXID()
	return self._cfgTpl.miss_fx
end

function ys.Battle.BattleBullet:GetTrackFXID()
	return self._cfgTpl.track_fx
end

function ys.Battle.BattleBullet:AddModel(arg_18_1)
	if self._isTempGO and self._go == nil then
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_18_1)

		return false
	else
		if self._isTempGO then
			LuaHelper.CopyTransformInfoGO(arg_18_1, self._go)
			self._factory:RecyleTempModel(self._go)

			self._isTempGO = false
		end

		self:SetGO(arg_18_1)
		self._bulletData:ActiveCldBox()

		if self._bulletData:IsAutoRotate() then
			self:AddRotateScript()
		end

		local var_18_0 = self._tf:Find("bullet")

		if var_18_0 and var_18_0:GetComponent(typeof(SpineAnim)) then
			self._skeleton = var_18_0:GetComponent("SkeletonAnimation")
			self._spineBullet = true

			var_18_0:GetComponent(typeof(SpineAnim)):SetAction("normal", 0, false)
		end

		local var_18_1 = self._tf:Find("bullet_random")

		if var_18_1 and var_18_1:GetComponent(typeof(SpineAnim)) then
			self._skeleton = var_18_1:GetComponent("SkeletonAnimation")
			self._spineBullet = true

			var_18_1:GetComponent(typeof(SpineAnim)):SetAction(tostring(math.random(3)), 0, false)
		end

		return true
	end

	return
end

function ys.Battle.BattleBullet:SetAnimaSpeed(arg_19_1)
	if self._skeleton then
		arg_19_1 = arg_19_1 or 1
		self._skeleton.timeScale = arg_19_1
	end

	return
end

function ys.Battle.BattleBullet:AddRotateScript()
	self._rotateScript = self.resMgr:GetRotateScript(self._go)

	return
end

function ys.Battle.BattleBullet:AddTempModel(arg_21_1)
	self._isTempGO = true

	self:SetGO(arg_21_1)

	if self._bulletData:IsAutoRotate() then
		self:AddRotateScript()
	end

	return
end

function ys.Battle.BattleBullet:AddTrack(arg_22_1)
	self._trackFX = arg_22_1

	LuaHelper.SetGOParentTF(arg_22_1, self._tf, false)

	return
end

function ys.Battle.BattleBullet:SetSpawn(arg_23_1)
	local var_23_0, var_23_1 = self:getHeightAdjust(arg_23_1)
	local var_23_2 = var_23_0:Clone()

	var_23_2.z = var_23_2.z + var_23_1
	self._tf.localPosition = var_23_2

	self._bulletData:SetSpawnPosition(var_23_2)

	local var_23_3, var_23_4, var_23_5 = self._bulletData:GetRotateInfo()

	if var_23_3 then
		self._bulletData:InitSpeed(self._bulletData:GetOffsetPriority() and math.rad2Deg * math.atan2(var_23_3.z - var_23_0.z, var_23_3.x - var_23_2.x) or math.rad2Deg * math.atan2(var_23_3.z - var_23_0.z - var_23_1, var_23_3.x - var_23_2.x))
	else
		self._bulletData:InitSpeed(nil)
	end

	return
end

function ys.Battle.BattleBullet:getHeightAdjust(arg_24_1)
	local var_24_0 = self._bulletData:GetTemplate().extra_param

	if var_24_0.airdrop then
		local var_24_1 = self._bulletData:GetExplodePostion()
		local var_24_2 = 0

		if var_24_0.dropOffset then
			var_24_2 = math.sqrt(math.abs(var_24_0.offsetY * 2 / self._bulletData._gravity)) * self._bulletData:GetConvertedVelocity()

			if self._bulletData:GetHost():GetDirection() < 0 then
				var_24_2 = var_24_2 * -1
			end
		end

		return Vector3(var_24_1.x - var_24_2, var_24_0.offsetY or arg_24_1.y, var_24_1.z), 0
	else
		local var_24_3, var_24_4 = self._bulletData:GetOffset()
		local var_24_5 = arg_24_1.x + var_24_3
		local var_24_6 = arg_24_1.z + var_24_4

		if self._bulletData:IsGravitate() then
			return Vector3(var_24_5, arg_24_1.y, var_24_6), 0
		else
			local var_24_7 = 0
			local var_24_8

			if var_0_2.BulletHeight >= arg_24_1.y then
				var_24_8 = arg_24_1.y
			else
				var_24_8 = var_0_2.BulletHeight
				var_24_7 = self.GetZExtraOffset(arg_24_1.y)
			end

			return Vector3(var_24_5, var_24_8, var_24_6), var_24_7
		end
	end

	return
end

function ys.Battle.BattleBullet.GetZExtraOffset(arg_25_0)
	return var_0_2.HeightOffsetRate * (arg_25_0 - var_0_2.BulletHeight)
end

function ys.Battle.BattleBullet:GetFactory()
	return self._factory
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

function ys.Battle.BattleBullet:Neutrailze()
	if self._bulletMissFunc then
		self:_bulletMissFunc()
	end

	SetActive(self._go, false)

	return
end

return
