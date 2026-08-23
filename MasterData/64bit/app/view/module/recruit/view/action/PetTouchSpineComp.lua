local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.sound.SoundManager
local var_0_2 = 0.03333333333333333
local var_0_3 = 10
local var_0_4 = 25 * 0.03333333333333333
local var_0_5 = 10
local var_0_6 = 1
local PetTouchSpineComp = class("PetTouchSpineComp", require("app.fairyGUI.recruit.UI_PetTouchSpineComp"))

function PetTouchSpineComp:ctor()
	self._spine = nil
	self._touchPos = nil
	self._touchBeginPos = nil
	self._touchEnable = false
	self._spineName = nil
	self._animName = nil
	self._curFrame = 0
	self._highQuality = 1
	self._idleLeftCount = var_0_6

	self:_addListeners()
	self.m_tipEffectNode:addEffectSpine({
		name = "eff_ui_petRecruit_end",
		isLoop = true,
		remove = false
	})

	local var_1_0 = 1

	if display.width / 1334 > 1 or display.height / 750 > 1 then
		var_1_0 = math.max(display.width / 1334, display.height / 750)

		local var_1_1 = self.m_spineNode:getPosition()
		local var_1_2 = self.m_tipEffectNode:getPosition()

		var_1_2.x = var_1_2.x - (math.max(1, var_1_0) - 1) * (var_1_1.x - var_1_2.x)
		var_1_2.y = var_1_2.y + (math.max(1, var_1_0) - 1) * (var_1_2.y - var_1_1.y)

		self.m_tipEffectNode:setPosition(var_1_2)
	end

	self.m_tipEffectNode:setScale(var_1_0)
	self.m_spineNode:setScale(0.8 * var_1_0)
end

function PetTouchSpineComp:_addListeners()
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_touchSpineNode:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function PetTouchSpineComp:setCallBack(arg_3_1)
	self._call = arg_3_1
end

function PetTouchSpineComp:playShow(arg_4_1)
	self._curFrame = 0
	self._idleLeftCount = 1

	var_0_1:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_PET_LOTTERY_START)

	self._highQuality = arg_4_1.quality

	local var_4_0 = "recruit_pet_draw_r"

	if arg_4_1.quality == 2 then
		var_4_0 = "recruit_pet_draw_sr"
	elseif arg_4_1.quality == 3 then
		var_4_0 = "recruit_pet_draw_ssr"
	elseif arg_4_1.quality == 4 then
		var_4_0 = "recruit_pet_draw_ur"
	elseif arg_4_1.quality == 5 then
		var_4_0 = "recruit_pet_draw_mr"
	end

	self:_updateSpine(var_4_0, "start", false)
	self:setVisible(true)
end

function PetTouchSpineComp:_onTouchBegin(arg_5_1)
	if not self._touchEnable then
		return
	end

	self.m_tipEffectNode:setVisible(false)

	local var_5_0 = arg_5_1:getInput():getTouch():getLocation()

	self._touchBeginPos = var_5_0
	self._touchPos = cc.p(var_5_0.x, var_5_0.y)

	arg_5_1:captureTouch()
	var_0_1:playSound(var_0_0.Sound.UI_EVENT_PET_LOTTERY_TOUCH)
end

function PetTouchSpineComp:_onTouchMove(arg_6_1)
	if not self._touchEnable then
		return
	end

	local var_6_0 = arg_6_1:getInput():getTouch()
	local var_6_1 = var_6_0:getLocation()

	if math.abs(var_6_0) >= 1 then
		self:_setSpineFrame(self._curFrame + math.floor(-(var_6_1.y - self._touchPos.y) / var_0_3))

		self._touchPos = var_6_1
	end
end

function PetTouchSpineComp:_onTouchEnd(arg_7_1)
	if self._touchEnable then
		self:_autoPlayBackWards()
	end
end

function PetTouchSpineComp:_onCall()
	if self._call ~= nil then
		self._call()
	end

	self._touchEnable = false

	self.m_touchSpineNode:setTouchable(false)
end

function PetTouchSpineComp:playHide()
	self._touchEnable = false

	self.m_touchSpineNode:setTouchable(false)
	self:_removePlayBackWardsTimer()
	self:setVisible(false)
	self.m_tipEffectNode:setVisible(false)

	if self._spine then
		self._spine:stop()
	end
end

function PetTouchSpineComp:onLoad()
	self:setVisible(false)
end

function PetTouchSpineComp:onUnload()
	var_0_1:playSound(var_0_0.Sound.UI_EVENT_PET_IDLE_STOP)
	var_0_1:setMusicVolume(g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_VOLUME))
	self:_clearSpine()
end

function PetTouchSpineComp:_clearSpine()
	if self._spine then
		self._spine:stop()
		self._spine:dispose()
	end

	self._spine = nil
	self._spineName = nil
