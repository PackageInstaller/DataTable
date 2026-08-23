local RecruitWishSuccubaComp = class("RecruitWishSuccubaComp", require("app.fairyGUI.recruitSuccuba.UI_RecruitWishSuccubaComp"))

function RecruitWishSuccubaComp:updateSuccuba(arg_1_1)
	self.m_knightPic:getController("state"):setSelectedIndex(1)
	self.m_knightPic:setIcon(arg_1_1.res)
	self.m_nameText:setText(arg_1_1.good.name)
	self.m_nameBgLoader:setURL((g.core.common.Path:getUserIconQualityStarBg(arg_1_1.good.quality)))
end

return RecruitWishSuccubaComp
