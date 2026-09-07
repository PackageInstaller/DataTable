local VolleyballGameView = class("VolleyballGameView", import("..BaseMiniGameView"))
local var_0_1 = {
	"maliluosi_2_DOA",
	"suixiang_2_doa",
	"xia_2_DOA",
	"haixiao_2_DOA",
	"zhixiao_2_DOA",
	"nvtiangou_2_DOA",
	"monika_2_DOA"
}
local var_0_2 = {
	10600010,
	10600020,
	10600030,
	10600040,
	10600050,
	10600060,
	10600070
}
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = -1
local var_0_6 = 0
local var_0_7 = 0.35
local var_0_8 = 0.15
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 0
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = 1.5
local var_0_16 = 1
local var_0_17 = 0.5
local var_0_18 = 0.5
local var_0_20 = 0.5
local var_0_21 = 0.76
local var_0_23 = -30
local var_0_24 = 50
local var_0_25 = 60
local var_0_26 = 230
local var_0_27 = 60
local var_0_28 = "event:/ui/ddldaoshu2"
local var_0_29 = "event:/ui/fighterplane_click"
local var_0_30 = "event:/ui/jieqiu"
local var_0_31 = "event:/ui/kouqiu"
local var_0_32 = 0.8
local var_0_33 = -1000

function VolleyballGameView:getUIName()
	return "VolleyballGameUI"
end

function VolleyballGameView:init()
	self.countTimeUI = self._tf:Find("count_time_ui")
	self.countTimeImage = self.countTimeUI:Find("time")
	self.countTimeNumImage = self.countTimeUI:Find("nums")
	self.mainUI = self._tf:Find("main_ui")
	self.returnBtn = self.mainUI:Find("return_btn")
	self.mainStartBtn = self.mainUI:Find("start_btn")
	self.ruleBtn = self.mainUI:Find("rule_btn")
	self.progressScroll = self.mainUI:Find("right_panel/scroll_view/")
	self.progressContent = self.mainUI:Find("right_panel/scroll_view/viewport/content")
	self.colors = self.mainUI:Find("right_panel/colors")
	self.icons = self.mainUI:Find("right_panel/icons")
	self.gotIcon = self.mainUI:Find("bg/got")
	self.selectUI = self._tf:Find("select_ui")
	self.selectBackBtn = self.selectUI:Find("back_btn")
	self.selectStartBtn = self.selectUI:Find("start_btn")
	self.tags = self.selectUI:Find("select_panel/tags")
	self.paints = self.selectUI:Find("select_panel/paints")
	self.freeTitle = self.selectUI:Find("select_panel/title/free")
	self.dayTitle = self.selectUI:Find("select_panel/title/challenge")
	self.titleDayNum = self.selectUI:Find("select_panel/title/challenge/num")
	self.ruleTxt = self.selectUI:Find("select_panel/rule/rule_txt")
	self.select4Chars = self.selectUI:Find("select_panel/chars")
	self.selectWindow = self.selectUI:Find("select_windows")
	self.selectSureBtn = self.selectWindow:Find("windows/sure_btn")
	self.select9Chars = self.selectWindow:Find("windows/char_layout")
	self.selectNum = self.selectWindow:Find("windows/tips/num")
	self.gameUI = self._tf:Find("game_ui")
	self.bgEffect = self.gameUI:Find("bg/shatanpaiqiu_hailang")
	self.hitEffect = self.gameUI:Find("shatanpaiqiu_jida")
	self.upEffect = self.gameUI:Find("shatanpaiqiu_jieqiu")
	self.ball = self.gameUI:Find("ball")
	self.ballShadow = self.gameUI:Find("ball_shadow")
	self.pauseBtn = self.gameUI:Find("pause_btn")
	self.backBtn = self.gameUI:Find("back_btn")
	self.qteBtn = self.gameUI:Find("qte_btn")
	self.pos = self.gameUI:Find("pos")

	self:initPos()

	self.ourScore = self.gameUI:Find("score/our")
	self.enemyScore = self.gameUI:Find("score/enemy")
	self.qte = self.gameUI:Find("qte")
	self.qteCircles = self.qte:Find("circles")
	self.qteCircle = self.qte:Find("circles/big")
	self.result = self.qte:Find("result")
	self.resultTxt = self.qte:Find("txts")
	self.cutin = self.gameUI:Find("cutin")
	self.cutinPaint = self.gameUI:Find("cutin/paint")
	self.cutinPaints = self.gameUI:Find("cutin_paints")
	self.scoreCutin = self.gameUI:Find("score_cutin")
	self.scoreCutinNums = self.gameUI:Find("score_cutin/nums")
	self.ourScoreCutin = self.gameUI:Find("score_cutin/our")
	self.enemyScoreCutin = self.gameUI:Find("score_cutin/enemy")
	self.charTF = {}
	self.charTF.our1 = self.gameUI:Find("char/our1")
	self.charTF.our2 = self.gameUI:Find("char/our2")
	self.charTF.enemy1 = self.gameUI:Find("char/enemy1")
	self.charTF.enemy2 = self.gameUI:Find("char/enemy2")
	self.charModels = {}
	self.charactor = {}
	self.cutinMask = self.gameUI:Find("cutin_mask")
	self.endUI = self._tf:Find("end_ui")
	self.endDayTitle = self.endUI:Find("title/race")
	self.endFreeTitle = self.endUI:Find("title/free")
	self.endTitleDay = self.endUI:Find("title/race/num")
	self.titleDays = self.endUI:Find("title_days")
	self.endOurScore = self.endUI:Find("score_panel/score/our")
	self.endEnemyScore = self.endUI:Find("score_panel/score/enemy")
	self.endScoreNums = self.endUI:Find("nums")
	self.sureBtn = self.endUI:Find("sure_btn")
	self.winTag = self.endUI:Find("score_panel/score/win")
	self.loseTag = self.endUI:Find("score_panel/score/lose")
	self.helpUI = self._tf:Find("help_ui")
	self.miniGameHudId = self:GetMiniGameHudId(ActivityConst.MINIGAME_VOLLEYBALL)
	self.miniGameId = self:GetDOA2MiniGameId(ActivityConst.MINIGAME_VOLLEYBALL)

	return
end

function VolleyballGameView:initPos()
	self.orgPos = {}
	self.orgPos.our_serve = self.pos:Find("our_pos/serve_pos").anchoredPosition
	self.orgPos.our1 = self.pos:Find("our_pos/drop_pos1").anchoredPosition
	self.orgPos.our2 = self.pos:Find("our_pos/drop_pos2").anchoredPosition
	self.orgPos.enemy_serve = self.pos:Find("enemy_pos/serve_pos").anchoredPosition
	self.orgPos.enemy1 = self.pos:Find("enemy_pos/drop_pos1").anchoredPosition
	self.orgPos.enemy2 = self.pos:Find("enemy_pos/drop_pos2").anchoredPosition

	self:resetPos()

	return
