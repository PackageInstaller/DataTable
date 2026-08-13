class = var_0_10000

local var_0_0 = "VolleyballGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = {
	"maliluosi_2_DOA",
	"suixiang_2_doa",
	"xia_2_DOA",
	"haixiao_2_DOA",
	"zhixiao_2_DOA",
	"nvtiangou_2_DOA",
	"monika_2_DOA"
}
local var_0_3 = {
	10600010,
	10600020,
	10600030,
	10600040,
	10600050,
	10600060,
	10600070
}
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = -1
local var_0_7 = 0
local var_0_8 = 0.35
local var_0_9 = 0.15
local var_0_10 = 0
local var_0_11 = 1
local var_0_12 = 2
local var_0_13 = 0
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = 1.5
local var_0_17 = 1
local var_0_18 = 0.5
local var_0_19 = 0.5
local var_0_20 = 0.43
local var_0_21 = 0.5
local var_0_22 = 0.76
local var_0_23 = 0.83
local var_0_24 = -30
local var_0_25 = 50
local var_0_26 = 60
local var_0_27 = 230
local var_0_28 = 60
local var_0_29 = "event:/ui/ddldaoshu2"
local var_0_30 = "event:/ui/fighterplane_click"
local var_0_31 = "event:/ui/jieqiu"
local var_0_32 = "event:/ui/kouqiu"
local var_0_33 = 0.8
local var_0_34 = -1000

function var_0_1.getUIName(arg_1_0)
	return "VolleyballGameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.countTimeUI = var_1.Find(var_2_0, "count_time_ui")

	local var_2_1 = arg_2_0.countTimeUI

	arg_2_0.countTimeImage = var_1.Find(var_2_1, "time")

	local var_2_2 = arg_2_0.countTimeUI

	arg_2_0.countTimeNumImage = var_1.Find(var_2_2, "nums")

	local var_2_3 = arg_2_0._tf

	arg_2_0.mainUI = var_1.Find(var_2_3, "main_ui")

	local var_2_4 = arg_2_0.mainUI

	arg_2_0.returnBtn = var_1.Find(var_2_4, "return_btn")

	local var_2_5 = arg_2_0.mainUI

	arg_2_0.mainStartBtn = var_1.Find(var_2_5, "start_btn")

	local var_2_6 = arg_2_0.mainUI

	arg_2_0.ruleBtn = var_1.Find(var_2_6, "rule_btn")

	local var_2_7 = arg_2_0.mainUI

	arg_2_0.progressScroll = var_1.Find(var_2_7, "right_panel/scroll_view/")

	local var_2_8 = arg_2_0.mainUI

	arg_2_0.progressContent = var_1.Find(var_2_8, "right_panel/scroll_view/viewport/content")

	local var_2_9 = arg_2_0.mainUI

	arg_2_0.colors = var_1.Find(var_2_9, "right_panel/colors")

	local var_2_10 = arg_2_0.mainUI

	arg_2_0.icons = var_1.Find(var_2_10, "right_panel/icons")

	local var_2_11 = arg_2_0.mainUI

	arg_2_0.gotIcon = var_1.Find(var_2_11, "bg/got")

	local var_2_12 = arg_2_0._tf

	arg_2_0.selectUI = var_1.Find(var_2_12, "select_ui")

	local var_2_13 = arg_2_0.selectUI

	arg_2_0.selectBackBtn = var_1.Find(var_2_13, "back_btn")

	local var_2_14 = arg_2_0.selectUI

	arg_2_0.selectStartBtn = var_1.Find(var_2_14, "start_btn")

	local var_2_15 = arg_2_0.selectUI

	arg_2_0.tags = var_1.Find(var_2_15, "select_panel/tags")

	local var_2_16 = arg_2_0.selectUI

	arg_2_0.paints = var_1.Find(var_2_16, "select_panel/paints")

	local var_2_17 = arg_2_0.selectUI

	arg_2_0.freeTitle = var_1.Find(var_2_17, "select_panel/title/free")

	local var_2_18 = arg_2_0.selectUI

	arg_2_0.dayTitle = var_1.Find(var_2_18, "select_panel/title/challenge")

	local var_2_19 = arg_2_0.selectUI

	arg_2_0.titleDayNum = var_1.Find(var_2_19, "select_panel/title/challenge/num")

	local var_2_20 = arg_2_0.selectUI

	arg_2_0.ruleTxt = var_1.Find(var_2_20, "select_panel/rule/rule_txt")

	local var_2_21 = arg_2_0.selectUI

	arg_2_0.select4Chars = var_1.Find(var_2_21, "select_panel/chars")

	local var_2_22 = arg_2_0.selectUI

	arg_2_0.selectWindow = var_1.Find(var_2_22, "select_windows")

	local var_2_23 = arg_2_0.selectWindow

	arg_2_0.selectSureBtn = var_1.Find(var_2_23, "windows/sure_btn")

	local var_2_24 = arg_2_0.selectWindow

	arg_2_0.select9Chars = var_1.Find(var_2_24, "windows/char_layout")

	local var_2_25 = arg_2_0.selectWindow

	arg_2_0.selectNum = var_1.Find(var_2_25, "windows/tips/num")

	local var_2_26 = arg_2_0._tf

	arg_2_0.gameUI = var_1.Find(var_2_26, "game_ui")

	local var_2_27 = arg_2_0.gameUI

	arg_2_0.bgEffect = var_1.Find(var_2_27, "bg/shatanpaiqiu_hailang")

	local var_2_28 = arg_2_0.gameUI

	arg_2_0.hitEffect = var_1.Find(var_2_28, "shatanpaiqiu_jida")

	local var_2_29 = arg_2_0.gameUI

	arg_2_0.upEffect = var_1.Find(var_2_29, "shatanpaiqiu_jieqiu")

	local var_2_30 = arg_2_0.gameUI

	arg_2_0.ball = var_1.Find(var_2_30, "ball")

	local var_2_31 = arg_2_0.gameUI

	arg_2_0.ballShadow = var_1.Find(var_2_31, "ball_shadow")

	local var_2_32 = arg_2_0.gameUI

	arg_2_0.pauseBtn = var_1.Find(var_2_32, "pause_btn")

	local var_2_33 = arg_2_0.gameUI

	arg_2_0.backBtn = var_1.Find(var_2_33, "back_btn")

	local var_2_34 = arg_2_0.gameUI

	arg_2_0.qteBtn = var_1.Find(var_2_34, "qte_btn")

	local var_2_35 = arg_2_0.gameUI

	arg_2_0.pos = var_1.Find(var_2_35, "pos")

	arg_2_0:initPos()

	local var_2_36 = arg_2_0.gameUI

	arg_2_0.ourScore = var_1.Find(var_2_36, "score/our")

	local var_2_37 = arg_2_0.gameUI

	arg_2_0.enemyScore = var_1.Find(var_2_37, "score/enemy")

	local var_2_38 = arg_2_0.gameUI

	arg_2_0.qte = var_1.Find(var_2_38, "qte")

	local var_2_39 = arg_2_0.qte

	arg_2_0.qteCircles = var_1.Find(var_2_39, "circles")

	local var_2_40 = arg_2_0.qte

	arg_2_0.qteCircle = var_1.Find(var_2_40, "circles/big")

	local var_2_41 = arg_2_0.qte

	arg_2_0.result = var_1.Find(var_2_41, "result")

	local var_2_42 = arg_2_0.qte

	arg_2_0.resultTxt = var_1.Find(var_2_42, "txts")

	local var_2_43 = arg_2_0.gameUI

	arg_2_0.cutin = var_1.Find(var_2_43, "cutin")

	local var_2_44 = arg_2_0.gameUI

	arg_2_0.cutinPaint = var_1.Find(var_2_44, "cutin/paint")

	local var_2_45 = arg_2_0.gameUI

	arg_2_0.cutinPaints = var_1.Find(var_2_45, "cutin_paints")

	local var_2_46 = arg_2_0.gameUI

	arg_2_0.scoreCutin = var_1.Find(var_2_46, "score_cutin")

	local var_2_47 = arg_2_0.gameUI

	arg_2_0.scoreCutinNums = var_1.Find(var_2_47, "score_cutin/nums")

	local var_2_48 = arg_2_0.gameUI

	arg_2_0.ourScoreCutin = var_1.Find(var_2_48, "score_cutin/our")

	local var_2_49 = arg_2_0.gameUI

	arg_2_0.enemyScoreCutin = var_1.Find(var_2_49, "score_cutin/enemy")
	arg_2_0.charTF = {}

	local var_2_50 = arg_2_0.charTF
	local var_2_51 = arg_2_0.gameUI

	var_2_50.our1 = var_2.Find(var_2_51, "char/our1")

	local var_2_52 = arg_2_0.charTF
	local var_2_53 = arg_2_0.gameUI

	var_2_52.our2 = var_2.Find(var_2_53, "char/our2")

	local var_2_54 = arg_2_0.charTF
	local var_2_55 = arg_2_0.gameUI

	var_2_54.enemy1 = var_2.Find(var_2_55, "char/enemy1")

	local var_2_56 = arg_2_0.charTF
	local var_2_57 = arg_2_0.gameUI

	var_2_56.enemy2 = var_2.Find(var_2_57, "char/enemy2")
	arg_2_0.charModels = {}
	arg_2_0.charactor = {}

	local var_2_58 = arg_2_0.gameUI

	arg_2_0.cutinMask = var_1.Find(var_2_58, "cutin_mask")

	local var_2_59 = arg_2_0._tf

	arg_2_0.endUI = var_1.Find(var_2_59, "end_ui")

	local var_2_60 = arg_2_0.endUI

	arg_2_0.endDayTitle = var_1.Find(var_2_60, "title/race")

	local var_2_61 = arg_2_0.endUI

	arg_2_0.endFreeTitle = var_1.Find(var_2_61, "title/free")

	local var_2_62 = arg_2_0.endUI

	arg_2_0.endTitleDay = var_1.Find(var_2_62, "title/race/num")

	local var_2_63 = arg_2_0.endUI

	arg_2_0.titleDays = var_1.Find(var_2_63, "title_days")

	local var_2_64 = arg_2_0.endUI

	arg_2_0.endOurScore = var_1.Find(var_2_64, "score_panel/score/our")

	local var_2_65 = arg_2_0.endUI

	arg_2_0.endEnemyScore = var_1.Find(var_2_65, "score_panel/score/enemy")

	local var_2_66 = arg_2_0.endUI

	arg_2_0.endScoreNums = var_1.Find(var_2_66, "nums")

	local var_2_67 = arg_2_0.endUI

	arg_2_0.sureBtn = var_1.Find(var_2_67, "sure_btn")

	local var_2_68 = arg_2_0.endUI

	arg_2_0.winTag = var_1.Find(var_2_68, "score_panel/score/win")

	local var_2_69 = arg_2_0.endUI

	arg_2_0.loseTag = var_1.Find(var_2_69, "score_panel/score/lose")

	local var_2_70 = arg_2_0._tf

	arg_2_0.helpUI = var_1.Find(var_2_70, "help_ui")

	local var_2_71 = arg_2_0
	local var_2_72 = arg_2_0.GetMiniGameHudId

	ActivityConst = var_3
	arg_2_0.miniGameHudId = var_2_72(var_2_71, var_3.MINIGAME_VOLLEYBALL)

	local var_2_73 = arg_2_0
	local var_2_74 = arg_2_0.GetDOA2MiniGameId

	ActivityConst = var_3
	arg_2_0.miniGameId = var_2_74(var_2_73, var_3.MINIGAME_VOLLEYBALL)

	return
end

function var_0_1.initPos(arg_3_0)
	arg_3_0.orgPos = {}

	local var_3_0 = arg_3_0.orgPos
	local var_3_1 = arg_3_0.pos

	var_3_0.our_serve = var_2.Find(var_3_1, "our_pos/serve_pos").anchoredPosition

	local var_3_2 = arg_3_0.orgPos
	local var_3_3 = arg_3_0.pos

	var_3_2.our1 = var_2.Find(var_3_3, "our_pos/drop_pos1").anchoredPosition

	local var_3_4 = arg_3_0.orgPos
	local var_3_5 = arg_3_0.pos

	var_3_4.our2 = var_2.Find(var_3_5, "our_pos/drop_pos2").anchoredPosition

	local var_3_6 = arg_3_0.orgPos
	local var_3_7 = arg_3_0.pos

	var_3_6.enemy_serve = var_2.Find(var_3_7, "enemy_pos/serve_pos").anchoredPosition

	local var_3_8 = arg_3_0.orgPos
	local var_3_9 = arg_3_0.pos

	var_3_8.enemy1 = var_2.Find(var_3_9, "enemy_pos/drop_pos1").anchoredPosition

	local var_3_10 = arg_3_0.orgPos
	local var_3_11 = arg_3_0.pos

	var_3_10.enemy2 = var_2.Find(var_3_11, "enemy_pos/drop_pos2").anchoredPosition

	arg_3_0:resetPos()

	return
