local NenjuuMiniGameView = class("NenjuuMiniGameView", import("view.miniGame.BaseMiniGameView"))

function NenjuuMiniGameView:getUIName()
	return "NenjuuMiniGameUI"
end

function NenjuuMiniGameView:openUI(arg_2_1)
	if self.status then
		setActive(self.rtTitlePage:Find(self.status), false)
	end

	if arg_2_1 then
		setActive(self.rtTitlePage:Find(arg_2_1), true)
	end

	self.status = arg_2_1

	switch(arg_2_1, {
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
			local var_6_0 = self:GetMGData():GetRuntimeData("elements")

			var_6_0 = var_6_0 or {}

			local var_6_1 = NenjuuGameConfig.ParsingElements(var_6_0)
			local var_6_2 = self.gameController.point
			local var_6_3 = var_6_1.high
			local var_6_4 = self.rtTitlePage:Find("result")

			setActive(var_6_4:Find("window/now/new"), var_6_1.high < self.gameController.point)

			if var_6_3 <= var_6_2 then
				var_6_3 = var_6_2
				var_6_1.high = var_6_2
			end

			var_6_1.count = var_6_1.count + var_6_2

			self:SaveDataChange(var_6_1)
			setText(var_6_4:Find("window/high/Text"), var_6_3)
			setText(var_6_4:Find("window/now/Text"), var_6_2)

			local var_6_5 = self:GetMGHubData()

			if self.stageIndex == var_6_5.usedtime + 1 and var_6_5.count > 0 then
				self:SendSuccess(0)
			end

			return
		end
	})

	return
end

function NenjuuMiniGameView:updateMainUI()
	local var_7_0 = self:GetMGHubData()
	local var_7_1 = var_7_0:getConfig("reward_need")
	local var_7_2 = math.min(var_7_0.usedtime + 1, var_7_0.usedtime + var_7_0.count)
	local var_7_3 = self.itemList.container

	for iter_7_0 = 1, self.itemList.container.childCount do
		local var_7_4 = {}

		if iter_7_0 <= var_7_0.usedtime then
			var_7_4.finish = true
		elseif iter_7_0 <= var_7_0.usedtime + var_7_0.count then
			-- block empty
		else
			var_7_4.lock = true
		end

		local var_7_5 = var_7_3:GetChild(iter_7_0 - 1)

		setActive(var_7_5:Find("finish"), var_7_4.finish)
		setActive(var_7_5:Find("lock"), var_7_4.lock)
		setToggleEnabled(var_7_5, iter_7_0 <= var_7_2)
		triggerToggle(var_7_5, iter_7_0 == var_7_2)
	end

	self:checkGet()

	return
end

