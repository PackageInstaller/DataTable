class = var_0_10000

local var_0_0 = "BeachGuardGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

var_0_1.LEVEL_GAME = "leavel game"
var_0_1.PAUSE_GAME = "pause game "
var_0_1.OPEN_PAUSE_UI = "open pause ui"
var_0_1.OPEN_LEVEL_UI = "open leave ui"
var_0_1.BACK_MENU = "back menu"
var_0_1.CLOSE_GAME = "close game"
var_0_1.SHOW_RULE = "show rule"
var_0_1.READY_START = "ready start"
var_0_1.COUNT_DOWN = "count down"
var_0_1.STORE_SERVER = "store server"
var_0_1.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_1.OPEN_BOOK = "open book"
var_0_1.RECYCLES_CHAR = "RECYCLES CHAR"
var_0_1.RECYCLES_CHAR_CANCEL = "RECYCLES CHAR CANCEL"
var_0_1.DRAG_CHAR = "DRAG CHAR"
var_0_1.PULL_CHAR = "PULL CHAR"
var_0_1.USE_SKILL = "USE SKILL"
var_0_1.ADD_CRAFT = "ADD CRAFT"
var_0_1.ADD_ENEMY = "ADD ENEMY"
var_0_1.CREATE_CHAR_DAMAGE = "create char damage"
var_0_1.REMOVE_CHAR = "REMOVE CHAR"
var_0_1.BULLET_DAMAGE = "BULLET DAMAGE"
var_0_1.GAME_OVER = "GAME OVER"
var_0_1.ENEMY_COMMING = "enemy comming"

local var_0_2 = 1920
local var_0_3 = 1080
local var_0_4 = "bar-soft"
local var_0_5 = 6000
local var_0_6 = "pvzminigame_help"

Application = var_0_10006

local var_0_7

if not var_0_10006.targetFrameRate then
	var_0_7 = 60
end

function var_0_1.getUIName(arg_1_0)
	return "BeachGuardGameUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initEvent()
	arg_2_0:initUI()
	arg_2_0:initController()

	local var_2_0 = arg_2_0.beachGuardUI

	var_1.clearUI(var_2_0)

	setActive = var_1

	var_1(arg_2_0.bg, true)

	local var_2_1 = arg_2_0.menuUI

	var_1.show(var_2_1, true)

	local var_2_2 = arg_2_0.menuUI

	var_1.update(var_2_2, arg_2_0:GetMGHubData())
	arg_2_0:PlayGuider("NG0035")

	return
end

