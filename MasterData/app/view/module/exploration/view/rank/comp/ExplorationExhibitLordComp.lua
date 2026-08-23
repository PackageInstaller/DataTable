local ExplorationExhibitLordComp = class("ExplorationExhibitLordComp", require("app.fairyGUI.exploration.UI_ExplorationExhibitLordComp"))

function ExplorationExhibitLordComp:updateComp(arg_1_1)
	if not arg_1_1 then
		return
	end

	self.m_nameTxt:setText(arg_1_1.name)
	self.m_serverTxt:setText(arg_1_1.server_name)
	self.m_knightPic:getChild("knightPic"):setURL(g.core.common.Path:getMiddleKnightPicById((arg_1_1.show_knight_dress and arg_1_1.show_knight_dress > 0 or nil) and arg_1_1.show_knight_dress))
end

return ExplorationExhibitLordComp
