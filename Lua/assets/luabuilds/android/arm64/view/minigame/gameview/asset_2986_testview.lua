local TestView = class("TestView", import("..BaseMiniGameView"))

function TestView:getUIName()
	return "MailBoxUI2"
end

function TestView:init()
	print("初始化")

	self._closeBtn = self._tf:Find("main/top/btnBack")
	self._btn1 = self._tf:Find("main/delete_all_button")
	self._btn2 = self._tf:Find("main/get_all_button")

	return
end

function TestView:didEnter()
	onButton(self, self._closeBtn, function()
		self:emit(TestView.ON_BACK)

		return
	end)
	onButton(self, self._btn1, function()
		self:SendSuccess(1)

		return
	end)
	onButton(self, self._btn2, function()
		self:SendFailure(1)

		return
	end)

	return
end

return TestView
