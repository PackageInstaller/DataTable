local var_0_0 = class("VolleyballGameView", import("..BaseMiniGameView"))
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

function var_0_0.getUIName(arg_1_0)
	return "VolleyballGameUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.countTimeUI = arg_2_0._tf:Find("count_time_ui")
	arg_2_0.countTimeImage = arg_2_0.countTimeUI:Find("time")
	arg_2_0.countTimeNumImage = arg_2_0.countTimeUI:Find("nums")
	arg_2_0.mainUI = arg_2_0._tf:Find("main_ui")
	arg_2_0.returnBtn = arg_2_0.mainUI:Find("return_btn")
	arg_2_0.mainStartBtn = arg_2_0.mainUI:Find("start_btn")
	arg_2_0.ruleBtn = arg_2_0.mainUI:Find("rule_btn")
	arg_2_0.progressScroll = arg_2_0.mainUI:Find("right_panel/scroll_view/")
	arg_2_0.progressContent = arg_2_0.mainUI:Find("right_panel/scroll_view/viewport/content")
	arg_2_0.colors = arg_2_0.mainUI:Find("right_panel/colors")
	arg_2_0.icons = arg_2_0.mainUI:Find("right_panel/icons")
	arg_2_0.gotIcon = arg_2_0.mainUI:Find("bg/got")
	arg_2_0.selectUI = arg_2_0._tf:Find("select_ui")
	arg_2_0.selectBackBtn = arg_2_0.selectUI:Find("back_btn")
	arg_2_0.selectStartBtn = arg_2_0.selectUI:Find("start_btn")
	arg_2_0.tags = arg_2_0.selectUI:Find("select_panel/tags")
	arg_2_0.paints = arg_2_0.selectUI:Find("select_panel/paints")
	arg_2_0.freeTitle = arg_2_0.selectUI:Find("select_panel/title/free")
	arg_2_0.dayTitle = arg_2_0.selectUI:Find("select_panel/title/challenge")
	arg_2_0.titleDayNum = arg_2_0.selectUI:Find("select_panel/title/challenge/num")
	arg_2_0.ruleTxt = arg_2_0.selectUI:Find("select_panel/rule/rule_txt")
	arg_2_0.select4Chars = arg_2_0.selectUI:Find("select_panel/chars")
	arg_2_0.selectWindow = arg_2_0.selectUI:Find("select_windows")
	arg_2_0.selectSureBtn = arg_2_0.selectWindow:Find("windows/sure_btn")
	arg_2_0.select9Chars = arg_2_0.selectWindow:Find("windows/char_layout")
	arg_2_0.selectNum = arg_2_0.selectWindow:Find("windows/tips/num")
	arg_2_0.gameUI = arg_2_0._tf:Find("game_ui")
	arg_2_0.bgEffect = arg_2_0.gameUI:Find("bg/shatanpaiqiu_hailang")
	arg_2_0.hitEffect = arg_2_0.gameUI:Find("shatanpaiqiu_jida")
	arg_2_0.upEffect = arg_2_0.gameUI:Find("shatanpaiqiu_jieqiu")
	arg_2_0.ball = arg_2_0.gameUI:Find("ball")
	arg_2_0.ballShadow = arg_2_0.gameUI:Find("ball_shadow")
	arg_2_0.pauseBtn = arg_2_0.gameUI:Find("pause_btn")
	arg_2_0.backBtn = arg_2_0.gameUI:Find("back_btn")
	arg_2_0.qteBtn = arg_2_0.gameUI:Find("qte_btn")
	arg_2_0.pos = arg_2_0.gameUI:Find("pos")

	arg_2_0:initPos()

	arg_2_0.ourScore = arg_2_0.gameUI:Find("score/our")
	arg_2_0.enemyScore = arg_2_0.gameUI:Find("score/enemy")
	arg_2_0.qte = arg_2_0.gameUI:Find("qte")
	arg_2_0.qteCircles = arg_2_0.qte:Find("circles")
	arg_2_0.qteCircle = arg_2_0.qte:Find("circles/big")
	arg_2_0.result = arg_2_0.qte:Find("result")
	arg_2_0.resultTxt = arg_2_0.qte:Find("txts")
	arg_2_0.cutin = arg_2_0.gameUI:Find("cutin")
	arg_2_0.cutinPaint = arg_2_0.gameUI:Find("cutin/paint")
	arg_2_0.cutinPaints = arg_2_0.gameUI:Find("cutin_paints")
	arg_2_0.scoreCutin = arg_2_0.gameUI:Find("score_cutin")
	arg_2_0.scoreCutinNums = arg_2_0.gameUI:Find("score_cutin/nums")
	arg_2_0.ourScoreCutin = arg_2_0.gameUI:Find("score_cutin/our")
	arg_2_0.enemyScoreCutin = arg_2_0.gameUI:Find("score_cutin/enemy")
	arg_2_0.charTF = {}
	arg_2_0.charTF.our1 = arg_2_0.gameUI:Find("char/our1")
	arg_2_0.charTF.our2 = arg_2_0.gameUI:Find("char/our2")
	arg_2_0.charTF.enemy1 = arg_2_0.gameUI:Find("char/enemy1")
	arg_2_0.charTF.enemy2 = arg_2_0.gameUI:Find("char/enemy2")
	arg_2_0.charModels = {}
	arg_2_0.charactor = {}
	arg_2_0.cutinMask = arg_2_0.gameUI:Find("cutin_mask")
	arg_2_0.endUI = arg_2_0._tf:Find("end_ui")
	arg_2_0.endDayTitle = arg_2_0.endUI:Find("title/race")
	arg_2_0.endFreeTitle = arg_2_0.endUI:Find("title/free")
	arg_2_0.endTitleDay = arg_2_0.endUI:Find("title/race/num")
	arg_2_0.titleDays = arg_2_0.endUI:Find("title_days")
	arg_2_0.endOurScore = arg_2_0.endUI:Find("score_panel/score/our")
	arg_2_0.endEnemyScore = arg_2_0.endUI:Find("score_panel/score/enemy")
	arg_2_0.endScoreNums = arg_2_0.endUI:Find("nums")
	arg_2_0.sureBtn = arg_2_0.endUI:Find("sure_btn")
	arg_2_0.winTag = arg_2_0.endUI:Find("score_panel/score/win")
	arg_2_0.loseTag = arg_2_0.endUI:Find("score_panel/score/lose")
	arg_2_0.helpUI = arg_2_0._tf:Find("help_ui")
	arg_2_0.miniGameHudId = arg_2_0:GetMiniGameHudId(ActivityConst.MINIGAME_VOLLEYBALL)
	arg_2_0.miniGameId = arg_2_0:GetDOA2MiniGameId(ActivityConst.MINIGAME_VOLLEYBALL)

	return
end

function var_0_0.initPos(arg_3_0)
	arg_3_0.orgPos = {}
	arg_3_0.orgPos.our_serve = arg_3_0.pos:Find("our_pos/serve_pos").anchoredPosition
	arg_3_0.orgPos.our1 = arg_3_0.pos:Find("our_pos/drop_pos1").anchoredPosition
	arg_3_0.orgPos.our2 = arg_3_0.pos:Find("our_pos/drop_pos2").anchoredPosition
	arg_3_0.orgPos.enemy_serve = arg_3_0.pos:Find("enemy_pos/serve_pos").anchoredPosition
	arg_3_0.orgPos.enemy1 = arg_3_0.pos:Find("enemy_pos/drop_pos1").anchoredPosition
	arg_3_0.orgPos.enemy2 = arg_3_0.pos:Find("enemy_pos/drop_pos2").anchoredPosition

	arg_3_0:resetPos()

	return
