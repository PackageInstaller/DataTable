local var_0_0 = g.core.const.ConstMgr.SpineConst
local BattleVSKnightComp = class("BattleVSKnightComp", require("app.fairyGUI.battle.UI_BattleVSLKnightComp"))

function BattleVSKnightComp:updateKnight(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = clone(arg_1_1)

	var_1_0.scale = 0.9

	self.m_knightPicComp:updateKnight(var_1_0)
	self.m_knightPicComp:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 150)
	self.m_watermarkComp:updateKnightByUrl((self.m_knightPicComp:getImageUrl()))
end

return BattleVSKnightComp
