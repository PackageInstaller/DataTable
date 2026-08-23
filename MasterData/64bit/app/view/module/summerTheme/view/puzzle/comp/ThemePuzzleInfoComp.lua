local ThemePuzzleInfoComp = class("ThemePuzzleInfoComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleInfoComp"))
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.config.activity_theme_display_info
local var_0_3 = g.core.common.Drops
local var_0_4 = g.core.common.ServerTime

function ThemePuzzleInfoComp:ctor()
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_startGameBtn:addClickListener(handler(self, self._onClickStartBtn))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function ThemePuzzleInfoComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = arg_2_1.themeValue or 0

	if var_2_0 == 0 then
		return
	end

	self.m_titleTxt:setText(var_0_2.get(var_2_0).minigame_name)

	local var_2_1 = var_0_1:getThemeData(var_2_0):getThemePuzzleData()

	self._themePuzzleData = var_2_1
	self._phase = var_2_1:getCurPhase()

	local var_2_2 = var_2_1:getPhasePuzzleInfo(self._phase)

	self._awards = var_0_3:getGoodsArray(var_2_2.drop)

	self.m_phaseComp:setTitle(g.core.lang:get(405801) .. g.core.lang:get(100 + self._phase))
	self.m_phaseComp:setDescText(var_2_2.phase_name)
	self.m_waveComp:setDescText(var_2_2.range_x * var_2_2.range_y)
	self.m_baseTimeComp:setDescText(g.core.lang:get(405802, {
		time = var_2_2.base_time
	}))
	self.m_awardList:setNumItems(#self._awards)
	self:_updateSurplusTimeText()
end

function ThemePuzzleInfoComp:_updateSurplusTimeText()
	self.m_surplusTimeComp:setDescText(var_0_4:getLeftDHFormat((self._themePuzzleData:getCurPhaseEndTime())))
end

function ThemePuzzleInfoComp:onLoad()
	return
end

function ThemePuzzleInfoComp:onUnload()
	return
end

function ThemePuzzleInfoComp:_onClickRankBtn()
	self:dispatchCompEvent("ThemePuzzle_rank")
end

function ThemePuzzleInfoComp:_onClickStartBtn()
	self:dispatchCompEvent("ThemePuzzle_start")
end

function ThemePuzzleInfoComp:_onAwardItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateIconData(self._awards[arg_8_1 + 1], (self._themePuzzleData:hasGotAwards()))
end

return ThemePuzzleInfoComp
