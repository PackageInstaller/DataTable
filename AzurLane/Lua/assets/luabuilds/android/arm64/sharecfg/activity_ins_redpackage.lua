pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "activity_ins_redpackage") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_ins_redpackage"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.activity_ins_redpackage = var_0_2
pg = var_0

local var_0_3 = var_0.activity_ins_redpackage

var_0_3.all = {
	1000,
	1001,
	1002,
	1003,
	1004,
	1005
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.activity_ins_redpackage = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_ins_redpackage

	var_1_0[1000] = {
		type = 2,
		id = 1000,
		desc = "新年快乐，财源滚滚",
		content = {
			1,
			1,
			648
		},
		group_receive = {
			{
				50102,
				1,
				1,
				46
			},
			{
				0,
				1,
				1,
				648
			},
			{
				50101,
				1,
				1,
				300
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_ins_redpackage

	var_1_1[1001] = {
		type = 2,
		id = 1001,
		desc = "新年吃好喝好！",
		content = {
			1,
			1,
			233
		},
		group_receive = {
			{
				50102,
				1,
				1,
				15
			},
			{
				0,
				1,
				1,
				233
			},
			{
				50107,
				1,
				1,
				320
			},
			{
				50104,
				1,
				1,
				100
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_ins_redpackage

	var_1_2[1002] = {
		type = 2,
		id = 1002,
		desc = "新年天天开心",
		content = {
			1,
			1,
			88
		},
		group_receive = {
			{
				50102,
				1,
				1,
				6
			},
			{
				0,
				1,
				1,
				88
			},
			{
				50602,
				1,
				1,
				426
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_ins_redpackage

	var_1_3[1003] = {
		group_receive = "",
		type = 1,
		id = 1003,
		desc = "指挥官新年快乐",
		content = {
			1,
			1,
			888
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_ins_redpackage

	var_1_4[1004] = {
		type = 2,
		id = 1004,
		desc = "新年红包来咯！",
		content = {
			1,
			1,
			666
		},
		group_receive = {
			{
				50107,
				1,
				1,
				88
			},
			{
				0,
				1,
				1,
				666
			},
			{
				50210,
				1,
				1,
				202
			},
			{
				50109,
				1,
				1,
				188
			}
		}
	}
	pg = var_1_4
	var_1_4.base.activity_ins_redpackage[1005] = {
		type = 2,
		id = 1005,
		desc = "祝指挥官和大家万事如意！",
		content = {
			1,
			1,
			888
		},
		group_receive = {
			{
				50301,
				1,
				1,
				12
			},
			{
				0,
				1,
				1,
				888
			},
			{
				50108,
				1,
				1,
				188
			}
		}
	}

	return
end)()

return
