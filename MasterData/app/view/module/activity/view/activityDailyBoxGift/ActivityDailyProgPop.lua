local var_0_0 = g.core.model.User.activityDailyBoxData
local ActivityDailyProgPop = class("ActivityDailyProgPop", require("app.fairyGUI.activity.UI_ActivityDailyProgPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityDailyProgPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivityDailyProgPop:ctor()
	self:showAtCenter()

	self._awardList = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self:_updateMainView()
end

function ActivityDailyProgPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_DAILYBOXTURNAWARD, handler(self, self._onGetActivityDailyTurnAward), self)
end

function ActivityDailyProgPop:_updateMainView()
	self._awardList = var_0_0:getAwardCfg()

	self.m_awardList:setNumItems(#self._awardList)
	self.m_scoreTxt:setText((var_0_0:getCurDailyBoxAwardScore()))
end

function ActivityDailyProgPop:_onRenderAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._awardList[arg_5_1 + 1], arg_5_1 + 1)
end

function ActivityDailyProgPop:_onGetActivityDailyTurnAward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
		self:_updateMainView()
	end
end

return ActivityDailyProgPop
