local ComTipsComp = class("ComTipsComp")

function ComTipsComp:ctor()
	self._txtContent = self:getChild("title")
end

function ComTipsComp:setTxt(arg_2_1)
	self._txtContent:setText(arg_2_1 or "")
end

return ComTipsComp
