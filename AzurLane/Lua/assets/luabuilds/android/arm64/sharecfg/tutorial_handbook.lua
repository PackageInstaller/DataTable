pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "tutorial_handbook") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "tutorial_handbook"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.tutorial_handbook = var_0_2
pg = var_0

local var_0_3 = var_0.tutorial_handbook

var_0_3.all = {
	100,
	200,
	900
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.tutorial_handbook = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.tutorial_handbook

	var_1_0[100] = {
		name = "新手任务",
		eng_name = "NEWCOMER",
		type = 1,
		id = 100,
		lock_name = "",
		lock_hint = "",
		unlock_param = {},
		tag_list = {
			100101,
			100201,
			100301,
			100401,
			100501,
			100601,
			100701,
			100801,
			100901
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.tutorial_handbook

	var_1_1[200] = {
		name = "功能指引",
		eng_name = "TUTORIAL",
		type = 1,
		id = 200,
		lock_name = "",
		lock_hint = "",
		unlock_param = {},
		tag_list = {
			200101,
			200201,
			200301,
			200401,
			200501,
			200601,
			200701,
			200801,
			200901,
			201001,
			201101,
			201201,
			201301,
			201401,
			201501,
			201601,
			201701,
			201801,
			201901,
			202001,
			202101,
			202201,
			202301,
			202401,
			202501,
			202601,
			202701,
			202801,
			202901,
			203001,
			203101,
			203201,
			203301,
			203401
		}
	}
	pg = var_1_1
	var_1_1.base.tutorial_handbook[900] = {
		name = "科研任务",
		eng_name = "RESEARCH",
		type = 2,
		id = 900,
		lock_name = "Lv.30",
		lock_hint = "",
		unlock_param = {},
		tag_list = {
			632
		}
	}

	return
end)()

return
