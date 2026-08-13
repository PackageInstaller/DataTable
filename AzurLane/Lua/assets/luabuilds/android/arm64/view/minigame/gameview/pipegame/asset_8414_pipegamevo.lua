class = var_0_10000

local var_0_0 = var_0_10000("PipeGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.menu_bgm = "story-richang-3"
var_0_0.game_bgm = "story-richang-3"
var_0_0.game_time = 0
var_0_0.rule_tip = "pipe_minigame_help"
var_0_0.rank_tip = "pipe_minigame_rank"
var_0_0.game_drag_time = 300
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frameRate = var_0_1
var_0_0.ui_atlas = "ui/minigameui/pipegameui_atlas"
var_0_0.game_ui = "PipeGameUI"
var_0_0.game_room_ui = "GameRoomPipeUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.SFX_SOUND_FIRE = "event:/ui/kaipao"
var_0_0.SFX_SOUND_BOOM = "event:/ui/baozha3"
var_0_0.SFX_SOUND_SKILL = "event:/ui/chongneng"
var_0_0.SFX_SOUND_ITEM = "event:/ui/mini_shine"
var_0_0.use_direct_round = nil
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

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	local var_3_0

	if not var_0_0.GetMiniGameHubData().usedtime then
		var_3_0 = 0
	end

	return var_3_0
end

function var_0_0.GetGameRound()
	if var_0_0.use_direct_round ~= nil then
		return var_0_0.use_direct_round
	end

	if var_0_0.selectRound ~= nil then
		return var_0_0.selectRound
	end

	local var_4_0 = var_0_0.GetGameUseTimes()

	if var_0_0.GetGameTimes() and var_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.GetMiniGameData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)

	return var_0.GetMiniGameData(var_5_0, var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_6_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByHubId(var_6_0, var_0_0.hub_id)
end

var_0_0.scoreNum = 0
var_0_0.roundData = nil
var_0_0.selectRound = nil
var_0_0.tplItemPool = {}
var_0_0.draging = false
Vector2 = var_1
var_0_0.dragScreenPos = var_1(0, 0)
var_0_0.dragItem = nil
var_0_0.gameDragTime = nil
var_0_0.startSettlement = false

function var_0_0.Prepare()
	var_0_0.gameTime = var_0_0.game_time
	var_0_0.gameDragTime = var_0_0.game_drag_time
	var_0_0.gameStepTime = 0
	var_0_0.scoreNum = 0
	var_0_0.draging = false

	local var_7_0 = var_0_0

	Vector2 = var_1
	var_7_0.dragScreenPos = var_1(0, 0)
	var_0_0.dragItem = nil

	local var_7_1 = var_0_0

	PipeGameConst = var_1
	var_7_1.roundData = var_1.game_round[var_0_0.GetGameRound()]

	local var_7_2 = var_0_0

	Vector2 = var_1
	var_7_2.sceneSpeed = var_1(0, 0)
	var_0_0.startSettlement = false

	return
end

function var_0_0.SetGameTpl(arg_8_0)
	var_0_0.tpl = arg_8_0

	return
end

function var_0_0.GetTplItemFromPool(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return nil
	end

	if var_0_0.tplItemPool[arg_9_0] == nil then
		var_0_0.tplItemPool[arg_9_0] = {}
	end

	local var_9_0

	if #var_0_0.tplItemPool[arg_9_0] == 0 then
		tf = var_9_0
		instantiate = var_1_10004
		findTF = var_1_10006
		var_9_0 = var_9_0(var_1_10004(var_1_10006(var_0_0.tpl, arg_9_0)))
		setParent = var_1_10003

		var_1_10003(var_9_0, arg_9_1)

		return var_9_0
	else
		table = var_9_0

		return var_9_0.remove(var_0_0.tplItemPool[arg_9_0], #var_0_0.tplItemPool[arg_9_0])
	end

	return
end

function var_0_0.RetTplItem(arg_10_0, arg_10_1)
	local var_10_0

	if var_0_0.tplItemPool[arg_10_0] == nil then
		var_10_0 = var_0_0.tplItemPool
		var_10_0[arg_10_0] = {}
	end

	table = var_10_0

	var_10_0.insert(var_0_0.tplItemPool[arg_10_0], arg_10_1)

	return
end

function var_0_0.GetSprite(arg_11_0)
	GetSpriteFromAtlas = var_1_10001

	return var_1_10001(var_0_0.ui_atlas, arg_11_0)
end

function var_0_0.GetResultLevel()
	if not var_0_0.scoreNum or var_0_0.scoreNum == 0 then
		return 1
	end

	PipeGameConst = var_0

	for iter_12_0 = #var_0.game_result_level, 1, -1 do
		local var_12_0 = var_0_0.scoreNum

		PipeGameConst = var_1_10005

		if var_1_10005.game_result_level[iter_12_0] <= var_12_0 then
			return iter_12_0
		end
	end

	return 1
end

function var_0_0.GetRoundData()
	return var_0_0.roundData
end

function var_0_0.Clear()
	var_0_0.tpl = nil
	var_0_0.char = nil

	return
end

return var_0_0
