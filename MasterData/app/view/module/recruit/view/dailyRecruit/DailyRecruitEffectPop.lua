local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.common.Goods
local DailyRecruitEffectPop = class("DailyRecruitEffectPop", require("app.fairyGUI.recruitDaily.UI_DailyRecruitEffectPop"), function()
	return fgui.GComponent:create({
		resName = "DailyRecruitEffectPop",
		pkgPath = "ui/recruitDaily/recruitDaily",
		pkgName = "recruitDaily"
	})
end)

function DailyRecruitEffectPop:ctor(arg_2_1)
	self._highQuality = var_0_0.R
	self._awards = arg_2_1
	self._crystalEffect = nil
	self._screenEffect = nil
	self._isCanClick = false

	self:initView(arg_2_1)
	self:startPlay()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_MenuTurnOn_03)
end

function DailyRecruitEffectPop:initView(arg_3_1)
	self:showAtCenter()

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_0 = var_0_1:convert(arg_3_1[iter_3_0])

		if var_3_0.type == var_0_1.TYPE_KNIGHT or var_3_0.type == var_0_1.TYPE_UNITETOKEN or var_3_0.type == var_0_1.TYPE_ARTIFACT or var_3_0.type == var_0_1.TYPE_PET then
			self._highQuality = math.max(self._highQuality, var_3_0.quality)
		end
	end

	self.m_touchIcon:addClickListener(handler(self, self._onClickIcon))
end

function DailyRecruitEffectPop:startPlay()
	self.m_enterTransition:play()

	self._crystalEffect = self.m_effectEnterCrystal:addEffectSpine({
		anim = "play",
		name = "eff_ui_dailyRecruit_ipadEnterCrystal",
		isLoop = false,
		remove = false,
		eventHandler = handler(self, self._effectEvent)
	})
	self._screenEffect = self.m_effectEnterScreen:addEffectSpine({
		anim = "play",
		name = "eff_ui_dailyRecruit_ipadEnterScreen",
		remove = false,
		isLoop = false
	})
end

function DailyRecruitEffectPop:_effectEvent(arg_5_1, arg_5_2)
	if arg_5_1.type == "event" then
		if (arg_5_1.eventData or {}).name == "stop" then
			self:playIdleEffect()
		end
	end
end

function DailyRecruitEffectPop:playIdleEffect()
	self._isCanClick = true

	self.m_effectIdle:setAlpha(1)
	self.m_effectIdle:addEffectSpine({
		anim = "play",
		name = "eff_ui_dailyRecruit_ipadIdle",
		remove = false,
		isLoop = true
	})
end

function DailyRecruitEffectPop:_onClickIcon()
	if not self._isCanClick then
		return
	end

	self.m_touchIcon:setTouchable(false)
	self.m_effectIdle:removeAllEffect()
	self.m_effectShow:setAlpha(1)
	self.m_effectShow:addEffectSpine({
		name = "eff_ui_dailyRecruit_ipadShow",
		isLoop = false,
		remove = true,
		anim = "play_" .. tostring(self._highQuality + 1),
		eventHandler = handler(self, self.showEffectEvent)
	})

	if self._highQuality == var_0_0.SSR then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ResultDisplay_01)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ResultDisplay_02)
	end
end

function DailyRecruitEffectPop:showEffectEvent(arg_8_1)
	if arg_8_1.type == "complete" then
		self:showEffectEnd()
	end
end

function DailyRecruitEffectPop:showEffectEnd()
	if self._backing then
		return
	end

	self._backing = true

	self.m_backTransition:play(handler(self, self.onBackTranEnd))
end

function DailyRecruitEffectPop:onBackTranEnd()
	self:dispatchCompEvent("DailyRecruit_EffectPop_End", {
		awards = self._awards
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function DailyRecruitEffectPop:onLoad()
	self.m_qualityController:setSelectedIndex(self._highQuality)
end

return DailyRecruitEffectPop
