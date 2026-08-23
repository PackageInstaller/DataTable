local var_0_0 = g.core.const.ConstMgr.WeeklyCompetitionConst
local WeeklyCompetitionRewardItem = class("WeeklyCompetitionRewardItem", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionRewardItem")))

function WeeklyCompetitionRewardItem:ctor()
	self._data = nil

	self:_initList()
end

function WeeklyCompetitionRewardItem:_initList()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_awardList:doFairyBatching(false)
end

function WeeklyCompetitionRewardItem:updateItem(arg_3_1, arg_3_2)
	self._data = arg_3_1

	self:setTitle(arg_3_1.cfg.node_name)
	self.m_awardList:setNumItems(#self._data.awards)

	if arg_3_2 == var_0_0.REWARD_STATE.REWARDED then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function WeeklyCompetitionRewardItem:_onAwardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._data.awards[arg_4_1 + 1])
end

return WeeklyCompetitionRewardItem
