local SailBoatBullet = class("SailBoatBullet")
local var_0_1

function SailBoatBullet:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._eventCall = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "bound"), typeof(BoxCollider2D))
	self._img = GetComponent(findTF(self._tf, "img"), typeof(Image))
	self._weaponData = nil

	return
end

function SailBoatBullet:setData(arg_2_1)
	self._data = arg_2_1

	return
end

function SailBoatBullet:start()
	self._removeFlag = false

	self:setSprite(var_0_1.GetBulletSprite(self._data.image))
	self:setVisible(true)

	self._moveDistance = 0
	self._lifeTime = 0

	self:setPosition(self._fireData.pos)
	self:setMove(self._fireData.move)
	self:setHitGroup(self._fireData.hit)

	if self._fireData.content then
		self:setContent(self._fireData.content)
	end

	if self:getConfig("fire_effect") then
		self._eventCall(SailBoatGameEvent.CREATE_EFFECT, {
			effect = self:getConfig("fire_effect"),
			direct = Vector3(self._move.x, 1, 1),
			position = self._fireData.effect_pos,
			content = self._fireData.effect_content
		})
	end

	return
end

function SailBoatBullet:getWorld()
	return self._tf.position
end

function SailBoatBullet:step(arg_5_1)
	self._tf.anchoredPosition.x = self._tf.anchoredPosition.x + self._move.x * arg_5_1 * self._speed
	self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + self._move.y * arg_5_1 * self._speed
	self._tf.anchoredPosition = self._tf.anchoredPosition

	if self._life and self._life > 0 then
		self._life = self._life - arg_5_1

		if self._life <= 0 then
			self._life = 0

			self:setRemoveFlag(true)
		end
	end

	if math.abs(self._tf.anchoredPosition.x) > SailBoatGameVo.scene_width then
		self._removeFlag = true
	elseif math.abs(self._tf.anchoredPosition.y) > SailBoatGameVo.scene_height then
		self._removeFlag = true
	end

	return
end

function SailBoatBullet:getDamage()
	return {
		num = self._weaponData.damage,
		position = self._tf.position
	}
end

function SailBoatBullet:setMove(arg_7_1)
	self._move = arg_7_1

	return
end

function SailBoatBullet:setPosition(arg_8_1)
	self._tf.anchoredPosition = arg_8_1

	return
end

function SailBoatBullet:hit()
	if self:getConfig("hit_effect") then
		self._eventCall(SailBoatGameEvent.CREATE_EFFECT, {
			effect = self:getConfig("hit_effect"),
			direct = Vector3(1, 1, 1),
			position = self._tf.anchoredPosition
		})
	end

	self._removeFlag = true

	return
end

function SailBoatBullet:setHitGroup(arg_10_1)
	self._hitGroup = arg_10_1

	return
end

function SailBoatBullet:getHitGroup()
	self._hitGroup = self._hitGroup or {}

	return self._hitGroup
end

function SailBoatBullet:setSprite(arg_12_1)
	self._img.sprite = arg_12_1

	self._img:SetNativeSize()

	return
end

function SailBoatBullet:getSpeed()
	return self._speed
end

function SailBoatBullet:setFireData(arg_14_1)
	self._fireData = arg_14_1

	return
end

function SailBoatBullet:setWeapon(arg_15_1)
	self._weaponData = arg_15_1
	self._speed = self._weaponData.speed
	self._damage = self._weaponData.damage
	self._life = self._weaponData.life

	return
end

function SailBoatBullet:setContent(arg_16_1)
	self._content = arg_16_1

	SetParent(self._tf, arg_16_1)

	return
end

function SailBoatBullet:getId()
	return self._data.id
end

function SailBoatBullet:setVisible(arg_18_1)
	setActive(self._tf, arg_18_1)

	return
end

function SailBoatBullet:setPosition(arg_19_1)
	self._tf.anchoredPosition = arg_19_1

	return
end

function SailBoatBullet:clear()
	self:setVisible(false)

	return
end

function SailBoatBullet:setRemoveFlag(arg_21_1)
	self._removeFlag = arg_21_1

	return
end

function SailBoatBullet:getRemoveFlag()
	return self._removeFlag
end

function SailBoatBullet:dispose()
	var_0_1 = nil

	return
end

function SailBoatBullet:getColliderData()
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

function SailBoatBullet:checkPositionInRange(arg_25_1)
	local var_25_0 = self:getConfig("range")

	if math.abs(self._tf.anchoredPosition.x - arg_25_1.x) < var_25_0.x and math.abs(self._tf.anchoredPosition.y - arg_25_1.y) < var_25_0.y then
		return true
	end

	return false
end

function SailBoatBullet:getPosition()
	return self._tf.anchoredPosition
end

function SailBoatBullet:getConfig(arg_27_1)
	return self._data[arg_27_1]
end

function SailBoatBullet:getWeaponConfig(arg_28_1)
	return self._weaponData[arg_28_1]
end

return SailBoatBullet
