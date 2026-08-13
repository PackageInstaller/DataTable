pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "activity_link_button") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_link_button"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.activity_link_button = var_0_2
pg = var_0

local var_0_3 = var_0.activity_link_button

var_0_3.all = {
	1,
	2,
	9,
	10,
	11,
	12,
	13,
	20,
	21,
	30,
	40,
	60,
	70,
	80,
	90,
	100,
	101,
	102,
	103,
	104,
	105,
	106,
	107,
	108,
	109,
	110,
	111,
	112,
	113,
	114,
	115,
	116,
	121,
	122
}
pg = var_0_3

local var_0_4 = var_0_3.activity_link_button

var_0_4.get_id_list_by_name = {
	event_Atelier = {
		80
	},
	event_LanternFestival = {
		60
	},
	event_all = {
		1,
		2,
		9
	},
	event_aprilFool = {
		70
	},
	event_blackFriday = {
		106
	},
	event_boat_ad_game = {
		105
	},
	event_boss = {
		30
	},
	event_boss_single = {
		102
	},
	event_core = {
		109,
		114,
		116
	},
	event_core_2 = {
		113,
		115
	},
	event_dreamland = {
		103
	},
	event_escort = {
		40
	},
	event_holidayVilla = {
		21
	},
	event_layer = {
		104
	},
	event_map = {
		10,
		121
	},
	event_map_2 = {
		111
	},
	event_map_sub = {
		11
	},
	event_medal = {
		100
	},
	event_minigame = {
		20,
		108,
		110,
		122
	},
	event_old_act = {
		13
	},
	event_second_map = {
		112
	},
	event_senran = {
		101
	},
	event_series = {
		90
	},
	event_sub_act = {
		12
	},
	event_tolove = {
		107
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
var_0_4.base.activity_link_button = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_link_button

	var_1_0[1] = {
		param = "0",
		name = "event_all",
		text_pic = "text_event_all",
		type = 3,
		pic = "event_all",
		id = 1,
		group_id = 1,
		order = 1,
		time = {
			"default",
			51033
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_link_button

	var_1_1[2] = {
		param = "5871",
		name = "event_all",
		time = "stop",
		text_pic = "text_event_all",
		type = 3,
		pic = "event_all",
		id = 2,
		group_id = 1,
		order = 2
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_link_button

	var_1_2[9] = {
		param = "0",
		name = "event_all",
		time = "always",
		text_pic = "text_event_all",
		type = 3,
		pic = "event_all_default",
		id = 9,
		group_id = 1,
		order = 99
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_link_button

	var_1_3[10] = {
		param = "",
		name = "event_map",
		text_pic = "text_event_map",
		type = 0,
		pic = "event_map",
		id = 10,
		group_id = 2,
		order = 1,
		time = {
			"default",
			51071
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_link_button

	var_1_4[11] = {
		name = "event_map_sub",
		time = "stop",
		text_pic = "text_event_map_sub",
		type = 2,
		pic = "event_map_sub",
		id = 11,
		group_id = 3,
		order = 1,
		param = {
			"LiquorFloor"
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.activity_link_button

	var_1_5[12] = {
		name = "event_sub_act",
		text_pic = "text_event_map_sub",
		type = 2,
		pic = "event_map_sub",
		id = 12,
		group_id = 3,
		order = 1,
		time = {
			"default",
			50434
		},
		param = {
			"LiquorFloor"
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.activity_link_button

	var_1_6[13] = {
		name = "event_old_act",
		text_pic = "",
		type = 2,
		pic = "",
		id = 13,
		group_id = 3,
		order = 1,
		time = {
			"default",
			50434
		},
		param = {
			"LiquorFloor"
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.activity_link_button

	var_1_7[20] = {
		name = "event_minigame",
		time = "stop",
		text_pic = "text_event_minigame",
		type = 2,
		pic = "event_minigame",
		id = 20,
		group_id = 5,
		order = 1,
		param = {
			"holiday villa map"
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.activity_link_button

	var_1_8[21] = {
		name = "event_holidayVilla",
		time = "stop",
		text_pic = "text_event_minigame",
		type = 0,
		pic = "event_minigame",
		id = 21,
		group_id = 5,
		order = 1,
		param = {
			"holiday villa map",
			5922
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.activity_link_button

	var_1_9[30] = {
		param = "0",
		name = "event_boss",
		time = "stop",
		text_pic = "text_event_boss",
		type = 0,
		pic = "event_boss",
		id = 30,
		group_id = 3,
		order = 1
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.activity_link_button

	var_1_10[40] = {
		param = "0",
		name = "event_escort",
		text_pic = "text_event_escort",
		type = 0,
		pic = "event_escort",
		id = 40,
		group_id = 6,
		order = 1,
		time = {
			"default"
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.activity_link_button

	var_1_11[60] = {
		param = "0",
		name = "event_LanternFestival",
		text_pic = "text_event_LanternFestival",
		type = 0,
		pic = "event_LanternFestival",
		id = 60,
		group_id = 7,
		order = 1,
		time = {
			"default",
			5803
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.activity_link_button

	var_1_12[70] = {
		param = "0",
		name = "event_aprilFool",
		text_pic = "text_event_aprilFool",
		type = 0,
		pic = "event_aprilFool",
		id = 70,
		group_id = 8,
		order = 1,
		time = {
			"default",
			5267
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.activity_link_button

	var_1_13[80] = {
		name = "event_Atelier",
		text_pic = "text_event_Atelier",
		type = 2,
		pic = "event_Atelier",
		id = 80,
		group_id = 9,
		order = 1,
		time = {
			"default",
			4581
		},
		param = {
			"ATELIER_COMPOSITE"
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.activity_link_button

	var_1_14[90] = {
		param = "0",
		name = "event_series",
		time = "stop",
		text_pic = "text_event_map",
		type = 0,
		pic = "event_series",
		id = 90,
		group_id = 4,
		order = 1
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.activity_link_button

	var_1_15[100] = {
		name = "event_medal",
		text_pic = "text_event_medal",
		type = 2,
		pic = "event_medal",
		id = 100,
		group_id = 10,
		order = 1,
		time = {
			"default",
			5093
		},
		param = {
			"SENRANKAGURA_MEDAL"
		}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.activity_link_button

	var_1_16[101] = {
		name = "event_senran",
		text_pic = "text_event_senran",
		type = 2,
		pic = "event_senran",
		id = 101,
		group_id = 100,
		order = 1,
		time = {
			"default",
			5099
		},
		param = {
			"SENRANKAGURA_TRAIN"
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.activity_link_button

	var_1_17[102] = {
		param = "0",
		name = "event_boss_single",
		time = "stop",
		text_pic = "text_event_anotherWorld",
		type = 0,
		pic = "event_map",
		id = 102,
		group_id = 4,
		order = 1
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.activity_link_button

	var_1_18[103] = {
		name = "event_dreamland",
		time = "stop",
		text_pic = "text_event_minigame",
		type = 2,
		pic = "event_minigame",
		id = 103,
		group_id = 9,
		order = 1,
		param = {
			"DREAMLAND"
		}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.activity_link_button

	var_1_19[104] = {
		name = "event_layer",
		text_pic = "text_event_layer",
		type = 14,
		pic = "event_layer",
		id = 104,
		group_id = 1,
		order = 1,
		time = {
			"default",
			5404
		},
		param = {
			mediator = "ChildishnessSchoolPtMediator",
			view = "ChildishnessSchoolPtPage"
		}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.activity_link_button

	var_1_20[105] = {
		name = "event_boat_ad_game",
		text_pic = "text_event_boat_ad_game",
		type = 7,
		pic = "event_boat_ad_game",
		id = 105,
		group_id = 10,
		order = 1,
		time = {
			"default",
			50204
		},
		param = {
			68
		}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.activity_link_button

	var_1_21[106] = {
		name = "event_blackFriday",
		text_pic = "text_event_blackfriday",
		type = 2,
		pic = "event_blackfriday",
		id = 106,
		group_id = 11,
		order = 1,
		time = {
			"default",
			5702
		},
		param = {
			"BlackFridaySales"
		}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.activity_link_button

	var_1_22[107] = {
		name = "event_tolove",
		text_pic = "text_event_minigame",
		type = 2,
		pic = "event_minigame",
		id = 107,
		group_id = 12,
		order = 1,
		time = {
			"default",
			5686
		},
		param = {
			"TOLOVE_COLLAB_BACKHILL"
		}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.activity_link_button

	var_1_23[108] = {
		name = "event_minigame",
		text_pic = "text_event_minigame",
		type = 2,
		pic = "event_minigame",
		id = 108,
		group_id = 13,
		order = 1,
		time = {
			"default",
			5785
		},
		param = {
			"firework and spring"
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.activity_link_button

	var_1_24[109] = {
		param = "StarsCityCoreActivityUI",
		name = "event_core",
		text_pic = "text_event_core",
		type = 16,
		pic = "event_core",
		id = 109,
		group_id = 1,
		order = 1,
		time = {
			"default",
			51086
		}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.activity_link_button

	var_1_25[110] = {
		param = "RapidSeasideCoreActivityUI",
		name = "event_minigame",
		text_pic = "text_event_core3",
		type = 16,
		pic = "event_core3",
		id = 110,
		group_id = 2,
		order = 2,
		time = {
			"default",
			51090
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.activity_link_button

	var_1_26[111] = {
		param = "ALYCoreActivityUI",
		name = "event_map_2",
		text_pic = "text_event_ryzaAtelierRe",
		type = 16,
		pic = "event_ryzaAtelierRe",
		id = 111,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50042
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.activity_link_button

	var_1_27[112] = {
		param = "0",
		name = "event_second_map",
		text_pic = "text_event_ryza_map",
		type = 0,
		pic = "event_ryza_map",
		id = 112,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50042
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.activity_link_button

	var_1_28[113] = {
		param = "EighthAnniversaryJpCoreActivityUI",
		name = "event_core_2",
		text_pic = "text_event_special",
		type = 16,
		pic = "event_special",
		id = 113,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50118
		}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.activity_link_button

	var_1_29[114] = {
		param = "WinterFestival2025CoreActivityUI",
		name = "event_core",
		text_pic = "text_event_core3",
		type = 16,
		pic = "event_core3",
		id = 114,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50298
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.activity_link_button

	var_1_30[115] = {
		param = "AnniversaryNineCoreActivityUI",
		name = "event_core_2",
		text_pic = "text_event_core2",
		type = 16,
		pic = "event_core2",
		id = 115,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50630
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.activity_link_button

	var_1_31[116] = {
		param = "HolidayCoreActivityUI",
		name = "event_core",
		text_pic = "text_event_core3",
		type = 16,
		pic = "event_core3",
		id = 116,
		group_id = 1,
		order = 1,
		time = {
			"default",
			51001
		}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.activity_link_button

	var_1_32[121] = {
		param = "",
		name = "event_map",
		text_pic = "text_event_map",
		type = 0,
		pic = "event_map2",
		id = 121,
		group_id = 2,
		order = 2,
		time = {
			"default",
			50825
		}
	}
	pg = var_1_32
	var_1_32.base.activity_link_button[122] = {
		param = "NieRAutomataCoreActivityUI",
		name = "event_minigame",
		text_pic = "text_event_core3",
		type = 16,
		pic = "event_minigame",
		id = 122,
		group_id = 1,
		order = 1,
		time = {
			"default",
			50841
		}
	}

	return
end)()

return
