local GameRoomCookView = class("GameRoomCookView", import("..BaseMiniGameView"))
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_4 = 60
local var_0_5 = "cookgameui_atlas"
local var_0_7 = 8
local var_0_8 = {
	speed_num = 3,
	char_path = "ui/minigameui/",
	extend_time = 10,
	time_up = 0.5,
	cake_num = 5,
	path = "ui/minigameui/" .. "cookgameui_atlas"
}

GameRoomCookView.CLICK_JUDGE_EVENT = "click judge event"
GameRoomCookView.AC_CAKE_EVENT = "ac cake event"
GameRoomCookView.SERVE_EVENT = "serve event"
GameRoomCookView.EXTEND_EVENT = "extend event"

function GameRoomCookView:getUIName()
	return "GameRoomCookUI"
end

function GameRoomCookView:preload(arg_2_1)
	AssetBundleHelper.StoreAssetBundle(var_0_8.path, false, true)

	self.cookGameUIAtlasStored = true

	arg_2_1()

	return
end

function GameRoomCookView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function GameRoomCookView:initEvent()
	self.uiCam = self.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	self:bind(CookGameView.CLICK_JUDGE_EVENT, function(arg_5_0, arg_5_1, arg_5_2)
		if self.charController then
			self.charController:setJudgeAction(arg_5_1, nil, arg_5_2)
		end

		return
	end)
	self:bind(CookGameView.AC_CAKE_EVENT, function(arg_6_0, arg_6_1, arg_6_2)
		if self.charController then
			self.charController:createAcCake(arg_6_1, arg_6_2)
		end

		return
	end)
	self:bind(CookGameView.SERVE_EVENT, function(arg_7_0, arg_7_1, arg_7_2)
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

		self:addScore(var_7_5 * var_7_3, var_7_8)
		self:showScore(var_7_11, var_7_2, var_7_6)

		if arg_7_1.serveData.battleData.double_score == 8 then
			if var_7_1 and var_7_7 and var_7_7 % 2 == 0 then
				self:addScore(var_7_11, var_7_8)
				LeanTween.delayedCall(go(self._tf), 0.5, System.Action(function()
					self:showScore(var_7_11, var_7_2, 2)

					return
				end))
			end
		elseif arg_7_1.serveData.battleData.half_double and var_7_1 and math.random() > 0.5 then
			self:addScore(var_7_11, var_7_8)
			LeanTween.delayedCall(go(self._tf), 0.5, System.Action(function()
				self:showScore(var_7_11, var_7_2, 2)

				return
			end))
		end

		return
	end)
	self:bind(CookGameView.EXTEND_EVENT, function(arg_10_0, arg_10_1, arg_10_2)
		if self.judgesController then
			self.judgesController:extend()
		end

		self.waitingExtendTime = false
		self.extendTime = var_0_8.extend_time
		self.gameTime = 0

		return
	end)

	return
end

