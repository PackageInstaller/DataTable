local var_0_0 = class("GameRoomCookView", import("..BaseMiniGameView"))
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
	return "GameRoomCookUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	AssetBundleHelper.StoreAssetBundle(var_0_7.path, false, true)

	arg_2_0.cookGameUIAtlasStored = true

	arg_2_1()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:initEvent()
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:initGameUI()
	arg_3_0:initController()
	arg_3_0:updateMenuUI()
	arg_3_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_4_0)
	arg_4_0.uiCam = arg_4_0.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	arg_4_0:bind(CookGameView.CLICK_JUDGE_EVENT, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_4_0.charController then
			arg_4_0.charController:setJudgeAction(arg_5_1, nil, arg_5_2)
		end

		return
	end)
	arg_4_0:bind(CookGameView.AC_CAKE_EVENT, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_4_0.charController then
			arg_4_0.charController:createAcCake(arg_6_1, arg_6_2)
		end

		return
	end)
	arg_4_0:bind(CookGameView.SERVE_EVENT, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1.serveData.battleData.id
		local var_7_1 = arg_7_1.right
		local var_7_2 = arg_7_1.pos
		local var_7_3 = arg_7_1.rate
		local var_7_5 = arg_7_1.right and 1 or -1
		local var_7_6 = arg_7_1.right and 1 or 0
		local var_7_7 = arg_7_1.serveData.parameter.right_index

		if not arg_7_1.serveData.battleData.weight then
			-- block empty
		end

		if var_7_1 and arg_7_1.serveData.battleData.cake_allow then
			var_7_6 = 3
		end

		if var_7_1 and arg_7_1.serveData.battleData.score_added then
			var_7_5 = var_7_5 + arg_7_1.serveData.parameter.series_right_index - 1
		end

		if arg_7_1.serveData.battleData.random_score then
			var_7_5 = var_7_5 * math.random(1, CookGameConst.random_score)
		end

		local var_7_11 = var_7_5 * var_7_3

		arg_4_0:addScore(var_7_5 * var_7_3, var_7_8)
		arg_4_0:showScore(var_7_11, var_7_2, var_7_6)

		if arg_7_1.serveData.battleData.double_score == 8 then
			if var_7_1 and var_7_7 and var_7_7 % 2 == 0 then
				arg_4_0:addScore(var_7_11, var_7_8)
				LeanTween.delayedCall(go(arg_4_0._tf), 0.5, System.Action(function()
					arg_4_0:showScore(var_7_11, var_7_2, 2)

					return
				end))
			end
		elseif arg_7_1.serveData.battleData.half_double and var_7_1 and math.random() > 0.5 then
			arg_4_0:addScore(var_7_11, var_7_8)
			LeanTween.delayedCall(go(arg_4_0._tf), 0.5, System.Action(function()
				arg_4_0:showScore(var_7_11, var_7_2, 2)

				return
			end))
		end

		return
	end)
	arg_4_0:bind(CookGameView.EXTEND_EVENT, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_4_0.judgesController then
			arg_4_0.judgesController:extend()
		end

		arg_4_0.waitingExtendTime = false
		arg_4_0.extendTime = var_0_7.extend_time
		arg_4_0.gameTime = 0

		return
	end)

	return
end