end

function PetTouchSpineComp:_updateSpine(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 == self._spineName then
		self:_setAnimation(arg_13_2, arg_13_3)
		self._spine:restart()

		return
	end

	self:_clearSpine()

	self._animName = arg_13_2
	self._spineName = arg_13_1
	self._spine = self.m_spineNode:addEffectSpine({
		remove = false,
		name = arg_13_1,
		isLoop = arg_13_3 == true,
		anim = arg_13_2,
		eventHandler = handler(self, self._onSpineEventHandle)
	})
end

function PetTouchSpineComp:_onSpineEventHandle(arg_14_1, arg_14_2)
	local BattleConst = require("app.view.battle.const.BattleConst")

	if arg_14_1.type == "event" then
		local var_14_1 = arg_14_1.eventData or {}

		if self._animName ~= "play" or var_14_1.name == "open" then
			-- block empty
		elseif BattleConst.SPINE_EVENT.COMPLETE == var_14_1.name then
			self:_setSpineFrame(0, 0)
		end
	end

	if BattleConst.SPINE_EVENT.COMPLETE == arg_14_1.type and self._animName then
		if self._animName == "start" then
			self:_setAnimation("play", false)

			self._touchEnable = true

			self.m_touchSpineNode:setTouchable(self._touchEnable)
			self:_startTipEffectTimer(0)
		elseif self._animName == "play" then
			if self._curFrame >= var_0_5 then
				self:_autoPlay()
			elseif self._curFrame == var_0_4 then
				self:_setAnimation("idle", true)

				local var_14_2 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_IDLE_R

				if self._highQuality == 2 then
					var_14_2 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_IDLE_SR
				elseif self._highQuality == 3 then
					var_14_2 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_IDLE_SSR
				end

				var_0_1:playSound(var_14_2)
			end
		elseif self._animName == "idle" then
			if self._idleLeftCount == 0 then
				self:_onCall()
			else
				self._idleLeftCount = self._idleLeftCount - 1
			end
		end
	end
end

function PetTouchSpineComp:_setAnimation(arg_15_1, arg_15_2, arg_15_3)
	self._animName = arg_15_1
	arg_15_3 = arg_15_3 or 0

	self._spine:setAnimation(arg_15_3, self._animName, arg_15_2)
end

function PetTouchSpineComp:_setSpineFrame(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or arg_16_1
	arg_16_2 = math.max(0, arg_16_2)

	self._spine:play(arg_16_1 * var_0_2, arg_16_2 * var_0_2)

	self._curFrame = math.min(var_0_4, arg_16_2)
	self._curFrame = math.max(0, arg_16_2)
end

function PetTouchSpineComp:_autoPlayBackWards()
	self._touchEnable = false

	self.m_touchSpineNode:setTouchable(false)
	self:_startPlayBackWardsTimer()
end

function PetTouchSpineComp:_startPlayBackWardsTimer()
	self:newSchedule(handler(self, self._playBackWards), var_0_2)
end

function PetTouchSpineComp:_playBackWards()
	if self._curFrame == 0 then
		self._touchEnable = true

		self.m_touchSpineNode:setTouchable(true)
		self:_removePlayBackWardsTimer()
		self:_startTipEffectTimer()

		return
	end

	self:_setSpineFrame(self._curFrame - 1)
end

function PetTouchSpineComp:_removePlayBackWardsTimer()
	self:cancelAllSchedule()
end

function PetTouchSpineComp:_autoPlay()
	self:_removePlayBackWardsTimer()
	self._spine:play(self._curFrame, var_0_4)

	self._curFrame = var_0_4
	self._touchEnable = false

	self.m_touchSpineNode:setTouchable(false)

	local var_21_0 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_PLAY_R

	if self._highQuality == 2 then
		var_21_0 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_PLAY_SR
	elseif self._highQuality == 3 then
		var_21_0 = var_0_0.Sound.UI_EVENT_PET_LOTTERY_PLAY_SSR
	end

	var_0_1:playSound(var_21_0)
end

function PetTouchSpineComp:_startTipEffectTimer(arg_22_1)
	arg_22_1 = arg_22_1 or 3

	if self._tipEffectTimer then
		self:cancelSchedule(self._tipEffectTimer)

		self._tipEffectTimer = nil
	end

	self._tipEffectTimer = self:newScheduleOnce(handler(self, self._setTipEffect), arg_22_1)
	self._tipEffectEnable = true
end

function PetTouchSpineComp:_setTipEffect()
	self.m_enterTransition:play()
	self.m_tipEffectNode:setVisible(self._tipEffectEnable)

	self._tipEffectTimer = nil
end

return PetTouchSpineComp
