class = var_0_10000

local var_0_0 = "Fushun3GameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "fushun_game3_tip"
local var_0_4 = "event:/ui/taosheng"
local var_0_5 = "event:/ui/tiji"
local var_0_6 = "event:/ui/baozha1"
local var_0_7 = "event:/ui/break_out_full"

function var_0_1.getUIName(arg_1_0)
	return "Fushun3GameView"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initEvent()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initGameUI()
	arg_2_0:initController()
	arg_2_0:updateMenuUI()
	arg_2_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	Fushun3GameEvent = var_1_10003

	var_3_1(var_3_0, var_1_10003.create_item_call, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_3_0.itemController then
			local var_4_0 = arg_3_0.itemController

			var_3.createItem(var_4_0, arg_4_1.name, arg_4_1.pos)
		end

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_3(var_3_2, var_3.create_platform_item_call, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_3_0.itemController then
			local var_5_0 = arg_3_0.itemController

			var_3.createPlatformItem(var_5_0, arg_5_1.pos, arg_5_1.id)
		end

		return
	end)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_5(var_3_4, var_3.item_follow_call, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_3_0.itemController then
			local var_6_0 = arg_3_0.itemController

			var_3.itemFollow(var_6_0, arg_6_1.anchoredPos)
		end

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_7(var_3_6, var_3.create_monster_call, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_3_0.monsterController then
			local var_7_0 = arg_3_0.monsterController

			var_3.createMonster(var_7_0, arg_7_1.pos)
		end

		return
	end)

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_9(var_3_8, var_3.player_attack_call, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_3_0.monsterController then
			local var_8_0 = arg_3_0.monsterController
			local var_8_1 = var_3.checkMonsterDamage
			local var_8_2 = arg_8_1.collider
			local var_8_3 = arg_8_1.callback

			Fushun3GameEvent = var_2_10007

			var_8_1(var_8_0, var_8_2, var_8_3, var_2_10007.attack_damdage_monster_call)
		end

		return
	end)

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_11(var_3_10, var_3.char_damaged_call, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_3_0.charController
		local var_9_1 = var_3.getHeart(var_9_0)
		local var_9_2 = arg_3_0

		var_4.updateGameUI(var_9_2)

		if var_9_1 == 0 then
			local var_9_3 = arg_3_0

			var_4.onGameOver(var_9_3)
		end

		return
	end)

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_13(var_3_12, var_3.check_item_damage, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_3_0.monsterController then
			local var_10_0 = arg_3_0.monsterController
			local var_10_1 = var_3.checkMonsterDamage
			local var_10_2 = arg_10_1.collider
			local var_10_3 = arg_10_1.callback

			Fushun3GameEvent = var_2_10007

			var_10_1(var_10_0, var_10_2, var_10_3, var_2_10007.shot_damage_monster_call)
		end

		return
	end)

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_15(var_3_14, var_3.check_player_damage, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_3_0.monsterController then
			local var_11_0 = arg_3_0.monsterController

			var_3.checkPlayerDamage(var_11_0, arg_11_1.tf, arg_11_1.callback)
		end

		return
	end)

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_17(var_3_16, var_3.power_damage_monster_call, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_3_0.monsterController then
			local var_12_0 = arg_3_0.monsterController
			local var_12_1 = var_3.damageMonster
			local var_12_2 = arg_12_1.tf

			Fushun3GameEvent = var_2_10006

			var_12_1(var_12_0, var_12_2, var_2_10006.power_damage_monster_call)
		end

		return
	end)

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_19(var_3_18, var_3.shot_damage_monster_call, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_3_0.monsterController then
			local var_13_0 = arg_3_0.monsterController
			local var_13_1 = var_3.damageMonster
			local var_13_2 = arg_13_1.tf

			Fushun3GameEvent = var_2_10006

			var_13_1(var_13_0, var_13_2, var_2_10006.shot_damage_monster_call)
		end

		return
	end)

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_21(var_3_20, var_3.attack_damdage_monster_call, function(arg_14_0, arg_14_1, arg_14_2)
		if arg_3_0.monsterController then
			local var_14_0 = arg_3_0.monsterController
			local var_14_1 = var_3.damageMonster
			local var_14_2 = arg_14_1.tf

			Fushun3GameEvent = var_2_10006

			var_14_1(var_14_0, var_14_2, var_2_10006.attack_damdage_monster_call)
		end

		return
	end)

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_23(var_3_22, var_3.kick_damage_monster_call, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_3_0.monsterController then
			local var_15_0 = arg_3_0.monsterController
			local var_15_1 = var_3.damageMonster
			local var_15_2 = arg_15_1.tf

			Fushun3GameEvent = var_2_10006

			var_15_1(var_15_0, var_15_2, var_2_10006.kick_damage_monster_call, arg_15_1.callback)
		end

		return
	end)

	local var_3_24 = arg_3_0
	local var_3_25 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_25(var_3_24, var_3.add_anim_effect_call, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_3_0.effectController and arg_16_1 then
			local var_16_0 = arg_3_0.effectController

			var_3.addEffectByAnim(var_16_0, arg_16_1.clipName, arg_16_1.targetTf)
		end

		return
	end)

	local var_3_26 = arg_3_0
	local var_3_27 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_27(var_3_26, var_3.add_effect_call, function(arg_17_0, arg_17_1, arg_17_2)
		if arg_3_0.effectController and arg_17_1 then
			local var_17_0 = arg_3_0.effectController

			var_3.addEffectByName(var_17_0, arg_17_1.effectName, arg_17_1.targetTf)
		end

		return
	end)

	local var_3_28 = arg_3_0
	local var_3_29 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_29(var_3_28, var_3.power_speed_call, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_3_0.platformController then
			local var_18_0 = arg_3_0.platformController

			var_3.onPlayerPower(var_18_0)
		end

		return
	end)

	local var_3_30 = arg_3_0
	local var_3_31 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_31(var_3_30, var_3.add_monster_score_call, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_3_0.charController
		local var_19_1 = var_3.addPower

		Fushun3GameConst = var_2_10005

		var_19_1(var_19_0, var_2_10005.monster_score)

		local var_19_2 = arg_3_0
		local var_19_3 = var_3.addScore

		Fushun3GameConst = var_5

		var_19_3(var_19_2, var_5.monster_score)

		return
	end)

	local var_3_32 = arg_3_0
	local var_3_33 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_33(var_3_32, var_3.game_over_call, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_3_0

		var_3.onGameOver(var_20_0)

		return
	end)

	local var_3_34 = arg_3_0
	local var_3_35 = arg_3_0.bind

	Fushun3GameEvent = var_3

	var_3_35(var_3_34, var_3.day_night_change, function(arg_21_0, arg_21_1, arg_21_2)
		if arg_3_0.platformController then
			local var_21_0 = arg_3_0.platformController

			var_3.updateDayNight(var_21_0)
		end

		return
	end)

	return
end

function var_0_1.onEventHandle(arg_22_0, arg_22_1)
	return
end

function var_0_1.initData(arg_23_0)
	Fushun3GameVo = var_1_10001

	local var_23_0 = var_1_10001.ChangeTimeType

	math = var_1_10002

	if var_1_10002.random() < 0.5 then
		Fushun3GameConst = var_23_1

		local var_23_1

		if not var_23_1.day_type then
			Fushun3GameConst = var_23_1
			var_23_1 = var_23_1.night_type
		end

		var_23_0(var_23_1)

		Fushun3GameVo = var_23_0
		arg_23_0.dayTimeFlag = var_23_0.GetTimeFlag()
		Application = var_1

		local var_23_2

		if not var_1.targetFrameRate then
			var_23_2 = 60
		end

		if 60 < var_23_2 then
			var_23_2 = 60
		end

		Timer = var_2
		arg_23_0.timer = var_2.New(function()
			local var_24_0 = arg_23_0

			var_0.onTimer(var_24_0)

			return
		end, 1 / var_23_2, -1)

		return
	end
end

function var_0_1.initController(arg_25_0)
	findTF = var_1_10001
	arg_25_0.charTf = var_1_10001(arg_25_0._tf, "sceneContainer/scene/char")
	RectCollider = var_1
	arg_25_0.rectCollider = var_1.New(arg_25_0.charTf, {}, arg_25_0)

	local var_25_0 = arg_25_0.rectCollider
	local var_25_1 = var_1.addScript

	FuShunMovementScript = var_3

	var_25_1(var_25_0, var_3.New())

	local var_25_2 = arg_25_0.rectCollider
	local var_25_3 = var_1.addScript

	FuShunAttakeScript = var_3

	var_25_3(var_25_2, var_3.New())

	local var_25_4 = arg_25_0.rectCollider
	local var_25_5 = var_1.addScript

	FuShunJumpScript = var_3

	var_25_5(var_25_4, var_3.New())

	local var_25_6 = arg_25_0.rectCollider
	local var_25_7 = var_1.addScript

	FuShunPowerSpeedScript = var_3

	var_25_7(var_25_6, var_3.New())

	local var_25_8 = arg_25_0.rectCollider
	local var_25_9 = var_1.addScript

	FuShunDamageScript = var_3

	var_25_9(var_25_8, var_3.New())

	findTF = var_25_9

	local var_25_10 = var_25_9(arg_25_0._tf, "tpls/platformTpls")

	findTF = var_2

	local var_25_11 = var_2(arg_25_0.sceneTf, "platform/content")

	Fushun3PlatformControll = var_3
	arg_25_0.platformController = var_3.New(arg_25_0.sceneTf, var_25_10, var_25_11, arg_25_0)
	Fushun3SceneController = var_3
	arg_25_0.sceneController = var_3.New(arg_25_0.backSceneTf, arg_25_0.sceneTf, arg_25_0.charTf)

	local var_25_12 = arg_25_0.rectCollider
	local var_25_13 = var_3.getCollisionInfo(var_25_12)

	Fushun3CharController = var_25_12
	arg_25_0.charController = var_25_12.New(arg_25_0.rectCollider, arg_25_0.charTf, var_25_13, arg_25_0.powerProgressSlider, arg_25_0)
	findTF = var_4

	local var_25_14 = var_4(arg_25_0._tf, "tpls/itemTpls")

	Fushun3ItemController = var_5
	arg_25_0.itemController = var_5.New(arg_25_0.sceneTf, arg_25_0.charTf, var_25_14, arg_25_0)

	local var_25_15 = arg_25_0.itemController

	var_5.setCallback(var_25_15, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0

		var_2.onControllerCallback(var_26_0, arg_26_0, arg_26_1)

		return
	end)

	findTF = var_5

	local var_25_16 = var_5(arg_25_0._tf, "tpls/bgTpls")

	findTF = var_6

	local var_25_17 = var_6(arg_25_0._tf, "tpls/fireTpls")

	findTF = var_7

	local var_25_18 = var_7(arg_25_0._tf, "tpls/petalTpl")

	Fushun3BgController = var_8
	arg_25_0.bgController = var_8.New(var_25_16, var_25_17, var_25_18, arg_25_0.backSceneTf, arg_25_0)
	findTF = var_8

	local var_25_19 = var_8(arg_25_0._tf, "tpls/monsterTpls")

	findTF = var_9

	local var_25_20 = var_9(arg_25_0.sceneTf, "monster")

	Fushun3MonsterController = var_10
	arg_25_0.monsterController = var_10.New(var_25_19, var_25_20, arg_25_0.sceneTf, arg_25_0)
	findTF = var_10

	local var_25_21 = var_10(arg_25_0._tf, "tpls/efTpls")

	findTF = var_11

	local var_25_22 = var_11(arg_25_0.sceneTf, "effect")

	Fushun3EffectController = var_12
	arg_25_0.effectController = var_12.New(var_25_21, var_25_22, arg_25_0)

	return
end

function var_0_1.initUI(arg_27_0)
	findTF = var_1_10001
	arg_27_0.backSceneTf = var_1_10001(arg_27_0._tf, "sceneContainer/scene_background")
	findTF = var_1
	arg_27_0.frontSceneTf = var_1(arg_27_0._tf, "sceneContainer/scene_front")
	findTF = var_1
	arg_27_0.sceneTf = var_1(arg_27_0._tf, "sceneContainer/scene")
	findTF = var_1
	arg_27_0.clickMask = var_1(arg_27_0._tf, "clickMask")
	findTF = var_1
	arg_27_0.countUI = var_1(arg_27_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_2

	local var_27_0 = var_2(arg_27_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_27_0.countAnimator = var_1(var_27_0, var_3(var_4))
	GetOrAddComponent = var_1
	findTF = var_27_0

	local var_27_1 = var_27_0(arg_27_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_27_0.countDft = var_1(var_27_1, var_3(var_4))

	local var_27_2 = arg_27_0.countDft

	var_1.SetTriggerEvent(var_27_2, function()
		return
	end)

	local var_27_3 = arg_27_0.countDft

	var_1.SetEndEvent(var_27_3, function()
		setActive = var_2_10000

		var_2_10000(arg_27_0.countUI, false)

		local var_29_0 = arg_27_0

		var_0.gameStart(var_29_0)

		return
	end)

	SetActive = var_1

	var_1(arg_27_0.countUI, false)

	findTF = var_1
	arg_27_0.leaveUI = var_1(arg_27_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_27_4 = arg_27_0

	findTF = var_3

	local var_27_5 = var_3(arg_27_0.leaveUI, "ad/btnOk")

	local function var_27_6()
		local var_30_0 = arg_27_0

		var_0.resumeGame(var_30_0)

		local var_30_1 = arg_27_0

		var_0.onGameOver(var_30_1)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_27_4, var_27_5, var_27_6, var_5)

	onButton = var_1

	local var_27_7 = arg_27_0

	findTF = var_27_5

	local var_27_8 = var_27_5(arg_27_0.leaveUI, "ad/btnCancel")

	local function var_27_9()
		local var_31_0 = arg_27_0

		var_0.resumeGame(var_31_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_27_7, var_27_8, var_27_9, var_5)

	SetActive = var_1

	var_1(arg_27_0.leaveUI, false)

	findTF = var_1
	arg_27_0.pauseUI = var_1(arg_27_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_27_10 = arg_27_0

	findTF = var_3

	local var_27_11 = var_3(arg_27_0.pauseUI, "ad/btnOk")

	local function var_27_12()
		setActive = var_2_10000

		var_2_10000(arg_27_0.pauseUI, false)

		local var_32_0 = arg_27_0

		var_0.resumeGame(var_32_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_27_10, var_27_11, var_27_12, var_5)

	SetActive = var_1

	var_1(arg_27_0.pauseUI, false)

	findTF = var_1
	arg_27_0.settlementUI = var_1(arg_27_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_27_13 = arg_27_0

	findTF = var_3

	local var_27_14 = var_3(arg_27_0.settlementUI, "ad/btnOver")

	local function var_27_15()
		setActive = var_2_10000

		var_2_10000(arg_27_0.settlementUI, false)

		local var_33_0 = arg_27_0

		var_0.openMenuUI(var_33_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_27_13, var_27_14, var_27_15, var_5)

	SetActive = var_1

	var_1(arg_27_0.settlementUI, false)

	findTF = var_1
	arg_27_0.menuUI = var_1(arg_27_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_2

	local var_27_16 = var_2(arg_27_0.menuUI, "battList")

	typeof = var_3
	ScrollRect = var_4
	arg_27_0.battleScrollRect = var_1(var_27_16, var_3(var_4))
	arg_27_0.totalTimes = arg_27_0:getGameTotalTime()

	local var_27_17, var_27_18

	if arg_27_0:getGameUsedTimes() - 4 < 0 then
		var_27_17 = 0
	else
		var_27_18 = arg_27_0
		var_27_17 = arg_27_0.getGameUsedTimes(var_27_18) - 4
	end

	scrollTo = var_27_18

	var_27_18(arg_27_0.battleScrollRect, 0, 1 - var_27_17 / (arg_27_0.totalTimes - 4))

	onButton = var_27_18

	local var_27_19 = arg_27_0

	findTF = var_4

	local var_27_20 = var_4(arg_27_0.menuUI, "rightPanelBg/arrowUp")

	local function var_27_21()
		local var_34_0 = arg_27_0.battleScrollRect.normalizedPosition.y + 1 / (arg_27_0.totalTimes - 4)

		if 1 < var_34_0 then
			var_34_0 = 1
		end

		scrollTo = var_1

		var_1(arg_27_0.battleScrollRect, 0, var_34_0)

		return
	end

	SFX_CANCEL = var_6

	var_27_18(var_27_19, var_27_20, var_27_21, var_6)

	onButton = var_27_18

	local var_27_22 = arg_27_0

	findTF = var_27_20

	local var_27_23 = var_27_20(arg_27_0.menuUI, "rightPanelBg/arrowDown")

	local function var_27_24()
		local var_35_0

		if arg_27_0.battleScrollRect.normalizedPosition.y - 1 / (arg_27_0.totalTimes - 4) < 0 then
			var_35_0 = 0
		end

		scrollTo = var_1

		var_1(arg_27_0.battleScrollRect, 0, var_35_0)

		return
	end

	SFX_CANCEL = var_6

	var_27_18(var_27_22, var_27_23, var_27_24, var_6)

	onButton = var_27_18

	local var_27_25 = arg_27_0

	findTF = var_27_23

	local var_27_26 = var_27_23(arg_27_0.menuUI, "btnBack")

	local function var_27_27()
		local var_36_0 = arg_27_0

		var_0.closeView(var_36_0)

		return
	end

	SFX_CANCEL = var_6

	var_27_18(var_27_25, var_27_26, var_27_27, var_6)

	onButton = var_27_18

	local var_27_28 = arg_27_0

	findTF = var_27_26

	local var_27_29 = var_27_26(arg_27_0.menuUI, "btnRule")

	local function var_27_30()
		pg = var_2_10000

		local var_37_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_37_1 = var_0.ShowMsgBox
		local var_37_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_37_2.type = var_2_10003
		pg = var_2_10003
		var_37_2.helps = var_2_10003.gametip[var_0_3].tip

		var_37_1(var_37_0, var_37_2)

		return
	end

	SFX_CANCEL = var_6

	var_27_18(var_27_28, var_27_29, var_27_30, var_6)

	onButton = var_27_18

	local var_27_31 = arg_27_0

	findTF = var_27_29

	local var_27_32 = var_27_29(arg_27_0.menuUI, "btnStart")

	local function var_27_33()
		setActive = var_2_10000

		var_2_10000(arg_27_0.menuUI, false)

		local var_38_0 = arg_27_0

		var_0.readyStart(var_38_0)

		return
	end

	SFX_CANCEL = var_6

	var_27_18(var_27_31, var_27_32, var_27_33, var_6)

	findTF = var_27_18

	local var_27_34 = var_27_18(arg_27_0.menuUI, "tplBattleItem")

	arg_27_0.battleItems = {}
	arg_27_0.dropItems = {}

	for iter_27_0 = 1, 7 do
		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(var_27_34))
		var_1_10007.name = "battleItem_" .. iter_27_0
		setParent = var_1_10008

		local var_27_35 = var_1_10007

		findTF = var_1_10010

		var_1_10008(var_27_35, var_1_10010(arg_27_0.menuUI, "battList/Viewport/Content"))

		var_1_10008 = iter_27_0
		GetSpriteFromAtlasAsync = var_27_35

		var_27_35("ui/minigameui/fushun3gameui_atlas", "battleDesc" .. var_1_10008, function(arg_39_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10007, "state_open/buttomDesc"), arg_39_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_clear/buttomDesc"), arg_39_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_current/buttomDesc"), arg_39_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_closed/buttomDesc"), arg_39_0, true)

			return
		end)

		setActive = var_27_35

		var_27_35(var_1_10007, true)

		table = var_27_35

		var_27_35.insert(arg_27_0.battleItems, var_1_10007)
	end

	if not arg_27_0.handle then
		UpdateBeat = var_3
		arg_27_0.handle = var_3:CreateListener(arg_27_0.Update, arg_27_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_27_0.handle)

	return
end

function var_0_1.initGameUI(arg_40_0)
	findTF = var_1_10001
	arg_40_0.gameUI = var_1_10001(arg_40_0._tf, "ui/gameUI")
	findTF = var_1
	arg_40_0.powerProgress = var_1(arg_40_0.gameUI, "top/powerProgress")
	GetComponent = var_1

	local var_40_0 = arg_40_0.powerProgress

	typeof = var_3
	Slider = var_1_10004
	arg_40_0.powerProgressSlider = var_1(var_40_0, var_3(var_1_10004))
	onButton = var_1

	local var_40_1 = arg_40_0

	findTF = var_3

	var_1(var_40_1, var_3(arg_40_0.gameUI, "topRight/btnStop"), function()
		local var_41_0 = arg_40_0

		var_0.stopGame(var_41_0)

		setActive = var_0

		var_0(arg_40_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_40_2 = arg_40_0

	findTF = var_3

	var_1(var_40_2, var_3(arg_40_0.gameUI, "btnLeave"), function()
		local var_42_0 = arg_40_0

		var_0.stopGame(var_42_0)

		setActive = var_0

		var_0(arg_40_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_40_0.gameTimeS = var_1(arg_40_0.gameUI, "top/time/s")
	findTF = var_1
	arg_40_0.scoreTf = var_1(arg_40_0.gameUI, "top/score")
	arg_40_0.hearts = {}

	local var_40_3 = 1

	Fushun3GameConst = var_2

	for iter_40_0 = var_40_3, var_2.heart_num do
		table = var_40_4

		local var_40_4 = var_40_4.insert
		local var_40_5 = arg_40_0.hearts

		findTF = var_1_10007

		var_40_4(var_40_5, var_1_10007(arg_40_0.gameUI, "top/heart" .. iter_40_0 .. "/full"))
	end

	GetOrAddComponent = var_40_3
	findTF = var_2
	arg_40_0.atkDelegate = var_40_3(var_2(arg_40_0.gameUI, "btnAtk"), "EventTriggerListener")
	arg_40_0.atkDelegate.enabled = true

	local var_40_6 = arg_40_0.atkDelegate

	var_1.AddPointDownFunc(var_40_6, function(arg_43_0, arg_43_1)
		if arg_40_0.charController then
			local var_43_0 = arg_40_0.charController

			var_2.attack(var_43_0)
		end

		return
	end)

	GetOrAddComponent = var_1
	findTF = var_40_6
	arg_40_0.jumpDelegate = var_1(var_40_6(arg_40_0.gameUI, "btnJump"), "EventTriggerListener")
	arg_40_0.jumpDelegate.enabled = true

	local var_40_7 = arg_40_0.jumpDelegate

	var_1.AddPointDownFunc(var_40_7, function(arg_44_0, arg_44_1)
		if arg_40_0.charController then
			local var_44_0 = arg_40_0.charController

			var_2.jump(var_44_0)
		end

		return
	end)

	setText = var_1
	findTF = var_40_7

	local var_40_8 = var_40_7(arg_40_0._tf, "pop/LeaveUI/ad/desc/n")

	i18n = var_3
	Fushun3GameConst = var_4

	var_1(var_40_8, var_3(var_4.mini_game_leave))

	setText = var_1
	findTF = var_40_8

	local var_40_9 = var_40_8(arg_40_0._tf, "pop/pauseUI/ad/desc/n")

	i18n = var_3
	Fushun3GameConst = var_4

	var_1(var_40_9, var_3(var_4.mini_game_pause))

	return
end

function var_0_1.Update(arg_45_0)
	arg_45_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_46_0)
	if arg_46_0.gameStop or arg_46_0.settlementFlag then
		return
	end

	Application = var_1

	if var_1.isEditor then
		-- block empty
	end

	return
end

function var_0_1.updateMenuUI(arg_47_0)
	local var_47_0 = arg_47_0:getGameUsedTimes()
	local var_47_1 = arg_47_0:getGameTimes()

	for iter_47_0 = 1, #arg_47_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "bg/n"), not arg_47_0.dayTimeFlag)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "bg/d"), arg_47_0.dayTimeFlag)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_current"), false)

		if iter_47_0 <= var_47_0 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_clear"), true)
		elseif iter_47_0 == var_47_0 + 1 and 1 <= var_47_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_current"), true)
		elseif var_47_0 < iter_47_0 and iter_47_0 <= var_47_0 + var_47_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_47_0.battleItems[iter_47_0], "state_closed"), true)
		end
	end

	arg_47_0.totalTimes = arg_47_0:getGameTotalTime()

	local var_47_2 = 1 - (arg_47_0:getGameUsedTimes() - 3 < 0 and 0 or arg_47_0:getGameUsedTimes() - 3) / (arg_47_0.totalTimes - 4)

	if 1 < var_47_2 then
		var_47_2 = 1
	end

	scrollTo = var_5

	var_5(arg_47_0.battleScrollRect, 0, var_47_2)

	setActive = var_5
	findTF = var_6

	var_5(var_6(arg_47_0.menuUI, "btnStart/tip"), var_47_1 > 0)
	arg_47_0:CheckGet()
	arg_47_0:updateDayNightUI()

	return
end

function var_0_1.CheckGet(arg_48_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_48_0.menuUI, "got"), false)

	if arg_48_0:getUltimate() then
		local var_48_0 = arg_48_0

		if arg_48_0.getUltimate(var_48_0) ~= 0 then
			setActive = var_1
			findTF = var_48_0

			var_1(var_48_0(arg_48_0.menuUI, "got"), true)
		end
	end

	if arg_48_0:getUltimate() == 0 then
		local var_48_1 = arg_48_0:getGameTotalTime()
		local var_48_2 = arg_48_0

		if var_48_1 > arg_48_0.getGameUsedTimes(var_48_2) then
			return
		end

		pg = var_48_2

		local var_48_3 = var_48_2.m02
		local var_48_4 = var_3.sendNotification

		GAME = var_1_10005

		local var_48_5 = var_1_10005.SEND_MINI_GAME_OP
		local var_48_6 = {
			hubid = arg_48_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_48_6.cmd = var_7.CMD_ULTIMATE
		var_48_6.args1 = {}

		var_48_4(var_48_3, var_48_5, var_48_6)

		setActive = var_48_4
		findTF = var_48_3

		var_48_4(var_48_3(arg_48_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_49_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_49_0._tf, "sceneContainer/scene_front"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_49_0._tf, "sceneContainer/scene_background"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_49_0._tf, "sceneContainer/scene"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_49_0._tf, "bg"), true)

	setActive = var_1_10001

	var_1_10001(arg_49_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_49_0.menuUI, true)
	arg_49_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_50_0)
	setActive = var_1_10001

	var_1_10001(arg_50_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_50_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_50_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_50_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_50_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_51_0)
	setActive = var_1_10001

	var_1_10001(arg_51_0.countUI, true)

	local var_51_0 = arg_51_0.countAnimator

	var_1.Play(var_51_0, "count")

	pg = var_1

	local var_51_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_51_1, var_0_2)

	return
end

function var_0_1.gameStart(arg_52_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_52_0._tf, "sceneContainer/scene_front"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_52_0._tf, "sceneContainer/scene_background"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_52_0._tf, "sceneContainer/scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_52_0.gameUI, true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_52_0._tf, "bg"), false)

	arg_52_0.gameStartFlag = true
	arg_52_0.scoreNum = 0
	arg_52_0.playerPosIndex = 2
	arg_52_0.gameStepTime = 0
	arg_52_0.gameOverTime = 0
	Fushun3GameConst = var_1
	arg_52_0.gameTime = var_1.game_time
	Fushun3GameConst = var_1
	arg_52_0.gameLevelTime = var_1.level_time

	local var_52_0 = arg_52_0.rectCollider
	local var_52_1 = var_1.getCollisionInfo(var_52_0).config

	Fushun3GameConst = var_52_0
	var_52_1.moveSpeed = var_52_0.move_speed

	local var_52_2 = arg_52_0.rectCollider

	var_1.start(var_52_2)

	local var_52_3 = arg_52_0.platformController

	var_1.start(var_52_3)

	local var_52_4 = arg_52_0.sceneController

	var_1.start(var_52_4)

	local var_52_5 = arg_52_0.charController

	var_1.start(var_52_5)

	local var_52_6 = arg_52_0.itemController

	var_1.start(var_52_6)

	local var_52_7 = arg_52_0.bgController

	var_1.start(var_52_7)

	local var_52_8 = arg_52_0.monsterController

	var_1.start(var_52_8)

	local var_52_9 = arg_52_0.effectController

	var_1.start(var_52_9)
	arg_52_0:updateGameUI()
	arg_52_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_53_0)
	return arg_53_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_54_0)
	return arg_54_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_55_0)
	return arg_55_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_56_0)
	local var_56_0 = arg_56_0:GetMGHubData()

	return (var_1.getConfig(var_56_0, "reward_need"))
end

function var_0_1.updateDayNightUI(arg_57_0)
	Fushun3GameVo = var_1_10001
	arg_57_0.dayTimeFlag = var_1_10001.GetTimeFlag()
	setActive = var_1
	findTF = var_1_10002

	var_1(var_1_10002(arg_57_0._tf, "bg/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0._tf, "bg/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "bg/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "bg/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "btnBack/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "btnBack/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "title/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "title/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "desc/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "desc/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "got/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "got/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "btnRule/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "btnRule/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "rightPanelBg/arrowUp/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "rightPanelBg/arrowUp/d"), arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "rightPanelBg/arrowDown/n"), not arg_57_0.dayTimeFlag)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_57_0.menuUI, "rightPanelBg/arrowDown/d"), arg_57_0.dayTimeFlag)

	local var_57_0 = true

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.countUI, "bgCount/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.countUI, "bgCount/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/img/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/img/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/btnOk/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/btnOk/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/desc/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.leaveUI, "ad/desc/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/img/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/img/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/btnOk/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/btnOk/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/desc/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.pauseUI, "ad/desc/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/img/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/img/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/imgScore/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/imgScore/d"), var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/imgHigh/n"), not var_57_0)

	setActive = var_57_1
	findTF = var_3

	var_57_1(var_3(arg_57_0.settlementUI, "ad/bg/imgHigh/d"), var_57_0)

	if var_57_0 then
		Color = var_57_1

		local var_57_1

		if not var_57_1.New(1, 0.9686274509803922, 0.9215686274509803, 1) then
			Color = var_57_1
			var_57_1 = var_57_1.New(0.8549019607843137, 0.807843137254902, 1, 1)
		end

		setTextColor = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.settlementUI, "ad/currentText"), var_57_1)

		setTextColor = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.settlementUI, "ad/highText"), var_57_1)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/powerProgress/content/bg/n"), not var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/powerProgress/content/bg/d"), var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/powerProgress/full/n"), not var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/powerProgress/full/d"), var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/split/n"), not var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/split/d"), var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/scoreImg/n"), not var_57_0)

		setActive = var_57_2
		findTF = var_4

		var_57_2(var_4(arg_57_0.gameUI, "top/scoreImg/d"), var_57_0)

		if var_57_0 then
			Color = var_57_2

			local var_57_2

			if not var_57_2.New(0.9215686274509803, 0.8745098039215686, 0.7725490196078432, 1) then
				Color = var_57_2
				var_57_2 = var_57_2.New(0.8, 0.7372549019607844, 0.8392156862745098, 1)
			end

			setTextColor = var_4
			findTF = var_5

			var_4(var_5(arg_57_0.gameUI, "top/score"), var_57_2)

			setActive = var_4
			findTF = var_5

			var_4(var_5(arg_57_0.gameUI, "topRight/btnStop/n"), not var_57_0)

			setActive = var_4
			findTF = var_5

			var_4(var_5(arg_57_0.gameUI, "topRight/btnStop/d"), var_57_0)

			setActive = var_4
			findTF = var_5

			var_4(var_5(arg_57_0.gameUI, "btnLeave/n"), not var_57_0)

			setActive = var_4
			findTF = var_5

			var_4(var_5(arg_57_0.gameUI, "btnLeave/d"), var_57_0)

			local var_57_3 = 1

			Fushun3GameConst = var_5

			for iter_57_0 = var_57_3, var_5.heart_num do
				findTF = var_1_10008
				var_1_10008 = var_1_10008(arg_57_0.gameUI, "top/heart" .. iter_57_0 .. "")
				setActive = var_9
				findTF = var_10

				var_9(var_10(var_1_10008, "img/n"), not var_57_0)

				setActive = var_9
				findTF = var_10

				var_9(var_10(var_1_10008, "img/d"), var_57_0)

				setActive = var_9
				findTF = var_10

				var_9(var_10(var_1_10008, "full/n"), not var_57_0)

				setActive = var_9
				findTF = var_10

				var_9(var_10(var_1_10008, "full/d"), var_57_0)
			end

			return
		end
	end
