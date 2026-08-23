local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseSpinnerNormalAwardComp = class("ReleaseSpinnerNormalAwardComp", require("app.fairyGUI.release.UI_ReleaseSpinnerNormalAwardComp"))

function ReleaseSpinnerNormalAwardComp:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function ReleaseSpinnerNormalAwardComp:updateAward(arg_2_1)
	self._goods = g.core.common.Goods:convert({
		type = arg_2_1.type,
		value = arg_2_1.value
	})

	self.m_iconLoader:setIcon(self._goods.icon)
	self.m_qualityLoader:setURL("ui://release/pic_wxmy_ptjl" .. self._goods.quality + 1)
	self.m_numTxt:setText(g.core.lang:get(107073, {
		num = arg_2_1.size
	}))

	local var_2_0 = arg_2_1.num - var_0_0:getSpinnerPrizeCountById(arg_2_1.id)

	self.m_remainBg:setURL("ui://release/pic_wxmy_kcqsldi")
	self.m_remainNumTxt:setText(math.max(var_2_0, 0))
	self.m_isAwardController:setSelectedIndex(var_2_0 == 0 and 1 or 0)
end

function ReleaseSpinnerNormalAwardComp:playSmallEff(arg_3_1)
	self._curSpinnerId = var_0_0:getSpinnerId()
	self._spinnerInfo = g.core.config.activity_release_spinner_info.get(self._curSpinnerId)

	if arg_3_1 then
		self._awards = arg_3_1

		self:newScheduleOnce(handler(self, self._awardSummary), 1)
	end

	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_release_rewardsmall",
		isLoop = false,
		anim = "play_" .. self._spinnerInfo.quality
	})
	self.m_txteff:removeAllEffect()
	self.m_txteff:addEffectSpine({
		name = "eff_ui_release_txtrefresh",
		isLoop = false,
		anim = "play_" .. self._spinnerInfo.quality
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Gear_GetSmall)
end

function ReleaseSpinnerNormalAwardComp:_awardSummary()
	if self._awards then
		g.core.module.ModuleManager:awardSummary(self._awards, true, nil, nil, handler(self, self._scheduleOnceCall))

		self._awards = nil
	end
end

function ReleaseSpinnerNormalAwardComp:_scheduleOnceCall()
	self:newScheduleOnce(function()
		self:dispatchCompEvent("HIDE_SPINNER_NEEDLE")
	end)
end

function ReleaseSpinnerNormalAwardComp:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return ReleaseSpinnerNormalAwardComp
