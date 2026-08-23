local RecruitUniteTokenStoneComp = class("RecruitUniteTokenStoneComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenStoneComp"))

function RecruitUniteTokenStoneComp:ctor()
	self._isOpened = false
	self._schedulerEffId = nil
end

function RecruitUniteTokenStoneComp:setEffTag(arg_2_1)
	self.m_stoneController:setSelectedIndex(arg_2_1 - 1)

	self._effTag = arg_2_1
end

function RecruitUniteTokenStoneComp:setOpened(arg_3_1)
	self._quality = g.core.common.Goods:convert({
		type = arg_3_1.type,
		value = arg_3_1.value,
		size = arg_3_1.size
	}).quality

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_TOUCH)
	self:playPreEff()

	self._isOpened = true
end

function RecruitUniteTokenStoneComp:playPreEff()
	self.m_downEffHolder:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_stone_" .. self._effTag,
		anim = "click_down_" .. self._quality + 1
	})
	self.m_upEffHolder:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_stone_" .. self._effTag,
		anim = "click_up_" .. self._quality + 1
	})

	self._schedulerEffId = self:newScheduleOnce(function()
		self._schedulerEffId = nil

		self:playOpenEff()
	end, 0.3)
end

function RecruitUniteTokenStoneComp:playOpenEff()
	self.m_upEffHolder:addEffectSpine({
		isLoop = false,
		name = "eff_ui_stone_" .. self._effTag,
		anim = "scrack_" .. self._quality + 1,
		eventHandler = handler(self, self._onAnimFinish)
	})

	self._schedulerFadeInId = self:newScheduleOnce(function()
		self._schedulerFadeInId = nil

		self:onIdleEffPlay()
	end, 0.8)
end

function RecruitUniteTokenStoneComp:onIdleEffPlay()
	local var_8_0 = self.m_upEffHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_stone_" .. self._effTag,
		anim = "scrackIdle_" .. self._quality + 1
	})

	var_8_0:setOpacity(0)
	var_8_0:runAction(cc.Sequence:create({
		cc.FadeIn:create(0.5)
	}))
end

function RecruitUniteTokenStoneComp:_onAnimFinish()
	self:dispatchCompEvent("OPEN_STONE_FINISH")
end

function RecruitUniteTokenStoneComp:playBreak()
	self.m_downEffHolder:addEffectSpine({
		anim = "common_Open_Down",
		isLoop = false,
		name = "eff_ui_stone_" .. self._effTag
	})
	self.m_upEffHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_stone_" .. self._effTag,
		anim = "idle_" .. self._quality + 1
	})
	self.m_upEffHolder:addEffectSpine({
		anim = "common_Open_Up",
		isLoop = false,
		name = "eff_ui_stone_" .. self._effTag
	})
end

function RecruitUniteTokenStoneComp:isOpened()
	return self._isOpened
end

function RecruitUniteTokenStoneComp:getQuality()
	return self._quality
end

function RecruitUniteTokenStoneComp:onUnload()
	if self._schedulerEffId then
		self:cancelSchedule(self._schedulerEffId)
	end

	if self._schedulerFadeInId then
		self:cancelSchedule(self._schedulerFadeInId)
	end
end

return RecruitUniteTokenStoneComp
