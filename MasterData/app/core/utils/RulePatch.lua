return {
	doPatch = function()
		g.core.utils.Rule.setRuleLevel(3)

		require("app.view.module.login.view.PvPlayLayer").ctor = function(self, arg_2_1)
			self._pvName = arg_2_1.pvName or ""
			self._zimuName = arg_2_1.zimuName or ""
			self._bgSoundName = arg_2_1.bgPVSound
			self._saveLocalName = arg_2_1.localName or ""
			self._hideTime = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.PV_HIDE_JUMP_BTN_TIME).parameter

			self.m_skipBtn:setVisible(false)
			self.m_skipBtn:addClickListener(handler(self, self._onSkipClicked))
			self.m_touchComp:addClickListener(handler(self, self._onPvLayerClick))

			if string.len(self._pvName) > 0 and not g.core.utils.Rule.isHideLoginPv() then
				self:playVideo()
				self:playZimuVideo()
			end

			if string.len(self._saveLocalName) > 0 then
				g.core.common.Storage:save(self._saveLocalName .. ".json", {
					played = true
				}, false)
			end

			self:newScheduleOnce(handler(self, self._onSkipClicked), 0.5)
		end

		local ChannelConst = require("app.core.platform.const.ChannelConst")
		local var_1_1 = g.core.platform.PlatformProxy:getCurChannel()

		if var_1_1.name == ChannelConst.ChannelNames.HUAWEI or var_1_1.name == ChannelConst.ChannelNames.RONGYAO then
			g.core.sound.SoundManager:stop()
		end
	end,
	doOnlineRulePatch = function()
		return
	end
}
