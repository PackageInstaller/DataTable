local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.sound.SoundManager
local KsoulTouchSpineComp = class("KsoulTouchSpineComp", require("app.fairyGUI.recruitKnightSoul.UI_KsoulTouchSpineComp"))

function KsoulTouchSpineComp:ctor()
	self._isShowTouchEffect = false
	self._isCalled = false
	self._highQuality = 1
	self._isJump = false
	self._scheduleId = nil

	self:_addListeners()
end

function KsoulTouchSpineComp:_addListeners()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_jumpBtn:addClickListener(handler(self, self._onJumpBtnClick))
end

function KsoulTouchSpineComp:_onTouchBegin(arg_3_1)
	arg_3_1:captureTouch()
end

function KsoulTouchSpineComp:_onTouchEnd(arg_4_1)
	if not self._isJump then
		self:_onClickTouchSpine()
	end
end

function KsoulTouchSpineComp:_onEnterSpineEvent(arg_5_1, arg_5_2)
	if arg_5_1.type == "event" then
		if (arg_5_1.eventData or {}).name == "idle" then
			self.m_touchEffect:addEffectSpine({
				anim = "play",
				name = "eff_ui_knightSoul_touch",
				isLoop = true
			})

			self._isShowTouchEffect = true
		end
	end
end

function KsoulTouchSpineComp:_onOpenSpineEvent(arg_6_1, arg_6_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_6_1.type and not self._isJump then
		self._isCalled = true
		self._scheduleId = self:newScheduleOnce(handler(self, self._onCall), 0)
	end
end

function KsoulTouchSpineComp:_onClickTouchSpine()
	local var_7_0

	if not self._isShowTouchEffect then
		do return end

		var_7_0 = {
			name = "eff_ui_knightSoul_open",
			isLoop = false,
			remove = true
		}
	end

	var_7_0.anim = "play_" .. math.max(3, self._highQuality + 1)
	var_7_0.eventHandler = handler(self, self._onOpenSpineEvent)

	self.m_openEffect:addEffectSpine(var_7_0)
	self.m_touchEffect:removeAllEffect()

	self._isShowTouchEffect = false

	var_0_1:playSound(var_0_0.Sound.UI_EVENT_KNIGHT_SOUL_CARD_OPEN)
end

function KsoulTouchSpineComp:setCallBack(arg_8_1)
	self._call = arg_8_1
end

function KsoulTouchSpineComp:playShow(arg_9_1)
	self._isJump = false

	self:_clearSchedule()
	self.m_enterEffect:removeAllEffect()
	self.m_touchEffect:removeAllEffect()
	self.m_openEffect:removeAllEffect()
	self:setVisible(true)
	var_0_1:playSound(var_0_0.Sound.UI_EVENT_KNIGHT_SOUL_CARD_SHOW)

	self._highQuality = arg_9_1.quality

	self.m_enterEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_knightSoul_enter",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onEnterSpineEvent)
	})
end

function KsoulTouchSpineComp:_onCall()
	if self._call ~= nil then
		self._call()
	end

	self._scheduleId = nil
end

function KsoulTouchSpineComp:_onJumpBtnClick()
	self._isJump = true

	if not self._isCalled then
		self:_clearSchedule()
		self:dispatchCompEvent("skipAnimation")

		self._isCalled = true

		return
	end
end

function KsoulTouchSpineComp:_clearEffect()
	self.m_enterEffect:removeAllEffect()
	self.m_touchEffect:removeAllEffect()
	self.m_openEffect:removeAllEffect()

	self._isShowTouchEffect = false
end

function KsoulTouchSpineComp:_clearSchedule()
	if self._scheduleId then
		self:cancelSchedule(self._scheduleId)
	end
end

function KsoulTouchSpineComp:playHide()
	self:_clearEffect()
	self:newScheduleOnce(handler(self, self.hideComp), 0.5)
end

function KsoulTouchSpineComp:hideComp()
	self:setVisible(false)
end

function KsoulTouchSpineComp:onLoad()
	self:_clearEffect()
end

function KsoulTouchSpineComp:onUnload()
	self._tipEffectEnable = false

	var_0_1:playSound(var_0_0.Sound.UI_CARD_IDLE_STOP)
	var_0_1:setMusicVolume(g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_VOLUME))
	self:_clearEffect()
end

return KsoulTouchSpineComp
