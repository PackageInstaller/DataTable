local var_0_0 = g.core.config.knight_base_info
local var_0_1 = g.core.common.Path
local TeamBattleResultMaskComp = class("TeamBattleResultMaskComp", require("app.fairyGUI.teamBattle.UI_TeamBattleResultMaskComp"))

function TeamBattleResultMaskComp:updateMaskComp(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1.resId)

	if not var_1_0 then
		return
	end

	self:setIcon((var_0_1:getMiddleKnightPicById(var_1_0.painted_id)))
end

return TeamBattleResultMaskComp
