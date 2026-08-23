local var_0_0 = g.core.config.mine_desc_info
local MineConst = require("app.view.module.mine.const.MineConst")
local MineTimeInfoComp = class("MineTimeInfoComp", require("app.fairyGUI.mine.UI_MineTimeInfoComp"))

function MineTimeInfoComp:ctor()
	self._updateTime = 0
	self._refreshTime = nil

	self.m_detailBtn:addClickListener(handler(self, self._onClickServer))
end

function MineTimeInfoComp:updateCountDown()
	local var_2_0 = g.core.model.User.mineData:getTotalWarTime()
	local var_2_1 = g.core.common.ServerTime:getTime()
	local var_2_2 = 0
	local var_2_3 = {}

	if var_2_1 <= var_2_0 then
		var_2_3 = var_0_0.get(2)
		var_2_2 = g.core.common.ServerTime:getCountDownBySecond(var_2_0 - var_2_1)
	else
		var_2_3 = var_0_0.get(3)
		var_2_2 = g.core.common.ServerTime:getCountDownBySecond(g.core.model.User.mineData:getSeasonEndTime() - var_2_1)
	end

	self.m_endTimeTxt:setText(g.core.lang:get(307510, {
		time = var_2_2,
		stage = var_2_3.name
	}))

	if self._updateTime == 0 then
		self._updateTime = var_2_1 - 1
	end

	if var_2_0 > self._updateTime and var_2_0 <= var_2_1 then
		self:updateTimeStage(2)
	end

	local var_2_4 = g.core.common.ServerTime:secondsFromToday()
	local var_2_5 = g.core.config.mine_event_info.indexOf(1).refresh_time

	if var_2_5 < var_2_4 then
		var_2_5 = var_2_5 + 86400
	end

	local var_2_6 = var_2_5 - var_2_4

	if self._refreshTime and var_2_1 > self._refreshTime then
		self._refreshTime = var_2_1 + var_2_6

		g.core.network.GameNetProxy:send_C2S_Mine_GetInfo({})
	end

	self._refreshTime = self._refreshTime or var_2_1 + var_2_6

	self.m_refreshTimeTxt:setText((g.core.common.ServerTime:getCountDownBySecond(var_2_6)))

	self._updateTime = var_2_1
end

function MineTimeInfoComp:updateTimeStage(arg_3_1)
	local var_3_0 = arg_3_1 or g.core.model.User.mineData:getTimeStage()

	self.m_stageTxt:setText((var_3_0 == MineConst.TIME_STAGE.NORMAL and var_0_0.get(1) or var_3_0 == MineConst.TIME_STAGE.TOTAL_WAR and var_0_0.get(2) or var_0_0.get(3)).name)
end

function MineTimeInfoComp:_onClickServer()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineServerInfoPop").new(), {
		touchDisappear = true
	})
end

return MineTimeInfoComp
