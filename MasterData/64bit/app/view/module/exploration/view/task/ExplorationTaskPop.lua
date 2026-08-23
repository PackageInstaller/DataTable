local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMapTipPop = class("ExplorationMapTipPop", require("app.fairyGUI.exploration.UI_ExplorationTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationTaskPop",
		pkgName = "exploration",
		pkgPath = "ui/exploration/exploration"
	})
end)

function ExplorationMapTipPop:ctor(arg_2_1)
	self:showAtCenter()

	self._taskInfo = arg_2_1

	self:_initView()
end

function ExplorationMapTipPop:_initView()
	self.m_getBtn:addClickListener(handler(self, self._onGetBtnClicked))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClicked))
	self.m_taskDesText:setText(self._taskInfo.cfg.task_describe)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setNumItems(#self._taskInfo.awards)
end

function ExplorationMapTipPop:onLoad()
	local var_4_0 = g.core.event.EventManager
	local var_4_1 = g.core.event.enum

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	var_4_0:addEventListener(var_4_1.EVENT_NET_S2C_EXPLORATION_FINISHTASK, handler(self, self._onS2CExplorationFINISHTASK), self)
	self.m_curText:setText(self._taskInfo.curValue)
	self.m_goalText:setText(self._taskInfo.cfg.goal)

	if self._taskInfo.state == ExplorationConst.TASK_STATE.MATCH then
		self.m_isFinishController:setSelectedIndex(1)
	else
		self.m_isFinishController:setSelectedIndex(0)
	end

	var_4_0:dispatchEvent(var_4_1.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {}
	})
	self.m_title:setText(self._taskInfo.cfg.task_name)
end

function ExplorationMapTipPop:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._taskInfo.awards[arg_5_1 + 1])
end

function ExplorationMapTipPop:_onGetBtnClicked()
	if self._taskInfo.state == ExplorationConst.TASK_STATE.MATCH then
		g.core.network.GameNetProxy:send_C2S_Exploration_FinishTask({
			task_id = self._taskInfo.cfg.id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420694))
	end
end

function ExplorationMapTipPop:_onS2CExplorationFINISHTASK(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards, nil, nil, nil, handler(self, function(arg_8_0)
		arg_8_0:_onCloseBtnClicked()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_TASK_CHANGE, false)
	end))
end

function ExplorationMapTipPop:_onEnterEnd()
	return
end

function ExplorationMapTipPop:_onBackEnd()
	self:_onCloseBtnClicked()
end

function ExplorationMapTipPop:_onCloseBtnClicked()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationMapTipPop
