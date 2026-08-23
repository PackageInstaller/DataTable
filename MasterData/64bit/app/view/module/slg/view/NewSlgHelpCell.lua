local NewSlgHelpCell = class("NewSlgHelpCell")

function NewSlgHelpCell:ctor()
	self._txtTitle = self:getChild("Txt_title")
	self._txtDesc = self:getChild("Txt_desc")
end

function NewSlgHelpCell:updateCell(arg_2_1)
	self._txtTitle:setText(arg_2_1.name)
	self._txtDesc:setText(arg_2_1.text)
end

return NewSlgHelpCell
