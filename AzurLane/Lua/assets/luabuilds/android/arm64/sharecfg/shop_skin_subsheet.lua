pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "shop_skin_subsheet") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "shop_skin_subsheet"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.shop_skin_subsheet = var_0_2
pg = var_0

local var_0_3 = var_0.shop_skin_subsheet

var_0_3.all = {
	1,
	2
}
pg = var_0_3

local var_0_4 = var_0_3.shop_skin_subsheet

var_0_4.get_id_list_by_type = {
	[0] = {
		1,
		2
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.shop_skin_subsheet = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.shop_skin_subsheet

	var_1_0[1] = {
		time = "",
		site_tag_text = "精选换装",
		type = 0,
		id = 1,
		enter_subsheet = 1,
		sort = 1,
		param = {}
	}
	pg = var_1_0
	var_1_0.base.shop_skin_subsheet[2] = {
		time = "",
		site_tag_text = "热门换装",
		type = 0,
		id = 2,
		enter_subsheet = 2,
		sort = 2,
		param = {}
	}

	return
end)()

return
