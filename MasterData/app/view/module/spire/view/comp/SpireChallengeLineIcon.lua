local SpireChallengeLineIcon = class("SpireChallengeLineIcon", require("app.fairyGUI.spire.UI_SpireChallengeLineIcon"))

function SpireChallengeLineIcon:updateLineIcon(arg_1_1, arg_1_2)
	self.m_icon:updateComp(arg_1_2, arg_1_1, nil, true, false)
end

return SpireChallengeLineIcon
