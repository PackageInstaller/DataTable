local var_0_0 = g.core.config.activity_theme_display_info
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.common.Drops
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.model.User.themeData
local ThemeGuessInfoComp = class("ThemeGuessInfoComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessInfoComp"))

function ThemeGuessInfoComp:ctor()
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_startGameBtn:addClickListener(handler(self, self._onStartGameClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function ThemeGuessInfoComp:updateState(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._displayInfo = var_0_0.get(self._activeThemeValue)

	local var_2_0 = var_0_4:getThemeData(self._activeThemeValue):getThemeGuessData()

	self._themeGuessData = var_2_0

	self.m_titleTxt:setText(self._displayInfo.minigame_name)

	self._phase = var_2_0:getCurPhase()

	local var_2_1 = var_2_0:getPhaseGuessInfo(self._phase)

	self._awards = var_0_2:getGoodsArray(var_2_1.game_award)

	self.m_phaseComp:setTitle(g.core.lang:get(405801) .. g.core.lang:get(100 + self._phase))
	self.m_phaseComp:setDescText(var_2_1.phase_name)
	self.m_errorDecTimeComp:setDescText(g.core.lang:get(405802, {
		time = var_2_1.fault_time
	}))
	self.m_baseTimeComp:setDescText(g.core.lang:get(405802, {
		time = var_2_1.base_time
	}))
	self.m_awardList:setNumItems(#self._awards)
	self:_updateSurplusTimeText()
end

function ThemeGuessInfoComp:_updateSurplusTimeText()
	self.m_surplusTimeComp:setDescText(var_0_3:getLeftDHFormat((self._themeGuessData:getCurPhaseEndTime())))
end

function ThemeGuessInfoComp:_onStartGameClick()
	self:dispatchCompEvent("ON_GUESS_GAME_START_CLICK")
end

function ThemeGuessInfoComp:_onRankBtnClick()
	self:dispatchCompEvent("ON_GUESS__SHOW_RANK_CLICK")
end

function ThemeGuessInfoComp:_onAwardItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateIconData(self._awards[arg_6_1 + 1], (self._themeGuessData:hasGotAwards()))
end

return ThemeGuessInfoComp
