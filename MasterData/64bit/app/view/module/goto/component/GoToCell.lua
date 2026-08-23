local GoToCell = class("GoToCell", require("app.fairyGUI.goto.UI_GoToCell"))

function GoToCell:ctor()
	self._isOpen = false
	self._errDesc = ""

	self.m_goToBtn:addClickListener(handler(self, self._onGoToClick))
	self:addClickListener(handler(self, self._onItemClick))
end

function GoToCell:_onGoToClick()
	self:dispatchCompEvent("GotoCell_goto", self._data)
end

function GoToCell:_onItemClick()
	if not self._isOpen then
		if self._errDesc == "" then
			g.core.module.ModuleManager:tip(g.core.lang:get(2059))
		else
			g.core.module.ModuleManager:tip(self._errDesc)
		end
	end
end

function GoToCell:update(arg_4_1)
	self._data = arg_4_1
	self._isOpen = arg_4_1.isOpened
	self._errDesc = arg_4_1.errDesc

	self.m_titleTxt:setText(arg_4_1.route.name)

	if arg_4_1.routType == 1 then
		self.m_openStateController:setSelectedIndex(2)
	else
		self.m_openStateController:setSelectedIndex(arg_4_1.isOpened and 1 or 0)
	end
end

return GoToCell
