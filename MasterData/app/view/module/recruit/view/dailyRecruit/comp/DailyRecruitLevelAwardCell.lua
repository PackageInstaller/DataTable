local var_0_0 = g.core.model.User.recruitData
local DailyRecruitLevelAwardCell = class("DailyRecruitLevelAwardCell", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLevelAwardCell"))

function DailyRecruitLevelAwardCell:ctor()
	self._showItemList = {}
	self._isGet = false

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
end

function DailyRecruitLevelAwardCell:_onItemRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateAwardItem(self._showItemList[arg_2_1 + 1], self.m_rewardStateController:getSelectedIndex() == 1)
end

function DailyRecruitLevelAwardCell:updateLevelAwardCell(arg_3_1)
	self.m_rewardTitle:setText(g.core.lang:get(410005, {
		level = arg_3_1.level + 1
	}))
	self.m_curNumText:setText(arg_3_1.time_max)

	if arg_3_1.level < var_0_0:getDailyRecruitInfo().level then
		self.m_rewardStateController:setSelectedIndex(1)
	elseif var_0_0:getDailyRecruitTotalTimes() >= arg_3_1.time_max then
		self.m_rewardStateController:setSelectedIndex(1)
	else
		self.m_rewardStateController:setSelectedIndex(0)

		local var_3_0 = var_0_0:getDailyRecruitTotalTimes()
		local var_3_1, var_3_2 = var_0_0:getDailyRecruitProgressValue(arg_3_1.level, var_3_0)

		self.m_progressText:setText(g.core.lang:get(200524, {
			curNum = var_3_0,
			totalNum = arg_3_1.time_max
		}))
	end

	self._showItemList = {}

	table.insert(self._showItemList, {
		type = arg_3_1.reward_type,
		value = arg_3_1.reward_value,
		size = arg_3_1.reward_size
	})
	self.m_itemList:setNumItems(#self._showItemList)
end

return DailyRecruitLevelAwardCell
