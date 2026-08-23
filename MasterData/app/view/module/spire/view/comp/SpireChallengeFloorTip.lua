local SpireChallengeFloorTip = class("SpireChallengeFloorTip", require("app.fairyGUI.spire.UI_SpireChallengeFloorTip"))

function SpireChallengeFloorTip:ctor()
	self.m_txtComp:getChild("title"):enableRich()
end

function SpireChallengeFloorTip:updateTip(arg_2_1)
	self.m_txtComp:setTitle(arg_2_1)
end

return SpireChallengeFloorTip
