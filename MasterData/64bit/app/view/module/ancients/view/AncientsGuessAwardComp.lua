local AncientsGuessAwardComp = class("AncientsGuessAwardComp", require("app.fairyGUI.ancients.UI_AncientsGuessAwardComp"))

function var_0_0:ctor()
	self.m_List_sucAward:setVirtual(self)
	self.m_List_sucAward:setItemRenderer(handler(self, self._onRenderListSucAwardCell))
	self.m_List_failAward:setVirtual(self)
	self.m_List_failAward:setItemRenderer(handler(self, self._onRenderListFailAwardCell))
end

function var_0_0:updateView(arg_2_1)
	self._flag = arg_2_1

	self.m_is_rank32Controller:setSelectedIndex(arg_2_1 and 1 or 0)
	self.m_is_selfController:setSelectedIndex(g.core.model.User.ancientsData:isRankLevelAward() == arg_2_1 and 1 or 0)
	self.m_List_sucAward:setNumItems(1)
	self.m_List_failAward:setNumItems(1)
end

function var_0_0:_onRenderListSucAwardCell(arg_3_1, arg_3_2)
	local var_3_0 = g.core.config.ancients_parameter_info.fetch(36) and g.core.config.ancients_parameter_info.get(36).parameter or 1

	arg_3_2:updateIcon({
		type = g.core.model.User.ancientsData:getAncientsInfo().guess_reward_type,
		value = g.core.model.User.ancientsData:getAncientsInfo().guess_reward_value,
		size = (self._flag or nil) and (g.core.config.ancients_parameter_info.fetch(38) and g.core.config.ancients_parameter_info.get(38).parameter or 1)
	})
end

function var_0_0:_onRenderListFailAwardCell(arg_4_1, arg_4_2)
	local var_4_0 = g.core.config.ancients_parameter_info.fetch(37) and g.core.config.ancients_parameter_info.get(37).parameter or 1

	arg_4_2:updateIcon({
		type = g.core.model.User.ancientsData:getAncientsInfo().guess_reward_type,
		value = g.core.model.User.ancientsData:getAncientsInfo().guess_reward_value,
		size = (self._flag or nil) and (g.core.config.ancients_parameter_info.fetch(39) and g.core.config.ancients_parameter_info.get(39).parameter or 1)
	})
end

return var_0_0
