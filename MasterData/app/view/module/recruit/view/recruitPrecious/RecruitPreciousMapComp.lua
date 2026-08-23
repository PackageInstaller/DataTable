local RecruitPreciousMapComp = class("RecruitPreciousMapComp", require("app.fairyGUI.recruit.UI_RecruitPreciousMapComp"))

function RecruitPreciousMapComp:ctor()
	self.m_icon:setURL("bg/recruit/bg_zm_gzwp.png")

	self._awardList = {}
	self._lightCnt = 0

	self:_addListeners()
	self:_addTranslationHook()
	self:_fixSize()
end

function RecruitPreciousMapComp:_fixSize()
	local var_2_0 = self.m_icon:getContentSize()

	self.m_icon:setSize(var_2_0.width, var_2_0.height)
end

function RecruitPreciousMapComp:_addListeners()
	self:addClickListener(handler(self, self._onClickSelf))
end

function RecruitPreciousMapComp:_addTranslationHook()
	for iter_4_0 = 1, 10 do
		self.m_enterTransition:setHook("play" .. iter_4_0, handler(self, function(arg_5_0)
			arg_5_0:_showLightByPos(iter_4_0)
			arg_5_0:_showLoopLightByPos(iter_4_0)
		end))
	end
end

function RecruitPreciousMapComp:setCallBack(arg_6_1)
	self._call = arg_6_1
end

function RecruitPreciousMapComp:playShow(arg_7_1)
	self._awardList = arg_7_1.awards
	self._lightCnt = 0

	local var_7_0 = g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CHOUKA_GZ_ONE

	if #self._awardList > 1 then
		self.m_isTenController:setSelectedIndex(1)

		var_7_0 = g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CHOUKA_GZ_TEN
	else
		self.m_isTenController:setSelectedIndex(0)
	end

	self.m_enterTransition:play()
	self:setVisible(true)
	g.core.sound.SoundManager:playSound(var_7_0)
end

function RecruitPreciousMapComp:_showLightByPos(arg_8_1)
	local var_8_0

	if arg_8_1 > #self._awardList then
		do return end

		var_8_0 = {
			name = "eff_ui_precious_mappoint",
			remove = true,
			isLoop = false
		}
	end

	var_8_0.anim = "play_" .. self._awardList[arg_8_1].quality + 1

	self["m_effectNode" .. arg_8_1]:addEffectSpine(var_8_0)
end

function RecruitPreciousMapComp:_showLoopLightByPos(arg_9_1)
	local var_9_0

	if arg_9_1 > #self._awardList then
		do return end

		var_9_0 = {
			name = "eff_ui_precious_mappoint",
			remove = false,
			isLoop = true
		}
	end

	var_9_0.anim = "loop_" .. self._awardList[arg_9_1].quality + 1

	self["m_effLoop" .. arg_9_1]:addEffectSpine(var_9_0)
	self:newScheduleOnce(handler(self, self._onOneLightShowOver), 1)
end

function RecruitPreciousMapComp:_onOneLightShowOver()
	self._lightCnt = self._lightCnt + 1

	if self._lightCnt >= #self._awardList then
		self:_onAllLightShowOver()
	end
end

function RecruitPreciousMapComp:_onAllLightShowOver()
	self.m_clickEnableController:setSelectedIndex(1)
end

function RecruitPreciousMapComp:_onCall()
	self:_clearEffect()
	self.m_clickEnableController:setSelectedIndex(0)
	self:setVisible(false)

	if self._call ~= nil then
		self._call()
	end
end

function RecruitPreciousMapComp:playHide()
	self.m_clickEnableController:setSelectedIndex(0)
	self.m_backTransition:play(handler(self, self._onCall))
end

function RecruitPreciousMapComp:_clearEffect()
	for iter_14_0 = 1, 10 do
		self["m_effectNode" .. iter_14_0]:removeAllEffect()
		self["m_effLoop" .. iter_14_0]:removeAllEffect()
	end
end

function RecruitPreciousMapComp:onLoad()
	self:setVisible(false)
end

function RecruitPreciousMapComp:onUnload()
	self:_clearEffect()
end

function RecruitPreciousMapComp:_onClickSelf()
	if self.m_clickEnableController:getSelectedIndex() ~= 0 then
		self:playHide()
	end
end

return RecruitPreciousMapComp
