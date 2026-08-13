pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "commander_skill_effect_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "commander_skill_effect_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.commander_skill_effect_template = var_0_2
pg = var_0

local var_0_3 = var_0.commander_skill_effect_template

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	100111,
	100112,
	100113,
	100211,
	100212,
	100213,
	110111,
	110112,
	110113,
	110211,
	110212,
	110213,
	120111,
	120112,
	120113,
	120121,
	120122,
	120123,
	200111,
	200112,
	200113,
	200211,
	200212,
	200213,
	210111,
	210112,
	210113,
	210211,
	210212,
	210213,
	210311,
	210312,
	210313,
	210411,
	210412,
	210413,
	220111,
	220112,
	220113,
	220211,
	220212,
	220213,
	300111,
	300112,
	300113,
	300211,
	300212,
	300213,
	310111,
	310112,
	310113,
	310211,
	310212,
	310213,
	320111,
	320112,
	320113,
	320211,
	320212,
	320213,
	400111,
	400112,
	400113,
	400211,
	400212,
	400213,
	410111,
	410112,
	410113,
	410211,
	410212,
	410213,
	410311,
	410312,
	410313,
	420111,
	420112,
	420113,
	420211,
	420212,
	420213,
	9600111,
	9600112,
	9600113,
	9600211,
	9600212,
	9600213,
	9600311,
	9600312,
	9600313,
	9600411,
	9600412,
	9600413,
	9600414,
	9600511,
	9600512,
	9600513,
	9600611,
	9600612,
	9600613,
	9600711,
	9600712,
	9600713,
	9100111,
	9100112,
	9100113,
	9110111,
	9110212,
	9120121,
	9200112,
	9210213,
	9210312,
	9210411,
	9300112,
	9310113,
	9400112,
	9400113,
	9400212,
	9410213,
	99600212,
	99600311,
	99600511,
	99600711
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.commander_skill_effect_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.commander_skill_effect_template

	var_1_0[1] = {
		id = 1,
		name = "技能模板",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.commander_skill_effect_template

	var_1_1[2] = {
		id = 2,
		name = "技能模板",
		effect_type = "attack",
		args = {
			"torpedo",
			10000,
			200
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.commander_skill_effect_template

	var_1_2[3] = {
		id = 3,
		name = "技能模板",
		effect_type = "strategy",
		args = {
			9,
			1
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			},
			{
				"around_combat_ally",
				1
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.commander_skill_effect_template

	var_1_3[4] = {
		id = 4,
		name = "技能模板",
		effect_type = "battle_buff",
		args = {
			20001
		},
		condition = {
			{
				"dd_head"
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.commander_skill_effect_template

	var_1_4[5] = {
		id = 5,
		name = "技能模板",
		effect_type = "airfight_doge",
		args = {
			5000
		},
		condition = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.commander_skill_effect_template

	var_1_5[6] = {
		id = 6,
		name = "技能模板",
		effect_type = "ambush_doge",
		args = {
			5000
		},
		condition = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.commander_skill_effect_template

	var_1_6[7] = {
		id = 7,
		name = "技能模板",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"around_enemy",
				3,
				1
			}
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.commander_skill_effect_template

	var_1_7[8] = {
		id = 8,
		name = "技能模板",
		effect_type = "battle_buff",
		args = {
			20002
		},
		condition = {
			{
				"battle_buff_not_active",
				20003
			}
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.commander_skill_effect_template

	var_1_8[9] = {
		id = 9,
		name = "技能模板",
		effect_type = "attack",
		args = {
			"airfight",
			5000,
			200
		},
		condition = {}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.commander_skill_effect_template

	var_1_9[10] = {
		id = 10,
		name = "技能模板",
		effect_type = "battle_buff",
		args = {
			20004
		},
		condition = {
			{
				"count",
				{
					1,
					20
				},
				1,
				1
			},
			{
				"vang_count",
				1,
				1
			}
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.commander_skill_effect_template

	var_1_10[11] = {
		id = 11,
		name = "技能模板",
		effect_type = "hunt_lv",
		args = {
			1
		},
		condition = {}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.commander_skill_effect_template

	var_1_11[12] = {
		id = 12,
		name = "技能模板",
		effect_type = "torpedo_power_up",
		args = {
			0.01,
			2800
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.commander_skill_effect_template

	var_1_12[13] = {
		id = 13,
		name = "技能模板",
		effect_type = "battle_buff",
		args = {
			20005
		},
		condition = {
			{
				"around_enemy",
				0,
				2
			}
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.commander_skill_effect_template

	var_1_13[14] = {
		id = 14,
		name = "技能模板",
		effect_type = "battle_buff",
		args = {
			40010,
			5000
		},
		condition = {}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.commander_skill_effect_template

	var_1_14[15] = {
		id = 100111,
		name = "31节的正义",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				3,
				6
			}
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.commander_skill_effect_template

	var_1_15[16] = {
		id = 100112,
		name = "31节的正义",
		effect_type = "attack",
		args = {
			"torpedo",
			102,
			1500,
			0.3,
			600
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			},
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.commander_skill_effect_template

	var_1_16[17] = {
		id = 100113,
		name = "31节的正义",
		effect_type = "strategy",
		args = {
			9,
			1
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			},
			{
				"pos",
				1
			},
			{
				"around_combat_ally",
				1
			}
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.commander_skill_effect_template

	var_1_17[100211] = {
		id = 100211,
		name = "王牌射手",
		effect_type = "battle_buff",
		args = {
			40210
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					1,
					2,
					3,
					4,
					5,
					6
				}
			}
		}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.commander_skill_effect_template

	var_1_18[100212] = {
		id = 100212,
		name = "王牌射手",
		effect_type = "battle_buff",
		args = {
			40220
		},
		condition = {}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.commander_skill_effect_template

	var_1_19[100213] = {
		id = 100213,
		name = "王牌射手",
		effect_type = "battle_buff",
		args = {
			40230
		},
		condition = {}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.commander_skill_effect_template

	var_1_20[31] = {
		id = 110111,
		name = "5英寸的勇气",
		effect_type = "attack",
		args = {
			"torpedo",
			102,
			1500,
			0.3,
			600
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				1,
				6
			},
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.commander_skill_effect_template

	var_1_21[110112] = {
		id = 110112,
		name = "5英寸的勇气",
		effect_type = "battle_buff",
		args = {
			40000
		},
		condition = {
			{
				"dd_head"
			}
		}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.commander_skill_effect_template

	var_1_22[110113] = {
		id = 110113,
		name = "5英寸的勇气",
		effect_type = "battle_buff",
		args = {
			40002
		},
		condition = {
			{
				"dd_head"
			}
		}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.commander_skill_effect_template

	var_1_23[3] = {
		id = 110211,
		name = "幸运之翼",
		effect_type = "battle_buff",
		args = {
			442610
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.commander_skill_effect_template

	var_1_24[4] = {
		id = 110212,
		name = "幸运之翼",
		effect_type = "airfight_doge",
		args = {
			102,
			0.05,
			10,
			250
		},
		condition = {}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.commander_skill_effect_template

	var_1_25[5] = {
		id = 110213,
		name = "幸运之翼",
		effect_type = "battle_buff",
		args = {
			441320
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.commander_skill_effect_template

	var_1_26[120111] = {
		id = 120111,
		name = "空母后勤",
		effect_type = "battle_buff",
		args = {
			443610
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.commander_skill_effect_template

	var_1_27[120112] = {
		id = 120112,
		name = "空母后勤",
		effect_type = "battle_buff",
		args = {
			441310
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.commander_skill_effect_template

	var_1_28[120113] = {
		id = 120113,
		name = "空母后勤",
		effect_type = "battle_buff",
		args = {
			442810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.commander_skill_effect_template

	var_1_29[120121] = {
		id = 120121,
		name = "雷达侦察",
		effect_type = "ambush_doge",
		args = {
			101,
			0.05,
			10,
			250
		},
		condition = {}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.commander_skill_effect_template

	var_1_30[120122] = {
		id = 120122,
		name = "雷达侦察",
		effect_type = "battle_buff",
		args = {
			422810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.commander_skill_effect_template

	var_1_31[120123] = {
		id = 120123,
		name = "雷达侦察",
		effect_type = "battle_buff",
		args = {
			421110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.commander_skill_effect_template

	var_1_32[200111] = {
		id = 200111,
		name = "尽忠职守",
		effect_type = "battle_buff",
		args = {
			40020
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.commander_skill_effect_template

	var_1_33[200112] = {
		id = 200112,
		name = "尽忠职守",
		effect_type = "battle_buff",
		args = {
			40040
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"around_land",
				1
			}
		}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.commander_skill_effect_template

	var_1_34[200113] = {
		id = 200113,
		name = "尽忠职守",
		effect_type = "battle_buff",
		args = {
			40030
		},
		condition = {}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.commander_skill_effect_template

	var_1_35[19] = {
		id = 200211,
		name = "狡黠之灌",
		effect_type = "battle_buff",
		args = {
			40240
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.commander_skill_effect_template

	var_1_36[20] = {
		id = 200212,
		name = "狡黠之灌",
		effect_type = "battle_buff",
		args = {
			40250
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.commander_skill_effect_template

	var_1_37[21] = {
		id = 200213,
		name = "狡黠之灌",
		effect_type = "battle_buff",
		args = {
			40260
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.commander_skill_effect_template

	var_1_38[210111] = {
		id = 210111,
		name = "物资拦截者",
		effect_type = "battle_buff",
		args = {
			423910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.commander_skill_effect_template

	var_1_39[210112] = {
		id = 210112,
		name = "物资拦截者",
		effect_type = "battle_buff",
		args = {
			422130
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					10,
					11,
					12
				}
			},
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.commander_skill_effect_template

	var_1_40[210113] = {
		id = 210113,
		name = "物资拦截者",
		effect_type = "battle_buff",
		args = {
			421220
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.commander_skill_effect_template

	var_1_41[210211] = {
		id = 210211,
		name = "斥候猎手",
		effect_type = "battle_buff",
		args = {
			412820
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					1,
					2,
					3
				}
			},
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.commander_skill_effect_template

	var_1_42[210212] = {
		id = 210212,
		name = "斥候猎手",
		effect_type = "battle_buff",
		args = {
			413920
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.commander_skill_effect_template

	var_1_43[210213] = {
		id = 210213,
		name = "斥候猎手",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"around_enemy",
				3,
				{
					1,
					2,
					3
				}
			}
		}
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.commander_skill_effect_template

	var_1_44[7] = {
		id = 210311,
		name = "守望者",
		effect_type = "battle_buff",
		args = {
			442810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.commander_skill_effect_template

	var_1_45[8] = {
		id = 210312,
		name = "守望者",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"around_enemy",
				2,
				{
					1,
					2,
					3
				}
			}
		}
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.commander_skill_effect_template

	var_1_46[9] = {
		id = 210313,
		name = "守望者",
		effect_type = "battle_buff",
		args = {
			441320
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.commander_skill_effect_template

	var_1_47[210411] = {
		id = 210411,
		name = "无畏的骑士",
		effect_type = "ambush_doge",
		args = {
			102,
			0.05,
			10,
			250
		},
		condition = {}
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.commander_skill_effect_template

	var_1_48[210412] = {
		id = 210412,
		name = "无畏的骑士",
		effect_type = "battle_buff",
		args = {
			432610
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.commander_skill_effect_template

	var_1_49[210413] = {
		id = 210413,
		name = "无畏的骑士",
		effect_type = "battle_buff",
		args = {
			40050
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.commander_skill_effect_template

	var_1_50[220111] = {
		id = 220111,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			433610
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.commander_skill_effect_template

	var_1_51[220112] = {
		id = 220112,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			433810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.commander_skill_effect_template

	var_1_52[220113] = {
		id = 220113,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			433110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.commander_skill_effect_template

	var_1_53[220211] = {
		id = 220211,
		name = "巡洋战术",
		effect_type = "battle_buff",
		args = {
			422110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.commander_skill_effect_template

	var_1_54[220212] = {
		id = 220212,
		name = "巡洋战术",
		effect_type = "battle_buff",
		args = {
			422810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.commander_skill_effect_template

	var_1_55[220213] = {
		id = 220213,
		name = "巡洋战术",
		effect_type = "battle_buff",
		args = {
			422910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_55

	local var_1_56 = var_1_55.base.commander_skill_effect_template

	var_1_56[300111] = {
		id = 300111,
		name = "反击的一拳",
		effect_type = "battle_buff",
		args = {
			40110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_56

	local var_1_57 = var_1_56.base.commander_skill_effect_template

	var_1_57[300112] = {
		id = 300112,
		name = "反击的一拳",
		effect_type = "ambush_doge",
		args = {
			103,
			0.05,
			10,
			250
		},
		condition = {}
	}
	pg = var_1_57

	local var_1_58 = var_1_57.base.commander_skill_effect_template

	var_1_58[300113] = {
		id = 300113,
		name = "反击的一拳",
		effect_type = "battle_buff",
		args = {
			40120
		},
		condition = {
			{
				"count",
				{
					6,
					7
				},
				1,
				1
			}
		}
	}
	pg = var_1_58

	local var_1_59 = var_1_58.base.commander_skill_effect_template

	var_1_59[300211] = {
		id = 300211,
		name = "敢勇当先",
		effect_type = "battle_buff",
		args = {
			40270
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_59

	local var_1_60 = var_1_59.base.commander_skill_effect_template

	var_1_60[300212] = {
		id = 300212,
		name = "敢勇当先",
		effect_type = "battle_buff",
		args = {
			40280
		},
		condition = {
			{
				"around_enemy",
				2,
				{
					4,
					5,
					6
				}
			},
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_60

	local var_1_61 = var_1_60.base.commander_skill_effect_template

	var_1_61[300213] = {
		id = 300213,
		name = "敢勇当先",
		effect_type = "battle_buff",
		args = {
			40290
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					4,
					5,
					6
				}
			},
			{
				"pos",
				1
			}
		}
	}
	pg = var_1_61

	local var_1_62 = var_1_61.base.commander_skill_effect_template

	var_1_62[310111] = {
		id = 310111,
		name = "必杀·三段击",
		effect_type = "battle_buff",
		args = {
			442810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_62

	local var_1_63 = var_1_62.base.commander_skill_effect_template

	var_1_63[310112] = {
		id = 310112,
		name = "必杀·三段击",
		effect_type = "battle_buff",
		args = {
			441320
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_63

	local var_1_64 = var_1_63.base.commander_skill_effect_template

	var_1_64[310113] = {
		id = 310113,
		name = "必杀·三段击",
		effect_type = "attack",
		args = {
			"airfight",
			102,
			1500,
			0.3,
			600
		},
		condition = {
			{
				"count",
				{
					6,
					7
				},
				1,
				3
			}
		}
	}
	pg = var_1_64

	local var_1_65 = var_1_64.base.commander_skill_effect_template

	var_1_65[310211] = {
		id = 310211,
		name = "野性的直觉",
		effect_type = "battle_buff",
		args = {
			411910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_65

	local var_1_66 = var_1_65.base.commander_skill_effect_template

	var_1_66[310212] = {
		id = 310212,
		name = "野性的直觉",
		effect_type = "battle_buff",
		args = {
			413220
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_66

	local var_1_67 = var_1_66.base.commander_skill_effect_template

	var_1_67[310213] = {
		id = 310213,
		name = "野性的直觉",
		effect_type = "battle_buff",
		args = {
			40150
		},
		condition = {
			{
				"count",
				{
					1,
					20
				},
				1,
				1
			},
			{
				"vang_count",
				1,
				1
			},
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_67

	local var_1_68 = var_1_67.base.commander_skill_effect_template

	var_1_68[320111] = {
		id = 320111,
		name = "巡洋指挥",
		effect_type = "battle_buff",
		args = {
			421110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_68

	local var_1_69 = var_1_68.base.commander_skill_effect_template

	var_1_69[320112] = {
		id = 320112,
		name = "巡洋指挥",
		effect_type = "battle_buff",
		args = {
			423210
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_69

	local var_1_70 = var_1_69.base.commander_skill_effect_template

	var_1_70[320113] = {
		id = 320113,
		name = "巡洋指挥",
		effect_type = "battle_buff",
		args = {
			421210
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_70

	local var_1_71 = var_1_70.base.commander_skill_effect_template

	var_1_71[320211] = {
		id = 320211,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			433810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_71

	local var_1_72 = var_1_71.base.commander_skill_effect_template

	var_1_72[320212] = {
		id = 320212,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			431410
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_72

	local var_1_73 = var_1_72.base.commander_skill_effect_template

	var_1_73[320213] = {
		id = 320213,
		name = "战列后勤",
		effect_type = "battle_buff",
		args = {
			432110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_73

	local var_1_74 = var_1_73.base.commander_skill_effect_template

	var_1_74[400111] = {
		id = 400111,
		name = "静寂的狩猎者",
		effect_type = "battle_buff",
		args = {
			40180
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_74

	local var_1_75 = var_1_74.base.commander_skill_effect_template

	var_1_75[400112] = {
		id = 400112,
		name = "静寂的狩猎者",
		effect_type = "hunt_lv",
		args = {
			1
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_75

	local var_1_76 = var_1_75.base.commander_skill_effect_template

	var_1_76[400113] = {
		id = 400113,
		name = "静寂的狩猎者",
		effect_type = "torpedo_power_up",
		args = {
			102,
			0.1,
			10,
			125
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_76

	local var_1_77 = var_1_76.base.commander_skill_effect_template

	var_1_77[400211] = {
		id = 400211,
		name = "不屈的意志",
		effect_type = "battle_buff",
		args = {
			40300
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_77

	local var_1_78 = var_1_77.base.commander_skill_effect_template

	var_1_78[400212] = {
		id = 400212,
		name = "不屈的意志",
		effect_type = "attack",
		args = {
			"cannon",
			102,
			1500,
			0.3,
			600
		},
		condition = {
			{
				"count",
				{
					4,
					5
				},
				1,
				3
			},
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_78

	local var_1_79 = var_1_78.base.commander_skill_effect_template

	var_1_79[400213] = {
		id = 400213,
		name = "不屈的意志",
		effect_type = "battle_buff",
		args = {
			40310
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					4,
					5,
					6
				}
			},
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_79

	local var_1_80 = var_1_79.base.commander_skill_effect_template

	var_1_80[410111] = {
		id = 410111,
		name = "海之铁骑士",
		effect_type = "battle_buff",
		args = {
			431910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_80

	local var_1_81 = var_1_80.base.commander_skill_effect_template

	var_1_81[0] = {
		id = 410112,
		name = "海之铁骑士",
		effect_type = "battle_buff",
		args = {
			432820
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_81

	local var_1_82 = var_1_81.base.commander_skill_effect_template

	var_1_82[1] = {
		id = 410113,
		name = "海之铁骑士",
		effect_type = "battle_buff",
		args = {
			40200
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					4,
					5,
					6
				}
			}
		}
	}
	pg = var_1_82

	local var_1_83 = var_1_82.base.commander_skill_effect_template

	var_1_83[410211] = {
		id = 410211,
		name = "海之勇者",
		effect_type = "battle_buff",
		args = {
			451210
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_83

	local var_1_84 = var_1_83.base.commander_skill_effect_template

	var_1_84[410212] = {
		id = 410212,
		name = "海之勇者",
		effect_type = "battle_buff",
		args = {
			451820
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_84

	local var_1_85 = var_1_84.base.commander_skill_effect_template

	var_1_85[410213] = {
		id = 410213,
		name = "海之勇者",
		effect_type = "hunt_lv",
		args = {
			1
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_85

	local var_1_86 = var_1_85.base.commander_skill_effect_template

	var_1_86[410311] = {
		id = 410311,
		name = "守护之心",
		effect_type = "battle_buff",
		args = {
			451210
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_86

	local var_1_87 = var_1_86.base.commander_skill_effect_template

	var_1_87[410312] = {
		id = 410312,
		name = "守护之心",
		effect_type = "battle_buff",
		args = {
			451920
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_87

	local var_1_88 = var_1_87.base.commander_skill_effect_template

	var_1_88[410313] = {
		id = 410313,
		name = "守护之心",
		effect_type = "battle_buff",
		args = {
			40060
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_1_88

	local var_1_89 = var_1_88.base.commander_skill_effect_template

	var_1_89[15] = {
		id = 420111,
		name = "巡洋后勤",
		effect_type = "battle_buff",
		args = {
			423910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_89

	local var_1_90 = var_1_89.base.commander_skill_effect_template

	var_1_90[16] = {
		id = 420112,
		name = "巡洋后勤",
		effect_type = "battle_buff",
		args = {
			423110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_90

	local var_1_91 = var_1_90.base.commander_skill_effect_template

	var_1_91[17] = {
		id = 420113,
		name = "巡洋后勤",
		effect_type = "battle_buff",
		args = {
			421110
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_91

	local var_1_92 = var_1_91.base.commander_skill_effect_template

	var_1_92[420211] = {
		id = 420211,
		name = "驱逐指挥",
		effect_type = "battle_buff",
		args = {
			411910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_92

	local var_1_93 = var_1_92.base.commander_skill_effect_template

	var_1_93[420212] = {
		id = 420212,
		name = "驱逐指挥",
		effect_type = "battle_buff",
		args = {
			412810
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_93

	local var_1_94 = var_1_93.base.commander_skill_effect_template

	var_1_94[420213] = {
		id = 420213,
		name = "驱逐指挥",
		effect_type = "battle_buff",
		args = {
			413210
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_1_94

	local var_1_95 = var_1_94.base.commander_skill_effect_template

	var_1_95[9600111] = {
		id = 9600111,
		name = "环球航行",
		effect_type = "battle_buff",
		args = {
			40400
		},
		condition = {}
	}
	pg = var_1_95

	local var_1_96 = var_1_95.base.commander_skill_effect_template

	var_1_96[9600112] = {
		id = 9600112,
		name = "环球航行",
		effect_type = "battle_buff",
		args = {
			40410
		},
		condition = {
			{
				"count",
				{
					22,
					23,
					24
				},
				1,
				6
			}
		}
	}
	pg = var_1_96

	local var_1_97 = var_1_96.base.commander_skill_effect_template

	var_1_97[9600113] = {
		id = 9600113,
		name = "环球航行",
		effect_type = "battle_buff",
		args = {
			40420
		},
		condition = {}
	}
	pg = var_1_97

	local var_1_98 = var_1_97.base.commander_skill_effect_template

	var_1_98[9600211] = {
		id = 9600211,
		name = "私掠者的是与非",
		effect_type = "battle_buff",
		args = {
			40430
		},
		condition = {}
	}
	pg = var_1_98
	var_1_98.base.commander_skill_effect_template[9600212] = {
		id = 9600212,
		name = "私掠者的是与非",
		effect_type = "move_speed",
		args = {
			1
		},
		condition = {
			{
				"around_enemy",
				3,
				{
					1,
					2,
					3
				}
			}
		}
	}

	return
end)()
;(function()
	pg = var_1_10000

	local var_2_0 = var_1_10000.base.commander_skill_effect_template

	var_2_0[9600213] = {
		id = 9600213,
		name = "私掠者的是与非",
		effect_type = "battle_buff",
		args = {
			40450
		},
		condition = {
			{
				"count",
				{
					22,
					23,
					24
				},
				1,
				6
			}
		}
	}
	pg = var_2_0

	local var_2_1 = var_2_0.base.commander_skill_effect_template

	var_2_1[9600311] = {
		id = 9600311,
		name = "“高速”的山姆",
		effect_type = "hunt_lv",
		args = {
			1
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_1

	local var_2_2 = var_2_1.base.commander_skill_effect_template

	var_2_2[9600312] = {
		id = 9600312,
		name = "“高速”的山姆",
		effect_type = "battle_buff",
		args = {
			40460
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_2

	local var_2_3 = var_2_2.base.commander_skill_effect_template

	var_2_3[9600313] = {
		id = 9600313,
		name = "“高速”的山姆",
		effect_type = "battle_buff",
		args = {
			40470
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_3

	local var_2_4 = var_2_3.base.commander_skill_effect_template

	var_2_4[27] = {
		id = 9600411,
		name = "攻夺与幻想",
		effect_type = "battle_buff",
		args = {
			40490
		},
		condition = {
			{
				"count",
				{
					22,
					23,
					24
				},
				1,
				6
			}
		}
	}
	pg = var_2_4

	local var_2_5 = var_2_4.base.commander_skill_effect_template

	var_2_5[28] = {
		id = 9600412,
		name = "攻夺与幻想",
		effect_type = "battle_buff",
		args = {
			40500
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_2_5

	local var_2_6 = var_2_5.base.commander_skill_effect_template

	var_2_6[29] = {
		id = 9600413,
		name = "攻夺与幻想",
		effect_type = "battle_buff",
		args = {
			40510
		},
		condition = {}
	}
	pg = var_2_6

	local var_2_7 = var_2_6.base.commander_skill_effect_template

	var_2_7[30] = {
		id = 9600414,
		name = "攻夺与幻想",
		effect_type = "battle_buff",
		args = {
			40490
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_7

	local var_2_8 = var_2_7.base.commander_skill_effect_template

	var_2_8[9600511] = {
		id = 9600511,
		name = "戒律的订立者",
		effect_type = "hunt_lv",
		args = {
			1
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_8

	local var_2_9 = var_2_8.base.commander_skill_effect_template

	var_2_9[0] = {
		id = 9600512,
		name = "戒律的订立者",
		effect_type = "battle_buff",
		args = {
			40520
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_9

	local var_2_10 = var_2_9.base.commander_skill_effect_template

	var_2_10[1] = {
		id = 9600513,
		name = "戒律的订立者",
		effect_type = "battle_buff",
		args = {
			40530
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_10

	local var_2_11 = var_2_10.base.commander_skill_effect_template

	var_2_11[9600611] = {
		id = 9600611,
		name = "未了的传奇",
		effect_type = "battle_buff",
		args = {
			40550
		},
		condition = {}
	}
	pg = var_2_11

	local var_2_12 = var_2_11.base.commander_skill_effect_template

	var_2_12[9600612] = {
		id = 9600612,
		name = "未了的传奇",
		effect_type = "battle_buff",
		args = {
			40560
		},
		condition = {
			{
				"around_enemy",
				0,
				{
					4,
					5,
					6
				}
			}
		}
	}
	pg = var_2_12

	local var_2_13 = var_2_12.base.commander_skill_effect_template

	var_2_13[9600613] = {
		id = 9600613,
		name = "未了的传奇",
		effect_type = "battle_buff",
		args = {
			40570
		},
		condition = {}
	}
	pg = var_2_13

	local var_2_14 = var_2_13.base.commander_skill_effect_template

	var_2_14[9600711] = {
		id = 9600711,
		name = "绅士海盗的传说",
		effect_type = "ambush_doge",
		args = {
			103,
			0.05,
			10,
			250
		},
		condition = {}
	}
	pg = var_2_14

	local var_2_15 = var_2_14.base.commander_skill_effect_template

	var_2_15[9600712] = {
		id = 9600712,
		name = "绅士海盗的传说",
		effect_type = "battle_buff",
		args = {
			40590
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_15

	local var_2_16 = var_2_15.base.commander_skill_effect_template

	var_2_16[9600713] = {
		id = 9600713,
		name = "绅士海盗的传说",
		effect_type = "battle_buff",
		args = {
			40600
		},
		condition = {}
	}
	pg = var_2_16

	local var_2_17 = var_2_16.base.commander_skill_effect_template

	var_2_17[9100111] = {
		id = 9100111,
		name = "31节的正义",
		effect_type = "battle_buff",
		args = {
			412220
		},
		condition = {
			{
				"count",
				{
					1,
					20,
					21
				},
				3,
				6
			}
		}
	}
	pg = var_2_17

	local var_2_18 = var_2_17.base.commander_skill_effect_template

	var_2_18[9100112] = {
		id = 9100112,
		name = "31节的正义",
		effect_type = "battle_buff",
		args = {
			40320
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_2_18

	local var_2_19 = var_2_18.base.commander_skill_effect_template

	var_2_19[9100113] = {
		id = 9100113,
		name = "31节的正义",
		effect_type = "battle_buff",
		args = {
			40325
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_2_19

	local var_2_20 = var_2_19.base.commander_skill_effect_template

	var_2_20[9110111] = {
		id = 9110111,
		name = "5英寸的勇气",
		effect_type = "battle_buff",
		args = {
			411210
		},
		condition = {
			{
				"pos",
				1
			}
		}
	}
	pg = var_2_20

	local var_2_21 = var_2_20.base.commander_skill_effect_template

	var_2_21[9110212] = {
		id = 9110212,
		name = "幸运之翼",
		effect_type = "battle_buff",
		args = {
			40330
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_21

	local var_2_22 = var_2_21.base.commander_skill_effect_template

	var_2_22[9120121] = {
		id = 9120121,
		name = "雷达侦察",
		effect_type = "battle_buff",
		args = {
			423910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_22

	local var_2_23 = var_2_22.base.commander_skill_effect_template

	var_2_23[9200112] = {
		id = 9200112,
		name = "尽忠职守",
		effect_type = "battle_buff",
		args = {
			40340
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_23

	local var_2_24 = var_2_23.base.commander_skill_effect_template

	var_2_24[9210213] = {
		id = 9210213,
		name = "斥候猎手",
		effect_type = "battle_buff",
		args = {
			411910
		},
		condition = {
			{
				"around_enemy",
				3,
				{
					1,
					2,
					3
				}
			}
		}
	}
	pg = var_2_24

	local var_2_25 = var_2_24.base.commander_skill_effect_template

	var_2_25[9210312] = {
		id = 9210312,
		name = "守望者",
		effect_type = "battle_buff",
		args = {
			411910
		},
		condition = {
			{
				"around_enemy",
				2,
				{
					1,
					2,
					3
				}
			}
		}
	}
	pg = var_2_25

	local var_2_26 = var_2_25.base.commander_skill_effect_template

	var_2_26[9210411] = {
		id = 9210411,
		name = "无畏的骑士",
		effect_type = "battle_buff",
		args = {
			433910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_26

	local var_2_27 = var_2_26.base.commander_skill_effect_template

	var_2_27[16] = {
		id = 9300112,
		name = "反击的一拳",
		effect_type = "battle_buff",
		args = {
			443910
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_27

	local var_2_28 = var_2_27.base.commander_skill_effect_template

	var_2_28[9310113] = {
		id = 9310113,
		name = "必杀·三段击",
		effect_type = "battle_buff",
		args = {
			40350
		},
		condition = {}
	}
	pg = var_2_28

	local var_2_29 = var_2_28.base.commander_skill_effect_template

	var_2_29[9400112] = {
		id = 9400112,
		name = "静寂的狩猎者",
		effect_type = "battle_buff",
		args = {
			40360
		},
		condition = {
			{
				"pos",
				1
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_29

	local var_2_30 = var_2_29.base.commander_skill_effect_template

	var_2_30[9400113] = {
		id = 9400113,
		name = "静寂的狩猎者",
		effect_type = "battle_buff",
		args = {
			40370
		},
		condition = {
			{
				"pos",
				1
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_30

	local var_2_31 = var_2_30.base.commander_skill_effect_template

	var_2_31[20] = {
		id = 9400212,
		name = "不屈的意志",
		effect_type = "battle_buff",
		args = {
			40380
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}
	pg = var_2_31

	local var_2_32 = var_2_31.base.commander_skill_effect_template

	var_2_32[9410213] = {
		id = 9410213,
		name = "海之勇者",
		effect_type = "battle_buff",
		args = {
			40390
		},
		condition = {
			{
				"pos",
				2
			},
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_32

	local var_2_33 = var_2_32.base.commander_skill_effect_template

	var_2_33[99600212] = {
		id = 99600212,
		name = "私掠者的是非",
		effect_type = "battle_buff",
		args = {
			40440
		},
		condition = {
			{
				"around_enemy",
				3,
				{
					1,
					2,
					3
				}
			}
		}
	}
	pg = var_2_33

	local var_2_34 = var_2_33.base.commander_skill_effect_template

	var_2_34[99600311] = {
		id = 99600311,
		name = "“高速”的山姆",
		effect_type = "battle_buff",
		args = {
			40480
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_34

	local var_2_35 = var_2_34.base.commander_skill_effect_template

	var_2_35[99600511] = {
		id = 99600511,
		name = "戒律的订立者",
		effect_type = "battle_buff",
		args = {
			40540
		},
		condition = {
			{
				"insubteam",
				1
			}
		}
	}
	pg = var_2_35
	var_2_35.base.commander_skill_effect_template[99600711] = {
		id = 99600711,
		name = "绅士海盗的传说",
		effect_type = "battle_buff",
		args = {
			40580
		},
		condition = {
			{
				"pos",
				2
			}
		}
	}

	return
end)()

return