function NenjuuMiniGameView:checkGet()
	local var_8_0 = self:GetMGHubData()

	if var_8_0.ultimate == 0 then
		if var_8_0.usedtime < var_8_0:getConfig("reward_need") then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_8_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function NenjuuMiniGameView:initPageUI()
	self.rtTitlePage = self._tf:Find("TitlePage")

	local var_9_0 = self.rtTitlePage:Find("main")

	onButton(self, var_9_0:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, var_9_0:Find("btn_home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, var_9_0:Find("btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["2023spring_minigame_help"].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, var_9_0:Find("btn_opreation"), function()
		setActive(self.rtLevel:Find("Opreation"), true)
		self:UpdateOpreationPage(1)

		return
	end, SFX_PANEL)

	local var_9_1 = self:GetMGData():GetSimpleValue("story")

	onButton(self, var_9_0:Find("btn_start"), function()
		local var_14_0 = {}
		local var_14_1 = checkExist(var_9_1, {
			self.stageIndex
		}, {
			1
		})

		if var_14_1 then
			table.insert(var_14_0, function(arg_15_0)
				pg.NewStoryMgr.GetInstance():Play(var_14_1, arg_15_0)

				return
			end)
		end

		seriesAsync(var_14_0, function()
			self:openReadyPage()

			return
		end)

		return
	end, SFX_PANEL)

	self.stageIndex = 0

	local var_9_2 = pg.mini_game[self:GetMGData().id].simple_config_data.drop
	local var_9_3 = var_9_0:Find("side_panel/award/content")

	self.itemList = UIItemList.New(var_9_3, var_9_3:GetChild(0))

	self.itemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_17_2:Find("IconTpl")
			local var_17_1 = {}

			var_17_1.type, var_17_1.id, var_17_1.count = unpack(var_9_2[arg_17_1])

			updateDrop(var_17_0, var_17_1)
			onButton(self, var_17_0, function()
				self:emit(NenjuuMiniGameView.ON_DROP, var_17_1)

				return
			end, SFX_PANEL)
			onToggle(self, arg_17_2, function(arg_19_0)
				if arg_19_0 then
					self.stageIndex = arg_17_1
				end

				return
			end)
		end

		return
	end)
	self.itemList:align(#var_9_2)
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

	local var_9_4 = self.rtTitlePage:Find("exit")

	onButton(self, var_9_4:Find("window/btn_cancel"), function()
		self:openUI()
		self.gameController:ResumeGame()

		return
	end, SFX_CANCEL)
	onButton(self, var_9_4:Find("window/btn_confirm"), function()
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

function NenjuuMiniGameView:initLeveUI()
	self.rtLevel = self._tf:Find("LevelPage")

	local var_25_0 = self.rtLevel:Find("Opreation")

	onButton(self, var_25_0:Find("btn_back"), function()
		setActive(var_25_0, false)

		return
	end, SFX_CANCEL)

	return
end

local var_0_1 = {
	bomb = {
		"2023spring_minigame_item_firecracker"
	},
	lantern = {
		"2023spring_minigame_item_lantern"
	},
	ice = {
		"2023spring_minigame_skill_icewall",
		"2023spring_minigame_skill_icewall_up"
	},
	flash = {
		"2023spring_minigame_skill_flash",
		"2023spring_minigame_skill_flash_up"
	},
	rush = {
		"2023spring_minigame_skill_sprint",
		"2023spring_minigame_skill_sprint_up"
	},
	blessing = {
		"2023spring_minigame_bless_speed",
		"2023spring_minigame_bless_speed_up"
	},
	decoy = {
		"2023spring_minigame_bless_substitute",
		"2023spring_minigame_bless_substitute_up"
	}
}

function NenjuuMiniGameView:UpdateOpreationPage(arg_27_1)
	local var_27_0 = self.rtLevel:Find("Opreation")
	local var_27_1 = self:GetMGData():GetRuntimeData("elements")

	var_27_1 = var_27_1 or {}

	local var_27_2 = NenjuuGameConfig.ParsingElements(var_27_1)

	setText(var_27_0:Find("point/Text"), var_27_2.count)

	local var_27_3
	local var_27_4 = var_27_0:Find("main/view/content")
	local var_27_5 = UIItemList.New(var_27_4, var_27_4:Find("tpl"))

	var_27_5:make(function(arg_28_0, arg_28_1, arg_28_2)
		arg_28_1 = arg_28_1 + 1

		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_27_3[arg_28_1]

			setActive(arg_28_2:Find("empty"), not var_27_3[arg_28_1])
			setActive(arg_28_2:Find("info"), var_28_0)

			if var_28_0 then
				local var_28_1 = arg_28_2:Find("info")

				eachChild(var_28_1:Find("icon"), function(arg_29_0)
					setActive(arg_29_0, arg_29_0.name == var_28_0)

					return
				end)

				local var_28_2 = string.split(i18n(var_0_1[var_28_0][1]), "|")

				setText(var_28_1:Find("name/Text"), var_28_2[1])
				setText(var_28_1:Find("desc"), var_28_2[2])
				setActive(var_28_1:Find("level"), var_0_1[var_28_0][2])

				if var_0_1[var_28_0][2] then
					local var_28_3 = string.split(i18n(var_0_1[var_28_0][2]), "|")

					for iter_28_0 = 1, 3 do
						local var_28_4 = var_28_1:Find("level/" .. iter_28_0)

						setActive(var_28_4, var_28_3[iter_28_0])

						if var_28_3[iter_28_0] then
							setTextColor(var_28_4:Find("Text"), Color.NewHex(iter_28_0 > var_27_2.level[var_28_0] and "8D90AFFF" or "535885FF"))
							changeToScrollText(var_28_4:Find("info"), setColorStr(var_28_3[iter_28_0], iter_28_0 > var_27_2.level[var_28_0] and "#8D90AFFF" or "#535885FF"))
						end
					end
				end

				eachChild(var_28_1:Find("status"), function(arg_30_0)
					setActive(arg_30_0, false)

					return
				end)
				onButton(self, var_28_1:Find("status/btn_equip"), function()
					var_27_2.item = var_28_0

					self:SaveDataChange(var_27_2)
					self:UpdateOpreationPage(arg_27_1)

					return
				end, SFX_CONFIRM)
				onButton(self, var_28_1:Find("status/btn_unlock"), function()
					var_27_2.count = var_27_2.count - NenjuuGameConfig.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_2.level[var_28_0] + 1]
					var_27_2.level[var_28_0] = var_27_2.level[var_28_0] + 1

					if var_27_2.level[var_28_0] > 1 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("2023spring_minigame_tip7", var_28_2[1]))
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("2023spring_minigame_tip6", var_28_2[1]))
					end

					self:SaveDataChange(var_27_2)
					self:UpdateOpreationPage(arg_27_1)

					return
				end, SFX_CONFIRM)

				if var_27_2.level[var_28_0] < #NenjuuGameConfig.SKILL_LEVEL_CONFIG[var_28_0].cost then
					if NenjuuGameConfig.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_2.level[var_28_0] + 1] > var_27_2.count then
						setText(var_28_1:Find("status/btn_lock/point"), NenjuuGameConfig.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_2.level[var_28_0] + 1])
						setText(var_28_1:Find("status/btn_lock/Text"), i18n("2023spring_minigame_tip3"))
						setActive(var_28_1:Find("status/btn_lock"), true)
					else
						setText(var_28_1:Find("status/btn_unlock/point"), NenjuuGameConfig.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_2.level[var_28_0] + 1])
						setText(var_28_1:Find("status/btn_unlock/Text"), i18n("2023spring_minigame_tip3"))
						setActive(var_28_1:Find("status/btn_unlock"), true)
					end
				elseif var_28_0 == "bomb" or var_28_0 == "lantern" then
					setText(var_28_1:Find("status/btn_equip/Text"), i18n("2023spring_minigame_tip1"))
					setActive(var_28_1:Find("status/btn_equip"), var_27_2.item ~= var_28_0)
					setText(var_28_1:Find("status/btn_in/Text"), i18n("2023spring_minigame_tip2"))
					setActive(var_28_1:Find("status/btn_in"), var_27_2.item == var_28_0)
				else
					setActive(var_28_1:Find("status/unlock"), true)
				end
			end
		end

		return
	end)

	for iter_27_0, iter_27_1 in ipairs({
		{
			"bomb",
			"lantern"
		},
		{
			"ice",
			"flash",
			"rush"
		},
		{
			"blessing",
			"decoy"
		}
	}) do
		onToggle(self, var_27_0:Find("toggles/" .. iter_27_0), function(arg_33_0)
			arg_27_1 = iter_27_0
			var_27_3 = iter_27_1

			var_27_5:align(4)
			setActive(var_27_0:Find("main/tip"), iter_27_0 == 1)

			return
		end, SFX_PANEL)
	end

	triggerToggle(var_27_0:Find("toggles/" .. arg_27_1), true)

	return
