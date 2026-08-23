local AncientsBattleHeadComp = class("AncientsBattleHeadComp", require("app.fairyGUI.ancients.UI_AncientsBattleHeadComp"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateCell(arg_2_1)
	self._teamUser = arg_2_1.teamUser

	local var_2_1 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._teamUser.user_id)

	if var_2_1 then
		self.m_headComp:updateAsUser(var_2_1)
		self.m_nameTxt:setText(var_2_1.name)
	end
end

return var_0_0
