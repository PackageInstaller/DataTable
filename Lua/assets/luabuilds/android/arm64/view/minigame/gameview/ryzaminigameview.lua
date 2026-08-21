local var_0_0 = class("RyzaMiniGameView", import("view.miniGame.BaseMiniGameView"))

var_0_0.EVENT_CREATE = "RyzaMiniGameView.EVENT_CREATE"
var_0_0.EVENT_DESTROY = "RyzaMiniGameView.EVENT_DESTROY"
var_0_0.EVENT_FINISH = "RyzaMiniGameView.EVENT_FINISH"
var_0_0.EVENT_WINDOW_FOCUS = "RyzaMiniGameView.EVENT_WINDOW_FOCUS"
var_0_0.EVENT_STATUS_SYNC = "RyzaMiniGameView.EVENT_STATUS_SYNC"
var_0_0.EVENT_UPDATE_HIDE = "RyzaMiniGameView.EVENT_UPDATE_HIDE"

function var_0_0.getUIName(arg_1_0)
	return "RyzaMiniGameUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initTimer()
	arg_2_0:initUI()
	arg_2_0:initGameUI()
	onNextTick(function()
		arg_2_0:openUI("main")

		return
	end)

	return
end

local function var_0_1(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs((arg_4_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_4_1.speed = arg_4_1
	end

	return
end

function var_0_0.openUI(arg_5_0, arg_5_1)
	if arg_5_0.status then
		setActive(arg_5_0.rtTitlePage:Find(arg_5_0.status), false)
	end

	if arg_5_1 then
		setActive(arg_5_0.rtTitlePage:Find(arg_5_1), true)
	end

	arg_5_0.status = arg_5_1

	switch(arg_5_1, {
		main = function()
			arg_5_0:updateMainUI()

			return
		end,
		pause = function()
			arg_5_0:pauseGame()

			return
		end,
		exit = function()
			arg_5_0:pauseGame()

			return
		end,
		result = function()
			local var_9_0 = arg_5_0:GetMGData():GetRuntimeData("elements")
			local var_9_1 = arg_5_0.scoreNum

			if var_9_0 and #var_9_0 > 0 then
				local var_9_2 = var_9_0[1] or 0
				local var_9_3 = arg_5_0.rtTitlePage:Find("result")

				setActive(var_9_3:Find("window/now/new"), var_9_2 < var_9_1)

				if var_9_2 <= var_9_1 then
					var_9_2 = var_9_1

					arg_5_0:StoreDataToServer({
						var_9_1
					})
				end

				setText(var_9_3:Find("window/high/Text"), var_9_2)
				setText(var_9_3:Find("window/now/Text"), var_9_1)

				local var_9_4 = arg_5_0:GetMGHubData()

				if arg_5_0.stageIndex == var_9_4.usedtime + 1 and var_9_4.count > 0 then
					arg_5_0:SendSuccess(0)
				end

				return
			end
		end
	})

	return
end

function var_0_0.updateMainUI(arg_10_0)
	local var_10_0 = arg_10_0:GetMGHubData()
	local var_10_1 = var_10_0:getConfig("reward_need")
	local var_10_2 = var_10_0.usedtime
	local var_10_3 = var_10_0.usedtime + var_10_0.count
	local var_10_4 = var_10_0.usedtime == var_10_1 and 8 or math.min(var_10_0.usedtime + 1, var_10_3)
	local var_10_5 = arg_10_0.itemList.container

	for iter_10_0 = 1, arg_10_0.itemList.container.childCount do
		local var_10_6 = {}

		if iter_10_0 <= var_10_2 then
			var_10_6.finish = true
		elseif iter_10_0 <= var_10_3 then
			-- block empty
		elseif var_10_2 == var_10_1 then
			var_10_6.finish = false
			var_10_6.lock = false
		else
			var_10_6.lock = true
		end

		local var_10_7 = var_10_5:GetChild(iter_10_0 - 1)

		setActive(var_10_7:Find("finish"), var_10_6.finish)
		setActive(var_10_7:Find("lock"), var_10_6.lock)
		setToggleEnabled(var_10_7, iter_10_0 <= var_10_4)
		triggerToggle(var_10_7, iter_10_0 == var_10_4)
	end

	local var_10_8 = var_10_5:GetComponent(typeof(ScrollRect)).viewport.rect.height

	scrollTo(var_10_5, nil, 1 - math.clamp(var_10_5:GetChild(0).anchoredPosition.y - var_10_5:GetChild(var_10_4 - 1).anchoredPosition.y, 0, var_10_5.rect.height - var_10_8) / (var_10_5.rect.height - var_10_8))
	setActive(arg_10_0.rtTitlePage:Find("main/tip/Image"), var_10_2 == var_10_1)
	arg_10_0:checkGet()

	if var_10_2 == 1 and var_10_4 == 2 then
		if PlayerPrefs.GetInt("ryza_minigame_guide", 0) == 0 then
			scrollTo(var_10_5, nil, 1)
			pg.NewGuideMgr.GetInstance():Play("Ryza_MiniGame")
			PlayerPrefs.SetInt("ryza_minigame_guide", 1)
		end
	elseif PlayerPrefs.GetInt("ryza_minigame_help", 0) == 0 then
		triggerButton(arg_10_0.rtTitlePage:Find("main/btn_rule"))
	end

	return
end

function var_0_0.checkGet(arg_11_0)
	local var_11_0 = arg_11_0:GetMGHubData()

	if var_11_0.ultimate == 0 then
		if var_11_0.usedtime < var_11_0:getConfig("reward_need") then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_11_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function var_0_0.initUI(arg_12_0)
	arg_12_0.rtTitlePage = arg_12_0._tf:Find("TitlePage")

	local var_12_0 = arg_12_0.rtTitlePage:Find("main")

	onButton(arg_12_0, var_12_0:Find("btn_back"), function()
		arg_12_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, var_12_0:Find("btn_rule"), function()
		PlayerPrefs.SetInt("ryza_minigame_help", 1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_mini_game.tip
		})

		return
	end, SFX_PANEL)

	local var_12_1 = arg_12_0:GetMGData():GetSimpleValue("story")

	onButton(arg_12_0, var_12_0:Find("btn_start"), function()
		if checkExist(var_12_1, {
			arg_12_0.stageIndex
		}, {
			1
		}) then
			table.insert({}, function(arg_16_0)
				pg.NewStoryMgr.GetInstance():Play(var_0, arg_16_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_12_0:readyStart()

			return
		end)

		return
	end, SFX_CONFIRM)

	arg_12_0.stageIndex = 0

	local var_12_2 = pg.mini_game[arg_12_0:GetMGData().id].simple_config_data.drop_ids
	local var_12_3 = var_12_0:Find("side_panel/award/content")

	arg_12_0.itemList = UIItemList.New(var_12_3, var_12_3:GetChild(0))

	arg_12_0.itemList:make(function(arg_18_0, arg_18_1, arg_18_2)
		arg_18_1 = arg_18_1 + 1

		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = arg_18_2:Find("IconTpl")
			local var_18_1 = {}

			var_18_1.type, var_18_1.id, var_18_1.count = unpack(var_12_2[arg_18_1])

			updateDrop(var_18_0, {})
			onButton(arg_12_0, var_18_0, function()
				arg_12_0:emit(var_0_0.ON_DROP, var_18_1)

				return
			end, SFX_PANEL)
			onToggle(arg_12_0, arg_18_2, function(arg_20_0)
				if arg_20_0 then
					arg_12_0.stageIndex = arg_18_1
				end

				return
			end)
		end

		return
	end)
	arg_12_0.itemList:align(#pg.mini_game[arg_12_0:GetMGData().id].simple_config_data.drop_ids)

	local var_12_4 = arg_12_0:GetMGHubData():getConfig("reward_need")

	setActive(var_12_3:GetChild(var_12_4), true)
	onToggle(arg_12_0, var_12_3:GetChild(var_12_4), function(arg_21_0)
		if arg_21_0 then
			arg_12_0.stageIndex = 0
		end

		return
	end)
	arg_12_0.rtTitlePage:Find("countdown"):Find("bg/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_12_0:openUI()
		arg_12_0:startGame()

		return
	end)
	onButton(arg_12_0, arg_12_0.rtTitlePage:Find("pause"):Find("window/btn_confirm"), function()
		arg_12_0:openUI()
		arg_12_0:resumeGame()

		return
	end, SFX_CONFIRM)

	local var_12_5 = arg_12_0.rtTitlePage:Find("exit")

	onButton(arg_12_0, var_12_5:Find("window/btn_cancel"), function()
		arg_12_0:openUI()
		arg_12_0:resumeGame()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, var_12_5:Find("window/btn_confirm"), function()
		arg_12_0:openUI()
		arg_12_0:resumeGame()
		arg_12_0:endGame()

		return
	end, SFX_CONFIRM)
	onButton(arg_12_0, arg_12_0.rtTitlePage:Find("result"):Find("window/btn_finish"), function()
		setActive(arg_12_0._tf:Find("Viewport"), false)
		arg_12_0:openUI("main")
		pg.BgmMgr.GetInstance():Push(arg_12_0.__cname, "ryza-5")

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.initGameUI(arg_27_0)
	arg_27_0.uiMgr = pg.UIMgr.GetInstance()
	arg_27_0.rtResource = arg_27_0._tf:Find("Resource")
	arg_27_0.rtMain = arg_27_0._tf:Find("Viewport/MainContent")
	arg_27_0.rtPlane = arg_27_0.rtMain:Find("plane")
	arg_27_0.sprites = {}

	eachChild(arg_27_0.rtPlane, function(arg_28_0)
		arg_27_0.sprites[arg_28_0.name] = getImageSprite(arg_28_0)

		return
	end)

	arg_27_0.rtController = arg_27_0._tf:Find("Controller")
	arg_27_0.rtJoyStick = arg_27_0.rtController:Find("bottom/handle_stick")

	onButton(arg_27_0, arg_27_0.rtController:Find("bottom/btn_bomb"), function()
		arg_27_0.responder:RyzaBomb()

		return
	end)

	arg_27_0.rtScore = arg_27_0.rtController:Find("top/title/SCORE/Text")
	arg_27_0.rtTime = arg_27_0.rtController:Find("top/title/TIME/Text")

	onButton(arg_27_0, arg_27_0.rtController:Find("top/btn_back"), function()
		arg_27_0:openUI("exit")

		return
	end, SFX_PANEL)
	onButton(arg_27_0, arg_27_0.rtController:Find("top/btn_pause"), function()
		arg_27_0:openUI("pause")

		return
	end, SFX_PANEL)

	arg_27_0.rtStatus = arg_27_0.rtController:Find("bottom/status")
	arg_27_0.rtRyzaHP = arg_27_0.rtController:Find("top/title/HP/heart")
	arg_27_0.rtControllerUI = arg_27_0.rtController:Find("UI")

	eachChild(arg_27_0.rtControllerUI, function(arg_32_0)
		arg_27_0["tplUI" .. arg_32_0.name] = arg_32_0

		setActive(arg_32_0, false)

		return
	end)

	arg_27_0.responder = Responder.New(arg_27_0)

	arg_27_0:bind(var_0_0.EVENT_CREATE, function(arg_33_0, ...)
		arg_27_0:CreateReactor(...)

		return
	end)
	arg_27_0:bind(var_0_0.EVENT_DESTROY, function(arg_34_0, ...)
		arg_27_0:DestroyReactor(...)

		return
	end)
	arg_27_0:bind(var_0_0.EVENT_FINISH, function(arg_35_0, arg_35_1)
		arg_27_0:endGame(arg_35_1)

		return
	end)
	arg_27_0:bind(var_0_0.EVENT_WINDOW_FOCUS, function(arg_36_0, arg_36_1)
		setAnchoredPosition(arg_27_0.rtMain, {
			x = math.clamp(-arg_36_1.x, -arg_27_0.buffer.x, arg_27_0.buffer.x),
			y = math.clamp(-arg_36_1.y, -arg_27_0.buffer.y - 48, arg_27_0.buffer.y - 48)
		})

		return
	end)
	arg_27_0:bind(var_0_0.EVENT_STATUS_SYNC, function(arg_37_0, ...)
		arg_27_0:updateControllerStatus(...)
		arg_27_0:popRyzaUI(...)

		return
	end)
	arg_27_0:bind(var_0_0.EVENT_UPDATE_HIDE, function(arg_38_0, arg_38_1, arg_38_2)
		if isa(arg_38_1, MoveEnemy) then
			GetOrAddComponent(arg_27_0.reactorUIs[arg_38_1], typeof(CanvasGroup)).alpha = arg_38_2 and 0 or 1
		end

		return
	end)

	return
end

function var_0_0.initTimer(arg_39_0)
	arg_39_0.timer = Timer.New(function()
		arg_39_0:onTimer()

		return
	end, RyzaMiniGameConfig.TIME_INTERVAL, -1)

	return
end

function var_0_0.readyStart(arg_41_0)
	arg_41_0:resetGame()
	setActive(arg_41_0._tf:Find("Viewport"), true)
	var_0_1(arg_41_0.rtMain, 1)
	arg_41_0:initConfig()
	arg_41_0:buildMap()
	arg_41_0:initController()
	arg_41_0:openUI("countdown")

	return
end

function var_0_0.startGame(arg_42_0)
	pg.BgmMgr.GetInstance():Push(arg_42_0.__cname, "ryza-az-battle")

	arg_42_0.gameStartFlag = true

	arg_42_0:startTimer()

	return
end

function var_0_0.endGame(arg_43_0, arg_43_1)
	if arg_43_1 then
		arg_43_0.scoreNum = arg_43_0.scoreNum + RyzaMiniGameConfig.GetPassGamePoint(arg_43_0.countTime)

		setText(arg_43_0.rtScore, arg_43_0.scoreNum)
	end

	arg_43_0.gameEndFlag = true

	arg_43_0:stopTimer()
	arg_43_0:openUI("result")

	return
end

function var_0_0.pauseGame(arg_44_0)
	arg_44_0.gamePause = true

	arg_44_0:stopTimer()
	arg_44_0:pauseManagedTween()

	return
end

function var_0_0.resumeGame(arg_45_0)
	arg_45_0.gamePause = false

	arg_45_0:startTimer()
	arg_45_0:resumeManagedTween()

	return
end

function var_0_0.resetGame(arg_46_0)
	arg_46_0.gameStartFlag = false
	arg_46_0.gamePause = false
	arg_46_0.gameEndFlag = false
	arg_46_0.scoreNum = 0
	arg_46_0.countTime = 0

	arg_46_0.responder:reset()

	if arg_46_0.reactorUIs then
		for iter_46_0, iter_46_1 in pairs(arg_46_0.reactorUIs) do
			Destroy(iter_46_1)
		end
	end

	arg_46_0.reactorUIs = {}

	return
end

function var_0_0.initConfig(arg_47_0)
	local var_47_0 = arg_47_0.stageIndex == 0 and math.random(7) or arg_47_0.stageIndex
	local var_47_1 = 0
	local var_47_2 = underscore.rest(RyzaMiniGameConfig.ENEMY_TYPE_LIST, 1)
	local var_47_3 = {}
	local var_47_4 = pg.MiniGameTileMgr.GetInstance():getDataLayers("BoomGame", "BoomLevel_" .. var_47_0)

	arg_47_0.config = {}
	arg_47_0.config.mapSize = NewPos(var_47_4[1].width, var_47_4[1].height)
	arg_47_0.config.reactorList = {}

	for iter_47_0, iter_47_1 in ipairs(var_47_4) do
		for iter_47_2, iter_47_3 in ipairs(iter_47_1.layer) do
			if iter_47_3.item then
				local var_47_5 = {
					name = iter_47_3.item
				}

				if arg_47_0.stageIndex == 0 and isa(RyzaMiniGameConfig.CreateInfo(var_47_5.name), TargetMove) then
					if var_47_5.name == "Ryza" then
						-- block empty
					else
						local var_47_6 = math.random(#var_47_2)

						if string.find(var_47_2[var_47_6], "BOSS_") then
							var_47_5.name = table.remove(var_47_2, var_47_6)
							var_47_1 = var_47_1 + 1

							if var_47_1 == RyzaMiniGameConfig.FREE_MAP_BOSS_LIMIT[var_47_0] then
								while string.find(var_47_2[#var_47_2], "BOSS_") do
									table.remove(var_47_2)
								end
							end
						else
							var_47_5.name = var_47_2[var_47_6]
						end

						table.insert(var_47_3, #arg_47_0.config.reactorList + 1)
					end
				elseif iter_47_3.prop then
					for iter_47_4, iter_47_5 in pairs(iter_47_3.prop) do
						var_47_5[iter_47_4] = iter_47_5
					end
				end

				var_47_5.pos = {
					(iter_47_3.index - 1) % arg_47_0.config.mapSize.x,
					math.floor((iter_47_3.index - 1) / arg_47_0.config.mapSize.x)
				}

				table.insert(arg_47_0.config.reactorList, var_47_5)
			end
		end
	end

	if arg_47_0.stageIndex == 0 and var_47_1 == 0 then
		local var_47_7 = math.random(#var_47_3)

		arg_47_0.config.reactorList[var_47_7] = {
			name = "BOSS_" .. arg_47_0.config.reactorList[var_47_7].name,
			pos = arg_47_0.config.reactorList[var_47_7].pos
		}
	end

	return
end

function var_0_0.buildMap(arg_48_0)
	setSizeDelta(arg_48_0.rtMain, arg_48_0.config.mapSize * 32)
	eachChild(arg_48_0.rtMain:Find("bg/NW"), function(arg_49_0)
		setActive(arg_49_0, arg_49_0.name == tostring(math.floor((arg_48_0.stageIndex - 1) % 8 / 2) + 1))

		return
	end)

	local var_48_0 = arg_48_0._tf:Find("Viewport").rect

	arg_48_0.buffer = NewPos(math.max(arg_48_0.rtMain.rect.width + 0 - var_48_0.width, 0), math.max(arg_48_0.rtMain.rect.height + 160 - var_48_0.height, 0)) * 0.5

	local var_48_2 = arg_48_0.config.mapSize.y
	local var_48_3 = UIItemList.New(arg_48_0.rtPlane, arg_48_0.rtPlane:GetChild(0))

	var_48_3:make(function(arg_50_0, arg_50_1, arg_50_2)
		if arg_50_0 == UIItemList.EventUpdate then
			arg_50_2.name = arg_50_1 % var_48_2 .. "_" .. math.floor(arg_50_1 / var_48_2)

			if math.random() < RyzaMiniGameConfig.GRASS_CHAGNE_RATE then
				setImageAlpha(arg_50_2, 1)
				setImageSprite(arg_50_2, arg_48_0.sprites["Grass_" .. 3 + math.random(3)])
			else
				setImageAlpha(arg_50_2, 0)
			end
		end

		return
	end)
	var_48_3:align(arg_48_0.config.mapSize.x * arg_48_0.config.mapSize.y)
	arg_48_0:soilMapPartition(Vector2.zero, arg_48_0.config.mapSize)

	for iter_48_0, iter_48_1 in ipairs(arg_48_0.config.reactorList) do
		arg_48_0:CreateReactor(iter_48_1)
	end

	return
end

function var_0_0.initController(arg_51_0)
	setText(arg_51_0.rtScore, arg_51_0.scoreNum)
	setText(arg_51_0.rtTime, string.format("%02d:%02d", math.floor(arg_51_0.countTime / 60), math.floor(arg_51_0.countTime % 60)))
	arg_51_0:updateControllerStatus(arg_51_0.responder.reactorRyza, "hp", {
		num = arg_51_0.responder.reactorRyza.hp
	})
	arg_51_0:updateControllerStatus(arg_51_0.responder.reactorRyza, "bomb", {
		num = arg_51_0.responder.reactorRyza.bomb
	})
	arg_51_0:updateControllerStatus(arg_51_0.responder.reactorRyza, "power", {
		num = arg_51_0.responder.reactorRyza.power
	})
	arg_51_0:updateControllerStatus(arg_51_0.responder.reactorRyza, "speed", {
		num = arg_51_0.responder.reactorRyza.speed
	})

	return
end

function var_0_0.updateControllerStatus(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if isa(arg_52_1, MoveRyza) then
		if arg_52_2 == "hp" then
			eachChild(arg_52_0.rtRyzaHP, function(arg_53_0)
				setActive(arg_53_0:Find("active"), tonumber(arg_53_0.name) <= arg_52_3.num)

				return
			end)
		else
			eachChild(arg_52_0.rtStatus:Find(string.upper(arg_52_2) .. "/bit"), function(arg_54_0)
				setActive(arg_54_0, tonumber(arg_54_0.name) <= arg_52_3.num)

				return
			end)
		end
	elseif isa(arg_52_1, MoveEnemy) then
		setSlider(arg_52_0.reactorUIs[arg_52_1]:Find("hp"), 0, arg_52_3.max, arg_52_3.num)
	end

	return
end

function var_0_0.popRyzaUI(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if isa(arg_55_1, MoveRyza) then
		if arg_55_2 == "hp" then
			local var_55_1 = var_55_0:Find("pop/hp_" .. (arg_55_3.delta > 0 and "up" or "down"))

			for iter_55_0 = 1, 2 do
				setActive(var_55_1:Find(iter_55_0), iter_55_0 * iter_55_0 == arg_55_3.delta * arg_55_3.delta)
			end

			setActive(var_55_1, false)
			setActive(var_55_1, true)
		else
			local var_55_2 = var_55_0:Find("pop/" .. arg_55_2 .. "_up")

			setActive(var_55_2, false)
			setActive(var_55_2, true)
		end
	end

	return
end

function var_0_0.CreateReactor(arg_56_0, arg_56_1)
	local var_56_0, var_56_1, var_56_2 = RyzaMiniGameConfig.CreateInfo(arg_56_1.name)

	if not var_56_0 then
		warning(arg_56_1.name)

		return
	end

	local var_56_3 = var_56_0.New(arg_56_1, cloneTplTo(arg_56_0.rtResource:Find(var_56_1), arg_56_0.rtMain:Find(var_56_2)), arg_56_0.responder)

	if isa(var_56_3, MoveRyza) then
		arg_56_0.reactorUIs[var_56_3] = cloneTplTo(arg_56_0.tplUIRyza, arg_56_0.rtControllerUI)

		eachChild(arg_56_0.reactorUIs[var_56_3]:Find("pop"), function(arg_57_0)
			arg_57_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				setActive(arg_57_0, false)

				return
			end)

			return
		end)

		arg_56_0.reactorUIs[var_56_3].position = var_56_3._tf.position
	elseif isa(var_56_3, MoveEnemy) then
		arg_56_0.reactorUIs[var_56_3] = cloneTplTo(arg_56_0.tplUIEnemy, arg_56_0.rtControllerUI)

		setAnchoredPosition(arg_56_0.reactorUIs[var_56_3]:Find("hp"), {
			y = var_56_3:GetUIHeight()
		})

		arg_56_0.reactorUIs[var_56_3].position = var_56_3._tf.position
	end

	return
end

function var_0_0.DestroyReactor(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0.reactorUIs[arg_59_1] then
		Destroy(arg_59_0.reactorUIs[arg_59_1])

		arg_59_0.reactorUIs[arg_59_1] = nil
	end

	arg_59_0.scoreNum = arg_59_0.scoreNum + arg_59_2

	setText(arg_59_0.rtScore, arg_59_0.scoreNum)

	return
end

function var_0_0.soilMapPartition(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = RyzaMiniGameConfig.SOIL_RANDOM_CONFIG
	local var_60_1 = math.floor(math.min(arg_60_2.x, arg_60_2.y) * (RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[1] + math.random() * (RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[2] - RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[1])))

	if var_60_1 < 2 then
		return
	end

	local var_60_2 = math.random(4) % 4
	local var_60_3 = arg_60_0
	local var_60_6 = arg_60_1.x

	if var_60_2 % 2 > 0 then
		local var_60_7 = arg_60_2.x - var_60_1 or 0
		local var_60_8 = var_60_6 + var_60_7
		local var_60_9 = arg_60_1.y

		if var_60_2 > 1 then
			local var_60_10 = arg_60_2.y - var_60_1 or 0

			var_60_4(var_60_3, var_60_5(var_60_8, var_60_9 + var_60_10), var_60_1)

			local var_60_11 = var_60_1 + math.ceil((arg_60_2.x - var_60_1) * var_60_0.spacer_rate)
			local var_60_12 = var_60_1 + math.ceil((arg_60_2.y - var_60_1) * var_60_0.spacer_rate)

			if arg_60_2.x > arg_60_2.y then
				arg_60_0:soilMapPartition(NewPos(arg_60_1.x + (var_60_2 % 2 > 0 and 0 or var_60_11), arg_60_1.y), NewPos(arg_60_2.x - var_60_11, arg_60_2.y))

				local var_60_13 = arg_60_0
				local var_60_16 = arg_60_1.x

				if var_60_2 % 2 > 0 then
					local var_60_17 = arg_60_2.x - var_60_1 or 0
					local var_60_18 = var_60_16 + var_60_17

					var_60_14(var_60_13, var_60_15(var_60_18, arg_60_1.y + (var_60_2 > 1 and 0 or var_60_12)), NewPos(var_60_1, arg_60_2.y - var_60_12))

					local var_60_19 = arg_60_0
					local var_60_22 = arg_60_1.x + (var_60_2 % 2 > 0 and 0 or var_60_11)
					local var_60_23 = arg_60_1.y

					goto label_60_0

					::label_60_0::

					if var_60_2 > 1 then
						do
							local var_60_24 = arg_60_2.y - var_60_1 or 0

							var_60_20(var_60_19, var_60_21(var_60_22, var_60_23 + var_60_24), NewPos(arg_60_2.x - var_60_11, var_60_1))
							arg_60_0:soilMapPartition(NewPos(arg_60_1.x, arg_60_1.y + (var_60_2 > 1 and 0 or var_60_12)), NewPos(arg_60_2.x, arg_60_2.y - var_60_12))
						end

						return
					end
				end
			end
		end
	end
end

local var_0_2 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	}
}
local var_0_3 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		1
	},
	{
		1,
		-1
	},
	{
		-1,
		-1
	},
	{
		-1,
		1
	}
}

function var_0_0.dealSoilMap(arg_61_0, arg_61_1, arg_61_2)
	for iter_61_0 = 0, 3 do
		local var_61_1 = {}

		if iter_61_0 % 2 > 0 then
			local var_61_3 = arg_61_2 - 1 or 0

			if iter_61_0 > 1 then
				local var_61_4 = arg_61_2 - 1 or 0

				var_61_0(var_61_1, arg_61_1 + var_61_2(var_61_3, var_61_4))
			end
		end
	end

	local function var_61_5(arg_62_0)
		if arg_62_0.x < arg_61_1.x or arg_62_0.y < arg_61_1.y or arg_62_0.x >= arg_61_1.x + arg_61_2 or arg_62_0.y >= arg_61_1.y + arg_61_2 then
			return false
		else
			return true
		end

		return
	end

	local var_61_6 = {}

	local function var_61_7(arg_63_0)
		local var_63_0 = 0

		for iter_63_0, iter_63_1 in ipairs(var_0_3) do
			local var_63_1 = arg_63_0 + NewPos(unpack(iter_63_1))

			if var_61_5(var_63_1) and defaultValue(var_61_6[var_63_1.x .. "_" .. var_63_1.y], true) then
				var_63_0 = var_63_0 + 1
			end
		end

		return var_63_0
	end

	local var_61_8 = 0
	local var_61_10 = 0

	while var_61_10 < #{} do
		var_61_10 = var_61_10 + 1

		local var_61_11 = ({})[var_61_10]

		var_61_6[({})[var_61_10].x .. "_" .. ({})[var_61_10].y] = false

		if math.random() < RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.cancel_rate[1] + RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.cancel_rate[2] * (1 - var_61_8 / arg_61_2 / arg_61_2) * (1 - var_61_8 / arg_61_2 / arg_61_2) and (function(arg_64_0)
			for iter_64_0, iter_64_1 in ipairs(var_0_3) do
				local var_64_0 = arg_64_0 + NewPos(unpack(iter_64_1))

				if var_61_5(var_64_0) and defaultValue(var_61_6[var_64_0.x .. "_" .. var_64_0.y], true) and not RyzaMiniGameConfig.SOIL_SPRITES_DIC[var_61_7(var_64_0)] then
					return false
				end
			end

			return true
		end)(var_61_11) then
			var_61_8 = var_61_8 + 1
		else
			var_61_6[var_61_11.x .. "_" .. var_61_11.y] = true
		end

		for iter_61_1, iter_61_2 in ipairs(var_0_2) do
			local var_61_12 = var_61_11 + NewPos(unpack(iter_61_2))

			if var_61_5(var_61_12) and var_61_6[var_61_12.x .. "_" .. var_61_12.y] == nil then
				table.insert({}, var_61_12)
			end
		end
	end

	local var_61_13 = arg_61_0.config.mapSize.x

	for iter_61_3 = arg_61_1.x, arg_61_1.x + arg_61_2 - 1 do
		for iter_61_4 = arg_61_1.y, arg_61_1.y + arg_61_2 - 1 do
			if defaultValue(var_61_6[iter_61_3 .. "_" .. iter_61_4], true) then
				local var_61_15 = RyzaMiniGameConfig.SOIL_SPRITES_DIC[(function(arg_63_0)
					local var_63_0 = 0

					for iter_63_0, iter_63_1 in ipairs(var_0_3) do
						local var_63_1 = arg_63_0 + NewPos(unpack(iter_63_1))

						if var_61_5(var_63_1) and defaultValue(var_61_6[var_63_1.x .. "_" .. var_63_1.y], true) then
							var_63_0 = var_63_0 + 1
						end
					end

					return var_63_0
				end)(NewPos(iter_61_3, iter_61_4))]

				assert(var_61_15)

				local var_61_16 = arg_61_0.rtPlane:GetChild(iter_61_4 * var_61_13 + iter_61_3)

				setImageAlpha(var_61_16, 1)
				setImageSprite(var_61_16, arg_61_0.sprites[var_61_15])
			end
		end
	end

	return
end

function var_0_0.startTimer(arg_65_0)
	if not arg_65_0.timer.running then
		arg_65_0.timer:Start()
	end

	arg_65_0.uiMgr:AttachStickOb(arg_65_0.rtJoyStick)
	var_0_1(arg_65_0.rtMain, 1)

	return
end

function var_0_0.stopTimer(arg_66_0)
	if arg_66_0.timer.running then
		arg_66_0.timer:Stop()
	end

	arg_66_0.uiMgr:ClearStick()
	var_0_1(arg_66_0.rtMain, 0)

	return
end

function var_0_0.onTimer(arg_67_0)
	arg_67_0.countTime = arg_67_0.countTime + RyzaMiniGameConfig.TIME_INTERVAL

	setText(arg_67_0.rtTime, string.format("%02d:%02d", math.floor(arg_67_0.countTime / 60), math.floor(arg_67_0.countTime % 60)))
	arg_67_0.responder:TimeFlow(RyzaMiniGameConfig.TIME_INTERVAL)

	for iter_67_0, iter_67_1 in pairs(arg_67_0.reactorUIs) do
		iter_67_1.position = iter_67_0._tf.position
	end

	local var_67_0 = arg_67_0.responder:GetJoyStick()

	if var_67_0.x ~= 0 or var_67_0.y ~= 0 then
		local var_67_1 = RyzaMiniGameConfig.ReSetDir(var_67_0)
		local var_67_2 = arg_67_0.reactorUIs[arg_67_0.responder.reactorRyza]:Find("dir")

		if var_67_1.x == 0 then
			setLocalEulerAngles(var_67_2, {
				z = var_67_1.y > 0 and 270 or 90
			})
		else
			setLocalEulerAngles(var_67_2, {
				z = math.atan2(-var_67_1.y, var_67_1.x) / math.pi * 180
			})
		end
	end

	return
end

function var_0_0.OnApplicationPaused(arg_68_0, arg_68_1)
	if arg_68_1 then
		-- block empty
	end

	return
end

function var_0_0.onBackPressed(arg_69_0)
	switch(arg_69_0.status, {
		main = function()
			var_0_0.super.onBackPressed(arg_69_0)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			arg_69_0:openUI()
			arg_69_0:resumeGame()

			return
		end,
		exit = function()
			arg_69_0:openUI()
			arg_69_0:resumeGame()

			return
		end,
		result = function()
			return
		end
	}, function()
		assert(arg_69_0.gameStartFlag, "game start false")
		arg_69_0:openUI("pause")

		return
	end)

	return
end

function var_0_0.willExit(arg_76_0)
	return
end

return var_0_0
