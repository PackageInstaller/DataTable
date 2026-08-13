class = var_0_10000

local var_0_0 = var_0_10000("BoatAdGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.menu_bgm = "theme-tempest"
var_0_0.game_bgm = "story-temepest-2"
var_0_0.rule_tip = "BoatAdGame_minigame_help"
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frameRate = var_0_1
var_0_0.ui_atlas = "ui/minigameui/boatadgameui_atlas"
var_0_0.game_ui = "BoatAdGameUI"
var_0_0.game_room_ui = "GameRoomBoatAdUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.SFX_SOUND_SHIBAI = "event:/ui/shibai"
var_0_0.SFX_SOUND_GREAT = "event:/ui/mini_great"
var_0_0.SFX_SOUND_PERFECT = "event:/ui/mini_perfect"
var_0_0.SFX_SOUND_BATTLE = "event:/ui/minigame_hitwood"
var_0_0.use_direct_round = nil
var_0_0.enemyToEndRate = nil
var_0_0.gameTime = 0
var_0_0.gameStepTime = 0
var_0_0.deltaTime = 0

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.game_id = arg_1_0
	var_0_0.hub_id = arg_1_1

	local var_1_0 = var_0_0

	pg = var_1_10003
	var_1_0.total_times = var_1_10003.mini_game_hub[var_0_0.hub_id]

	local var_1_1 = var_0_0

	pg = var_3
	var_1_1.drop = var_3.mini_game[var_0_0.game_id].simple_config_data.drop_ids

	local var_1_2 = var_0_0

	pg = var_3
	var_1_2.total_times = var_3.mini_game_hub[var_0_0.hub_id].reward_need

	return
end

function var_0_0.GetGameMaxTimes()
	local var_2_0 = var_0_0.GetMiniGameHubData()

	return var_0.getConfig(var_2_0, "reward_need")
end

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	local var_4_0

	if not var_0_0.GetMiniGameHubData().usedtime then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_0.GetGameRound()
	if var_0_0.use_direct_round ~= nil then
		return var_0_0.use_direct_round
	end

	if var_0_0.selectRound ~= nil then
		return var_0_0.selectRound
	end

	local var_5_0 = var_0_0.GetGameUseTimes()

	if var_0_0.GetGameTimes() == 0 and var_5_0 == 7 then
		return 8
	end

	if var_1 and var_1 > 0 then
		return var_5_0 + 1
	end

	if var_5_0 and var_5_0 > 0 then
		return var_5_0
	end

	return 1
end

function var_0_0.GetMiniGameData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_6_0 = var_1_10000(var_1_10002)

	return var_0.GetMiniGameData(var_6_0, var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_7_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByHubId(var_7_0, var_0_0.hub_id)
end

var_0_0.char_id = 2
var_0_0.scene_width = 1920
var_0_0.scene_height = 1080
var_0_0.collider_time = 1
var_0_0.colliderDamage = 5
var_0_0.scoreNum = 0
var_0_0.joyStickData = nil
var_0_0.roundData = nil
var_0_0.selectRound = nil
var_0_0.items = {}
var_0_0.enemys = {}
var_0_0.isEndLessRound = false

function var_0_0.Prepare()
	local var_8_0 = var_0_0.GetGameRound()
	local var_8_1 = var_0_0

	BoatAdGameConst = var_1_10002
	var_8_1.gameTime = var_1_10002.game_time[var_8_0]
	var_0_0.gameStepTime = 0
	var_0_0.scoreNum = 0
	var_0_0.isEndLessRound = var_0_0.gameTime > 10000

	local var_8_2 = var_0_0

	BoatAdGameConst = var_2
	var_8_2.roundData = var_2.game_round[var_8_0]

	return
end

function var_0_0.SetGameTpl(arg_9_0)
	var_0_0.tpl = arg_9_0

	return
end

function var_0_0.SetGameBgs(arg_10_0)
	var_0_0.bg = arg_10_0

	return
end

function var_0_0.GetGameBg(arg_11_0)
	return var_0_0.bg
end

function var_0_0.SetGameChar(arg_12_0)
	var_0_0.char = arg_12_0

	return
end

function var_0_0.GetGameChar()
	return var_0_0.char
end

function var_0_0.SetGameItems(arg_14_0)
	var_0_0.items = arg_14_0

	return
end

function var_0_0.GetGameItems()
	return var_0_0.items
end

function var_0_0.SetGameEnemys(arg_16_0)
	var_0_0.enemys = arg_16_0

	return
end

function var_0_0.GetGameEnemys()
	return var_0_0.enemys
end

function var_0_0.GetGameTplTf(arg_18_0)
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_18_0)))
end