function GameRoomCookView:showScore(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 == 0 then
		return
	end

	local var_11_0

	if #self.showScoresPool > 0 then
		var_11_0 = table.remove(self.showScoresPool, 1)
	else
		var_11_0 = tf(Instantiate(self.showScoreTpl))

		setParent(var_11_0, self.sceneFrontContainer)
		GetComponent(findTF(var_11_0, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			for iter_12_0 = #self.showScores, 1, -1 do
				if var_11_0 == self.showScores[iter_12_0] then
					setActive(var_11_0, false)
					table.insert(self.showScoresPool, table.remove(self.showScores, iter_12_0))
				end
			end

			return
		end)
	end

	var_11_0.anchoredPosition = self.sceneFrontContainer:InverseTransformPoint(arg_11_2)

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
	table.insert(self.showScores, var_11_0)

	return
end

function GameRoomCookView:onEventHandle(arg_13_1)
	return
end

function GameRoomCookView:initData()
	local var_14_0 = Application.targetFrameRate or 60

	if var_14_0 > 60 then
		var_14_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_14_0, -1)
	self.showScores = {}
	self.showScoresPool = {}
	self.dropData = pg.mini_game[self:GetMGData().id].simple_config_data.drop_ids
	var_0_8.playerChar = nil
	var_0_8.partnerChar = nil
	var_0_8.partnerPet = nil
	var_0_8.enemy1Char = nil
	var_0_8.enemy2Char = nil
	var_0_8.enemyPet = nil
	self.selectPlayer = true
	self.selectPartner = false

	return
end

function GameRoomCookView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_background")
	self.sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")
	self.sceneFrontContainer = findTF(self._tf, "sceneMask/sceneContainer/scene_front")
	self.clickMask = findTF(self._tf, "clickMask")
	self.bg = findTF(self._tf, "bg")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)
	setActive(self.leaveUI, false)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)
	setActive(self.settlementUI, false)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "adButton/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:openCoinLayer(false)
		self:openSelectUI()

		return
	end, SFX_CANCEL)

	local var_16_0 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}
	self.dropItems = {}

	for iter_16_0 = 1, 7 do
		local var_16_1 = tf(instantiate(var_16_0))

		var_16_1.name = "battleItem_" .. iter_16_0

		setParent(var_16_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, "battleDesc" .. iter_16_0, function(arg_28_0)
			if arg_28_0 then
				setImageSprite(findTF(var_16_1, "state_open/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_clear/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_current/desc"), arg_28_0, true)
				setImageSprite(findTF(var_16_1, "state_closed/desc"), arg_28_0, true)
			end

			return
		end)

		local var_16_2 = findTF(var_16_1, "icon")
		local var_16_3 = {
			type = self.dropData[iter_16_0][1],
			id = self.dropData[iter_16_0][2],
			amount = self.dropData[iter_16_0][3]
		}

		updateDrop(var_16_2, var_16_3)
		onButton(self, var_16_2, function()
			self:emit(BaseUI.ON_DROP, var_16_3)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_16_2)
		setActive(var_16_1, true)
		table.insert(self.battleItems, var_16_1)
	end

	self.selectUI = findTF(self._tf, "pop/selectUI")
	self.selectCharTpl = findTF(self.selectUI, "ad/charTpl")

	setActive(self.selectCharTpl, false)

	self.selectCharsContainer = findTF(self.selectUI, "ad/chars/Viewport/Content")
	self.selectCharId = nil
	self.selectChars = {}

	local var_16_4 = findTF(self.selectUI, "ad/charDetail")

	self.detailDescPositons = {}

	for iter_16_1 = 1, #CookGameConst.char_ids do
		local var_16_5 = self:getCharDataById(CookGameConst.char_ids[iter_16_1])
		local var_16_6 = tf(instantiate(self.selectCharTpl))

		setParent(var_16_6, self.selectCharsContainer)

		if var_16_5 then
			local var_16_7 = var_16_5.icon
			local var_16_8 = var_16_5.pos

			setScrollText(findTF(var_16_6, "name/text"), pg.ship_data_statistics[var_16_5.ship_id].name)
			setActive(findTF(var_16_6, "desc"), false)
			setActive(findTF(var_16_6, "desc_en"), false)

			if PLATFORM_CODE == PLATFORM_US then
				setActive(findTF(var_16_6, "desc_en"), true)
				setText(findTF(var_16_6, "desc_en"), pg.gametip[var_16_5.desc].tip)
			else
				setActive(findTF(var_16_6, "desc"), true)
				setText(findTF(var_16_6, "desc"), pg.gametip[var_16_5.desc].tip)
			end

			local var_16_9 = findTF(var_16_6, "detailDesc")

			setActive(var_16_9, false)

			if var_16_5.detail_name then
				self.detailDescPositons[var_16_5.detail_name] = var_16_9.anchoredPosition

				setText(findTF(var_16_9, "name"), i18n(var_16_5.detail_name))
				setText(findTF(var_16_9, "desc"), i18n(var_16_5.detail_desc))
				setActive(findTF(var_16_6, "clickDesc"), true)
				onButton(self, findTF(var_16_6, "clickDesc"), function()
					local var_30_0 = isActive(var_16_9)
					local var_30_1

					if not var_30_0 then
						var_30_1 = var_16_4:InverseTransformPoint(var_16_9.position)

						setParent(var_16_9, var_16_4)

						self.detailDescTf = var_16_9
						self.detailDescContent = var_16_6
						self.detailDescName = var_16_5.detail_name
					else
						var_30_1 = self.detailDescPositons[var_16_5.detail_name]

						setParent(var_16_9, var_16_6)

						self.detailDescTf = nil
						self.detailDescContent = nil
						self.detailDescName = nil
					end

					var_16_9.anchoredPosition = var_30_1

					setActive(var_16_9, not var_30_0)

					return
				end)
			end

			GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, var_16_7, function(arg_31_0)
				local var_31_0 = findTF(var_16_6, "icon/img")

				setActive(var_31_0, true)

				var_31_0.anchoredPosition = var_16_8

				setImageSprite(var_31_0, arg_31_0, true)

				return
			end)
			setActive(findTF(var_16_6, "selected"), false)
			onButton(self, findTF(var_16_6, "click"), function()
				self:selectChar(var_16_5.id)

				return
			end, SFX_PANEL)
		else
			GetComponent(var_16_6, typeof(CanvasGroup)).alpha = 0
		end

		setActive(var_16_6, true)
		table.insert(self.selectChars, {
			data = var_16_5,
			tf = var_16_6
		})
	end

	self.playerTf = findTF(self.selectUI, "ad/player")
	self.partnerTf = findTF(self.selectUI, "ad/partner")
	self.selectClickTf = findTF(self.selectUI, "ad/click")

	setActive(self.selectClickTf, false)
	onButton(self, findTF(self.selectUI, "ad/btnStart"), function()
		if var_0_8.playerChar and var_0_8.partnerChar then
			self:randomAIShip()
			setActive(self.selectUI, false)
			self:readyStart()
		end

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.selectUI, "ad/player"), function()
		self.selectPlayer = true
		self.selectPartner = false

		self:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.selectUI, "ad/partner"), function()
		self.selectPlayer = false
		self.selectPartner = true

		self:updateSelectUI()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.selectUI, "ad/back"), function()
		setActive(self.selectUI, false)
		self:openMenuUI()

		return
	end, SFX_PANEL)

	self.pageMax = math.ceil(#CookGameConst.char_ids / var_0_7) - 1
	self.curPageIndex = 0
	self.scrollNum = 1 / self.pageMax
	self.scrollRect = GetComponent(findTF(self.selectUI, "ad/chars"), typeof(ScrollRect))
	self.scrollRect.normalizedPosition = Vector2(0, 0)

	self.scrollRect.onValueChanged:Invoke(Vector2(0, 0))

	self.scrollRect.normalizedPosition = Vector2(0, 0)

	self.scrollRect.onValueChanged:Invoke(Vector2(0, 0))
	GetOrAddComponent(findTF(self.selectUI, "ad/chars"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_37_0, arg_37_1)
		return
	end)
	self.scrollRect.onValueChanged:AddListener(function(arg_38_0, arg_38_1, arg_38_2)
		if self.detailDescTf then
			setActive(self.detailDescTf, false)
			setParent(self.detailDescTf, self.detailDescContent)

			self.detailDescTf.anchoredPosition = self.detailDescPositons[self.detailDescName]
			self.detailDescTf = nil
			self.detailDescContent = nil
			self.detailDescName = nil
		end

		return
	end)
	onButton(self, findTF(self.selectUI, "ad/next"), function()
		self.curPageIndex = self.curPageIndex + self.scrollNum

		if self.curPageIndex > 1 then
			self.curPageIndex = 1
		end

		self.scrollRect.normalizedPosition = Vector2(self.curPageIndex, 0)

		self.scrollRect.onValueChanged:Invoke(Vector2(self.curPageIndex, 0))

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.selectUI, "ad/pre"), function()
		self.curPageIndex = self.curPageIndex - self.scrollNum

		if self.curPageIndex < 0 then
			self.curPageIndex = 0
		end

		self.scrollRect.normalizedPosition = Vector2(self.curPageIndex, 0)

		self.scrollRect.onValueChanged:Invoke(Vector2(self.curPageIndex, 0))

		return
	end, SFX_PANEL)
	setActive(self.selectUI, false)

	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	GetComponent(findTF(self.selectUI, "ad/playerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.selectUI, "ad/partnerDesc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()

	return
end

function GameRoomCookView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.showScoreTpl = findTF(self.sceneFrontContainer, "score")

	setActive(self.showScoreTpl, false)
	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.otherScoreTf = findTF(self.gameUI, "top/otherScore")

	return
end

function GameRoomCookView:initController()
	self.judgesController = CookGameJudgesController.New(self.sceneContainer, var_0_8, self)

	setActive(findTF(self.sceneContainer, "scene_background/charTpl"), false)

	self.charController = CookGameCharController.New(self.sceneContainer, var_0_8, self)

	return
end

function GameRoomCookView:Update()
	self:AddDebugInput()

	return
end

function GameRoomCookView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function GameRoomCookView:updateMenuUI()
	local var_47_0 = self:getGameUsedTimes()
	local var_47_1 = self:getGameTimes()

	for iter_47_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_47_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_current"), false)

		if iter_47_0 <= var_47_0 then
			SetParent(self.dropItems[iter_47_0], findTF(self.battleItems[iter_47_0], "state_clear/icon"))
			setActive(self.dropItems[iter_47_0], true)
			setActive(findTF(self.battleItems[iter_47_0], "state_clear"), true)
		elseif iter_47_0 == var_47_0 + 1 and var_47_1 >= 1 then
			setActive(findTF(self.battleItems[iter_47_0], "state_current"), true)
			SetParent(self.dropItems[iter_47_0], findTF(self.battleItems[iter_47_0], "state_current/icon"))
			setActive(self.dropItems[iter_47_0], true)
		elseif var_47_0 < iter_47_0 and iter_47_0 <= var_47_0 + var_47_1 then
			setActive(findTF(self.battleItems[iter_47_0], "state_open"), true)
			SetParent(self.dropItems[iter_47_0], findTF(self.battleItems[iter_47_0], "state_open/icon"))
			setActive(self.dropItems[iter_47_0], true)
		else
			setActive(findTF(self.battleItems[iter_47_0], "state_closed"), true)
			SetParent(self.dropItems[iter_47_0], findTF(self.battleItems[iter_47_0], "state_closed/icon"))
			setActive(self.dropItems[iter_47_0], true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_47_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_47_2 > 1 then
		var_47_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_47_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_47_1 > 0)
	self:CheckGet()

	return
end

function GameRoomCookView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function GameRoomCookView:openSelectUI()
	setActive(self.selectUI, true)

	self.selectPlayer = true
	self.selectPartner = false

	self:updateSelectUI()

	return
end

function GameRoomCookView:updateSelectUI()
	if var_0_8.playerChar then
		local var_50_0 = findTF(self.selectUI, "ad/player/icon/img")
		local var_50_1 = self:getCharData(var_0_8.playerChar, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, self:getCharData(var_0_8.playerChar, "icon"), function(arg_51_0)
			var_50_0.anchoredPosition = var_50_1

			setActive(var_50_0, true)
			setImageSprite(var_50_0, arg_51_0, true)

			return
		end)
	else
		setActive(findTF(self.selectUI, "ad/player/icon/img"), false)
	end

	local var_50_2 = var_0_8.partnerChar

	if var_0_8.partnerChar then
		local var_50_3 = findTF(self.selectUI, "ad/partner/icon/img")
		local var_50_4 = self:getCharData(var_50_2, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, self:getCharData(var_50_2, "icon"), function(arg_52_0)
			var_50_3.anchoredPosition = var_50_4

			setActive(var_50_3, true)
			setImageSprite(var_50_3, arg_52_0, true)

			return
		end)
	else
		setActive(findTF(self.selectUI, "ad/partner/icon/img"), false)
	end

	if self.selectPlayer then
		setActive(findTF(self.selectUI, "ad/player/selected"), true)
		setActive(findTF(self.selectUI, "ad/partner/selected"), false)
	elseif self.selectPartner then
		setActive(findTF(self.selectUI, "ad/player/selected"), false)
		setActive(findTF(self.selectUI, "ad/partner/selected"), true)
	end

	return
end

function GameRoomCookView:selectChar(arg_53_1)
	self.selectCharId = arg_53_1

	for iter_53_0 = 1, #self.selectChars do
		if self.selectChars[iter_53_0].data then
			if self.selectChars[iter_53_0].data.id == arg_53_1 then
				setActive(findTF(self.selectChars[iter_53_0].tf, "selected"), true)
			else
				setActive(findTF(self.selectChars[iter_53_0].tf, "selected"), false)
			end
		end
	end

	if self.selectPlayer then
		if var_0_8.partnerChar and var_0_8.partnerChar == arg_53_1 then
			var_0_8.partnerChar = var_0_8.playerChar or nil
		end

		var_0_8.playerChar = arg_53_1

		if not var_0_8.partnerChar then
			self.selectPlayer = false
			self.selectPartner = true
		end
	elseif self.selectPartner then
		if var_0_8.playerChar and var_0_8.playerChar == arg_53_1 then
			var_0_8.playerChar = var_0_8.partnerChar
		end

		var_0_8.partnerChar = arg_53_1

		if not var_0_8.playerChar then
			self.selectPlayer = true
			self.selectPartner = false
		end
	end

	var_0_8.partnerPet = var_0_8.playerChar and CookGameConst.char_battle_data[var_0_8.playerChar].pet and CookGameConst.char_battle_data[var_0_8.playerChar].pet or var_0_8.partnerChar and CookGameConst.char_battle_data[var_0_8.partnerChar].pet and CookGameConst.char_battle_data[var_0_8.partnerChar].pet or nil

	self:updateSelectUI()

	return
end

function GameRoomCookView:getCharDataById(arg_54_1)
	for iter_54_0, iter_54_1 in pairs(CookGameConst.char_data) do
		if iter_54_1.id == arg_54_1 then
			return Clone(iter_54_1)
		end
	end

	return nil
end

function GameRoomCookView:getCharData(arg_55_1, arg_55_2)
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

function GameRoomCookView:randomAIShip()
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs(CookGameConst.char_battle_data) do
		if iter_56_1.extend then
			table.insert(var_56_0, iter_56_1.id)
		end
	end

	if var_0_8.playerChar then
		table.insert(var_56_0, var_0_8.playerChar)
	end

	if var_0_8.partnerChar then
		table.insert(var_56_0, var_0_8.partnerChar)
	end

	local var_56_1 = Clone(CookGameConst.random_ids)

	for iter_56_2 = #var_56_1, 1, -1 do
		if table.contains(var_56_0, var_56_1[iter_56_2]) then
			table.remove(var_56_1, iter_56_2)
		end
	end

	var_0_8.enemy1Char = table.remove(var_56_1, math.random(1, #var_56_1))
	var_0_8.enemy2Char = table.remove(var_56_1, math.random(1, #var_56_1))
	var_0_8.enemyPet = CookGameConst.char_battle_data[var_0_8.enemy1Char].pet or CookGameConst.char_battle_data[var_0_8.enemy2Char].pet or nil

	return
end

function GameRoomCookView:openMenuUI()
	setActive(findTF(self.sceneContainer, "scene_front"), false)
	setActive(findTF(self.sceneContainer, "scene_background"), false)
	setActive(findTF(self.sceneContainer, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:openCoinLayer(true)
	setActive(self.bg, true)
	self:updateMenuUI()

	return
end

function GameRoomCookView:clearUI()
	setActive(self.sceneContainer, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)
	setActive(self.selectUI, false)

	return
end

function GameRoomCookView:readyStart()
	self.readyStartFlag = true

	self:controllerReady()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	self.readyStartFlag = false

	return
end

function GameRoomCookView:gameStart()
	setActive(findTF(self.sceneContainer, "scene_front"), true)
	setActive(findTF(self.sceneContainer, "scene_background"), true)
	setActive(findTF(self.sceneContainer, "scene"), true)

	GetComponent(findTF(self.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 1

	setActive(self.bg, false)

	self.sceneContainer.anchoredPosition = Vector2(0, 0)
	self.offsetPosition = Vector2(0, 0)

	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.otherScoreNum = 0
	self.gameStepTime = 0
	self.gameTime = var_0_4
	self.extendTime = nil
	self.waitingExtendTime = false

	if var_0_8.playerChar == 6 or var_0_8.partnerChar == 6 then
		self.waitingExtendTime = true
	end

	for iter_60_0 = #self.showScores, 1, -1 do
		if not table.contains(self.showScoresPool, self.showScores[iter_60_0]) then
			table.insert(self.showScoresPool, (table.remove(self.showScores, iter_60_0)))
		end
	end

	for iter_60_1 = #self.showScoresPool, 1, -1 do
		setActive(self.showScoresPool[iter_60_1], false)
	end

	local function var_60_0(arg_61_0, arg_61_1)
		local var_61_0 = self:getCharData(arg_61_0, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, self:getCharData(arg_61_0, "icon"), function(arg_62_0)
			setActive(arg_61_1, true)
			setImageSprite(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end

	var_60_0(var_0_8.playerChar, findTF(self.gameUI, "top/leftCharPos/player/img"))
	var_60_0(var_0_8.partnerChar, findTF(self.gameUI, "top/leftCharPos/partner/img"))
	var_60_0(var_0_8.enemy1Char, findTF(self.gameUI, "top/rightCharPos/enemy1/img"))
	var_60_0(var_0_8.enemy2Char, findTF(self.gameUI, "top/rightCharPos/enemy2/img"))
	self:updateGameUI()
	self:timerStart()
	self:controllerStart()

	return
end

function GameRoomCookView:controllerReady()
	GetComponent(findTF(self.sceneContainer, "scene"), typeof(CanvasGroup)).alpha = 0

	setActive(findTF(self.sceneContainer, "scene"), true)
	self.charController:readyStart()

	return
end

function GameRoomCookView:controllerStart()
	self.judgesController:start()
	self.charController:start()

	return
end

function GameRoomCookView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomCookView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GameRoomCookView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GameRoomCookView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GameRoomCookView:changeSpeed(arg_69_1)
	if self.judgesController then
		self.judgesController:changeSpeed(arg_69_1)
	end

	if self.charController then
		self.charController:changeSpeed(arg_69_1)
	end

	return
end

function GameRoomCookView:onTimer()
	self:gameStep()

	return
end

function GameRoomCookView:gameStep()
	if self.gameTime and self.gameTime > 3 and self.gameTime - Time.deltaTime < 3 and var_0_8.playerChar ~= 6 and var_0_8.playerChar ~= 6 then
		self.judgesController:timeUp()
	end

	if self.extendTime and self.extendTime > 3 and self.extendTime - Time.deltaTime < 3 then
		self.judgesController:timeUp()
	end

	self.gameTime = self.gameTime - Time.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	var_0_8.gameTime = self.gameTime

	if self.extendTime and self.extendTime > 0 then
		self.extendTime = self.extendTime - Time.deltaTime

		if self.extendTime < 0 then
			self.extendTime = 0
		end
	end

	self.gameStepTime = self.gameStepTime + Time.deltaTime

	self:controllerStep(Time.deltaTime)
	self:updateGameUI()

	if not self.waitingExtendTime and self.gameTime <= 0 then
		if self.extendTime then
			if self.extendTime <= 0 then
				self:onGameOver()
			end
		else
			self:onGameOver()
		end

		return
	end

	return
end

function GameRoomCookView:controllerStep(arg_72_1)
	self.judgesController:step(arg_72_1)
	self.charController:step(arg_72_1)

	return
end

function GameRoomCookView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomCookView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GameRoomCookView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.otherScoreTf, self.otherScoreNum)

	if self.extendTime and self.extendTime > 0 then
		setText(self.gameTimeS, math.ceil(self.extendTime))
	else
		setText(self.gameTimeS, math.ceil(self.gameTime))
	end

	return
end

function GameRoomCookView:addScore(arg_76_1, arg_76_2)
	if arg_76_2 then
		self.otherScoreNum = self.otherScoreNum + arg_76_1

		if self.otherScoreNum < 0 then
			self.otherScoreNum = 0
		end
	else
		self.scoreNum = self.scoreNum + arg_76_1

		if self.scoreNum < 0 then
			self.scoreNum = 0
		end
	end

	return
end

function GameRoomCookView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self:controllerClear()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function GameRoomCookView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_79_0 = self.scoreNum
	local var_79_1 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)
	local var_79_2 = self.otherScoreNum or 0

	setActive(findTF(self.settlementUI, "ad/new"), var_79_1 < var_79_0)

	if var_79_1 <= var_79_0 then
		var_79_1 = var_79_0

		self:StoreDataToServer({
			var_79_0
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_79_1)
	setText(findTF(self.settlementUI, "ad/currentText"), var_79_0)
	setText(findTF(self.settlementUI, "ad/otherText"), var_79_2)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(var_79_0)
	end

	if var_79_2 < var_79_0 then
		setActive(findTF(self.settlementUI, "ad/win"), true)
		setActive(findTF(self.settlementUI, "ad/defeat"), false)
	elseif var_79_0 < var_79_2 then
		setActive(findTF(self.settlementUI, "ad/win"), false)
		setActive(findTF(self.settlementUI, "ad/defeat"), true)
	else
		setActive(findTF(self.settlementUI, "ad/win"), false)
		setActive(findTF(self.settlementUI, "ad/defeat"), false)
	end

	local var_79_3 = {}

	table.insert(var_79_3, {
		name = "player",
		char_id = var_0_8.playerChar
	})
	table.insert(var_79_3, {
		name = "partner",
		char_id = var_0_8.partnerChar
	})
	table.insert(var_79_3, {
		name = "enemy1",
		char_id = var_0_8.enemy1Char
	})
	table.insert(var_79_3, {
		name = "enemy2",
		char_id = var_0_8.enemy2Char
	})

	for iter_79_0 = 1, #var_79_3 do
		local var_79_4 = findTF(self.settlementUI, "ad/" .. var_79_3[iter_79_0].name)
		local var_79_5 = self:getCharData(var_79_3[iter_79_0].char_id, "pos")

		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_5, self:getCharData(var_79_3[iter_79_0].char_id, "icon"), function(arg_80_0)
			local var_80_0 = findTF(var_79_4, "mask/img")

			setActive(var_80_0, true)

			var_80_0.anchoredPosition = var_79_5

			setImageSprite(var_80_0, arg_80_0, true)

			return
		end)
	end

	return
end

function GameRoomCookView:OnApplicationPaused()
	if not self.gameStartFlag then
		return
	end

	if self.readyStartFlag then
		return
	end

	if self.settlementFlag then
		return
	end

	if isActive(self.pauseUI) or isActive(self.leaveUI) then
		return
	end

	if not isActive(self.pauseUI) then
		setActive(self.pauseUI, true)
	end

	self:stopGame()

	return
end

function GameRoomCookView:controllerClear()
	self.judgesController:clear()
	self.charController:clear()

	return
end

function GameRoomCookView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomCookView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function GameRoomCookView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(GameRoomCookView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function GameRoomCookView:willExit()
	if self.cookGameUIAtlasStored then
		AssetBundleHelper.UnstoreAssetBundle(var_0_8.path, true)

		self.cookGameUIAtlasStored = false
	end

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	self:destroyController()

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	self.scrollRect.onValueChanged:RemoveAllListeners()

	Time.timeScale = 1
	self.timer = nil

	return
end

function GameRoomCookView:destroyController()
	return
end

return GameRoomCookView
