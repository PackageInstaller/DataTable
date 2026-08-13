pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "property_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "property_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.property_data_template = var_0_2
pg = var_0
pg = var_0_2

local var_0_3

if not var_0_2.base then
	var_0_3 = {}
end

var_0.base = var_0_3
pg = var_0
var_0.base.property_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.property_data_template

	var_1_0.durability = {
		view = "durability",
		name = "耐久",
		icon = "durability"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.property_data_template

	var_1_1.cannon = {
		view = "cannon",
		name = "炮击",
		icon = "cannon"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.property_data_template

	var_1_2.torpedo = {
		view = "torpedo",
		name = "雷击",
		icon = "torpedo"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.property_data_template

	var_1_3.antiaircraft = {
		view = "antiaircraft",
		name = "防空",
		icon = "antiaircraft"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.property_data_template

	var_1_4.air = {
		view = "air",
		name = "航空",
		icon = "air"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.property_data_template

	var_1_5.reload = {
		view = "reload",
		name = "装填",
		icon = "reload"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.property_data_template

	var_1_6.range_view = {
		view = "range_view",
		name = "射程",
		icon = "range"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.property_data_template

	var_1_7.armor = {
		view = "armor",
		name = "装甲",
		icon = "armor"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.property_data_template

	var_1_8.hit = {
		view = "hit",
		name = "命中",
		icon = "hit"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.property_data_template

	var_1_9.dodge = {
		view = "dodge",
		name = "机动",
		icon = "dodge"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.property_data_template

	var_1_10.speed = {
		view = "speed",
		name = "航速",
		icon = "speed"
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.property_data_template

	var_1_11.luck = {
		view = "luck",
		name = "幸运",
		icon = "luck"
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.property_data_template

	var_1_12.damage = {
		view = "damage",
		name = "火力",
		icon = "cannon"
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.property_data_template

	var_1_13.healthy = {
		view = "healthy",
		name = "治疗",
		icon = "durability"
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.property_data_template

	var_1_14.cd = {
		view = "cd",
		name = "射速",
		icon = "reload"
	}
	pg = var_1_14
	var_1_14.base.property_data_template.speciality = {
		view = "speciality",
		name = "特性",
		icon = "damage"
	}

	return
end)()

return
