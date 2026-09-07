local RacingMiniGameView = class("RacingMiniGameView", import("view.miniGame.MiniGameTemplateView"))

RacingMiniGameView.canSelectStage = false

function RacingMiniGameView:getUIName()
	return "RacingMiniGameUI"
end

function RacingMiniGameView:getGameController()
	return RacingMiniGameController
end

function RacingMiniGameView:getShowSide()
	return false
end

function RacingMiniGameView:initPageUI()
	self.rtTitlePage = self._tf:Find("TitlePage")

	self.rtTitlePage:Find("countdown"):Find("bg"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:openUI()
		self.gameController:StartGame()
		pg.BgmMgr.GetInstance():ContinuePlay()

		return
	end)
	onButton(self, self.rtTitlePage:Find("pause"):Find("window/btn_confirm"), function()
		self:openUI()
		self.gameController:ResumeGame()

		return
	end, SFX_CONFIRM)

	local var_4_0 = self.rtTitlePage:Find("exit")

	onButton(self, var_4_0:Find("window/btn_cancel"), function()
		self:openUI()
		self.gameController:ResumeGame()

		return
	end, SFX_CANCEL)
	onButton(self, var_4_0:Find("window/btn_confirm"), function()
		self:openUI()
		self.gameController:EndGame()

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtTitlePage:Find("result"):Find("window/btn_finish"), function()
		self:closeView()

		return
	end, SFX_CONFIRM)

	return
end

function RacingMiniGameView:didEnter()
	self:initPageUI()
	self:initControllerUI()

	self.gameController = self:getGameController().New(self, self._tf)

	self.gameController:ResetGame()
	self.gameController:ReadyGame(getProxy(MiniGameProxy):GetRank(self:GetMGData().id))
	pg.BgmMgr.GetInstance():StopPlay()
	self:openUI("countdown")

	return
end

function RacingMiniGameView:initOpenUISwich()
	RacingMiniGameView.super.initOpenUISwich(self)

	self.openSwitchDic.main = nil

	function self.openSwitchDic.result()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-streamers")

		local var_12_0 = self:GetMGData().id
		local var_12_1 = self.gameController.point
		local var_12_2 = getProxy(MiniGameProxy):GetHighScore(var_12_0) / 100
		local var_12_3 = self.rtTitlePage:Find("result")

		setActive(var_12_3:Find("window/now/new"), var_12_2 < self.gameController.point)

		if var_12_2 <= var_12_1 then
			var_12_2 = var_12_1

			getProxy(MiniGameProxy):UpdataHighScore(var_12_0, math.floor(var_12_1 * 100))
		end

		setText(var_12_3:Find("window/high/Text"), string.format("%.2fm", var_12_2))
		setText(var_12_3:Find("window/now/Text"), string.format("%.2fm", var_12_1))

		local var_12_4 = self:GetMGHubData()

		self:emit(BaseMiniGameMediator.GAME_FINISH_TRACKING, {
			game_id = var_12_0,
			hub_id = var_12_4.id,
			isComplete = self.gameController.result
		})

		if (not self:getShowSide() or self.stageIndex == var_12_4.usedtime + 1) and var_12_4.count > 0 then
			self:SendSuccess(0)
		end

		return
	end

	function self.openSwitchDic.countdown()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_PILE_COUNTDOWN)

		return
	end

	return
end

function RacingMiniGameView:willExit()
	self.gameController:willExit()

	return
end

return RacingMiniGameView