function var_0_1.PlayGuider(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.NewStoryMgr.GetInstance()

	if not var_2.IsPlayed(var_3_0, arg_3_1) then
		pg = var_2

		local var_3_1 = var_2.NewGuideMgr.GetInstance()

		var_2.Play(var_3_1, arg_3_1)

		pg = var_2

		local var_3_2 = var_2.m02
		local var_3_3 = var_2.sendNotification

		GAME = var_5

		var_3_3(var_3_2, var_5.STORY_UPDATE, {
			storyId = arg_3_1
		})
	end

	return
end

function var_0_1.initData(arg_4_0)
	if var_0_7 > 60 then
		var_0_7 = 60
	end

	Timer = var_1
	arg_4_0.timer = var_1.New(function()
		local var_5_0 = arg_4_0

		var_0.onTimer(var_5_0)

		return
	end, 1 / var_0_7, -1)

	local var_4_0 = arg_4_0:GetMGData().id
	local var_4_1 = {
		path = "ui/minigameui/beachguardgameui_atlas",
		game_time = var_0_5
	}

	pg = var_3
	var_4_1.drop = var_3.mini_game[var_4_0].simple_config_data.drop

	local var_4_2 = arg_4_0:GetMGHubData()

	var_4_1.total_times = var_3.getConfig(var_4_2, "reward_need")
	var_4_1.rule_tip = var_0_6
	BeachGuardAsset = var_3
	var_4_1.asset = var_3.New(arg_4_0._tf)
	arg_4_0.gameData = var_4_1

	return
end

function var_0_1.initEvent(arg_6_0)
	if not arg_6_0.handle then
		IsUnityEditor = var_1

		if var_1 then
			UpdateBeat = var_1
			arg_6_0.handle = var_1:CreateListener(arg_6_0.Update, arg_6_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_6_0.handle)
		end
	end

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.bind

	BeachGuardGameView = var_1_10004

	var_6_1(var_6_0, var_1_10004.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			local var_7_0 = arg_6_0

			var_3.resumeGame(var_7_0)

			local var_7_1 = arg_6_0

			var_3.onGameOver(var_7_1)
		else
			local var_7_2 = arg_6_0

			var_3.resumeGame(var_7_2)
		end

		return
	end)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_3(var_6_2, var_4.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0

		var_3.gameStart(var_8_0)

		return
	end)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_5(var_6_4, var_4.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_6_0.beachGuardUI

		var_3.popPauseUI(var_9_0)

		return
	end)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_7(var_6_6, var_4.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_6_0.beachGuardUI

		var_3.popLeaveUI(var_10_0)

		return
	end)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_9(var_6_8, var_4.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			local var_11_0 = arg_6_0

			var_3.pauseGame(var_11_0)
		else
			local var_11_1 = arg_6_0

			var_3.resumeGame(var_11_1)
		end

		return
	end)

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_11(var_6_10, var_4.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		setActive = var_2_10003

		var_2_10003(arg_6_0.sceneContainer, false)

		local var_12_0 = arg_6_0.menuUI
		local var_12_1 = var_3.update
		local var_12_2 = arg_6_0

		var_12_1(var_12_0, var_6.GetMGHubData(var_12_2))

		local var_12_3 = arg_6_0.menuUI

		var_3.show(var_12_3, true)

		local var_12_4 = arg_6_0.gameUI

		var_3.show(var_12_4, false)

		return
	end)

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_13(var_6_12, var_4.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_6_0

		var_3.closeView(var_13_0)

		return
	end)

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_15(var_6_14, var_4.ENEMY_COMMING, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_6_0.gameUI

		var_3.setEnemyComming(var_14_0)

		return
	end)

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_17(var_6_16, var_4.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_6_0

		var_3.onGameOver(var_15_0)

		return
	end)

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_19(var_6_18, var_4.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg = var_2_10003

		local var_16_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_16_1 = var_3.ShowMsgBox
		local var_16_2 = {}

		MSGBOX_TYPE_HELP = var_2_10007
		var_16_2.type = var_2_10007
		pg = var_2_10007
		var_16_2.helps = var_2_10007.gametip[var_0_6].tip

		var_16_1(var_16_0, var_16_2)

		return
	end)

	local var_6_20 = arg_6_0
	local var_6_21 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_21(var_6_20, var_4.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_6_0

		var_3.readyStart(var_17_0)

		return
	end)

	local var_6_22 = arg_6_0
	local var_6_23 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_23(var_6_22, var_4.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_6_0

		var_3.StoreDataToServer(var_18_0, {
			arg_18_1
		})

		return
	end)

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_25(var_6_24, var_4.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			local var_19_0 = arg_6_0

			var_3.SendSuccess(var_19_0, 0)
		end

		return
	end)

	local var_6_26 = arg_6_0
	local var_6_27 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_27(var_6_26, var_4.RECYCLES_CHAR, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_6_0

		var_3.changeRecycles(var_20_0, arg_20_1)

		return
	end)

	local var_6_28 = arg_6_0
	local var_6_29 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_29(var_6_28, var_4.RECYCLES_CHAR_CANCEL, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_6_0.gameUI

		var_3.cancelRecycle(var_21_0)

		local var_21_1 = arg_6_0

		var_3.changeRecycles(var_21_1, false)

		return
	end)

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_31(var_6_30, var_4.DRAG_CHAR, function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_6_0.sceneMgr

		var_3.setDrag(var_22_0, arg_22_1)

		return
	end)

	local var_6_32 = arg_6_0
	local var_6_33 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_33(var_6_32, var_4.PULL_CHAR, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_23_1.card_id
		local var_23_1 = arg_23_1.line_index
		local var_23_2 = arg_23_1.grid_index

		BeachGuardConst = var_2_10006

		local var_23_3 = var_2_10006.char_card[var_23_0].char_id
		local var_23_4 = var_6.cost
		local var_23_5 = var_6.once
		local var_23_6 = arg_6_0.runningData.goodsNum
		local var_23_7 = arg_6_0.runningData.sceneChars

		if var_23_6 < var_23_4 then
			return
		end

		if var_23_5 then
			table = var_2_10012

			if var_2_10012.contains(var_23_7, var_23_3) then
				return
			end
		end

		local var_23_8 = arg_6_0.sceneMgr

		if var_12.pullChar(var_23_8, var_23_3, var_23_1, var_23_2) then
			local var_23_9 = arg_6_0
			local var_23_10 = var_13.goodsUpdate

			math = var_16

			var_23_10(var_23_9, -1 * var_16.abs(var_23_4))

			local var_23_11 = arg_6_0

			var_13.pullSceneChar(var_23_11, var_23_3)
		end

		return
	end)

	local var_6_34 = arg_6_0
	local var_6_35 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_35(var_6_34, var_4.USE_SKILL, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_6_0.sceneMgr

		var_3.useSkill(var_24_0, arg_24_1)

		return
	end)

	local var_6_36 = arg_6_0
	local var_6_37 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_37(var_6_36, var_4.ADD_CRAFT, function(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = arg_6_0

		var_3.goodsUpdate(var_25_0, arg_25_1.num)

		return
	end)

	local var_6_38 = arg_6_0
	local var_6_39 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_39(var_6_38, var_4.ADD_ENEMY, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_6_0.sceneMgr

		var_3.addEnemy(var_26_0, arg_26_1)

		return
	end)

	local var_6_40 = arg_6_0
	local var_6_41 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_41(var_6_40, var_4.CREATE_CHAR_DAMAGE, function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = arg_6_0.sceneMgr

		var_3.craeteCharDamage(var_27_0, arg_27_1)

		return
	end)

	local var_6_42 = arg_6_0
	local var_6_43 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_43(var_6_42, var_4.REMOVE_CHAR, function(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_6_0

		var_3.removeSceneChar(var_28_0, arg_28_1:getId())

		local var_28_1 = arg_6_0.sceneMgr

		var_3.removeChar(var_28_1, arg_28_1)

		if arg_28_1 and arg_28_1:getCamp() == 2 then
			local var_28_2 = arg_6_0

			var_3.addScore(var_28_2, arg_28_1:getScore())
		end

		return
	end)

	local var_6_44 = arg_6_0
	local var_6_45 = arg_6_0.bind

	BeachGuardGameView = var_4

	var_6_45(var_6_44, var_4.BULLET_DAMAGE, function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_6_0.sceneMgr

		var_3.bulletDamage(var_29_0, arg_29_1)

		return
	end)

	return
end

function var_0_1.onEventHandle(arg_30_0, arg_30_1)
	return
end

function var_0_1.initUI(arg_31_0)
	findTF = var_1_10001
	arg_31_0.sceneMask = var_1_10001(arg_31_0._tf, "sceneMask")
	findTF = var_1
	arg_31_0.sceneContainer = var_1(arg_31_0._tf, "sceneMask/sceneContainer")
	findTF = var_1
	arg_31_0.clickMask = var_1(arg_31_0._tf, "clickMask")
	findTF = var_1
	arg_31_0.bg = var_1(arg_31_0._tf, "bg")
	BeachGuardUI = var_1
	arg_31_0.beachGuardUI = var_1.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)
	BeachGuardGameUI = var_1
	arg_31_0.gameUI = var_1.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)
	BeachGuardMenuUI = var_1
	arg_31_0.menuUI = var_1.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)

	return
