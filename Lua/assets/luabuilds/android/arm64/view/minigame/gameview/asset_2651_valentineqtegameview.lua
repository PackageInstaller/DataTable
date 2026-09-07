local ValentineQteGameView = class("ValentineQteGameView", import("..BaseMiniGameView"))

function ValentineQteGameView:getUIName()
	return "ValentineQteGamePage"
end

function ValentineQteGameView:init()
	self.gameView = ValentineQteGamePage.New(self._tf)

	return
end

function ValentineQteGameView:didEnter()
	self.gameView:SetUp(function()
		if self:GetMGHubData().count > 0 then
			self:SendSuccess(0)
		end

		return
	end, function()
		if self.gameView then
			self.gameView = nil
		end

		self:emit(ValentineQteGameView.ON_BACK)

		return
	end, self:GetMGHubData().usedtime == 0)

	return
end

function ValentineQteGameView:onBackPressed()
	if self.gameView and self.gameView:onBackPressed() then
		return
	end

	ValentineQteGameView.super.onBackPressed(self)

	return
end

function ValentineQteGameView:willExit()
	if self.gameView then
		self.gameView:Destroy()

		self.gameView = nil
	end

	return
end

return ValentineQteGameView
