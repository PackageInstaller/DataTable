local var_0_0 = g.core.common.Path
local FormationPreKnightComp = class("FormationPreKnightComp", require("app.fairyGUI.formation.UI_FormationPreKnightComp"))

function FormationPreKnightComp:ctor()
	return
end

function FormationPreKnightComp:updateKnightComp(arg_2_1)
	self.m_knightLoader:setURL((var_0_0:getKnightPictorialBook(arg_2_1.res_id)))
	self.m_qualityBg:setURL((var_0_0:getUserIconQualityStarBg(arg_2_1.quality)))
end

return FormationPreKnightComp
