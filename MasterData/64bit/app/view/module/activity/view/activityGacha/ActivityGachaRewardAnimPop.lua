local ActivityGachaRewardAnimPop = class("ActivityGachaRewardAnimPop", require("app.fairyGUI.activity.UI_ActivityGachaRewardAnimPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityGachaRewardAnimPop",
		pkgName = "activity",
		isFullScreen = true,
		pkgPath = "ui/activity/activity"
	})
end)

function ActivityGachaRewardAnimPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._callFunc = arg_2_2
	self._content = arg_2_1

	self:addClickListener(handler(self, self.onCloseAnim))
	self:setTouchable(false)
end

function ActivityGachaRewardAnimPop:onLoad()
	self:playAnim()
	self:newScheduleOnce(function()
		self:setTouchable(true)
	end, 1)
end

function ActivityGachaRewardAnimPop:onCloseAnim()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._callFunc then
		self._callFunc(self._content)
	end
end

function ActivityGachaRewardAnimPop:playAnim()
	local var_6_0 = g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP.R

	for iter_6_0, iter_6_1 in ipairs(self._content.reward_ids) do
		local var_6_1 = g.core.config.month_gacha_reward.get(iter_6_1.id)

		if var_6_0 > var_6_1.type then
			var_6_0 = var_6_1.type
		end
	end

	local var_6_2 = {
		[g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP.SSR] = {
			animName = "eff_ui_activityGacha_S",
			anim = "S"
		},
		[g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP.SR] = {
			animName = "eff_ui_activityGacha_A",
			anim = "A"
		},
		[g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP.R] = {
			animName = "eff_ui_activityGacha_B",
			anim = "B"
		}
	}

	if var_6_0 == g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP.SSR then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ScratchChouka)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_TicketAward)
	end

	self.m_effHolder:addEffectSpine({
		name = "liujinshang_silver",
		isLoop = false,
		anim = var_6_2[var_6_0].anim
	})
	self.m_effHolder:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = var_6_2[var_6_0].animName
	})
end

function ActivityGachaRewardAnimPop:onUnload()
	self:cancelAllSchedule()
end

return ActivityGachaRewardAnimPop
