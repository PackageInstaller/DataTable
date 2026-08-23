local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local var_0_1 = g.core.model.User.explorationData
local ExplorationActivePointComp = class("ExplorationActivePointComp", require("app.fairyGUI.exploration.UI_ExplorationActivePointComp"))

function ExplorationActivePointComp:ctor()
	self:addClickListener(handler(self, self._onShowInfo))
end

function ExplorationActivePointComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_UNLOCKCELL, handler(self, self.onUpdateActivePoint), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_INFO, handler(self, self.onUpdateActivePoint), self)
	self:onUpdateActivePoint()
	self.m_maxTxt:setText(g.core.lang:get(420684, {
		num = g.core.config.exploration_parameter_info.get(var_0_0.PARAMETER_ACTION_NUM).parameter
	}))
end

function ExplorationActivePointComp:onUpdateActivePoint()
	self.m_pointTxt:setText(var_0_1:getMapData():getActionPoint())
end

function ExplorationActivePointComp:_onShowInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 346
	}), {
		touchDisappear = true
	})
end

return ExplorationActivePointComp