end

function var_0_1.onTimer(arg_58_0)
	arg_58_0:gameStep()

	return
end

function var_0_1.gameStep(arg_59_0)
	local var_59_0 = arg_59_0.gameOverTime

	Time = var_1_10002
	arg_59_0.gameOverTime = var_59_0 + var_1_10002.deltaTime

	local var_59_1 = arg_59_0.gameTime

	Time = var_2
	arg_59_0.gameTime = var_59_1 - var_2.deltaTime

	if arg_59_0.gameTime < 0 then
		arg_59_0.gameTime = 0
	end

	local var_59_2 = arg_59_0.gameStepTime

	Time = var_2
	arg_59_0.gameStepTime = var_59_2 + var_2.deltaTime

	local var_59_3 = arg_59_0.gameLevelTime

	if 0 < var_59_3 then
		local var_59_4 = arg_59_0.gameLevelTime

		Time = var_2
		arg_59_0.gameLevelTime = var_59_4 - var_2.deltaTime

		if arg_59_0.gameLevelTime <= 0 then
			Fushun3GameConst = var_1
			arg_59_0.gameLevelTime = var_1.level_time

			local var_59_5 = arg_59_0.platformController

			var_1.levelUp(var_59_5)
		end
	end

	local var_59_6 = arg_59_0.rectCollider

	var_1.step(var_59_6)

	local var_59_7 = arg_59_0.platformController

	var_1.step(var_59_7)

	local var_59_8 = arg_59_0.sceneController

	var_1.step(var_59_8)

	local var_59_9 = arg_59_0.charController

	var_1.step(var_59_9)

	local var_59_10 = arg_59_0.itemController

	var_1.step(var_59_10)

	local var_59_11 = arg_59_0.bgController

	var_1.step(var_59_11)

	local var_59_12 = arg_59_0.monsterController

	var_1.step(var_59_12)

	local var_59_13 = arg_59_0.effectController

	var_1.step(var_59_13)
	arg_59_0:updateGameUI()

	if arg_59_0.gameTime <= 0 then
		arg_59_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_60_0)
	if not arg_60_0.timer.running then
		local var_60_0 = arg_60_0.timer

		var_1.Start(var_60_0)
	end

	return
