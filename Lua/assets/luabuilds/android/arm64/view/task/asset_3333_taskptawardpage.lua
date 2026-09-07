local TaskPtAwardPage = class("TaskPtAwardPage", import("..base.BaseSubView"))

function TaskPtAwardPage:getUIName()
	return "ActivitybonusWindow"
end

function TaskPtAwardPage:Display(arg_2_1)
	self.window = self.window or TaskPtAwardWindow.New(self._tf, self)

	self.window:Show(arg_2_1)
	self:Show()

	return
end

function TaskPtAwardPage:OnDestroy()
	if self.window then
		self.window:Dispose()

		self.window = nil
	end

	return
end

return TaskPtAwardPage
