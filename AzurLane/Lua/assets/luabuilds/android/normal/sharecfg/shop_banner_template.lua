pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "shop_banner_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "shop_banner_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.shop_banner_template = var_0_2
pg = var_0

local var_0_3 = var_0.shop_banner_template

var_0_3.all = {
	10,
	11,
	12,
	13,
	14,
	20,
	21,
	22,
	23,
	24,
	25,
	30,
	31,
	40,
	41,
	50,
	51
}
pg = var_0_3

local var_0_4 = var_0_3.shop_banner_template

var_0_4.get_id_list_by_name = {
	banner_big = {
		10,
		11,
		12,
		13,
		14
	},
	banner_middle = {
		20,
		21,
		22,
		23,
		24,
		25
	},
	banner_small1 = {
		30,
		31
	},
	banner_small2 = {
		40,
		41
	},
	banner_small3 = {
		50,
		51
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
var_0_4.base.shop_banner_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.shop_banner_template

	var_1_0[10] = {
		name = "banner_big",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_skin",
		id = 10,
		relation_param = "",
		order = 10,
		time = {
			{
				{
					2026,
					7,
					23
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					7,
					29
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene skinshop",
			{}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.shop_banner_template

	var_1_1[11] = {
		name = "banner_big",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_skin2",
		id = 11,
		relation_param = "",
		order = 9,
		time = {
			{
				{
					2026,
					7,
					16
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					7,
					29
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene skinshop",
			{}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.shop_banner_template

	var_1_2[12] = {
		name = "banner_big",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_skin3",
		id = 12,
		relation_param = "",
		order = 8,
		time = {
			{
				{
					2026,
					6,
					5
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					17
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene skinshop",
			{}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.shop_banner_template

	var_1_3[13] = {
		name = "banner_big",
		time = "stop",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_skin4",
		id = 13,
		relation_param = "",
		order = 7,
		param = {
			"scene skinshop",
			{}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.shop_banner_template

	var_1_4[14] = {
		name = "banner_big",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_skin_default",
		id = 14,
		relation_param = "",
		order = 1,
		param = {
			"scene skinshop",
			{}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.shop_banner_template

	var_1_5[20] = {
		name = "banner_middle",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_pack_bg",
		id = 20,
		order = 99,
		time = {
			{
				{
					2026,
					5,
					28
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					11
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene charge",
			{
				warp = 4
			}
		},
		relation_param = {
			1,
			9018
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.shop_banner_template

	var_1_6[21] = {
		name = "banner_middle",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_pack_bg",
		id = 21,
		order = 98,
		time = {
			{
				{
					2026,
					5,
					28
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					11
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene charge",
			{
				warp = 4
			}
		},
		relation_param = {
			1,
			9019
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.shop_banner_template

	var_1_7[22] = {
		name = "banner_middle",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_akashi_recommend",
		id = 22,
		relation_param = "",
		order = 1,
		param = {
			"scene charge",
			{
				warp = 4
			}
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.shop_banner_template

	var_1_8[23] = {
		name = "banner_middle",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_pack_bg",
		id = 23,
		order = 97,
		time = {
			{
				{
					2026,
					5,
					20
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					11
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene charge",
			{
				warp = 4
			}
		},
		relation_param = {
			1,
			9016
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.shop_banner_template

	var_1_9[24] = {
		name = "banner_middle",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_pack_bg",
		id = 24,
		order = 96,
		time = {
			{
				{
					2026,
					5,
					20
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					11
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene charge",
			{
				warp = 4
			}
		},
		relation_param = {
			1,
			9017
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.shop_banner_template

	var_1_10[25] = {
		name = "banner_middle",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_pack_bg",
		id = 25,
		order = 95,
		time = {
			{
				{
					2026,
					5,
					20
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					6,
					11
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene charge",
			{
				warp = 4
			}
		},
		relation_param = {
			1,
			2079
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.shop_banner_template

	var_1_11[30] = {
		name = "banner_small1",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_diamond",
		id = 30,
		relation_param = "",
		order = 10,
		param = {
			"scene charge",
			{
				warp = 1
			}
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.shop_banner_template

	var_1_12[31] = {
		name = "banner_small1",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_props",
		id = 31,
		relation_param = "",
		order = 1,
		param = {
			"scene charge",
			{
				warp = 3
			}
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.shop_banner_template

	var_1_13[40] = {
		param = "",
		name = "banner_small2",
		time = "stop",
		type = 2,
		time_lable = 0,
		pic = "",
		id = 40,
		relation_param = "",
		order = 10
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.shop_banner_template

	var_1_14[41] = {
		name = "banner_small2",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_item_bg",
		id = 41,
		order = 1,
		param = {
			"scene charge",
			{
				warp = 1
			}
		},
		relation_param = {
			1,
			1
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.shop_banner_template

	var_1_15[50] = {
		name = "banner_small3",
		type = 2,
		time_lable = 1,
		pic = "shopbanner/shop_event_pt",
		id = 50,
		relation_param = "",
		order = 10,
		time = {
			{
				{
					2026,
					6,
					18
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2026,
					7,
					1
				},
				{
					23,
					59,
					59
				}
			}
		},
		param = {
			"scene shop",
			{
				warp = "activity"
			}
		}
	}
	pg = var_1_15
	var_1_15.base.shop_banner_template[51] = {
		name = "banner_small3",
		time = "always",
		type = 2,
		time_lable = 0,
		pic = "shopbanner/shop_shopstreet",
		id = 51,
		relation_param = "",
		order = 1,
		param = {
			"scene shop",
			{
				warp = "shopstreet"
			}
		}
	}

	return
end)()

return