end

function var_0_0.resetPos(arg_4_0)
	arg_4_0.anchoredPos = Clone(arg_4_0.orgPos)
	arg_4_0.anchoredPos.our1 = arg_4_0:getRandomPos("our1")
	arg_4_0.anchoredPos.our2 = arg_4_0:getRandomPos("our2")
	arg_4_0.anchoredPos.enemy1 = arg_4_0:getRandomPos("enemy1")
	arg_4_0.anchoredPos.enemy2 = arg_4_0:getRandomPos("enemy2")

	return
end

function var_0_0.GetMiniGameHudId(arg_5_0, arg_5_1)
	if not pg.activity_template[arg_5_1] then
		return nil
	end

	return pg.activity_template[arg_5_1].config_id
end

function var_0_0.GetDOA2MiniGameId(arg_6_0, arg_6_1)
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

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.returnBtn, function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.ruleBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("venusvolleyball_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mainStartBtn, function()
		setActive(arg_7_0.selectUI, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_7_0.selectUI)
		arg_7_0:initSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.selectBackBtn, function()
		setActive(arg_7_0.selectUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.selectUI, arg_7_0._tf)

		return
	end, SFX_PANEL)

	arg_7_0.canStartGame = false

	onButton(arg_7_0, arg_7_0.selectStartBtn, function()
		if not arg_7_0.canStartGame then
			return
		end

		setActive(arg_7_0.mainUI, false)
		setActive(arg_7_0.selectUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.selectUI, arg_7_0._tf)
		setActive(arg_7_0.gameUI, true)
		arg_7_0:resetGameData()

		if arg_7_0.isFirstgame == 0 then
			arg_7_0:firstShow(function()
				arg_7_0:startCountTimer()

				return
			end)
		else
			arg_7_0:startCountTimer()
		end

		return
	end, SFX_PANEL)

	arg_7_0.canSureChar = false

	onButton(arg_7_0, arg_7_0.selectSureBtn, function()
		if not arg_7_0.canSureChar then
			return
		end

		if arg_7_0.selectCharCamp == "enemy" then
			arg_7_0.charNames.enemy1 = var_0_1[arg_7_0.selectSDIndex1]
			arg_7_0.charNames.enemy2 = var_0_1[arg_7_0.selectSDIndex2]
		elseif arg_7_0.selectCharCamp == "our" then
			arg_7_0.charNames.our1 = var_0_1[arg_7_0.selectSDIndex1]
			arg_7_0.charNames.our2 = var_0_1[arg_7_0.selectSDIndex2]
		end

		setActive(arg_7_0.selectWindow, false)
		arg_7_0:refreshSelectUI()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.selectWindow:Find("mask"), function()
		setActive(arg_7_0.selectWindow, false)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.pauseBtn, function()
		if not arg_7_0.btnAvailable then
			return
		end

		arg_7_0:pauseGame()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("venusvolleyball_suspend_tip"),
			onNo = function()
				arg_7_0:resumeGame()

				return
			end,
			onYes = function()
				arg_7_0:resumeGame()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		if not arg_7_0.btnAvailable then
			return
		end

		arg_7_0:pauseGame()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("venusvolleyball_return_tip"),
			onNo = function()
				arg_7_0:resumeGame()

				return
			end,
			onYes = function()
				arg_7_0:endGame()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.qteBtn, function()
		if arg_7_0.qteBtnStatus == var_0_5 then
			return
		end

		arg_7_0:qteResult()

		return
	end)
	onButton(arg_7_0, arg_7_0.sureBtn, function()
		setActive(arg_7_0.mainUI, true)
		arg_7_0:initMainUI()
		setActive(arg_7_0.gameUI, false)
		setActive(arg_7_0.endUI, false)
		arg_7_0:clearSpineChars()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.endUI, arg_7_0._tf)

		return
	end, SFX_PANEL)
	arg_7_0:initMainUI()

	return
end

