local ComDescComp = class("ComDescComp")

function ComDescComp:ctor()
	self._txtNum = self:getChild("Txt_num")
	self._title = self:getChild("title")
	self._colorCtrl = self:getController("color")
end

function ComDescComp:updateView(arg_2_1)
	self._txtNum:setText(arg_2_1.num)

	if arg_2_1.size then
		self:setFontSize(arg_2_1.size)
	end
end

function ComDescComp:setFontSize(arg_3_1)
	self._title:setFontSize(arg_3_1)
	self._txtNum:setFontSize(arg_3_1)
end

function ComDescComp:setColor(arg_4_1)
	self._colorCtrl:setSelectedIndex(arg_4_1)
end

return ComDescComp
