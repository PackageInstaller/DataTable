local GameRoomDOAPPView = class("GameRoomDOAPPView", import("view.miniGame.MiniGameTemplateView"))

GameRoomDOAPPView.canSelectStage = false

function GameRoomDOAPPView:getUIName()
	return "GameRoomDOAPPUI"
end

function GameRoomDOAPPView:getGameController()
	return DOAPPMiniGameController
end

function GameRoomDOAPPView:initPageUI()
	GameRoomDOAPPView.super.initPageUI(self)
	onButton(self, self.rtTitlePage:Find("main/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.doa_minigame_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = self:GetMGData():GetSimpleValue("story")

	onButton(self, self.rtTitlePage:Find("main/btn_start"), function()
		local var_5_0 = {}
		local var_5_1 = checkExist(var_3_0, {
			self.stageIndex
		}, {
			1
		})

		if var_5_1 then
			table.insert(var_5_0, function(arg_6_0)
				pg.NewStoryMgr.GetInstance():Play(var_5_1, arg_6_0)

				return
			end)
		end

		seriesAsync(var_5_0, function()
			self:openUI("select")
			self:openCoinLayer(false)

			return
		end)

		return
	end, SFX_PANEL)

	local var_3_1 = self.rtTitlePage:Find("select")

	onButton(self, var_3_1:Find("btn_back"), function()
		self:openUI("main")
		self:openCoinLayer(true)
		self:openCoinLayer(true)

		return
	end, SFX_CANCEL)
	onButton(self, var_3_1:Find("btn/confirm"), function()
		if not self.character then
			pg.TipsMgr.GetInstance():ShowTips("without selected character")

			return
		end

		self.gameController:ResetGame()
		self.gameController:ReadyGame({
			name = self.character
		})
		self:openUI("countdown")

		return
	end, SFX_CONFIRM)
	eachChild(var_3_1:Find("content"), function(arg_10_0)
		setText(arg_10_0:Find("name/Text"), i18n("doa_minigame_" .. arg_10_0.name))
		onToggle(self, arg_10_0, function(arg_11_0)
			if arg_11_0 then
				self.character = arg_10_0.name

				setAnchoredPosition(arg_10_0:Find(arg_10_0.name), {
					x = 70
				})
				quickPlayAnimator(arg_10_0:Find(arg_10_0.name .. "/Image"), "Win")
			else
				if self.character == arg_10_0.name then
					self.character = nil
				end

				setAnchoredPosition(arg_10_0:Find(arg_10_0.name), {
					x = 110
				})
				quickPlayAnimator(arg_10_0:Find(arg_10_0.name .. "/Image"), "Idle")
			end

			return
		end, SFX_PANEL)

		return
	end)

	return
end

local function var_0_1(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	eachChild(arg_12_0:Find("mask"), function(arg_13_0)
		setActive(arg_13_0, arg_13_0.name == arg_12_1)

		return
	end)
	setText(arg_12_0:Find("name/Text"), i18n("doa_minigame_" .. arg_12_1))
	eachChild(arg_12_0:Find("name/Text"), function(arg_14_0)
		setActive(arg_14_0, arg_14_0.name == arg_12_1)

		return
	end)
	setActive(arg_12_0:Find("result/lose"), arg_12_3 < 0)
	setActive(arg_12_0:Find("result/win"), arg_12_3 > 0)
	eachChild(arg_12_0:Find("point"), function(arg_15_0)
		setActive(arg_15_0, tonumber(arg_15_0.name) <= arg_12_2)

		return
	end)

	return
end

function GameRoomDOAPPView:initOpenUISwich()
	GameRoomDOAPPView.super.initOpenUISwich(self)

	function self.openSwitchDic.result()
		var_0_1(self.rtTitlePage:Find("result/window/self"), self.gameController:GetResultInfo(false))
		var_0_1(self.rtTitlePage:Find("result/window/other"), self.gameController:GetResultInfo(true))

		local var_17_0 = self:GetMGHubData()

		self:SendSuccess(0)

		return
	end

	function self.openSwitchDic.select()
		triggerToggle(self.rtTitlePage:Find("select/content/Marie"), true)

		return
	end

	return
end

function GameRoomDOAPPView:initBackPressSwitch()
	GameRoomDOAPPView.super.initBackPressSwitch(self)

	function self.backPressSwitchDic.select()
		self:openUI("main")
		self:openCoinLayer(true)

		return
	end

	return
end

function GameRoomDOAPPView:willExit()
	self.gameController:willExit()

	return
end

function GameRoomDOAPPView:getShowSide()
	return false
end

return GameRoomDOAPPView