end

function var_0_1.initController(arg_32_0)
	BeachGuardSceneMgr = var_1_10001
	arg_32_0.sceneMgr = var_1_10001.New(arg_32_0.sceneMask, arg_32_0.gameData, arg_32_0)

	return
end

function var_0_1.Update(arg_33_0)
	if arg_33_0.gameStop or arg_33_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_33_0 = var_1.GetKeyDown

		KeyCode = var_1_10003

		if var_33_0(var_1_10003.S) then
			-- block empty
		end
	end

	return
end

function var_0_1.readyStart(arg_34_0)
	arg_34_0.readyStartFlag = true

	local var_34_0 = arg_34_0.beachGuardUI

	var_1.readyStart(var_34_0)

	local var_34_1 = arg_34_0.menuUI

	var_1.show(var_34_1, false)

	local var_34_2 = arg_34_0.gameUI

	var_1.show(var_34_2, false)

	local var_34_3 = arg_34_0
	local var_34_4 = arg_34_0.getChapter(var_34_3)

	BeachGuardConst = var_1_10002

	local var_34_5 = var_1_10002.chapater_enemy[var_34_4].init_goods

	BeachGuardConst = var_34_3

	if var_34_3.chapter_data[var_34_4].fog then
		BeachGuardConst = var_4
		BeachGuardConst = var_1_10005
		var_4.enemy_bullet_width = var_1_10005.enemy_bullet_fog
	else
		BeachGuardConst = var_4
		BeachGuardConst = var_1_10005
		var_4.enemy_bullet_width = var_1_10005.enemy_bullet_defaut
	end

	arg_34_0.runningData = {
		scoreNum = 0,
		stepTime = 0,
		gameStepTime = 0,
		gameTime = arg_34_0.gameData.game_time,
		chapter = var_34_4,
		goodsNum = var_34_5 or 0,
		sceneChars = {},
		fog = var_3.fog
	}

	local var_34_6 = arg_34_0.sceneMgr

	var_4.setData(var_34_6, arg_34_0.runningData)

	return
