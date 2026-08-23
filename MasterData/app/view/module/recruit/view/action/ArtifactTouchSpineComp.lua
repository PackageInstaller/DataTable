local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.sound.SoundManager
local var_0_2 = 10
local var_0_3 = 350
local var_0_4 = 75
local var_0_5 = 40
local var_0_6 = 40
local var_0_7 = 0
local ArtifactTouchSpineComp = class("ArtifactTouchSpineComp", require("app.fairyGUI.recruit.UI_ArtifactTouchSpineComp"))

function ArtifactTouchSpineComp:ctor()
	self._landSpine = nil
	self._landDuration = 0
	self._movePos = 0
	self._touchPos = nil
	self._curProgress = 0
	self._isAutoMoving = false
	self._isTouched = false
	self._isRestMove = false
	self._autoMovingSchedule = nil
	self._endScheduler = nil
	self._highQuality = 1

	self:_addListeners()
	self.m_tipEffectNode:addEffectSpine({
		anim = "play",
		name = "eff_ui_recruitArtifact_arrow",
		isLoop = true
	})

	self._tipEffectEnable = false
	self._tipEffectTimer = nil

	self:_initPos()
end

function ArtifactTouchSpineComp:_addListeners()
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function ArtifactTouchSpineComp:_initPos()
	if display.width / 1334 > 1 or display.height / 750 > 1 then
		local var_3_0 = math.max(display.width / 1334, display.height / 750)

		self.m_spineNode:setScale(var_3_0)
		self.m_touchSpineNode:setScale(var_3_0)
		self.m_tipEffectNode:setScale(var_3_0)

		local var_3_1 = self:getSize()

		self:setSize(cc.size(1334 * var_3_0, 750 * var_3_0))

		local var_3_2 = self.m_spineNode:getPosition()
		local var_3_3 = self.m_tipEffectNode:getPosition()

		var_3_3.x = var_3_3.x - (math.max(1, var_3_0) - 1) * (var_3_2.x - var_3_3.x)
		var_3_3.y = var_3_3.y + (math.max(1, var_3_0) - 1) * (var_3_3.y - var_3_2.y)

		self.m_tipEffectNode:setPosition(var_3_3)

		local var_3_4 = self.m_touchSpineNode:getPosition()

		var_3_4.x = var_3_4.x - (math.max(1, var_3_0) - 1) * (var_3_2.x - var_3_4.x)
		var_3_4.y = var_3_4.y + (math.max(1, var_3_0) - 1) * (var_3_4.y - var_3_2.y)

		self.m_touchSpineNode:setPosition(var_3_4)
	end
end

function ArtifactTouchSpineComp:setCallBack(arg_4_1)
	self._call = arg_4_1
end

function ArtifactTouchSpineComp:playShow(arg_5_1)
	self:_clearComp()
	self:setVisible(true)
	var_0_1:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MENU_WUZHUANG)

	self._highQuality = arg_5_1.quality

	if self._landSpine == nil then
		local var_5_0 = "recruit_artifact_draw_r"

		if arg_5_1.quality == 2 then
			var_5_0 = "recruit_artifact_draw_sr"
		elseif arg_5_1.quality == 3 then
			var_5_0 = "recruit_artifact_draw_ssr"
		elseif arg_5_1.quality == 4 then
			var_5_0 = "recruit_artifact_draw_ur"
		elseif arg_5_1.quality == 5 then
			var_5_0 = "recruit_artifact_draw_mr"
		end

		self.m_touchSpineNode:setVisible(true)

		self._landSpine = self.m_spineNode:addEffectSpine({
			anim = "play",
			remove = false,
			isLoop = false,
			name = var_5_0
		})

		self.m_touchSpineNode:setTouchable(true)

		self._landDuration = self._landSpine:getAnimationDuration()

		self:setCurEffectProgress(0)
	end

	self:_startTipEffectTimer(0)
end

function ArtifactTouchSpineComp:_onTouchBegin(arg_6_1)
	if self._landSpine == nil or self._isAutoMoving or self._isTouched then
		return
	end

	self.m_tipEffectNode:setVisible(false)

	self._tipEffectEnable = false

	local var_6_0 = var_0_0.Sound.UI_RCARD_IDLE

	if self._highQuality == 2 then
		var_6_0 = var_0_0.Sound.UI_SRCARD_IDLE
	elseif self._highQuality == 3 then
		var_6_0 = var_0_0.Sound.UI_SSRCARD_IDLE
	elseif self._highQuality == 4 then
		var_6_0 = var_0_0.Sound.UI_SSRCARD_IDLE
	end

	var_0_1:playSound(var_6_0)
	var_0_1:setRTPCValue("Sys_Chouka", 0)

	self._isTouched = true
	self._movePos = 0
	self._touchPos = arg_6_1:getInput():getTouch():getLocation()

	arg_6_1:captureTouch()
end

function ArtifactTouchSpineComp:_onTouchMove(arg_7_1)
	if self._landSpine == nil or not self._isTouched then
		return
	end

	local var_7_0 = arg_7_1:getInput():getTouch()

	if not self._isScroll then
		if math.abs(self._touchPos.y - var_7_0:getLocation().y) >= var_0_7 then
			self._isScroll = true
		else
			return
		end
	end

	self._movePos = math.max(self._touchPos.y - var_7_0:getLocation().y, 0)

	local var_7_1 = math.clamp(self._movePos / var_0_3, 0, 1)

	self._curProgress = var_7_1

	if var_0_5 / var_0_4 <= self._curProgress then
		self._isRestMove = false
		self._isTouched = false

		self:checkEffect()
	else
		var_0_1:setRTPCValue("Sys_Chouka", var_0_2 * var_7_1)
		self:setCurEffectProgress(var_7_1)
	end
