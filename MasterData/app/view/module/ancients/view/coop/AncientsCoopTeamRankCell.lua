local AncientsCoopTeamRankCell = class("AncientsCoopTeamRankCell", require("app.fairyGUI.ancients.UI_AncientsCoopTeamRankCell"))

function var_0_0:ctor()
	self:addClickListener(handler(self, self._onClickSelf))

	self._id = 0
end

function var_0_0:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = g.core.common.GlobalFunc.rankUnit_param(arg_2_1.param, "AncientSimpleTeam", true)
	local var_2_1 = g.core.utils.Tools.ancientsFunc.getSnapshot(var_2_0.captain)

	if var_2_1 == nil then
		return
	end

	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2 == 1 and 1 or 0)
	self.m_Comp_rank:updateRankIndex({
		rank = arg_2_1.rank
	})
	self.m_Comp_pet:updateAsUser(var_2_1)

	self._id = var_2_0.team_id

	local var_2_2 = {}

	var_2_2.level = var_2_0.level or 0

	self.m_Txt_level:setText(g.core.lang:get(2052, var_2_2))
	self.m_Txt_name:setText(g.core.lang:get(433332, {
		name = var_2_0.name
	}))
	self.m_Txt_num:setText("(" .. var_2_0.member_num .. "/4)")
	self.m_Txt_point:setText(var_2_0.score or 0)
	self.m_Txt_fight:setText(var_2_0.pet_fight_value or 0)
	self.m_is_selfController:setSelectedIndex(var_2_0.team_id == g.core.model.User.ancientsData:getTeamId() and 1 or 0)
end

function var_0_0:_onClickEquip()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
		teamId = self._id
	})
end

function var_0_0:_onClickSelf()
	if self._id ~= 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
			teamId = self._id
		})
	end
end

return var_0_0