end

function var_0_1.getChapter(arg_35_0)
	local var_35_0

	if not arg_35_0:GetMGHubData().usedtime or arg_35_0:GetMGHubData().usedtime == 0 then
		var_35_0 = 1
	elseif arg_35_0:GetMGHubData().count > 0 then
		var_35_0 = arg_35_0:GetMGHubData().usedtime + 1
	else
		var_35_0 = arg_35_0:GetMGHubData().usedtime
	end

	print = var_2

	var_2("return chapter is " .. var_35_0)

	return var_35_0
end

function var_0_1.gameStart(arg_36_0)
	arg_36_0.readyStartFlag = false
	arg_36_0.gameStartFlag = true
	arg_36_0.sendSuccessFlag = false
	setActive = var_1

	var_1(arg_36_0.sceneContainer, true)

	setActive = var_1

	var_1(arg_36_0.bg, false)

	local var_36_0 = arg_36_0.beachGuardUI

	var_1.popCountUI(var_36_0, false)

	local var_36_1 = arg_36_0.gameUI

	var_1.firstUpdate(var_36_1, arg_36_0.runningData)

	local var_36_2 = arg_36_0.gameUI

	var_1.show(var_36_2, true)

	local var_36_3 = arg_36_0.sceneMgr

	var_1.start(var_36_3)
	arg_36_0:timerStart()

	return
end

function var_0_1.changeSpeed(arg_37_0, arg_37_1)
	return
end

function var_0_1.onTimer(arg_38_0)
	arg_38_0:gameStep()

	return
end

function var_0_1.gameStep(arg_39_0)
	arg_39_0:stepRunTimeData()

	local var_39_0 = arg_39_0.sceneMgr

	var_1.step(var_39_0)

	local var_39_1 = arg_39_0.gameUI

	var_1.update(var_39_1, arg_39_0.runningData)

	if arg_39_0.runningData.gameTime <= 0 then
		arg_39_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_40_0)
	if not arg_40_0.timer.running then
		local var_40_0 = arg_40_0.timer

		var_1.Start(var_40_0)
	end

	return
end

function var_0_1.timerResume(arg_41_0)
	if not arg_41_0.timer.running then
		local var_41_0 = arg_41_0.timer

		var_1.Start(var_41_0)
	end

	return
end

function var_0_1.timerStop(arg_42_0)
	if arg_42_0.timer.running then
		local var_42_0 = arg_42_0.timer

		var_1.Stop(var_42_0)
	end

	return
end

function var_0_1.stepRunTimeData(arg_43_0)
	Time = var_1_10001

	local var_43_0

	if var_1_10001.deltaTime > 0.016 then
		var_43_0 = 0.016
	end

	arg_43_0.runningData.gameTime = arg_43_0.runningData.gameTime - var_43_0
	arg_43_0.runningData.gameStepTime = arg_43_0.runningData.gameStepTime + var_43_0
	arg_43_0.runningData.deltaTime = var_43_0

	return
end

function var_0_1.changeRecycles(arg_44_0, arg_44_1)
	arg_44_0.runningData.recycles = arg_44_1

	local var_44_0 = arg_44_0.sceneMgr

	var_2.changeRecycles(var_44_0, arg_44_1)
	arg_44_0:runningUpdate()

	return
end

