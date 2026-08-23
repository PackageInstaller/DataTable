local RecruitPreviewIcon = class("RecruitPreviewIcon", require("app.fairyGUI.recruit.UI_RecruitPreviewIcon"))

function RecruitPreviewIcon:ctor()
	return
end

function RecruitPreviewIcon:updateIcon(arg_2_1, arg_2_2)
	self.m_icon:updateIcon(arg_2_1)

	if arg_2_1.sizeStr then
		self.m_numText:setText(arg_2_1.sizeStr)
	else
		self.m_numText:setText("")
	end

	self.m_qualityController:setSelectedIndex(arg_2_1.quality == g.core.const.ConstMgr.QUALITY_TYPE.UR and 1 or 0)

	if arg_2_2 then
		self.m_upBg:setURL(g.core.common.Path:getUserIconQualityStarBg(arg_2_1.quality))
		self.m_upText:setText(arg_2_2)
		self.m_showUpTipController:setSelectedIndex(1)
	else
		self.m_showUpTipController:setSelectedIndex(0)
	end
end

return RecruitPreviewIcon
