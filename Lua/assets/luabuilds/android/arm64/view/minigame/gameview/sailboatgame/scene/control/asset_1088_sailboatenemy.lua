local SailBoatEnemy = class("SailBoatEnemy")
local var_0_1

SailBoatEnemy.fire_cd = 0.2

function SailBoatEnemy:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._eventCall = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "bound"), typeof(BoxCollider2D))
	self._animator = GetComponent(findTF(self._tf, "img"), typeof(Animator))
	self._leftWeapons, self._rightWeapons = {}, {}

	return
end

function SailBoatEnemy:setData(arg_2_1)
	self._data = arg_2_1

	return
end

function SailBoatEnemy:start()
	self._removeFlag = false
	self._sceneWidth, self._sceneHeight = var_0_1.scene_width, var_0_1.scene_height
	self._maxRemoveHeight = -self._sceneHeight
	self._maxRemoveWidth = self._sceneWidth
	self._speed = self:getConfig("speed")
	self._targetX = nil
	self._targetY = nil
	self._targetIndex = 1
	self._hp = self:getConfig("hp")

	self:updateTarget()

	self._destroyFlag = false

	self:setInteger("dead_type", self:getConfig("dead_type") or 0)
	self:setVisible(true)

	self._stopFlag = false
	self._fireCd = SailBoatEnemy.fire_cd

	return
end

