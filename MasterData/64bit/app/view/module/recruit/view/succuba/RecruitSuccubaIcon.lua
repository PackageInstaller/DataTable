local RecruitSuccubaIcon = class("RecruitSuccubaIcon", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaIcon"))

function RecruitSuccubaIcon:setSuccubaIcon(arg_1_1)
	self.m_succubaComp:setIcon(arg_1_1)
end

return RecruitSuccubaIcon
