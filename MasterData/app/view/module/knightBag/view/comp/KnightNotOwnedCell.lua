local KnightNotOwnedCell = class("KnightNotOwnedCell", require("app.fairyGUI.knightBag.UI_KnightNotOwnedCell"))

function KnightNotOwnedCell:ctor()
	return
end

function KnightNotOwnedCell:updateCell(arg_2_1, arg_2_2)
	self.m_index:setText(arg_2_2)

	local var_2_0 = g.core.model.User.knightsData:getKnightByAdvanceId(arg_2_1)

	self.m_knightName:setText(var_2_0:getName())
	self.m_knightCard:updatePic(var_2_0)
	self.m_isCaptainController:setSelectedIndex(var_2_0:isElementLeader() and 1 or 0)

	local var_2_1 = var_2_0:getCfg()

	self.m_professionBg:setURL(g.core.common.Path:getProfessionBg(var_2_1.attack_type))
	self.m_professionIcon:setURL(g.core.common.Path:getKnightProfessionAndDamageTypeIcon(var_2_1.profession, 0))
	self.m_elementIcon:setURL(g.core.common.Path:getKnightElementIcon(var_2_1.classical))
	self.m_artifactIcon:setURL(g.core.common.Path:getArtifactIconById((var_2_0:getArtifactId())))
end

return KnightNotOwnedCell
