local NewSlgGatherComp = class("NewSlgGatherComp", require("app.fairyGUI.newSlg.UI_NewSlgGatherComp"))

function NewSlgGatherComp:setVis(arg_1_1)
	self.m_contentComp:setVis(arg_1_1)

	if arg_1_1 then
		self:setVisible(arg_1_1)
		self.m_enterTransition:play()
	else
		self.m_backTransition:play(handler(self, self.onCloseFinish))
	end
end

function NewSlgGatherComp:onCloseFinish()
	self:setVisible(false)
end

function NewSlgGatherComp:updateView()
	self.m_contentComp:updateView()
end

return NewSlgGatherComp
