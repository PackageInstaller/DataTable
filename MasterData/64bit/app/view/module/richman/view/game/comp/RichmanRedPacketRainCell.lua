local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")
local RichmanRedPacketRainCell = class("RichmanRedPacketRainCell", require("app.fairyGUI.richman.UI_RichmanRedPacketRainCell"))

function RichmanRedPacketRainCell:ctor()
	self._struct = nil
	self._isPlayScaleAnim = false
	self._callback = nil
	self._duration = nil
end

function RichmanRedPacketRainCell:updateRedPacketCell(arg_2_1, arg_2_2)
	self.m_normalTransition:play()
	self.m_effSmall:removeAllEffect()
	self.m_effSmall:setAlpha(1)
	self.m_effBig:removeAllEffect()
	self.m_effUpS:removeAllEffect()
	self.m_effUpS:setAlpha(1)
	self.m_effUpB:removeAllEffect()
	self.m_effCell:removeAllEffect()
	self.m_effReward:removeAllEffect()
	self:setTouchable(true)

	if not arg_2_1 then
		return
	end

	self._struct = arg_2_1

	self:setScale(RedPacketRainConst.ICON_SCALE[arg_2_2])
	self:setRotation(arg_2_1:getRotation())
	self.m_typeController:setSelectedIndex(RedPacketRainConst.RICH_MAN_ICON_TYPE[arg_2_1:getIconKey()] or 0)
	self:setPosition((self._struct:getStartPosition()))

	if arg_2_1:isBigAward() then
		self.m_effUpB:addEffectSpine({
			name = "eff_ui_richman_tailing",
			isLoop = true,
			anim = "play_big"
		})
	else
		self.m_effUpS:addEffectSpine({
			name = "eff_ui_richman_tailing",
			isLoop = true,
			anim = "play_small"
		})
		self.m_effSmall:setScale(1 / RedPacketRainConst.ICON_SCALE[arg_2_2])
		self.m_effUpS:setScale(1 / RedPacketRainConst.ICON_SCALE[arg_2_2])
	end
end

function RichmanRedPacketRainCell:playClickAnim(arg_3_1)
	self._callback = arg_3_1

	self:setTouchable(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShootingStar_Click)
	self.m_smallTransition:play()
	self.m_effSmall:removeAllEffect()
	self.m_effUpS:removeAllEffect()
	self.m_effSmall:addEffectSpine({
		name = "eff_ui_richman_click",
		isLoop = false,
		anim = "play_small",
		eventHandler = handler(self, self._finishRedPacketClick)
	})
end

function RichmanRedPacketRainCell:_finishRedPacketClick(arg_4_1, arg_4_2)
	if arg_4_1.type == "complete" then
		self.m_effSmall:removeAllEffect()
		self.m_effUpS:removeAllEffect()

		if self._callback then
			self._callback()

			self._callback = nil
		end

		self:setTouchable(true)
	end
end

function RichmanRedPacketRainCell:playMoveAnim(arg_5_1)
	self._duration = arg_5_1 or self._duration

	self:stopAllFGActions()

	local var_5_0 = self._duration or RedPacketRainConst.DURATION

	self:runFGAction(self._struct:isBigAward() and fgui.FMoveTo:create(var_5_0, (self._struct:getEndPosition())) or fgui.FMoveBy:create(var_5_0, cc.p(-display.width, display.height)))
end

function RichmanRedPacketRainCell:playScaleAnim(arg_6_1)
	if not self._struct:isClickNumReachTarget() then
		self._isPlayScaleAnim = true

		self._struct:addClickProcess()
		self.m_effCell:removeAllEffect()
		self.m_effCell:addEffectSpine({
			name = "eff_ui_richman_click",
			isLoop = false,
			anim = "play_click",
			eventHandler = handler(self, self._oneClickBigRedPacket)
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShootingStar_Click)
		self.m_bigTransition:play()
		self:setScale(RedPacketRainConst.CLICK_SCALE[self._struct:getClickProcess()] or 1)
	end
end

function RichmanRedPacketRainCell:_oneClickBigRedPacket(arg_7_1, arg_7_2)
	if arg_7_1.type == "complete" then
		self._isPlayScaleAnim = false
	end
end

function RichmanRedPacketRainCell:bigAwardClickFinish(arg_8_1)
	self._callback = arg_8_1

	self.m_effBig:removeAllEffect()
	self.m_effUpB:removeAllEffect()
	self.m_effCell:removeAllEffect()
	self.m_effReward:removeAllEffect()
	self.m_rewardTransition:play()
	self.m_effReward:addEffectSpine({
		name = "eff_ui_richman_click",
		isLoop = false,
		anim = "play_large",
		eventHandler = handler(self, self._onBigAwardFinish)
	})
end

function RichmanRedPacketRainCell:_onBigAwardFinish()
	if self._callback then
		self._callback()

		self._callback = nil
	end
end

function RichmanRedPacketRainCell:_onScaleAnimEnd()
	self._isPlayScaleAnim = false
end

function RichmanRedPacketRainCell:getAwardIndex()
	return self._struct:getIndex()
end

function RichmanRedPacketRainCell:isDestination()
	local var_12_0 = self:getPosition()

	return var_12_0.y > display.height or var_12_0.x < 0
end

function RichmanRedPacketRainCell:isPlayScaleAnim()
	return self._isPlayScaleAnim
end

function RichmanRedPacketRainCell:getRedPacketStruct()
	return self._struct
end

return RichmanRedPacketRainCell
