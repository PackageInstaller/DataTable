local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")
local ExplorationRedPacketRainCell = class("ExplorationRedPacketRainCell", require("app.fairyGUI.exploration.UI_ExplorationRedPacketRainCell"))

function ExplorationRedPacketRainCell:ctor()
	self._struct = nil
	self._isPlayScaleAnim = false
	self._callback = nil
	self._duration = nil
end

function ExplorationRedPacketRainCell:updateRedPacketCell(arg_2_1, arg_2_2)
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
	self.m_typeController:setSelectedIndex(RedPacketRainConst.ICON_TYPE[arg_2_1:getIconKey()] or 0)
	self:setPosition((self._struct:getStartPosition()))

	if arg_2_1:isBigAward() then
		self.m_effBig:addEffectSpine({
			anim = "play_bigDown",
			isLoop = true,
			name = "eff_ui_exploration_tailing"
		})
		self.m_effUpB:addEffectSpine({
			anim = "play_bigUp",
			isLoop = true,
			name = "eff_ui_exploration_tailing"
		})
	else
		self.m_effSmall:addEffectSpine({
			anim = "play_smallDown",
			isLoop = true,
			name = "eff_ui_exploration_tailing"
		})
		self.m_effUpS:addEffectSpine({
			anim = "play_smallUp",
			isLoop = true,
			name = "eff_ui_exploration_tailing"
		})
		self.m_effSmall:setScale(1 / RedPacketRainConst.ICON_SCALE[arg_2_2])
		self.m_effUpS:setScale(1 / RedPacketRainConst.ICON_SCALE[arg_2_2])
	end
end

function ExplorationRedPacketRainCell:playClickAnim(arg_3_1)
	self._callback = arg_3_1

	self:setTouchable(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShootingStar_Click)
	self.m_smallTransition:play()
	self.m_effSmall:removeAllEffect()
	self.m_effUpS:removeAllEffect()
	self.m_effSmall:addEffectSpine({
		anim = "play_small",
		isLoop = false,
		name = "eff_ui_exploration_click",
		eventHandler = handler(self, self._finishRedPacketClick)
	})
end

function ExplorationRedPacketRainCell:_finishRedPacketClick(arg_4_1, arg_4_2)
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

function ExplorationRedPacketRainCell:playMoveAnim(arg_5_1)
	self._duration = arg_5_1 or self._duration

	self:stopAllFGActions()

	local var_5_0 = self._duration or RedPacketRainConst.DURATION

	self:runFGAction(self._struct:isBigAward() and fgui.FMoveTo:create(var_5_0, (self._struct:getEndPosition())) or fgui.FMoveBy:create(var_5_0, cc.p(-display.width, display.height)))
end

function ExplorationRedPacketRainCell:playScaleAnim(arg_6_1)
	if not self._struct:isClickNumReachTarget() then
		self._isPlayScaleAnim = true

		self._struct:addClickProcess()
		self.m_effCell:removeAllEffect()
		self.m_effCell:addEffectSpine({
			anim = "play_click",
			isLoop = false,
			name = "eff_ui_exploration_click",
			eventHandler = handler(self, self._oneClickBigRedPacket)
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShootingStar_Click)
		self.m_bigTransition:play()
		self:setScale(RedPacketRainConst.CLICK_SCALE[self._struct:getClickProcess()] or 1)
	end
end

function ExplorationRedPacketRainCell:_oneClickBigRedPacket(arg_7_1, arg_7_2)
	if arg_7_1.type == "complete" then
		self._isPlayScaleAnim = false
	end
end

function ExplorationRedPacketRainCell:bigAwardClickFinish(arg_8_1)
	self._callback = arg_8_1

	self.m_effBig:removeAllEffect()
	self.m_effUpB:removeAllEffect()
	self.m_effCell:removeAllEffect()
	self.m_effReward:removeAllEffect()
	self.m_rewardTransition:play()
	self.m_effReward:addEffectSpine({
		anim = "play_large",
		isLoop = false,
		name = "eff_ui_exploration_click",
		eventHandler = handler(self, self._onBigAwardFinish)
	})
end

function ExplorationRedPacketRainCell:_onBigAwardFinish()
	if self._callback then
		self._callback()

		self._callback = nil
	end
end

function ExplorationRedPacketRainCell:_onScaleAnimEnd()
	self._isPlayScaleAnim = false
end

function ExplorationRedPacketRainCell:getAwardIndex()
	return self._struct:getIndex()
end

function ExplorationRedPacketRainCell:isDestination()
	local var_12_0 = self:getPosition()

	return var_12_0.y > display.height or var_12_0.x < 0
end

function ExplorationRedPacketRainCell:isPlayScaleAnim()
	return self._isPlayScaleAnim
end

function ExplorationRedPacketRainCell:getRedPacketStruct()
	return self._struct
end

return ExplorationRedPacketRainCell
