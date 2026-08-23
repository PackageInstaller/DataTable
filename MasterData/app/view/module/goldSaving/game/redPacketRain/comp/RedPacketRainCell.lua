local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")
local RedPacketRainCell = class("RedPacketRainCell", require("app.fairyGUI.goldSaving.UI_RedPacketRainCell"))

function RedPacketRainCell:ctor()
	self._struct = nil
	self._isPlayScaleAnim = false
	self._callback = nil
	self._duration = nil
end

function RedPacketRainCell:updateRedPacketCell(arg_2_1, arg_2_2)
	self.m_normalTransition:play()
	self.m_effSmall:removeAllEffect()
	self.m_effBig:removeAllEffect()
	self.m_effCell:removeAllEffect()
	self.m_effReward:removeAllEffect()
	self:setTouchable(true)

	if not arg_2_1 then
		return
	end

	self._struct = arg_2_1

	self:setScale(RedPacketRainConst.ICON_SCALE[arg_2_2])
	self:setRotation(arg_2_1:getRotation())
	self.m_typeController:setSelectedIndex(RedPacketRainConst.ICON_TYPE[arg_2_1:getIconKey()] or 0)
	self:setPosition((self._struct:getStartPosition()))

	if arg_2_1:isBigAward() then
		self.m_effBig:addEffectSpine({
			anim = "play",
			name = "eff_ui_redPacketRain_numberBig",
			isLoop = true
		})
	else
		local var_2_0 = {
			name = "eff_ui_redPacketRain_numberSmall",
			isLoop = true
		}

		var_2_0.anim = "play" .. math.random(1, 5)

		self.m_effSmall:addEffectSpine(var_2_0)
	end
end

function RedPacketRainCell:playClickAnim(arg_3_1)
	self._callback = arg_3_1

	self:setTouchable(false)
	self.m_smallTransition:play()
	self.m_effSmall:removeAllEffect()
	self.m_effSmall:addEffectSpine({
		anim = "play",
		name = "eff_ui_redPacketRain_clickSmall",
		isLoop = false,
		eventHandler = handler(self, self._finishRedPacketClick)
	})
end

function RedPacketRainCell:_finishRedPacketClick(arg_4_1, arg_4_2)
	if arg_4_1.type == "complete" then
		self.m_effSmall:removeAllEffect()

		if self._callback then
			self._callback()

			self._callback = nil
		end

		self:setTouchable(true)
	end
end

function RedPacketRainCell:playMoveAnim(arg_5_1)
	self._duration = arg_5_1 or self._duration

	self:stopAllFGActions()
	self:runFGAction((fgui.FMoveTo:create(self._duration or RedPacketRainConst.DURATION, (self._struct:getEndPosition()))))
end

function RedPacketRainCell:playScaleAnim(arg_6_1)
	if not self._struct:isClickNumReachTarget() then
		self._isPlayScaleAnim = true

		self._struct:addClickProcess()
		self.m_effCell:removeAllEffect()
		self.m_effCell:addEffectSpine({
			anim = "play",
			name = "eff_ui_redPacketRain_clickBig",
			isLoop = false,
			eventHandler = handler(self, self._oneClickBigRedPacket)
		})
		self:setScale(RedPacketRainConst.CLICK_SCALE[self._struct:getClickProcess()] or 1)
	end
end

function RedPacketRainCell:_oneClickBigRedPacket(arg_7_1, arg_7_2)
	if arg_7_1.type == "complete" then
		self.m_effBig:removeAllEffect()
		self.m_effBig:addEffectSpine({
			anim = "play",
			name = "eff_ui_redPacketRain_numberBig",
			isLoop = true
		})

		self._isPlayScaleAnim = false
	end
end

function RedPacketRainCell:bigAwardClickFinish(arg_8_1)
	self._callback = arg_8_1

	self.m_effBig:removeAllEffect()
	self.m_effCell:removeAllEffect()
	self.m_effReward:removeAllEffect()
	self.m_rewardTransition:play()
	self.m_effReward:addEffectSpine({
		anim = "play",
		name = "eff_ui_redPacketRain_reward",
		isLoop = false,
		eventHandler = handler(self, self._onBigAwardFinish)
	})
end

function RedPacketRainCell:_onBigAwardFinish()
	if self._callback then
		self._callback()

		self._callback = nil
	end
end

function RedPacketRainCell:_onScaleAnimEnd()
	self._isPlayScaleAnim = false
end

function RedPacketRainCell:getAwardIndex()
	return self._struct:getIndex()
end

function RedPacketRainCell:isDestination()
	return self:getPosition().y > display.height
end

function RedPacketRainCell:isPlayScaleAnim()
	return self._isPlayScaleAnim
end

function RedPacketRainCell:getRedPacketStruct()
	return self._struct
end

return RedPacketRainCell
