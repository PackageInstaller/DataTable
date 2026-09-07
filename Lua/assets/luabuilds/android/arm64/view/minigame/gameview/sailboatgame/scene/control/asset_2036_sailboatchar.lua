local SailBoatChar = class("SailBoatChar")
local var_0_1

SailBoatChar.fire_cd = 0.1

function SailBoatChar:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._eventCallback = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "bound"), typeof(BoxCollider2D))
	self.imgTf = findTF(self._tf, "img")
	self._animator = GetComponent(self.imgTf, typeof(Animator))
	self._leftWeapons, self._rightWeapons = {}, {}
	self._hpTf = findTF(self._tf, "hp")
	self._hpSlider = GetComponent(findTF(self._tf, "hp"), typeof(Slider))

	setActive(self._tf, false)

	self._playerAnimator = GetComponent(self._tf, typeof(Animator))

	return
end

function SailBoatChar:setData(arg_2_1)
	self._data = arg_2_1
	self._baseSpeed = self:getConfig("speed")
	self._baseHp = self:getConfig("hp")

	return
end

function SailBoatChar:setWeapon(arg_3_1, arg_3_2)
	if self._leftWeapons and #self._leftWeapons > 0 then
		for iter_3_0 = 1, #self._leftWeapons do
			self._leftWeapons[iter_3_0]:clear()
		end
	end

	if self._rightWeapons and #self._rightWeapons > 0 then
		for iter_3_1 = 1, #self._rightWeapons do
			self._rightWeapons[iter_3_1]:clear()
		end
	end

	self._leftWeapons = arg_3_1
	self._rightWeapons = arg_3_2
	self._weaponMaxDistance = nil

	return
end

function SailBoatChar:setContent(arg_4_1, arg_4_2)
	self._content = arg_4_1

	SetParent(self._tf, arg_4_1)

	self._tf.anchoredPosition = arg_4_2

	return
end

function SailBoatChar:changeDirect(arg_5_1, arg_5_2)
	self._directX = arg_5_1
	self._directY = arg_5_2
	self.imgTf.localEulerAngles = self._directX < 0 and Vector3(0, 0, 3) or self._directX > 0 and Vector3(0, 0, -3) or Vector3(0, 0, 0)

	return
end

function SailBoatChar:getWorld()
	return self._tf.position
end

function SailBoatChar:start()
	self._directX = 0
	self._directY = 0

	setActive(self._tf, true)

	self._tf.anchoredPosition = Vector2(0, 0)

	for iter_7_0 = 1, #self._leftWeapons do
		self._leftWeapons[iter_7_0]:start()
	end

	for iter_7_1 = 1, #self._rightWeapons do
		self._rightWeapons[iter_7_1]:start()
	end

	self._speed = Vector2(0, 0)
	self._speed.x = self._baseSpeed.x + self:getEquipAttr("speed")
	self._speed.y = self._baseSpeed.y + self:getEquipAttr("speed")
	self._hp = self._baseHp + self:getEquipAttr("hp")
	self._hpSlider.minValue = 0
	self._hpSlider.maxValue = self._hp
	self._timeForDead = nil
	self._fireLeftCd = 0
	self._fireRightCd = 0
	self._skillTime = 0
	self.colliderDamageCd = 0
	self._hpSlider.value = self._hp

	return
end

