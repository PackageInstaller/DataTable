local HandBookNameComp = class("HandBookNameComp", require("app.fairyGUI.handBook.UI_HandBookNameComp"))

function HandBookNameComp:setData(arg_1_1, arg_1_2)
	self.m_nameTxt:setText(arg_1_1.name)

	for iter_1_0 = 1, 3 do
		self["m_qualityBaseIcon" .. iter_1_0]:setURL(g.core.common.Path:getHandBookTitleQuality(arg_1_1.quality))
	end
end

return HandBookNameComp