function var_0_0.showScore(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 == 0 then
		return
	end

	local var_11_0

	if #arg_11_0.showScoresPool > 0 then
		var_11_0 = table.remove(arg_11_0.showScoresPool, 1)
	else
		var_11_0 = tf(Instantiate(arg_11_0.showScoreTpl))

		setParent(var_11_0, arg_11_0.sceneFrontContainer)
		GetComponent(findTF(var_11_0, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			for iter_12_0 = #arg_11_0.showScores, 1, -1 do
				if var_11_0 == arg_11_0.showScores[iter_12_0] then
					setActive(var_11_0, false)
					table.insert(arg_11_0.showScoresPool, table.remove(arg_11_0.showScores, iter_12_0))
				end
			end

			return
		end)
	end

	var_11_0.anchoredPosition = arg_11_0.sceneFrontContainer:InverseTransformPoint(arg_11_2)

	setText(findTF(var_11_0, "anim/text_sub"), "" .. tostring(arg_11_1))
	setText(findTF(var_11_0, "anim/text_add"), "+" .. tostring(arg_11_1))

	if arg_11_1 > 0 then
		setActive(findTF(var_11_0, "anim/text_sub"), false)
		setActive(findTF(var_11_0, "anim/text_add"), true)
	else
		setActive(findTF(var_11_0, "anim/text_sub"), true)
		setActive(findTF(var_11_0, "anim/text_add"), false)
	end

	setActive(var_11_0, false)
	setActive(var_11_0, true)
	table.insert(arg_11_0.showScores, var_11_0)

	return
end

function var_0_0.onEventHandle(arg_13_0, arg_13_1)
	return
end

function var_0_0.initData(arg_14_0)
	local var_14_0 = Application.targetFrameRate or 60

	if var_14_0 > 60 then
		var_14_0 = 60
	end

	arg_14_0.timer = Timer.New(function()
		arg_14_0:onTimer()

		return
	end, 1 / var_14_0, -1)
	arg_14_0.showScores = {}
	arg_14_0.showScoresPool = {}
	arg_14_0.dropData = pg.mini_game[arg_14_0:GetMGData().id].simple_config_data.drop_ids
	var_0_7.playerChar = nil
	var_0_7.partnerChar = nil
	var_0_7.partnerPet = nil
	var_0_7.enemy1Char = nil
	var_0_7.enemy2Char = nil
	var_0_7.enemyPet = nil
	arg_14_0.selectPlayer = true
	arg_14_0.selectPartner = false

	return
end

function var_0_0.initUI(arg_16_0)
	arg_16_0.backSceneTf = findTF(arg_16_0._tf, "scene_background")
	arg_16_0.sceneContainer = findTF(arg_16_0._tf, "sceneMask/sceneContainer")
	arg_16_0.sceneFrontContainer = findTF(arg_16_0._tf, "sceneMask/sceneContainer/scene_front")
	arg_16_0.clickMask = findTF(arg_16_0._tf, "clickMask")
	arg_16_0.bg = findTF(arg_16_0._tf, "bg")
	arg_16_0.countUI = findTF(arg_16_0._tf, "pop/CountUI")
	arg_16_0.countAnimator = GetComponent(findTF(arg_16_0.countUI, "count"), typeof(Animator))
	arg_16_0.countDft = GetOrAddComponent(findTF(arg_16_0.countUI, "count"), typeof(DftAniEvent))

	arg_16_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_16_0.countDft:SetEndEvent(function()
		setActive(arg_16_0.countUI, false)
		arg_16_0:gameStart()

		return
	end)

	arg_16_0.leaveUI = findTF(arg_16_0._tf, "pop/LeaveUI")

	onButton(arg_16_0, findTF(arg_16_0.leaveUI, "ad/btnOk"), function()
		arg_16_0:resumeGame()
		arg_16_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.leaveUI, "ad/btnCancel"), function()
		arg_16_0:resumeGame()

		return
	end, SFX_CANCEL)
	setActive(arg_16_0.leaveUI, false)

	arg_16_0.pauseUI = findTF(arg_16_0._tf, "pop/pauseUI")

	onButton(arg_16_0, findTF(arg_16_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_16_0.pauseUI, false)
		arg_16_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_16_0.settlementUI = findTF(arg_16_0._tf, "pop/SettleMentUI")

	onButton(arg_16_0, findTF(arg_16_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_16_0.settlementUI, false)
		arg_16_0:openMenuUI()

		return
	end, SFX_CANCEL)
	setActive(arg_16_0.settlementUI, false)

	arg_16_0.menuUI = findTF(arg_16_0._tf, "pop/menuUI")
	arg_16_0.battleScrollRect = GetComponent(findTF(arg_16_0.menuUI, "battList"), typeof(ScrollRect))
	arg_16_0.totalTimes = arg_16_0:getGameTotalTime()

	scrollTo(arg_16_0.battleScrollRect, 0, 1 - (arg_16_0:getGameUsedTimes() - 4 < 0 and 0 or arg_16_0:getGameUsedTimes() - 4) / (arg_16_0.totalTimes - 4))
	onButton(arg_16_0, findTF(arg_16_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_23_0 = arg_16_0.battleScrollRect.normalizedPosition.y + 1 / (arg_16_0.totalTimes - 4)

		if arg_16_0.battleScrollRect.normalizedPosition.y + 1 / (arg_16_0.totalTimes - 4) > 1 then
			var_23_0 = 1
		end

		scrollTo(arg_16_0.battleScrollRect, 0, var_23_0)

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_24_0 = arg_16_0.battleScrollRect.normalizedPosition.y - 1 / (arg_16_0.totalTimes - 4)

		if arg_16_0.battleScrollRect.normalizedPosition.y - 1 / (arg_16_0.totalTimes - 4) < 0 then
			var_24_0 = 0
		end

		scrollTo(arg_16_0.battleScrollRect, 0, var_24_0)

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.menuUI, "adButton/btnBack"), function()
		arg_16_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_16_0:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.menuUI, "btnStart"), function()
		setActive(arg_16_0.menuUI, false)
		arg_16_0:openCoinLayer(false)
		arg_16_0:openSelectUI()

		return
	end, SFX_CANCEL)

	local var_16_0 = findTF(arg_16_0.menuUI, "tplBattleItem")

	arg_16_0.battleItems = {}
	arg_16_0.dropItems = {}

	for iter_16_0 = 1, 7 do
		local var_16_1 = tf(instantiate(var_16_0))

		var_16_1.name = "battleItem_" .. iter_16_0

		setParent(var_16_1, findTF(arg_16_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, "battleDesc" .. iter_16_0, function(arg_28_0)
			if arg_28_0 then
				setImageSprite(findTF(var_16_1, "state_open/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_clear/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_current/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_closed/desc"), arg_28_0, true)
			end

			return
		end)

		local var_16_2 = findTF(var_16_1, "icon")

		updateDrop(var_16_2, {
			type = arg_16_0.dropData[iter_16_0][1],
			id = arg_16_0.dropData[iter_16_0][2],
			amount = arg_16_0.dropData[iter_16_0][3]
		})
		onButton(arg_16_0, var_16_2, function()
			arg_16_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_16_0.dropItems, var_16_2)
		setActive(var_16_1, true)
		table.insert(arg_16_0.battleItems, var_16_1)
	end

	arg_16_0.selectUI = findTF(arg_16_0._tf, "pop/selectUI")
	arg_16_0.selectCharTpl = findTF(arg_16_0.selectUI, "ad/charTpl")

	setActive(arg_16_0.selectCharTpl, false)

	arg_16_0.selectCharsContainer = findTF(arg_16_0.selectUI, "ad/chars/Viewport/Content")
	arg_16_0.selectCharId = nil
	arg_16_0.selectChars = {}

	local var_16_3 = findTF(arg_16_0.selectUI, "ad/charDetail")

	arg_16_0.detailDescPositons = {}

	for iter_16_1 = 1, #CookGameConst.char_ids do
		local var_16_4 = arg_16_0:getCharDataById(CookGameConst.char_ids[iter_16_1])
		local var_16_5 = tf(instantiate(arg_16_0.selectCharTpl))

		setParent(var_16_5, arg_16_0.selectCharsContainer)

		if var_16_4 then
			local var_16_6 = var_16_4.icon
			local var_16_7 = var_16_4.pos

			setScrollText(findTF(var_16_5, "name/text"), pg.ship_data_statistics[var_16_4.ship_id].name)
			setActive(findTF(var_16_5, "desc"), false)
			setActive(findTF(var_16_5, "desc_en"), false)

			if PLATFORM_CODE == PLATFORM_US then
				setActive(findTF(var_16_5, "desc_en"), true)
				setText(findTF(var_16_5, "desc_en"), pg.gametip[var_16_4.desc].tip)
			else
				setActive(findTF(var_16_5, "desc"), true)
				setText(findTF(var_16_5, "desc"), pg.gametip[var_16_4.desc].tip)
			end

			local var_16_8 = findTF(var_16_5, "detailDesc")

			setActive(var_16_8, false)

			if var_16_4.detail_name then
				arg_16_0.detailDescPositons[var_16_4.detail_name] = var_16_8.anchoredPosition

				setText(findTF(var_16_8, "name"), i18n(var_16_4.detail_name))
				setText(findTF(var_16_8, "desc"), i18n(var_16_4.detail_desc))
				setActive(findTF(var_16_5, "clickDesc"), true)
				onButton(arg_16_0, findTF(var_16_5, "clickDesc"), function()
					local var_30_0 = isActive(var_16_8)
					local var_30_1

					if not var_30_0 then
						var_30_1 = var_16_3:InverseTransformPoint(var_16_8.position)

						setParent(var_16_8, var_16_3)

						arg_16_0.detailDescTf = var_16_8
						arg_16_0.detailDescContent = var_16_5
						arg_16_0.detailDescName = var_16_4.detail_name
					else
						var_30_1 = arg_16_0.detailDescPositons[var_16_4.detail_name]

						setParent(var_16_8, var_16_5)

						arg_16_0.detailDescTf = nil
						arg_16_0.detailDescContent = nil
						arg_16_0.detailDescName = nil
					end

					var_16_8.anchoredPosition = var_30_1

					setActive(var_16_8, not var_30_0)

					return
				end)
			end

			GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, var_16_6, function(arg_31_0)
				local var_31_0 = findTF(var_16_5, "icon/img")

				setActive(var_31_0, true)

				var_31_0.anchoredPosition = var_16_7

				setImageSprite(var_31_0, arg_31_0, true)

				return
			end)
			setActive(findTF(var_16_5, "selected"), false)
			onButton(arg_16_0, findTF(var_16_5, "click"), function()
				arg_16_0:selectChar(var_16_4.id)

				return
			end, SFX_PANEL)
		else
			GetComponent(var_16_5, typeof(CanvasGroup)).alpha = 0
		end

		setActive(var_16_5, true)
		table.insert(arg_16_0.selectChars, {
			data = var_16_4,
			tf = var_16_5
		})
	end

	arg_16_0.playerTf = findTF(arg_16_0.selectUI, "ad/player")
	arg_16_0.partnerTf = findTF(arg_16_0.selectUI, "ad/partner")
	arg_16_0.selectClickTf = findTF(arg_16_0.selectUI, "ad/click")

	setActive(arg_16_0.selectClickTf, false)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/btnStart"), function()
		if var_0_7.playerChar and var_0_7.partnerChar then
			arg_16_0:randomAIShip()
			setActive(arg_16_0.selectUI, false)
			arg_16_0:readyStart()
		end

		return
	end, SFX_PANEL)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/player"), function()
		arg_16_0.selectPlayer = true
		arg_16_0.selectPartner = false

		arg_16_0:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/partner"), function()
		arg_16_0.selectPlayer = false
		arg_16_0.selectPartner = true

		arg_16_0:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/back"), function()
		setActive(arg_16_0.selectUI, false)
		arg_16_0:openMenuUI()

		return
	end, SFX_PANEL)

	arg_16_0.pageMax = math.ceil(#CookGameConst.char_ids / var_0_6) - 1
	arg_16_0.curPageIndex = 0
	arg_16_0.scrollNum = 1 / arg_16_0.pageMax
	arg_16_0.scrollRect = GetComponent(findTF(arg_16_0.selectUI, "ad/chars"), typeof(ScrollRect))
	arg_16_0.scrollRect.normalizedPosition = Vector2(0, 0)

	arg_16_0.scrollRect.onValueChanged:Invoke(Vector2(0, 0))

	arg_16_0.scrollRect.normalizedPosition = Vector2(0, 0)

	arg_16_0.scrollRect.onValueChanged:Invoke(Vector2(0, 0))
	GetOrAddComponent(findTF(arg_16_0.selectUI, "ad/chars"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_37_0, arg_37_1)
		return
	end)
	arg_16_0.scrollRect.onValueChanged:AddListener(function(arg_38_0, arg_38_1, arg_38_2)
		if arg_16_0.detailDescTf then
			setActive(arg_16_0.detailDescTf, false)
			setParent(arg_16_0.detailDescTf, arg_16_0.detailDescContent)

			arg_16_0.detailDescTf.anchoredPosition = arg_16_0.detailDescPositons[arg_16_0.detailDescName]
			arg_16_0.detailDescTf = nil
			arg_16_0.detailDescContent = nil
			arg_16_0.detailDescName = nil
		end

		return
	end)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/next"), function()
		arg_16_0.curPageIndex = arg_16_0.curPageIndex + arg_16_0.scrollNum

		if arg_16_0.curPageIndex > 1 then
			arg_16_0.curPageIndex = 1
		end

		arg_16_0.scrollRect.normalizedPosition = Vector2(arg_16_0.curPageIndex, 0)

		arg_16_0.scrollRect.onValueChanged:Invoke(Vector2(arg_16_0.curPageIndex, 0))

		return
	end, SFX_PANEL)
	onButton(arg_16_0, findTF(arg_16_0.selectUI, "ad/pre"), function()
		arg_16_0.curPageIndex = arg_16_0.curPageIndex - arg_16_0.scrollNum

		if arg_16_0.curPageIndex < 0 then
			arg_16_0.curPageIndex = 0
		end

		arg_16_0.scrollRect.normalizedPosition = Vector2(arg_16_0.curPageIndex, 0)

		arg_16_0.scrollRect.onValueChanged:Invoke(Vector2(arg_16_0.curPageIndex, 0))

		return
	end, SFX_PANEL)
	setActive(arg_16_0.selectUI, false)

	if not arg_16_0.handle and IsUnityEditor then
		arg_16_0.handle = UpdateBeat:CreateListener(arg_16_0.Update, arg_16_0)

		UpdateBeat:AddListener(arg_16_0.handle)
	end

	GetComponent(findTF(arg_16_0.selectUI, "ad/playerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_16_0.selectUI, "ad/partnerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_16_0.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_16_0.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()

	return
end

function var_0_0.initGameUI(arg_41_0)
	arg_41_0.gameUI = findTF(arg_41_0._tf, "ui/gameUI")
	arg_41_0.showScoreTpl = findTF(arg_41_0.sceneFrontContainer, "score")

	setActive(arg_41_0.showScoreTpl, false)
	onButton(arg_41_0, findTF(arg_41_0.gameUI, "topRight/btnStop"), function()
		arg_41_0:stopGame()
		setActive(arg_41_0.pauseUI, true)

		return
	end)
	onButton(arg_41_0, findTF(arg_41_0.gameUI, "btnLeave"), function()
		arg_41_0:stopGame()
		setActive(arg_41_0.leaveUI, true)

		return
	end)

	arg_41_0.gameTimeS = findTF(arg_41_0.gameUI, "top/time/s")
	arg_41_0.scoreTf = findTF(arg_41_0.gameUI, "top/score")
	arg_41_0.otherScoreTf = findTF(arg_41_0.gameUI, "top/otherScore")

	return
end

function var_0_0.initController(arg_44_0)
	arg_44_0.judgesController = CookGameJudgesController.New(arg_44_0.sceneContainer, var_0_7, arg_44_0)

	setActive(findTF(arg_44_0.sceneContainer, "scene_background/charTpl"), false)

	arg_44_0.charController = CookGameCharController.New(arg_44_0.sceneContainer, var_0_7, arg_44_0)

	return
end

function var_0_0.Update(arg_45_0)
	arg_45_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_46_0)
	if arg_46_0.gameStop or arg_46_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_47_0)
	local var_47_0 = arg_47_0:getGameUsedTimes()
	local var_47_1 = arg_47_0:getGameTimes()

	for iter_47_0 = 1, #arg_47_0.battleItems do
		setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_open"), false)
		setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_closed"), false)
		setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_clear"), false)
		setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_current"), false)

		if iter_47_0 <= var_47_0 then
			SetParent(arg_47_0.dropItems[iter_47_0], findTF(arg_47_0.battleItems[iter_47_0], "state_clear/icon"))
			setActive(arg_47_0.dropItems[iter_47_0], true)
			setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_clear"), true)
		elseif iter_47_0 == var_47_0 + 1 and var_47_1 >= 1 then
			setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_current"), true)
			SetParent(arg_47_0.dropItems[iter_47_0], findTF(arg_47_0.battleItems[iter_47_0], "state_current/icon"))
			setActive(arg_47_0.dropItems[iter_47_0], true)
		elseif var_47_0 < iter_47_0 and iter_47_0 <= var_47_0 + var_47_1 then
			setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_open"), true)
			SetParent(arg_47_0.dropItems[iter_47_0], findTF(arg_47_0.battleItems[iter_47_0], "state_open/icon"))
			setActive(arg_47_0.dropItems[iter_47_0], true)
		else
			setActive(findTF(arg_47_0.battleItems[iter_47_0], "state_closed"), true)
			SetParent(arg_47_0.dropItems[iter_47_0], findTF(arg_47_0.battleItems[iter_47_0], "state_closed/icon"))
			setActive(arg_47_0.dropItems[iter_47_0], true)
		end
	end

	arg_47_0.totalTimes = arg_47_0:getGameTotalTime()

	local var_47_2 = 1 - (arg_47_0:getGameUsedTimes() - 3 < 0 and 0 or arg_47_0:getGameUsedTimes() - 3) / (arg_47_0.totalTimes - 4)

	if var_47_2 > 1 then
		var_47_2 = 1
	end

	scrollTo(arg_47_0.battleScrollRect, 0, var_47_2)
	setActive(findTF(arg_47_0.menuUI, "btnStart/tip"), var_47_1 > 0)
	arg_47_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_48_0)
	setActive(findTF(arg_48_0.menuUI, "got"), false)

	if arg_48_0:getUltimate() and arg_48_0:getUltimate() ~= 0 then
		setActive(findTF(arg_48_0.menuUI, "got"), true)
	end

	if arg_48_0:getUltimate() == 0 then
		if arg_48_0:getGameTotalTime() > arg_48_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_48_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_48_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openSelectUI(arg_49_0)
	setActive(arg_49_0.selectUI, true)

	arg_49_0.selectPlayer = true
	arg_49_0.selectPartner = false

	arg_49_0:updateSelectUI()

	return