function SailBoatEnemy:step(arg_4_1)
	local var_4_0 = self._tf.anchoredPosition
	local var_4_1 = var_0_1.GetSceneSpeed()
	local var_4_2
	local var_4_3

	if self._targetIndex > 1 and self:getLife() and not self._targetX and not self._targetY and (self._targetListX and self._targetIndex <= #self._targetListX or self._targetListY and self._targetIndex <= #self._targetListY) then
		self:updateTarget()
	end

	if self._targetX then
		var_4_2 = self._targetSpeed[1] * arg_4_1 * (var_4_0.x >= self._targetX and -1 or 1)

		if (var_4_0.x >= self._targetX and -1 or 1) ~= (var_4_0.x + self._targetSpeed[1] * arg_4_1 * (var_4_0.x >= self._targetX and -1 or 1) >= self._targetX and -1 or 1) then
			self._targetX = nil

			if self._targetIndex > #self._targetListX then
				self:setTrigger("enter_end")
			end
		end
	else
		var_4_2 = self._speed.x * arg_4_1 + var_4_1.x
	end

	if self._targetY then
		var_4_3 = self._targetSpeed[2] * arg_4_1 * (var_4_0.y >= self._targetY and -1 or 1)

		if (var_4_0.y >= self._targetY and -1 or 1) ~= (var_4_0.y + self._targetSpeed[2] * arg_4_1 * (var_4_0.y >= self._targetY and -1 or 1) >= self._targetY and -1 or 1) then
			self._targetY = nil
		end
	else
		var_4_3 = self._speed.y * arg_4_1 + var_4_1.y
	end

	var_4_0.x = var_4_0.x + var_4_2
	var_4_0.y = var_4_0.y + var_4_3
	self._tf.anchoredPosition = var_4_0

	if not self._removeFlag then
		if var_4_0.y < self._maxRemoveHeight then
			self._removeFlag = true
		elseif math.abs(var_4_0.x) > self._maxRemoveWidth then
			self._removeFlag = true
		end
	end

	if self._removeTime and self._removeTime > 0 then
		self._removeTime = self._removeTime - arg_4_1

		if self._removeTime <= 0 then
			self._removeTime = nil
			self._removeFlag = true
		end
	end

	for iter_4_0 = 1, #self._leftWeapons do
		self._leftWeapons[iter_4_0]:step(arg_4_1)
	end

	for iter_4_1 = 1, #self._rightWeapons do
		self._rightWeapons[iter_4_1]:step(arg_4_1)
	end

	if self._fireCd and self._fireCd > 0 then
		self._fireCd = self._fireCd - arg_4_1

		if self._fireCd <= 0 then
			self._fireCd = 0
		end
	end

	return
end

function SailBoatEnemy:setWeapon(arg_5_1, arg_5_2)
	if self._leftWeapons and #self._leftWeapons > 0 then
		for iter_5_0 = 1, #self._leftWeapons do
			self._leftWeapons[iter_5_0]:clear()
		end
	end

	if self._rightWeapons and #self._rightWeapons > 0 then
		for iter_5_1 = 1, #self._rightWeapons do
			self._rightWeapons[iter_5_1]:clear()
		end
	end

	self._leftWeapons = arg_5_1
	self._rightWeapons = arg_5_2

	return
end

function SailBoatEnemy:setTarget(arg_6_1, arg_6_2, arg_6_3)
	self._targetListX = arg_6_1
	self._targetListY = arg_6_2
	self._targetSpeed = arg_6_3

	return
end

function SailBoatEnemy:updateTarget()
	if self._targetX or self._targetY then
		return
	end

	if self._targetListX and not self._targetX and self._targetIndex <= #self._targetListX then
		self._targetX = math.random(self._targetListX[self._targetIndex][1], self._targetListX[self._targetIndex][2])

		if self:getConfig("tpl") ~= "Enemys/Enemy_S" then
			if self:getConfig("tpl") == "Enemys/Enemy_SS" then
				self:setInteger("direct_x", self._tf.anchoredPosition.x < self._targetX and 1 or -1)
				self:setTrigger("enter")
			end

			if self._targetListY and not self._targetY and self._targetIndex <= #self._targetListY then
				self._targetY = math.random(self._targetListY[self._targetIndex][1], self._targetListY[self._targetIndex][2])
			end
		end
	end

	self._targetIndex = self._targetIndex + 1

	return
end

function SailBoatEnemy:setTrigger(arg_8_1, arg_8_2)
	if self:getLife() then
		self._animator:SetTrigger(arg_8_1)
	elseif arg_8_2 then
		self._animator:ResetTrigger("enter")
		self._animator:ResetTrigger("enter_end")
		self._animator:ResetTrigger("reset")
		self._animator:SetTrigger(arg_8_1)
	end

	return
end

function SailBoatEnemy:setInteger(arg_9_1, arg_9_2)
	self._animator:SetInteger(arg_9_1, arg_9_2)

	return
end

function SailBoatEnemy:getDestroyData()
	return {
		score = self:getConfig("score"),
		boom = self:getConfig("boom"),
		position = self._tf.anchoredPosition,
		range = self:getConfig("range")
	}
end

function SailBoatEnemy:damage(arg_11_1)
	if self._hp == 0 then
		return
	end

	self._hp = self._hp - arg_11_1.num

	if self._hp <= 0 then
		self:setTrigger("dead", true)

		self._hp = 0
		self._targetX = nil
		self._targetY = nil

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_BOOM)

		if self:getConfig("remove_time") then
			self._removeTime = self:getConfig("remove_time")

			return true
		end
	end

	return false
end

function SailBoatEnemy:getLife()
	return self._hp > 0
end

function SailBoatEnemy:getDestroyFlag()
	return self._destroyFlag
end

function SailBoatEnemy:getSpeed()
	return self._speed
end

function SailBoatEnemy:setContent(arg_15_1)
	self._content = arg_15_1

	SetParent(self._tf, arg_15_1)

	return
end

function SailBoatEnemy:getId()
	return self._data.id
end

function SailBoatEnemy:setVisible(arg_17_1)
	setActive(self._tf, arg_17_1)

	return
end

function SailBoatEnemy:setPosition(arg_18_1)
	self._tf.anchoredPosition = arg_18_1

	return
end

function SailBoatEnemy:getPosition()
	return self._tf.anchoredPosition
end

