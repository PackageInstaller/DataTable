local var_0_0 = class("BeachGuardGameView", import("..BaseMiniGameView"))

var_0_0.LEVEL_GAME = "leavel game"
var_0_0.PAUSE_GAME = "pause game "
var_0_0.OPEN_PAUSE_UI = "open pause ui"
var_0_0.OPEN_LEVEL_UI = "open leave ui"
var_0_0.BACK_MENU = "back menu"
var_0_0.CLOSE_GAME = "close game"
var_0_0.SHOW_RULE = "show rule"
var_0_0.READY_START = "ready start"
var_0_0.COUNT_DOWN = "count down"
var_0_0.STORE_SERVER = "store server"
var_0_0.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_0.OPEN_BOOK = "open book"
var_0_0.RECYCLES_CHAR = "RECYCLES CHAR"
var_0_0.RECYCLES_CHAR_CANCEL = "RECYCLES CHAR CANCEL"
var_0_0.DRAG_CHAR = "DRAG CHAR"
var_0_0.PULL_CHAR = "PULL CHAR"
var_0_0.USE_SKILL = "USE SKILL"
var_0_0.ADD_CRAFT = "ADD CRAFT"
var_0_0.ADD_ENEMY = "ADD ENEMY"
var_0_0.CREATE_CHAR_DAMAGE = "create char damage"
var_0_0.REMOVE_CHAR = "REMOVE CHAR"
var_0_0.BULLET_DAMAGE = "BULLET DAMAGE"
var_0_0.GAME_OVER = "GAME OVER"
var_0_0.ENEMY_COMMING = "enemy comming"

local var_0_4 = 6000
local var_0_5 = "pvzminigame_help"
local var_0_6

if not Application.targetFrameRate then
	var_0_6 = 60
end

function var_0_0.getUIName(arg_1_0)
	return "BeachGuardGameUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initEvent()
	arg_2_0:initUI()
	arg_2_0:initController()
	arg_2_0.beachGuardUI:clearUI()
	setActive(arg_2_0.bg, true)
	arg_2_0.menuUI:show(true)
	arg_2_0.menuUI:update(arg_2_0:GetMGHubData())
	arg_2_0:PlayGuider("NG0035")

	return
end

function var_0_0.PlayGuider(arg_3_0, arg_3_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_3_1) then
		pg.NewGuideMgr.GetInstance():Play(arg_3_1)
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_3_1
		})
	end

	return
end

function var_0_0.initData(arg_4_0)
	if var_0_6 > 60 then
		var_0_6 = 60
	end

	arg_4_0.timer = Timer.New(function()
		arg_4_0:onTimer()

		return
	end, 1 / var_0_6, -1)

	local var_4_0 = {
		path = "ui/minigameui/beachguardgameui_atlas",
		game_time = var_0_4,
		drop = pg.mini_game[arg_4_0:GetMGData().id].simple_config_data.drop
	}

	var_4_0.total_times = arg_4_0:GetMGHubData():getConfig("reward_need")
	var_4_0.rule_tip = var_0_5
	var_4_0.asset = BeachGuardAsset.New(arg_4_0._tf)
	arg_4_0.gameData = var_4_0

	return
end