end

function ArtifactTouchSpineComp:_onTouchEnd(arg_8_1)
	if self._isTouched then
		self._isTouched = false
		self._isScroll = false

		self:checkEffect()
		self:_startTipEffectTimer()
	end
end

function ArtifactTouchSpineComp:setCurEffectProgress(arg_9_1)
	self._landSpine:play(self._landDuration * arg_9_1, self._landDuration * arg_9_1)
end

function ArtifactTouchSpineComp:checkEffect()
	self.m_touchSpineNode:setVisible(false)

	if var_0_5 / var_0_4 <= self._curProgress then
		local var_10_0 = var_0_0.Sound.UI_RCARD_PLAY

		if self._highQuality == 2 then
			var_10_0 = var_0_0.Sound.UI_SRCARD_PLAY
		elseif self._highQuality == 3 then
			var_10_0 = var_0_0.Sound.UI_SSRCARD_PLAY
		elseif self._highQuality == 4 then
			var_10_0 = var_0_0.Sound.UI_SSRCARD_PLAY
		end

		var_0_1:playSound(var_10_0)

		self._isRestMove = false
		self._tipEffectEnable = false

		self.m_tipEffectNode:setVisible(false)
	else
		self._isRestMove = true

		self:_startTipEffectTimer()
	end

	if self._autoMovingSchedule == nil and self._curProgress > 0 then
		self._autoMovingSchedule = self:newSchedule(handler(self, self._move), 0.01)
		self._isAutoMoving = true
	else
		self:_stopAutoMove()
	end
end

function ArtifactTouchSpineComp:_move(arg_11_1, arg_11_2)
	if self._isRestMove then
		if (self._curProgress * self._landDuration - arg_11_2 * 10) / self._landDuration <= 0 then
			self._curProgress = 0

			self:setCurEffectProgress(0)
			self:_stopAutoMove()
		else
			self._curProgress = (self._curProgress * self._landDuration - arg_11_2 * 10) / self._landDuration

			var_0_1:setRTPCValue("Sys_Chouka", var_0_2 * ((self._curProgress * self._landDuration - arg_11_2 * 10) / self._landDuration))
			self:setCurEffectProgress((self._curProgress * self._landDuration - arg_11_2 * 10) / self._landDuration)
		end
	else
		local var_11_0 = (self._curProgress * self._landDuration + arg_11_2 * 2) / self._landDuration

		if (self._curProgress * self._landDuration + arg_11_2 * 2) / self._landDuration >= 1 then
			self._curProgress = 1

			self:setCurEffectProgress(1)
			self:_stopAutoMove()
		else
			self._curProgress = var_11_0

			self:setCurEffectProgress(var_11_0)
		end
	end
end

function ArtifactTouchSpineComp:_stopAutoMove()
	if self._autoMovingSchedule then
		self:cancelSchedule(self._autoMovingSchedule)

		self._autoMovingSchedule = nil
		self._isAutoMoving = false
		self._movePos = 0
	end

	if self._isRestMove then
		var_0_1:playSound(var_0_0.Sound.UI_CARD_IDLE_STOP)
		self.m_touchSpineNode:setVisible(true)
	else
		self.m_touchSpineNode:setVisible(false)
		self._landSpine:setAnimation(0, "idle", true)

		if self._endScheduler == nil then
			self._endScheduler = self:newScheduleOnce(handler(self, self._onCall), var_0_6 / 30)
		end
	end
end

function ArtifactTouchSpineComp:_onCall()
	if self._call ~= nil then
		self._call()
	end
end

function ArtifactTouchSpineComp:_clearEffect()
	if self._landSpine ~= nil then
		self._landSpine:dispose()

		self._landSpine = nil
	end
end

function ArtifactTouchSpineComp:playHide()
	if self._autoMovingSchedule then
		self:cancelSchedule(self._autoMovingSchedule)

		self._autoMovingSchedule = nil
		self._isAutoMoving = false
	end

	if self._endScheduler ~= nil then
		self:cancelSchedule(self._endScheduler)

		self._endScheduler = nil
	end

	self:setVisible(false)
end

function ArtifactTouchSpineComp:onLoad()
	self:_clearEffect()
	self:setVisible(false)
end

function ArtifactTouchSpineComp:onUnload()
	self:_clearComp()
	var_0_1:playSound(var_0_0.Sound.UI_CARD_IDLE_STOP)
	var_0_1:setMusicVolume(g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_VOLUME))
end

function ArtifactTouchSpineComp:_clearComp()
	self._tipEffectEnable = false

	if self._autoMovingSchedule then
		self:cancelSchedule(self._autoMovingSchedule)

		self._autoMovingSchedule = nil
		self._isAutoMoving = false
	end

	if self._endScheduler ~= nil then
		self:cancelSchedule(self._endScheduler)

		self._endScheduler = nil
	end

	self:_clearEffect()
end

function ArtifactTouchSpineComp:_startTipEffectTimer(arg_19_1)
	arg_19_1 = arg_19_1 or 3

	if self._tipEffectTimer then
		self:cancelSchedule(self._tipEffectTimer)

		self._tipEffectTimer = nil
	end

	self._tipEffectTimer = self:newScheduleOnce(handler(self, self._setTipEffect), arg_19_1)
	self._tipEffectEnable = true
end

function ArtifactTouchSpineComp:_setTipEffect()
	self.m_enterTransition:play()
	self.m_tipEffectNode:setVisible(self._tipEffectEnable)

	self._tipEffectTimer = nil
end

return ArtifactTouchSpineComp
