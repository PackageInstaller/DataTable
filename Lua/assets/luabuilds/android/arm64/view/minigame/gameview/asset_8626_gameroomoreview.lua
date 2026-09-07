local GameRoomOreView = class("GameRoomOreView", import("view.miniGame.MiniGameTemplateView"))

function GameRoomOreView:getUIName()
	return "GameRoomOreUI"
end

function GameRoomOreView:getGameController()
	return OreMiniGameController
end

function GameRoomOreView:getShowSide()
	return false
end

function GameRoomOreView:initPageUI()
	GameRoomOreView.super.initPageUI(self)
	onButton(self, self.rtTitlePage:Find("main/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ore_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rtTitlePage:Find("result/window/btn_finish"), function()
		self:openUI("main")
		self.gameController:ResetGame()

		return
	end, SFX_CONFIRM)

	return
end

function GameRoomOreView:initOpenUISwich()
	self.openSwitchDic = {
		main = function()
			self:updateMainUI()

			return
		end,
		pause = function()
			self.gameController:PauseGame()

			return
		end,
		exit = function()
			self.gameController:PauseGame()

			return
		end,
		result = function()
			local var_11_0 = self:GetMGData():GetRuntimeData("elements")

			var_11_0 = var_11_0 or {}

			local var_11_1 = self.gameController.point
			local var_11_2 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)
			local var_11_3 = self.rtTitlePage:Find("result")

			setActive(var_11_3:Find("window/now/new"), var_11_2 < self.gameController.point)

			if var_11_2 <= var_11_1 then
				var_11_2 = var_11_1
				var_11_0[1] = var_11_1
			end

			self:StoreDataToServer({
				var_11_2
			})
			setText(var_11_3:Find("window/high/Text"), var_11_2)
			setText(var_11_3:Find("window/now/Text"), var_11_1)

			local var_11_4 = self:GetMGHubData()

			self:SendSuccess(var_11_1)

			return
		end
	}

	return
end

function GameRoomOreView:openUI(arg_12_1)
	if not self.openSwitchDic then
		self:initOpenUISwich()
	end

	if self.status then
		setActive(self.rtTitlePage:Find(self.status), false)
	end

	if arg_12_1 == "main" then
		self:openCoinLayer(true)
	else
		self:openCoinLayer(false)
	end

	if arg_12_1 then
		setActive(self.rtTitlePage:Find(arg_12_1), true)
	end

	self.status = arg_12_1

	switch(arg_12_1, self.openSwitchDic)

	return
end

function GameRoomOreView:updateMainUI()
	GameRoomOreView.super.updateMainUI(self)

	return
end

function GameRoomOreView:willExit()
	self.gameController:willExit()

	return
end

return GameRoomOreView