end

function var_0_1.timerStop(arg_61_0)
	if arg_61_0.timer.running then
		local var_61_0 = arg_61_0.timer

		var_1.Stop(var_61_0)
	end

	return
end

function var_0_1.updateGameUI(arg_62_0)
	local var_62_0 = arg_62_0.charController
	local var_62_1 = var_1.getHeart(var_62_0)

	for iter_62_0 = 1, #arg_62_0.hearts do
		local var_62_2 = arg_62_0.hearts[iter_62_0]

		if iter_62_0 <= var_62_1 then
			setActive = var_1_10007

			var_1_10007(var_62_2, true)
		else
			setActive = var_1_10007

			var_1_10007(var_62_2, false)
		end
	end

	setText = var_2

	var_2(arg_62_0.scoreTf, arg_62_0.scoreNum)

	setText = var_2

	local var_62_3 = arg_62_0.gameTimeS

	math = var_4

	var_2(var_62_3, var_4.ceil(arg_62_0.gameTime))

	return
end

function var_0_1.addScore(arg_63_0, arg_63_1)
	arg_63_0.scoreNum = arg_63_0.scoreNum + arg_63_1

	if arg_63_0.scoreNum < 0 then
		arg_63_0.scoreNum = 0
	end

	return
end

function var_0_1.onControllerCallback(arg_64_0, arg_64_1, arg_64_2)
	Fushun3GameEvent = var_1_10003

	if arg_64_1 == var_1_10003.catch_item_call then
		local var_64_0 = arg_64_2.data.type

		Fushun3GameConst = var_1_10005

		if var_64_0 == var_1_10005.item_type_score then
			arg_64_0:addScore(var_3.score)

			local var_64_1 = arg_64_0.charController

			var_64_0.addPower(var_64_1, var_3.score)
		else
			pg = var_64_0

			local var_64_2 = var_64_0.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_64_2, var_0_7)

			local var_64_3 = arg_64_0.charController

			var_4.setBuff(var_64_3, var_3)
		end
	end

	return