end

function var_0_0.updateSelectUI(arg_50_0)
	if var_0_7.playerChar then
		local var_50_0 = findTF(arg_50_0.selectUI, "ad/player/icon/img")
		local var_50_1 = arg_50_0:getCharData(var_0_7.playerChar, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_50_0:getCharData(var_0_7.playerChar, "icon"), function(arg_51_0)
			var_50_0.anchoredPosition = var_50_1

			setActive(var_50_0, true)
			setImageSprite(var_50_0, arg_51_0, true)

			return
		end)
	else
		setActive(findTF(arg_50_0.selectUI, "ad/player/icon/img"), false)
	end

	local var_50_2 = var_0_7.partnerChar

	if var_0_7.partnerChar then
		local var_50_3 = findTF(arg_50_0.selectUI, "ad/partner/icon/img")
		local var_50_4 = arg_50_0:getCharData(var_50_2, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_50_0:getCharData(var_50_2, "icon"), function(arg_52_0)
			var_50_3.anchoredPosition = var_50_4

			setActive(var_50_3, true)
			setImageSprite(var_50_3, arg_52_0, true)

			return
		end)
	else
		setActive(findTF(arg_50_0.selectUI, "ad/partner/icon/img"), false)
	end

	if arg_50_0.selectPlayer then
		setActive(findTF(arg_50_0.selectUI, "ad/player/selected"), true)
		setActive(findTF(arg_50_0.selectUI, "ad/partner/selected"), false)
	elseif arg_50_0.selectPartner then
		setActive(findTF(arg_50_0.selectUI, "ad/player/selected"), false)
		setActive(findTF(arg_50_0.selectUI, "ad/partner/selected"), true)
	end

	return
