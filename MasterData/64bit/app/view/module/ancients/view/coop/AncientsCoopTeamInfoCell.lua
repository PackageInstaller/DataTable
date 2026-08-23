local AncientsCoopTeamInfoCell = class("AncientsCoopTeamInfoCell", require("app.fairyGUI.ancients.UI_AncientsCoopTeamInfoCell"))

function var_0_0:ctor()
	self.m_is_finalController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)
end

function var_0_0:updateCell(arg_2_1)
	local var_2_0 = arg_2_1.user
	local var_2_1 = arg_2_1.isLeader

	self.m_is_emptyController:setSelectedIndex(arg_2_1.user == nil and 1 or 0)
	self.m_is_leaderController:setSelectedIndex(var_2_1 and 1 or 0)

	if var_2_0 == nil then
		return
	end

	self.m_Comp_icon:updateAsUser(arg_2_1.snapShot)

	local var_2_2 = g.core.config.knight_info.get(arg_2_1.snapShot.base_id)

	self.m_Txt_name:setText(arg_2_1.snapShot.name)
	self.m_Txt_fight:setText(var_2_0.fight_value)
	self.m_Txt_point:setText(var_2_0.score)
	self.m_Txt_teamPoint:setText(var_2_0.team_contribution)
end

return var_0_0