end

function var_0_1.onGameOver(arg_65_0)
	if arg_65_0.settlementFlag then
		return
	end

	arg_65_0:timerStop()

	arg_65_0.settlementFlag = true
	setActive = var_1

	var_1(arg_65_0.clickMask, true)

	LeanTween = var_1

	local var_65_0 = var_1.delayedCall

	go = var_2

	local var_65_1 = var_2(arg_65_0._tf)
	local var_65_2 = 1

	System = var_1_10004

	var_65_0(var_65_1, var_65_2, var_1_10004.Action(function()
		arg_65_0.settlementFlag = false

		local var_66_0 = arg_65_0

		var_66_0.gameStartFlag = false
		setActive = var_66_0

		var_66_0(arg_65_0.clickMask, false)

		local var_66_1 = arg_65_0

		var_0.showSettlement(var_66_1)

		return
	end))

	pg = var_65_0

	local var_65_3 = var_65_0.m02
	local var_65_4 = var_1.sendNotification

	GAME = var_65_2

	local var_65_5 = var_65_2.MINI_GAME_TIME
	local var_65_6 = {
		id = arg_65_0:GetMGData().id
	}

	math = var_5
	var_65_6.time = var_5.ceil(arg_65_0.gameOverTime)

	var_65_4(var_65_3, var_65_5, var_65_6)

	return