end

function var_0_1.resetPos(arg_4_0)
	Clone = var_1_10001
	arg_4_0.anchoredPos = var_1_10001(arg_4_0.orgPos)
	arg_4_0.anchoredPos.our1 = arg_4_0:getRandomPos("our1")
	arg_4_0.anchoredPos.our2 = arg_4_0:getRandomPos("our2")
	arg_4_0.anchoredPos.enemy1 = arg_4_0:getRandomPos("enemy1")
	arg_4_0.anchoredPos.enemy2 = arg_4_0:getRandomPos("enemy2")

	return
end

function var_0_1.GetMiniGameHudId(arg_5_0, arg_5_1)
	pg = var_1_10002

	if not var_1_10002.activity_template[arg_5_1] then
		return nil
	end

	return var_2.config_id
end

function var_0_1.GetDOA2MiniGameId(arg_6_0, arg_6_1)
	pg = var_1_10002

	if not var_1_10002.activity_template[arg_6_1] then
		error = var_1_10003

		var_1_10003("未找到对应DOA活动ID")

		return nil
	end

	local var_6_0 = var_2.config_id

	pg = var_1_10004

	for iter_6_0 = #var_1_10004.mini_game.all, 1, -1 do
		pg = var_1_10008
		var_1_10008 = var_1_10008.mini_game.all[iter_6_0]
		pg = var_1_10009

		if var_1_10009.mini_game[var_1_10008] and var_1_10009.hub_id == var_6_0 then
			return var_1_10008
		end
	end

	error = var_4

	var_4("未找到对应DOA活动的miniGameID")

	return nil
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.returnBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.ruleBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		i18n = var_2_10003
		var_9_2.helps = var_2_10003("venusvolleyball_help")

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.mainStartBtn

	local function var_7_8()
		setActive = var_2_10000

		var_2_10000(arg_7_0.selectUI, true)

		pg = var_2_10000

		local var_10_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_10_0, arg_7_0.selectUI)

		local var_10_1 = arg_7_0

		var_0.initSelectUI(var_10_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.selectBackBtn

	local function var_7_11()
		setActive = var_2_10000

		var_2_10000(arg_7_0.selectUI, false)

		pg = var_2_10000

		local var_11_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_11_0, arg_7_0.selectUI, arg_7_0._tf)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	arg_7_0.canStartGame = false
	onButton = var_1

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.selectStartBtn

	local function var_7_14()
		if not arg_7_0.canStartGame then
			return
		end

		setActive = var_0

		var_0(arg_7_0.mainUI, false)

		setActive = var_0

		var_0(arg_7_0.selectUI, false)

		pg = var_0

		local var_12_0 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_12_0, arg_7_0.selectUI, arg_7_0._tf)

		setActive = var_0

		var_0(arg_7_0.gameUI, true)

		local var_12_1 = arg_7_0

		var_0.resetGameData(var_12_1)

		if arg_7_0.isFirstgame == 0 then
			local var_12_2 = arg_7_0

			var_0.firstShow(var_12_2, function()
				local var_13_0 = arg_7_0

				var_0.startCountTimer(var_13_0)

				return
			end)
		else
			local var_12_3 = arg_7_0

			var_0.startCountTimer(var_12_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_12, var_7_13, var_7_14, var_1_10005)

	arg_7_0.canSureChar = false
	onButton = var_1

	local var_7_15 = arg_7_0
	local var_7_16 = arg_7_0.selectSureBtn

	local function var_7_17()
		if not arg_7_0.canSureChar then
			return
		end

		local var_14_0

		if arg_7_0.selectCharCamp == "enemy" then
			var_14_0 = arg_7_0.charNames
			var_14_0.enemy1 = var_0_2[arg_7_0.selectSDIndex1]
			var_14_0 = arg_7_0.charNames
			var_14_0.enemy2 = var_0_2[arg_7_0.selectSDIndex2]
		elseif arg_7_0.selectCharCamp == "our" then
			var_14_0 = arg_7_0.charNames
			var_14_0.our1 = var_0_2[arg_7_0.selectSDIndex1]
			var_14_0 = arg_7_0.charNames
			var_14_0.our2 = var_0_2[arg_7_0.selectSDIndex2]
		end

		setActive = var_14_0

		var_14_0(arg_7_0.selectWindow, false)

		local var_14_1 = arg_7_0

		var_0.refreshSelectUI(var_14_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_15, var_7_16, var_7_17, var_1_10005)

	onButton = var_1

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.selectWindow
	local var_7_20 = var_3.Find(var_7_19, "mask")

	local function var_7_21()
		setActive = var_2_10000

		var_2_10000(arg_7_0.selectWindow, false)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_18, var_7_20, var_7_21, var_5)

	onButton = var_1

	local var_7_22 = arg_7_0
	local var_7_23 = arg_7_0.pauseBtn

	local function var_7_24()
		if not arg_7_0.btnAvailable then
			return
		end

		local var_16_0 = arg_7_0

		var_0.pauseGame(var_16_0)

		pg = var_0

		local var_16_1 = var_0.MsgboxMgr.GetInstance()
		local var_16_2 = var_0.ShowMsgBox
		local var_16_3 = {
			hideNo = true
		}

		i18n = var_2_10003
		var_16_3.content = var_2_10003("venusvolleyball_suspend_tip")

		function var_16_3.onNo()
			local var_17_0 = arg_7_0

			var_0.resumeGame(var_17_0)

			return
		end

		function var_16_3.onYes()
			local var_18_0 = arg_7_0

			var_0.resumeGame(var_18_0)

			return
		end

		var_16_2(var_16_1, var_16_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_22, var_7_23, var_7_24, var_5)

	onButton = var_1

	local var_7_25 = arg_7_0
	local var_7_26 = arg_7_0.backBtn

	local function var_7_27()
		if not arg_7_0.btnAvailable then
			return
		end

		local var_19_0 = arg_7_0

		var_0.pauseGame(var_19_0)

		pg = var_0

		local var_19_1 = var_0.MsgboxMgr.GetInstance()
		local var_19_2 = var_0.ShowMsgBox
		local var_19_3 = {}

		i18n = var_2_10003
		var_19_3.content = var_2_10003("venusvolleyball_return_tip")

		function var_19_3.onNo()
			local var_20_0 = arg_7_0

			var_0.resumeGame(var_20_0)

			return
		end

		function var_19_3.onYes()
			local var_21_0 = arg_7_0

			var_0.endGame(var_21_0)

			return
		end

		var_19_2(var_19_1, var_19_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_25, var_7_26, var_7_27, var_5)

	onButton = var_1

	var_1(arg_7_0, arg_7_0.qteBtn, function()
		if arg_7_0.qteBtnStatus == var_0_6 then
			return
		end

		local var_22_0 = arg_7_0

		var_0.qteResult(var_22_0)

		return
	end)

	onButton = var_1

	local var_7_28 = arg_7_0
	local var_7_29 = arg_7_0.sureBtn

	local function var_7_30()
		setActive = var_2_10000

		var_2_10000(arg_7_0.mainUI, true)

		local var_23_0 = arg_7_0

		var_0.initMainUI(var_23_0)

		setActive = var_0

		var_0(arg_7_0.gameUI, false)

		setActive = var_0

		var_0(arg_7_0.endUI, false)

		local var_23_1 = arg_7_0

		var_0.clearSpineChars(var_23_1)

		pg = var_0

		local var_23_2 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_23_2, arg_7_0.endUI, arg_7_0._tf)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_28, var_7_29, var_7_30, var_5)
	arg_7_0:initMainUI()

	return
end

