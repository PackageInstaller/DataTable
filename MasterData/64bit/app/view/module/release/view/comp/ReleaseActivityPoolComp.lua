local var_0_0 = g.core.model.User.releaseActivityData
local var_0_1 = g.core.const.ConstMgr.ReleaseActivityConst
local ReleaseActivityPoolComp = class("ReleaseActivityPoolComp", require("app.fairyGUI.release.UI_ReleaseActivityPoolComp"))

function ReleaseActivityPoolComp:ctor()
	self._curSpinnerId = 0
end

function ReleaseActivityPoolComp:updatePoolComp()
	local var_2_0 = var_0_0:getSpinnerId()

	self._spinnerInfo = g.core.config.activity_release_spinner_info.get(var_2_0)

	self.m_typeController:setSelectedIndex(self._spinnerInfo.quality - 1)

	local var_2_1 = var_0_0:getReleaseSpinnerPrizeByGroup(self._spinnerInfo.spinner_prize_group)

	for iter_2_0 = 1, #var_2_1 do
		if self["m_award" .. iter_2_0] and var_2_1[iter_2_0] then
			self["m_award" .. iter_2_0]:updateAward(var_2_1[iter_2_0])
		end
	end

	self.m_bgLoader:setURL("ui://release/pic_wxmy_spinner" .. self._spinnerInfo.quality)

	if self._curSpinnerId ~= var_2_0 then
		self.m_spinnerEff:removeAllEffect()
		self.m_spinnerEff:addEffectSpine({
			isLoop = true,
			name = var_0_1.SPINNER_QUALITY_EFF_NAME[self._spinnerInfo.quality]
		})

		self._curSpinnerId = var_2_0
	end

	self:_updateNeedleComp()
end

function ReleaseActivityPoolComp:_updateNeedleComp()
	for iter_3_0 = 1, var_0_1.NEEDLE_MAX_COUNT do
		self["m_needle" .. iter_3_0]:setIcon("ui://release/pic_wxmy_needle" .. self._spinnerInfo.quality)
	end

	self.m_arrowBg:setURL("ui://release/pic_wxmy_needleUp" .. self._spinnerInfo.quality)
end

function ReleaseActivityPoolComp:hideSpinnerNeedle()
	for iter_4_0 = 1, var_0_1.NEEDLE_MAX_COUNT do
		if iter_4_0 == 1 then
			self["m_needle" .. iter_4_0]:setRotation(var_0_1.NEEDLE_INIT_ANGLE[iter_4_0])
		end

		self["m_needle" .. iter_4_0]:setVisible(iter_4_0 == 1)
	end
end

function ReleaseActivityPoolComp:playRollEff()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_release_rollglow",
		anim = "play_" .. self._spinnerInfo.quality
	})
end

function ReleaseActivityPoolComp:playRewardEff(arg_6_1, arg_6_2)
	local var_6_0 = g.core.config.activity_release_spinner_prize_info.get(arg_6_1)

	if var_6_0.grand_prize ~= 1 then
		if self["m_award" .. var_6_0.effect] then
			self["m_award" .. var_6_0.effect]:playSmallEff(arg_6_2)
		end
	elseif self["m_award" .. var_6_0.effect] then
		self["m_award" .. var_6_0.effect]:playBigEff(arg_6_2)
	end
end

function ReleaseActivityPoolComp:getNeedleCompByIndex(arg_7_1)
	if self["m_needle" .. arg_7_1] then
		self["m_needle" .. arg_7_1]:setRotation(var_0_1.NEEDLE_INIT_ANGLE[arg_7_1])
		self["m_needle" .. arg_7_1]:setVisible(true)

		return self["m_needle" .. arg_7_1]
	end
end

function ReleaseActivityPoolComp:playArrowEff()
	self.m_arrowEff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_release_dotglow",
		remove = true,
		anim = "get_" .. self._spinnerInfo.quality
	})
end

return ReleaseActivityPoolComp
