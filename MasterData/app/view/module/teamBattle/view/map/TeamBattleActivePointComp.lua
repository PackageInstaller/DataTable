local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleActivePointComp = class("TeamBattleActivePointComp", require("app.fairyGUI.teamBattle.UI_TeamBattleActivePointComp"))

function TeamBattleActivePointComp:ctor()
	self:addClickListener(handler(self, self._onShowInfo))
	self.m_iconLoader:setURL(g.core.common.Path:getTeamBattleIcon(93))
end

function TeamBattleActivePointComp:onLoad()
	self:onUpdateActivePoint()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, handler(self, self.onUpdateActivePoint), self)
	self.m_maxTxt:setText(g.core.lang:get(420684, {
		num = g.core.model.User.shopData:getInitTimes(93)
	}))
end

function TeamBattleActivePointComp:onUpdateActivePoint()
	self.m_pointTxt:setText((g.core.model.User.teamBattleData:getMapData():getLeftPoint()))
end

function TeamBattleActivePointComp:_onShowInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 437
	}), {
		touchDisappear = true
	})
end

return TeamBattleActivePointComp