function var_0_0.initEvent(arg_6_0)
	if not arg_6_0.handle and IsUnityEditor then
		arg_6_0.handle = UpdateBeat:CreateListener(arg_6_0.Update, arg_6_0)

		UpdateBeat:AddListener(arg_6_0.handle)
	end

	arg_6_0:bind(BeachGuardGameView.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			arg_6_0:resumeGame()
			arg_6_0:onGameOver()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0:gameStart()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		arg_6_0.beachGuardUI:popPauseUI()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_6_0.beachGuardUI:popLeaveUI()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			arg_6_0:pauseGame()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		setActive(arg_6_0.sceneContainer, false)
		arg_6_0.menuUI:update(arg_6_0:GetMGHubData())
		arg_6_0.menuUI:show(true)
		arg_6_0.gameUI:show(false)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		arg_6_0:closeView()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ENEMY_COMMING, function(arg_14_0, arg_14_1, arg_14_2)
		arg_6_0.gameUI:setEnemyComming()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		arg_6_0:onGameOver()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_5].tip
		})

		return
	end)
	arg_6_0:bind(BeachGuardGameView.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		arg_6_0:readyStart()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		arg_6_0:StoreDataToServer({
			arg_18_1
		})

		return
	end)
	arg_6_0:bind(BeachGuardGameView.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			arg_6_0:SendSuccess(0)
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.RECYCLES_CHAR, function(arg_20_0, arg_20_1, arg_20_2)
		arg_6_0:changeRecycles(arg_20_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.RECYCLES_CHAR_CANCEL, function(arg_21_0, arg_21_1, arg_21_2)
		arg_6_0.gameUI:cancelRecycle()
		arg_6_0:changeRecycles(false)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.DRAG_CHAR, function(arg_22_0, arg_22_1, arg_22_2)
		arg_6_0.sceneMgr:setDrag(arg_22_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.PULL_CHAR, function(arg_23_0, arg_23_1, arg_23_2)
		if arg_6_0.runningData.goodsNum < BeachGuardConst.char_card[arg_23_1.card_id].cost then
			return
		end

		if BeachGuardConst.char_card[arg_23_1.card_id].once and table.contains(arg_6_0.runningData.sceneChars, BeachGuardConst.char_card[arg_23_1.card_id].char_id) then
			return
		end

		if arg_6_0.sceneMgr:pullChar(BeachGuardConst.char_card[arg_23_1.card_id].char_id, arg_23_1.line_index, arg_23_1.grid_index) then
			arg_6_0:goodsUpdate(-1 * math.abs(BeachGuardConst.char_card[arg_23_1.card_id].cost))
			arg_6_0:pullSceneChar(BeachGuardConst.char_card[arg_23_1.card_id].char_id)
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.USE_SKILL, function(arg_24_0, arg_24_1, arg_24_2)
		arg_6_0.sceneMgr:useSkill(arg_24_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ADD_CRAFT, function(arg_25_0, arg_25_1, arg_25_2)
		arg_6_0:goodsUpdate(arg_25_1.num)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ADD_ENEMY, function(arg_26_0, arg_26_1, arg_26_2)
		arg_6_0.sceneMgr:addEnemy(arg_26_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.CREATE_CHAR_DAMAGE, function(arg_27_0, arg_27_1, arg_27_2)
		arg_6_0.sceneMgr:craeteCharDamage(arg_27_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.REMOVE_CHAR, function(arg_28_0, arg_28_1, arg_28_2)
		arg_6_0:removeSceneChar(arg_28_1:getId())
		arg_6_0.sceneMgr:removeChar(arg_28_1)

		if arg_28_1 and arg_28_1:getCamp() == 2 then
			arg_6_0:addScore(arg_28_1:getScore())
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.BULLET_DAMAGE, function(arg_29_0, arg_29_1, arg_29_2)
		arg_6_0.sceneMgr:bulletDamage(arg_29_1)

		return
	end)

	return
end

function var_0_0.onEventHandle(arg_30_0, arg_30_1)
	return
end

function var_0_0.initUI(arg_31_0)
	arg_31_0.sceneMask = findTF(arg_31_0._tf, "sceneMask")
	arg_31_0.sceneContainer = findTF(arg_31_0._tf, "sceneMask/sceneContainer")
	arg_31_0.clickMask = findTF(arg_31_0._tf, "clickMask")
	arg_31_0.bg = findTF(arg_31_0._tf, "bg")
	arg_31_0.beachGuardUI = BeachGuardUI.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)
	arg_31_0.gameUI = BeachGuardGameUI.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)
	arg_31_0.menuUI = BeachGuardMenuUI.New(arg_31_0._tf, arg_31_0.gameData, arg_31_0)

	return
end

function var_0_0.initController(arg_32_0)
	arg_32_0.sceneMgr = BeachGuardSceneMgr.New(arg_32_0.sceneMask, arg_32_0.gameData, arg_32_0)

	return
end

function var_0_0.Update(arg_33_0)
	if arg_33_0.gameStop or arg_33_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function var_0_0.readyStart(arg_34_0)
	arg_34_0.readyStartFlag = true

	arg_34_0.beachGuardUI:readyStart()
	arg_34_0.menuUI:show(false)
	arg_34_0.gameUI:show(false)

	local var_34_0 = arg_34_0:getChapter()
	local var_34_1 = BeachGuardConst.chapater_enemy[var_34_0].init_goods
	local var_34_2 = BeachGuardConst.chapter_data[var_34_0]

	BeachGuardConst.enemy_bullet_width = BeachGuardConst.chapter_data[var_34_0].fog and BeachGuardConst.enemy_bullet_fog or BeachGuardConst.enemy_bullet_defaut
	arg_34_0.runningData = {
		scoreNum = 0,
		stepTime = 0,
		gameStepTime = 0,
		gameTime = arg_34_0.gameData.game_time,
		chapter = var_34_0,
		goodsNum = var_34_1 or 0,
		sceneChars = {},
		fog = var_34_2.fog
	}

	arg_34_0.sceneMgr:setData(arg_34_0.runningData)

	return
end

function var_0_0.getChapter(arg_35_0)
	local var_35_0 = (not arg_35_0:GetMGHubData().usedtime or arg_35_0:GetMGHubData().usedtime == 0) and 1 or arg_35_0:GetMGHubData().count > 0 and arg_35_0:GetMGHubData().usedtime + 1 or arg_35_0:GetMGHubData().usedtime

	print("return chapter is " .. var_35_0)

	return var_35_0
end

function var_0_0.gameStart(arg_36_0)
	arg_36_0.readyStartFlag = false
	arg_36_0.gameStartFlag = true
	arg_36_0.sendSuccessFlag = false

	setActive(arg_36_0.sceneContainer, true)
	setActive(arg_36_0.bg, false)
	arg_36_0.beachGuardUI:popCountUI(false)
	arg_36_0.gameUI:firstUpdate(arg_36_0.runningData)
	arg_36_0.gameUI:show(true)
	arg_36_0.sceneMgr:start()
	arg_36_0:timerStart()

	return
end

function var_0_0.changeSpeed(arg_37_0, arg_37_1)
	return
end

function var_0_0.onTimer(arg_38_0)
	arg_38_0:gameStep()

	return
end

function var_0_0.gameStep(arg_39_0)
	arg_39_0:stepRunTimeData()
	arg_39_0.sceneMgr:step()
	arg_39_0.gameUI:update(arg_39_0.runningData)

	if arg_39_0.runningData.gameTime <= 0 then
		arg_39_0:onGameOver()
	end

	return
end

function var_0_0.timerStart(arg_40_0)
	if not arg_40_0.timer.running then
		arg_40_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_41_0)
	if not arg_41_0.timer.running then
		arg_41_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_42_0)
	if arg_42_0.timer.running then
		arg_42_0.timer:Stop()
	end

	return
end

function var_0_0.stepRunTimeData(arg_43_0)
	local var_43_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_43_0 = 0.016
	end

	arg_43_0.runningData.gameTime = arg_43_0.runningData.gameTime - var_43_0
	arg_43_0.runningData.gameStepTime = arg_43_0.runningData.gameStepTime + var_43_0
	arg_43_0.runningData.deltaTime = var_43_0

	return
end

function var_0_0.changeRecycles(arg_44_0, arg_44_1)
	arg_44_0.runningData.recycles = arg_44_1

	arg_44_0.sceneMgr:changeRecycles(arg_44_1)
	arg_44_0:runningUpdate()

	return
end

function var_0_0.addScore(arg_45_0, arg_45_1)
	arg_45_0.runningData.scoreNum = arg_45_0.runningData.scoreNum + arg_45_1

	return
end

function var_0_0.pullSceneChar(arg_46_0, arg_46_1)
	table.insert(arg_46_0.runningData.sceneChars, arg_46_1)
	arg_46_0:runningUpdate()

	return
end

function var_0_0.removeSceneChar(arg_47_0, arg_47_1)
	for iter_47_0 = #arg_47_0.runningData.sceneChars, 1, -1 do
		if arg_47_0.runningData.sceneChars[iter_47_0] == arg_47_1 then
			table.remove(arg_47_0.runningData.sceneChars, iter_47_0)
		end
	end

	return
end

function var_0_0.goodsUpdate(arg_48_0, arg_48_1)
	arg_48_0.runningData.goodsNum = arg_48_0.runningData.goodsNum + arg_48_1

	arg_48_0.gameUI:updateGoods(arg_48_1)

	return
end

function var_0_0.runningUpdate(arg_49_0)
	return
end

function var_0_0.onGameOver(arg_50_0)
	if arg_50_0.settlementFlag then
		return
	end

	arg_50_0:timerStop()
	arg_50_0:clearGame()

	arg_50_0.settlementFlag = true

	setActive(arg_50_0.clickMask, true)
	LeanTween.delayedCall(go(arg_50_0._tf), 0.1, System.Action(function()
		arg_50_0.settlementFlag = false
		arg_50_0.gameStartFlag = false

		setActive(arg_50_0.clickMask, false)
		arg_50_0.beachGuardUI:updateSettlementUI(arg_50_0:GetMGData(), arg_50_0:GetMGHubData(), arg_50_0.runningData)
		arg_50_0.beachGuardUI:openSettlementUI(true)

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_52_0)
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
	arg_52_0.beachGuardUI:popPauseUI()

	return
end

function var_0_0.clearGame(arg_53_0)
	arg_53_0.sceneMgr:clear()

	return
end

function var_0_0.pauseGame(arg_54_0)
	arg_54_0.gameStop = true

	arg_54_0:changeSpeed(0)
	arg_54_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_55_0)
	arg_55_0.gameStop = false

	arg_55_0:changeSpeed(1)
	arg_55_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_56_0)
	if arg_56_0.readyStartFlag then
		return
	end

	if not arg_56_0.gameStartFlag then
		arg_56_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_56_0.settlementFlag then
			return
		end

		arg_56_0.beachGuardUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_57_0, arg_57_1)
	return
end

function var_0_0.willExit(arg_58_0)
	if arg_58_0.handle then
		UpdateBeat:RemoveListener(arg_58_0.handle)
	end

	if arg_58_0._tf and LeanTween.isTweening(go(arg_58_0._tf)) then
		LeanTween.cancel(go(arg_58_0._tf))
	end

	if arg_58_0.timer and arg_58_0.timer.running then
		arg_58_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_58_0.timer = nil

	arg_58_0:destroyController()
	BeachGuardAsset.clear()

	return
end

function var_0_0.destroyController(arg_59_0)
	return
end

return var_0_0
