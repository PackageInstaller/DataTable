local SailBoatItem = class("SailBoatItem")
local var_0_1

function SailBoatItem:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "bound"), typeof(BoxCollider2D))

	return
end

function SailBoatItem:setData(arg_2_1)
	self._itemData = arg_2_1

	return
end

function SailBoatItem:start()
	self._removeFlag = false
	self._sceneWidth, self._sceneHeight = var_0_1.scene_width, var_0_1.scene_height
	self._maxRemoveHeight = -self._sceneHeight * 2
	self._maxRemoveWidth = self._sceneWidth * 2
	self._speed = self:getConfig("speed")

	self:setVisible(true)

	return
end

function SailBoatItem:step(arg_4_1)
	local var_4_0 = var_0_1.GetSceneSpeed()

	self._speed.x = self._speed.x * arg_4_1 + var_4_0.x
	self._speed.y = self._speed.y * arg_4_1 + var_4_0.y
	self._tf.anchoredPosition.x = self._tf.anchoredPosition.x + self._speed.x
	self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + self._speed.y
	self._tf.anchoredPosition = self._tf.anchoredPosition

	if not self._removeFlag then
		if self._tf.anchoredPosition.y < self._maxRemoveHeight then
			self._removeFlag = true
		elseif math.abs(self._tf.anchoredPosition.x) > self._maxRemoveWidth then
			self._removeFlag = true
		end
	end

	return
end

function SailBoatItem:getSpeed()
	return self._speed
end

function SailBoatItem:setContent(arg_6_1)
	self._content = arg_6_1

	SetParent(self._tf, arg_6_1)

	return
end

function SailBoatItem:getId()
	return self._itemData.id
end

function SailBoatItem:setVisible(arg_8_1)
	setActive(self._tf, arg_8_1)

	return
end

function SailBoatItem:setPosition(arg_9_1)
	self._tf.anchoredPosition = arg_9_1

	return
end

function SailBoatItem:clear()
	self:setVisible(false)

	return
end

function SailBoatItem:setRemoveFlag(arg_11_1)
	self._removeFlag = arg_11_1

	return
end

function SailBoatItem:getRemoveFlag()
	return self._removeFlag
end

function SailBoatItem:dispose()
	var_0_1 = nil

	return
end

function SailBoatItem:getColliderData()
	local var_14_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_14_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_14_1.x - var_14_0.x),
			height = math.floor(var_14_1.y - var_14_0.y)
		}
	end

	return var_14_0, self._boundData
end

function SailBoatItem:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function SailBoatItem:getTf()
	return self._tf
end

function SailBoatItem:getUseData()
	return {
		score = self:getConfig("score"),
		hp = self:getConfig("hp"),
		skill = self:getConfig("skill")
	}
end

function SailBoatItem:checkPositionInRange(arg_18_1)
	local var_18_0 = self:getConfig("range")

	if math.abs(self._tf.anchoredPosition.x - arg_18_1.x) < var_18_0.x and math.abs(self._tf.anchoredPosition.y - arg_18_1.y) < var_18_0.y then
		return true
	end

	return false
end

function SailBoatItem:getPosition()
	return self._tf.anchoredPosition
end

function SailBoatItem:getConfig(arg_20_1)
	return self._itemData[arg_20_1]
end

return SailBoatItem