end

function VolleyballGameView:resetPos()
	self.anchoredPos = Clone(self.orgPos)
	self.anchoredPos.our1 = self:getRandomPos("our1")
	self.anchoredPos.our2 = self:getRandomPos("our2")
	self.anchoredPos.enemy1 = self:getRandomPos("enemy1")
	self.anchoredPos.enemy2 = self:getRandomPos("enemy2")

	return
end

function VolleyballGameView:GetMiniGameHudId(arg_5_1)
	if not pg.activity_template[arg_5_1] then
		return nil
	end

	return pg.activity_template[arg_5_1].config_id
end

function VolleyballGameView:GetDOA2MiniGameId(arg_6_1)
	if not pg.activity_template[arg_6_1] then
		error("未找到对应DOA活动ID")

		return nil
	end

	local var_6_0 = pg.activity_template[arg_6_1].config_id

	for iter_6_0 = #pg.mini_game.all, 1, -1 do
		if pg.mini_game[pg.mini_game.all[iter_6_0]] and pg.mini_game[pg.mini_game.all[iter_6_0]].hub_id == var_6_0 then
			return pg.mini_game.all[iter_6_0]
		end
	end

	error("未找到对应DOA活动的miniGameID")

	return nil
end

function VolleyballGameView:didEnter()
	onButton(self, self.returnBtn, function()
		self:emit(VolleyballGameView.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.ruleBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("venusvolleyball_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.mainStartBtn, function()
		setActive(self.selectUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.selectUI)
		self:initSelectUI()

		return
	end, SFX_PANEL)
	onButton(self, self.selectBackBtn, function()
		setActive(self.selectUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.selectUI, self._tf)

		return
	end, SFX_PANEL)

	self.canStartGame = false

	onButton(self, self.selectStartBtn, function()
		if not self.canStartGame then
			return
		end

		setActive(self.mainUI, false)
		setActive(self.selectUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.selectUI, self._tf)
		setActive(self.gameUI, true)
		self:resetGameData()

		if self.isFirstgame == 0 then
			self:firstShow(function()
				self:startCountTimer()

				return
			end)
		else
			self:startCountTimer()
		end

		return
	end, SFX_PANEL)

	self.canSureChar = false

	onButton(self, self.selectSureBtn, function()
		if not self.canSureChar then
			return
		end

		if self.selectCharCamp == "enemy" then
			self.charNames.enemy1 = var_0_1[self.selectSDIndex1]
			self.charNames.enemy2 = var_0_1[self.selectSDIndex2]
		elseif self.selectCharCamp == "our" then
			self.charNames.our1 = var_0_1[self.selectSDIndex1]
			self.charNames.our2 = var_0_1[self.selectSDIndex2]
		end

		setActive(self.selectWindow, false)
		self:refreshSelectUI()

		return
	end, SFX_PANEL)
	onButton(self, self.selectWindow:Find("mask"), function()
		setActive(self.selectWindow, false)

		return
	end, SFX_PANEL)
	onButton(self, self.pauseBtn, function()
		if not self.btnAvailable then
			return
		end

		self:pauseGame()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("venusvolleyball_suspend_tip"),
			onNo = function()
				self:resumeGame()

				return
			end,
			onYes = function()
				self:resumeGame()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if not self.btnAvailable then
			return
		end

		self:pauseGame()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("venusvolleyball_return_tip"),
			onNo = function()
				self:resumeGame()

				return
			end,
			onYes = function()
				self:endGame()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.qteBtn, function()
		if self.qteBtnStatus == var_0_5 then
			return
		end

		self:qteResult()

		return
	end)
	onButton(self, self.sureBtn, function()
		setActive(self.mainUI, true)
		self:initMainUI()
		setActive(self.gameUI, false)
		setActive(self.endUI, false)
		self:clearSpineChars()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.endUI, self._tf)

		return
	end, SFX_PANEL)
	self:initMainUI()

	return
end

function VolleyballGameView:playEffect(arg_24_1, arg_24_2)
	arg_24_1.anchoredPosition = arg_24_2 and arg_24_2 or self.ball.anchoredPosition

	setActive(arg_24_1, false)
	setActive(arg_24_1, true)

	return
end

function VolleyballGameView:getGameData()
	self.mgProxy = getProxy(MiniGameProxy)
	self.hubData = self.mgProxy:GetHubByHubId(self.miniGameHudId)

	if self.hubData.ultimate == 0 then
		self.curDay = self.hubData.usedtime + 1 or 8
	end

	self.unlockDay = self.hubData.usedtime + self.hubData.count

	if self.curDay <= self.unlockDay then
		self.curDay = self.curDay or self.unlockDay
	end

	self.mgData = self.mgProxy:GetMiniGameData(self.miniGameId)
	self.endScore = self.mgData:GetSimpleValue("endScore")[self.curDay]
	self.storylist = self.mgData:GetSimpleValue("story")
	self.isFirstgame = PlayerPrefs.GetInt("volleyballgame_first_" .. getProxy(PlayerProxy):getData().id)

	return
end

function VolleyballGameView:getEnemyCharsIndex()
	return self.mgData:GetSimpleValue("mainChar")[self.curDay], self.mgData:GetSimpleValue("minorChar")[self.curDay]
end

function VolleyballGameView:initMainUI()
	self.isInGame = false

	self:getGameData()

	if self.hubData.ultimate == 0 and self.hubData.usedtime >= self.hubData:getConfig("reward_need") then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.hubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	self.isFree = self.hubData.ultimate ~= 0

	setActive(self.mainStartBtn:Find("free_tag"), self.isFree)
	setActive(self.gotIcon, self.isFree)
	eachChild(self.progressContent, function(arg_28_0)
		local var_28_0 = ""
		local var_28_1 = tonumber(arg_28_0.name)
		local var_28_2 = var_0_1[self.mgData:GetSimpleValue("mainChar")[var_28_1]]

		setActive(arg_28_0:Find("char_bg/mask"), false)
		setActive(arg_28_0:Find("name_bg/mask"), false)
		setActive(arg_28_0:Find("pass"), false)

		if var_28_1 == self.curDay and self.hubData.count > 0 then
			var_28_0 = "red"

			setImageSprite(arg_28_0:Find("char_bg/icon"), self.icons:Find(self:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
		elseif var_28_1 < self.curDay or var_28_1 == self.curDay and self.hubData.count == 0 then
			var_28_0 = "grey"

			setImageSprite(arg_28_0:Find("char_bg/icon"), self.icons:Find(self:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
			setActive(arg_28_0:Find("char_bg/mask"), true)
			setActive(arg_28_0:Find("name_bg/mask"), true)
			setActive(arg_28_0:Find("pass"), true)
		elseif var_28_1 > self.curDay and var_28_1 <= self.unlockDay then
			var_28_0 = "blue"

			setImageSprite(arg_28_0:Find("char_bg/icon"), self.icons:Find(self:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
		else
			var_28_0 = "grey"

			setImageSprite(arg_28_0:Find("char_bg/icon"), self.colors:Find("unkonwn"):GetComponent(typeof(Image)).sprite)
		end

		setImageSprite(arg_28_0:Find("name_bg"), self.colors:Find(var_28_0):GetComponent(typeof(Image)).sprite)

		return
	end)

	self.progressContent.anchoredPosition = {
		x = 0,
		y = math.min(645, (self.curDay - 1) * 215)
	}

	onScroll(self, self.progressScroll, function(arg_29_0)
		setActive(self.mainUI:Find("right_panel/arraws_up"), arg_29_0.y < 1 and true or false)
		setActive(self.mainUI:Find("right_panel/arraws_down"), arg_29_0.y > 0 and true or false)

		return
	end)

	return
end

function VolleyballGameView:initSelectUI()
	setActive(self.freeTitle, self.isFree)
	setActive(self.dayTitle, not self.isFree)
	setText(self.titleDayNum, self.curDay)
	setText(self.ruleTxt, i18n("venusvolleyball_rule_tip", self.endScore))

	self.charNames = {}
	self.lastSelectNames = {}

	eachChild(self.select4Chars, function(arg_31_0)
		local var_31_0 = arg_31_0.name

		onButton(self, arg_31_0, function()
			if not self.isFree and string.find(var_31_0, "enemy") then
				return
			end

			self.selectCharCamp = string.find(var_31_0, "enemy") and "enemy" or "our"

			self:openSelectWindow()

			return
		end)

		return
	end)

	if not self.isFree then
		local var_30_0, var_30_1 = self:getEnemyCharsIndex()

		self.charNames.enemy1, self.charNames.enemy2 = var_0_1[var_30_0], var_0_1[var_30_1]
	end

	self:refreshSelectUI()

	return
end

function VolleyballGameView:getCharIndex(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(var_0_1) do
		if iter_33_1 == arg_33_1 then
			return iter_33_0
		end
	end

	return 1
end

function VolleyballGameView:refreshSelectUI()
	eachChild(self.select4Chars, function(arg_35_0)
		if self.charNames[arg_35_0.name] then
			setActive(arg_35_0:Find("select_btn"), false)
			setActive(arg_35_0:Find("char"), true)
			setImageSprite(arg_35_0:Find("char/icon"), self.paints:Find(self:getCharIndex(self.charNames[arg_35_0.name])):GetComponent(typeof(Image)).sprite, true)
			setImageSprite(arg_35_0:Find("char/tag"), self.tags:Find(self:getCharIndex(self.charNames[arg_35_0.name])):GetComponent(typeof(Image)).sprite, true)
		else
			setActive(arg_35_0:Find("select_btn"), true)
			setActive(arg_35_0:Find("char"), false)
		end

		return
	end)

	self.canStartGame = not not (self.charNames.our1 and self.charNames.our2 and self.charNames.enemy1 and self.charNames.enemy2)

	setGray(self.selectStartBtn, not self.canStartGame, not self.canStartGame)

	return
end

function VolleyballGameView:isSelected(arg_36_1, arg_36_2)
	local var_36_0 = false

	for iter_36_0, iter_36_1 in pairs(self.charNames) do
		if arg_36_1 == iter_36_1 then
			var_36_0 = not string.find(iter_36_0, arg_36_2)
		end
	end

	return var_36_0
end

function VolleyballGameView:openSelectWindow()
	setActive(self.selectWindow, true)

	self.hasSelectNum = 0

	setText(self.selectNum, setColorStr(self.hasSelectNum, COLOR_GREEN) .. "/2")

	self.selectSDIndex1 = nil
	self.selectSDIndex2 = nil

	eachChild(self.select9Chars, function(arg_38_0)
		local var_38_0 = tonumber(arg_38_0.name)

		setImageSprite(arg_38_0:Find("char/frame/icon"), self.icons:Find(var_38_0):GetComponent(typeof(Image)).sprite, true)
		onButton(self, arg_38_0, function()
			if self:isSelected(var_0_1[var_38_0], self.selectCharCamp) then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_29)

			if isActive(arg_38_0:Find("selected")) then
				setActive(arg_38_0:Find("selected"), false)

				if self.selectSDIndex1 and self.selectSDIndex1 == var_38_0 then
					self.selectSDIndex1 = nil
				end

				if self.selectSDIndex2 and self.selectSDIndex2 == var_38_0 then
					self.selectSDIndex2 = nil
				end

				self.hasSelectNum = self.hasSelectNum - 1
			elseif self.selectSDIndex1 and self.selectSDIndex2 then
				-- block empty
			elseif self.selectSDIndex1 then
				self.selectSDIndex2 = var_38_0
				self.hasSelectNum = self.hasSelectNum + 1
			else
				self.selectSDIndex1 = var_38_0
				self.hasSelectNum = self.hasSelectNum + 1
			end

			self:refreshSelectWindow()

			return
		end)

		return
	end)
	self:refreshSelectWindow()

	return
end

function VolleyballGameView:refreshSelectWindow()
	eachChild(self.select9Chars, function(arg_41_0)
		local var_41_0 = tonumber(arg_41_0.name)

		setActive(arg_41_0:Find("char/mask"), self:isSelected(var_0_1[var_41_0], self.selectCharCamp) and true or false)

		if var_41_0 == self.selectSDIndex1 or var_41_0 == self.selectSDIndex2 then
			setActive(arg_41_0:Find("selected"), true)
		else
			setActive(arg_41_0:Find("selected"), false)
		end

		return
	end)
	setText(self.selectNum, setColorStr(self.hasSelectNum, COLOR_GREEN) .. "/2")

	self.canSureChar = not not (self.selectSDIndex1 and self.selectSDIndex2)

	setGray(self.selectSureBtn, not self.canSureChar, not self.canSureChar)

	return
end

function VolleyballGameView:firstShow(arg_42_1)
	setActive(self.helpUI, true)
	pg.UIMgr.GetInstance():BlurPanel(self.helpUI)
	onButton(self, self.helpUI, function()
		PlayerPrefs.SetInt("volleyballgame_first_" .. getProxy(PlayerProxy):getData().id, 1)
		setActive(self.helpUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.helpUI, self._tf)

		if arg_42_1 then
			arg_42_1()
		end

		return
	end, SFX_PANEL)

	return
end

function VolleyballGameView:startCountTimer()
	self:setBtnAvailable(false)
	setActive(self.countTimeUI, true)
	pg.UIMgr.GetInstance():BlurPanel(self.countTimeUI)

	self.countTime = 3

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_28)
	setImageSprite(self.countTimeImage, self.countTimeNumImage:Find(self.countTime):GetComponent(typeof(Image)).sprite)

	local function var_44_0()
		self.countTime = self.countTime - 1

		if self.countTime <= 0 then
			setActive(self.countTimeUI, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.countTimeUI, self._tf)
			self:resetGameAni()
			self:startGame()
		else
			setImageSprite(self.countTimeImage, self.countTimeNumImage:Find(self.countTime):GetComponent(typeof(Image)).sprite)
		end

		return
	end

	if self.countTimer then
		self.countTimer:Reset(var_44_0, 1, -1)
	else
		self.countTimer = Timer.New(var_44_0, 1, -1)
	end

	self.countTimer:Start()

	return
end

function VolleyballGameView:setBtnAvailable(arg_46_1)
	self.btnAvailable = arg_46_1

	setGray(self.backBtn, not arg_46_1, not arg_46_1)
	setGray(self.pauseBtn, not arg_46_1, not arg_46_1)

	return
end

function VolleyballGameView:startGame()
	self.isInGame = true

	self:setBtnAvailable(true)
	setActive(self.bgEffect, false)
	setActive(self.bgEffect, true)

	if self.beginTeam == var_0_3 then
		self:ourServe(function()
			self:enemyUp2Up(function()
				self:enemyUp2Hit(function()
					self:enemyThrow(function()
						self:enterLoop()

						return
					end)

					return
				end)

				return
			end)

			return
		end)
	else
		self:enemyServe(function()
			self:enterLoop()

			return
		end)
	end

	return
end

function VolleyballGameView:enterLoop()
	self:ourUp2Up(function()
		self:ourUp2Hit(function()
			self:ourThrow(function()
				self:enemyUp2Up(function()
					self:enemyUp2Hit(function()
						self:enemyThrow(function()
							self:enterLoop()

							return
						end)

						return
					end)

					return
				end)

				return
			end)

			return
		end)

		return
	end)

	return
end

function VolleyballGameView:ourServe(arg_60_1)
	self.ballPosTag = "our_serve"

	setActive(self.ball, true)
	self:charServeBall()
	self:managedTween(LeanTween.delayedCall, function()
		local var_61_0 = "enemy" .. math.random(2)

		self.ballPosTag = var_61_0
		self.anchoredPos[self.ballPosTag] = self:getRandomPos(self.ballPosTag)

		self:ballServe(self.ball, var_0_15, self.anchoredPos[var_61_0], function()
			if arg_60_1 then
				arg_60_1()
			end

			return
		end)
		self:managedTween(LeanTween.delayedCall, function()
			self:charUpBall()

			return
		end, var_0_15 - var_0_21, nil)

		return
	end, var_0_20 + 0.5, nil)

	return
end

function VolleyballGameView:enemyServe(arg_64_1)
	self.ballPosTag = "enemy_serve"

	setActive(self.ball, true)
	self:charServeBall()
	self:managedTween(LeanTween.delayedCall, function()
		local var_65_0 = "our" .. math.random(2)

		self.ballPosTag = var_65_0
		self.anchoredPos[self.ballPosTag] = self:getRandomPos(self.ballPosTag)

		self:ballServe(self.ball, var_0_15, self.anchoredPos[var_65_0], function()
			if arg_64_1 then
				arg_64_1()
			end

			return
		end)
		self:managedTween(LeanTween.delayedCall, function()
			self:charUpBall()

			return
		end, var_0_15 - var_0_21, nil)

		return
	end, var_0_20 + 0.5, nil)

	return
end

function VolleyballGameView:ourUp2Up(arg_68_1)
	if self.qteStatus == var_0_11 and self.qteType == var_0_13 then
		self:ourFly()

		return
	end

	self.ballPosTag = self.ballPosTag == "our1" and "our2" or "our1"

	self:ballUp2Up(self.ball, var_0_16, self.anchoredPos[self.ballPosTag], function()
		if arg_68_1 then
			arg_68_1()
		end

		return
	end)
	self:managedTween(LeanTween.delayedCall, function()
		self:charUpBall()

		return
	end, 0.3, nil)

	return
end

function VolleyballGameView:ourUp2Hit(arg_71_1)
	local var_71_0 = {}

	self.ballPosTag = self.ballPosTag == "our1" and "our2" or "our1"
	self.anchoredPos[self.ballPosTag] = self:getRandomPos(self.ballPosTag)
	self.qteType = var_0_14

	self:charHitBall()

	local var_71_1 = false

	local function var_71_2(arg_72_0)
		if var_71_1 then
			arg_72_0()
		else
			var_71_1 = true
		end

		return
	end

	table.insert(var_71_0, function(arg_73_0)
		local function var_73_0()
			if self.isCutin then
				self:showcutin(function()
					self.isCutin = false

					arg_73_0()

					return
				end)
			else
				arg_73_0()
			end

			return
		end

		self:managedTween(LeanTween.delayedCall, function()
			var_71_2(var_73_0)

			return
		end, var_0_16 - 0.2, nil)
		self:managedTween(LeanTween.delayedCall, function()
			self:startQTE(var_0_32, 200, self.anchoredPos[self.ballPosTag], function()
				var_71_2(var_73_0)

				return
			end)

			return
		end, var_0_16 - var_0_32 - 0.2, nil)

		return
	end)
	table.insert(var_71_0, function(arg_79_0)
		self:ballUp2Hit(self.ball, var_0_16, self.anchoredPos[self.ballPosTag], arg_79_0)

		return
	end)
	parallelAsync(var_71_0, function()
		if arg_71_1 then
			arg_71_1()
		end

		return
	end)

	return
end

function VolleyballGameView:ourThrow(arg_81_1)
	local var_81_0 = "enemy" .. math.random(2)

	self.ballPosTag = var_81_0
	self.anchoredPos[self.ballPosTag] = self:getRandomPos(self.ballPosTag)

	self:ballHit(self.ball, var_0_17, self.anchoredPos[var_81_0], function()
		if arg_81_1 then
			arg_81_1()
		end

		return
	end)
	self:charUpBall()

	return
end

function VolleyballGameView:enemyUp2Up(arg_83_1)
	if self.qteStatus == var_0_10 and self.qteType == var_0_14 then
		self:enemyFly()

		return
	end

	self.ballPosTag = self.ballPosTag == "enemy1" and "enemy2" or "enemy1"

	self:ballUp2Up(self.ball, var_0_16, self.anchoredPos[self.ballPosTag], function()
		if arg_83_1 then
			arg_83_1()
		end

		return
	end)
	self:managedTween(LeanTween.delayedCall, function()
		self:charUpBall()

		return
	end, 0.3, nil)

	return
end

function VolleyballGameView:enemyUp2Hit(arg_86_1)
	self.ballPosTag = self.ballPosTag == "enemy1" and "enemy2" or "enemy1"
	self.anchoredPos[self.ballPosTag] = self:getRandomPos(self.ballPosTag)
	self.randomQtePos = "our" .. math.random(2)
	self.anchoredPos[self.randomQtePos] = self:getRandomPos(self.randomQtePos)
	self.qteType = var_0_13

	self:managedTween(LeanTween.delayedCall, function()
		self:startQTE(var_0_32, 0, self.anchoredPos[self.randomQtePos])

		return
	end, var_0_16 - var_0_32, nil)
	self:ballUp2Hit(self.ball, var_0_16, self.anchoredPos[self.ballPosTag], function()
		if arg_86_1 then
			arg_86_1()
		end

		return
	end)
	self:charHitBall()

	return
end

function VolleyballGameView:enemyThrow(arg_89_1)
	self.ballPosTag = self.randomQtePos

	self:ballHit(self.ball, var_0_17, self.anchoredPos[self.ballPosTag], function()
		if arg_89_1 then
			arg_89_1()
		end

		return
	end)
	self:charUpBall()

	return
end

function VolleyballGameView:ourFly()
	self.ballPosTag = "out"

	self:hitFly(self.ball, var_0_18, {
		x = -math.random(1000, 1100),
		y = math.random(0, 200) - 100
	}, function()
		self.qteStatus = var_0_9

		setGray(self.qteBtn, true, true)

		self.enemyScoreNum = self.enemyScoreNum + 1

		self:updateScore()

		return
	end)

	return
end

function VolleyballGameView:enemyFly()
	self.ballPosTag = "out"

	self:hitFly(self.ball, var_0_18, {
		x = math.random(1000, 1100),
		y = math.random(0, 200) - 100
	}, function()
		self.qteStatus = var_0_9

		setGray(self.qteBtn, true, true)

		self.ourScoreNum = self.ourScoreNum + 1

		self:updateScore()

		return
	end)

	return
end

function VolleyballGameView:qteSuccess()
	self.qteStatus = var_0_10
	self.beginTeam = var_0_3

	self:changeQTEBtnStatus(var_0_5)

	return
end

function VolleyballGameView:qteFail()
	self.qteStatus = var_0_11
	self.beginTeam = var_0_4

	self:changeQTEBtnStatus(var_0_5)

	return
end

function VolleyballGameView:GetBeziersPoints(arg_97_1, arg_97_2, arg_97_3, arg_97_4)
	local function var_97_0(arg_98_0)
		return arg_97_1:Clone():Mul((1 - arg_98_0) * (1 - arg_98_0)):Clone():Add((arg_97_2:Clone():Mul(2 * arg_98_0 * (1 - arg_98_0)))):Add((arg_97_3:Clone():Mul(arg_98_0 * arg_98_0)))
	end

	local var_97_1 = {}

	table.insert(var_97_1, Vector3(0, 0, 0))
	table.insert(var_97_1, var_97_0(0))

	for iter_97_0 = 1, arg_97_4 do
		table.insert(var_97_1, var_97_0(iter_97_0 / arg_97_4))
	end

	table.insert(var_97_1, Vector3(0, 0, 0))

	return var_97_1
end

function VolleyballGameView:ballParabolaMove(arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5, arg_99_6)
	local var_99_0 = Vector2(arg_99_1.anchoredPosition.x, arg_99_1.anchoredPosition.y - arg_99_5)
	local var_99_1 = Vector2(arg_99_3.x, arg_99_3.y)
	local var_99_2 = var_99_1.x - var_99_0.x
	local var_99_3 = var_99_1.y - var_99_0.y
	local var_99_4 = math.abs(arg_99_6 - arg_99_5)
	local var_99_5 = DOAParabolaCalc(arg_99_2, math.abs(var_0_33), var_99_4)
	local var_99_10 = math.sqrt(2 * math.abs(var_0_33) * (arg_99_5 < arg_99_6 and var_99_5 + var_99_4 or var_99_5))

	self:managedTween(LeanTween.value, function()
		if arg_99_4 then
			arg_99_4()
		end

		return
	end, go(arg_99_1), 0, arg_99_2, arg_99_2):setOnUpdate(System.Action_float(function(arg_101_0)
		arg_99_1.anchoredPosition = Vector2(var_99_0.x + var_99_2 * arg_101_0 / arg_99_2, var_99_0.y + var_99_3 * arg_101_0 / arg_99_2 + arg_99_5 + (var_99_10 * arg_101_0 + 0.5 * var_0_33 * arg_101_0 * arg_101_0))

		return
	end))

	return
end

function VolleyballGameView:ballServe(arg_102_1, arg_102_2, arg_102_3, arg_102_4)
	self:ballParabolaMove(arg_102_1, arg_102_2, arg_102_3, function()
		if arg_102_4 then
			arg_102_4()
		end

		return
	end, var_0_24, var_0_25)
	self:managedTween(LeanTween.move, nil, self.ballShadow, Vector3(arg_102_3.x, arg_102_3.y + var_0_23), arg_102_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:ballUp2Up(arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	self:ballParabolaMove(arg_104_1, arg_104_2, arg_104_3, function()
		if arg_104_4 then
			arg_104_4()
		end

		return
	end, var_0_25, var_0_25)
	self:managedTween(LeanTween.move, nil, self.ballShadow, Vector3(arg_104_3.x, arg_104_3.y + var_0_23), arg_104_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:ballUp2Hit(arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	self:ballParabolaMove(arg_106_1, arg_106_2, {
		x = arg_106_3.x,
		y = arg_106_3.y
	}, function()
		if arg_106_4 then
			arg_106_4()
		end

		return
	end, var_0_25, var_0_26)
	self:managedTween(LeanTween.move, nil, self.ballShadow, Vector3(arg_106_3.x, arg_106_3.y + var_0_23), arg_106_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:ballHit(arg_108_1, arg_108_2, arg_108_3, arg_108_4)
	arg_108_3 = Vector2(arg_108_3.x, arg_108_3.y + var_0_25)

	self:managedTween(LeanTween.moveX, function()
		if arg_108_4 then
			arg_108_4()
		end

		return
	end, arg_108_1, arg_108_3.x, arg_108_2):setEase(LeanTweenType.linear)
	self:managedTween(LeanTween.moveY, nil, arg_108_1, arg_108_3.y, arg_108_2):setEase(LeanTweenType.linear)
	self:managedTween(LeanTween.move, nil, self.ballShadow, Vector3(arg_108_3.x, arg_108_3.y + var_0_23), arg_108_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:charMove(arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	self:managedTween(LeanTween.moveX, nil, arg_110_1, arg_110_3.x, arg_110_2):setEase(LeanTweenType.easeOutQuad)
	self:managedTween(LeanTween.moveY, function()
		if arg_110_4 then
			arg_110_4()
		end

		return
	end, arg_110_1, arg_110_3.y, arg_110_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:hitFly(arg_112_1, arg_112_2, arg_112_3, arg_112_4)
	self:ballParabolaMove(arg_112_1, arg_112_2, arg_112_3, function()
		if arg_112_4 then
			arg_112_4()
		end

		return
	end, var_0_27, var_0_26)
	self:managedTween(LeanTween.move, nil, self.ballShadow, Vector3(arg_112_3.x, arg_112_3.y + var_0_23), arg_112_2):setEase(LeanTweenType.linear)

	return
end

function VolleyballGameView:startQTE(arg_114_1, arg_114_2, arg_114_3, arg_114_4)
	self:changeQTEBtnStatus(var_0_6)

	self.qte.anchoredPosition = {
		x = arg_114_3.x,
		y = arg_114_3.y + arg_114_2
	}

	setActive(self.qte, true)
	setActive(self.qteCircles, true)
	setActive(self.result, false)
	setLocalScale(self.qteCircle, Vector3(1, 1, 1))
	self.result:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_115_0)
		setActive(self.result, false)

		return
	end)

	self.qteCallback = arg_114_4
	self.qteTween = LeanTween.scale(self.qteCircle, Vector3(0, 0, 1), arg_114_1):setOnComplete(System.Action(function()
		self:changeQTEBtnStatus(var_0_5)
		setImageSprite(self.result, self.resultTxt:Find("miss"):GetComponent(typeof(Image)).sprite, true)
		setActive(self.result, true)
		self:qteFail()

		self.isCutin = false

		setActive(self.qteCircles, false)
		existCall(self.qteCallback)

		self.qteCallback = nil

		return
	end)).uniqueId

	return
end

function VolleyballGameView:qteResult()
	if LeanTween.isTweening(self.qteTween) then
		LeanTween.cancel(self.qteTween, false)
	end

	local var_117_0 = math.abs(self.qteCircle.localScale.x)

	setActive(self.result, true)

	self.isCutin = false

	if var_117_0 > 0 then
		if var_117_0 > var_0_7 then
			setImageSprite(self.result, self.resultTxt:Find("miss"):GetComponent(typeof(Image)).sprite, true)
			self:qteFail()
		elseif var_117_0 > var_0_8 then
			setImageSprite(self.result, self.resultTxt:Find("good"):GetComponent(typeof(Image)).sprite, true)
			self:qteSuccess()
		end
	end

	setImageSprite(self.result, self.resultTxt:Find("perfect"):GetComponent(typeof(Image)).sprite, true)
	self:qteSuccess()

	self.isCutin = self.qteType == var_0_14

	setActive(self.qteCircles, false)
	existCall(self.qteCallback)

	self.qteCallback = nil

	return
end

local function var_0_34(arg_118_0, arg_118_1, arg_118_2, arg_118_3, arg_118_4)
	local var_118_0 = {
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}

	function var_118_0.ctor(arg_119_0)
		var_118_0._tf.anchoredPosition = arg_118_0.anchoredPos[arg_118_4]

		return
	end

	function var_118_0.setPosTag(arg_120_0, arg_120_1)
		var_118_0._tf.anchoredPosition = arg_118_0.anchoredPos[arg_120_1]
		var_118_0.posTag = arg_120_1

		return
	end

	function var_118_0.getPosTag(arg_121_0)
		return var_118_0.posTag
	end

	function var_118_0.pauseSpine(arg_122_0)
		var_118_0.skele.timeScale = 0

		return
	end

	function var_118_0.resumeSpine(arg_123_0)
		var_118_0.skele.timeScale = 1

		return
	end

	function var_118_0.setActionOnce(arg_124_0, arg_124_1, arg_124_2)
		var_118_0.spineAnim:SetActionCallBack(function(arg_125_0)
			if arg_125_0 == "action" then
				if arg_124_1 == "chuanqiu" or arg_124_1 == "dianqiu" then
					arg_118_0:playEffect(arg_118_0.upEffect, Vector2(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_25))
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_30)
				elseif arg_124_1 == "kouqiu" then
					arg_118_0:playEffect(arg_118_0.hitEffect, Vector2(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_25 + var_0_26))
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_31)
				elseif arg_124_1 == "faqiu" then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_30)
					arg_118_0:playEffect(arg_118_0.upEffect, Vector2(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_24))
				end
			end

			if arg_125_0 == "finish" then
				var_118_0.spineAnim:SetActionCallBack(nil)

				if arg_124_2 then
					arg_124_2()
				else
					var_118_0.spineAnim:SetAction("normal2", 0)
				end
			end

			return
		end)
		var_118_0.spineAnim:SetAction(arg_124_1, 0)

		return
	end

	function var_118_0.move(arg_126_0, arg_126_1, arg_126_2, arg_126_3, arg_126_4)
		local function var_126_0()
			var_118_0.spineAnim:SetAction("run", 0)

			var_118_0.posTag = arg_126_2

			arg_118_0:charMove(var_118_0._tf, arg_126_1, arg_118_0.anchoredPos[arg_126_2], function()
				if arg_126_4 then
					arg_126_4()
				else
					var_118_0.spineAnim:SetAction("normal2", 0)
				end

				return
			end)

			return
		end

		if arg_126_3 then
			var_118_0:setActionOnce(arg_126_3, function()
				var_126_0()

				return
			end)
		else
			var_126_0()
		end

		return
	end

	var_118_0:ctor()

	return var_118_0
end

function VolleyballGameView:getRandomPos(arg_130_1)
	local var_130_0 = math.random(0, 300)
	local var_130_1 = math.random(0, 50)

	return string.find(arg_130_1, "our") and {
		x = self.orgPos[arg_130_1].x + var_130_0 - 50,
		y = self.orgPos[arg_130_1].y + var_130_1 - 25
	} or {
		x = self.orgPos[arg_130_1].x + var_130_0 - 250,
		y = self.orgPos[arg_130_1].y + var_130_1 - 25
	}
end

function VolleyballGameView:loadSpineChars()
	self:clearSpineChars()

	self.beginTeam = math.random(2)
	self.serveChar = self.beginTeam == var_0_3 and "our" .. math.random(2) or "enemy" .. math.random(2)

	self:setBallPos()

	for iter_131_0, iter_131_1 in pairs(self.charNames) do
		self:loadOneSpineChar(iter_131_0, self.serveChar)
	end

	return
end

function VolleyballGameView:loadOneSpineChar(arg_132_1, arg_132_2)
	if not self.charNames[arg_132_1] then
		self.charNames[arg_132_1] = false

		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(self.charNames[arg_132_1], true, function(arg_133_0)
		pg.UIMgr.GetInstance():LoadingOff()

		local var_133_1

		if string.find(arg_132_1, "our") then
			tf(arg_133_0).localScale = Vector3(0.6, 0.6, 1)
			tf(arg_133_0).localPosition = Vector3(-20, 0, 0)
			var_133_1 = string.find(arg_132_1, "1") and "our1" or "our2"
		else
			tf(arg_133_0).localScale = Vector3(-0.6, 0.6, 1)
			tf(arg_133_0).localPosition = Vector3(20, 0, 0)
			var_133_1 = string.find(arg_132_1, "1") and "enemy1" or "enemy2"
		end

		self.charModels[arg_132_1] = arg_133_0

		local var_133_2 = arg_133_0:GetComponent("SpineAnimUI")
		local var_133_3 = arg_133_0:GetComponent("SkeletonGraphic")

		var_133_2:SetAction("normal2", 0)

		var_133_3.timeScale = 1

		local var_133_4 = self._tf:Find("game_ui/char/" .. arg_132_1)

		setParent(arg_133_0, var_133_4)

		self.charactor[arg_132_1] = var_0_34(self, var_133_4, var_133_2, var_133_3, var_133_1)

		if arg_132_1 == arg_132_2 then
			if self.beginTeam == var_0_3 then
				self.charactor[arg_132_1]:setPosTag("our_serve")
			else
				self.charactor[arg_132_1]:setPosTag("enemy_serve")
			end
		end

		return
	end)

	return
end

function VolleyballGameView:clearSpineChars()
	for iter_134_0, iter_134_1 in pairs(self.charModels) do
		if self.charModels[iter_134_0] and self.charNames[iter_134_0] then
			PoolMgr.GetInstance():ReturnSpineChar(self.charNames[iter_134_0], self.charModels[iter_134_0])
		end
	end

	self.charModels = {}

	return
end

function VolleyballGameView:getCharWithTag(arg_135_1)
	for iter_135_0, iter_135_1 in pairs(self.charactor) do
		if iter_135_1:getPosTag() == arg_135_1 then
			return iter_135_0, iter_135_1
		end
	end

	return nil
end

function VolleyballGameView:getAnotherChar(arg_136_1)
	local var_136_0 = ""

	if string.find(arg_136_1, "our") then
		var_136_0 = arg_136_1 == "our1" and "our2" or "our1"
	elseif string.find(arg_136_1, "enemy") then
		var_136_0 = arg_136_1 == "enemy1" and "enemy2" or "enemy1"
	end

	return var_136_0, self.charactor[var_136_0]
end

function VolleyballGameView:setBallPos()
	setActive(self.ball, true)

	local var_137_0 = string.find(self.serveChar, "our") and "our_serve" or "enemy_serve"

	self.ball.anchoredPosition = {
		x = self.orgPos[var_137_0].x,
		y = self.orgPos[var_137_0].y + 300
	}
	self.ballShadow.anchoredPosition = Vector3(self.orgPos[var_137_0].x, self.orgPos[var_137_0].y, 0)

	self:managedTween(LeanTween.rotate, nil, self.ball, 360, 0.5):setLoopClamp()

	return
end

function VolleyballGameView:resetChar()
	self:resetPos()

	for iter_138_0, iter_138_1 in pairs(self.charactor) do
		if LeanTween.isTweening(go(iter_138_1._tf)) then
			LeanTween.cancel(go(iter_138_1._tf))
		end
	end

	self.charactor.our1:setPosTag("our1")
	self.charactor.our2:setPosTag("our2")
	self.charactor.enemy1:setPosTag("enemy1")
	self.charactor.enemy2:setPosTag("enemy2")

	if self.beginTeam == var_0_3 then
		self.serveChar = "our" .. math.random(2)

		self.charactor[self.serveChar]:setPosTag("our_serve")
	else
		self.serveChar = "enemy" .. math.random(2)

		self.charactor[self.serveChar]:setPosTag("enemy_serve")
	end

	self:setBallPos()

	return
end

function VolleyballGameView:charServeBall()
	self:managedTween(LeanTween.rotate, nil, self.ball, 360, 0.5):setLoopClamp()

	local var_139_0 = string.find(self.serveChar, "our") and "our_serve" or "enemy_serve"

	self:managedTween(LeanTween.delayedCall, function()
		self:managedTween(LeanTween.moveY, nil, self.ball, self.orgPos[var_139_0].y + var_0_24, 0.5):setEase(LeanTweenType.linear)
		self.charactor[self.serveChar]:setActionOnce("faqiu", function()
			self:managedTween(LeanTween.delayedCall, function()
				self.charactor[self.serveChar]:move(1, self.serveChar)

				return
			end, 0.2, nil)

			return
		end)

		return
	end, 0.5, nil)

	return
end

function VolleyballGameView:charUpBall(arg_143_1)
	local var_143_0, var_143_1 = self:getCharWithTag(self.ballPosTag)

	if not var_143_1 then
		return
	end

	self.upChar = var_143_0
	self.hitChar = self:getAnotherChar(self.upChar)

	var_143_1:move(0.45, self.ballPosTag, nil, function()
		var_143_1:setActionOnce("chuanqiu")

		return
	end)

	return
end

function VolleyballGameView:charHitBall()
	local var_145_0 = self.charactor[self.hitChar]

	self.charactor[self.hitChar]:move(0.5, self.ballPosTag, nil, function()
		var_145_0:setActionOnce("kouqiu")

		return
	end)

	return
end

function VolleyballGameView:showcutin(arg_147_1)
	self:setBtnAvailable(false)
	self:pauseGame()
	setActive(self.cutin, true)

	local var_147_0 = ""

	for iter_147_0, iter_147_1 in pairs(self.charNames) do
		if iter_147_0 == self.hitChar then
			var_147_0 = iter_147_1
		end
	end

	local var_147_1, var_147_2, var_147_3 = ShipWordHelper.GetWordAndCV(var_0_2[self:getCharIndex(var_147_0)], "skill")

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_147_2)
	setActive(self.gameUI:Find("line"), true)
	setActive(self.cutin:Find("shatanpaiqiu_cutin"), false)
	setActive(self.cutin:Find("shatanpaiqiu_cutin"), true)
	setImageSprite(self.cutinPaint, self.cutinPaints:Find(self:getCharIndex(var_147_0)):GetComponent(typeof(Image)).sprite, true)
	LeanTween.moveX(self.cutin, 0, 0.3):setOnComplete(System.Action(function()
		LeanTween.delayedCall(1, System.Action(function()
			setActive(self.gameUI:Find("line"), false)
			LeanTween.moveX(self.cutin, -567, 0.3):setOnComplete(System.Action(function()
				setActive(self.cutin, false)
				self:setBtnAvailable(true)
				self:resumeGame()

				if arg_147_1 then
					arg_147_1()
				end

				return
			end))

			return
		end))

		return
	end))

	return
end

function VolleyballGameView:showScoreCutin(arg_151_1)
	self:setBtnAvailable(false)
	self:pauseGame()
	setImageSprite(self.ourScoreCutin, self.scoreCutinNums:Find(self.ourScoreNum):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(self.enemyScoreCutin, self.scoreCutinNums:Find(self.enemyScoreNum):GetComponent(typeof(Image)).sprite, true)
	setActive(self.scoreCutin, true)
	setLocalScale(self.scoreCutin, Vector3(1, 0, 1))
	LeanTween.scale(self.scoreCutin, Vector3(1, 1, 1), 0.2):setOnComplete(System.Action(function()
		self:resetChar()
		LeanTween.delayedCall(0.6, System.Action(function()
			LeanTween.scale(self.scoreCutin, Vector3(1, 0, 1), 0.2):setOnComplete(System.Action(function()
				setActive(self.scoreCutin, false)
				self:setBtnAvailable(true)
				self:resumeGame()

				if arg_151_1 then
					arg_151_1()
				end

				return
			end))

			return
		end))

		return
	end))

	return
end

function VolleyballGameView:updateScore()
	setText(self.ourScore, self.ourScoreNum)
	setText(self.enemyScore, self.enemyScoreNum)
	setActive(self.qte, false)

	if self.ourScoreNum >= self.endScore or self.enemyScoreNum >= self.endScore then
		self:endGame()
	else
		self:showScoreCutin(function()
			self:startGame()

			return
		end)
	end

	return
end

function VolleyballGameView:endGame()
	setActive(self.winTag, self.ourScoreNum ~= self.enemyScoreNum)
	setActive(self.loseTag, self.ourScoreNum ~= self.enemyScoreNum)
	self:setBtnAvailable(false)

	self.isInGame = false

	pg.UIMgr.GetInstance():BlurPanel(self.endUI)
	setActive(self.endUI, true)
	setActive(self.endFreeTitle, self.isFree)
	setActive(self.endDayTitle, not self.isFree)
	setImageSprite(self.endTitleDay, self.titleDays:Find(self.curDay):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(self.endOurScore, self.endScoreNums:Find(self.ourScoreNum):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(self.endEnemyScore, self.endScoreNums:Find(self.enemyScoreNum):GetComponent(typeof(Image)).sprite, true)

	local var_157_1

	if self.ourScoreNum > self.enemyScoreNum then
		self.winTag.anchoredPosition = Vector3(-170, 200, 0)
		self.loseTag.anchoredPosition = Vector3(180, 200, 0)
		var_157_1 = -20
	else
		self.winTag.anchoredPosition = Vector3(170, 200, 0)
		self.loseTag.anchoredPosition = Vector3(-180, 200, 0)
		var_157_1 = 20
	end

	setActive(self.winTag:GetChild(0), false)
	setActive(self.winTag:GetChild(0), true)
	setLocalRotation(self.loseTag, Vector3(0, 0, 0))
	LeanTween.rotateZ(go(self.loseTag), var_157_1, 0.2):setOnComplete(System.Action(function()
		if self:GetMGHubData().count > 0 then
			self:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)
		end

		return
	end))

	return
end

function VolleyballGameView:OnGetAwardDone(arg_159_1)
	if arg_159_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_159_0 = self:GetMGHubData()
		local var_159_1 = var_159_0.ultimate
		local var_159_2 = var_159_0.usedtime
		local var_159_3 = var_159_0:getConfig("reward_need")
		local var_159_4 = self:GetMGHubData().count
		local var_159_5 = pg.NewStoryMgr.GetInstance()
		local var_159_6 = self.storylist[self:GetMGHubData().usedtime] and self.storylist[self:GetMGHubData().usedtime][1] or nil

		if var_159_0.usedtime ~= 7 and var_159_6 and not var_159_5:IsPlayed(var_159_6) then
			var_159_5:Play(var_159_6)
		end

		if var_159_1 == 0 and var_159_3 <= var_159_2 then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_159_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	elseif arg_159_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		local var_159_7

		if self.storylist[7][1] then
			var_159_7 = self.storylist[7][1] or nil
		end

		local var_159_8 = pg.NewStoryMgr.GetInstance()

		if var_159_7 and not var_159_8:IsPlayed(var_159_7) then
			var_159_8:Play(var_159_7)
		end
	end

	return
end

function VolleyballGameView:pauseGame()
	self:pauseManagedTween()

	if self.qteTimer then
		self.qteTimer:Pause()
	end

	if self.qteTween and LeanTween.isTweening(self.qteTween) then
		LeanTween.pause(self.qteTween)
	end

	for iter_160_0, iter_160_1 in pairs(self.charactor) do
		iter_160_1:pauseSpine()
	end

	return
end

function VolleyballGameView:resumeGame()
	self:resumeManagedTween()

	if self.qteTimer then
		self.qteTimer:Resume()
	end

	if self.qteTween and LeanTween.isTweening(self.qteTween) then
		LeanTween.resume(self.qteTween)
	end

	for iter_161_0, iter_161_1 in pairs(self.charactor) do
		iter_161_1:resumeSpine()
	end

	return
end

function VolleyballGameView:clearTimer()
	if self.qteTimer then
		self.qteTimer:Stop()

		self.qteTimer = nil
	end

	if self.countTimer then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	return
end

function VolleyballGameView:changeQTEBtnStatus(arg_163_1)
	self.qteBtnStatus = arg_163_1

	return
end

function VolleyballGameView:resetGameData()
	self.qteStatus = var_0_9
	self.qteType = var_0_12

	self:changeQTEBtnStatus(var_0_5)

	self.ballPosTag = ""
	self.isCutin = false
	self.cutin.anchoredPosition = {
		x = -567,
		y = 582
	}
	self.isScoreCutin = false

	setActive(self.scoreCutin, false)

	self.ourScoreNum = 0
	self.enemyScoreNum = 0

	setText(self.ourScore, self.ourScoreNum)
	setText(self.enemyScore, self.enemyScoreNum)
	setActive(self.qte, false)
	self:loadSpineChars()

	return
end

function VolleyballGameView:exitGame()
	self.isInGame = false

	self:setBtnAvailable(true)
	self:resetGameAni()

	return
end

function VolleyballGameView:resetGameAni()
	self:cleanManagedTween()

	if self.qteTween and LeanTween.isTweening(self.qteTween) then
		LeanTween.cancel(self.qteTween, false)
	end

	self:clearTimer()

	return
end

function VolleyballGameView:willExit()
	self:clearSpineChars()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.selectUI, self._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.endUI, self._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.countTimeUI, self._tf)

	return
end

function VolleyballGameView:onBackPressed()
	if self.isInGame then
		triggerButton(self.backBtn)
	elseif isActive(self.selectUI) then
		triggerButton(self.selectBackBtn)
	elseif isActive(self.mainUI) then
		triggerButton(self.returnBtn)
	end

	return
end

return VolleyballGameView
