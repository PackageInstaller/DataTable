local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.config.activity_theme_display_info
local ThemeTurnCardInfoComp = class("ThemeTurnCardInfoComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardInfoComp"))

function ThemeTurnCardInfoComp:ctor()
	self.m_rankBtn:addClickListener(handler(self, self._onClickTurnCardRankBtn))
	self.m_startGameBtn:addClickListener(handler(self, self._onClickStartGameBtn))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self:checkSpeWeakGuide()
end

function ThemeTurnCardInfoComp:updateInfoView(arg_2_1)
	self._turnCardData = var_0_0:getThemeData(arg_2_1):getTurnCardData()
	self._phaseId = self._turnCardData:getCurTurnCardPhase()
	self._phaseInfo = self._turnCardData:getPhaseCardInfo(self._phaseId)
	self._displayInfo = var_0_2.get(arg_2_1)

	self.m_titleName:setText(self._displayInfo.minigame_name)
	self.m_phaseComp:setTitle(g.core.lang:get(405801) .. g.core.lang:get(100 + self._phaseInfo.rank_idx))
	self.m_phaseComp:setDescText(self._phaseInfo.phase_name)
	self:updateSurplusTimeText()

	if self._phaseInfo.game_mode == var_0_1.TURN_CARD_MODEL.ENDLESS then
		self.m_waveComp:setDescText(g.core.lang:get(405810))
	else
		self.m_waveComp:setDescText((self._turnCardData:getWaveCountByPhase(self._phaseId)))
	end

	self.m_baseTimeComp:setDescText(g.core.lang:get(405802, {
		time = self._phaseInfo.base_time
	}))

	self._awards = g.core.common.Drops:getGoodsArray(self._phaseInfo.game_award)

	self.m_awardList:setNumItems(#self._awards)
end

function ThemeTurnCardInfoComp:updateSurplusTimeText()
	self.m_surplusTimeComp:setDescText(g.core.common.ServerTime:getLeftDHFormat(self._turnCardData:getCurPhaseNeedDays() * 86400 + g.core.common.ServerTime:getLeftSeconds((self._turnCardData:getTurnCardStartTime())) + g.core.common.ServerTime:getTime()))
end

function ThemeTurnCardInfoComp:checkSpeWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "GUILD_THEME_TURN_CARD_START",
		targetBtn = self.m_startGameBtn
	})
end

function ThemeTurnCardInfoComp:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIconData(self._awards[arg_5_1 + 1], (self._turnCardData:isGetTurnCardAwards()))
end

function ThemeTurnCardInfoComp:_onClickTurnCardRankBtn()
	self:dispatchCompEvent("ON_CLICK_RANK_BUTTON")
end

function ThemeTurnCardInfoComp:_onClickStartGameBtn()
	self:dispatchCompEvent("START_TURN_CARD_GAME")
end

function ThemeTurnCardInfoComp:playBackTransition()
	self.m_backTransition:play()
end

return ThemeTurnCardInfoComp
