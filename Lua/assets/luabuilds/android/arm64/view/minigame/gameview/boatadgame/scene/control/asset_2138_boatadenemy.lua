local BoatAdEnemy = class("BoatAdEnemy")
local var_0_1
local var_0_2

BoatAdEnemy.name_index = 1

function BoatAdEnemy:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	self._tf = arg_1_1
	self._eventCall = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "ad/bound"), typeof(BoxCollider2D))
	self._moveAnimator = GetComponent(self._tf, typeof(Animator))
	self._moveDftEvent = GetComponent(self._tf, typeof(DftAniEvent))
	self._hpTf = findTF(self._tf, "ad/img/hp")
	self._ad = findTF(self._tf, "ad")
	self._imgTf = findTF(self._tf, "ad/img")
	self._speedDownTf = findTF(self._tf, "ad/img/speedDown")

	if self._speedDownTf then
		setActive(self._speedDownTf, false)
	end

	self._moveDftEvent:SetEndEvent(function()
		print("触发移除标记")
		self:setRemoveFlag(true)

		return
	end)

	return
end

function BoatAdEnemy:setData(arg_3_1)
	self._data = arg_3_1
	self._tf.name = self._data.id
	self._moveFlag = self:getConfig("move")
	self._moveSpeed = self:getConfig("speed")

	self:update()

	return
end

function BoatAdEnemy:update()
	setText(self._hpTf, self._hp)

	return
end

function BoatAdEnemy:start()
	BoatAdEnemy.name_index = BoatAdEnemy.name_index + 1
	self._removeFlag = false

	local var_5_0 = self:getConfig("hp")

	self._hp = 10

	if type(var_5_0) == "number" then
		self._hp = var_5_0
	elseif type(var_5_0) == "table" then
		self._hp = math.random(var_5_0[1], var_5_0[2])
	end

	self.moveDirect = math.random() < 0.5 and 1 or -1

	if self._speedDownTf then
		setActive(self._speedDownTf, false)
	end

	self._battleHp = 0
	self._destroyFlag = false
	self._stopFlag = false
	self._battleFlag = false
	self._ad.anchoredPosition = Vector2(0, 0)

	if self:getConfig("boss") then
		self._battleSubHp = var_0_2.battle_sub_hp_boss or var_0_2.battle_sub_hp
	end

	self:speedDown(false)
	self:update()

	return
end

function BoatAdEnemy:step(arg_6_1)
	if self._battleHp > 0 then
		self._hp = self._hp - self._battleSubHp

		if self._hp < 0 then
			self._hp = 0
			self._battleHp = 0
			self._battleFlag = true

			self:setRemoveFlag(true)
		end

		self:update()
	end

	if self._moveFlag and self:getSpeed() > 0 and self._battleHp <= 0 and not self:getRemoveFlag() then
		self._ad.anchoredPosition = Vector2(self._ad.anchoredPosition.x + self.moveDirect * self._moveSpeed * arg_6_1 * self._imgTf.localScale.x * ((self._speedDownFlag or nil) and (var_0_2.speed_down_rate or 1)), self._ad.anchoredPosition.y)

		local var_6_1 = false

		if self.moveDirect == 1 then
			var_6_1 = var_0_1.CheckPointOutRightLine(self:getScenePosition())
		elseif self.moveDirect == -1 then
			var_6_1 = var_0_1.CheckPointOutLeftLine(self:getScenePosition())
		end

		if var_6_1 then
			self.moveDirect = -self.moveDirect
		end
	end

	return
end

function BoatAdEnemy:setMoveCount(arg_7_1, arg_7_2)
	self.moveCount = arg_7_1
	self.line = arg_7_2

	self:setVisible(false)
	self:setVisible(true)
	self:setSpeed(1)
	self:setInteger(self._moveAnimator, "move_count", arg_7_1)
	self:setTrigger(self._moveAnimator, "move")

	return
end

function BoatAdEnemy:getScenePosition()
	return {
		x = self._tf.anchoredPosition.x + self._ad.anchoredPosition.x,
		y = self._tf.anchoredPosition.y + self._ad.anchoredPosition.y
	}
