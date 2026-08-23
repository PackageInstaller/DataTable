local var_0_0 = g.core.config.richman_monster_info
local RichmanMonsterIcon = class("RichmanMonsterIcon", require("app.fairyGUI.richman.UI_RichmanMonsterIcon"))

function RichmanMonsterIcon:onRichManMonsterRenderer(arg_1_1)
	local var_1_0 = g.core.config.massive_monster_team_info.fetch(var_0_0.get(arg_1_1.value).monster_id)

	if not var_1_0 then
		return
	end

	self.m_monsterIcon:setIcon((g.core.common.Path:getKnightIconById(g.core.config.knight_info.get(var_1_0.knight_id_1).res_id)))
end

return RichmanMonsterIcon
