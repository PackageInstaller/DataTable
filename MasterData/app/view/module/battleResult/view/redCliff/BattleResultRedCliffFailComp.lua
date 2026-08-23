local var_0_0 = g.core.model.User.redCliffData
local BattleResultRedCliffFailComp = class("BattleResultRedCliffFailComp", require("app.fairyGUI.battleResult.UI_BattleResultRedCliffFailComp"))

function BattleResultRedCliffFailComp:ctor()
	return
end

function BattleResultRedCliffFailComp:update(arg_2_1)
	local var_2_1 = var_0_0:getPlayerStructByUserId(arg_2_1.enemyId or 0)

	if var_2_1 then
		self.m_failTip:setText(g.core.lang:get(421001, {
			other = var_2_1:getUserName()
		}))
	end
end

return BattleResultRedCliffFailComp
