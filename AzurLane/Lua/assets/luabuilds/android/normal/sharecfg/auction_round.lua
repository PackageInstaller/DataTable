pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "auction_round") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "auction_round"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.auction_round = var_0_2
pg = var_0

local var_0_3 = var_0.auction_round

var_0_3.all = {
	1,
	2,
	3,
	4,
	5
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.auction_round = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.auction_round

	var_1_0[1] = {
		id = 1,
		name = "第一轮",
		one_hit = "2"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.auction_round

	var_1_1[2] = {
		id = 2,
		name = "第二轮",
		one_hit = "1.6"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.auction_round

	var_1_2[3] = {
		id = 3,
		name = "第三轮",
		one_hit = "1.3"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.auction_round

	var_1_3[4] = {
		id = 4,
		name = "第四轮",
		one_hit = "1.1"
	}
	pg = var_1_3
	var_1_3.base.auction_round[5] = {
		id = 5,
		name = "第五轮",
		one_hit = "1.1"
	}

	return
end)()

return