function SailBoatEnemy:getWorld()
	return self._tf.position
end

function SailBoatEnemy:clear()
	self:setVisible(false)

	return
end

function SailBoatEnemy:setRemoveFlag(arg_22_1)
	self._removeFlag = arg_22_1

	return
end

function SailBoatEnemy:getGroup()
	return self:getConfig("group")
end

function SailBoatEnemy:getHitGroup()
	return self:getConfig("hit_group")
end

function SailBoatEnemy:getTargetFlag()
	return self._targetX or self._targetY
end

function SailBoatEnemy:getTf()
	return self._tf
end

function SailBoatEnemy:getRemoveFlag()
	return self._removeFlag
end

function SailBoatEnemy:getRuleConfig(arg_28_1)
	return self._rule[arg_28_1]
end

function SailBoatEnemy:dispose()
	var_0_1 = nil

	return
end

function SailBoatEnemy:getColliderData()
	local var_30_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_30_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_30_1.x - var_30_0.x),
			height = math.floor(var_30_1.y - var_30_0.y)
		}
	end

	return var_30_0, self._boundData
end

function SailBoatEnemy:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function SailBoatEnemy:getStop()
	return self._stopFlag
end

function SailBoatEnemy:stopTarget(arg_33_1)
	if self._stopFlag then
		return
	end

	if self._targetX then
		self._targetX = nil
	end

	if self._targetY then
		self._targetY = nil
	end

	self._stopFlag = true

	self._animator:ResetTrigger("enter")
	self._animator:ResetTrigger("enter_end")
	self:setTrigger("reset")

	self._speed = arg_33_1

	return
end

function SailBoatEnemy:getMinMaxPosition()
	return self._collider.bounds.min, self._collider.bounds.max
end

function SailBoatEnemy:checkPositionInRange(arg_35_1)
	local var_35_0 = self:getConfig("range")

	if math.abs(self._tf.anchoredPosition.x - arg_35_1.x) < var_35_0.x and math.abs(self._tf.anchoredPosition.y - arg_35_1.y) < var_35_0.y then
		return true
	end

	return false
end

function SailBoatEnemy:getWeaponMaxDistance()
	if not self._weaponMaxDistance then
		self._weaponMaxDistance = 0

		for iter_36_0 = 1, #self._leftWeapons do
			if self._leftWeapons[iter_36_0]:getDistance() > self._weaponMaxDistance then
				self._weaponMaxDistance = self._leftWeapons[iter_36_0]:getDistance()
			end
		end

		for iter_36_1 = 1, #self._rightWeapons do
			if self._rightWeapons[iter_36_1]:getDistance() > self._weaponMaxDistance then
				self._weaponMaxDistance = self._rightWeapons[iter_36_1]:getDistance()
			end
		end
	end

	return self._weaponMaxDistance
end

function SailBoatEnemy:getWeapons()
	return self._leftWeapons, self._rightWeapons
end

function SailBoatEnemy:canFire()
	return #self._leftWeapons > 0 or #self._rightWeapons > 0
end

function SailBoatEnemy:inFireCd()
	return self._fireCd > 0
end

function SailBoatEnemy:fire()
	if self._fireCd <= 0 then
		self._fireCd = SailBoatEnemy.fire_cd

		return true
	end

	return false
end

function SailBoatEnemy:getFirePos()
	self._leftFireTf = self._leftFireTf or findTF(self._tf, "leftFire")
	self._rightFireTf = self._rightFireTf or findTF(self._tf, "rightFire")

	local var_41_0 = self._content:InverseTransformPoint(self._leftFireTf.position)
	local var_41_1 = self._content:InverseTransformPoint(self._rightFireTf.position)
end

function SailBoatEnemy:getFireContent()
	return self._leftFireTf, self._rightFireTf
end

function SailBoatEnemy:getConfig(arg_43_1)
	return self._data[arg_43_1]
end

return SailBoatEnemy