function var_0_1.playEffect(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 then
		arg_24_1.anchoredPosition = arg_24_2
	else
		arg_24_1.anchoredPosition = arg_24_0.ball.anchoredPosition
	end

	setActive = var_1_10003

	var_1_10003(arg_24_1, false)

	setActive = var_1_10003

	var_1_10003(arg_24_1, true)

	return
end

function var_0_1.getGameData(arg_25_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002
	arg_25_0.mgProxy = var_1_10001(var_1_10002)

	local var_25_0 = arg_25_0.mgProxy

	arg_25_0.hubData = var_1.GetHubByHubId(var_25_0, arg_25_0.miniGameHudId)

	local var_25_1

	if arg_25_0.hubData.ultimate ~= 0 or not (arg_25_0.hubData.usedtime + 1) then
		var_25_1 = 8
	end

	arg_25_0.curDay = var_25_1
	arg_25_0.unlockDay = arg_25_0.hubData.usedtime + arg_25_0.hubData.count

	local var_25_2

	if not (arg_25_0.curDay <= arg_25_0.unlockDay) or not arg_25_0.curDay then
		var_25_2 = arg_25_0.unlockDay
	end

	arg_25_0.curDay = var_25_2

	local var_25_3 = arg_25_0.mgProxy

	arg_25_0.mgData = var_1.GetMiniGameData(var_25_3, arg_25_0.miniGameId)

	local var_25_4 = arg_25_0.mgData

	arg_25_0.endScore = var_1.GetSimpleValue(var_25_4, "endScore")[arg_25_0.curDay]

	local var_25_5 = arg_25_0.mgData

	arg_25_0.storylist = var_1.GetSimpleValue(var_25_5, "story")
	getProxy = var_1
	PlayerProxy = var_25_5

	local var_25_6 = var_1(var_25_5)
	local var_25_7 = var_1.getData(var_25_6).id

	PlayerPrefs = var_25_6
	arg_25_0.isFirstgame = var_25_6.GetInt("volleyballgame_first_" .. var_25_7)

	return
end

function var_0_1.getEnemyCharsIndex(arg_26_0)
	local var_26_0 = arg_26_0.mgData
	local var_26_1 = var_1.GetSimpleValue(var_26_0, "mainChar")[arg_26_0.curDay]
	local var_26_2 = arg_26_0.mgData

	return var_26_1, var_2.GetSimpleValue(var_26_2, "minorChar")[arg_26_0.curDay]
end

function var_0_1.initMainUI(arg_27_0)
	arg_27_0.isInGame = false

	arg_27_0:getGameData()

	if arg_27_0.hubData.ultimate == 0 then
		local var_27_0 = arg_27_0.hubData.usedtime
		local var_27_1 = arg_27_0.hubData

		if var_27_0 >= var_2.getConfig(var_27_1, "reward_need") then
			pg = var_27_0

			local var_27_2 = var_27_0.m02
			local var_27_3 = var_1.sendNotification

			GAME = var_27_1

			local var_27_4 = var_27_1.SEND_MINI_GAME_OP
			local var_27_5 = {
				hubid = arg_27_0.hubData.id
			}

			MiniGameOPCommand = var_5
			var_27_5.cmd = var_5.CMD_ULTIMATE
			var_27_5.args1 = {}

			var_27_3(var_27_2, var_27_4, var_27_5)
		end
	end

	arg_27_0.isFree = arg_27_0.hubData.ultimate ~= 0 and true or false
	setActive = var_1

	local var_27_6 = arg_27_0.mainStartBtn

	var_1(var_2.Find(var_27_6, "free_tag"), arg_27_0.isFree)

	setActive = var_1

	var_1(arg_27_0.gotIcon, arg_27_0.isFree)

	eachChild = var_1

	var_1(arg_27_0.progressContent, function(arg_28_0)
		local var_28_0 = ""

		tonumber = var_2_10002

		local var_28_1 = var_2_10002(arg_28_0.name)
		local var_28_2 = var_0_2
		local var_28_3 = arg_27_0.mgData
		local var_28_4 = var_28_2[var_4.GetSimpleValue(var_28_3, "mainChar")[var_28_1]]

		setActive = var_4

		var_4(arg_28_0:Find("char_bg/mask"), false)

		setActive = var_4

		var_4(arg_28_0:Find("name_bg/mask"), false)

		setActive = var_4

		var_4(arg_28_0:Find("pass"), false)

		if var_28_1 == arg_27_0.curDay and arg_27_0.hubData.count > 0 then
			var_28_0 = "red"
			setImageSprite = var_4

			local var_28_5 = arg_28_0:Find("char_bg/icon")
			local var_28_6 = arg_27_0.icons
			local var_28_7 = var_6.Find

			var_2_10009 = arg_27_0

			local var_28_8 = var_28_7(var_28_6, var_8.getCharIndex(var_2_10009, var_28_4))
			local var_28_9 = var_6.GetComponent

			typeof = var_8
			Image = var_2_10009

			var_4(var_28_5, var_28_9(var_28_8, var_8(var_2_10009)).sprite, true)
		elseif var_28_1 < arg_27_0.curDay or var_28_1 == arg_27_0.curDay and arg_27_0.hubData.count == 0 then
			var_28_0 = "grey"
			setImageSprite = var_4

			local var_28_10 = arg_28_0:Find("char_bg/icon")
			local var_28_11 = arg_27_0.icons
			local var_28_12 = var_6.Find

			var_2_10009 = arg_27_0

			local var_28_13 = var_28_12(var_28_11, var_8.getCharIndex(var_2_10009, var_28_4))
			local var_28_14 = var_6.GetComponent

			typeof = var_8
			Image = var_2_10009

			var_4(var_28_10, var_28_14(var_28_13, var_8(var_2_10009)).sprite, true)

			setActive = var_4

			var_4(arg_28_0:Find("char_bg/mask"), true)

			setActive = var_4

			var_4(arg_28_0:Find("name_bg/mask"), true)

			setActive = var_4

			var_4(arg_28_0:Find("pass"), true)
		elseif arg_27_0.curDay < var_28_1 and var_28_1 <= arg_27_0.unlockDay then
			var_28_0 = "blue"
			setImageSprite = var_4

			local var_28_15 = arg_28_0:Find("char_bg/icon")
			local var_28_16 = arg_27_0.icons
			local var_28_17 = var_6.Find

			var_2_10009 = arg_27_0

			local var_28_18 = var_28_17(var_28_16, var_8.getCharIndex(var_2_10009, var_28_4))
			local var_28_19 = var_6.GetComponent

			typeof = var_8
			Image = var_2_10009

			var_4(var_28_15, var_28_19(var_28_18, var_8(var_2_10009)).sprite, true)
		else
			var_28_0 = "grey"
			setImageSprite = var_4

			local var_28_20 = arg_28_0:Find("char_bg/icon")
			local var_28_21 = arg_27_0.colors
			local var_28_22 = var_6.Find(var_28_21, "unkonwn")
			local var_28_23 = var_6.GetComponent

			typeof = var_8
			Image = var_2_10009

			var_4(var_28_20, var_28_23(var_28_22, var_8(var_2_10009)).sprite)
		end

		setImageSprite = var_4

		local var_28_24 = arg_28_0:Find("name_bg")
		local var_28_25 = arg_27_0.colors
		local var_28_26 = var_6.Find(var_28_25, var_28_0)
		local var_28_27 = var_6.GetComponent

		typeof = var_8
		Image = var_2_10009

		var_4(var_28_24, var_28_27(var_28_26, var_8(var_2_10009)).sprite)

		return
	end)

	local var_27_7 = 215

	math = var_2

	local var_27_8 = var_2.min(645, (arg_27_0.curDay - 1) * var_27_7)
	local var_27_9 = arg_27_0.progressContent

	var_27_9.anchoredPosition = {
		x = 0,
		y = var_27_8
	}
	onScroll = var_27_9

	var_27_9(arg_27_0, arg_27_0.progressScroll, function(arg_29_0)
		setActive = var_2_10001

		local var_29_0 = arg_27_0.mainUI

		var_2_10001(var_2.Find(var_29_0, "right_panel/arraws_up"), arg_29_0.y < 1 and true or false)

		setActive = var_2_10001

		local var_29_1 = arg_27_0.mainUI

		var_2_10001(var_2.Find(var_29_1, "right_panel/arraws_down"), arg_29_0.y > 0 and true or false)

		return
	end)

	return
end

function var_0_1.initSelectUI(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.freeTitle, arg_30_0.isFree)

	setActive = var_1_10001

	var_1_10001(arg_30_0.dayTitle, not arg_30_0.isFree)

	setText = var_1_10001

	var_1_10001(arg_30_0.titleDayNum, arg_30_0.curDay)

	setText = var_1_10001

	local var_30_0 = arg_30_0.ruleTxt

	i18n = var_3

	var_1_10001(var_30_0, var_3("venusvolleyball_rule_tip", arg_30_0.endScore))

	arg_30_0.charNames = {}
	arg_30_0.lastSelectNames = {}
	eachChild = var_1

	var_1(arg_30_0.select4Chars, function(arg_31_0)
		local var_31_0 = arg_31_0.name

		onButton = var_2_10002

		var_2_10002(arg_30_0, arg_31_0, function()
			if not arg_30_0.isFree then
				string = var_0

				if var_0.find(var_31_0, "enemy") then
					return
				end
			end

			local var_32_0 = arg_30_0

			string = var_3_10001
			var_32_0.selectCharCamp = var_3_10001.find(var_31_0, "enemy") and "enemy" or "our"

			local var_32_1 = arg_30_0

			var_0.openSelectWindow(var_32_1)

			return
		end)

		return
	end)

	if not arg_30_0.isFree then
		local var_30_1, var_30_2 = arg_30_0:getEnemyCharsIndex()

		arg_30_0.charNames.enemy1, arg_30_0.charNames.enemy2 = var_0_2[var_30_1], var_0_2[var_30_2]
	end

	arg_30_0:refreshSelectUI()

	return
end

function var_0_1.getCharIndex(arg_33_0, arg_33_1)
	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(var_0_2) do
		if iter_33_1 == arg_33_1 then
			return iter_33_0
		end
	end

	return 1
end

function var_0_1.refreshSelectUI(arg_34_0)
	eachChild = var_1_10001

	var_1_10001(arg_34_0.select4Chars, function(arg_35_0)
		local var_35_0 = arg_35_0.name

		if arg_34_0.charNames[var_35_0] then
			setActive = var_2

			var_2(arg_35_0:Find("select_btn"), false)

			setActive = var_2

			var_2(arg_35_0:Find("char"), true)

			setImageSprite = var_2

			local var_35_1 = arg_35_0:Find("char/icon")
			local var_35_2 = arg_34_0.paints
			local var_35_3 = var_4.Find
			local var_35_4 = arg_34_0
			local var_35_5 = var_35_3(var_35_2, var_6.getCharIndex(var_35_4, arg_34_0.charNames[var_35_0]))
			local var_35_6 = var_4.GetComponent

			typeof = var_6
			Image = var_35_4

			var_2(var_35_1, var_35_6(var_35_5, var_6(var_35_4)).sprite, true)

			setImageSprite = var_2

			local var_35_7 = arg_35_0:Find("char/tag")
			local var_35_8 = arg_34_0.tags
			local var_35_9 = var_4.Find
			local var_35_10 = arg_34_0
			local var_35_11 = var_35_9(var_35_8, var_6.getCharIndex(var_35_10, arg_34_0.charNames[var_35_0]))
			local var_35_12 = var_4.GetComponent

			typeof = var_6
			Image = var_35_10

			var_2(var_35_7, var_35_12(var_35_11, var_6(var_35_10)).sprite, true)
		else
			setActive = var_2

			var_2(arg_35_0:Find("select_btn"), true)

			setActive = var_2

			var_2(arg_35_0:Find("char"), false)
		end

		return
	end)

	local var_34_0

	if arg_34_0.charNames.our1 and arg_34_0.charNames.our2 and arg_34_0.charNames.enemy1 then
		var_34_0 = arg_34_0.charNames.enemy2
	end

	arg_34_0.canStartGame = var_34_0 and true or false
	setGray = var_2

	var_2(arg_34_0.selectStartBtn, not arg_34_0.canStartGame, not arg_34_0.canStartGame)

	return
end

function var_0_1.isSelected(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = false

	pairs = var_1_10004

	for iter_36_0, iter_36_1 in var_1_10004(arg_36_0.charNames) do
		if arg_36_1 == iter_36_1 then
			string = var_1_10009
			var_36_0 = not var_1_10009.find(iter_36_0, arg_36_2) and true or false
		end
	end

	return var_36_0
end

function var_0_1.openSelectWindow(arg_37_0)
	setActive = var_1_10001

	var_1_10001(arg_37_0.selectWindow, true)

	arg_37_0.hasSelectNum = 0
	setText = var_1

	local var_37_0 = arg_37_0.selectNum

	setColorStr = var_3

	local var_37_1 = arg_37_0.hasSelectNum

	COLOR_GREEN = var_1_10005

	var_1(var_37_0, var_3(var_37_1, var_1_10005) .. "/2")

	arg_37_0.selectSDIndex1 = nil
	arg_37_0.selectSDIndex2 = nil
	eachChild = var_1

	var_1(arg_37_0.select9Chars, function(arg_38_0)
		tonumber = var_2_10001

		local var_38_0 = var_2_10001(arg_38_0.name)

		setImageSprite = var_2

		local var_38_1 = arg_38_0:Find("char/frame/icon")
		local var_38_2 = arg_37_0.icons
		local var_38_3 = var_4.Find(var_38_2, var_38_0)
		local var_38_4 = var_4.GetComponent

		typeof = var_6
		Image = var_2_10007

		var_2(var_38_1, var_38_4(var_38_3, var_6(var_2_10007)).sprite, true)

		onButton = var_2

		var_2(arg_37_0, arg_38_0, function()
			local var_39_0 = arg_37_0

			if var_0.isSelected(var_39_0, var_0_2[var_38_0], arg_37_0.selectCharCamp) then
				return
			end

			pg = var_0

			local var_39_1 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_39_1, var_0_30)

			isActive = var_0

			local var_39_2 = arg_38_0

			if var_0(var_1.Find(var_39_2, "selected")) then
				setActive = var_0

				local var_39_3 = arg_38_0

				var_0(var_1.Find(var_39_3, "selected"), false)

				if arg_37_0.selectSDIndex1 and arg_37_0.selectSDIndex1 == var_38_0 then
					arg_37_0.selectSDIndex1 = nil
				end

				if arg_37_0.selectSDIndex2 and arg_37_0.selectSDIndex2 == var_38_0 then
					arg_37_0.selectSDIndex2 = nil
				end

				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum - 1
			elseif arg_37_0.selectSDIndex1 and arg_37_0.selectSDIndex2 then
				-- block empty
			elseif arg_37_0.selectSDIndex1 then
				arg_37_0.selectSDIndex2 = var_38_0
				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum + 1
			else
				arg_37_0.selectSDIndex1 = var_38_0
				arg_37_0.hasSelectNum = arg_37_0.hasSelectNum + 1
			end

			local var_39_4 = arg_37_0

			var_0.refreshSelectWindow(var_39_4)

			return
		end)

		return
	end)
	arg_37_0:refreshSelectWindow()

	return
end

function var_0_1.refreshSelectWindow(arg_40_0)
	eachChild = var_1_10001

	var_1_10001(arg_40_0.select9Chars, function(arg_41_0)
		tonumber = var_2_10001

		local var_41_0 = var_2_10001(arg_41_0.name)

		setActive = var_2

		local var_41_1 = arg_41_0:Find("char/mask")
		local var_41_2 = arg_40_0

		var_2(var_41_1, var_4.isSelected(var_41_2, var_0_2[var_41_0], arg_40_0.selectCharCamp) and true or false)

		if var_41_0 == arg_40_0.selectSDIndex1 or var_41_0 == arg_40_0.selectSDIndex2 then
			setActive = var_2

			var_2(arg_41_0:Find("selected"), true)
		else
			setActive = var_2

			var_2(arg_41_0:Find("selected"), false)
		end

		return
	end)

	setText = var_1_10001

	local var_40_0 = arg_40_0.selectNum

	setColorStr = var_3

	local var_40_1 = arg_40_0.hasSelectNum

	COLOR_GREEN = var_1_10005

	var_1_10001(var_40_0, var_3(var_40_1, var_1_10005) .. "/2")

	arg_40_0.canSureChar = arg_40_0.selectSDIndex1 and arg_40_0.selectSDIndex2 and true or false
	setGray = var_1

	var_1(arg_40_0.selectSureBtn, not arg_40_0.canSureChar, not arg_40_0.canSureChar)

	return
end

function var_0_1.firstShow(arg_42_0, arg_42_1)
	setActive = var_1_10002

	var_1_10002(arg_42_0.helpUI, true)

	pg = var_1_10002

	local var_42_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_42_0, arg_42_0.helpUI)

	onButton = var_2

	local var_42_1 = arg_42_0
	local var_42_2 = arg_42_0.helpUI

	local function var_42_3()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_43_0 = var_2_10000(var_2_10001)
		local var_43_1 = var_0.getData(var_43_0).id

		PlayerPrefs = var_43_0

		var_43_0.SetInt("volleyballgame_first_" .. var_43_1, 1)

		setActive = var_1

		var_1(arg_42_0.helpUI, false)

		pg = var_1

		local var_43_2 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_43_2, arg_42_0.helpUI, arg_42_0._tf)

		if arg_42_1 then
			arg_42_1()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_42_1, var_42_2, var_42_3, var_1_10006)

	return
