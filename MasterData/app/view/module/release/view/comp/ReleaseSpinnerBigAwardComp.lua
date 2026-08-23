local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseSpinnerBigAwardComp = class("ReleaseSpinnerBigAwardComp", require("app.fairyGUI.release.UI_ReleaseSpinnerBigAwardComp"))

function ReleaseSpinnerBigAwardComp:ctor()
	self.m_fragImg:setVisible(false)
	self:addClickListener(handler(self, self._onClick))
end

function ReleaseSpinnerBigAwardComp:updateAward(arg_2_1)
	self._goods = g.core.common.Goods:convert({
		type = arg_2_1.type,
		value = arg_2_1.value
	})

	if self._goods then
		self.m_iconLoader:setIcon(self._goods.icon)
		self.m_numTxt:setText(g.core.lang:get(107073, {
			num = arg_2_1.size
		}))
		self.m_qualityLoader:setURL("ui://release/pic_wxmy_dajiang" .. self._goods.quality + 1)
		self.m_fragImg:setVisible(arg_2_1.type == g.core.common.Goods.TYPE_FRAGMENT)
	end

	self.m_isAwardController:setSelectedIndex(var_0_0:isGetSpinnerBigAward(arg_2_1.group) and 1 or 0)
end

function ReleaseSpinnerBigAwardComp:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

function ReleaseSpinnerBigAwardComp:playBigEff(arg_4_1)
	self._curSpinnerId = var_0_0:getSpinnerId()
	self._spinnerInfo = g.core.config.activity_release_spinner_info.get(self._curSpinnerId)

	if arg_4_1 then
		self._awards = arg_4_1

		self:newScheduleOnce(handler(self, self._awardSummary), 1.3)
	end

	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_release_rewardbig",
		isLoop = false,
		anim = "play_" .. self._spinnerInfo.quality
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Gear_GetBig)
end

function ReleaseSpinnerBigAwardComp:_awardSummary()
	if self._awards then
		g.core.module.ModuleManager:awardSummary(self._awards, true, nil, nil, handler(self, self._scheduleOnceCall))

		self._awards = nil
	end
end

function ReleaseSpinnerBigAwardComp:_scheduleOnceCall()
	self:newScheduleOnce(function()
		self:dispatchCompEvent("HIDE_SPINNER_NEEDLE")
	end)
end

return ReleaseSpinnerBigAwardComp
