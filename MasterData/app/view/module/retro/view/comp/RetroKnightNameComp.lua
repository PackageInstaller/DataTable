local RetroKnightNameComp = class("RetroKnightNameComp", require("app.fairyGUI.retro.UI_RetroKnightNameComp"))

function RetroKnightNameComp:updateName(arg_1_1)
	self.m_nameTxt:setText(arg_1_1.name)
	self.m_qualityLoader:setURL(g.core.common.Path:getQualityArtTxtURLNew(arg_1_1.quality))
end

return RetroKnightNameComp