end

function var_0_1.startCountTimer(arg_44_0)
	arg_44_0:setBtnAvailable(false)

	setActive = var_1

	var_1(arg_44_0.countTimeUI, true)

	pg = var_1

	local var_44_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_44_0, arg_44_0.countTimeUI)

	arg_44_0.countTime = 3
	pg = var_1

	local var_44_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_44_1, var_0_29)

	setImageSprite = var_1

	local var_44_2 = arg_44_0.countTimeImage
	local var_44_3 = arg_44_0.countTimeNumImage
	local var_44_4 = var_3.Find(var_44_3, arg_44_0.countTime)
	local var_44_5 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	var_1(var_44_2, var_44_5(var_44_4, var_5(var_1_10006)).sprite)

	local function var_44_6()
		arg_44_0.countTime = arg_44_0.countTime - 1

		if arg_44_0.countTime <= 0 then
			setActive = var_0

			var_0(arg_44_0.countTimeUI, false)

			pg = var_0

			local var_45_0 = var_0.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_45_0, arg_44_0.countTimeUI, arg_44_0._tf)

			local var_45_1 = arg_44_0

			var_0.resetGameAni(var_45_1)

			local var_45_2 = arg_44_0

			var_0.startGame(var_45_2)
		else
			setImageSprite = var_0

			local var_45_3 = arg_44_0.countTimeImage
			local var_45_4 = arg_44_0.countTimeNumImage
			local var_45_5 = var_2.Find(var_45_4, arg_44_0.countTime)
			local var_45_6 = var_2.GetComponent

			typeof = var_4
			Image = var_2_10005

			var_0(var_45_3, var_45_6(var_45_5, var_4(var_2_10005)).sprite)
		end

		return
	end

	if arg_44_0.countTimer then
		local var_44_7 = arg_44_0.countTimer

		var_2.Reset(var_44_7, var_44_6, 1, -1)
	else
		Timer = var_2
		arg_44_0.countTimer = var_2.New(var_44_6, 1, -1)
	end

	local var_44_8 = arg_44_0.countTimer

	var_2.Start(var_44_8)

	return
end

function var_0_1.setBtnAvailable(arg_46_0, arg_46_1)
	arg_46_0.btnAvailable = arg_46_1
	setGray = var_1_10002

	var_1_10002(arg_46_0.backBtn, not arg_46_1, not arg_46_1)

	setGray = var_1_10002

	var_1_10002(arg_46_0.pauseBtn, not arg_46_1, not arg_46_1)

	return
end

