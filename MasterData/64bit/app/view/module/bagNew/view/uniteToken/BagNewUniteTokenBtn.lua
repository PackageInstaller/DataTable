local BagNewUniteTokenBtn = class("BagNewUniteTokenBtn", require("app.fairyGUI.bagNew.UI_BagNewUniteTokenBtn"))

function BagNewUniteTokenBtn:ctor()
	self.m_redPointComp = self:getChild("redPointComp")
end

return BagNewUniteTokenBtn
