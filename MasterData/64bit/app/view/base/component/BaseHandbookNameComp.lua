local BaseHandbookNameComp = class("BaseHandbookNameComp", require("app.fairyGUI.base_new.UI_BaseHandbookNameComp"))

function BaseHandbookNameComp:setData(arg_1_1, arg_1_2)
	self.m_nameTxt:setText(arg_1_1)

	for iter_1_0 = 1, 3 do
		self["m_qualityBaseIcon" .. iter_1_0]:setURL(g.core.common.Path:getHandBookTitleQuality(arg_1_2))
	end
end

return BaseHandbookNameComp