end

function var_0_0.selectChar(arg_53_0, arg_53_1)
	arg_53_0.selectCharId = arg_53_1

	for iter_53_0 = 1, #arg_53_0.selectChars do
		if arg_53_0.selectChars[iter_53_0].data then
			if arg_53_0.selectChars[iter_53_0].data.id == arg_53_1 then
				setActive(findTF(arg_53_0.selectChars[iter_53_0].tf, "selected"), true)
			else
				setActive(findTF(arg_53_0.selectChars[iter_53_0].tf, "selected"), false)
			end
		end
	end

	if arg_53_0.selectPlayer then
		if var_0_7.partnerChar and var_0_7.partnerChar == arg_53_1 then
			var_0_7.partnerChar = var_0_7.playerChar or nil
		end

		var_0_7.playerChar = arg_53_1

		if not var_0_7.partnerChar then
			arg_53_0.selectPlayer = false
			arg_53_0.selectPartner = true
		end
	elseif arg_53_0.selectPartner then
		if var_0_7.playerChar and var_0_7.playerChar == arg_53_1 then
			var_0_7.playerChar = var_0_7.partnerChar
		end

		var_0_7.partnerChar = arg_53_1

		if not var_0_7.playerChar then
			arg_53_0.selectPlayer = true
			arg_53_0.selectPartner = false
		end
	end

	var_0_7.partnerPet = var_0_7.playerChar and CookGameConst.char_battle_data[var_0_7.playerChar].pet and CookGameConst.char_battle_data[var_0_7.playerChar].pet or var_0_7.partnerChar and CookGameConst.char_battle_data[var_0_7.partnerChar].pet and CookGameConst.char_battle_data[var_0_7.partnerChar].pet or nil

	arg_53_0:updateSelectUI()

	return