function var_0_1.startGame(arg_47_0)
	arg_47_0.isInGame = true

	arg_47_0:setBtnAvailable(true)

	setActive = var_1

	var_1(arg_47_0.bgEffect, false)

	setActive = var_1

	var_1(arg_47_0.bgEffect, true)

	if arg_47_0.beginTeam == var_0_4 then
		arg_47_0:ourServe(function()
			local var_48_0 = arg_47_0

			var_0.enemyUp2Up(var_48_0, function()
				local var_49_0 = arg_47_0

				var_0.enemyUp2Hit(var_49_0, function()
					local var_50_0 = arg_47_0

					var_0.enemyThrow(var_50_0, function()
						local var_51_0 = arg_47_0

						var_0.enterLoop(var_51_0)

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
			local var_52_0 = arg_47_0

			var_0.enterLoop(var_52_0)

			return
		end)
	end

	return
end

function var_0_1.enterLoop(arg_53_0)
	arg_53_0:ourUp2Up(function()
		local var_54_0 = arg_53_0

		var_0.ourUp2Hit(var_54_0, function()
			local var_55_0 = arg_53_0

			var_0.ourThrow(var_55_0, function()
				local var_56_0 = arg_53_0

				var_0.enemyUp2Up(var_56_0, function()
					local var_57_0 = arg_53_0

					var_0.enemyUp2Hit(var_57_0, function()
						local var_58_0 = arg_53_0

						var_0.enemyThrow(var_58_0, function()
							local var_59_0 = arg_53_0

							var_0.enterLoop(var_59_0)

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

function var_0_1.ourServe(arg_60_0, arg_60_1)
	arg_60_0.ballPosTag = "our_serve"
	setActive = var_2

	var_2(arg_60_0.ball, true)
	arg_60_0:charServeBall()

	local var_60_0 = arg_60_0
	local var_60_1 = arg_60_0.managedTween

	LeanTween = var_4

	var_60_1(var_60_0, var_4.delayedCall, function()
		local var_61_0 = "enemy"

		math = var_2_10001

		local var_61_1 = var_61_0 .. var_2_10001.random(2)

		arg_60_0.ballPosTag = var_61_1

		local var_61_2 = arg_60_0.anchoredPos
		local var_61_3 = arg_60_0.ballPosTag
		local var_61_4 = arg_60_0

		var_61_2[var_61_3] = var_3.getRandomPos(var_61_4, arg_60_0.ballPosTag)

		local var_61_5 = arg_60_0

		var_1.ballServe(var_61_5, arg_60_0.ball, var_0_16, arg_60_0.anchoredPos[var_61_1], function()
			if arg_60_1 then
				arg_60_1()
			end

			return
		end)

		local var_61_6 = arg_60_0
		local var_61_7 = var_1.managedTween

		LeanTween = var_3

		var_61_7(var_61_6, var_3.delayedCall, function()
			local var_63_0 = arg_60_0

			var_0.charUpBall(var_63_0)

			return
		end, var_0_16 - var_0_22, nil)

		return
	end, var_0_21 + 0.5, nil)

	return
end

function var_0_1.enemyServe(arg_64_0, arg_64_1)
	arg_64_0.ballPosTag = "enemy_serve"
	setActive = var_2

	var_2(arg_64_0.ball, true)
	arg_64_0:charServeBall()

	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.managedTween

	LeanTween = var_4

	var_64_1(var_64_0, var_4.delayedCall, function()
		local var_65_0 = "our"

		math = var_2_10001

		local var_65_1 = var_65_0 .. var_2_10001.random(2)

		arg_64_0.ballPosTag = var_65_1

		local var_65_2 = arg_64_0.anchoredPos
		local var_65_3 = arg_64_0.ballPosTag
		local var_65_4 = arg_64_0

		var_65_2[var_65_3] = var_3.getRandomPos(var_65_4, arg_64_0.ballPosTag)

		local var_65_5 = arg_64_0

		var_1.ballServe(var_65_5, arg_64_0.ball, var_0_16, arg_64_0.anchoredPos[var_65_1], function()
			if arg_64_1 then
				arg_64_1()
			end

			return
		end)

		local var_65_6 = arg_64_0
		local var_65_7 = var_1.managedTween

		LeanTween = var_3

		var_65_7(var_65_6, var_3.delayedCall, function()
			local var_67_0 = arg_64_0

			var_0.charUpBall(var_67_0)

			return
		end, var_0_16 - var_0_22, nil)

		return
	end, var_0_21 + 0.5, nil)

	return
end

function var_0_1.ourUp2Up(arg_68_0, arg_68_1)
	if arg_68_0.qteStatus == var_0_12 and arg_68_0.qteType == var_0_14 then
		arg_68_0:ourFly()

		return
	end

	arg_68_0.ballPosTag = arg_68_0.ballPosTag == "our1" and "our2" or "our1"

	arg_68_0:ballUp2Up(arg_68_0.ball, var_0_17, arg_68_0.anchoredPos[arg_68_0.ballPosTag], function()
		if arg_68_1 then
			arg_68_1()
		end

		return
	end)

	local var_68_0 = arg_68_0
	local var_68_1 = arg_68_0.managedTween

	LeanTween = var_5

	var_68_1(var_68_0, var_5.delayedCall, function()
		local var_70_0 = arg_68_0

		var_0.charUpBall(var_70_0)

		return
	end, 0.3, nil)

	return
end

function var_0_1.ourUp2Hit(arg_71_0, arg_71_1)
	local var_71_0 = {}

	arg_71_0.ballPosTag = arg_71_0.ballPosTag == "our1" and "our2" or "our1"
	arg_71_0.anchoredPos[arg_71_0.ballPosTag] = arg_71_0:getRandomPos(arg_71_0.ballPosTag)
	arg_71_0.qteType = var_0_15

	arg_71_0:charHitBall()

	local var_71_1 = false

	local function var_71_2(arg_72_0)
		if var_71_1 then
			arg_72_0()
		else
			var_71_1 = true
		end

		return
	end

	table = var_6

	var_6.insert(var_71_0, function(arg_73_0)
		local function var_73_0()
			if arg_71_0.isCutin then
				local var_74_0 = arg_71_0

				var_0.showcutin(var_74_0, function()
					arg_71_0.isCutin = false

					arg_73_0()

					return
				end)
			else
				arg_73_0()
			end

			return
		end

		local var_73_1 = arg_71_0
		local var_73_2 = var_2.managedTween

		LeanTween = var_2_10004

		var_73_2(var_73_1, var_2_10004.delayedCall, function()
			var_71_2(var_73_0)

			return
		end, var_0_17 - 0.2, nil)

		local var_73_3 = arg_71_0
		local var_73_4 = var_2.managedTween

		LeanTween = var_4

		var_73_4(var_73_3, var_4.delayedCall, function()
			local var_77_0 = arg_71_0

			var_0.startQTE(var_77_0, var_0_33, 200, arg_71_0.anchoredPos[arg_71_0.ballPosTag], function()
				var_71_2(var_73_0)

				return
			end)

			return
		end, var_0_17 - var_0_33 - 0.2, nil)

		return
	end)

	table = var_6

	var_6.insert(var_71_0, function(arg_79_0)
		local var_79_0 = arg_71_0

		var_1.ballUp2Hit(var_79_0, arg_71_0.ball, var_0_17, arg_71_0.anchoredPos[arg_71_0.ballPosTag], arg_79_0)

		return
	end)

	parallelAsync = var_6

	var_6(var_71_0, function()
		if arg_71_1 then
			arg_71_1()
		end

		return
	end)

	return
end

function var_0_1.ourThrow(arg_81_0, arg_81_1)
	local var_81_0 = "enemy"

	math = var_1_10003
	arg_81_0.ballPosTag = var_81_0 .. var_1_10003.random(2)
	arg_81_0.anchoredPos[arg_81_0.ballPosTag] = arg_81_0:getRandomPos(arg_81_0.ballPosTag)

	arg_81_0:ballHit(arg_81_0.ball, var_0_18, arg_81_0.anchoredPos[var_2], function()
		if arg_81_1 then
			arg_81_1()
		end

		return
	end)
	arg_81_0:charUpBall()

	return
end

function var_0_1.enemyUp2Up(arg_83_0, arg_83_1)
	if arg_83_0.qteStatus == var_0_11 and arg_83_0.qteType == var_0_15 then
		arg_83_0:enemyFly()

		return
	end

	arg_83_0.ballPosTag = arg_83_0.ballPosTag == "enemy1" and "enemy2" or "enemy1"

	arg_83_0:ballUp2Up(arg_83_0.ball, var_0_17, arg_83_0.anchoredPos[arg_83_0.ballPosTag], function()
		if arg_83_1 then
			arg_83_1()
		end

		return
	end)

	local var_83_0 = arg_83_0
	local var_83_1 = arg_83_0.managedTween

	LeanTween = var_5

	var_83_1(var_83_0, var_5.delayedCall, function()
		local var_85_0 = arg_83_0

		var_0.charUpBall(var_85_0)

		return
	end, 0.3, nil)

	return
end

function var_0_1.enemyUp2Hit(arg_86_0, arg_86_1)
	arg_86_0.ballPosTag = arg_86_0.ballPosTag == "enemy1" and "enemy2" or "enemy1"
	arg_86_0.anchoredPos[arg_86_0.ballPosTag] = arg_86_0:getRandomPos(arg_86_0.ballPosTag)

	local var_86_0 = "our"

	math = var_4
	arg_86_0.randomQtePos = var_86_0 .. var_4.random(2)
	arg_86_0.anchoredPos[arg_86_0.randomQtePos] = arg_86_0:getRandomPos(arg_86_0.randomQtePos)
	arg_86_0.qteType = var_0_14

	local var_86_1 = arg_86_0
	local var_86_2 = arg_86_0.managedTween

	LeanTween = var_5

	var_86_2(var_86_1, var_5.delayedCall, function()
		local var_87_0 = arg_86_0

		var_0.startQTE(var_87_0, var_0_33, 0, arg_86_0.anchoredPos[arg_86_0.randomQtePos])

		return
	end, var_0_17 - var_0_33, nil)
	arg_86_0:ballUp2Hit(arg_86_0.ball, var_0_17, arg_86_0.anchoredPos[arg_86_0.ballPosTag], function()
		if arg_86_1 then
			arg_86_1()
		end

		return
	end)
	arg_86_0:charHitBall()

	return
end

function var_0_1.enemyThrow(arg_89_0, arg_89_1)
	arg_89_0.ballPosTag = arg_89_0.randomQtePos

	arg_89_0:ballHit(arg_89_0.ball, var_0_18, arg_89_0.anchoredPos[arg_89_0.ballPosTag], function()
		if arg_89_1 then
			arg_89_1()
		end

		return
	end)
	arg_89_0:charUpBall()

	return
end

function var_0_1.ourFly(arg_91_0)
	arg_91_0.ballPosTag = "out"
	math = var_1

	local var_91_0 = var_1.random(1000, 1100)

	math = var_2

	local var_91_1 = var_2.random(0, 200)

	arg_91_0:hitFly(arg_91_0.ball, var_0_19, {
		x = -var_91_0,
		y = var_91_1 - 100
	}, function()
		local var_92_0 = arg_91_0

		var_92_0.qteStatus = var_0_10
		setGray = var_92_0

		var_92_0(arg_91_0.qteBtn, true, true)

		arg_91_0.enemyScoreNum = arg_91_0.enemyScoreNum + 1

		local var_92_1 = arg_91_0

		var_0.updateScore(var_92_1)

		return
	end)

	return
end

function var_0_1.enemyFly(arg_93_0)
	arg_93_0.ballPosTag = "out"
	math = var_1

	local var_93_0 = var_1.random(1000, 1100)

	math = var_2

	local var_93_1 = var_2.random(0, 200)

	arg_93_0:hitFly(arg_93_0.ball, var_0_19, {
		x = var_93_0,
		y = var_93_1 - 100
	}, function()
		local var_94_0 = arg_93_0

		var_94_0.qteStatus = var_0_10
		setGray = var_94_0

		var_94_0(arg_93_0.qteBtn, true, true)

		arg_93_0.ourScoreNum = arg_93_0.ourScoreNum + 1

		local var_94_1 = arg_93_0

		var_0.updateScore(var_94_1)

		return
	end)

	return
end

function var_0_1.qteSuccess(arg_95_0)
	arg_95_0.qteStatus = var_0_11
	arg_95_0.beginTeam = var_0_4

	arg_95_0:changeQTEBtnStatus(var_0_6)

	return
end

function var_0_1.qteFail(arg_96_0)
	arg_96_0.qteStatus = var_0_12
	arg_96_0.beginTeam = var_0_5

	arg_96_0:changeQTEBtnStatus(var_0_6)

	return
end

function var_0_1.GetBeziersPoints(arg_97_0, arg_97_1, arg_97_2, arg_97_3, arg_97_4)
	local function var_97_0(arg_98_0)
		local var_98_0 = arg_97_1
		local var_98_1 = var_1.Clone(var_98_0)
		local var_98_2 = var_1.Mul(var_98_1, (1 - arg_98_0) * (1 - arg_98_0))
		local var_98_3 = arg_97_2
		local var_98_4 = var_2.Clone(var_98_3)
		local var_98_5 = var_2.Mul(var_98_4, 2 * arg_98_0 * (1 - arg_98_0))
		local var_98_6 = arg_97_3
		local var_98_7 = var_3.Clone(var_98_6)
		local var_98_8 = var_3.Mul(var_98_7, arg_98_0 * arg_98_0)
		local var_98_9 = var_98_2:Clone()
		local var_98_10 = var_4.Add(var_98_9, var_98_5)

		return var_4.Add(var_98_10, var_98_8)
	end

	local var_97_1 = {}

	table = var_1_10007

	local var_97_2 = var_1_10007.insert
	local var_97_3 = var_97_1

	Vector3 = var_1_10009

	var_97_2(var_97_3, var_1_10009(0, 0, 0))

	table = var_97_2

	var_97_2.insert(var_97_1, var_97_0(0))

	for iter_97_0 = 1, arg_97_4 do
		local var_97_4 = iter_97_0 / arg_97_4

		table = var_12

		var_12.insert(var_97_1, var_97_0(var_97_4))
	end

	table = var_7

	local var_97_5 = var_7.insert
	local var_97_6 = var_97_1

	Vector3 = var_9

	var_97_5(var_97_6, var_9(0, 0, 0))

	return var_97_1
end

function var_0_1.ballParabolaMove(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5, arg_99_6)
	Vector2 = var_1_10007

	local var_99_0 = var_1_10007(arg_99_1.anchoredPosition.x, arg_99_1.anchoredPosition.y - arg_99_5)

	Vector2 = var_8

	local var_99_1 = var_8(arg_99_3.x, arg_99_3.y).x - var_99_0.x
	local var_99_2 = var_8.y - var_99_0.y

	math = var_11

	local var_99_3 = var_11.abs(arg_99_6 - arg_99_5)

	DOAParabolaCalc = var_12

	local var_99_4 = arg_99_2

	math = var_1_10014

	local var_99_5 = var_12(var_99_4, var_1_10014.abs(var_0_34), var_99_3)
	local var_99_6
	local var_99_7

	if arg_99_5 < arg_99_6 then
		var_99_6 = var_99_5 + var_99_3

		local var_99_8 = var_99_5
	else
		var_99_6 = var_99_5

		local var_99_9 = var_99_5 + var_99_3
	end

	math = var_15

	local var_99_10 = var_15.sqrt

	math = var_1_10016

	local var_99_11 = var_99_10(2 * var_1_10016.abs(var_0_34) * var_99_6)
	local var_99_12 = arg_99_0
	local var_99_13 = arg_99_0.managedTween

	LeanTween = var_1_10018

	local var_99_14 = var_1_10018.value

	local function var_99_15()
		if arg_99_4 then
			arg_99_4()
		end

		return
	end

	go = var_1_10020

	local var_99_16 = var_99_13(var_99_12, var_99_14, var_99_15, var_1_10020(arg_99_1), 0, arg_99_2, arg_99_2)
	local var_99_17 = var_16.setOnUpdate

	System = var_99_14

	var_99_17(var_99_16, var_99_14.Action_float(function(arg_101_0)
		local var_101_0 = var_99_1 * arg_101_0 / arg_99_2
		local var_101_1 = var_99_2 * arg_101_0 / arg_99_2
		local var_101_2 = var_99_11 * arg_101_0 + 0.5 * var_0_34 * arg_101_0 * arg_101_0
		local var_101_3 = arg_99_1

		Vector2 = var_2_10005
		var_101_3.anchoredPosition = var_2_10005(var_99_0.x + var_101_0, var_99_0.y + var_101_1 + arg_99_5 + var_101_2)

		return
	end))

	return
end

function var_0_1.ballServe(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4)
	arg_102_0:ballParabolaMove(arg_102_1, arg_102_2, arg_102_3, function()
		if arg_102_4 then
			arg_102_4()
		end

		return
	end, var_0_25, var_0_26)

	local var_102_0 = arg_102_0
	local var_102_1 = arg_102_0.managedTween

	LeanTween = var_7

	local var_102_2 = var_7.move
	local var_102_3
	local var_102_4 = arg_102_0.ballShadow

	Vector3 = var_10

	local var_102_5 = var_102_1(var_102_0, var_102_2, var_102_3, var_102_4, var_10(arg_102_3.x, arg_102_3.y + var_0_24), arg_102_2)
	local var_102_6 = var_5.setEase

	LeanTweenType = var_102_2

	var_102_6(var_102_5, var_102_2.linear)

	return
end

function var_0_1.ballUp2Up(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	arg_104_0:ballParabolaMove(arg_104_1, arg_104_2, arg_104_3, function()
		if arg_104_4 then
			arg_104_4()
		end

		return
	end, var_0_26, var_0_26)

	local var_104_0 = arg_104_0
	local var_104_1 = arg_104_0.managedTween

	LeanTween = var_7

	local var_104_2 = var_7.move
	local var_104_3
	local var_104_4 = arg_104_0.ballShadow

	Vector3 = var_10

	local var_104_5 = var_104_1(var_104_0, var_104_2, var_104_3, var_104_4, var_10(arg_104_3.x, arg_104_3.y + var_0_24), arg_104_2)
	local var_104_6 = var_5.setEase

	LeanTweenType = var_104_2

	var_104_6(var_104_5, var_104_2.linear)

	return
end

function var_0_1.ballUp2Hit(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	local var_106_0 = {
		x = arg_106_3.x,
		y = arg_106_3.y
	}

	arg_106_0:ballParabolaMove(arg_106_1, arg_106_2, var_106_0, function()
		if arg_106_4 then
			arg_106_4()
		end

		return
	end, var_0_26, var_0_27)

	local var_106_1 = arg_106_0
	local var_106_2 = arg_106_0.managedTween

	LeanTween = var_8

	local var_106_3 = var_8.move
	local var_106_4
	local var_106_5 = arg_106_0.ballShadow

	Vector3 = var_11

	local var_106_6 = var_106_2(var_106_1, var_106_3, var_106_4, var_106_5, var_11(arg_106_3.x, arg_106_3.y + var_0_24), arg_106_2)
	local var_106_7 = var_6.setEase

	LeanTweenType = var_106_3

	var_106_7(var_106_6, var_106_3.linear)

	return
end

function var_0_1.ballHit(arg_108_0, arg_108_1, arg_108_2, arg_108_3, arg_108_4)
	Vector2 = var_1_10005
	arg_108_3 = var_1_10005(arg_108_3.x, arg_108_3.y + var_0_26)

	local var_108_0 = arg_108_0
	local var_108_1 = arg_108_0.managedTween

	LeanTween = var_7

	local var_108_2 = var_108_1(var_108_0, var_7.moveX, function()
		if arg_108_4 then
			arg_108_4()
		end

		return
	end, arg_108_1, arg_108_3.x, arg_108_2)
	local var_108_3 = var_5.setEase

	LeanTweenType = var_7

	var_108_3(var_108_2, var_7.linear)

	local var_108_4 = arg_108_0
	local var_108_5 = arg_108_0.managedTween

	LeanTween = var_7

	local var_108_6 = var_108_5(var_108_4, var_7.moveY, nil, arg_108_1, arg_108_3.y, arg_108_2)
	local var_108_7 = var_5.setEase

	LeanTweenType = var_7

	var_108_7(var_108_6, var_7.linear)

	local var_108_8 = arg_108_0
	local var_108_9 = arg_108_0.managedTween

	LeanTween = var_7

	local var_108_10 = var_7.move
	local var_108_11
	local var_108_12 = arg_108_0.ballShadow

	Vector3 = var_10

	local var_108_13 = var_108_9(var_108_8, var_108_10, var_108_11, var_108_12, var_10(arg_108_3.x, arg_108_3.y + var_0_24), arg_108_2)
	local var_108_14 = var_5.setEase

	LeanTweenType = var_108_10

	var_108_14(var_108_13, var_108_10.linear)

	return
end

function var_0_1.charMove(arg_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	local var_110_0 = arg_110_0
	local var_110_1 = arg_110_0.managedTween

	LeanTween = var_1_10007

	local var_110_2 = var_110_1(var_110_0, var_1_10007.moveX, nil, arg_110_1, arg_110_3.x, arg_110_2)
	local var_110_3 = var_5.setEase

	LeanTweenType = var_7

	var_110_3(var_110_2, var_7.easeOutQuad)

	local var_110_4 = arg_110_0
	local var_110_5 = arg_110_0.managedTween

	LeanTween = var_7

	local var_110_6 = var_110_5(var_110_4, var_7.moveY, function()
		if arg_110_4 then
			arg_110_4()
		end

		return
	end, arg_110_1, arg_110_3.y, arg_110_2)
	local var_110_7 = var_5.setEase

	LeanTweenType = var_7

	var_110_7(var_110_6, var_7.linear)

	return
end

function var_0_1.hitFly(arg_112_0, arg_112_1, arg_112_2, arg_112_3, arg_112_4)
	arg_112_0:ballParabolaMove(arg_112_1, arg_112_2, arg_112_3, function()
		if arg_112_4 then
			arg_112_4()
		end

		return
	end, var_0_28, var_0_27)

	local var_112_0 = arg_112_0
	local var_112_1 = arg_112_0.managedTween

	LeanTween = var_7

	local var_112_2 = var_7.move
	local var_112_3
	local var_112_4 = arg_112_0.ballShadow

	Vector3 = var_10

	local var_112_5 = var_112_1(var_112_0, var_112_2, var_112_3, var_112_4, var_10(arg_112_3.x, arg_112_3.y + var_0_24), arg_112_2)
	local var_112_6 = var_5.setEase

	LeanTweenType = var_112_2

	var_112_6(var_112_5, var_112_2.linear)

	return
end

function var_0_1.startQTE(arg_114_0, arg_114_1, arg_114_2, arg_114_3, arg_114_4)
	arg_114_0:changeQTEBtnStatus(var_0_7)

	local var_114_0 = arg_114_0.qte

	var_114_0.anchoredPosition = {
		x = arg_114_3.x,
		y = arg_114_3.y + arg_114_2
	}
	setActive = var_114_0

	var_114_0(arg_114_0.qte, true)

	setActive = var_114_0

	var_114_0(arg_114_0.qteCircles, true)

	setActive = var_114_0

	var_114_0(arg_114_0.result, false)

	setLocalScale = var_114_0

	local var_114_1 = arg_114_0.qteCircle

	Vector3 = var_7

	var_114_0(var_114_1, var_7(1, 1, 1))

	local var_114_2 = arg_114_0.result
	local var_114_3 = var_5.GetComponent

	typeof = var_7
	DftAniEvent = var_8

	local var_114_4 = var_114_3(var_114_2, var_7(var_8))

	var_5.SetEndEvent(var_114_4, function(arg_115_0)
		setActive = var_2_10001

		var_2_10001(arg_114_0.result, false)

		return
	end)

	arg_114_0.qteCallback = arg_114_4
	LeanTween = var_6

	local var_114_5 = var_6.scale
	local var_114_6 = arg_114_0.qteCircle

	Vector3 = var_8

	local var_114_7 = var_114_5(var_114_6, var_8(0, 0, 1), arg_114_1)
	local var_114_8 = var_6.setOnComplete

	System = var_8
	arg_114_0.qteTween = var_114_8(var_114_7, var_8.Action(function()
		local var_116_0 = arg_114_0

		var_0.changeQTEBtnStatus(var_116_0, var_0_6)

		setImageSprite = var_0

		local var_116_1 = arg_114_0.result
		local var_116_2 = arg_114_0.resultTxt
		local var_116_3 = var_2.Find(var_116_2, "miss")
		local var_116_4 = var_2.GetComponent

		typeof = var_4
		Image = var_2_10005

		var_0(var_116_1, var_116_4(var_116_3, var_4(var_2_10005)).sprite, true)

		setActive = var_0

		var_0(arg_114_0.result, true)

		local var_116_5 = arg_114_0

		var_0.qteFail(var_116_5)

		local var_116_6 = arg_114_0

		var_116_6.isCutin = false
		setActive = var_116_6

		var_116_6(arg_114_0.qteCircles, false)

		existCall = var_116_6

		var_116_6(arg_114_0.qteCallback)

		arg_114_0.qteCallback = nil

		return
	end)).uniqueId

	return
end

function var_0_1.qteResult(arg_117_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_117_0.qteTween) then
		LeanTween = var_1

		var_1.cancel(arg_117_0.qteTween, false)
	end

	math = var_1

	local var_117_0 = var_1.abs(arg_117_0.qteCircle.localScale.x)

	setActive = var_2

	var_2(arg_117_0.result, true)

	arg_117_0.isCutin = false

	if var_117_0 <= 0 or var_0_8 < var_117_0 then
		setImageSprite = var_2

		local var_117_1 = arg_117_0.result
		local var_117_2 = arg_117_0.resultTxt
		local var_117_3 = var_4.Find(var_117_2, "miss")
		local var_117_4 = var_4.GetComponent

		typeof = var_6
		Image = var_1_10007

		var_2(var_117_1, var_117_4(var_117_3, var_6(var_1_10007)).sprite, true)
		arg_117_0:qteFail()
	elseif var_0_9 < var_117_0 then
		setImageSprite = var_2

		local var_117_5 = arg_117_0.result
		local var_117_6 = arg_117_0.resultTxt
		local var_117_7 = var_4.Find(var_117_6, "good")
		local var_117_8 = var_4.GetComponent

		typeof = var_6
		Image = var_1_10007

		var_2(var_117_5, var_117_8(var_117_7, var_6(var_1_10007)).sprite, true)
		arg_117_0:qteSuccess()
	else
		setImageSprite = var_2

		local var_117_9 = arg_117_0.result
		local var_117_10 = arg_117_0.resultTxt
		local var_117_11 = var_4.Find(var_117_10, "perfect")
		local var_117_12 = var_4.GetComponent

		typeof = var_6
		Image = var_1_10007

		var_2(var_117_9, var_117_12(var_117_11, var_6(var_1_10007)).sprite, true)
		arg_117_0:qteSuccess()

		if arg_117_0.qteType == var_0_15 then
			arg_117_0.isCutin = true
		else
			arg_117_0.isCutin = false
		end
	end

	setActive = var_2

	var_2(arg_117_0.qteCircles, false)

	existCall = var_2

	var_2(arg_117_0.qteCallback)

	arg_117_0.qteCallback = nil

	return
end

local function var_0_35(arg_118_0, arg_118_1, arg_118_2, arg_118_3, arg_118_4)
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
		local var_124_0 = var_118_0.spineAnim

		var_3.SetActionCallBack(var_124_0, function(arg_125_0)
			if arg_125_0 == "action" then
				if arg_124_1 == "chuanqiu" or arg_124_1 == "dianqiu" then
					local var_125_0 = arg_118_0
					local var_125_1 = var_1.playEffect
					local var_125_2 = arg_118_0.upEffect

					Vector2 = var_3_10004

					var_125_1(var_125_0, var_125_2, var_3_10004(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_26))

					pg = var_125_1

					local var_125_3 = var_125_1.CriMgr.GetInstance()

					var_1.PlaySoundEffect_V3(var_125_3, var_0_31)
				elseif arg_124_1 == "kouqiu" then
					local var_125_4 = arg_118_0
					local var_125_5 = var_1.playEffect
					local var_125_6 = arg_118_0.hitEffect

					Vector2 = var_3_10004

					var_125_5(var_125_4, var_125_6, var_3_10004(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_26 + var_0_27))

					pg = var_125_5

					local var_125_7 = var_125_5.CriMgr.GetInstance()

					var_1.PlaySoundEffect_V3(var_125_7, var_0_32)
				elseif arg_124_1 == "faqiu" then
					pg = var_1

					local var_125_8 = var_1.CriMgr.GetInstance()

					var_1.PlaySoundEffect_V3(var_125_8, var_0_31)

					local var_125_9 = arg_118_0
					local var_125_10 = var_1.playEffect
					local var_125_11 = arg_118_0.upEffect

					Vector2 = var_3_10004

					var_125_10(var_125_9, var_125_11, var_3_10004(var_118_0._tf.anchoredPosition.x, var_118_0._tf.anchoredPosition.y + var_0_25))
				end
			end

			if arg_125_0 == "finish" then
				local var_125_12 = var_118_0.spineAnim

				var_1.SetActionCallBack(var_125_12, nil)

				if arg_124_2 then
					arg_124_2()
				else
					local var_125_13 = var_118_0.spineAnim

					var_1.SetAction(var_125_13, "normal2", 0)
				end
			end

			return
		end)

		local var_124_1 = var_118_0.spineAnim

		var_3.SetAction(var_124_1, arg_124_1, 0)

		return
	end

	function var_118_0.move(arg_126_0, arg_126_1, arg_126_2, arg_126_3, arg_126_4)
		local function var_126_0()
			local var_127_0 = var_118_0.spineAnim

			var_0.SetAction(var_127_0, "run", 0)

			var_118_0.posTag = arg_126_2

			local var_127_1 = arg_118_0

			var_0.charMove(var_127_1, var_118_0._tf, arg_126_1, arg_118_0.anchoredPos[arg_126_2], function()
				if arg_126_4 then
					arg_126_4()
				else
					local var_128_0 = var_118_0.spineAnim

					var_0.SetAction(var_128_0, "normal2", 0)
				end

				return
			end)

			return
		end

		if arg_126_3 then
			local var_126_1 = var_118_0

			var_6.setActionOnce(var_126_1, arg_126_3, function()
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

function var_0_1.getRandomPos(arg_130_0, arg_130_1)
	math = var_1_10002

	local var_130_0 = var_1_10002.random(0, 300)

	math = var_3

	local var_130_1 = var_3.random(0, 50)
	local var_130_2 = arg_130_0.orgPos[arg_130_1]

	string = var_1_10006

	if var_1_10006.find(arg_130_1, "our") then
		var_130_2 = {
			x = var_4.x + var_130_0 - 50,
			y = var_4.y + var_130_1 - 25
		}
	else
		var_130_2 = {
			x = var_4.x + var_130_0 - 250,
			y = var_4.y + var_130_1 - 25
		}
	end

	return var_130_2
end

function var_0_1.loadSpineChars(arg_131_0)
	arg_131_0:clearSpineChars()

	math = var_1
	arg_131_0.beginTeam = var_1.random(2)

	if arg_131_0.beginTeam == var_0_4 then
		local var_131_0 = "our"

		math = var_2
		arg_131_0.serveChar = var_131_0 .. var_2.random(2)
	else
		local var_131_1 = "enemy"

		math = var_2
		arg_131_0.serveChar = var_131_1 .. var_2.random(2)
	end

	arg_131_0:setBallPos()

	pairs = var_1

	for iter_131_0, iter_131_1 in var_1(arg_131_0.charNames) do
		arg_131_0:loadOneSpineChar(iter_131_0, arg_131_0.serveChar)
	end

	return
end

function var_0_1.loadOneSpineChar(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0

	if not arg_132_0.charNames[arg_132_1] then
		var_132_0 = arg_132_0.charNames
		var_132_0[arg_132_1] = false

		return
	end

	pg = var_132_0

	local var_132_1 = var_132_0.UIMgr.GetInstance()

	var_3.LoadingOn(var_132_1)

	PoolMgr = var_3

	local var_132_2 = var_3.GetInstance()

	var_3.GetSpineChar(var_132_2, arg_132_0.charNames[arg_132_1], true, function(arg_133_0)
		pg = var_2_10001

		local var_133_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_133_0)

		local var_133_1 = ""

		string = var_133_0

		local var_133_2

		if var_133_0.find(arg_132_1, "our") then
			tf = var_133_2
			var_133_2 = var_133_2(arg_133_0)
			Vector3 = var_3
			var_133_2.localScale = var_3(0.6, 0.6, 1)
			tf = var_133_2
			var_133_2 = var_133_2(arg_133_0)
			Vector3 = var_3
			var_133_2.localPosition = var_3(-20, 0, 0)
			string = var_133_2

			if var_133_2.find(arg_132_1, "1") then
				var_133_1 = "our1"
			else
				var_133_1 = "our2"
			end
		else
			tf = var_133_2

			local var_133_3 = var_133_2(arg_133_0)

			Vector3 = var_3
			var_133_3.localScale = var_3(-0.6, 0.6, 1)
			tf = var_133_3

			local var_133_4 = var_133_3(arg_133_0)

			Vector3 = var_3
			var_133_4.localPosition = var_3(20, 0, 0)
			string = var_133_4
			var_133_1 = var_133_4.find(arg_132_1, "1") and "enemy1" or "enemy2"
		end

		arg_132_0.charModels[arg_132_1] = arg_133_0

		local var_133_5 = arg_133_0:GetComponent("SpineAnimUI")
		local var_133_6 = arg_133_0:GetComponent("SkeletonGraphic")

		var_133_5:SetAction("normal2", 0)

		var_133_6.timeScale = 1

		local var_133_7 = arg_132_0._tf
		local var_133_8 = var_4.Find(var_133_7, "game_ui/char/" .. arg_132_1)

		setParent = var_133_7

		var_133_7(arg_133_0, var_133_8)

		arg_132_0.charactor[arg_132_1] = var_0_35(arg_132_0, var_133_8, var_133_5, var_133_6, var_133_1)

		if arg_132_1 == arg_132_2 then
			if arg_132_0.beginTeam == var_0_4 then
				local var_133_9 = arg_132_0.charactor[arg_132_1]

				var_5.setPosTag(var_133_9, "our_serve")
			else
				local var_133_10 = arg_132_0.charactor[arg_132_1]

				var_5.setPosTag(var_133_10, "enemy_serve")
			end
		end

		return
	end)

	return
end

function var_0_1.clearSpineChars(arg_134_0)
	pairs = var_1_10001

	for iter_134_0, iter_134_1 in var_1_10001(arg_134_0.charModels) do
		if arg_134_0.charModels[iter_134_0] and arg_134_0.charNames[iter_134_0] then
			PoolMgr = var_6

			local var_134_0 = var_6.GetInstance()

			var_6.ReturnSpineChar(var_134_0, arg_134_0.charNames[iter_134_0], arg_134_0.charModels[iter_134_0])
		end
	end

	arg_134_0.charModels = {}

	return
end

function var_0_1.getCharWithTag(arg_135_0, arg_135_1)
	pairs = var_1_10002

	for iter_135_0, iter_135_1 in var_1_10002(arg_135_0.charactor) do
		if iter_135_1:getPosTag() == arg_135_1 then
			return iter_135_0, iter_135_1
		end
	end

	return nil
end

function var_0_1.getAnotherChar(arg_136_0, arg_136_1)
	local var_136_0 = ""

	string = var_1_10003

	if var_1_10003.find(arg_136_1, "our") then
		var_136_0 = arg_136_1 == "our1" and "our2" or "our1"
	else
		string = var_3

		if var_3.find(arg_136_1, "enemy") then
			var_136_0 = arg_136_1 == "enemy1" and "enemy2" or "enemy1"
		end
	end

	return var_136_0, arg_136_0.charactor[var_136_0]
end

function var_0_1.setBallPos(arg_137_0)
	setActive = var_1_10001

	var_1_10001(arg_137_0.ball, true)

	string = var_1_10001

	local var_137_0 = var_1_10001.find(arg_137_0.serveChar, "our") and "our_serve" or "enemy_serve"

	arg_137_0.ball.anchoredPosition = {
		x = arg_137_0.orgPos[var_137_0].x,
		y = arg_137_0.orgPos[var_137_0].y + 300
	}

	local var_137_1 = arg_137_0.ballShadow

	Vector3 = var_3
	var_137_1.anchoredPosition = var_3(arg_137_0.orgPos[var_137_0].x, arg_137_0.orgPos[var_137_0].y, 0)

	local var_137_2 = arg_137_0
	local var_137_3 = arg_137_0.managedTween

	LeanTween = var_4

	local var_137_4 = var_137_3(var_137_2, var_4.rotate, nil, arg_137_0.ball, 360, 0.5)

	var_2.setLoopClamp(var_137_4)

	return
end

function var_0_1.resetChar(arg_138_0)
	arg_138_0:resetPos()

	pairs = var_1

	for iter_138_0, iter_138_1 in var_1(arg_138_0.charactor) do
		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.isTweening
		go = var_1_10007

		if var_1_10006(var_1_10007(iter_138_1._tf)) then
			LeanTween = var_1_10006
			var_1_10006 = var_1_10006.cancel
			go = var_1_10007

			var_1_10006(var_1_10007(iter_138_1._tf))
		end
	end

	local var_138_0 = arg_138_0.charactor.our1

	var_1.setPosTag(var_138_0, "our1")

	local var_138_1 = arg_138_0.charactor.our2

	var_1.setPosTag(var_138_1, "our2")

	local var_138_2 = arg_138_0.charactor.enemy1

	var_1.setPosTag(var_138_2, "enemy1")

	local var_138_3 = arg_138_0.charactor.enemy2

	var_1.setPosTag(var_138_3, "enemy2")

	local var_138_5

	if arg_138_0.beginTeam == var_0_4 then
		local var_138_4 = "our"

		math = var_138_5
		arg_138_0.serveChar = var_138_4 .. var_138_5.random(2)
		var_138_5 = arg_138_0.charactor[arg_138_0.serveChar]

		var_1.setPosTag(var_138_5, "our_serve")
	else
		local var_138_6 = "enemy"

		math = var_138_5
		arg_138_0.serveChar = var_138_6 .. var_138_5.random(2)

		local var_138_7 = arg_138_0.charactor[arg_138_0.serveChar]

		var_1.setPosTag(var_138_7, "enemy_serve")
	end

	arg_138_0:setBallPos()

	return
end

function var_0_1.charServeBall(arg_139_0)
	local var_139_0 = arg_139_0
	local var_139_1 = arg_139_0.managedTween

	LeanTween = var_1_10003

	local var_139_2 = var_139_1(var_139_0, var_1_10003.rotate, nil, arg_139_0.ball, 360, 0.5)

	var_1.setLoopClamp(var_139_2)

	string = var_1

	local var_139_3 = var_1.find(arg_139_0.serveChar, "our") and "our_serve" or "enemy_serve"
	local var_139_4 = arg_139_0
	local var_139_5 = arg_139_0.managedTween

	LeanTween = var_4

	var_139_5(var_139_4, var_4.delayedCall, function()
		local var_140_0 = arg_139_0
		local var_140_1 = var_0.managedTween

		LeanTween = var_2_10002

		local var_140_2 = var_140_1(var_140_0, var_2_10002.moveY, nil, arg_139_0.ball, arg_139_0.orgPos[var_139_3].y + var_0_25, 0.5)
		local var_140_3 = var_0.setEase

		LeanTweenType = var_2

		var_140_3(var_140_2, var_2.linear)

		local var_140_4 = arg_139_0.charactor[arg_139_0.serveChar]

		var_0.setActionOnce(var_140_4, "faqiu", function()
			local var_141_0 = arg_139_0
			local var_141_1 = var_0.managedTween

			LeanTween = var_3_10002

			var_141_1(var_141_0, var_3_10002.delayedCall, function()
				local var_142_0 = arg_139_0.charactor[arg_139_0.serveChar]

				var_0.move(var_142_0, 1, arg_139_0.serveChar)

				return
			end, 0.2, nil)

			return
		end)

		return
	end, 0.5, nil)

	return
end

function var_0_1.charUpBall(arg_143_0, arg_143_1)
	local var_143_0, var_143_1 = arg_143_0:getCharWithTag(arg_143_0.ballPosTag)

	if not var_143_1 then
		return
	end

	arg_143_0.upChar = var_143_0
	arg_143_0.hitChar = arg_143_0:getAnotherChar(arg_143_0.upChar)

	var_143_1:move(0.45, arg_143_0.ballPosTag, nil, function()
		local var_144_0 = var_143_1

		var_0.setActionOnce(var_144_0, "chuanqiu")

		return
	end)

	return
end

function var_0_1.charHitBall(arg_145_0)
	local var_145_0 = arg_145_0.charactor[arg_145_0.hitChar]

	var_1.move(var_145_0, 0.5, arg_145_0.ballPosTag, nil, function()
		local var_146_0 = var_0

		var_0.setActionOnce(var_146_0, "kouqiu")

		return
	end)

	return
end

function var_0_1.showcutin(arg_147_0, arg_147_1)
	arg_147_0:setBtnAvailable(false)
	arg_147_0:pauseGame()

	setActive = var_2

	var_2(arg_147_0.cutin, true)

	local var_147_0 = ""

	pairs = var_3

	for iter_147_0, iter_147_1 in var_3(arg_147_0.charNames) do
		if iter_147_0 == arg_147_0.hitChar then
			var_147_0 = iter_147_1
		end
	end

	ShipWordHelper = var_3

	local var_147_1 = var_3.GetWordAndCV
	local var_147_2 = var_0_3
	local var_147_3 = arg_147_0
	local var_147_4, var_147_5, var_147_6 = var_147_1(var_147_2[arg_147_0.getCharIndex(var_147_3, var_147_0)], "skill")

	pg = var_147_3

	local var_147_7 = var_147_3.CriMgr.GetInstance()

	var_6.PlaySoundEffect_V3(var_147_7, var_147_5)

	setActive = var_6

	local var_147_8 = arg_147_0.gameUI

	var_6(var_7.Find(var_147_8, "line"), true)

	setActive = var_6

	local var_147_9 = arg_147_0.cutin

	var_6(var_7.Find(var_147_9, "shatanpaiqiu_cutin"), false)

	setActive = var_6

	local var_147_10 = arg_147_0.cutin

	var_6(var_7.Find(var_147_10, "shatanpaiqiu_cutin"), true)

	setImageSprite = var_6

	local var_147_11 = arg_147_0.cutinPaint
	local var_147_12 = arg_147_0.cutinPaints
	local var_147_13 = var_8.Find
	local var_147_14 = arg_147_0
	local var_147_15 = var_147_13(var_147_12, arg_147_0.getCharIndex(var_147_14, var_147_0))
	local var_147_16 = var_8.GetComponent

	typeof = var_10
	Image = var_147_14

	var_6(var_147_11, var_147_16(var_147_15, var_10(var_147_14)).sprite, true)

	LeanTween = var_6

	local var_147_17 = var_6.moveX(arg_147_0.cutin, 0, 0.3)
	local var_147_18 = var_6.setOnComplete

	System = var_8

	var_147_18(var_147_17, var_8.Action(function()
		LeanTween = var_2_10000

		local var_148_0 = var_2_10000.delayedCall
		local var_148_1 = 1

		System = var_2_10002

		var_148_0(var_148_1, var_2_10002.Action(function()
			setActive = var_3_10000

			local var_149_0 = arg_147_0.gameUI

			var_3_10000(var_1.Find(var_149_0, "line"), false)

			LeanTween = var_3_10000

			local var_149_1 = var_3_10000.moveX(arg_147_0.cutin, -567, 0.3)
			local var_149_2 = var_0.setOnComplete

			System = var_2

			var_149_2(var_149_1, var_2.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_147_0.cutin, false)

				local var_150_0 = arg_147_0

				var_0.setBtnAvailable(var_150_0, true)

				local var_150_1 = arg_147_0

				var_0.resumeGame(var_150_1)

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

function var_0_1.showScoreCutin(arg_151_0, arg_151_1)
	arg_151_0:setBtnAvailable(false)
	arg_151_0:pauseGame()

	setImageSprite = var_2

	local var_151_0 = arg_151_0.ourScoreCutin
	local var_151_1 = arg_151_0.scoreCutinNums
	local var_151_2 = var_4.Find(var_151_1, arg_151_0.ourScoreNum)
	local var_151_3 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	var_2(var_151_0, var_151_3(var_151_2, var_6(var_1_10007)).sprite, true)

	setImageSprite = var_2

	local var_151_4 = arg_151_0.enemyScoreCutin
	local var_151_5 = arg_151_0.scoreCutinNums
	local var_151_6 = var_4.Find(var_151_5, arg_151_0.enemyScoreNum)
	local var_151_7 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	var_2(var_151_4, var_151_7(var_151_6, var_6(var_1_10007)).sprite, true)

	setActive = var_2

	var_2(arg_151_0.scoreCutin, true)

	setLocalScale = var_2

	local var_151_8 = arg_151_0.scoreCutin

	Vector3 = var_4

	var_2(var_151_8, var_4(1, 0, 1))

	LeanTween = var_2

	local var_151_9 = var_2.scale
	local var_151_10 = arg_151_0.scoreCutin

	Vector3 = var_4

	local var_151_11 = var_151_9(var_151_10, var_4(1, 1, 1), 0.2)
	local var_151_12 = var_2.setOnComplete

	System = var_4

	var_151_12(var_151_11, var_4.Action(function()
		local var_152_0 = arg_151_0

		var_0.resetChar(var_152_0)

		LeanTween = var_0

		local var_152_1 = var_0.delayedCall
		local var_152_2 = 0.6

		System = var_2_10002

		var_152_1(var_152_2, var_2_10002.Action(function()
			LeanTween = var_3_10000

			local var_153_0 = var_3_10000.scale
			local var_153_1 = arg_151_0.scoreCutin

			Vector3 = var_3_10002

			local var_153_2 = var_153_0(var_153_1, var_3_10002(1, 0, 1), 0.2)
			local var_153_3 = var_0.setOnComplete

			System = var_2

			var_153_3(var_153_2, var_2.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_151_0.scoreCutin, false)

				local var_154_0 = arg_151_0

				var_0.setBtnAvailable(var_154_0, true)

				local var_154_1 = arg_151_0

				var_0.resumeGame(var_154_1)

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

function var_0_1.updateScore(arg_155_0)
	setText = var_1_10001

	var_1_10001(arg_155_0.ourScore, arg_155_0.ourScoreNum)

	setText = var_1_10001

	var_1_10001(arg_155_0.enemyScore, arg_155_0.enemyScoreNum)

	setActive = var_1_10001

	var_1_10001(arg_155_0.qte, false)

	if arg_155_0.ourScoreNum >= arg_155_0.endScore or arg_155_0.enemyScoreNum >= arg_155_0.endScore then
		arg_155_0:endGame()
	else
		arg_155_0:showScoreCutin(function()
			local var_156_0 = arg_155_0

			var_0.startGame(var_156_0)

			return
		end)
	end

	return
end

function var_0_1.endGame(arg_157_0)
	setActive = var_1_10001

	var_1_10001(arg_157_0.winTag, arg_157_0.ourScoreNum ~= arg_157_0.enemyScoreNum)

	setActive = var_1_10001

	var_1_10001(arg_157_0.loseTag, arg_157_0.ourScoreNum ~= arg_157_0.enemyScoreNum)
	arg_157_0:setBtnAvailable(false)

	arg_157_0.isInGame = false
	pg = var_1

	local var_157_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_157_0, arg_157_0.endUI)

	setActive = var_1

	var_1(arg_157_0.endUI, true)

	setActive = var_1

	var_1(arg_157_0.endFreeTitle, arg_157_0.isFree)

	setActive = var_1

	var_1(arg_157_0.endDayTitle, not arg_157_0.isFree)

	setImageSprite = var_1

	local var_157_1 = arg_157_0.endTitleDay
	local var_157_2 = arg_157_0.titleDays
	local var_157_3 = var_3.Find(var_157_2, arg_157_0.curDay)
	local var_157_4 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	var_1(var_157_1, var_157_4(var_157_3, var_5(var_1_10006)).sprite, true)

	setImageSprite = var_1

	local var_157_5 = arg_157_0.endOurScore
	local var_157_6 = arg_157_0.endScoreNums
	local var_157_7 = var_3.Find(var_157_6, arg_157_0.ourScoreNum)
	local var_157_8 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	var_1(var_157_5, var_157_8(var_157_7, var_5(var_1_10006)).sprite, true)

	setImageSprite = var_1

	local var_157_9 = arg_157_0.endEnemyScore
	local var_157_10 = arg_157_0.endScoreNums
	local var_157_11 = var_3.Find(var_157_10, arg_157_0.enemyScoreNum)
	local var_157_12 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	var_1(var_157_9, var_157_12(var_157_11, var_5(var_1_10006)).sprite, true)

	local var_157_13 = -20
	local var_157_14 = arg_157_0.ourScoreNum

	if arg_157_0.enemyScoreNum < var_157_14 then
		var_157_14 = arg_157_0.winTag
		Vector3 = var_3
		var_157_14.anchoredPosition = var_3(-170, 200, 0)
		var_157_14 = arg_157_0.loseTag
		Vector3 = var_3
		var_157_14.anchoredPosition = var_3(180, 200, 0)
		var_157_13 = -20
	else
		var_157_14 = arg_157_0.winTag
		Vector3 = var_3
		var_157_14.anchoredPosition = var_3(170, 200, 0)
		var_157_14 = arg_157_0.loseTag
		Vector3 = var_3
		var_157_14.anchoredPosition = var_3(-180, 200, 0)
		var_157_13 = 20
	end

	setActive = var_157_14

	local var_157_15 = arg_157_0.winTag

	var_157_14(var_3.GetChild(var_157_15, 0), false)

	setActive = var_157_14

	local var_157_16 = arg_157_0.winTag

	var_157_14(var_3.GetChild(var_157_16, 0), true)

	setLocalRotation = var_157_14

	local var_157_17 = arg_157_0.loseTag

	Vector3 = var_4

	var_157_14(var_157_17, var_4(0, 0, 0))

	LeanTween = var_157_14

	local var_157_18 = var_157_14.rotateZ

	go = var_157_17

	local var_157_19 = var_157_18(var_157_17(arg_157_0.loseTag), var_157_13, 0.2)
	local var_157_20 = var_2.setOnComplete

	System = var_4

	var_157_20(var_157_19, var_4.Action(function()
		local var_158_0 = arg_157_0

		if var_0.GetMGHubData(var_158_0).count > 0 then
			local var_158_1 = arg_157_0
			local var_158_2 = var_1.emit

			BaseMiniGameMediator = var_2_10003

			var_158_2(var_158_1, var_2_10003.MINI_GAME_SUCCESS, 0)
		end

		return
	end))

	return
end

function var_0_1.OnGetAwardDone(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_1.cmd

	MiniGameOPCommand = var_1_10003

	local var_159_1

	if var_159_0 == var_1_10003.CMD_COMPLETE then
		var_159_1 = arg_159_0
		var_159_1 = arg_159_0.GetMGHubData(var_159_1).ultimate

		local var_159_2 = var_2.usedtime
		local var_159_3 = var_2:getConfig("reward_need")
		local var_159_4 = arg_159_0
		local var_159_5 = arg_159_0.GetMGHubData(var_159_4).count

		pg = var_159_4

		local var_159_6 = var_159_4.NewStoryMgr.GetInstance()
		local var_159_7

		if not arg_159_0.storylist[arg_159_0:GetMGHubData().usedtime] or not arg_159_0.storylist[arg_159_0:GetMGHubData().usedtime][1] then
			var_159_7 = nil
		end

		if var_159_2 ~= 7 and var_159_7 and not var_159_6:IsPlayed(var_159_7) then
			var_159_6:Play(var_159_7)
		end

		if var_159_1 == 0 and var_159_3 <= var_159_2 then
			pg = var_9

			local var_159_8 = var_9.m02
			local var_159_9 = var_9.sendNotification

			GAME = var_1_10011

			local var_159_10 = var_1_10011.SEND_MINI_GAME_OP
			local var_159_11 = {
				hubid = var_2.id
			}

			MiniGameOPCommand = var_13
			var_159_11.cmd = var_13.CMD_ULTIMATE
			var_159_11.args1 = {}

			var_159_9(var_159_8, var_159_10, var_159_11)
		end
	else
		local var_159_12 = arg_159_1.cmd

		MiniGameOPCommand = var_159_1

		if var_159_12 == var_159_1.CMD_ULTIMATE then
			local var_159_13

			if not arg_159_0.storylist[7][1] or not arg_159_0.storylist[7][1] then
				var_159_13 = nil
			end

			pg = var_3

			local var_159_14 = var_3.NewStoryMgr.GetInstance()

			if var_159_13 and not var_159_14:IsPlayed(var_159_13) then
				var_159_14:Play(var_159_13)
			end
		end
	end

	return
end

function var_0_1.pauseGame(arg_160_0)
	arg_160_0:pauseManagedTween()

	if arg_160_0.qteTimer then
		local var_160_0 = arg_160_0.qteTimer

		var_1.Pause(var_160_0)
	end

	if arg_160_0.qteTween then
		LeanTween = var_1

		if var_1.isTweening(arg_160_0.qteTween) then
			LeanTween = var_1

			var_1.pause(arg_160_0.qteTween)
		end
	end

	pairs = var_1

	for iter_160_0, iter_160_1 in var_1(arg_160_0.charactor) do
		iter_160_1:pauseSpine()
	end

	return
end

function var_0_1.resumeGame(arg_161_0)
	arg_161_0:resumeManagedTween()

	if arg_161_0.qteTimer then
		local var_161_0 = arg_161_0.qteTimer

		var_1.Resume(var_161_0)
	end

	if arg_161_0.qteTween then
		LeanTween = var_1

		if var_1.isTweening(arg_161_0.qteTween) then
			LeanTween = var_1

			var_1.resume(arg_161_0.qteTween)
		end
	end

	pairs = var_1

	for iter_161_0, iter_161_1 in var_1(arg_161_0.charactor) do
		iter_161_1:resumeSpine()
	end

	return
end

function var_0_1.clearTimer(arg_162_0)
	if arg_162_0.qteTimer then
		local var_162_0 = arg_162_0.qteTimer

		var_1.Stop(var_162_0)

		arg_162_0.qteTimer = nil
	end

	if arg_162_0.countTimer then
		local var_162_1 = arg_162_0.countTimer

		var_1.Stop(var_162_1)

		arg_162_0.countTimer = nil
	end

	return
end

function var_0_1.changeQTEBtnStatus(arg_163_0, arg_163_1)
	arg_163_0.qteBtnStatus = arg_163_1

	return
end

function var_0_1.resetGameData(arg_164_0)
	arg_164_0.qteStatus = var_0_10
	arg_164_0.qteType = var_0_13

	arg_164_0:changeQTEBtnStatus(var_0_6)

	arg_164_0.ballPosTag = ""
	arg_164_0.isCutin = false
	arg_164_0.cutin.anchoredPosition = {
		x = -567,
		y = 582
	}
	arg_164_0.isScoreCutin = false
	setActive = var_1

	var_1(arg_164_0.scoreCutin, false)

	arg_164_0.ourScoreNum = 0
	arg_164_0.enemyScoreNum = 0
	setText = var_1

	var_1(arg_164_0.ourScore, arg_164_0.ourScoreNum)

	setText = var_1

	var_1(arg_164_0.enemyScore, arg_164_0.enemyScoreNum)

	setActive = var_1

	var_1(arg_164_0.qte, false)
	arg_164_0:loadSpineChars()

	return
end

function var_0_1.exitGame(arg_165_0)
	arg_165_0.isInGame = false

	arg_165_0:setBtnAvailable(true)
	arg_165_0:resetGameAni()

	return
end

function var_0_1.resetGameAni(arg_166_0)
	arg_166_0:cleanManagedTween()

	if arg_166_0.qteTween then
		LeanTween = var_1

		if var_1.isTweening(arg_166_0.qteTween) then
			LeanTween = var_1

			var_1.cancel(arg_166_0.qteTween, false)
		end
	end

	arg_166_0:clearTimer()

	return
end

function var_0_1.willExit(arg_167_0)
	arg_167_0:clearSpineChars()

	pg = var_1

	local var_167_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_167_0, arg_167_0.selectUI, arg_167_0._tf)

	pg = var_1

	local var_167_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_167_1, arg_167_0.endUI, arg_167_0._tf)

	pg = var_1

	local var_167_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_167_2, arg_167_0.countTimeUI, arg_167_0._tf)

	return
end

function var_0_1.onBackPressed(arg_168_0)
	if arg_168_0.isInGame then
		triggerButton = var_1

		var_1(arg_168_0.backBtn)
	else
		isActive = var_1

		if var_1(arg_168_0.selectUI) then
			triggerButton = var_1

			var_1(arg_168_0.selectBackBtn)
		else
			isActive = var_1

			if var_1(arg_168_0.mainUI) then
				triggerButton = var_1

				var_1(arg_168_0.returnBtn)
			end
		end
	end

	return
end

return var_0_1
