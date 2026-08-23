local AncientsCoopTeamTargetComp = class("AncientsCoopTeamTargetComp")

function var_0_0:ctor()
	self._buttonCtrl = self:getController("button")
end

function var_0_0:updateView(arg_2_1)
	self:setTitle(g.core.config.ancients_team_tips_info.get(arg_2_1).tips or "")
end

return var_0_0
