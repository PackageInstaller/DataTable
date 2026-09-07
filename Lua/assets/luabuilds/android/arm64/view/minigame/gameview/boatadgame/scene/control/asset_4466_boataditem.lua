local BoatAdItem = class("BoatAdItem")
local var_0_1

function BoatAdItem:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "ad/bound"), typeof(BoxCollider2D))
	self._moveAnimator = GetComponent(self._tf, typeof(Animator))
	self._moveDftEvent = GetComponent(self._tf, typeof(DftAniEvent))
	self._hpTf = findTF(self._tf, "ad/img/hp")
	self.leftTf = findTF(self._tf, "ad/img/left")
	self.rightTf = findTF(self._tf, "ad/img/right")
	self.textureTf = findTF(self._tf, "ad/img/texture")

	self._moveDftEvent:SetEndEvent(function()
		self:setRemoveFlag(true)

		return
	end)

	return
end

function BoatAdItem:setData(arg_3_1)
	self._itemData = arg_3_1

	local var_3_0 = 0

	self._tf.name = arg_3_1.id

	if type(self:getConfig("hp")) == "number" then
		var_3_0 = self:getConfig("hp")
	elseif type(self:getConfig("hp")) == "table" then
		local var_3_1 = self:getConfig("hp")

		var_3_0 = math.random(var_3_1[1], var_3_1[2])
	end

	self._hp = var_3_0

	return
end

function BoatAdItem:start()
	self._removeFlag = false

	setActive(self.textureTf, true)

	self._touchFlag = false

	self:updateUI()

	return
end

function BoatAdItem:step(arg_5_1)
	return
end

function BoatAdItem:updateUI()
	if self:getConfig("buff") then
		if self._hp and not self:getConfig("item") then
			local var_6_0 = self:getConfig("hp_type")
			local var_6_1 = ""

			if var_6_0 == BoatAdGameConst.hp_type_sub then
				var_6_1 = self._hp >= 0 and "+" or ""
			elseif var_6_0 == BoatAdGameConst.hp_type_mul then
				var_6_1 = "*"
			elseif var_6_0 == BoatAdGameConst.hp_type_div then
				var_6_1 = "/"
			end

			setText(self._hpTf, var_6_1 .. self._hp)
			setActive(self._hpTf, true)
		else
			setActive(self._hpTf, false)
		end
	end

	return
end

function BoatAdItem:getHp()
	return self._hp
end

function BoatAdItem:setMoveCount(arg_8_1, arg_8_2)
	self.moveCount = arg_8_1
	self.line = arg_8_2

	self:setVisible(false)
	self:setVisible(true)
	self:setSpeed(1)
	self:setInteger(self._moveAnimator, "move_count", arg_8_1)

	if self:getConfig("buff") then
		self:setTrigger(self._moveAnimator, "buff")
	else
		self:setTrigger(self._moveAnimator, "move")
	end

	setActive(self.leftTf, false)
	setActive(self.rightTf, false)

	self.leftTf.localScale = Vector3(-1, 1, 1)
	self.rightTf.localScale = Vector3(1, 1, 1)

	if self.moveCount == 3 then
		setActive(self.leftTf, true)
		setActive(self.rightTf, true)
	elseif self.moveCount < 3 then
		setActive(self.leftTf, true)
	elseif self.moveCount > 3 then
		setActive(self.rightTf, true)
	end

	return
end

function BoatAdItem:getLine()
	return self.line
end

function BoatAdItem:setSpeed(arg_10_1)
	self._moveAnimator.speed = arg_10_1

	return
end

function BoatAdItem:getMoveCount()
	return self.moveCount
end

function BoatAdItem:getBuff()
	return self:getConfig("buff")
end

function BoatAdItem:setTrigger(arg_13_1, arg_13_2)
	arg_13_1:SetTrigger(arg_13_2)

	return
end

function BoatAdItem:setTouch()
	setActive(self.textureTf, false)
	setActive(self._hpTf, false)

	self._touchFlag = true

	return
end

function BoatAdItem:getTouchFlag()
	return self._touchFlag
end

function BoatAdItem:setInteger(arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:SetInteger(arg_16_2, arg_16_3)

	return
end

function BoatAdItem:getSpeed()
	return self._speed
end

function BoatAdItem:setContent(arg_18_1)
	self._content = arg_18_1

	SetParent(self._tf, arg_18_1)

	return
end

function BoatAdItem:getId()
	return self._itemData.id
end

function BoatAdItem:setVisible(arg_20_1)
	setActive(self._tf, arg_20_1)

	return
end

function BoatAdItem:clear()
	self:setVisible(false)

	return
end

function BoatAdItem:setRemoveFlag(arg_22_1)
	self._removeFlag = arg_22_1

	return
end

function BoatAdItem:getRemoveFlag()
	return self._removeFlag
end

function BoatAdItem:dispose()
	var_0_1 = nil

	return
end

function BoatAdItem:getColliderData()
	local var_25_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_25_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_25_1.x - var_25_0.x),
			height = math.floor(var_25_1.y - var_25_0.y)
		}
	end

	return var_25_0, self._boundData
end

function BoatAdItem:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function BoatAdItem:getTf()
	return self._tf
end

function BoatAdItem:getUseData()
	return {
		score = self:getConfig("score"),
		hp = self:getConfig("hp"),
		skill = self:getConfig("skill")
	}
end

function BoatAdItem:getScore()
	return self:getConfig("score")
end

function BoatAdItem:checkPositionInRange(arg_30_1)
	local var_30_0 = self:getConfig("range")

	if math.abs(self._tf.anchoredPosition.x - arg_30_1.x) < var_30_0.x and math.abs(self._tf.anchoredPosition.y - arg_30_1.y) < var_30_0.y then
		return true
	end

	return false
end

function BoatAdItem:getPosition()
	return self._tf.anchoredPosition
end

function BoatAdItem:getConfig(arg_32_1)
	return self._itemData[arg_32_1]
end

return BoatAdItem
