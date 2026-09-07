local BoatAdBg = class("BoatAdBg")
local var_0_1

function BoatAdBg:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._tf = arg_1_1
	self._event = arg_1_2
	self._moveAnimator = GetComponent(self._tf, typeof(Animator))
	self._moveDftEvent = GetComponent(self._tf, typeof(DftAniEvent))
	self.spineTf = findTF(self._tf, "ad/img/spine")

	self._moveDftEvent:SetEndEvent(function()
		self:setRemoveFlag(true)

		return
	end)

	return
end

function BoatAdBg:setData(arg_3_1)
	self._data = arg_3_1

	return
end

function BoatAdBg:setSpeed(arg_4_1)
	self._moveAnimator.speed = arg_4_1

	return
end

function BoatAdBg:getMoveCount()
	return self.moveCount
end

function BoatAdBg:setRemoveFlag(arg_6_1)
	self._removeFlag = arg_6_1

	return
end

function BoatAdBg:getRemoveFlag()
	return self._removeFlag
end

function BoatAdBg:getId()
	return self:getConfig("id")
end

function BoatAdBg:getConfig(arg_9_1)
	return self._data[arg_9_1]
end

function BoatAdBg:setMoveCount(arg_10_1)
	self.moveCount = arg_10_1

	self:setVisible(false)
	self:setVisible(true)
	self:setSpeed(1)
	self:setInteger(self._moveAnimator, "move_count", arg_10_1)
	self:setTrigger(self._moveAnimator, "bg")

	return
end

function BoatAdBg:setInteger(arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:SetInteger(arg_11_2, arg_11_3)

	return
end

function BoatAdBg:setTrigger(arg_12_1, arg_12_2)
	arg_12_1:SetTrigger(arg_12_2)

	return
end

function BoatAdBg:setContent(arg_13_1)
	self._content = arg_13_1

	SetParent(self._tf, arg_13_1)

	return
end

function BoatAdBg:setVisible(arg_14_1)
	setActive(self._tf, arg_14_1)

	return
end

function BoatAdBg:getPosition()
	return self._tf.anchoredPosition
end

function BoatAdBg:start()
	self._removeFlag = false

	return
end

function BoatAdBg:step()
	return
end

function BoatAdBg:checkEmptyGrid()
	return
end

function BoatAdBg:stop()
	return
end

function BoatAdBg:clear()
	return
end

function BoatAdBg:dispose()
	return
end

return BoatAdBg