function SailBoatChar:step(arg_8_1)
	if self:getLife() then
		local var_8_0 = self:getNextPosition(self._directX, self._directY)

		if math.abs(var_8_0.x) > var_0_1.scene_width / 2 + 50 or math.abs(var_8_0.y) > var_0_1.scene_height / 2 + 50 then
			-- block empty
		else
			self._tf.anchoredPosition = var_8_0
		end

		for iter_8_0 = #self._leftWeapons, 1, -1 do
			self._leftWeapons[iter_8_0]:step(arg_8_1)

			if self._skillTime and self._skillTime > 0 then
				self._leftWeapons[iter_8_0]:skillStep(arg_8_1)
			end
		end

		for iter_8_1 = #self._rightWeapons, 1, -1 do
			self._rightWeapons[iter_8_1]:step(arg_8_1)

			if self._skillTime and self._skillTime > 0 then
				self._rightWeapons[iter_8_1]:skillStep(arg_8_1)
			end
		end
	end

	if self._skillTime and self._skillTime > 0 then
		self._skillTime = self._skillTime - arg_8_1
	end

	if self.colliderDamageCd and self.colliderDamageCd > 0 then
		self.colliderDamageCd = self.colliderDamageCd - arg_8_1
	end

	if self._timeForDead and self._timeForDead > 0 then
		self._timeForDead = self._timeForDead - arg_8_1

		if self._timeForDead <= 0 then
			self._timeForDead = nil

			self._eventCallback(SailBoatGameEvent.PLAYER_DEAD)
		end
	end

	if self._fireLeftCd and self._fireLeftCd > 0 then
		self._fireLeftCd = self._fireLeftCd - arg_8_1

		if self._fireLeftCd <= 0 then
			self._fireLeftCd = 0
		end
	end

	if self._fireRightCd and self._fireRightCd > 0 then
		self._fireRightCd = self._fireRightCd - arg_8_1

		if self._fireRightCd <= 0 then
			self._fireRightCd = 0
		end
	end

	if math.abs(self._tf.anchoredPosition.x) > var_0_1.scene_width / 2 + 50 or math.abs(self._tf.anchoredPosition.y) > var_0_1.scene_height / 2 + 50 then
		self:damage({
			num = 999,
			position = Vector2(0, 0)
		})
	end

	return
end

function SailBoatChar:getHp()
	return self._hp
end

function SailBoatChar:getHpPos()
	return self._hpTf.position
end

function SailBoatChar:useSkill()
	self._skillTime = SailBoatGameVo.skillTime

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_SKILL)

	return
end

function SailBoatChar:getNextPosition(arg_12_1, arg_12_2)
	local var_12_0 = 0

	if arg_12_1 ~= 0 then
		var_12_0 = self._speed.x * arg_12_1 * var_0_1.deltaTime
	end

	local var_12_1 = 0

	if arg_12_2 ~= 0 then
		var_12_1 = self._speed.y * arg_12_2 * var_0_1.deltaTime
	end

	local var_12_2 = self._tf.anchoredPosition

	if var_12_0 ~= 0 or var_12_1 ~= 0 then
		var_12_2.x = var_12_2.x + var_12_0
		var_12_2.y = var_12_2.y + var_12_1

		return var_12_2
	end

	return var_12_2
end

function SailBoatChar:getWeapons()
	return self._leftWeapons, self._rightWeapons
end

function SailBoatChar:getFirePos()
	self._leftFireTf = self._leftFireTf or findTF(self._tf, "leftFire")
	self._rightFireTf = self._rightFireTf or findTF(self._tf, "rightFire")

	local var_14_0 = self._content:InverseTransformPoint(self._leftFireTf.position)
	local var_14_1 = self._content:InverseTransformPoint(self._rightFireTf.position)
end

function SailBoatChar:getFireContent()
	return self._leftFireTf, self._rightFireTf
end

function SailBoatChar:getWeaponMaxDistance()
	if not self._weaponMaxDistance then
		self._weaponMaxDistance = 0

		for iter_16_0 = 1, #self._leftWeapons do
			if self._leftWeapons[iter_16_0]:getDistance() > self._weaponMaxDistance then
				self._weaponMaxDistance = self._leftWeapons[iter_16_0]:getDistance()
			end
		end

		for iter_16_1 = 1, #self._rightWeapons do
			if self._rightWeapons[iter_16_1]:getDistance() > self._weaponMaxDistance then
				self._weaponMaxDistance = self._rightWeapons[iter_16_1]:getDistance()
			end
		end
	end

	return self._weaponMaxDistance
end

function SailBoatChar:flash()
	self.colliderDamageCd = var_0_1.collider_time

	self._playerAnimator:SetTrigger("flash")

	return
end

function SailBoatChar:move(arg_18_1, arg_18_2)
	self._tf.anchoredPosition.x = self._tf.anchoredPosition.x + arg_18_1
	self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + arg_18_2
	self._tf.anchoredPosition = self._tf.anchoredPosition

	return
end

