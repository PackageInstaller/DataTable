pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "weather_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "weather_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.weather_data_template = var_0_2
pg = var_0

local var_0_3 = var_0.weather_data_template

var_0_3.all = {
	101,
	102,
	103
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.weather_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.weather_data_template

	var_1_0[101] = {
		buff_desc = "苏里高海峡被黑夜和雷雨笼罩，己方先锋舰队与敌方舰队均获得「夜战隐蔽」状态。被攻击时，舰队会依据当前隐蔽强度获得额外的规避能力。",
		name = "夜战",
		id = 101,
		buff_icon = "weather_101",
		icon = "",
		effect_args = {
			buff = 9677
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.weather_data_template

	var_1_1[102] = {
		buff_desc = "处于海雾区域中，战斗时己方和敌方的隐蔽强度降低速率减慢。",
		name = "海雾",
		id = 102,
		buff_icon = "weather_102",
		icon = "suligao_fog",
		effect_args = {
			buff = 9620
		}
	}
	pg = var_1_1
	var_1_1.base.weather_data_template[103] = {
		buff_desc = "",
		name = "迷雾",
		id = 103,
		buff_icon = "",
		icon = "visible_fog",
		effect_args = {}
	}

	return
end)()

return