end

function var_0_1.showSettlement(arg_67_0)
	setActive = var_1_10001

	var_1_10001(arg_67_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_67_0 = var_2(arg_67_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_67_1 = var_1_10001(var_67_0, var_3(var_4))

	var_1.Play(var_67_1, "settlement", -1, 0)

	local var_67_2 = arg_67_0:GetMGData()
	local var_67_3 = var_2.GetRuntimeData(var_67_2, "elements")
	local var_67_4 = arg_67_0.scoreNum

	if var_67_3 then
		local var_67_5 = #var_67_3
		local var_67_6

		if not (0 < var_67_5) or not var_67_3[1] then
			var_67_6 = 0
		end

		setActive = var_5
		findTF = var_6

		var_5(var_6(arg_67_0.settlementUI, "ad/new"), var_67_6 < var_67_4)

		if var_67_6 <= var_67_4 then
			var_67_6 = var_67_4

			arg_67_0:StoreDataToServer({
				var_67_6
			})
		end

		findTF = var_5

		local var_67_7 = var_5(arg_67_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_67_8 = var_6(arg_67_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_67_7, var_67_6)

		setText = var_7

		var_7(var_67_8, var_67_4)

		if arg_67_0:getGameTimes() and arg_67_0:getGameTimes() > 0 then
			arg_67_0.sendSuccessFlag = true

			arg_67_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_68_0)
	arg_68_0.gameStop = false
	setActive = var_1

	var_1(arg_68_0.leaveUI, false)
	arg_68_0:timerStart()

	return
end

function var_0_1.stopGame(arg_69_0)
	arg_69_0.gameStop = true

	arg_69_0:timerStop()

	return
end

function var_0_1.onBackPressed(arg_70_0)
	if not arg_70_0.gameStartFlag then
		arg_70_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_70_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_70_0.pauseUI) then
			setActive = var_1

			var_1(arg_70_0.pauseUI, false)
		end

		arg_70_0:stopGame()

		setActive = var_1

		var_1(arg_70_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_71_0)
	if arg_71_0.charController then
		var_1_10002 = arg_71_0.charController

		var_1.dispose(var_1_10002)
	end

	if arg_71_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_71_0.handle)
	end

	if arg_71_0._tf then
		LeanTween = var_1

		local var_71_0 = var_1.isTweening

		go = var_1_10002

		if var_71_0(var_1_10002(arg_71_0._tf)) then
			LeanTween = var_1

			local var_71_1 = var_1.cancel

			go = var_2

			var_71_1(var_2(arg_71_0._tf))
		end
	end

	if arg_71_0.timer and arg_71_0.timer.running then
		local var_71_2 = arg_71_0.timer

		var_1.Stop(var_71_2)
	end

	if arg_71_0.atkDelegate then
		ClearEventTrigger = var_1

		var_1(arg_71_0.atkDelegate)
	end

	if arg_71_0.jumpDelegate then
		ClearEventTrigger = var_1

		var_1(arg_71_0.jumpDelegate)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_71_0.timer = nil

	local var_71_3 = arg_71_0.rectCollider

	var_1.clear(var_71_3)

	return
end

return var_0_1
