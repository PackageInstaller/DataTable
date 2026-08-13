pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm_data_template = var_0_2
pg = var_0

local var_0_3 = var_0.dorm_data_template

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm_data_template

	var_1_0[1] = {
		training_ship_number = 6,
		name = "一级房间",
		time = 15,
		exp = 1,
		capacity = 40000,
		consume = 5,
		id = 1,
		comfortable = 0,
		fix_ship_number = 6,
		limit = {
			20,
			16,
			1,
			1,
			16,
			8
		},
		comfortable_count = {
			{
				1,
				1
			},
			{
				2,
				20
			},
			{
				3,
				16
			},
			{
				4,
				1
			},
			{
				5,
				2
			},
			{
				6,
				16
			},
			{
				7,
				8
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm_data_template

	var_1_1[2] = {
		training_ship_number = 6,
		name = "二级房间",
		time = 15,
		exp = 1,
		capacity = 40000,
		consume = 5,
		id = 2,
		comfortable = 10,
		fix_ship_number = 6,
		limit = {
			24,
			20,
			1,
			1,
			20,
			10
		},
		comfortable_count = {
			{
				1,
				1
			},
			{
				2,
				24
			},
			{
				3,
				20
			},
			{
				4,
				1
			},
			{
				5,
				3
			},
			{
				6,
				20
			},
			{
				7,
				10
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm_data_template

	var_1_2[3] = {
		training_ship_number = 6,
		name = "三级房间",
		time = 15,
		exp = 1,
		capacity = 40000,
		consume = 5,
		id = 3,
		comfortable = 20,
		fix_ship_number = 6,
		limit = {
			28,
			24,
			1,
			1,
			24,
			12
		},
		comfortable_count = {
			{
				1,
				1
			},
			{
				2,
				28
			},
			{
				3,
				24
			},
			{
				4,
				1
			},
			{
				5,
				4
			},
			{
				6,
				24
			},
			{
				7,
				12
			}
		}
	}
	pg = var_1_2
	var_1_2.base.dorm_data_template[4] = {
		training_ship_number = 6,
		name = "四级房间",
		time = 15,
		exp = 1,
		capacity = 40000,
		consume = 5,
		id = 4,
		comfortable = 30,
		fix_ship_number = 6,
		limit = {
			34,
			30,
			1,
			1,
			30,
			15
		},
		comfortable_count = {
			{
				1,
				1
			},
			{
				2,
				34
			},
			{
				3,
				30
			},
			{
				4,
				1
			},
			{
				5,
				5
			},
			{
				6,
				30
			},
			{
				7,
				15
			}
		}
	}

	return
end)()

return
