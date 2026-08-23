local OutpostKnightTalkComp = class("OutpostKnightTalkComp", require("app.fairyGUI.outpost.UI_OutpostKnightTalkComp"))

function OutpostKnightTalkComp:showTalkParam(arg_1_1)
	self.m_talkComp:showTalkText(arg_1_1)
end

return OutpostKnightTalkComp
