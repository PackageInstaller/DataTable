local NewSlgJumpToPop = class("NewSlgJumpToPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgJumpToPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	})
end)

function NewSlgJumpToPop:ctor()
	self:getView():center(true)
	self:getChild("Btn_go"):addClickListener(handler(self, self._onClickConfirm))

	self._posX = self:getChild("Txt_posX")
	self._posY = self:getChild("Txt_posY")
end

function NewSlgJumpToPop:_onClickConfirm()
	self:dispatchCompEvent("NewSlg_jumpToPos", {
		pos = {
			x = checknumber(self._posX:getText()),
			y = checknumber(self._posY:getText())
		}
	})
	self:removeSelf()
end

return NewSlgJumpToPop
