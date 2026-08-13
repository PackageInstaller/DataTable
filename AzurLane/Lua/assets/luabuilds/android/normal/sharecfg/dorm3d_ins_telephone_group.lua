pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_ins_telephone_group") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_ins_telephone_group"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_ins_telephone_group = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_ins_telephone_group

var_0_3.__namecode__ = true
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_ins_telephone_group

var_0_4.all = {
	10517301,
	10517302,
	30707301,
	30707302,
	49905301,
	49905302,
	79902301,
	79902302
}
pg = var_0_4

local var_0_5 = var_0_4.dorm3d_ins_telephone_group

var_0_5.get_id_list_by_ship_group = {
	[10517] = {
		10517301,
		10517302
	},
	[30707] = {
		30707301,
		30707302
	},
	[49905] = {
		49905301,
		49905302
	},
	[30] = {
		79902301,
		79902302
	}
}
pg = var_0_5
pg = var_1

local var_0_6

if not var_1.base then
	var_0_6 = {}
end

var_0_5.base = var_0_6
pg = var_0_5
var_0_5.base.dorm3d_ins_telephone_group = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_ins_telephone_group

	var_1_0[10517301] = {
		ship_group = 10517,
		name = "{namecode:199}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 10517301,
		unlock_desc = "进入{namecode:199}宿舍",
		content = {
			11,
			110602
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_ins_telephone_group

	var_1_1[10517302] = {
		ship_group = 10517,
		name = "{namecode:199}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 10517302,
		unlock_desc = "{namecode:199}契合度12级",
		content = {
			11,
			110603
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_ins_telephone_group

	var_1_2[30707301] = {
		ship_group = 30707,
		name = "{namecode:97}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 30707301,
		unlock_desc = "进入{namecode:97}宿舍",
		content = {
			12,
			120601
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_ins_telephone_group

	var_1_3[30707302] = {
		ship_group = 30707,
		name = "{namecode:97}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 30707302,
		unlock_desc = "{namecode:97}契合度12级",
		content = {
			12,
			120602
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_ins_telephone_group

	var_1_4[21] = {
		ship_group = 49905,
		name = "{namecode:480}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 49905301,
		unlock_desc = "进入{namecode:480}宿舍",
		content = {
			14,
			140601
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_ins_telephone_group

	var_1_5[22] = {
		ship_group = 49905,
		name = "{namecode:480}视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 49905302,
		unlock_desc = "{namecode:480}契合度12级",
		content = {
			14,
			140602
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_ins_telephone_group

	var_1_6[79902301] = {
		ship_group = 79902,
		name = "纳希莫夫海军上将视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 79902301,
		unlock_desc = "进入纳希莫夫海军上将宿舍",
		content = {
			21,
			210601
		}
	}
	pg = var_1_6
	var_1_6.base.dorm3d_ins_telephone_group[79902302] = {
		ship_group = 79902,
		name = "纳希莫夫海军上将视频通话",
		background = "voice_placeholder",
		type = 1,
		id = 79902302,
		unlock_desc = "纳希莫夫海军上将契合度12级",
		content = {
			21,
			210602
		}
	}

	return
end)()

return