function var_0_1.addScore(arg_45_0, arg_45_1)
	arg_45_0.runningData.scoreNum = arg_45_0.runningData.scoreNum + arg_45_1

	return
end

function var_0_1.pullSceneChar(arg_46_0, arg_46_1)
	table = var_1_10002

	var_1_10002.insert(arg_46_0.runningData.sceneChars, arg_46_1)
	arg_46_0:runningUpdate()

	return
end

function var_0_1.removeSceneChar(arg_47_0, arg_47_1)
	for iter_47_0 = #arg_47_0.runningData.sceneChars, 1, -1 do
		if arg_47_0.runningData.sceneChars[iter_47_0] == arg_47_1 then
			table = var_6

			var_6.remove(arg_47_0.runningData.sceneChars, iter_47_0)
		end
	end

	return
end

function var_0_1.goodsUpdate(arg_48_0, arg_48_1)
	arg_48_0.runningData.goodsNum = arg_48_0.runningData.goodsNum + arg_48_1

	local var_48_0 = arg_48_0.gameUI

	var_2.updateGoods(var_48_0, arg_48_1)

	return
end

function var_0_1.runningUpdate(arg_49_0)
	return
end

function var_0_1.onGameOver(arg_50_0)
	if arg_50_0.settlementFlag then
		return
	end

	arg_50_0:timerStop()
	arg_50_0:clearGame()

	arg_50_0.settlementFlag = true
	setActive = var_1

	var_1(arg_50_0.clickMask, true)

	LeanTween = var_1

	local var_50_0 = var_1.delayedCall

	go = var_3

	local var_50_1 = var_3(arg_50_0._tf)
	local var_50_2 = 0.1

	System = var_5

	var_50_0(var_50_1, var_50_2, var_5.Action(function()
		arg_50_0.settlementFlag = false

		local var_51_0 = arg_50_0

		var_51_0.gameStartFlag = false
		setActive = var_51_0

		var_51_0(arg_50_0.clickMask, false)

		local var_51_1 = arg_50_0.beachGuardUI
		local var_51_2 = var_0.updateSettlementUI
		local var_51_3 = arg_50_0
		local var_51_4 = var_3.GetMGData(var_51_3)
		local var_51_5 = arg_50_0

		var_51_2(var_51_1, var_51_4, var_4.GetMGHubData(var_51_5), arg_50_0.runningData)

		local var_51_6 = arg_50_0.beachGuardUI

		var_0.openSettlementUI(var_51_6, true)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_52_0)
	if not arg_52_0.gameStartFlag then
		return
	end

	if arg_52_0.readyStartFlag then
		return
	end

	if arg_52_0.settlementFlag then
		return
	end

	arg_52_0:pauseGame()

	local var_52_0 = arg_52_0.beachGuardUI

	var_1.popPauseUI(var_52_0)

	return
end

function var_0_1.clearGame(arg_53_0)
	local var_53_0 = arg_53_0.sceneMgr

	var_1.clear(var_53_0)

	return
end

function var_0_1.pauseGame(arg_54_0)
	arg_54_0.gameStop = true

	arg_54_0:changeSpeed(0)
	arg_54_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_55_0)
	arg_55_0.gameStop = false

	arg_55_0:changeSpeed(1)
	arg_55_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_56_0)
	if arg_56_0.readyStartFlag then
		return
	end

	if not arg_56_0.gameStartFlag then
		arg_56_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_56_0.settlementFlag then
			return
		end

		local var_56_0 = arg_56_0.beachGuardUI

		var_1.backPressed(var_56_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_57_0, arg_57_1)
	return
end

function var_0_1.willExit(arg_58_0)
	if arg_58_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_58_0.handle)
	end

	if arg_58_0._tf then
		LeanTween = var_1

		local var_58_0 = var_1.isTweening

		go = var_1_10003

		if var_58_0(var_1_10003(arg_58_0._tf)) then
			LeanTween = var_1

			local var_58_1 = var_1.cancel

			go = var_3

			var_58_1(var_3(arg_58_0._tf))
		end
	end

	if arg_58_0.timer and arg_58_0.timer.running then
		local var_58_2 = arg_58_0.timer

		var_1.Stop(var_58_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_58_0.timer = nil

	arg_58_0:destroyController()

	BeachGuardAsset = var_1

	var_1.clear()

	return
end

function var_0_1.destroyController(arg_59_0)
	return
end

return var_0_1
