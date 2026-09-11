local ReversePacmanGameScene = class("ReversePacmanGameScene", import("view.base.BaseUI"))

function ReversePacmanGameScene:getUIName()
	return "ReversePacmanGameUI"
end

function ReversePacmanGameScene:init()
	onButton(self, self.uiTopTF:Find("back"), function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.uiTopTF:Find("home"), function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)

	self.settleSubView = ReversePacmanSettleSubView.New(self._tf, self.event, self.contextData)

	return
end

function ReversePacmanGameScene:didEnter()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)
	self.gameControl = ReversePacmanGameController.New(self, self._tf)

	self.gameControl:SetUp(self.contextData.levelId, self.contextData.slotShipIds, self.contextData.buffIds, self.contextData.buffCnts, self.contextData.eduBuffCnt)

	return
end

function ReversePacmanGameScene:GameOver(arg_6_1)
	self.settleData = arg_6_1

	if self.settleData.result == ReversePacmanConst.RESULT_TYPE.SUCCESS then
		self:emit(ReversePacmanGameMediator.SETTLE_GAME, {
			actId = self.activity.id,
			levelId = self.contextData.levelId,
			time = self.settleData.useTime
		})
	else
		self:ShowSettlePanel()
	end

	return
end

function ReversePacmanGameScene:ShowSettlePanel(arg_7_1)
	self.settleSubView:ExecuteAction("Show", setmetatable({
		awards = arg_7_1 or {}
	}, {
		__index = self.settleData
	}), function()
		self:onBackPressed()

		return
	end)

	return
end

function ReversePacmanGameScene:willExit()
	if self.settleSubView then
		self.settleSubView:Destroy()

		self.settleSubView = nil
	end

	self.gameControl:Dispose()

	return
end

return ReversePacmanGameScene