end

function var_0_0.getCharDataById(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(CookGameConst.char_data) do
		if iter_54_1.id == arg_54_1 then
			return Clone(iter_54_1)
		end
	end

	return nil
end

function var_0_0.getCharData(arg_55_0, arg_55_1, arg_55_2)
	for iter_55_0 = 1, #CookGameConst.char_data do
		if CookGameConst.char_data[iter_55_0].id == arg_55_1 then
			if not arg_55_2 then
				return Clone(CookGameConst.char_data[iter_55_0])
			else
				return Clone(CookGameConst.char_data[iter_55_0][arg_55_2])
			end
		end
	end

	return nil
end

function var_0_0.randomAIShip(arg_56_0)
	for iter_56_0, iter_56_1 in pairs(CookGameConst.char_battle_data) do
		if iter_56_1.extend then
			table.insert({}, iter_56_1.id)
		end
	end

	if var_0_7.playerChar then
		table.insert({}, var_0_7.playerChar)
	end

	if var_0_7.partnerChar then
		table.insert({}, var_0_7.partnerChar)
	end

	local var_56_0 = Clone(CookGameConst.random_ids)

	for iter_56_2 = #var_56_0, 1, -1 do
		if table.contains({}, var_56_0[iter_56_2]) then
			table.remove(var_56_0, iter_56_2)
		end
	end

	var_0_7.enemy1Char = table.remove(var_56_0, math.random(1, #var_56_0))
	var_0_7.enemy2Char = table.remove(var_56_0, math.random(1, #var_56_0))
	var_0_7.enemyPet = CookGameConst.char_battle_data[var_0_7.enemy1Char].pet or CookGameConst.char_battle_data[var_0_7.enemy2Char].pet or nil

	return
end

function var_0_0.openMenuUI(arg_57_0)
	setActive(findTF(arg_57_0.sceneContainer, "scene_front"), false)
	setActive(findTF(arg_57_0.sceneContainer, "scene_background"), false)
	setActive(findTF(arg_57_0.sceneContainer, "scene"), false)
	setActive(arg_57_0.gameUI, false)
	setActive(arg_57_0.menuUI, true)
	arg_57_0:openCoinLayer(true)
	setActive(arg_57_0.bg, true)
	arg_57_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_58_0)
	setActive(arg_58_0.sceneContainer, false)
	setActive(arg_58_0.settlementUI, false)
	setActive(arg_58_0.countUI, false)
	setActive(arg_58_0.menuUI, false)
	setActive(arg_58_0.gameUI, false)
	setActive(arg_58_0.selectUI, false)

	return
end

function var_0_0.readyStart(arg_59_0)
	arg_59_0.readyStartFlag = true

	arg_59_0:controllerReady()
	setActive(arg_59_0.countUI, true)
	arg_59_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	arg_59_0.readyStartFlag = false

	return
end

function var_0_0.gameStart(arg_60_0)
	setActive(findTF(arg_60_0.sceneContainer, "scene_front"), true)
	setActive(findTF(arg_60_0.sceneContainer, "scene_background"), true)
	setActive(findTF(arg_60_0.sceneContainer, "scene"), true)

	GetComponent(findTF(arg_60_0.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 1

	setActive(arg_60_0.bg, false)

	arg_60_0.sceneContainer.anchoredPosition = Vector2(0, 0)
	arg_60_0.offsetPosition = Vector2(0, 0)

	setActive(arg_60_0.gameUI, true)

	arg_60_0.gameStartFlag = true
	arg_60_0.scoreNum = 0
	arg_60_0.otherScoreNum = 0
	arg_60_0.gameStepTime = 0
	arg_60_0.gameTime = var_0_4
	arg_60_0.extendTime = nil
	arg_60_0.waitingExtendTime = false

	if var_0_7.playerChar == 6 or var_0_7.partnerChar == 6 then
		arg_60_0.waitingExtendTime = true
	end

	for iter_60_0 = #arg_60_0.showScores, 1, -1 do
		if not table.contains(arg_60_0.showScoresPool, arg_60_0.showScores[iter_60_0]) then
			table.insert(arg_60_0.showScoresPool, (table.remove(arg_60_0.showScores, iter_60_0)))
		end
	end

	for iter_60_1 = #arg_60_0.showScoresPool, 1, -1 do
		setActive(arg_60_0.showScoresPool[iter_60_1], false)
	end

	;(function(arg_61_0, arg_61_1)
		local var_61_0 = arg_60_0:getCharData(arg_61_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_60_0:getCharData(arg_61_0, "icon"), function(arg_62_0)
			setActive(arg_61_1, true)
			setImageSprite(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end)(var_0_7.playerChar, findTF(arg_60_0.gameUI, "top/leftCharPos/player/img"))
	;(function(arg_61_0, arg_61_1)
		local var_61_0 = arg_60_0:getCharData(arg_61_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_60_0:getCharData(arg_61_0, "icon"), function(arg_62_0)
			setActive(arg_61_1, true)
			setImageSprite(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end)(var_0_7.partnerChar, findTF(arg_60_0.gameUI, "top/leftCharPos/partner/img"))
	;(function(arg_61_0, arg_61_1)
		local var_61_0 = arg_60_0:getCharData(arg_61_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_60_0:getCharData(arg_61_0, "icon"), function(arg_62_0)
			setActive(arg_61_1, true)
			setImageSprite(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end)(var_0_7.enemy1Char, findTF(arg_60_0.gameUI, "top/rightCharPos/enemy1/img"))
	;(function(arg_61_0, arg_61_1)
		local var_61_0 = arg_60_0:getCharData(arg_61_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_60_0:getCharData(arg_61_0, "icon"), function(arg_62_0)
			setActive(arg_61_1, true)
			setImageSprite(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end)(var_0_7.enemy2Char, findTF(arg_60_0.gameUI, "top/rightCharPos/enemy2/img"))
	arg_60_0:updateGameUI()
	arg_60_0:timerStart()
	arg_60_0:controllerStart()

	return
end

function var_0_0.controllerReady(arg_63_0)
	GetComponent(findTF(arg_63_0.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 0

	setActive(findTF(arg_63_0.sceneContainer, "scene"), true)
	arg_63_0.charController:readyStart()

	return
end

function var_0_0.controllerStart(arg_64_0)
	arg_64_0.judgesController:start()
	arg_64_0.charController:start()

	return
end

function var_0_0.getGameTimes(arg_65_0)
	return arg_65_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_66_0)
	return arg_66_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_67_0)
	return arg_67_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_68_0)
	return (arg_68_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_69_0, arg_69_1)
	if arg_69_0.judgesController then
		arg_69_0.judgesController:changeSpeed(arg_69_1)
	end

	if arg_69_0.charController then
		arg_69_0.charController:changeSpeed(arg_69_1)
	end

	return
end

function var_0_0.onTimer(arg_70_0)
	arg_70_0:gameStep()

	return
end

function var_0_0.gameStep(arg_71_0)
	if arg_71_0.gameTime and arg_71_0.gameTime > 3 and arg_71_0.gameTime - Time.deltaTime < 3 and var_0_7.playerChar ~= 6 and var_0_7.playerChar ~= 6 then
		arg_71_0.judgesController:timeUp()
	end

	if arg_71_0.extendTime and arg_71_0.extendTime > 3 and arg_71_0.extendTime - Time.deltaTime < 3 then
		arg_71_0.judgesController:timeUp()
	end

	arg_71_0.gameTime = arg_71_0.gameTime - Time.deltaTime

	if arg_71_0.gameTime < 0 then
		arg_71_0.gameTime = 0
	end

	var_0_7.gameTime = arg_71_0.gameTime

	if arg_71_0.extendTime and arg_71_0.extendTime > 0 then
		arg_71_0.extendTime = arg_71_0.extendTime - Time.deltaTime

		if arg_71_0.extendTime < 0 then
			arg_71_0.extendTime = 0
		end
	end

	arg_71_0.gameStepTime = arg_71_0.gameStepTime + Time.deltaTime

	arg_71_0:controllerStep(Time.deltaTime)
	arg_71_0:updateGameUI()

	if not arg_71_0.waitingExtendTime and arg_71_0.gameTime <= 0 then
		if arg_71_0.extendTime then
			if arg_71_0.extendTime <= 0 then
				arg_71_0:onGameOver()
			end
		else
			arg_71_0:onGameOver()
		end

		return
	end

	return
end

function var_0_0.controllerStep(arg_72_0, arg_72_1)
	arg_72_0.judgesController:step(arg_72_1)
	arg_72_0.charController:step(arg_72_1)

	return
end

function var_0_0.timerStart(arg_73_0)
	if not arg_73_0.timer.running then
		arg_73_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_74_0)
	if arg_74_0.timer.running then
		arg_74_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_75_0)
	setText(arg_75_0.scoreTf, arg_75_0.scoreNum)
	setText(arg_75_0.otherScoreTf, arg_75_0.otherScoreNum)

	if arg_75_0.extendTime and arg_75_0.extendTime > 0 then
		setText(arg_75_0.gameTimeS, math.ceil(arg_75_0.extendTime))
	else
		setText(arg_75_0.gameTimeS, math.ceil(arg_75_0.gameTime))
	end

	return
end

function var_0_0.addScore(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_2 then
		arg_76_0.otherScoreNum = arg_76_0.otherScoreNum + arg_76_1

		if arg_76_0.otherScoreNum < 0 then
			arg_76_0.otherScoreNum = 0
		end
	else
		arg_76_0.scoreNum = arg_76_0.scoreNum + arg_76_1

		if arg_76_0.scoreNum < 0 then
			arg_76_0.scoreNum = 0
		end
	end

	return
end

function var_0_0.onGameOver(arg_77_0)
	if arg_77_0.settlementFlag then
		return
	end

	arg_77_0:timerStop()
	arg_77_0:controllerClear()

	arg_77_0.settlementFlag = true

	setActive(arg_77_0.clickMask, true)
	LeanTween.delayedCall(go(arg_77_0._tf), 0.1, System.Action(function()
		arg_77_0.settlementFlag = false
		arg_77_0.gameStartFlag = false

		setActive(arg_77_0.clickMask, false)
		arg_77_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_79_0)
	setActive(arg_79_0.settlementUI, true)
	GetComponent(findTF(arg_79_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_79_0 = arg_79_0.scoreNum
	local var_79_1 = getProxy(GameRoomProxy):getRoomScore(arg_79_0:getGameRoomData().id)
	local var_79_2 = arg_79_0.otherScoreNum or 0

	setActive(findTF(arg_79_0.settlementUI, "ad/new"), var_79_1 < var_79_0)

	if var_79_1 <= var_79_0 then
		var_79_1 = var_79_0

		arg_79_0:StoreDataToServer({
			var_79_0
		})
	end

	setText(findTF(arg_79_0.settlementUI, "ad/highText"), var_79_1)
	setText(findTF(arg_79_0.settlementUI, "ad/currentText"), var_79_0)
	setText(findTF(arg_79_0.settlementUI, "ad/otherText"), var_79_2)

	if arg_79_0:getGameTimes() and arg_79_0:getGameTimes() > 0 then
		arg_79_0.sendSuccessFlag = true

		arg_79_0:SendSuccess(var_79_0)
	end

	if var_79_2 < var_79_0 then
		setActive(findTF(arg_79_0.settlementUI, "ad/win"), true)
		setActive(findTF(arg_79_0.settlementUI, "ad/defeat"), false)
	elseif var_79_0 < var_79_2 then
		setActive(findTF(arg_79_0.settlementUI, "ad/win"), false)
		setActive(findTF(arg_79_0.settlementUI, "ad/defeat"), true)
	else
		setActive(findTF(arg_79_0.settlementUI, "ad/win"), false)
		setActive(findTF(arg_79_0.settlementUI, "ad/defeat"), false)
	end

	local var_79_3 = {}

	table.insert({}, {
		name = "player",
		char_id = var_0_7.playerChar
	})
	table.insert(var_79_3, {
		name = "partner",
		char_id = var_0_7.partnerChar
	})
	table.insert(var_79_3, {
		name = "enemy1",
		char_id = var_0_7.enemy1Char
	})
	table.insert(var_79_3, {
		name = "enemy2",
		char_id = var_0_7.enemy2Char
	})

	for iter_79_0 = 1, #var_79_3 do
		local var_79_4 = findTF(arg_79_0.settlementUI, "ad/" .. var_79_3[iter_79_0].name)
		local var_79_5 = arg_79_0:getCharData(var_79_3[iter_79_0].char_id, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0, arg_79_0:getCharData(var_79_3[iter_79_0].char_id, "icon"), function(arg_80_0)
			local var_80_0 = findTF(var_79_4, "mask/img")

			setActive(var_80_0, true)

			var_80_0.anchoredPosition = var_79_5

			setImageSprite(var_80_0, arg_80_0, true)

			return
		end)
	end

	return
end

function var_0_0.OnApplicationPaused(arg_81_0)
	if not arg_81_0.gameStartFlag then
		return
	end

	if arg_81_0.readyStartFlag then
		return
	end

	if arg_81_0.settlementFlag then
		return
	end

	if isActive(arg_81_0.pauseUI) or isActive(arg_81_0.leaveUI) then
		return
	end

	if not isActive(arg_81_0.pauseUI) then
		setActive(arg_81_0.pauseUI, true)
	end

	arg_81_0:stopGame()

	return
end

function var_0_0.controllerClear(arg_82_0)
	arg_82_0.judgesController:clear()
	arg_82_0.charController:clear()

	return
end

function var_0_0.resumeGame(arg_83_0)
	arg_83_0.gameStop = false

	setActive(arg_83_0.leaveUI, false)
	arg_83_0:changeSpeed(1)
	arg_83_0:timerStart()

	return
end

function var_0_0.stopGame(arg_84_0)
	arg_84_0.gameStop = true

	arg_84_0:timerStop()
	arg_84_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_85_0)
	if arg_85_0.readyStartFlag then
		return
	end

	if not arg_85_0.gameStartFlag then
		arg_85_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_85_0.settlementFlag then
			return
		end

		if isActive(arg_85_0.pauseUI) then
			setActive(arg_85_0.pauseUI, false)
		end

		arg_85_0:stopGame()
		setActive(arg_85_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_86_0)
	if arg_86_0.cookGameUIAtlasStored then
		AssetBundleHelper.UnstoreAssetBundle(var_0_7.path, true)

		arg_86_0.cookGameUIAtlasStored = false
	end

	if arg_86_0.handle then
		UpdateBeat:RemoveListener(arg_86_0.handle)
	end

	if arg_86_0._tf and LeanTween.isTweening(go(arg_86_0._tf)) then
		LeanTween.cancel(go(arg_86_0._tf))
	end

	arg_86_0:destroyController()

	if arg_86_0.timer and arg_86_0.timer.running then
		arg_86_0.timer:Stop()
	end

	arg_86_0.scrollRect.onValueChanged:RemoveAllListeners()

	Time.timeScale = 1
	arg_86_0.timer = nil

	return
end

function var_0_0.destroyController(arg_87_0)
	return
end

return var_0_0