end

function BoatAdEnemy:getLine()
	return self.line
end

function BoatAdEnemy:getMoveCount()
	return self.moveCount
end

function BoatAdEnemy:bossFocus(arg_11_1)
	self._ad.anchoredPosition.x = self._ad.anchoredPosition.x + arg_11_1
	self._ad.anchoredPosition = self._ad.anchoredPosition

	return
end

function BoatAdEnemy:setTrigger(arg_12_1, arg_12_2)
	arg_12_1:SetTrigger("move")

	return
end

function BoatAdEnemy:getBoss()
	return self:getConfig("boss")
end

function BoatAdEnemy:setInteger(arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:SetInteger(arg_14_2, arg_14_3)

	return
end

function BoatAdEnemy:getLife()
	return self._hp > 0
end

function BoatAdEnemy:getScale()
	return self._imgTf.localScale.y
end

function BoatAdEnemy:getHp()
	return self._hp
end

function BoatAdEnemy:speedDown(arg_18_1)
	if self._moveFlag then
		self._speedDownFlag = arg_18_1

		setActive(self._speedDownTf, arg_18_1)
	end

	return
end

function BoatAdEnemy:battle(arg_19_1)
	self._battleHp = arg_19_1

	return
end

function BoatAdEnemy:getBattle()
	return self._battleHp > 0
end

function BoatAdEnemy:getSpeed()
	return self._moveAnimator.speed
end

function BoatAdEnemy:setSpeed(arg_22_1)
	self._moveAnimator.speed = arg_22_1

	return
end

function BoatAdEnemy:getDestroyFlag()
	return self._destroyFlag
end

function BoatAdEnemy:setContent(arg_24_1)
	self._content = arg_24_1

	SetParent(self._tf, arg_24_1)

	return
end

function BoatAdEnemy:getId()
	return self._data.id
end

function BoatAdEnemy:setVisible(arg_26_1)
	setActive(self._tf, arg_26_1)

	return
end

function BoatAdEnemy:getPosition()
	return self._tf.anchoredPosition
end

function BoatAdEnemy:getRelaPositionX()
	return self._tf.anchoredPosition.x + self._ad.anchoredPosition.x, self._tf.anchoredPosition.y + self._ad.anchoredPosition.y
end

function BoatAdEnemy:getWorld()
	return self._tf.position
end

function BoatAdEnemy:clear()
	self:setVisible(false)

	return
end

function BoatAdEnemy:setRemoveFlag(arg_31_1)
	self._removeFlag = arg_31_1

	return
end

function BoatAdEnemy:getGroup()
	return self:getConfig("group")
end

function BoatAdEnemy:getTf()
	return self._tf
end

function BoatAdEnemy:getRemoveFlag()
	return self._removeFlag
end

function BoatAdEnemy:getMoveCount()
	return self.moveCount
end

function BoatAdEnemy:dispose()
	var_0_1 = nil

	return
end

function BoatAdEnemy:getColliderData()
	local var_37_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_37_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_37_1.x - var_37_0.x),
			height = math.floor(var_37_1.y - var_37_0.y)
		}
	end

	return var_37_0, self._boundData
end

function BoatAdEnemy:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function BoatAdEnemy:getStop()
	return self._stopFlag
end

function BoatAdEnemy:getMinMaxPosition()
	return self._collider.bounds.min, self._collider.bounds.max
end

function BoatAdEnemy:getBoundWidth()
	return self._collider.size.x / 2
end

function BoatAdEnemy:checkPositionInRange(arg_42_1)
	local var_42_0 = self:getConfig("range")

	if math.abs(self._tf.anchoredPosition.x - arg_42_1.x) < var_42_0.x and math.abs(self._tf.anchoredPosition.y - arg_42_1.y) < var_42_0.y then
		return true
	end

	return false
end

function BoatAdEnemy:getConfig(arg_43_1)
	return self._data[arg_43_1]
end

return BoatAdEnemy
