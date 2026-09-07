local MonopolyCar2024Scene = class("MonopolyCar2024Scene", import("view.base.BaseUI"))

function MonopolyCar2024Scene:getUIName()
	return "MonopolyCar2024UI"
end

function MonopolyCar2024Scene:init()
	return
end

function MonopolyCar2024Scene:didEnter()
	self:UpdateGame((getProxy(ActivityProxy):getActivityById(self.contextData.actId)))

	return
end

function MonopolyCar2024Scene:UpdateGame(arg_4_1)
	self.activity = arg_4_1

	if self.gameUI then
		self.gameUI:UpdateActivity(self.activity)
	else
		self.gameUI = self:NewGame()

		self.gameUI:Setup()
	end

	return
end

function MonopolyCar2024Scene:UpdateStory()
	if not self.gameUI then
		return
	end

	self.gameUI:UpdateStory()

	return
end

function MonopolyCar2024Scene:NewGame()
	return MonopolyCar2024Game.New(self.activity, self._tf:Find("adapt"), self.event)
end

function MonopolyCar2024Scene:onBackPressed()
	if self.gameUI and self.gameUI.isBlocksRaycasts then
		return
	end

	MonopolyCar2024Scene.super.onBackPressed(self)

	return
end

function MonopolyCar2024Scene:willExit()
	if self.gameUI then
		self.gameUI:Dispose()

		self.gameUI = nil
	end

	return
end

return MonopolyCar2024Scene