function SailBoatChar:getMaxHp()
	return self._baseHp + self:getEquipAttr("hp")
end

function SailBoatChar:getTf()
	return self._tf
end

function SailBoatChar:clearEquipData()
	self._equipData = {}

	return
end

function SailBoatChar:setEquipData(arg_22_1)
	table.insert(self._equipData, arg_22_1)

	return
end

function SailBoatChar:getEquipAttr(arg_23_1)
	local var_23_0 = 0

	for iter_23_0 = 1, #self._equipData do
		var_23_0 = var_23_0 + self._equipData[iter_23_0][arg_23_1]
	end

	return var_23_0
end

function SailBoatChar:getColliderData()
	local var_24_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_24_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_24_1.x - var_24_0.x),
			height = math.floor(var_24_1.y - var_24_0.y)
		}
	end

	return var_24_0, self._boundData
end

function SailBoatChar:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function SailBoatChar:addHp(arg_26_1)
	if self:getLife() then
		self._hp = self._hp + arg_26_1

		local var_26_0 = self:getMaxHp()

		if var_26_0 < self._hp then
			self._hp = var_26_0
		end
	end

	return
end

function SailBoatChar:getLife()
	return self._hp > 0
end

function SailBoatChar:getColliderMinPosition()
	self._minPosition = self._minPosition or self._tf:InverseTransformPoint(self._collider.bounds.min)

	return self._minPosition
end

function SailBoatChar:getBoundData()
	local var_29_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_29_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_29_1.x - var_29_0.x),
			height = math.floor(var_29_1.y - var_29_0.y)
		}
	end

	return self._boundData
end

function SailBoatChar:getPosition()
	return self._tf.anchoredPosition
end

function SailBoatChar:getGroup()
	return self:getConfig("group")
end

function SailBoatChar:getHitGroup()
	return self:getConfig("hit_group")
end

function SailBoatChar:inFireCd(arg_33_1)
	if arg_33_1 > 0 then
		return self._fireRightCd > 0
	else
		return self._fireLeftCd > 0
	end

	return
end

function SailBoatChar:fire(arg_34_1)
	if arg_34_1 > 0 then
		if self._fireRightCd <= 0 then
			self._fireRightCd = SailBoatChar.fire_cd

			return true
		end

		return false
	else
		if self._fireLeftCd <= 0 then
			self._fireLeftCd = SailBoatChar.fire_cd

			return true
		end

		return false
	end

	return
end

function SailBoatChar:clear()
	return
end

function SailBoatChar:stop()
	return
end

function SailBoatChar:checkColliderDamage()
	return self.colliderDamageCd <= 0
end

function SailBoatChar:damage(arg_38_1)
	if not self:getLife() then
		return
	end

	local var_38_0 = arg_38_1.position

	if arg_38_1.position then
		if var_38_0.x > self._tf.position.x then
			self:setInteger("damage_direct", 1)
		else
			self:setInteger("damage_direct", -1)
		end
	end

	self._hp = self._hp - arg_38_1.num

	if self._hp <= 0 then
		self._hp = 0

		self:setTrigger("dead", true)

		self._timeForDead = 1
	elseif var_38_0 then
		self:setTrigger("damage")
	end

	return
end

function SailBoatChar:setTrigger(arg_39_1, arg_39_2)
	if self:getLife() then
		self._animator:SetTrigger(arg_39_1)
	elseif arg_39_2 then
		self._animator:SetTrigger(arg_39_1)
	end

	return
end

function SailBoatChar:setInteger(arg_40_1, arg_40_2)
	self._animator:SetInteger(arg_40_1, arg_40_2)

	return
end

function SailBoatChar:getMinMaxPosition()
	return self._collider.bounds.min, self._collider.bounds.max
end

function SailBoatChar:getConfig(arg_42_1)
	return self._data[arg_42_1]
end

function SailBoatChar:checkPositionInRange(arg_43_1)
	if math.abs(self._tf.anchoredPosition.x - arg_43_1.x) < 250 and math.abs(self._tf.anchoredPosition.y - arg_43_1.y) < 300 then
		return true
	end

	return false
end

function SailBoatChar:dispose()
	return
end

return SailBoatChar
