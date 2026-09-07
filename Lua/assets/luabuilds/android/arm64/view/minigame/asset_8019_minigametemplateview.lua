local MiniGameTemplateView = class("MiniGameTemplateView", import("view.miniGame.BaseMiniGameView"))

MiniGameTemplateView.canSelectStage = true

function MiniGameTemplateView:getUIName()
	return nil
end

function MiniGameTemplateView:getGameController()
	return nil
end

function MiniGameTemplateView:getShowSide()
	return true
end

function MiniGameTemplateView:updateMainUI()
	if self:getShowSide() then
		local var_4_0 = self:GetMGHubData()
		local var_4_1 = var_4_0:getConfig("reward_need")
		local var_4_2 = math.min(var_4_0.usedtime + 1, var_4_0.usedtime + var_4_0.count)
		local var_4_3 = self.itemList.container

		for iter_4_0 = 1, self.itemList.container.childCount do
			local var_4_4 = {}

			if iter_4_0 <= var_4_0.usedtime then
				var_4_4.finish = true
			elseif iter_4_0 <= var_4_0.usedtime + var_4_0.count then
				-- block empty
			else
				var_4_4.lock = true
			end

			local var_4_5 = var_4_3:GetChild(iter_4_0 - 1)

			setActive(var_4_5:Find("finish"), var_4_4.finish)
			setActive(var_4_5:Find("lock"), var_4_4.lock)
			setToggleEnabled(var_4_5, self.canSelectStage and iter_4_0 <= var_4_2)
			triggerToggle(var_4_5, iter_4_0 == var_4_2)
		end

		local var_4_7 = var_4_3:GetComponent(typeof(ScrollRect)).viewport.rect.height

		scrollTo(var_4_3, nil, 1 - math.clamp(var_4_3:GetChild(0).anchoredPosition.y - var_4_3:GetChild(var_4_2 - 1).anchoredPosition.y, 0, var_4_3.rect.height - var_4_7) / (var_4_3.rect.height - var_4_7))
	end

	self:checkGet()

	return
end

