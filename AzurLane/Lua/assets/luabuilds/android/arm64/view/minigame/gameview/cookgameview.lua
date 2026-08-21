local var_0_0 = class("CookGameView", import("..BaseMiniGameView"))
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_4 = 60
local var_0_6 = 8
local var_0_7 = {
	speed_num = 3,
	char_path = "ui/minigameui/",
	extend_time = 10,
	time_up = 0.5,
	cake_num = 5,
	path = "ui/minigameui/" .. "cookgameui_atlas"
}

var_0_0.CLICK_JUDGE_EVENT = "click judge event"
var_0_0.AC_CAKE_EVENT = "ac cake event"
var_0_0.SERVE_EVENT = "serve event"
var_0_0.EXTEND_EVENT = "extend event"

function var_0_0.getUIName(arg_1_0)
	return "CookGameUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initEvent()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initGameUI()
	arg_2_0:initController()
	arg_2_0:updateMenuUI()
	arg_2_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_3_0)
	arg_3_0.uiCam = arg_3_0.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	arg_3_0:bind(CookGameView.CLICK_JUDGE_EVENT, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_3_0.charController then
			arg_3_0.charController:setJudgeAction(arg_4_1, nil, arg_4_2)
		end

		return
	end)
	arg_3_0:bind(CookGameView.AC_CAKE_EVENT, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_3_0.charController then
			arg_3_0.charController:createAcCake(arg_5_1, arg_5_2)
		end

		return
	end)
	arg_3_0:bind(CookGameView.SERVE_EVENT, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_6_1.serveData.battleData.id
		local var_6_1 = arg_6_1.right
		local var_6_2 = arg_6_1.pos
		local var_6_3 = arg_6_1.rate
		local var_6_5 = arg_6_1.right and 1 or -1
		local var_6_6 = arg_6_1.right and 1 or 0
		local var_6_7 = arg_6_1.serveData.parameter.right_index

		if not arg_6_1.serveData.battleData.weight then
			-- block empty
		end

		if var_6_1 and arg_6_1.serveData.battleData.cake_allow then
			var_6_6 = 3
		end

		if var_6_1 and arg_6_1.serveData.battleData.score_added then
			var_6_5 = var_6_5 + arg_6_1.serveData.parameter.series_right_index - 1
		end

		if arg_6_1.serveData.battleData.random_score then
			var_6_5 = var_6_5 * math.random(1, CookGameConst.random_score)
		end

		local var_6_11 = var_6_5 * var_6_3

		arg_3_0:addScore(var_6_5 * var_6_3, var_6_8)
		arg_3_0:showScore(var_6_11, var_6_2, var_6_6)

		if arg_6_1.serveData.battleData.double_score == 8 then
			if var_6_1 and var_6_7 and var_6_7 % 2 == 0 then
				arg_3_0:addScore(var_6_11, var_6_8)
				LeanTween.delayedCall(go(arg_3_0._tf), 0.5, System.Action(function()
					arg_3_0:showScore(var_6_11, var_6_2, 2)

					return
				end))
			end
		elseif arg_6_1.serveData.battleData.half_double and var_6_1 and math.random() > 0.5 then
			arg_3_0:addScore(var_6_11, var_6_8)
			LeanTween.delayedCall(go(arg_3_0._tf), 0.5, System.Action(function()
				arg_3_0:showScore(var_6_11, var_6_2, 2)

				return
			end))
		end

		return
	end)
	arg_3_0:bind(CookGameView.EXTEND_EVENT, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_3_0.judgesController then
			arg_3_0.judgesController:extend()
		end

		arg_3_0.waitingExtendTime = false
		arg_3_0.extendTime = var_0_7.extend_time
		arg_3_0.gameTime = 0

		return
	end)

	return
end

