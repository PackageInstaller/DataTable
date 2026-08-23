local var_0_0 = g.core.model.User.themeData
local GEGemInfoComp = class("GEGemInfoComp", require("app.fairyGUI.summerThemeGame.UI_GEGemInfoComp"))

function GEGemInfoComp:ctor()
	self.m_startGameBtn:addClickListener(handler(self, self._onStartGameClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function GEGemInfoComp:onLoad()
	self:newSchedule(handler(self, self._onCD))
end

function GEGemInfoComp:updateInfoView(arg_3_1)
	local var_3_0 = var_0_0:getThemeData(arg_3_1):getGemEliminateData()
	local var_3_1 = var_3_0:getCurPhaseCfg()

	self._gemData = var_3_0
	self._phaseId = var_3_0:getPhaseId()

	self.m_phaseComp:setDescText(var_3_1.phase_name)
	self.m_phaseComp:setTitle(g.core.lang:get(405801) .. g.core.lang:get(100 + self._phaseId))
	self:updateSurplusTimeText()
	self.m_baseTimeComp:setDescText(g.core.lang:get(405802, {
		time = var_3_1.base_time
	}))

	self._awards = g.core.common.Drops:getGoodsArray(var_3_1.drop)

	self.m_awardList:setNumItems(#self._awards)
end

function GEGemInfoComp:_onCD()
	self:updateSurplusTimeText()
end

function GEGemInfoComp:_onAwardListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIconData(self._awards[arg_5_1 + 1], self._gemData:isGetTodayReward())
end

function GEGemInfoComp:updateSurplusTimeText()
	if not self._gemData then
		return
	end

	self.m_surplusTimeComp:setDescText(g.core.common.ServerTime:getLeftDHFormat(self._gemData:getCurPhaseNeedDays() * 86400 + g.core.common.ServerTime:getLeftSeconds((self._gemData:getGemEliminateStartTime())) + g.core.common.ServerTime:getTime()))
end

function GEGemInfoComp:_onStartGameClick()
	self:dispatchCompEvent("ON_GAME_START_CLICK")
end

function GEGemInfoComp:_onRankBtnClick()
	self:dispatchCompEvent("ON_SHOW_RANK_CLICK")
end

function GEGemInfoComp:onUnload()
	self:cancelAllSchedule()
end

return GEGemInfoComp
