local var_0_0 = {}

var_0_0.GAME_ID = 89
var_0_0.menu_bgm = "story-richang-6"
var_0_0.game_bgm = "story-richang-6"
var_0_0.ui_atlas = "ui/minigameui/crossroadgameui_atlas"
var_0_0.game_ui = "CrossRoadGameUI"
var_0_0.RECODE_NONE = "你怎么还一把没玩过/n快去启动！！！"
var_0_0.RECODE_NORMAL = "你上次记录的分数是"
var_0_0.GET_SCORE = "CrossRoadGameScene:GET_SCORE"
var_0_0.HIT_ROLER = "CrossRoadGameScene:HIT_ROLER"
var_0_0.GET_HONGCHA = "CrossRoadGameScene: GET_HONGCHA"
var_0_0.BACK_ROAD_NAME = "back_raod_name"
var_0_0.SCENE_ROAD_NAME = "scene_road_name"
var_0_0.FRONT_ROAD_NAME = "front_road_name"
var_0_0.SP_ROAD_NAME = "sp_raod_name"
var_0_0.NEW_ROUND = "NEW_ROUND"
var_0_0.MAKE_BING_MIAN = "make bing mian"
var_0_0.MAKE_XUAN_WO = "make xuan wo"
var_0_0.ADD_ROLE = "add role"
var_0_0.DISPOSE_BIN = "dispose bin"
var_0_0.XINZEXI = 102
var_0_0.BING_MIAN = 3
var_0_0.XUAN_WO = 2
var_0_0.EPS = 0.001
var_0_0.GAME_TIME = 0
var_0_0.GAME_TRACK_COUNT = 6
var_0_0.FIRST_CAR_TIQIAN_TIME = -5
var_0_0.START_CAR_SCALE = 0.5
var_0_0.ADD_CAR_SCALE = 0.7
var_0_0.WALKER_LINE_UNNDER = 250
var_0_0.WALKER_GO_AGIN_TIME = 5
var_0_0.CAR_SPEED_SCALE = 0.4
var_0_0.PLAYER_DISTANCE = 200
var_0_0.SHOW_GROUP_TIME = 5
var_0_0.PLAYER_SELECT_TIME = 0.5
var_0_0.CAN_ANGRY_TIME = 5
var_0_0.ONCE_ANGRY_TIME = 2
var_0_0.XUANWO_STOP_PERCENT = 40
var_0_0.HONGCHA_PERCENT = 100
var_0_0.SP_CAR_ID = {
	[102] = true,
	[101] = true
}
var_0_0.SHIP_TPL = {
	"aierdeliqi_tpl",
	"edu_tpl",
	"huoli_tpl",
	"kunibeierdi_tpl",
	"lemaer_tpl",
	"maoyue_tpl",
	"muyue_tpl",
	"nubiyaren_tpl",
	"shuiwuyue_tpl",
	"wanpi_tpl",
	"xiaotiane_tpl",
	"yanusi_tpl",
	"yinghuochong_tpl",
	"z19_tpl"
}
var_0_0.CAR_TPL = {
	"daqinghuayu_tpl",
	"xinzexi_tpl",
	"zibao_tpl",
	"jinbi_tpl",
	"yulei_tpl",
	"weixiu_tpl"
}
var_0_0.ITEM_TPL = {
	"hongcha_tpl",
	"xuanwo_tpl",
	"bingmian_tpl"
}
var_0_0.CAR_STATE = {
	going = 4,
	needDestroy = 6,
	goEnd = 5,
	goTrack = 2,
	showBack = 1,
	goSideWalk = 3
}
var_0_0.SHIP_STATE = {
	angry = 3,
	walk = 2,
	crash = 5,
	select = 4,
	stop = 1
}
var_0_0.SHIP_STATE_ACTION = {
	walk = "walk",
	crash = "crash",
	normal = "normal"
}
var_0_0.PLAYER_STATE = {
	stop_walk = "stop_walk",
	recover = "recover",
	crash = "crash",
	stop = "stop",
	walk = "walk",
	sign = "sign",
	sign_walk = "sign_walk",
	normal = "normal"
}
var_0_0.SP_CAR_MOVE = {
	moveEnd = 4,
	start = 1,
	mid = 2
}
var_0_0.COMOBO_TIME = 3
var_0_0.ROLE_COMOBO_LV = {
	2,
	3,
	4
}
var_0_0.SCORE_LIST = {
	50,
	100,
	150,
	200,
	250,
	300,
	350,
	400,
	450,
	500,
	550,
	600,
	650,
	700,
	750,
	800,
	850,
	900
}
var_0_0.TIME_MOVE_SPEED_UP = 1e-05