function MiniGameTemplateView:checkGet()
	local var_5_0 = self:GetMGHubData()

	if var_5_0.ultimate == 0 then
		if var_5_0.usedtime < var_5_0:getConfig("reward_need") then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_5_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function MiniGameTemplateView:initPageUI()
	self.rtTitlePage = self._tf:Find("TitlePage")

	local var_6_0 = self.rtTitlePage:Find("main")

	onButton(self, var_6_0:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, var_6_0:Find("btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["2023spring_minigame_help"].tip
		})

		return
	end, SFX_PANEL)

	local var_6_1 = self:GetMGData():GetSimpleValue("story")

	onButton(self, var_6_0:Find("btn_start"), function()
		local var_9_0 = {}
		local var_9_1 = checkExist(var_6_1, {
			self.stageIndex
		}, {
			1
		})

		if var_9_1 then
			table.insert(var_9_0, function(arg_10_0)
				pg.NewStoryMgr.GetInstance():Play(var_9_1, arg_10_0)

				return
			end)
		end

		seriesAsync(var_9_0, function()
			self:openUI("countdown")

			return
		end)

		return
	end, SFX_PANEL)

	self.stageIndex = 0

	if self:getShowSide() then
		local var_6_2 = pg.mini_game[self:GetMGData().id].simple_config_data.drop
		local var_6_3 = var_6_0:Find("side_panel/award/content")

		self.itemList = UIItemList.New(var_6_3, var_6_3:GetChild(0))

		self.itemList:make(function(arg_12_0, arg_12_1, arg_12_2)
			arg_12_1 = arg_12_1 + 1

			if arg_12_0 == UIItemList.EventUpdate then
				local var_12_0 = arg_12_2:Find("IconTpl")
				local var_12_1 = {}

				var_12_1.type, var_12_1.id, var_12_1.count = unpack(var_6_2[arg_12_1])

				updateDrop(var_12_0, var_12_1)
				onButton(self, var_12_0, function()
					self:emit(MiniGameTemplateView.ON_DROP, var_12_1)

					return
				end, SFX_PANEL)
				onToggle(self, arg_12_2, function(arg_14_0)
					if arg_14_0 then
						self.stageIndex = arg_12_1
					end

					return
				end)
			end

			return
		end)
		self.itemList:align(#var_6_2)
	end

	self.rtTitlePage:Find("countdown"):Find("bg/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:openUI()
		self.gameController:StartGame()

		return
	end)
	onButton(self, self.rtTitlePage:Find("pause"):Find("window/btn_confirm"), function()
		self:openUI()
		self.gameController:ResumeGame()

		return
	end, SFX_CONFIRM)

	local var_6_4 = self.rtTitlePage:Find("exit")

	onButton(self, var_6_4:Find("window/btn_cancel"), function()
		self:openUI()
		self.gameController:ResumeGame()

		return
	end, SFX_CANCEL)
	onButton(self, var_6_4:Find("window/btn_confirm"), function()
		self:openUI()
		self.gameController:EndGame()

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtTitlePage:Find("result"):Find("window/btn_finish"), function()
		self:openUI("main")

		return
	end, SFX_CONFIRM)

	return
end

function MiniGameTemplateView:initControllerUI()
	local var_20_0 = self._tf:Find("Controller/top")

	onButton(self, var_20_0:Find("btn_back"), function()
		self:openUI("exit")

		return
	end, SFX_PANEL)
	onButton(self, var_20_0:Find("btn_pause"), function()
		self:openUI("pause")

		return
	end)

	return
end

function MiniGameTemplateView:SaveDataChange(arg_23_1)
	self:StoreDataToServer(arg_23_1)

	return
end

function MiniGameTemplateView:didEnter()
	self:initPageUI()
	self:initControllerUI()

	self.gameController = self:getGameController().New(self, self._tf)

	self:openUI("main")

	return
end

function MiniGameTemplateView:initOpenUISwich()
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
			local var_29_0 = self:GetMGData():GetRuntimeData("elements")

			var_29_0 = var_29_0 or {}

			local var_29_1 = self.gameController.point
			local var_29_2 = var_29_0[1] or 0
			local var_29_3 = self.rtTitlePage:Find("result")

			setActive(var_29_3:Find("window/now/new"), var_29_2 < var_29_1)

			if var_29_2 <= var_29_1 then
				var_29_2 = var_29_1
				var_29_0[1] = var_29_1
			end

			self:SaveDataChange(var_29_0)
			setText(var_29_3:Find("window/high/Text"), var_29_2)
			setText(var_29_3:Find("window/now/Text"), var_29_1)

			local var_29_4 = self:GetMGHubData()

			if (not self:getShowSide() or self.stageIndex == var_29_4.usedtime + 1) and var_29_4.count > 0 then
				self:SendSuccess(0)
			end

			return
		end
	}

	return
end

function MiniGameTemplateView:openUI(arg_30_1)
	if not self.openSwitchDic then
		self:initOpenUISwich()
	end

	if self.status then
		setActive(self.rtTitlePage:Find(self.status), false)
	end

	if arg_30_1 then
		setActive(self.rtTitlePage:Find(arg_30_1), true)
	end

	self.status = arg_30_1

	switch(arg_30_1, self.openSwitchDic)

	return
end

function MiniGameTemplateView:initBackPressSwitch()
	self.backPressSwitchDic = {
		main = function()
			MiniGameTemplateView.super.onBackPressed(self)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			self:openUI()
			self.gameController:ResumeGame()

			return
		end,
		exit = function()
			self:openUI()
			self.gameController:ResumeGame()

			return
		end,
		result = function()
			return
		end
	}

	return
end

function MiniGameTemplateView:onBackPressed()
	if not self.backPressSwitchDic then
		self:initBackPressSwitch()
	end

	switch(self.status, self.backPressSwitchDic, function()
		assert(self.gameController.isStart)
		self:openUI("pause")

		return
	end)

	return
end

function MiniGameTemplateView:willExit()
	return
end

return MiniGameTemplateView