function var_0_0.GetRoundData()
	return var_0_0.roundData
end

function var_0_0.PointInRect1(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0
	local var_20_1
	local var_20_2
	local var_20_3
	local var_20_4
	local var_20_5
	local var_20_6 = var_0_0.Sign(arg_20_0, arg_20_1, arg_20_2)
	local var_20_7 = var_0_0.Sign(arg_20_0, arg_20_2, arg_20_3)
	local var_20_8 = var_0_0.Sign(arg_20_0, arg_20_3, arg_20_4)
	local var_20_9 = var_0_0.Sign(arg_20_0, arg_20_4, arg_20_1)
	local var_20_10 = var_20_6 < 0 or var_20_7 < 0 or var_20_8 < 0 or var_20_9 < 0
	local var_20_11 = var_20_6 > 0 or var_20_7 > 0 or var_20_8 > 0 or var_20_9 > 0

	return not var_20_10 or not var_20_11
end

function var_0_0.PointInRect2(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.x < arg_21_1.x or arg_21_0.y < arg_21_1.y then
		return false
	end

	if arg_21_0.x > arg_21_2.x or arg_21_0.y > arg_21_2.y then
		return false
	end

	return true
end

function var_0_0.SetMovePoint(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	var_0_0.lpt1 = arg_22_0
	var_0_0.lpt2 = arg_22_1
	var_0_0.rtp1 = arg_22_2
	var_0_0.rtp2 = arg_22_3

	return
end

function var_0_0.CheckPointOutLeftLine(arg_23_0)
	return var_0_0.PointLeftLine(arg_23_0, var_0_0.lpt1, var_0_0.lpt2)
end

function var_0_0.CheckPointOutRightLine(arg_24_0)
	return var_0_0.PointRightLine(arg_24_0, var_0_0.rtp1, var_0_0.rtp2)
end

function var_0_0.PointLeftLine(arg_25_0, arg_25_1, arg_25_2)
	return (arg_25_2.x - arg_25_1.x) * (arg_25_0.y - arg_25_1.y) - (arg_25_2.y - arg_25_1.y) * (arg_25_0.x - arg_25_1.x) < 0
end

function var_0_0.PointRightLine(arg_26_0, arg_26_1, arg_26_2)
	return (arg_26_2.x - arg_26_1.x) * (arg_26_0.y - arg_26_1.y) - (arg_26_2.y - arg_26_1.y) * (arg_26_0.x - arg_26_1.x) > 0
end

function var_0_0.CheckRectCollider(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0.x
	local var_27_1 = arg_27_0.y
	local var_27_2 = arg_27_2.width
	local var_27_3 = arg_27_2.height
	local var_27_4 = arg_27_1.x
	local var_27_5 = arg_27_1.y
	local var_27_6 = arg_27_3.width
	local var_27_7 = arg_27_3.height

	if var_27_4 <= var_27_0 and var_27_0 >= var_27_4 + var_27_6 then
		return false
	elseif var_27_0 <= var_27_4 and var_27_4 >= var_27_0 + var_27_2 then
		return false
	elseif var_27_5 <= var_27_1 and var_27_1 >= var_27_5 + var_27_7 then
		return false
	elseif var_27_1 <= var_27_5 and var_27_5 >= var_27_1 + var_27_3 then
		return false
	else
		return true
	end

	return
end

function var_0_0.Clear()
	var_0_0.tpl = nil
	var_0_0.char = nil

	return
end

return var_0_0