local function var_0_1(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0

	if not var_1_10002.gameset[arg_1_0] or not var_2.key_value then
		var_1_0 = arg_1_1
	end

	return var_1_0
end

local function var_0_2(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0

	if not var_1_10002.gameset[arg_2_0] or not var_2.description then
		var_2_0 = arg_2_1
	end

	return var_2_0
end

var_0_0.LIFE_COUNT = var_0_1("minigame_crossroad_dead", 5)
var_0_0.CHILD_SPEED = var_0_1("minigame_crossroad_child_speed", 100)
var_0_0.CHILD_RUSH_SPEED = var_0_1("crossroad_speed_down", 33)
var_0_0.MAKE_CAR_TIME = var_0_2("minigame_crossroad_ship_appears", {
	8,
	7.8,
	7.5,
	7,
	6.5,
	6
})
var_0_0.CAR_SPEED_SCALE = var_0_2("minigame_crossroad_speed_up", {
	0.2,
	0.4,
	0.6,
	0.8,
	1,
	1.2,
	1.4,
	1.6,
	1.8,
	2
})
var_0_0.CHILD_ANGER_TIME = var_0_2("minigame_crossroad_child_time", {
	3,
	5
})
var_0_0.SCORE_ONE = var_0_1("minigame_crossroad_points3", 50)
var_0_0.SCORE_GROUP = var_0_1("minigame_crossroad_points2", 300)
var_0_0.SCORE_BASE = var_0_1("minigame_crossroad_points1", 100)
var_0_0.PLAYER_SPEED = var_0_1("minigame_crossroad_command_speed", 300)
var_0_0.XUANWO_LIFE_TIME = var_0_1("minigame_crossroad_prop1_time", 5)
var_0_0.XUANWO_MAKE_PROBABILITY = var_0_1("minigame_crossroad_prop1_probability", 30)
var_0_0.HONGCHA_GET_LIFE = var_0_1("minigame_crossroad_prop2_recover", 1)
var_0_0.HONGCHA_MISS_TIME = var_0_1("minigame_crossroad_prop2_time", 5)
var_0_0.BINGMIAN_DISTANCE = var_0_1("minigame_crossroad_prop3_distance", 170)
var_0_0.BINGMIAN_LIFE_TIME = var_0_1("minigame_crossroad_prop3_time", 6)
var_0_0.BINGMIAN_MAKE_PROBABILITY = var_0_1("minigame_crossroad_prop3_probability", 30)
var_0_0.ANGRY_PERCENT = var_0_1("minigame_crossroad_child_impulse", 40)

return ((function(arg_3_0)
	return (function(arg_4_0)
		local var_4_0 = {}
		local var_4_1 = {
			__index = arg_4_0,
			__newindex = function(arg_5_0, arg_5_1, arg_5_2)
				error = var_3_10003

				var_3_10003("attempt to modify a read-only table", 2)

				return
			end,
			__pairs = function()
				pairs = var_3_10000

				return var_3_10000(arg_3_0)
			end,
			__ipairs = function()
				ipairs = var_3_10000

				return var_3_10000(arg_3_0)
			end,
			__len = function()
				return #arg_3_0
			end,
			__tostring = function()
				return "read-only table"
			end
		}

		setmetatable = var_3

		var_3(var_4_0, var_4_1)

		pairs = var_3

		for iter_4_0, iter_4_1 in var_3(arg_4_0) do
			type = var_2_10008

			if var_2_10008(iter_4_1) == "table" then
				var_0(iter_4_1)
			end
		end

		return var_4_0
	end)(arg_3_0)
end)(var_0_0))
