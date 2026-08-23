local GveInstituteProgress = class("GveInstituteProgress", require("app.fairyGUI.gve.UI_GveInstituteProgress"))

function GveInstituteProgress:setProgress(arg_1_1, arg_1_2)
	self:setMax(arg_1_2)
	self:setValue(arg_1_1)
	self.m_progressTxt:setText(arg_1_1 .. "/" .. arg_1_2)
	self.m_effProgress:setProgress(arg_1_1, arg_1_2)
end

function GveInstituteProgress:playAwardPoint()
	self.m_effProgress:playAwardPoint()
end

function GveInstituteProgress:_onPlayAwardFinish()
	self.m_effProgress:_onPlayAwardFinish()
end

return GveInstituteProgress
