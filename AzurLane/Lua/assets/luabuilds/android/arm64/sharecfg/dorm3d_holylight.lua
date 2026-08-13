pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_holylight") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_holylight"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_holylight = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_holylight

var_0_3.all = {
	49905101,
	49905301,
	49905102,
	20220301,
	19903101,
	79902101,
	79902102,
	79902103,
	79902104
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_holylight

var_0_4.get_id_list_by_skin_id = {
	[199031] = {
		19903101
	},
	[202203] = {
		20220301
	},
	[499051] = {
		49905101,
		49905102
	},
	[499053] = {
		49905301
	},
	[799021] = {
		79902101
	},
	[799022] = {
		79902102
	},
	[799023] = {
		79902103
	},
	[799024] = {
		79902104
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
var_0_4.base.dorm3d_holylight = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_holylight

	var_1_0[49905101] = {
		texture = "dorm3dholylight/Eff_smoke_114",
		id = 49905101,
		invert = 1,
		default_threshold = -0.01,
		skin_id = 499051,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			96,
			96
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_holylight

	var_1_1[21] = {
		texture = "dorm3dholylight/Eff_smoke_114",
		id = 49905301,
		invert = 1,
		default_threshold = -0.1,
		skin_id = 499053,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			96,
			96
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_holylight

	var_1_2[49905102] = {
		texture = "dorm3dholylight/Eff_smoke_114",
		id = 49905102,
		invert = 1,
		default_threshold = -1,
		skin_id = 499051,
		target_bone = "all/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			96,
			96
		},
		axis = {
			0,
			1,
			0
		},
		rotation_offset = {
			0,
			0,
			35
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_holylight

	var_1_3[13] = {
		texture = "dorm3dholylight/Eff_smoke_114",
		id = 20220301,
		invert = 1,
		default_threshold = -0.1,
		skin_id = 202203,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			96,
			96
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_holylight

	var_1_4[19903101] = {
		texture = "dorm3dholylight/Eff_smoke_114",
		id = 19903101,
		invert = 1,
		default_threshold = -0.1,
		skin_id = 199031,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			96,
			96
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_holylight

	var_1_5[21] = {
		texture = "dorm3dholylight/Eff_smoke_116",
		id = 79902101,
		invert = 1,
		default_threshold = 0.75,
		skin_id = 799021,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			128,
			128
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_holylight

	var_1_6[22] = {
		texture = "dorm3dholylight/Eff_smoke_116",
		id = 79902102,
		invert = 1,
		default_threshold = 0.75,
		skin_id = 799022,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			128,
			128
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_holylight

	var_1_7[23] = {
		texture = "dorm3dholylight/Eff_smoke_116",
		id = 79902103,
		invert = 1,
		default_threshold = 0.75,
		skin_id = 799023,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			128,
			128
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}
	pg = var_1_7
	var_1_7.base.dorm3d_holylight[24] = {
		texture = "dorm3dholylight/Eff_smoke_116",
		id = 79902104,
		invert = 1,
		default_threshold = 0.75,
		skin_id = 799024,
		target_bone = "all/Bip001/Bip001 Pelvis",
		color = {
			1,
			1,
			1,
			1
		},
		base_size = {
			128,
			128
		},
		axis = {
			1,
			0,
			0
		},
		rotation_offset = {
			0,
			0,
			0
		}
	}

	return
end)()

return