end

local function var_0_2(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in ipairs(NenjuuGameConfig.ABILITY_LIST) do
		if arg_34_0[iter_34_1] then
			arg_34_1 = arg_34_1 + arg_34_2[iter_34_1]
		end
	end

	return arg_34_1
end

function NenjuuMiniGameView:openReadyPage()
	local var_35_0 = self:GetMGData():GetRuntimeData("elements")

	var_35_0 = var_35_0 or {}

	local var_35_1 = NenjuuGameConfig.ParsingElements(var_35_0)
	local var_35_2 = NenjuuGameConfig.GetStageConfig("Spring23Level_" .. self.stageIndex)

	self.abilityCache[self.stageIndex] = self.abilityCache[self.stageIndex] or setmetatable({}, {
		__index = var_35_2.ability_config
	})

	setActive(self.rtLevel:Find("Ready"), true)
	onButton(self, self.rtLevel:Find("Ready/bg"), function()
		setActive(self.rtLevel:Find("Ready"), false)

		return
	end, SFX_CANCEL)

	local var_35_3 = self.rtLevel:Find("Ready/main")

	eachChild(var_35_3:Find("title"), function(arg_37_0)
		setActive(arg_37_0, arg_37_0.name == tostring(self.stageIndex))

		return
	end)
	setText(var_35_3:Find("rate/Image/Text"), var_0_2(self.abilityCache[self.stageIndex], var_35_2.base_rate, var_35_2.ability_rate))
	setText(var_35_3:Find("high/Image/Text"), var_35_1["stage_" .. self.stageIndex])
	setText(var_35_3:Find("ability_text/Text"), i18n("2023spring_minigame_tip5"))

	local var_35_4 = underscore.filter(NenjuuGameConfig.ABILITY_LIST, function(arg_38_0)
		return self.abilityCache[self.stageIndex][arg_38_0]
	end)
	local var_35_5 = UIItemList.New(var_35_3:Find("abilitys"), var_35_3:Find("abilitys/tpl"))

	var_35_5:make(function(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1 = arg_39_1 + 1

		if arg_39_0 == UIItemList.EventUpdate then
			setActive(arg_39_2:Find("empty"), not var_35_4[arg_39_1])
			setActive(arg_39_2:Find("enable"), var_35_4[arg_39_1])

			if var_35_4[arg_39_1] then
				eachChild(arg_39_2:Find("enable"), function(arg_40_0)
					setActive(arg_40_0, arg_40_0.name == var_35_4[arg_39_1])

					return
				end)
			end
		end

		return
	end)
	var_35_5:align(#NenjuuGameConfig.ABILITY_LIST)
	onButton(self, var_35_3:Find("btn_rate"), function()
		setActive(self.rtLevel:Find("Ready"), false)
		self:openRatePage()

		return
	end, SFX_PANEL)
	onButton(self, var_35_3:Find("btn_continue"), function()
		setActive(self.rtLevel:Find("Ready"), false)
		self.gameController:ResetGame()

		local var_42_0 = {
			index = self.stageIndex
		}
		local var_42_1 = self:GetMGData():GetRuntimeData("elements")

		var_42_1 = var_42_1 or {}
		var_42_0.FuShun = NenjuuGameConfig.ParsingElements(var_42_1)
		var_42_0.Nenjuu = self.abilityCache[self.stageIndex]
		var_42_0.rate = var_0_2(self.abilityCache[self.stageIndex], var_35_2.base_rate, var_35_2.ability_rate)

		self.gameController:ReadyGame(var_42_0)
		self:openUI("countdown")

		return
	end, SFX_CONFIRM)

	return
end

function NenjuuMiniGameView:openRatePage()
	local var_43_0 = self:GetMGData():GetRuntimeData("elements")

	var_43_0 = var_43_0 or {}

	local var_43_1 = NenjuuGameConfig.ParsingElements(var_43_0)
	local var_43_2 = NenjuuGameConfig.GetStageConfig("Spring23Level_" .. self.stageIndex)

	self.abilityCache[self.stageIndex] = self.abilityCache[self.stageIndex] or setmetatable({}, {
		__index = var_43_2.ability_config
	})

	setActive(self.rtLevel:Find("Rate"), true)
	onButton(self, self.rtLevel:Find("Rate/bg"), function()
		setActive(self.rtLevel:Find("Rate"), false)
		self:openReadyPage()

		return
	end, SFX_CANCEL)

	local var_43_3 = self.rtLevel:Find("Rate/main/panel")
	local var_43_4 = var_0_2(self.abilityCache[self.stageIndex], var_43_2.base_rate, var_43_2.ability_rate)

	setText(var_43_3:Find("info/rate/Text"), var_43_4)

	local var_43_5 = underscore.filter(NenjuuGameConfig.ABILITY_LIST, function(arg_45_0)
		return self.abilityCache[self.stageIndex][arg_45_0] ~= nil
	end)
	local var_43_6 = var_43_3:Find("view/content")
	local var_43_7 = UIItemList.New(var_43_6, var_43_6:Find("tpl"))

	var_43_7:make(function(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1 = arg_46_1 + 1

		if arg_46_0 == UIItemList.EventUpdate then
			local var_46_0 = var_43_5[arg_46_1]

			setActive(arg_46_2:Find("empty"), not var_43_5[arg_46_1])
			setActive(arg_46_2:Find("enable"), var_43_5[arg_46_1])

			if var_43_5[arg_46_1] then
				local var_46_1 = arg_46_2:Find("enable")

				eachChild(var_46_1:Find("icon"), function(arg_47_0)
					setActive(arg_47_0, arg_47_0.name == var_46_0)

					return
				end)

				local var_46_2 = string.split(i18n("2023spring_minigame_nenjuu_skill" .. table.indexof(NenjuuGameConfig.ABILITY_LIST, var_43_5[arg_46_1])), "|")

				setText(var_46_1:Find("name/Text"), var_46_2[1])
				setText(var_46_1:Find("desc"), var_46_2[2])
				onToggle(self, var_46_1:Find("toggle"), function(arg_48_0)
					self.abilityCache[self.stageIndex][var_46_0] = arg_48_0

					local var_48_0 = var_0_2(self.abilityCache[self.stageIndex], var_43_2.base_rate, var_43_2.ability_rate) - var_43_4

					setText(var_43_3:Find("info/delta"), (var_48_0 < 0 and "" or "+") .. var_48_0)

					return
				end)
				triggerToggle(var_46_1:Find("toggle"), self.abilityCache[self.stageIndex][var_43_5[arg_46_1]])
			end
		end

		return
	end)
	var_43_7:align(math.min(#var_43_5 + 1, #NenjuuGameConfig.ABILITY_LIST))

	return
end

function NenjuuMiniGameView:initControllerUI()
	local var_49_0 = self._tf:Find("Controller/top")

	onButton(self, var_49_0:Find("btn_back"), function()
		self:openUI("exit")

		return
	end, SFX_PANEL)
	onButton(self, var_49_0:Find("btn_pause"), function()
		self:openUI("pause")

		return
	end)

	return
end

function NenjuuMiniGameView:SaveDataChange(arg_52_1)
	local var_52_0 = {}

	table.insert(var_52_0, arg_52_1.high)
	table.insert(var_52_0, arg_52_1.count)
	table.insert(var_52_0, arg_52_1.item and table.indexof(NenjuuGameConfig.ITEM_LIST, arg_52_1.item) or 0)

	for iter_52_0 = 1, 7 do
		table.insert(var_52_0, arg_52_1["stage_" .. iter_52_0])
	end

	for iter_52_1, iter_52_2 in ipairs({
		"bomb",
		"lantern",
		"ice",
		"flash",
		"rush",
		"blessing",
		"decoy"
	}) do
		table.insert(var_52_0, arg_52_1.level[iter_52_2])
	end

	self:StoreDataToServer(var_52_0)

	return
end

function NenjuuMiniGameView:didEnter()
	self:initPageUI()
	self:initLeveUI()
	self:initControllerUI()

	self.abilityCache = {}
	self.gameController = NenjuuGameController.New(self, self._tf)

	self:openUI("main")

	return
end

function NenjuuMiniGameView:onBackPressed()
	switch(self.status, {
		main = function()
			if isActive(self.rtLevel:Find("Opreation")) then
				triggerButton(self.rtLevel:Find("Opreation/btn_back"))

				return
			end

			if isActive(self.rtLevel:Find("Ready")) then
				triggerButton(self.rtLevel:Find("Ready/bg"))

				return
			end

			if isActive(self.rtLevel:Find("Rate")) then
				triggerButton(self.rtLevel:Find("Rate/bg"))

				return
			end

			NenjuuMiniGameView.super.onBackPressed(self)

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
	}, function()
		assert(self.gameController.isStart)
		self:openUI("pause")

		return
	end)

	return
end

function NenjuuMiniGameView:willExit()
	return
end

return NenjuuMiniGameView