function var_0_0.playEffect(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1.anchoredPosition = arg_24_2 and arg_24_2 or arg_24_0.ball.anchoredPosition

	setActive(arg_24_1, false)
	setActive(arg_24_1, true)

	return
end

function var_0_0.getGameData(arg_25_0)
	arg_25_0.mgProxy = getProxy(MiniGameProxy)
	arg_25_0.hubData = arg_25_0.mgProxy:GetHubByHubId(arg_25_0.miniGameHudId)

	if arg_25_0.hubData.ultimate == 0 then
		arg_25_0.curDay = arg_25_0.hubData.usedtime + 1 or 8
		arg_25_0.unlockDay = arg_25_0.hubData.usedtime + arg_25_0.hubData.count

		if arg_25_0.curDay <= arg_25_0.unlockDay then
			arg_25_0.curDay = arg_25_0.curDay or arg_25_0.unlockDay
			arg_25_0.mgData = arg_25_0.mgProxy:GetMiniGameData(arg_25_0.miniGameId)
			arg_25_0.endScore = arg_25_0.mgData:GetSimpleValue("endScore")[arg_25_0.curDay]
			arg_25_0.storylist = arg_25_0.mgData:GetSimpleValue("story")
			arg_25_0.isFirstgame = PlayerPrefs.GetInt("volleyballgame_first_" .. getProxy(PlayerProxy):getData().id)

			return
		end
	end
end

function var_0_0.getEnemyCharsIndex(arg_26_0)
	return arg_26_0.mgData:GetSimpleValue("mainChar")[arg_26_0.curDay], arg_26_0.mgData:GetSimpleValue("minorChar")[arg_26_0.curDay]
end

function var_0_0.initMainUI(arg_27_0)
	arg_27_0.isInGame = false

	arg_27_0:getGameData()

	if arg_27_0.hubData.ultimate == 0 and arg_27_0.hubData.usedtime >= arg_27_0.hubData:getConfig("reward_need") then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_27_0.hubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	arg_27_0.isFree = arg_27_0.hubData.ultimate ~= 0

	setActive(arg_27_0.mainStartBtn:Find("free_tag"), arg_27_0.isFree)
	setActive(arg_27_0.gotIcon, arg_27_0.isFree)
	eachChild(arg_27_0.progressContent, function(arg_28_0)
		local var_28_0 = ""
		local var_28_1 = tonumber(arg_28_0.name)
		local var_28_2 = var_0_1[arg_27_0.mgData:GetSimpleValue("mainChar")[var_28_1]]

		setActive(arg_28_0:Find("char_bg/mask"), false)
		setActive(arg_28_0:Find("name_bg/mask"), false)
		setActive(arg_28_0:Find("pass"), false)

		if var_28_1 == arg_27_0.curDay and arg_27_0.hubData.count > 0 then
			var_28_0 = "red"

			setImageSprite(arg_28_0:Find("char_bg/icon"), arg_27_0.icons:Find(arg_27_0:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
		elseif var_28_1 < arg_27_0.curDay or var_28_1 == arg_27_0.curDay and arg_27_0.hubData.count == 0 then
			var_28_0 = "grey"

			setImageSprite(arg_28_0:Find("char_bg/icon"), arg_27_0.icons:Find(arg_27_0:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
			setActive(arg_28_0:Find("char_bg/mask"), true)
			setActive(arg_28_0:Find("name_bg/mask"), true)
			setActive(arg_28_0:Find("pass"), true)
		elseif var_28_1 > arg_27_0.curDay and var_28_1 <= arg_27_0.unlockDay then
			var_28_0 = "blue"

			setImageSprite(arg_28_0:Find("char_bg/icon"), arg_27_0.icons:Find(arg_27_0:getCharIndex(var_28_2)):GetComponent(typeof(Image)).sprite, true)
		else
			var_28_0 = "grey"

			setImageSprite(arg_28_0:Find("char_bg/icon"), arg_27_0.colors:Find("unkonwn"):GetComponent(typeof(Image)).sprite)
		end

		setImageSprite(arg_28_0:Find("name_bg"), arg_27_0.colors:Find(var_28_0):GetComponent(typeof(Image)).sprite)

		return
	end)

	arg_27_0.progressContent.anchoredPosition = {
		x = 0,
		y = math.min(645, (arg_27_0.curDay - 1) * 215)
	}

	onScroll(arg_27_0, arg_27_0.progressScroll, function(arg_29_0)
		setActive(arg_27_0.mainUI:Find("right_panel/arraws_up"), arg_29_0.y < 1 and true or false)
		setActive(arg_27_0.mainUI:Find("right_panel/arraws_down"), arg_29_0.y > 0 and true or false)

		return
	end)

	return
end

function var_0_0.initSelectUI(arg_30_0)
	setActive(arg_30_0.freeTitle, arg_30_0.isFree)
	setActive(arg_30_0.dayTitle, not arg_30_0.isFree)
	setText(arg_30_0.titleDayNum, arg_30_0.curDay)
	setText(arg_30_0.ruleTxt, i18n("venusvolleyball_rule_tip", arg_30_0.endScore))

	arg_30_0.charNames = {}
	arg_30_0.lastSelectNames = {}

	eachChild(arg_30_0.select4Chars, function(arg_31_0)
		local var_31_0 = arg_31_0.name

		onButton(arg_30_0, arg_31_0, function()
			if not arg_30_0.isFree and string.find(var_31_0, "enemy") then
				return
			end

			arg_30_0.selectCharCamp = string.find(var_31_0, "enemy") and "enemy" or "our"

			arg_30_0:openSelectWindow()

			return
		end)

		return
	end)

	if not arg_30_0.isFree then
		local var_30_0, var_30_1 = arg_30_0:getEnemyCharsIndex()

		arg_30_0.charNames.enemy1, arg_30_0.charNames.enemy2 = var_0_1[var_30_0], var_0_1[var_30_1]
	end

	arg_30_0:refreshSelectUI()

	return
end

function var_0_0.getCharIndex(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(var_0_1) do
		if iter_33_1 == arg_33_1 then
			return iter_33_0
		end
	end

	return 1
end

function var_0_0.refreshSelectUI(arg_34_0)
	eachChild(arg_34_0.select4Chars, function(arg_35_0)
		if arg_34_0.charNames[arg_35_0.name] then
			setActive(arg_35_0:Find("select_btn"), false)
			setActive(arg_35_0:Find("char"), true)
			setImageSprite(arg_35_0:Find("char/icon"), arg_34_0.paints:Find(arg_34_0:getCharIndex(arg_34_0.charNames[arg_35_0.name])):GetComponent(typeof(Image)).sprite, true)
			setImageSprite(arg_35_0:Find("char/tag"), arg_34_0.tags:Find(arg_34_0:getCharIndex(arg_34_0.charNames[arg_35_0.name])):GetComponent(typeof(Image)).sprite, true)
		else
			setActive(arg_35_0:Find("select_btn"), true)
			setActive(arg_35_0:Find("char"), false)
		end

		return
	end)

	local var_34_0 = arg_34_0.charNames.our1 and arg_34_0.charNames.our2 and arg_34_0.charNames.enemy1 and arg_34_0.charNames.enemy2

	arg_34_0.canStartGame = not not var_34_0

	setGray(arg_34_0.selectStartBtn, not arg_34_0.canStartGame, not arg_34_0.canStartGame)

	return
end

function var_0_0.isSelected(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = false

	for iter_36_0, iter_36_1 in pairs(arg_36_0.charNames) do
		if arg_36_1 == iter_36_1 then
			var_36_0 = not string.find(iter_36_0, arg_36_2)
		end
	end

	return var_36_0
end

function var_0_0.openSelectWindow(arg_37_0)
	setActive(arg_37_0.selectWindow, true)

	arg_37_0.hasSelectNum = 0

	setText(arg_37_0.selectNum, setColorStr(arg_37_0.hasSelectNum, COLOR_GREEN) .. "/2")

	arg_37_0.selectSDIndex1 = nil
	arg_37_0.selectSDIndex2 = nil

	eachChild(arg_37_0.select9Chars, function(arg_38_0)
		setImageSprite(arg_38_0:Find("char/frame/icon"), arg_37_0.icons:Find((tonumber(arg_38_0.name))):GetComponent(typeof(Image)).sprite, true)
		onButton(arg_37_0, arg_38_0, function()
			if arg_37_0:isSelected(var_0_1[var_0], arg_37_0.selectCharCamp) then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_29)

			if isActive(arg_38_0:Find("selected")) then
				setActive(arg_38_0:Find("selected"), false)

				if arg_37_0.selectSDIndex1 and arg_37_0.selectSDIndex1 == var_0 then
					arg_37_0.selectSDIndex1 = nil
				end

				if arg_37_0.selectSDIndex2 and arg_37_0.selectSDIndex2 == var_0 then
					arg_37_0.selectSDIndex2 = nil
				end

				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum - 1
			elseif arg_37_0.selectSDIndex1 and arg_37_0.selectSDIndex2 then
				-- block empty
			elseif arg_37_0.selectSDIndex1 then
				arg_37_0.selectSDIndex2 = var_0
				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum + 1
			else
				arg_37_0.selectSDIndex1 = var_0
				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum + 1
			end

			arg_37_0:refreshSelectWindow()

			return
		end)

		return
	end)
	arg_37_0:refreshSelectWindow()

	return
end

function var_0_0.refreshSelectWindow(arg_40_0)
	eachChild(arg_40_0.select9Chars, function(arg_41_0)
		local var_41_0 = tonumber(arg_41_0.name)

		setActive(arg_41_0:Find("char/mask"), arg_40_0:isSelected(var_0_1[var_41_0], arg_40_0.selectCharCamp) and true or false)

		if var_41_0 == arg_40_0.selectSDIndex1 or var_41_0 == arg_40_0.selectSDIndex2 then
			setActive(arg_41_0:Find("selected"), true)
		else
			setActive(arg_41_0:Find("selected"), false)
		end

		return
	end)
	setText(arg_40_0.selectNum, setColorStr(arg_40_0.hasSelectNum, COLOR_GREEN) .. "/2")

	arg_40_0.canSureChar = not not (arg_40_0.selectSDIndex1 and arg_40_0.selectSDIndex2)

	setGray(arg_40_0.selectSureBtn, not arg_40_0.canSureChar, not arg_40_0.canSureChar)

	return
end

function var_0_0.firstShow(arg_42_0, arg_42_1)
	setActive(arg_42_0.helpUI, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_42_0.helpUI)
	onButton(arg_42_0, arg_42_0.helpUI, function()
		PlayerPrefs.SetInt("volleyballgame_first_" .. getProxy(PlayerProxy):getData().id, 1)
		setActive(arg_42_0.helpUI, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_42_0.helpUI, arg_42_0._tf)

		if arg_42_1 then
			arg_42_1()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.startCountTimer(arg_44_0)
	arg_44_0:setBtnAvailable(false)
	setActive(arg_44_0.countTimeUI, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_44_0.countTimeUI)

	arg_44_0.countTime = 3

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_28)
	setImageSprite(arg_44_0.countTimeImage, arg_44_0.countTimeNumImage:Find(arg_44_0.countTime):GetComponent(typeof(Image)).sprite)

	if arg_44_0.countTimer then
		arg_44_0.countTimer:Reset(function()
			arg_44_0.countTime = arg_44_0.countTime - 1

			if arg_44_0.countTime <= 0 then
				setActive(arg_44_0.countTimeUI, false)
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_44_0.countTimeUI, arg_44_0._tf)
				arg_44_0:resetGameAni()
				arg_44_0:startGame()
			else
				setImageSprite(arg_44_0.countTimeImage, arg_44_0.countTimeNumImage:Find(arg_44_0.countTime):GetComponent(typeof(Image)).sprite)
			end

			return
		end, 1, -1)
	else
		arg_44_0.countTimer = Timer.New(function()
			arg_44_0.countTime = arg_44_0.countTime - 1

			if arg_44_0.countTime <= 0 then
				setActive(arg_44_0.countTimeUI, false)
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_44_0.countTimeUI, arg_44_0._tf)
				arg_44_0:resetGameAni()
				arg_44_0:startGame()
			else
				setImageSprite(arg_44_0.countTimeImage, arg_44_0.countTimeNumImage:Find(arg_44_0.countTime):GetComponent(typeof(Image)).sprite)
			end

			return
		end, 1, -1)
	end

	arg_44_0.countTimer:Start()

	return
end

function var_0_0.setBtnAvailable(arg_46_0, arg_46_1)
	arg_46_0.btnAvailable = arg_46_1

	setGray(arg_46_0.backBtn, not arg_46_1, not arg_46_1)
	setGray(arg_46_0.pauseBtn, not arg_46_1, not arg_46_1)

	return
end

function var_0_0.startGame(arg_47_0)
	arg_47_0.isInGame = true

	arg_47_0:setBtnAvailable(true)
	setActive(arg_47_0.bgEffect, false)
	setActive(arg_47_0.bgEffect, true)

	if arg_47_0.beginTeam == var_0_3 then
		arg_47_0:ourServe(function()
			arg_47_0:enemyUp2Up(function()
				arg_47_0:enemyUp2Hit(function()
					arg_47_0:enemyThrow(function()
						arg_47_0:enterLoop()

						return
					end)

					return
				end)

				return
			end)

			return
		end)
	else
		arg_47_0:enemyServe(function()
			arg_47_0:enterLoop()

			return
		end)
	end

	return
end

function var_0_0.enterLoop(arg_53_0)
	arg_53_0:ourUp2Up(function()
		arg_53_0:ourUp2Hit(function()
			arg_53_0:ourThrow(function()
				arg_53_0:enemyUp2Up(function()
					arg_53_0:enemyUp2Hit(function()
						arg_53_0:enemyThrow(function()
							arg_53_0:enterLoop()

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

function var_0_0.ourServe(arg_60_0, arg_60_1)
	arg_60_0.ballPosTag = "our_serve"

	setActive(arg_60_0.ball, true)
	arg_60_0:charServeBall()
	arg_60_0:managedTween(LeanTween.delayedCall, function()
		local var_61_0 = "enemy" .. math.random(2)

		arg_60_0.ballPosTag = var_61_0
		arg_60_0.anchoredPos[arg_60_0.ballPosTag] = arg_60_0:getRandomPos(arg_60_0.ballPosTag)

		arg_60_0:ballServe(arg_60_0.ball, var_0_15, arg_60_0.anchoredPos[var_61_0], function()
			if arg_60_1 then
				arg_60_1()
			end

			return
		end)
		arg_60_0:managedTween(LeanTween.delayedCall, function()
			arg_60_0:charUpBall()

			return
		end, var_0_15 - var_0_21, nil)

		return
	end, var_0_20 + 0.5, nil)

	return
end

function var_0_0.enemyServe(arg_64_0, arg_64_1)
	arg_64_0.ballPosTag = "enemy_serve"

	setActive(arg_64_0.ball, true)
	arg_64_0:charServeBall()
	arg_64_0:managedTween(LeanTween.delayedCall, function()
		local var_65_0 = "our" .. math.random(2)

		arg_64_0.ballPosTag = var_65_0
		arg_64_0.anchoredPos[arg_64_0.ballPosTag] = arg_64_0:getRandomPos(arg_64_0.ballPosTag)

		arg_64_0:ballServe(arg_64_0.ball, var_0_15, arg_64_0.anchoredPos[var_65_0], function()
			if arg_64_1 then
				arg_64_1()
			end

			return
		end)
		arg_64_0:managedTween(LeanTween.delayedCall, function()
			arg_64_0:charUpBall()

			return
		end, var_0_15 - var_0_21, nil)

		return
	end, var_0_20 + 0.5, nil)

	return
end

function var_0_0.ourUp2Up(arg_68_0, arg_68_1)
	if arg_68_0.qteStatus == var_0_11 and arg_68_0.qteType == var_0_13 then
		arg_68_0:ourFly()

		return
	end

	arg_68_0.ballPosTag = arg_68_0.ballPosTag == "our1" and "our2" or "our1"

	arg_68_0:ballUp2Up(arg_68_0.ball, var_0_16, arg_68_0.anchoredPos[arg_68_0.ballPosTag], function()
		if arg_68_1 then
			arg_68_1()
		end

		return
	end)
	arg_68_0:managedTween(LeanTween.delayedCall, function()
		arg_68_0:charUpBall()

		return
	end, 0.3, nil)

	return
end

function var_0_0.ourUp2Hit(arg_71_0, arg_71_1)
	arg_71_0.ballPosTag = arg_71_0.ballPosTag == "our1" and "our2" or "our1"
	arg_71_0.anchoredPos[arg_71_0.ballPosTag] = arg_71_0:getRandomPos(arg_71_0.ballPosTag)
	arg_71_0.qteType = var_0_14

	arg_71_0:charHitBall()

	local var_71_0 = false

	local function var_71_1(arg_72_0)
		if var_71_0 then
			arg_72_0()
		else
			var_71_0 = true
		end

		return
	end

	table.insert({}, function(arg_73_0)
		local function var_73_0()
			if arg_71_0.isCutin then
				arg_71_0:showcutin(function()
					arg_71_0.isCutin = false

					arg_73_0()

					return
				end)
			else
				arg_73_0()
			end

			return
		end

		arg_71_0:managedTween(LeanTween.delayedCall, function()
			var_71_1(var_73_0)

			return
		end, var_0_16 - 0.2, nil)
		arg_71_0:managedTween(LeanTween.delayedCall, function()
			arg_71_0:startQTE(var_0_32, 200, arg_71_0.anchoredPos[arg_71_0.ballPosTag], function()
				var_71_1(var_73_0)

				return
			end)

			return
		end, var_0_16 - var_0_32 - 0.2, nil)

		return
	end)
	table.insert({}, function(arg_79_0)
		arg_71_0:ballUp2Hit(arg_71_0.ball, var_0_16, arg_71_0.anchoredPos[arg_71_0.ballPosTag], arg_79_0)

		return
	end)
	parallelAsync({}, function()
		if arg_71_1 then
			arg_71_1()
		end

		return
	end)

	return
end

function var_0_0.ourThrow(arg_81_0, arg_81_1)
	local var_81_0 = "enemy" .. math.random(2)

	arg_81_0.ballPosTag = var_81_0
	arg_81_0.anchoredPos[arg_81_0.ballPosTag] = arg_81_0:getRandomPos(arg_81_0.ballPosTag)

	arg_81_0:ballHit(arg_81_0.ball, var_0_17, arg_81_0.anchoredPos[var_81_0], function()
		if arg_81_1 then
			arg_81_1()
		end

		return
	end)
	arg_81_0:charUpBall()

	return
end

function var_0_0.enemyUp2Up(arg_83_0, arg_83_1)
	if arg_83_0.qteStatus == var_0_10 and arg_83_0.qteType == var_0_14 then
		arg_83_0:enemyFly()

		return
	end

	arg_83_0.ballPosTag = arg_83_0.ballPosTag == "enemy1" and "enemy2" or "enemy1"

	arg_83_0:ballUp2Up(arg_83_0.ball, var_0_16, arg_83_0.anchoredPos[arg_83_0.ballPosTag], function()
		if arg_83_1 then
			arg_83_1()
		end

		return
	end)
	arg_83_0:managedTween(LeanTween.delayedCall, function()
		arg_83_0:charUpBall()

		return
	end, 0.3, nil)

	return
end

function var_0_0.enemyUp2Hit(arg_86_0, arg_86_1)
	arg_86_0.ballPosTag = arg_86_0.ballPosTag == "enemy1" and "enemy2" or "enemy1"
	arg_86_0.anchoredPos[arg_86_0.ballPosTag] = arg_86_0:getRandomPos(arg_86_0.ballPosTag)
	arg_86_0.randomQtePos = "our" .. math.random(2)
	arg_86_0.anchoredPos[arg_86_0.randomQtePos] = arg_86_0:getRandomPos(arg_86_0.randomQtePos)
	arg_86_0.qteType = var_0_13

	arg_86_0:managedTween(LeanTween.delayedCall, function()
		arg_86_0:startQTE(var_0_32, 0, arg_86_0.anchoredPos[arg_86_0.randomQtePos])

		return
	end, var_0_16 - var_0_32, nil)
	arg_86_0:ballUp2Hit(arg_86_0.ball, var_0_16, arg_86_0.anchoredPos[arg_86_0.ballPosTag], function()
		if arg_86_1 then
			arg_86_1()
		end

		return
	end)
	arg_86_0:charHitBall()

	return
end

function var_0_0.enemyThrow(arg_89_0, arg_89_1)
	arg_89_0.ballPosTag = arg_89_0.randomQtePos

	arg_89_0:ballHit(arg_89_0.ball, var_0_17, arg_89_0.anchoredPos[arg_89_0.ballPosTag], function()
		if arg_89_1 then
			arg_89_1()
		end

		return
	end)
	arg_89_0:charUpBall()

	return
end

function var_0_0.ourFly(arg_91_0)
	arg_91_0.ballPosTag = "out"

	arg_91_0:hitFly(arg_91_0.ball, var_0_18, {
		x = -math.random(1000, 1100),
		y = math.random(0, 200) - 100
	}, function()
		arg_91_0.qteStatus = var_0_9

		setGray(arg_91_0.qteBtn, true, true)

		arg_91_0.enemyScoreNum = arg_91_0.enemyScoreNum + 1

		arg_91_0:updateScore()

		return
	end)

	return
end

function var_0_0.enemyFly(arg_93_0)
	arg_93_0.ballPosTag = "out"

	arg_93_0:hitFly(arg_93_0.ball, var_0_18, {
		x = math.random(1000, 1100),
		y = math.random(0, 200) - 100
	}, function()
		arg_93_0.qteStatus = var_0_9

		setGray(arg_93_0.qteBtn, true, true)

		arg_93_0.ourScoreNum = arg_93_0.ourScoreNum + 1

		arg_93_0:updateScore()

		return
	end)

	return
end

function var_0_0.qteSuccess(arg_95_0)
	arg_95_0.qteStatus = var_0_10
	arg_95_0.beginTeam = var_0_3

	arg_95_0:changeQTEBtnStatus(var_0_5)

	return
end

function var_0_0.qteFail(arg_96_0)
	arg_96_0.qteStatus = var_0_11
	arg_96_0.beginTeam = var_0_4

	arg_96_0:changeQTEBtnStatus(var_0_5)

	return
end

function var_0_0.GetBeziersPoints(arg_97_0, arg_97_1, arg_97_2, arg_97_3, arg_97_4)
	table.insert({}, Vector3(0, 0, 0))
	table.insert({}, (function(arg_98_0)
		local var_98_9001
		local var_98_9000
		local var_98_0 = arg_97_1:Clone()
		local var_98_1 = arg_97_2:Clone()

		return var_98_0.Mul(var_98_9001, (1 - arg_98_0) * (1 - arg_98_0)):Clone().Add(var_98_1, (var_98_1.Mul(var_98_9000, 2 * arg_98_0 * (1 - arg_98_0)))):Add((arg_97_3:Clone().Mul(var_98_0, arg_98_0 * arg_98_0)))
	end)(0))

	for iter_97_0 = 1, arg_97_4 do
		table.insert({}, (function(arg_98_0)
			local var_98_9001
			local var_98_9000
			local var_98_0 = arg_97_1:Clone()
			local var_98_1 = arg_97_2:Clone()

			return var_98_0.Mul(var_98_9001, (1 - arg_98_0) * (1 - arg_98_0)):Clone().Add(var_98_1, (var_98_1.Mul(var_98_9000, 2 * arg_98_0 * (1 - arg_98_0)))):Add((arg_97_3:Clone().Mul(var_98_0, arg_98_0 * arg_98_0)))
		end)(iter_97_0 / arg_97_4))
	end

	table.insert({}, Vector3(0, 0, 0))

	return {}
end

function var_0_0.ballParabolaMove(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5, arg_99_6)
	local var_99_0 = Vector2(arg_99_1.anchoredPosition.x, arg_99_1.anchoredPosition.y - arg_99_5)
	local var_99_1 = Vector2(arg_99_3.x, arg_99_3.y)
	local var_99_2 = var_99_1.x - var_99_0.x
	local var_99_3 = var_99_1.y - var_99_0.y
	local var_99_4 = math.abs(arg_99_6 - arg_99_5)
	local var_99_5 = DOAParabolaCalc(arg_99_2, math.abs(var_0_33), var_99_4)
	local var_99_6

	if arg_99_5 < arg_99_6 then
		var_99_6 = var_99_5 + var_99_4
	else
		var_99_6 = var_99_5
	end

	local var_99_10 = math.sqrt(2 * math.abs(var_0_33) * var_99_6)

	arg_99_0:managedTween(LeanTween.value, function()
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

function var_0_0.ballServe(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4)
	arg_102_0:ballParabolaMove(arg_102_1, arg_102_2, arg_102_3, function()
		if arg_102_4 then
			arg_102_4()
		end

		return
	end, var_0_24, var_0_25)
	arg_102_0:managedTween(LeanTween.move, nil, arg_102_0.ballShadow, Vector3(arg_102_3.x, arg_102_3.y + var_0_23), arg_102_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.ballUp2Up(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	arg_104_0:ballParabolaMove(arg_104_1, arg_104_2, arg_104_3, function()
		if arg_104_4 then
			arg_104_4()
		end

		return
	end, var_0_25, var_0_25)
	arg_104_0:managedTween(LeanTween.move, nil, arg_104_0.ballShadow, Vector3(arg_104_3.x, arg_104_3.y + var_0_23), arg_104_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.ballUp2Hit(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	arg_106_0:ballParabolaMove(arg_106_1, arg_106_2, {
		x = arg_106_3.x,
		y = arg_106_3.y
	}, function()
		if arg_106_4 then
			arg_106_4()
		end

		return
	end, var_0_25, var_0_26)
	arg_106_0:managedTween(LeanTween.move, nil, arg_106_0.ballShadow, Vector3(arg_106_3.x, arg_106_3.y + var_0_23), arg_106_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.ballHit(arg_108_0, arg_108_1, arg_108_2, arg_108_3, arg_108_4)
	arg_108_3 = Vector2(arg_108_3.x, arg_108_3.y + var_0_25)

	arg_108_0:managedTween(LeanTween.moveX, function()
		if arg_108_4 then
			arg_108_4()
		end

		return
	end, arg_108_1, arg_108_3.x, arg_108_2):setEase(LeanTweenType.linear)
	arg_108_0:managedTween(LeanTween.moveY, nil, arg_108_1, arg_108_3.y, arg_108_2):setEase(LeanTweenType.linear)
	arg_108_0:managedTween(LeanTween.move, nil, arg_108_0.ballShadow, Vector3(arg_108_3.x, arg_108_3.y + var_0_23), arg_108_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.charMove(arg_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	arg_110_0:managedTween(LeanTween.moveX, nil, arg_110_1, arg_110_3.x, arg_110_2):setEase(LeanTweenType.easeOutQuad)
	arg_110_0:managedTween(LeanTween.moveY, function()
		if arg_110_4 then
			arg_110_4()
		end

		return
	end, arg_110_1, arg_110_3.y, arg_110_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.hitFly(arg_112_0, arg_112_1, arg_112_2, arg_112_3, arg_112_4)
	arg_112_0:ballParabolaMove(arg_112_1, arg_112_2, arg_112_3, function()
		if arg_112_4 then
			arg_112_4()
		end

		return
	end, var_0_27, var_0_26)
	arg_112_0:managedTween(LeanTween.move, nil, arg_112_0.ballShadow, Vector3(arg_112_3.x, arg_112_3.y + var_0_23), arg_112_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.startQTE(arg_114_0, arg_114_1, arg_114_2, arg_114_3, arg_114_4)
	arg_114_0:changeQTEBtnStatus(var_0_6)

	arg_114_0.qte.anchoredPosition = {
		x = arg_114_3.x,
		y = arg_114_3.y + arg_114_2
	}

	setActive(arg_114_0.qte, true)
	setActive(arg_114_0.qteCircles, true)
	setActive(arg_114_0.result, false)
	setLocalScale(arg_114_0.qteCircle, Vector3(1, 1, 1))
	arg_114_0.result:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_115_0)
		setActive(arg_114_0.result, false)

		return
	end)

	arg_114_0.qteCallback = arg_114_4
	arg_114_0.qteTween = LeanTween.scale(arg_114_0.qteCircle, Vector3(0, 0, 1), arg_114_1):setOnComplete(System.Action(function()
		arg_114_0:changeQTEBtnStatus(var_0_5)
		setImageSprite(arg_114_0.result, arg_114_0.resultTxt:Find("miss"):GetComponent(typeof(Image)).sprite, true)
		setActive(arg_114_0.result, true)
		arg_114_0:qteFail()

		arg_114_0.isCutin = false

		setActive(arg_114_0.qteCircles, false)
		existCall(arg_114_0.qteCallback)

		arg_114_0.qteCallback = nil

		return
	end)).uniqueId

	return
end

function var_0_0.qteResult(arg_117_0)
	if LeanTween.isTweening(arg_117_0.qteTween) then
		LeanTween.cancel(arg_117_0.qteTween, false)
	end

	local var_117_0 = math.abs(arg_117_0.qteCircle.localScale.x)

	setActive(arg_117_0.result, true)

	arg_117_0.isCutin = false

	if var_117_0 > 0 then
		if var_117_0 > var_0_7 then
			setImageSprite(arg_117_0.result, arg_117_0.resultTxt:Find("miss"):GetComponent(typeof(Image)).sprite, true)
			arg_117_0:qteFail()
		elseif var_117_0 > var_0_8 then
			setImageSprite(arg_117_0.result, arg_117_0.resultTxt:Find("good"):GetComponent(typeof(Image)).sprite, true)
			arg_117_0:qteSuccess()
		else
			setImageSprite(arg_117_0.result, arg_117_0.resultTxt:Find("perfect"):GetComponent(typeof(Image)).sprite, true)
			arg_117_0:qteSuccess()

			arg_117_0.isCutin = arg_117_0.qteType == var_0_14
		end

		setActive(arg_117_0.qteCircles, false)
		existCall(arg_117_0.qteCallback)

		arg_117_0.qteCallback = nil

		return
	end
end

local function var_0_34(arg_118_0, arg_118_1, arg_118_2, arg_118_3, arg_118_4)
	local var_118_0 = {
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}

	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).ctor = function(arg_119_0)
		var_118_0._tf.anchoredPosition = arg_118_0.anchoredPos[arg_118_4]

		return
	end
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).setPosTag = function(arg_120_0, arg_120_1)
		var_118_0._tf.anchoredPosition = arg_118_0.anchoredPos[arg_120_1]
		var_118_0.posTag = arg_120_1

		return
	end
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).getPosTag = function(arg_121_0)
		return var_118_0.posTag
	end
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).pauseSpine = function(arg_122_0)
		var_118_0.skele.timeScale = 0

		return
	end
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).resumeSpine = function(arg_123_0)
		var_118_0.skele.timeScale = 1

		return
	end
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).setActionOnce = function(arg_124_0, arg_124_1, arg_124_2)
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
	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}).move = function(arg_126_0, arg_126_1, arg_126_2, arg_126_3, arg_126_4)
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
			(function()
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
			end)()
		end

		return
	end

	;({
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}):ctor()

	return {
		_tf = arg_118_1,
		spineAnim = arg_118_2,
		skele = arg_118_3,
		posTag = arg_118_4
	}
end

function var_0_0.getRandomPos(arg_130_0, arg_130_1)
	local var_130_0 = math.random(0, 300)
	local var_130_1 = math.random(0, 50)

	return string.find(arg_130_1, "our") and {
		x = arg_130_0.orgPos[arg_130_1].x + var_130_0 - 50,
		y = arg_130_0.orgPos[arg_130_1].y + var_130_1 - 25
	} or {
		x = arg_130_0.orgPos[arg_130_1].x + var_130_0 - 250,
		y = arg_130_0.orgPos[arg_130_1].y + var_130_1 - 25
	}
end

function var_0_0.loadSpineChars(arg_131_0)
	arg_131_0:clearSpineChars()

	arg_131_0.beginTeam = math.random(2)
	arg_131_0.serveChar = arg_131_0.beginTeam == var_0_3 and "our" .. math.random(2) or "enemy" .. math.random(2)

	arg_131_0:setBallPos()

	for iter_131_0, iter_131_1 in pairs(arg_131_0.charNames) do
		arg_131_0:loadOneSpineChar(iter_131_0, arg_131_0.serveChar)
	end

	return
end

function var_0_0.loadOneSpineChar(arg_132_0, arg_132_1, arg_132_2)
	if not arg_132_0.charNames[arg_132_1] then
		arg_132_0.charNames[arg_132_1] = false

		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(arg_132_0.charNames[arg_132_1], true, function(arg_133_0)
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

		arg_132_0.charModels[arg_132_1] = arg_133_0

		local var_133_2 = arg_133_0:GetComponent("SpineAnimUI")
		local var_133_3 = arg_133_0:GetComponent("SkeletonGraphic")

		var_133_2:SetAction("normal2", 0)

		var_133_3.timeScale = 1

		local var_133_4 = arg_132_0._tf:Find("game_ui/char/" .. arg_132_1)

		setParent(arg_133_0, var_133_4)

		arg_132_0.charactor[arg_132_1] = var_0_34(arg_132_0, var_133_4, var_133_2, var_133_3, var_133_1)

		if arg_132_1 == arg_132_2 then
			if arg_132_0.beginTeam == var_0_3 then
				arg_132_0.charactor[arg_132_1]:setPosTag("our_serve")
			else
				arg_132_0.charactor[arg_132_1]:setPosTag("enemy_serve")
			end
		end

		return
	end)

	return
end

function var_0_0.clearSpineChars(arg_134_0)
	for iter_134_0, iter_134_1 in pairs(arg_134_0.charModels) do
		if arg_134_0.charModels[iter_134_0] and arg_134_0.charNames[iter_134_0] then
			PoolMgr.GetInstance():ReturnSpineChar(arg_134_0.charNames[iter_134_0], arg_134_0.charModels[iter_134_0])
		end
	end

	arg_134_0.charModels = {}

	return
end

function var_0_0.getCharWithTag(arg_135_0, arg_135_1)
	for iter_135_0, iter_135_1 in pairs(arg_135_0.charactor) do
		if iter_135_1:getPosTag() == arg_135_1 then
			return iter_135_0, iter_135_1
		end
	end

	return nil
end

function var_0_0.getAnotherChar(arg_136_0, arg_136_1)
	local var_136_0 = ""

	if string.find(arg_136_1, "our") then
		var_136_0 = arg_136_1 == "our1" and "our2" or "our1"
	elseif string.find(arg_136_1, "enemy") then
		var_136_0 = arg_136_1 == "enemy1" and "enemy2" or "enemy1"
	end

	return var_136_0, arg_136_0.charactor[var_136_0]
end

function var_0_0.setBallPos(arg_137_0)
	setActive(arg_137_0.ball, true)

	local var_137_0 = string.find(arg_137_0.serveChar, "our") and "our_serve" or "enemy_serve"

	arg_137_0.ball.anchoredPosition = {
		x = arg_137_0.orgPos[var_137_0].x,
		y = arg_137_0.orgPos[var_137_0].y + 300
	}
	arg_137_0.ballShadow.anchoredPosition = Vector3(arg_137_0.orgPos[var_137_0].x, arg_137_0.orgPos[var_137_0].y, 0)

	arg_137_0:managedTween(LeanTween.rotate, nil, arg_137_0.ball, 360, 0.5):setLoopClamp()

	return
end

function var_0_0.resetChar(arg_138_0)
	arg_138_0:resetPos()

	for iter_138_0, iter_138_1 in pairs(arg_138_0.charactor) do
		if LeanTween.isTweening(go(iter_138_1._tf)) then
			LeanTween.cancel(go(iter_138_1._tf))
		end
	end

	arg_138_0.charactor.our1:setPosTag("our1")
	arg_138_0.charactor.our2:setPosTag("our2")
	arg_138_0.charactor.enemy1:setPosTag("enemy1")
	arg_138_0.charactor.enemy2:setPosTag("enemy2")

	if arg_138_0.beginTeam == var_0_3 then
		arg_138_0.serveChar = "our" .. math.random(2)

		arg_138_0.charactor[arg_138_0.serveChar]:setPosTag("our_serve")
	else
		arg_138_0.serveChar = "enemy" .. math.random(2)

		arg_138_0.charactor[arg_138_0.serveChar]:setPosTag("enemy_serve")
	end

	arg_138_0:setBallPos()

	return
end

function var_0_0.charServeBall(arg_139_0)
	arg_139_0:managedTween(LeanTween.rotate, nil, arg_139_0.ball, 360, 0.5):setLoopClamp()

	local var_139_0 = string.find(arg_139_0.serveChar, "our") and "our_serve" or "enemy_serve"

	arg_139_0:managedTween(LeanTween.delayedCall, function()
		arg_139_0:managedTween(LeanTween.moveY, nil, arg_139_0.ball, arg_139_0.orgPos[var_139_0].y + var_0_24, 0.5):setEase(LeanTweenType.linear)
		arg_139_0.charactor[arg_139_0.serveChar]:setActionOnce("faqiu", function()
			arg_139_0:managedTween(LeanTween.delayedCall, function()
				arg_139_0.charactor[arg_139_0.serveChar]:move(1, arg_139_0.serveChar)

				return
			end, 0.2, nil)

			return
		end)

		return
	end, 0.5, nil)

	return
end

function var_0_0.charUpBall(arg_143_0, arg_143_1)
	local var_143_0, var_143_1 = arg_143_0:getCharWithTag(arg_143_0.ballPosTag)

	if not var_143_1 then
		return
	end

	arg_143_0.upChar = var_143_0
	arg_143_0.hitChar = arg_143_0:getAnotherChar(arg_143_0.upChar)

	var_143_1:move(0.45, arg_143_0.ballPosTag, nil, function()
		var_143_1:setActionOnce("chuanqiu")

		return
	end)

	return
end

function var_0_0.charHitBall(arg_145_0)
	arg_145_0.charactor[arg_145_0.hitChar]:move(0.5, arg_145_0.ballPosTag, nil, function()
		var_0:setActionOnce("kouqiu")

		return
	end)

	return
end

function var_0_0.showcutin(arg_147_0, arg_147_1)
	arg_147_0:setBtnAvailable(false)
	arg_147_0:pauseGame()
	setActive(arg_147_0.cutin, true)

	local var_147_0 = ""

	for iter_147_0, iter_147_1 in pairs(arg_147_0.charNames) do
		if iter_147_0 == arg_147_0.hitChar then
			var_147_0 = iter_147_1
		end
	end

	local var_147_1, var_147_2, var_147_3 = ShipWordHelper.GetWordAndCV(var_0_2[arg_147_0:getCharIndex(var_147_0)], "skill")

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_147_2)
	setActive(arg_147_0.gameUI:Find("line"), true)
	setActive(arg_147_0.cutin:Find("shatanpaiqiu_cutin"), false)
	setActive(arg_147_0.cutin:Find("shatanpaiqiu_cutin"), true)
	setImageSprite(arg_147_0.cutinPaint, arg_147_0.cutinPaints:Find(arg_147_0:getCharIndex(var_147_0)):GetComponent(typeof(Image)).sprite, true)
	LeanTween.moveX(arg_147_0.cutin, 0, 0.3):setOnComplete(System.Action(function()
		LeanTween.delayedCall(1, System.Action(function()
			setActive(arg_147_0.gameUI:Find("line"), false)
			LeanTween.moveX(arg_147_0.cutin, -567, 0.3):setOnComplete(System.Action(function()
				setActive(arg_147_0.cutin, false)
				arg_147_0:setBtnAvailable(true)
				arg_147_0:resumeGame()

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

function var_0_0.showScoreCutin(arg_151_0, arg_151_1)
	arg_151_0:setBtnAvailable(false)
	arg_151_0:pauseGame()
	setImageSprite(arg_151_0.ourScoreCutin, arg_151_0.scoreCutinNums:Find(arg_151_0.ourScoreNum):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(arg_151_0.enemyScoreCutin, arg_151_0.scoreCutinNums:Find(arg_151_0.enemyScoreNum):GetComponent(typeof(Image)).sprite, true)
	setActive(arg_151_0.scoreCutin, true)
	setLocalScale(arg_151_0.scoreCutin, Vector3(1, 0, 1))
	LeanTween.scale(arg_151_0.scoreCutin, Vector3(1, 1, 1), 0.2):setOnComplete(System.Action(function()
		arg_151_0:resetChar()
		LeanTween.delayedCall(0.6, System.Action(function()
			LeanTween.scale(arg_151_0.scoreCutin, Vector3(1, 0, 1), 0.2):setOnComplete(System.Action(function()
				setActive(arg_151_0.scoreCutin, false)
				arg_151_0:setBtnAvailable(true)
				arg_151_0:resumeGame()

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

function var_0_0.updateScore(arg_155_0)
	setText(arg_155_0.ourScore, arg_155_0.ourScoreNum)
	setText(arg_155_0.enemyScore, arg_155_0.enemyScoreNum)
	setActive(arg_155_0.qte, false)

	if arg_155_0.ourScoreNum >= arg_155_0.endScore or arg_155_0.enemyScoreNum >= arg_155_0.endScore then
		arg_155_0:endGame()
	else
		arg_155_0:showScoreCutin(function()
			arg_155_0:startGame()

			return
		end)
	end

	return
end

function var_0_0.endGame(arg_157_0)
	setActive(arg_157_0.winTag, arg_157_0.ourScoreNum ~= arg_157_0.enemyScoreNum)
	setActive(arg_157_0.loseTag, arg_157_0.ourScoreNum ~= arg_157_0.enemyScoreNum)
	arg_157_0:setBtnAvailable(false)

	arg_157_0.isInGame = false

	pg.UIMgr.GetInstance():BlurPanel(arg_157_0.endUI)
	setActive(arg_157_0.endUI, true)
	setActive(arg_157_0.endFreeTitle, arg_157_0.isFree)
	setActive(arg_157_0.endDayTitle, not arg_157_0.isFree)
	setImageSprite(arg_157_0.endTitleDay, arg_157_0.titleDays:Find(arg_157_0.curDay):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(arg_157_0.endOurScore, arg_157_0.endScoreNums:Find(arg_157_0.ourScoreNum):GetComponent(typeof(Image)).sprite, true)
	setImageSprite(arg_157_0.endEnemyScore, arg_157_0.endScoreNums:Find(arg_157_0.enemyScoreNum):GetComponent(typeof(Image)).sprite, true)

	local var_157_1

	if arg_157_0.ourScoreNum > arg_157_0.enemyScoreNum then
		arg_157_0.winTag.anchoredPosition = Vector3(-170, 200, 0)
		arg_157_0.loseTag.anchoredPosition = Vector3(180, 200, 0)
		var_157_1 = -20
	else
		arg_157_0.winTag.anchoredPosition = Vector3(170, 200, 0)
		arg_157_0.loseTag.anchoredPosition = Vector3(-180, 200, 0)
		var_157_1 = 20
	end

	setActive(arg_157_0.winTag:GetChild(0), false)
	setActive(arg_157_0.winTag:GetChild(0), true)
	setLocalRotation(arg_157_0.loseTag, Vector3(0, 0, 0))
	LeanTween.rotateZ(go(arg_157_0.loseTag), var_157_1, 0.2):setOnComplete(System.Action(function()
		if arg_157_0:GetMGHubData().count > 0 then
			arg_157_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)
		end

		return
	end))

	return
end

function var_0_0.OnGetAwardDone(arg_159_0, arg_159_1)
	if arg_159_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_159_0 = arg_159_0:GetMGHubData()
		local var_159_1 = var_159_0.ultimate
		local var_159_2 = var_159_0.usedtime
		local var_159_3 = var_159_0:getConfig("reward_need")
		local var_159_4 = arg_159_0:GetMGHubData().count
		local var_159_5 = pg.NewStoryMgr.GetInstance()
		local var_159_6 = arg_159_0.storylist[arg_159_0:GetMGHubData().usedtime] and arg_159_0.storylist[arg_159_0:GetMGHubData().usedtime][1] or nil

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

		goto label_159_0
	end

	::label_159_0::

	if arg_159_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		if arg_159_0.storylist[7][1] then
			do
				local var_159_7 = arg_159_0.storylist[7][1] or nil
				local var_159_8 = pg.NewStoryMgr.GetInstance()

				if var_159_7 and not var_159_8:IsPlayed(var_159_7) then
					var_159_8:Play(var_159_7)
				end
			end

			return
		end
	end
end

function var_0_0.pauseGame(arg_160_0)
	arg_160_0:pauseManagedTween()

	if arg_160_0.qteTimer then
		arg_160_0.qteTimer:Pause()
	end

	if arg_160_0.qteTween and LeanTween.isTweening(arg_160_0.qteTween) then
		LeanTween.pause(arg_160_0.qteTween)
	end

	for iter_160_0, iter_160_1 in pairs(arg_160_0.charactor) do
		iter_160_1:pauseSpine()
	end

	return
end

function var_0_0.resumeGame(arg_161_0)
	arg_161_0:resumeManagedTween()

	if arg_161_0.qteTimer then
		arg_161_0.qteTimer:Resume()
	end

	if arg_161_0.qteTween and LeanTween.isTweening(arg_161_0.qteTween) then
		LeanTween.resume(arg_161_0.qteTween)
	end

	for iter_161_0, iter_161_1 in pairs(arg_161_0.charactor) do
		iter_161_1:resumeSpine()
	end

	return
end

function var_0_0.clearTimer(arg_162_0)
	if arg_162_0.qteTimer then
		arg_162_0.qteTimer:Stop()

		arg_162_0.qteTimer = nil
	end

	if arg_162_0.countTimer then
		arg_162_0.countTimer:Stop()

		arg_162_0.countTimer = nil
	end

	return
end

function var_0_0.changeQTEBtnStatus(arg_163_0, arg_163_1)
	arg_163_0.qteBtnStatus = arg_163_1

	return
end

function var_0_0.resetGameData(arg_164_0)
	arg_164_0.qteStatus = var_0_9
	arg_164_0.qteType = var_0_12

	arg_164_0:changeQTEBtnStatus(var_0_5)

	arg_164_0.ballPosTag = ""
	arg_164_0.isCutin = false
	arg_164_0.cutin.anchoredPosition = {
		x = -567,
		y = 582
	}
	arg_164_0.isScoreCutin = false

	setActive(arg_164_0.scoreCutin, false)

	arg_164_0.ourScoreNum = 0
	arg_164_0.enemyScoreNum = 0

	setText(arg_164_0.ourScore, arg_164_0.ourScoreNum)
	setText(arg_164_0.enemyScore, arg_164_0.enemyScoreNum)
	setActive(arg_164_0.qte, false)
	arg_164_0:loadSpineChars()

	return
end

function var_0_0.exitGame(arg_165_0)
	arg_165_0.isInGame = false

	arg_165_0:setBtnAvailable(true)
	arg_165_0:resetGameAni()

	return
end

function var_0_0.resetGameAni(arg_166_0)
	arg_166_0:cleanManagedTween()

	if arg_166_0.qteTween and LeanTween.isTweening(arg_166_0.qteTween) then
		LeanTween.cancel(arg_166_0.qteTween, false)
	end

	arg_166_0:clearTimer()

	return
end

function var_0_0.willExit(arg_167_0)
	arg_167_0:clearSpineChars()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_167_0.selectUI, arg_167_0._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_167_0.endUI, arg_167_0._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_167_0.countTimeUI, arg_167_0._tf)

	return
end

function var_0_0.onBackPressed(arg_168_0)
	if arg_168_0.isInGame then
		triggerButton(arg_168_0.backBtn)
	elseif isActive(arg_168_0.selectUI) then
		triggerButton(arg_168_0.selectBackBtn)
	elseif isActive(arg_168_0.mainUI) then
		triggerButton(arg_168_0.returnBtn)
	end

	return
end

return var_0_0
