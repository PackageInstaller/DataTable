local AncientsInformationCell = class("AncientsInformationCell", require("app.fairyGUI.ancients.UI_AncientsInformationCell"))

function var_0_0:ctor()
	self.m_userList:setVirtual(self)
	self.m_userList:setItemRenderer(handler(self, self._onRenderListTeamRankingCell))
end

function var_0_0:updateCell(arg_2_1, arg_2_2)
	self.m_Comp_rank:updateRankIndex({
		rank = arg_2_1.dataIndex
	})

	self._cacheMap = arg_2_2
	self._userList = arg_2_1.data.promote_users or {}

	self.m_userList:setNumItems(#self._userList)
	self.m_Comp_leader_name:setText(arg_2_1.data.team.name)

	local var_2_0 = {}

	var_2_0.level = arg_2_1.data.team.level or 0

	self.m_Txt_level:setText(g.core.lang:get(2052, var_2_0))
	self.m_Txt_team_points:setText(arg_2_1.data.team.score or 0)
	self.m_Txt_beast_power:setText(arg_2_1.data.team.pet_fight_value or 0)
end

function var_0_0:_onRenderListTeamRankingCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._userList[arg_3_1 + 1], self._cacheMap)
end

return var_0_0
