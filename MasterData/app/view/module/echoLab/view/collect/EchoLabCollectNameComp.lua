local EchoLabCollectNameComp = class("EchoLabCollectNameComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectNameComp"))

function EchoLabCollectNameComp:updateView(arg_1_1)
	self:setTitle(arg_1_1.name)

	for iter_1_0 = 1, 3 do
		self["m_qualityBaseIcon" .. iter_1_0]:setURL(g.core.common.Path:getHandBookTitleQuality(arg_1_1.quality))
	end
end

return EchoLabCollectNameComp