function var_0_0.showScore(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == 0 then
		return
	end

	local var_10_0

	if #arg_10_0.showScoresPool > 0 then
		var_10_0 = table.remove(arg_10_0.showScoresPool, 1)
	else
		var_10_0 = tf(Instantiate(arg_10_0.showScoreTpl))

		setParent(var_10_0, arg_10_0.sceneFrontContainer)
		GetComponent(findTF(var_10_0, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			for iter_11_0 = #arg_10_0.showScores, 1, -1 do
				if var_10_0 == arg_10_0.showScores[iter_11_0] then
					setActive(var_10_0, false)
					table.insert(arg_10_0.showScoresPool, table.remove(arg_10_0.showScores, iter_11_0))
				end
			end

			return
		end)
	end

	var_10_0.anchoredPosition = arg_10_0.sceneFrontContainer:InverseTransformPoint(arg_10_2)

	setText(findTF(var_10_0, "anim/text_sub"), "" .. tostring(arg_10_1))
	setText(findTF(var_10_0, "anim/text_add"), "+" .. tostring(arg_10_1))

	if arg_10_1 > 0 then
		setActive(findTF(var_10_0, "anim/text_sub"), false)
		setActive(findTF(var_10_0, "anim/text_add"), true)
	else
		setActive(findTF(var_10_0, "anim/text_sub"), true)
		setActive(findTF(var_10_0, "anim/text_add"), false)
	end

	setActive(var_10_0, false)
	setActive(var_10_0, true)
	table.insert(arg_10_0.showScores, var_10_0)

	return
end

function var_0_0.onEventHandle(arg_12_0, arg_12_1)
	return
end

function var_0_0.initData(arg_13_0)
	local var_13_0 = Application.targetFrameRate or 60

	if var_13_0 > 60 then
		var_13_0 = 60
	end

	arg_13_0.timer = Timer.New(function()
		arg_13_0:onTimer()

		return
	end, 1 / var_13_0, -1)
	arg_13_0.showScores = {}
	arg_13_0.showScoresPool = {}
	arg_13_0.dropData = pg.mini_game[arg_13_0:GetMGData().id].simple_config_data.drop_ids
	var_0_7.playerChar = nil
	var_0_7.partnerChar = nil
	var_0_7.partnerPet = nil
	var_0_7.enemy1Char = nil
	var_0_7.enemy2Char = nil
	var_0_7.enemyPet = nil
	arg_13_0.selectPlayer = true
	arg_13_0.selectPartner = false

	return
end

function var_0_0.initUI(arg_15_0)
	arg_15_0.backSceneTf = findTF(arg_15_0._tf, "scene_background")
	arg_15_0.sceneContainer = findTF(arg_15_0._tf, "sceneMask/sceneContainer")
	arg_15_0.sceneFrontContainer = findTF(arg_15_0._tf, "sceneMask/sceneContainer/scene_front")
	arg_15_0.clickMask = findTF(arg_15_0._tf, "clickMask")
	arg_15_0.bg = findTF(arg_15_0._tf, "bg")
	arg_15_0.countUI = findTF(arg_15_0._tf, "pop/CountUI")
	arg_15_0.countAnimator = GetComponent(findTF(arg_15_0.countUI, "count"), typeof(Animator))
	arg_15_0.countDft = GetOrAddComponent(findTF(arg_15_0.countUI, "count"), typeof(DftAniEvent))

	arg_15_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_15_0.countDft:SetEndEvent(function()
		setActive(arg_15_0.countUI, false)
		arg_15_0:gameStart()

		return
	end)

	arg_15_0.leaveUI = findTF(arg_15_0._tf, "pop/LeaveUI")

	onButton(arg_15_0, findTF(arg_15_0.leaveUI, "ad/btnOk"), function()
		arg_15_0:resumeGame()
		arg_15_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_15_0, findTF(arg_15_0.leaveUI, "ad/btnCancel"), function()
		arg_15_0:resumeGame()

		return
	end, SFX_CANCEL)
	setActive(arg_15_0.leaveUI, false)

	arg_15_0.pauseUI = findTF(arg_15_0._tf, "pop/pauseUI")

	onButton(arg_15_0, findTF(arg_15_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_15_0.pauseUI, false)
		arg_15_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_15_0.settlementUI = findTF(arg_15_0._tf, "pop/SettleMentUI")

	onButton(arg_15_0, findTF(arg_15_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_15_0.settlementUI, false)
		arg_15_0:openMenuUI()

		return
	end, SFX_CANCEL)
	setActive(arg_15_0.settlementUI, false)

	arg_15_0.menuUI = findTF(arg_15_0._tf, "pop/menuUI")
	arg_15_0.battleScrollRect = GetComponent(findTF(arg_15_0.menuUI, "battList"), typeof(ScrollRect))
	arg_15_0.totalTimes = arg_15_0:getGameTotalTime()

	scrollTo(arg_15_0.battleScrollRect, 0, 1 - (arg_15_0:getGameUsedTimes() - 4 < 0 and 0 or arg_15_0:getGameUsedTimes() - 4) / (arg_15_0.totalTimes - 4))
	onButton(arg_15_0, findTF(arg_15_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_22_0 = arg_15_0.battleScrollRect.normalizedPosition.y + 1 / (arg_15_0.totalTimes - 4)

		if arg_15_0.battleScrollRect.normalizedPosition.y + 1 / (arg_15_0.totalTimes - 4) > 1 then
			var_22_0 = 1
		end

		scrollTo(arg_15_0.battleScrollRect, 0, var_22_0)

		return
	end, SFX_CANCEL)
	onButton(arg_15_0, findTF(arg_15_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_23_0 = arg_15_0.battleScrollRect.normalizedPosition.y - 1 / (arg_15_0.totalTimes - 4)

		if arg_15_0.battleScrollRect.normalizedPosition.y - 1 / (arg_15_0.totalTimes - 4) < 0 then
			var_23_0 = 0
		end

		scrollTo(arg_15_0.battleScrollRect, 0, var_23_0)

		return
	end, SFX_CANCEL)
	onButton(arg_15_0, findTF(arg_15_0.menuUI, "adButton/btnBack"), function()
		arg_15_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_15_0, findTF(arg_15_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mini_cookgametip.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_15_0, findTF(arg_15_0.menuUI, "btnStart"), function()
		setActive(arg_15_0.menuUI, false)
		arg_15_0:openSelectUI()

		return
	end, SFX_CANCEL)

	local var_15_0 = findTF(arg_15_0.menuUI, "tplBattleItem")

	arg_15_0.battleItems = {}
	arg_15_0.dropItems = {}

	for iter_15_0 = 1, 7 do
		local var_15_1 = tf(instantiate(var_15_0))

		var_15_1.name = "battleItem_" .. iter_15_0

		setParent(var_15_1, findTF(arg_15_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, "battleDesc" .. iter_15_0, function(arg_27_0)
			if arg_27_0 then
				setImageSprite(findTF(var_15_1, "state_open/desc"), arg_27_0, true)
				setImageSprite(findTF(var_15_1, "state_clear/desc"), arg_27_0, true)
				setImageSprite(findTF(var_15_1, "state_current/desc"), arg_27_0, true)
				setImageSprite(findTF(var_15_1, "state_closed/desc"), arg_27_0, true)
			end

			return
		end)

		local var_15_2 = findTF(var_15_1, "icon")

		updateDrop(var_15_2, {
			type = arg_15_0.dropData[iter_15_0][1],
			id = arg_15_0.dropData[iter_15_0][2],
			amount = arg_15_0.dropData[iter_15_0][3]
		})
		onButton(arg_15_0, var_15_2, function()
			arg_15_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_15_0.dropItems, var_15_2)
		setActive(var_15_1, true)
		table.insert(arg_15_0.battleItems, var_15_1)
	end

	arg_15_0.selectUI = findTF(arg_15_0._tf, "pop/selectUI")
	arg_15_0.selectCharTpl = findTF(arg_15_0.selectUI, "ad/charTpl")

	setActive(arg_15_0.selectCharTpl, false)

	arg_15_0.selectCharsContainer = findTF(arg_15_0.selectUI, "ad/chars/Viewport/Content")
	arg_15_0.selectCharId = nil
	arg_15_0.selectChars = {}

	local var_15_3 = findTF(arg_15_0.selectUI, "ad/charDetail")

	arg_15_0.detailDescPositons = {}

	for iter_15_1 = 1, #CookGameConst.char_ids do
		local var_15_4 = arg_15_0:getCharDataById(CookGameConst.char_ids[iter_15_1])
		local var_15_5 = tf(instantiate(arg_15_0.selectCharTpl))

		setParent(var_15_5, arg_15_0.selectCharsContainer)

		if var_15_4 then
			local var_15_6 = var_15_4.icon
			local var_15_7 = var_15_4.pos

			setScrollText(findTF(var_15_5, "name/text"), pg.ship_data_statistics[var_15_4.ship_id].name)
			setActive(findTF(var_15_5, "desc"), false)
			setActive(findTF(var_15_5, "desc_en"), false)

			if PLATFORM_CODE == PLATFORM_US then
				setActive(findTF(var_15_5, "desc_en"), true)
				setText(findTF(var_15_5, "desc_en"), pg.gametip[var_15_4.desc].tip)
			else
				setActive(findTF(var_15_5, "desc"), true)
				setText(findTF(var_15_5, "desc"), pg.gametip[var_15_4.desc].tip)
			end

			local var_15_8 = findTF(var_15_5, "detailDesc")

			setActive(var_15_8, false)

			if var_15_4.detail_name then
				arg_15_0.detailDescPositons[var_15_4.detail_name] = var_15_8.anchoredPosition

				setText(findTF(var_15_8, "name"), i18n(var_15_4.detail_name))
				setText(findTF(var_15_8, "desc"), i18n(var_15_4.detail_desc))
				setActive(findTF(var_15_5, "clickDesc"), true)
				onButton(arg_15_0, findTF(var_15_5, "clickDesc"), function()
					local var_29_0 = isActive(var_15_8)
					local var_29_1

					if not var_29_0 then
						var_29_1 = var_15_3:InverseTransformPoint(var_15_8.position)

						setParent(var_15_8, var_15_3)

						arg_15_0.detailDescTf = var_15_8
						arg_15_0.detailDescContent = var_15_5
						arg_15_0.detailDescName = var_15_4.detail_name
					else
						var_29_1 = arg_15_0.detailDescPositons[var_15_4.detail_name]

						setParent(var_15_8, var_15_5)

						arg_15_0.detailDescTf = nil
						arg_15_0.detailDescContent = nil
						arg_15_0.detailDescName = nil
					end

					var_15_8.anchoredPosition = var_29_1

					setActive(var_15_8, not var_29_0)

					return
				end)
			end

			GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, var_15_6, function(arg_30_0)
				local var_30_0 = findTF(var_15_5, "icon/img")

				setActive(var_30_0, true)

				var_30_0.anchoredPosition = var_15_7

				setImageSprite(var_30_0, arg_30_0, true)

				return
			end)
			setActive(findTF(var_15_5, "selected"), false)
			onButton(arg_15_0, findTF(var_15_5, "click"), function()
				arg_15_0:selectChar(var_15_4.id)

				return
			end, SFX_PANEL)
		else
			GetComponent(var_15_5, typeof(CanvasGroup)).alpha = 0
		end

		setActive(var_15_5, true)
		table.insert(arg_15_0.selectChars, {
			data = var_15_4,
			tf = var_15_5
		})
	end

	arg_15_0.playerTf = findTF(arg_15_0.selectUI, "ad/player")
	arg_15_0.partnerTf = findTF(arg_15_0.selectUI, "ad/partner")
	arg_15_0.selectClickTf = findTF(arg_15_0.selectUI, "ad/click")

	setActive(arg_15_0.selectClickTf, false)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/btnStart"), function()
		if var_0_7.playerChar and var_0_7.partnerChar then
			arg_15_0:randomAIShip()
			setActive(arg_15_0.selectUI, false)
			arg_15_0:readyStart()
		end

		return
	end, SFX_PANEL)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/player"), function()
		arg_15_0.selectPlayer = true
		arg_15_0.selectPartner = false

		arg_15_0:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/partner"), function()
		arg_15_0.selectPlayer = false
		arg_15_0.selectPartner = true

		arg_15_0:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/back"), function()
		setActive(arg_15_0.selectUI, false)
		arg_15_0:openMenuUI()

		return
	end, SFX_PANEL)

	arg_15_0.pageMax = math.ceil(#CookGameConst.char_ids / var_0_6) - 1
	arg_15_0.curPageIndex = 0
	arg_15_0.scrollNum = 1 / arg_15_0.pageMax
	arg_15_0.scrollRect = GetComponent(findTF(arg_15_0.selectUI, "ad/chars"), typeof(ScrollRect))
	arg_15_0.scrollRect.normalizedPosition = Vector2(0, 0)

	arg_15_0.scrollRect.onValueChanged:Invoke(Vector2(0, 0))

	arg_15_0.scrollRect.normalizedPosition = Vector2(0, 0)

	arg_15_0.scrollRect.onValueChanged:Invoke(Vector2(0, 0))
	GetOrAddComponent(findTF(arg_15_0.selectUI, "ad/chars"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_36_0, arg_36_1)
		return
	end)
	arg_15_0.scrollRect.onValueChanged:AddListener(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_15_0.detailDescTf then
			setActive(arg_15_0.detailDescTf, false)
			setParent(arg_15_0.detailDescTf, arg_15_0.detailDescContent)

			arg_15_0.detailDescTf.anchoredPosition = arg_15_0.detailDescPositons[arg_15_0.detailDescName]
			arg_15_0.detailDescTf = nil
			arg_15_0.detailDescContent = nil
			arg_15_0.detailDescName = nil
		end

		return
	end)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/next"), function()
		arg_15_0.curPageIndex = arg_15_0.curPageIndex + arg_15_0.scrollNum

		if arg_15_0.curPageIndex > 1 then
			arg_15_0.curPageIndex = 1
		end

		arg_15_0.scrollRect.normalizedPosition = Vector2(arg_15_0.curPageIndex, 0)

		arg_15_0.scrollRect.onValueChanged:Invoke(Vector2(arg_15_0.curPageIndex, 0))

		return
	end, SFX_PANEL)
	onButton(arg_15_0, findTF(arg_15_0.selectUI, "ad/pre"), function()
		arg_15_0.curPageIndex = arg_15_0.curPageIndex - arg_15_0.scrollNum

		if arg_15_0.curPageIndex < 0 then
			arg_15_0.curPageIndex = 0
		end

		arg_15_0.scrollRect.normalizedPosition = Vector2(arg_15_0.curPageIndex, 0)

		arg_15_0.scrollRect.onValueChanged:Invoke(Vector2(arg_15_0.curPageIndex, 0))

		return
	end, SFX_PANEL)
	setActive(arg_15_0.selectUI, false)

	if not arg_15_0.handle and IsUnityEditor then
		arg_15_0.handle = UpdateBeat:CreateListener(arg_15_0.Update, arg_15_0)

		UpdateBeat:AddListener(arg_15_0.handle)
	end

	GetComponent(findTF(arg_15_0.selectUI, "ad/playerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_15_0.selectUI, "ad/partnerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_15_0.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_15_0.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()

	return
end

function var_0_0.initGameUI(arg_40_0)
	arg_40_0.gameUI = findTF(arg_40_0._tf, "ui/gameUI")
	arg_40_0.showScoreTpl = findTF(arg_40_0.sceneFrontContainer, "score")

	setActive(arg_40_0.showScoreTpl, false)
	onButton(arg_40_0, findTF(arg_40_0.gameUI, "topRight/btnStop"), function()
		arg_40_0:stopGame()
		setActive(arg_40_0.pauseUI, true)

		return
	end)
	onButton(arg_40_0, findTF(arg_40_0.gameUI, "btnLeave"), function()
		arg_40_0:stopGame()
		setActive(arg_40_0.leaveUI, true)

		return
	end)

	arg_40_0.gameTimeS = findTF(arg_40_0.gameUI, "top/time/s")
	arg_40_0.scoreTf = findTF(arg_40_0.gameUI, "top/score")
	arg_40_0.otherScoreTf = findTF(arg_40_0.gameUI, "top/otherScore")

	return
end

function var_0_0.initController(arg_43_0)
	arg_43_0.judgesController = CookGameJudgesController.New(arg_43_0.sceneContainer, var_0_7, arg_43_0)

	setActive(findTF(arg_43_0.sceneContainer, "scene_background/charTpl"), false)

	arg_43_0.charController = CookGameCharController.New(arg_43_0.sceneContainer, var_0_7, arg_43_0)

	return
end

function var_0_0.Update(arg_44_0)
	arg_44_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_45_0)
	if arg_45_0.gameStop or arg_45_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_46_0)
	local var_46_0 = arg_46_0:getGameUsedTimes()
	local var_46_1 = arg_46_0:getGameTimes()

	for iter_46_0 = 1, #arg_46_0.battleItems do
		setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_open"), false)
		setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_closed"), false)
		setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_clear"), false)
		setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_current"), false)

		if iter_46_0 <= var_46_0 then
			SetParent(arg_46_0.dropItems[iter_46_0], findTF(arg_46_0.battleItems[iter_46_0], "state_clear/icon"))
			setActive(arg_46_0.dropItems[iter_46_0], true)
			setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_clear"), true)
		elseif iter_46_0 == var_46_0 + 1 and var_46_1 >= 1 then
			setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_current"), true)
			SetParent(arg_46_0.dropItems[iter_46_0], findTF(arg_46_0.battleItems[iter_46_0], "state_current/icon"))
			setActive(arg_46_0.dropItems[iter_46_0], true)
		elseif var_46_0 < iter_46_0 and iter_46_0 <= var_46_0 + var_46_1 then
			setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_open"), true)
			SetParent(arg_46_0.dropItems[iter_46_0], findTF(arg_46_0.battleItems[iter_46_0], "state_open/icon"))
			setActive(arg_46_0.dropItems[iter_46_0], true)
		else
			setActive(findTF(arg_46_0.battleItems[iter_46_0], "state_closed"), true)
			SetParent(arg_46_0.dropItems[iter_46_0], findTF(arg_46_0.battleItems[iter_46_0], "state_closed/icon"))
			setActive(arg_46_0.dropItems[iter_46_0], true)
		end
	end

	arg_46_0.totalTimes = arg_46_0:getGameTotalTime()

	local var_46_2 = 1 - (arg_46_0:getGameUsedTimes() - 3 < 0 and 0 or arg_46_0:getGameUsedTimes() - 3) / (arg_46_0.totalTimes - 4)

	if var_46_2 > 1 then
		var_46_2 = 1
	end

	scrollTo(arg_46_0.battleScrollRect, 0, var_46_2)
	setActive(findTF(arg_46_0.menuUI, "btnStart/tip"), var_46_1 > 0)
	arg_46_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_47_0)
	setActive(findTF(arg_47_0.menuUI, "got"), false)

	if arg_47_0:getUltimate() and arg_47_0:getUltimate() ~= 0 then
		setActive(findTF(arg_47_0.menuUI, "got"), true)
	end

	if arg_47_0:getUltimate() == 0 then
		if arg_47_0:getGameTotalTime() > arg_47_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_47_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_47_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openSelectUI(arg_48_0)
	setActive(arg_48_0.selectUI, true)

	arg_48_0.selectPlayer = true
	arg_48_0.selectPartner = false

	arg_48_0:updateSelectUI()

	return
end

function var_0_0.updateSelectUI(arg_49_0)
	if var_0_7.playerChar then
		local var_49_0 = findTF(arg_49_0.selectUI, "ad/player/icon/img")
		local var_49_1 = arg_49_0:getCharData(var_0_7.playerChar, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_49_0:getCharData(var_0_7.playerChar, "icon"), function(arg_50_0)
			var_49_0.anchoredPosition = var_49_1

			setActive(var_49_0, true)
			setImageSprite(var_49_0, arg_50_0, true)

			return
		end)
	else
		setActive(findTF(arg_49_0.selectUI, "ad/player/icon/img"), false)
	end

	local var_49_2 = var_0_7.partnerChar

	if var_0_7.partnerChar then
		local var_49_3 = findTF(arg_49_0.selectUI, "ad/partner/icon/img")
		local var_49_4 = arg_49_0:getCharData(var_49_2, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_49_0:getCharData(var_49_2, "icon"), function(arg_51_0)
			var_49_3.anchoredPosition = var_49_4

			setActive(var_49_3, true)
			setImageSprite(var_49_3, arg_51_0, true)

			return
		end)
	else
		setActive(findTF(arg_49_0.selectUI, "ad/partner/icon/img"), false)
	end

	if arg_49_0.selectPlayer then
		setActive(findTF(arg_49_0.selectUI, "ad/player/selected"), true)
		setActive(findTF(arg_49_0.selectUI, "ad/partner/selected"), false)
	elseif arg_49_0.selectPartner then
		setActive(findTF(arg_49_0.selectUI, "ad/player/selected"), false)
		setActive(findTF(arg_49_0.selectUI, "ad/partner/selected"), true)
	end

	return
end

function var_0_0.selectChar(arg_52_0, arg_52_1)
	arg_52_0.selectCharId = arg_52_1

	for iter_52_0 = 1, #arg_52_0.selectChars do
		if arg_52_0.selectChars[iter_52_0].data then
			if arg_52_0.selectChars[iter_52_0].data.id == arg_52_1 then
				setActive(findTF(arg_52_0.selectChars[iter_52_0].tf, "selected"), true)
			else
				setActive(findTF(arg_52_0.selectChars[iter_52_0].tf, "selected"), false)
			end
		end
	end

	if arg_52_0.selectPlayer then
		if var_0_7.partnerChar and var_0_7.partnerChar == arg_52_1 then
			var_0_7.partnerChar = var_0_7.playerChar or nil
		end

		var_0_7.playerChar = arg_52_1

		if not var_0_7.partnerChar then
			arg_52_0.selectPlayer = false
			arg_52_0.selectPartner = true
		end
	elseif arg_52_0.selectPartner then
		if var_0_7.playerChar and var_0_7.playerChar == arg_52_1 then
			var_0_7.playerChar = var_0_7.partnerChar
		end

		var_0_7.partnerChar = arg_52_1

		if not var_0_7.playerChar then
			arg_52_0.selectPlayer = true
			arg_52_0.selectPartner = false
		end
	end

	var_0_7.partnerPet = var_0_7.playerChar and CookGameConst.char_battle_data[var_0_7.playerChar].pet and CookGameConst.char_battle_data[var_0_7.playerChar].pet or var_0_7.partnerChar and CookGameConst.char_battle_data[var_0_7.partnerChar].pet and CookGameConst.char_battle_data[var_0_7.partnerChar].pet or nil

	arg_52_0:updateSelectUI()

	return
end

function var_0_0.getCharDataById(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in pairs(CookGameConst.char_data) do
		if iter_53_1.id == arg_53_1 then
			return Clone(iter_53_1)
		end
	end

	return nil
end

function var_0_0.getCharData(arg_54_0, arg_54_1, arg_54_2)
	for iter_54_0 = 1, #CookGameConst.char_data do
		if CookGameConst.char_data[iter_54_0].id == arg_54_1 then
			if not arg_54_2 then
				return Clone(CookGameConst.char_data[iter_54_0])
			else
				return Clone(CookGameConst.char_data[iter_54_0][arg_54_2])
			end
		end
	end

	return nil
end

function var_0_0.randomAIShip(arg_55_0)
	for iter_55_0, iter_55_1 in pairs(CookGameConst.char_battle_data) do
		if iter_55_1.extend then
			table.insert({}, iter_55_1.id)
		end
	end

	if var_0_7.playerChar then
		table.insert({}, var_0_7.playerChar)
	end

	if var_0_7.partnerChar then
		table.insert({}, var_0_7.partnerChar)
	end

	local var_55_0 = Clone(CookGameConst.random_ids)

	for iter_55_2 = #var_55_0, 1, -1 do
		if table.contains({}, var_55_0[iter_55_2]) then
			table.remove(var_55_0, iter_55_2)
		end
	end

	var_0_7.enemy1Char = table.remove(var_55_0, math.random(1, #var_55_0))
	var_0_7.enemy2Char = table.remove(var_55_0, math.random(1, #var_55_0))
	var_0_7.enemyPet = CookGameConst.char_battle_data[var_0_7.enemy1Char].pet or CookGameConst.char_battle_data[var_0_7.enemy2Char].pet or nil

	return
end

function var_0_0.openMenuUI(arg_56_0)
	setActive(findTF(arg_56_0.sceneContainer, "scene_front"), false)
	setActive(findTF(arg_56_0.sceneContainer, "scene_background"), false)
	setActive(findTF(arg_56_0.sceneContainer, "scene"), false)
	setActive(arg_56_0.gameUI, false)
	setActive(arg_56_0.menuUI, true)
	setActive(arg_56_0.bg, true)
	arg_56_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_57_0)
	setActive(arg_57_0.sceneContainer, false)
	setActive(arg_57_0.settlementUI, false)
	setActive(arg_57_0.countUI, false)
	setActive(arg_57_0.menuUI, false)
	setActive(arg_57_0.gameUI, false)
	setActive(arg_57_0.selectUI, false)

	return
end

function var_0_0.readyStart(arg_58_0)
	arg_58_0.readyStartFlag = true

	arg_58_0:controllerReady()
	setActive(arg_58_0.countUI, true)
	arg_58_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	arg_58_0.readyStartFlag = false

	return
end

function var_0_0.gameStart(arg_59_0)
	setActive(findTF(arg_59_0.sceneContainer, "scene_front"), true)
	setActive(findTF(arg_59_0.sceneContainer, "scene_background"), true)
	setActive(findTF(arg_59_0.sceneContainer, "scene"), true)

	GetComponent(findTF(arg_59_0.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 1

	setActive(arg_59_0.bg, false)

	arg_59_0.sceneContainer.anchoredPosition = Vector2(0, 0)
	arg_59_0.offsetPosition = Vector2(0, 0)

	setActive(arg_59_0.gameUI, true)

	arg_59_0.gameStartFlag = true
	arg_59_0.scoreNum = 0
	arg_59_0.otherScoreNum = 0
	arg_59_0.gameStepTime = 0
	arg_59_0.gameTime = var_0_4
	arg_59_0.extendTime = nil
	arg_59_0.waitingExtendTime = false

	if var_0_7.playerChar == 6 or var_0_7.partnerChar == 6 then
		arg_59_0.waitingExtendTime = true
	end

	for iter_59_0 = #arg_59_0.showScores, 1, -1 do
		if not table.contains(arg_59_0.showScoresPool, arg_59_0.showScores[iter_59_0]) then
			table.insert(arg_59_0.showScoresPool, (table.remove(arg_59_0.showScores, iter_59_0)))
		end
	end

	for iter_59_1 = #arg_59_0.showScoresPool, 1, -1 do
		setActive(arg_59_0.showScoresPool[iter_59_1], false)
	end

	;(function(arg_60_0, arg_60_1)
		local var_60_0 = arg_59_0:getCharData(arg_60_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_59_0:getCharData(arg_60_0, "icon"), function(arg_61_0)
			setActive(arg_60_1, true)
			setImageSprite(arg_60_1, arg_61_0, true)

			return
		end)

		return
	end)(var_0_7.playerChar, findTF(arg_59_0.gameUI, "top/leftCharPos/player/img"))
	;(function(arg_60_0, arg_60_1)
		local var_60_0 = arg_59_0:getCharData(arg_60_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_59_0:getCharData(arg_60_0, "icon"), function(arg_61_0)
			setActive(arg_60_1, true)
			setImageSprite(arg_60_1, arg_61_0, true)

			return
		end)

		return
	end)(var_0_7.partnerChar, findTF(arg_59_0.gameUI, "top/leftCharPos/partner/img"))
	;(function(arg_60_0, arg_60_1)
		local var_60_0 = arg_59_0:getCharData(arg_60_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_59_0:getCharData(arg_60_0, "icon"), function(arg_61_0)
			setActive(arg_60_1, true)
			setImageSprite(arg_60_1, arg_61_0, true)

			return
		end)

		return
	end)(var_0_7.enemy1Char, findTF(arg_59_0.gameUI, "top/rightCharPos/enemy1/img"))
	;(function(arg_60_0, arg_60_1)
		local var_60_0 = arg_59_0:getCharData(arg_60_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_59_0:getCharData(arg_60_0, "icon"), function(arg_61_0)
			setActive(arg_60_1, true)
			setImageSprite(arg_60_1, arg_61_0, true)

			return
		end)

		return
	end)(var_0_7.enemy2Char, findTF(arg_59_0.gameUI, "top/rightCharPos/enemy2/img"))
	arg_59_0:updateGameUI()
	arg_59_0:timerStart()
	arg_59_0:controllerStart()

	return
end

function var_0_0.controllerReady(arg_62_0)
	GetComponent(findTF(arg_62_0.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 0

	setActive(findTF(arg_62_0.sceneContainer, "scene"), true)
	arg_62_0.charController:readyStart()

	return
end

function var_0_0.controllerStart(arg_63_0)
	arg_63_0.judgesController:start()
	arg_63_0.charController:start()

	return
end

function var_0_0.getGameTimes(arg_64_0)
	return arg_64_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_65_0)
	return arg_65_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_66_0)
	return arg_66_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_67_0)
	return (arg_67_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_68_0, arg_68_1)
	if arg_68_0.judgesController then
		arg_68_0.judgesController:changeSpeed(arg_68_1)
	end

	if arg_68_0.charController then
		arg_68_0.charController:changeSpeed(arg_68_1)
	end

	return
end

function var_0_0.onTimer(arg_69_0)
	arg_69_0:gameStep()

	return
end

function var_0_0.gameStep(arg_70_0)
	if arg_70_0.gameTime and arg_70_0.gameTime > 3 and arg_70_0.gameTime - Time.deltaTime < 3 and var_0_7.playerChar ~= 6 and var_0_7.playerChar ~= 6 then
		arg_70_0.judgesController:timeUp()
	end

	if arg_70_0.extendTime and arg_70_0.extendTime > 3 and arg_70_0.extendTime - Time.deltaTime < 3 then
		arg_70_0.judgesController:timeUp()
	end

	arg_70_0.gameTime = arg_70_0.gameTime - Time.deltaTime

	if arg_70_0.gameTime < 0 then
		arg_70_0.gameTime = 0
	end

	var_0_7.gameTime = arg_70_0.gameTime

	if arg_70_0.extendTime and arg_70_0.extendTime > 0 then
		arg_70_0.extendTime = arg_70_0.extendTime - Time.deltaTime

		if arg_70_0.extendTime < 0 then
			arg_70_0.extendTime = 0
		end
	end

	arg_70_0.gameStepTime = arg_70_0.gameStepTime + Time.deltaTime

	arg_70_0:controllerStep(Time.deltaTime)
	arg_70_0:updateGameUI()

	if not arg_70_0.waitingExtendTime and arg_70_0.gameTime <= 0 then
		if arg_70_0.extendTime then
			if arg_70_0.extendTime <= 0 then
				arg_70_0:onGameOver()
			end
		else
			arg_70_0:onGameOver()
		end

		return
	end

	return
end

function var_0_0.controllerStep(arg_71_0, arg_71_1)
	arg_71_0.judgesController:step(arg_71_1)
	arg_71_0.charController:step(arg_71_1)

	return
end

function var_0_0.timerStart(arg_72_0)
	if not arg_72_0.timer.running then
		arg_72_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_73_0)
	if arg_73_0.timer.running then
		arg_73_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_74_0)
	setText(arg_74_0.scoreTf, arg_74_0.scoreNum)
	setText(arg_74_0.otherScoreTf, arg_74_0.otherScoreNum)

	if arg_74_0.extendTime and arg_74_0.extendTime > 0 then
		setText(arg_74_0.gameTimeS, math.ceil(arg_74_0.extendTime))
	else
		setText(arg_74_0.gameTimeS, math.ceil(arg_74_0.gameTime))
	end

	return
end

function var_0_0.addScore(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_2 then
		arg_75_0.otherScoreNum = arg_75_0.otherScoreNum + arg_75_1

		if arg_75_0.otherScoreNum < 0 then
			arg_75_0.otherScoreNum = 0
		end
	else
		arg_75_0.scoreNum = arg_75_0.scoreNum + arg_75_1

		if arg_75_0.scoreNum < 0 then
			arg_75_0.scoreNum = 0
		end
	end

	return
end

function var_0_0.onGameOver(arg_76_0)
	if arg_76_0.settlementFlag then
		return
	end

	arg_76_0:timerStop()
	arg_76_0:controllerClear()

	arg_76_0.settlementFlag = true

	setActive(arg_76_0.clickMask, true)
	LeanTween.delayedCall(go(arg_76_0._tf), 0.1, System.Action(function()
		arg_76_0.settlementFlag = false
		arg_76_0.gameStartFlag = false

		setActive(arg_76_0.clickMask, false)
		arg_76_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_78_0)
	setActive(arg_78_0.settlementUI, true)
	GetComponent(findTF(arg_78_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_78_0 = arg_78_0:GetMGData():GetRuntimeData("elements")
	local var_78_1 = arg_78_0.scoreNum

	if var_78_0 and #var_78_0 > 0 then
		local var_78_2 = var_78_0[1] or 0
		local var_78_3 = arg_78_0.otherScoreNum or 0

		setActive(findTF(arg_78_0.settlementUI, "ad/new"), var_78_2 < var_78_1)

		if var_78_2 <= var_78_1 then
			var_78_2 = var_78_1

			arg_78_0:StoreDataToServer({
				var_78_1
			})
		end

		setText(findTF(arg_78_0.settlementUI, "ad/highText"), var_78_2)
		setText(findTF(arg_78_0.settlementUI, "ad/currentText"), var_78_1)
		setText(findTF(arg_78_0.settlementUI, "ad/otherText"), var_78_3)

		if arg_78_0:getGameTimes() and arg_78_0:getGameTimes() > 0 then
			arg_78_0.sendSuccessFlag = true

			arg_78_0:SendSuccess(0)
		end

		if var_78_3 < var_78_1 then
			setActive(findTF(arg_78_0.settlementUI, "ad/win"), true)
			setActive(findTF(arg_78_0.settlementUI, "ad/defeat"), false)
		elseif var_78_1 < var_78_3 then
			setActive(findTF(arg_78_0.settlementUI, "ad/win"), false)
			setActive(findTF(arg_78_0.settlementUI, "ad/defeat"), true)
		else
			setActive(findTF(arg_78_0.settlementUI, "ad/win"), false)
			setActive(findTF(arg_78_0.settlementUI, "ad/defeat"), false)
		end

		local var_78_4 = {}

		table.insert({}, {
			name = "player",
			char_id = var_0_7.playerChar
		})
		table.insert(var_78_4, {
			name = "partner",
			char_id = var_0_7.partnerChar
		})
		table.insert(var_78_4, {
			name = "enemy1",
			char_id = var_0_7.enemy1Char
		})
		table.insert(var_78_4, {
			name = "enemy2",
			char_id = var_0_7.enemy2Char
		})

		for iter_78_0 = 1, #var_78_4 do
			local var_78_5 = findTF(arg_78_0.settlementUI, "ad/" .. var_78_4[iter_78_0].name)
			local var_78_6 = arg_78_0:getCharData(var_78_4[iter_78_0].char_id, "pos")

			GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_78_0:getCharData(var_78_4[iter_78_0].char_id, "icon"), function(arg_79_0)
				local var_79_0 = findTF(var_78_5, "mask/img")

				setActive(var_79_0, true)

				var_79_0.anchoredPosition = var_78_6

				setImageSprite(var_79_0, arg_79_0, true)

				return
			end)
		end

		return
	end
end

function var_0_0.OnApplicationPaused(arg_80_0)
	if not arg_80_0.gameStartFlag then
		return
	end

	if arg_80_0.readyStartFlag then
		return
	end

	if arg_80_0.settlementFlag then
		return
	end

	if isActive(arg_80_0.pauseUI) or isActive(arg_80_0.leaveUI) then
		return
	end

	if not isActive(arg_80_0.pauseUI) then
		setActive(arg_80_0.pauseUI, true)
	end

	arg_80_0:stopGame()

	return
end

function var_0_0.controllerClear(arg_81_0)
	arg_81_0.judgesController:clear()
	arg_81_0.charController:clear()

	return
end

function var_0_0.resumeGame(arg_82_0)
	arg_82_0.gameStop = false

	setActive(arg_82_0.leaveUI, false)
	arg_82_0:changeSpeed(1)
	arg_82_0:timerStart()

	return
end

function var_0_0.stopGame(arg_83_0)
	arg_83_0.gameStop = true

	arg_83_0:timerStop()
	arg_83_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_84_0)
	if arg_84_0.readyStartFlag then
		return
	end

	if not arg_84_0.gameStartFlag then
		arg_84_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_84_0.settlementFlag then
			return
		end

		if isActive(arg_84_0.pauseUI) then
			setActive(arg_84_0.pauseUI, false)
		end

		arg_84_0:stopGame()
		setActive(arg_84_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_85_0)
	if arg_85_0.handle then
		UpdateBeat:RemoveListener(arg_85_0.handle)
	end

	if arg_85_0._tf and LeanTween.isTweening(go(arg_85_0._tf)) then
		LeanTween.cancel(go(arg_85_0._tf))
	end

	arg_85_0:destroyController()

	if arg_85_0.timer and arg_85_0.timer.running then
		arg_85_0.timer:Stop()
	end

	arg_85_0.scrollRect.onValueChanged:RemoveAllListeners()

	Time.timeScale = 1
	arg_85_0.timer = nil

	return
end

function var_0_0.destroyController(arg_86_0)
	return
end

return var_0_0
