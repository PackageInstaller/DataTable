pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_accompany") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_accompany"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_accompany = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_accompany

var_0_3.all = {
	1,
	2,
	3,
	21,
	22,
	31,
	32,
	111,
	112,
	121,
	122,
	141,
	142,
	211,
	212
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_accompany

var_0_4.get_id_list_by_ship_id = {
	[10517] = {
		111,
		112
	},
	[19903] = {
		31,
		32
	},
	[20220] = {
		1,
		2,
		3
	},
	[30221] = {
		21,
		22
	},
	[30707] = {
		121,
		122
	},
	[49905] = {
		141,
		142
	},
	[30] = {
		211,
		212
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
var_0_4.base.dorm3d_accompany = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_accompany

	var_1_0[1] = {
		sceneInfo = "map_siriushostel_01|Tianlangxing_DB/SiriusHostel",
		name = "日常相伴",
		performance_time = 20,
		image = "tianlangxing_accompany_room",
		ship_id = 20220,
		resource_room = 1,
		timeline = "Xiangban_shinei",
		id = 1,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_accompany

	var_1_1[2] = {
		sceneInfo = "map_beach_01|Beach",
		name = "休闲相伴",
		performance_time = 20,
		image = "tianlangxing_accompany_beach",
		ship_id = 20220,
		resource_room = 4,
		timeline = "Xiangban_shatan",
		id = 2,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			4,
			20220
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_accompany

	var_1_2[3] = {
		sceneInfo = "map_publiccafe_01|Publiccafe",
		name = "休闲相伴",
		performance_time = 20,
		image = "cafe_accompany",
		ship_id = 20220,
		resource_room = 16,
		timeline = "Xiangban_cafe_20220",
		id = 3,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			16,
			20220
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_accompany

	var_1_3[21] = {
		sceneInfo = "map_noshirohostel_01|Nengdai_DB/NoshiroHostel",
		name = "日常相伴",
		performance_time = 20,
		image = "nengdai_accompany_room",
		ship_id = 30221,
		resource_room = 2,
		timeline = "Xiangban_shinei_ND",
		id = 21,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_accompany

	var_1_4[22] = {
		sceneInfo = "map_beach_01|Beach",
		name = "休闲相伴",
		performance_time = 20,
		image = "tianlangxing_accompany_beach",
		ship_id = 30221,
		resource_room = 4,
		timeline = "Xiangban_shatan_ND",
		id = 22,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			4,
			30221
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_accompany

	var_1_5[31] = {
		sceneInfo = "map_anchoragehostel_01|Ankeleiqi_DB/Anchoragehostel",
		name = "日常相伴",
		performance_time = 20,
		image = "ankeleiqi_accompany_room",
		ship_id = 19903,
		resource_room = 3,
		timeline = "Xiangban_shinei_Ab",
		id = 31,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_accompany

	var_1_6[32] = {
		sceneInfo = "map_beach_01|Beach",
		name = "休闲相伴",
		performance_time = 20,
		image = "tianlangxing_accompany_beach",
		ship_id = 19903,
		resource_room = 4,
		timeline = "Xiangban_shatan_Ab",
		id = 32,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			4,
			19903
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_accompany

	var_1_7[111] = {
		sceneInfo = "map_newjerseyhostel_01|Xinzexi_DB/Newjerseyhostel",
		name = "日常相伴",
		performance_time = 20,
		image = "xinzexi_accompany_room",
		ship_id = 10517,
		resource_room = 11,
		timeline = "Xiangban_personal_10517",
		id = 111,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_accompany

	var_1_8[112] = {
		sceneInfo = "map_publiccafe_01|Publiccafe",
		name = "休闲相伴",
		performance_time = 20,
		image = "cafe_accompany",
		ship_id = 10517,
		resource_room = 16,
		timeline = "Xiangban_cafe_10517",
		id = 112,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			16,
			10517
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_accompany

	var_1_9[121] = {
		sceneInfo = "map_dafeng_01|Dafeng_DB/Dafenghostel",
		name = "日常相伴",
		performance_time = 20,
		image = "dafeng_accompany_room",
		ship_id = 30707,
		resource_room = 12,
		timeline = "Xiangban_personal_30707",
		id = 121,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_accompany

	var_1_10[122] = {
		sceneInfo = "map_publiccafe_01|Publiccafe",
		name = "休闲相伴",
		performance_time = 20,
		image = "cafe_accompany",
		ship_id = 30707,
		resource_room = 16,
		timeline = "Xiangban_cafe_30707",
		id = 122,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			16,
			30707
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_accompany

	var_1_11[141] = {
		sceneInfo = "map_aijier_01|Aijier_DB/Aijierhostel",
		name = "日常相伴",
		performance_time = 20,
		image = "aijier_accompany_room",
		ship_id = 49905,
		resource_room = 14,
		timeline = "Xiangban_personal_49905",
		id = 141,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_accompany

	var_1_12[142] = {
		sceneInfo = "map_publiccafe_01|Publiccafe",
		name = "休闲相伴",
		performance_time = 20,
		image = "cafe_accompany",
		ship_id = 49905,
		resource_room = 16,
		timeline = "Xiangban_cafe_49905",
		id = 142,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			16,
			49905
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_accompany

	var_1_13[211] = {
		sceneInfo = "map_naximofu_01|Naximofu_DB/Naximofuhostel",
		name = "日常相伴",
		performance_time = 20,
		image = "naximofu_accompany_room",
		ship_id = 79902,
		resource_room = 21,
		timeline = "Xiangban_personal_79902",
		id = 211,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {}
	}
	pg = var_1_13
	var_1_13.base.dorm3d_accompany[212] = {
		sceneInfo = "map_carwash_01|Carwash",
		name = "休闲相伴",
		performance_time = 20,
		image = "carwash_accompany",
		ship_id = 79902,
		resource_room = 26,
		timeline = "Xiangban_carwash_79902",
		id = 212,
		favor = {
			300,
			{
				1015,
				1016,
				1017
			}
		},
		jump_trigger = {},
		unlock = {
			5,
			26,
			79902
		}
	}

	return
end)()

return
