pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "activity_town_work_level") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_town_work_level"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.activity_town_work_level = var_0_2
pg = var_0

local var_0_3 = var_0.activity_town_work_level

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	11,
	12,
	13,
	14,
	15,
	16,
	21,
	22,
	23,
	24,
	25,
	26,
	31,
	32,
	33,
	34,
	35,
	36,
	101,
	102,
	103,
	104,
	105,
	106,
	111,
	112,
	113,
	114,
	115,
	116,
	121,
	122,
	123,
	124,
	125,
	126,
	131,
	132,
	133,
	134,
	135,
	136,
	137,
	138,
	139,
	140,
	141
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.activity_town_work_level = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_town_work_level

	var_1_0[1] = {
		gold = 0,
		exp_display = 10,
		name = "小型牧场LV.0",
		type = 1,
		group = 1,
		id = 1,
		pic = "muchang_xiao",
		gold_gain = 0,
		town_level = 1,
		level = 0
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_town_work_level

	var_1_1[2] = {
		gold = 50000,
		exp_display = 10,
		name = "小型牧场LV.1",
		type = 1,
		group = 1,
		id = 2,
		pic = "muchang_xiao",
		gold_gain = 1000,
		town_level = 1,
		level = 1
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_town_work_level

	var_1_2[3] = {
		gold = 100000,
		exp_display = 10,
		name = "中型牧场LV.2",
		type = 1,
		group = 1,
		id = 3,
		pic = "muchang_zhong",
		gold_gain = 1100,
		town_level = 1,
		level = 2
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_town_work_level

	var_1_3[4] = {
		gold = 300000,
		exp_display = 10,
		name = "中型牧场LV.3",
		type = 1,
		group = 1,
		id = 4,
		pic = "muchang_zhong",
		gold_gain = 1200,
		town_level = 2,
		level = 3
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_town_work_level

	var_1_4[5] = {
		gold = 600000,
		exp_display = 20,
		name = "大型牧场LV.4",
		type = 1,
		group = 1,
		id = 5,
		pic = "muchang_da",
		gold_gain = 1300,
		town_level = 2,
		level = 4
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.activity_town_work_level

	var_1_5[6] = {
		gold = 0,
		exp_display = 0,
		name = "大型牧场LV.5",
		type = 1,
		group = 1,
		id = 6,
		pic = "muchang_da",
		gold_gain = 1500,
		town_level = 0,
		level = 5
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.activity_town_work_level

	var_1_6[11] = {
		gold = 1200000,
		exp_display = 15,
		name = "小型农场LV.0",
		type = 1,
		group = 2,
		id = 11,
		pic = "nongchang_xiao",
		gold_gain = 0,
		town_level = 3,
		level = 0
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.activity_town_work_level

	var_1_7[12] = {
		gold = 800000,
		exp_display = 15,
		name = "小型农场LV.1",
		type = 1,
		group = 2,
		id = 12,
		pic = "nongchang_xiao",
		gold_gain = 500,
		town_level = 3,
		level = 1
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.activity_town_work_level

	var_1_8[13] = {
		gold = 1000000,
		exp_display = 15,
		name = "中型农场LV.2",
		type = 1,
		group = 2,
		id = 13,
		pic = "nongchang_zhong",
		gold_gain = 600,
		town_level = 3,
		level = 2
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.activity_town_work_level

	var_1_9[14] = {
		gold = 1200000,
		exp_display = 15,
		name = "中型农场LV.3",
		type = 1,
		group = 2,
		id = 14,
		pic = "nongchang_zhong",
		gold_gain = 700,
		town_level = 4,
		level = 3
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.activity_town_work_level

	var_1_10[15] = {
		gold = 2000000,
		exp_display = 20,
		name = "大型农场LV.4",
		type = 1,
		group = 2,
		id = 15,
		pic = "nongchang_da",
		gold_gain = 800,
		town_level = 4,
		level = 4
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.activity_town_work_level

	var_1_11[16] = {
		gold = 0,
		exp_display = 0,
		name = "大型农场LV.5",
		type = 1,
		group = 2,
		id = 16,
		pic = "nongchang_da",
		gold_gain = 1000,
		town_level = 0,
		level = 5
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.activity_town_work_level

	var_1_12[21] = {
		gold = 10000000,
		exp_display = 20,
		name = "小型矿场LV.0",
		type = 1,
		group = 3,
		id = 21,
		pic = "kuangchang_xiao",
		gold_gain = 0,
		town_level = 5,
		level = 0
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.activity_town_work_level

	var_1_13[22] = {
		gold = 8000000,
		exp_display = 20,
		name = "小型矿场LV.1",
		type = 1,
		group = 3,
		id = 22,
		pic = "kuangchang_xiao",
		gold_gain = 800,
		town_level = 5,
		level = 1
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.activity_town_work_level

	var_1_14[23] = {
		gold = 12000000,
		exp_display = 20,
		name = "中型矿场LV.2",
		type = 1,
		group = 3,
		id = 23,
		pic = "kuangchang_zhong",
		gold_gain = 1100,
		town_level = 5,
		level = 2
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.activity_town_work_level

	var_1_15[24] = {
		gold = 20000000,
		exp_display = 20,
		name = "中型矿场LV.3",
		type = 1,
		group = 3,
		id = 24,
		pic = "kuangchang_zhong",
		gold_gain = 1400,
		town_level = 6,
		level = 3
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.activity_town_work_level

	var_1_16[25] = {
		gold = 30000000,
		exp_display = 30,
		name = "大型矿场LV.4",
		type = 1,
		group = 3,
		id = 25,
		pic = "kuangchang_da",
		gold_gain = 1700,
		town_level = 6,
		level = 4
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.activity_town_work_level

	var_1_17[26] = {
		gold = 0,
		exp_display = 0,
		name = "大型矿场LV.5",
		type = 1,
		group = 3,
		id = 26,
		pic = "kuangchang_da",
		gold_gain = 2000,
		town_level = 0,
		level = 5
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.activity_town_work_level

	var_1_18[31] = {
		gold = 90000000,
		exp_display = 20,
		name = "小型摄影棚LV.0",
		type = 1,
		group = 4,
		id = 31,
		pic = "sheyingpeng_xiao",
		gold_gain = 0,
		town_level = 7,
		level = 0
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.activity_town_work_level

	var_1_19[32] = {
		gold = 45000000,
		exp_display = 20,
		name = "小型摄影棚LV.1",
		type = 1,
		group = 4,
		id = 32,
		pic = "sheyingpeng_xiao",
		gold_gain = 1000,
		town_level = 7,
		level = 1
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.activity_town_work_level

	var_1_20[33] = {
		gold = 60000000,
		exp_display = 20,
		name = "中型摄影棚LV.2",
		type = 1,
		group = 4,
		id = 33,
		pic = "sheyingpeng_zhong",
		gold_gain = 1500,
		town_level = 7,
		level = 2
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.activity_town_work_level

	var_1_21[34] = {
		gold = 75000000,
		exp_display = 20,
		name = "中型摄影棚LV.3",
		type = 1,
		group = 4,
		id = 34,
		pic = "sheyingpeng_zhong",
		gold_gain = 2000,
		town_level = 8,
		level = 3
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.activity_town_work_level

	var_1_22[35] = {
		gold = 180000000,
		exp_display = 20,
		name = "大型摄影棚LV.4",
		type = 1,
		group = 4,
		id = 35,
		pic = "sheyingpeng_da",
		gold_gain = 2500,
		town_level = 8,
		level = 4
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.activity_town_work_level

	var_1_23[36] = {
		gold = 0,
		exp_display = 0,
		name = "大型摄影棚LV.5",
		type = 1,
		group = 4,
		id = 36,
		pic = "sheyingpeng_da",
		gold_gain = 3500,
		town_level = 0,
		level = 5
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.activity_town_work_level

	var_1_24[101] = {
		gold = 25000000,
		exp_display = 40,
		name = "小镇车站LV.0",
		type = 2,
		group = 5,
		id = 101,
		pic = "huochezhan",
		gold_gain = 0,
		town_level = 4,
		level = 0
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.activity_town_work_level

	var_1_25[102] = {
		gold = 27000000,
		exp_display = 40,
		name = "小镇车站LV.1",
		type = 2,
		group = 5,
		id = 102,
		pic = "huochezhan",
		gold_gain = 500,
		town_level = 4,
		level = 1
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.activity_town_work_level

	var_1_26[103] = {
		gold = 30000000,
		exp_display = 40,
		name = "小镇车站LV.2",
		type = 2,
		group = 5,
		id = 103,
		pic = "huochezhan",
		gold_gain = 1000,
		town_level = 4,
		level = 2
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.activity_town_work_level

	var_1_27[104] = {
		gold = 35000000,
		exp_display = 40,
		name = "小镇车站LV.3",
		type = 2,
		group = 5,
		id = 104,
		pic = "huochezhan",
		gold_gain = 1500,
		town_level = 5,
		level = 3
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.activity_town_work_level

	var_1_28[105] = {
		gold = 40000000,
		exp_display = 40,
		name = "小镇车站LV.4",
		type = 2,
		group = 5,
		id = 105,
		pic = "huochezhan",
		gold_gain = 2000,
		town_level = 5,
		level = 4
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.activity_town_work_level

	var_1_29[106] = {
		gold = 0,
		exp_display = 0,
		name = "小镇车站LV.5",
		type = 2,
		group = 5,
		id = 106,
		pic = "huochezhan",
		gold_gain = 2500,
		town_level = 0,
		level = 5
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.activity_town_work_level

	var_1_30[111] = {
		gold = 80000000,
		exp_display = 40,
		name = "小镇旅店LV.0",
		type = 2,
		group = 6,
		id = 111,
		pic = "jiudian",
		gold_gain = 0,
		town_level = 6,
		level = 0
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.activity_town_work_level

	var_1_31[112] = {
		gold = 85000000,
		exp_display = 40,
		name = "小镇旅店LV.1",
		type = 2,
		group = 6,
		id = 112,
		pic = "jiudian",
		gold_gain = 1000,
		town_level = 6,
		level = 1
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.activity_town_work_level

	var_1_32[113] = {
		gold = 90000000,
		exp_display = 40,
		name = "小镇旅店LV.2",
		type = 2,
		group = 6,
		id = 113,
		pic = "jiudian",
		gold_gain = 2000,
		town_level = 6,
		level = 2
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.activity_town_work_level

	var_1_33[114] = {
		gold = 100000000,
		exp_display = 40,
		name = "小镇旅店LV.3",
		type = 2,
		group = 6,
		id = 114,
		pic = "jiudian",
		gold_gain = 3000,
		town_level = 7,
		level = 3
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.activity_town_work_level

	var_1_34[115] = {
		gold = 120000000,
		exp_display = 40,
		name = "小镇旅店LV.4",
		type = 2,
		group = 6,
		id = 115,
		pic = "jiudian",
		gold_gain = 4000,
		town_level = 7,
		level = 4
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.activity_town_work_level

	var_1_35[116] = {
		gold = 0,
		exp_display = 0,
		name = "小镇旅店LV.5",
		type = 2,
		group = 6,
		id = 116,
		pic = "jiudian",
		gold_gain = 5000,
		town_level = 0,
		level = 5
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.activity_town_work_level

	var_1_36[121] = {
		gold = 240000000,
		exp_display = 10,
		name = "小镇酒馆LV.0",
		type = 2,
		group = 7,
		id = 121,
		pic = "jiuguan",
		gold_gain = 0,
		town_level = 9,
		level = 0
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.activity_town_work_level

	var_1_37[122] = {
		gold = 250000000,
		exp_display = 10,
		name = "小镇酒馆LV.1",
		type = 2,
		group = 7,
		id = 122,
		pic = "jiuguan",
		gold_gain = 2000,
		town_level = 9,
		level = 1
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.activity_town_work_level

	var_1_38[123] = {
		gold = 260000000,
		exp_display = 10,
		name = "小镇酒馆LV.2",
		type = 2,
		group = 7,
		id = 123,
		pic = "jiuguan",
		gold_gain = 4000,
		town_level = 9,
		level = 2
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.activity_town_work_level

	var_1_39[124] = {
		gold = 280000000,
		exp_display = 10,
		name = "小镇酒馆LV.3",
		type = 2,
		group = 7,
		id = 124,
		pic = "jiuguan",
		gold_gain = 6000,
		town_level = 9,
		level = 3
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.activity_town_work_level

	var_1_40[125] = {
		gold = 300000000,
		exp_display = 10,
		name = "小镇酒馆LV.4",
		type = 2,
		group = 7,
		id = 125,
		pic = "jiuguan",
		gold_gain = 8000,
		town_level = 9,
		level = 4
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.activity_town_work_level

	var_1_41[126] = {
		gold = 0,
		exp_display = 0,
		name = "小镇酒馆LV.5",
		type = 2,
		group = 7,
		id = 126,
		pic = "jiuguan",
		gold_gain = 10000,
		town_level = 0,
		level = 5
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.activity_town_work_level

	var_1_42[131] = {
		gold = 50000000,
		exp_display = 50,
		name = "小镇办公厅LV.0",
		type = 2,
		group = 8,
		id = 131,
		pic = "jingju",
		gold_gain = 0,
		town_level = 8,
		level = 0
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.activity_town_work_level

	var_1_43[132] = {
		gold = 50000000,
		exp_display = 50,
		name = "小镇办公厅LV.1",
		type = 2,
		group = 8,
		id = 132,
		pic = "jingju",
		gold_gain = 0,
		town_level = 8,
		level = 1
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.activity_town_work_level

	var_1_44[133] = {
		gold = 100000000,
		exp_display = 60,
		name = "小镇办公厅LV.2",
		type = 2,
		group = 8,
		id = 133,
		pic = "jingju",
		gold_gain = 0,
		town_level = 9,
		level = 2
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.activity_town_work_level

	var_1_45[134] = {
		gold = 100000000,
		exp_display = 60,
		name = "小镇办公厅LV.3",
		type = 2,
		group = 8,
		id = 134,
		pic = "jingju",
		gold_gain = 0,
		town_level = 9,
		level = 3
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.activity_town_work_level

	var_1_46[135] = {
		gold = 150000000,
		exp_display = 70,
		name = "小镇办公厅LV.4",
		type = 2,
		group = 8,
		id = 135,
		pic = "jingju",
		gold_gain = 0,
		town_level = 9,
		level = 4
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.activity_town_work_level

	var_1_47[136] = {
		gold = 200000000,
		exp_display = 80,
		name = "小镇办公厅LV.5",
		type = 2,
		group = 8,
		id = 136,
		pic = "jingju",
		gold_gain = 0,
		town_level = 10,
		level = 5
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.activity_town_work_level

	var_1_48[137] = {
		gold = 400000000,
		exp_display = 90,
		name = "小镇办公厅LV.6",
		type = 2,
		group = 8,
		id = 137,
		pic = "jingju",
		gold_gain = 0,
		town_level = 10,
		level = 6
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.activity_town_work_level

	var_1_49[138] = {
		gold = 800000000,
		exp_display = 100,
		name = "小镇办公厅LV.7",
		type = 2,
		group = 8,
		id = 138,
		pic = "jingju",
		gold_gain = 0,
		town_level = 10,
		level = 7
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.activity_town_work_level

	var_1_50[139] = {
		gold = 1500000000,
		exp_display = 100,
		name = "小镇办公厅LV.8",
		type = 2,
		group = 8,
		id = 139,
		pic = "jingju",
		gold_gain = 0,
		town_level = 10,
		level = 8
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.activity_town_work_level

	var_1_51[140] = {
		gold = 3000000000,
		exp_display = 100,
		name = "小镇办公厅LV.9",
		type = 2,
		group = 8,
		id = 140,
		pic = "jingju",
		gold_gain = 0,
		town_level = 10,
		level = 9
	}
	pg = var_1_51
	var_1_51.base.activity_town_work_level[141] = {
		gold = 0,
		exp_display = 0,
		name = "小镇办公厅LV.10",
		type = 2,
		group = 8,
		id = 141,
		pic = "jingju",
		gold_gain = 0,
		town_level = 0,
		level = 10
	}

	return
end)()

return
