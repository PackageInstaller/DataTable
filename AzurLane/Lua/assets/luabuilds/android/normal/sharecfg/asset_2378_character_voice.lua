pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "character_voice") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "character_voice"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.character_voice = var_0_2
pg = var_0

local var_0_3 = var_0.character_voice

var_0_3.all = {
	"unlock",
	"login",
	"detail",
	"main1",
	"main2",
	"main3",
	"main4",
	"main5",
	"main6",
	"main7",
	"touch",
	"touch2",
	"headtouch",
	"mission",
	"mission_complete",
	"mail",
	"home",
	"feeling1",
	"feeling2",
	"feeling3",
	"feeling4",
	"feeling5",
	"propose",
	"expedition",
	"upgrade",
	"battle",
	"win_mvp",
	"lose",
	"skill",
	"hp_warning",
	"link1",
	"link2",
	"link3",
	"link4",
	"link5",
	"link6",
	"profile",
	"link7",
	"ryza_item1",
	"ryza_item2",
	"ryza_item3",
	"ryza_item4",
	"ryza_item5",
	"ryza_shop1",
	"ryza_shop2",
	"ryza_shop3",
	"ryza_shop4",
	"ryza_shop5",
	"skill_1",
	"skill_2",
	"atelier_yumia_shop_1",
	"atelier_yumia_shop_2",
	"atelier_yumia_shop_3",
	"atelier_yumia_shop_4",
	"atelier_yumia_shop_5",
	"atelier_yumia_item_1",
	"atelier_yumia_item_2",
	"atelier_yumia_item_3",
	"atelier_yumia_item_4",
	"atelier_yumia_item_5",
	"atelier_yumia_item_6",
	"atelier_yumia_item_7",
	"atelier_yumia_item_8",
	"atelier_yumia_item_9",
	"atelier_yumia_item_10",
	"atelier_yumia_item_11",
	"atelier_yumia_item_12",
	"skill_dal_1",
	"skill_dal_2",
	"dal_shop1",
	"dal_shop2",
	"dal_shop3",
	"dal_shop4",
	"dal_shop5",
	"asmr_001",
	"asmr_002",
	"asmr_003",
	"asmr_004",
	"asmr_005",
	"asmr_006",
	"asmr_007",
	"asmr_008",
	"asmr_009",
	"asmr_010",
	"gift_prefer"
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.character_voice = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.character_voice

	var_1_0.unlock = {
		voice_name = "获取",
		key = "unlock",
		resource_key = "get",
		spine_action = "stand",
		profile_index = 1,
		sp_trans_l2d = 1,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.character_voice

	var_1_1.login = {
		voice_name = "登录",
		key = "login",
		resource_key = "login",
		spine_action = "stand2",
		profile_index = 2,
		sp_trans_l2d = 0,
		l2d_action = "login",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.character_voice

	var_1_2.detail = {
		voice_name = "查看详情",
		key = "detail",
		resource_key = "detail",
		spine_action = "normal",
		profile_index = 3,
		sp_trans_l2d = 1,
		l2d_action = "detail",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.character_voice

	var_1_3.main1 = {
		voice_name = "主界面1",
		key = "main1",
		resource_key = "main_1",
		spine_action = "normal",
		profile_index = 4,
		sp_trans_l2d = 0,
		l2d_action = "main_1",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.character_voice

	var_1_4.main2 = {
		voice_name = "主界面2",
		key = "main2",
		resource_key = "main_2",
		spine_action = "normal",
		profile_index = 5,
		sp_trans_l2d = 0,
		l2d_action = "main_2",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.character_voice

	var_1_5.main3 = {
		voice_name = "主界面3",
		key = "main3",
		resource_key = "main_3",
		spine_action = "normal",
		profile_index = 6,
		sp_trans_l2d = 0,
		l2d_action = "main_3",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.character_voice

	var_1_6.main4 = {
		voice_name = "主界面4",
		key = "main4",
		resource_key = "main_4",
		spine_action = "normal",
		profile_index = 7,
		sp_trans_l2d = 0,
		l2d_action = "main_4",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.character_voice

	var_1_7.main5 = {
		voice_name = "主界面5",
		key = "main5",
		resource_key = "main_5",
		spine_action = "normal",
		profile_index = 8,
		sp_trans_l2d = 0,
		l2d_action = "main_5",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.character_voice

	var_1_8.main6 = {
		voice_name = "主界面6",
		key = "main6",
		resource_key = "main_6",
		spine_action = "normal",
		profile_index = 9,
		sp_trans_l2d = 0,
		l2d_action = "main_6",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.character_voice

	var_1_9.main7 = {
		voice_name = "主界面7",
		key = "main7",
		resource_key = "main_7",
		spine_action = "normal",
		profile_index = 10,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.character_voice

	var_1_10.touch = {
		voice_name = "普通触摸",
		key = "touch",
		resource_key = "touch_1",
		spine_action = "touch",
		profile_index = 11,
		sp_trans_l2d = 0,
		l2d_action = "touch_body",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.character_voice

	var_1_11.touch2 = {
		voice_name = "特殊触摸",
		key = "touch2",
		resource_key = "touch_2",
		spine_action = "tuozhuai",
		profile_index = 12,
		sp_trans_l2d = 0,
		l2d_action = "touch_special",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.character_voice

	var_1_12.headtouch = {
		voice_name = "摸头",
		key = "headtouch",
		resource_key = "touch_head",
		spine_action = "tuozhuai2",
		profile_index = 13,
		sp_trans_l2d = 0,
		l2d_action = "touch_head",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.character_voice

	var_1_13.mission = {
		voice_name = "任务提醒",
		key = "mission",
		resource_key = "task",
		spine_action = "move",
		profile_index = 14,
		sp_trans_l2d = 0,
		l2d_action = "mission",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.character_voice

	var_1_14.mission_complete = {
		voice_name = "任务完成",
		key = "mission_complete",
		resource_key = "mission_complete",
		spine_action = "victory",
		profile_index = 15,
		sp_trans_l2d = 0,
		l2d_action = "mission_complete",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.character_voice

	var_1_15.mail = {
		voice_name = "邮件提醒",
		key = "mail",
		resource_key = "mail",
		spine_action = "victory",
		profile_index = 16,
		sp_trans_l2d = 0,
		l2d_action = "mail",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.character_voice

	var_1_16.home = {
		voice_name = "回港",
		key = "home",
		resource_key = "home",
		spine_action = "walk",
		profile_index = 17,
		sp_trans_l2d = 0,
		l2d_action = "home",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.character_voice

	var_1_17.feeling1 = {
		voice_name = "失望",
		key = "feeling1",
		resource_key = "feeling1",
		spine_action = "normal",
		profile_index = 18,
		sp_trans_l2d = 1,
		l2d_action = "feeling1",
		unlock_condition = {
			1,
			0
		}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.character_voice

	var_1_18.feeling2 = {
		voice_name = "陌生",
		key = "feeling2",
		resource_key = "feeling2",
		spine_action = "normal",
		profile_index = 19,
		sp_trans_l2d = 1,
		l2d_action = "feeling2",
		unlock_condition = {
			1,
			3100
		}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.character_voice

	var_1_19.feeling3 = {
		voice_name = "友好",
		key = "feeling3",
		resource_key = "feeling3",
		spine_action = "normal",
		profile_index = 20,
		sp_trans_l2d = 1,
		l2d_action = "feeling3",
		unlock_condition = {
			1,
			6100
		}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.character_voice

	var_1_20.feeling4 = {
		voice_name = "喜欢",
		key = "feeling4",
		resource_key = "feeling4",
		spine_action = "normal",
		profile_index = 21,
		sp_trans_l2d = 1,
		l2d_action = "feeling4",
		unlock_condition = {
			1,
			8100
		}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.character_voice

	var_1_21.feeling5 = {
		voice_name = "爱",
		key = "feeling5",
		resource_key = "feeling5",
		spine_action = "normal",
		profile_index = 22,
		sp_trans_l2d = 1,
		l2d_action = "feeling5",
		unlock_condition = {
			1,
			10000
		}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.character_voice

	var_1_22.propose = {
		voice_name = "誓约",
		key = "propose",
		resource_key = "propose",
		spine_action = "normal",
		profile_index = 23,
		sp_trans_l2d = 0,
		l2d_action = "wedding",
		unlock_condition = {
			2,
			0
		}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.character_voice

	var_1_23.expedition = {
		voice_name = "委托完成",
		key = "expedition",
		resource_key = "expedition",
		spine_action = "victory",
		profile_index = 24,
		sp_trans_l2d = 0,
		l2d_action = "complete",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.character_voice

	var_1_24.upgrade = {
		voice_name = "强化成功",
		key = "upgrade",
		resource_key = "upgrade",
		spine_action = "victory",
		profile_index = 25,
		sp_trans_l2d = 1,
		l2d_action = "upgrade",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.character_voice

	var_1_25.battle = {
		voice_name = "旗舰开战",
		key = "battle",
		resource_key = "warcry",
		spine_action = "attack",
		profile_index = 26,
		sp_trans_l2d = 1,
		l2d_action = "battle",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.character_voice

	var_1_26.win_mvp = {
		voice_name = "胜利",
		key = "win_mvp",
		resource_key = "mvp",
		spine_action = "victory",
		profile_index = 27,
		sp_trans_l2d = 1,
		l2d_action = "win_mvp",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.character_voice

	var_1_27.lose = {
		voice_name = "失败",
		key = "lose",
		resource_key = "lose",
		spine_action = "dead",
		profile_index = 28,
		sp_trans_l2d = 1,
		l2d_action = "lose",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.character_voice

	var_1_28.skill = {
		voice_name = "技能",
		key = "skill",
		resource_key = "skill",
		spine_action = "skill",
		profile_index = 29,
		sp_trans_l2d = 1,
		l2d_action = "skill",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.character_voice

	var_1_29.hp_warning = {
		voice_name = "血量告急",
		key = "hp_warning",
		resource_key = "hp",
		spine_action = "dead",
		profile_index = 30,
		sp_trans_l2d = 1,
		l2d_action = "hp_warning",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.character_voice

	var_1_30.link1 = {
		voice_name = "战场互动1",
		key = "link1",
		resource_key = "link1",
		spine_action = "attcak",
		profile_index = 31,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.character_voice

	var_1_31.link2 = {
		voice_name = "战场互动2",
		key = "link2",
		resource_key = "link2",
		spine_action = "attcak",
		profile_index = 32,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.character_voice

	var_1_32.link3 = {
		voice_name = "战场互动3",
		key = "link3",
		resource_key = "link3",
		spine_action = "attcak",
		profile_index = 33,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.character_voice

	var_1_33.link4 = {
		voice_name = "战场互动4",
		key = "link4",
		resource_key = "link4",
		spine_action = "attcak",
		profile_index = 34,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.character_voice

	var_1_34.link5 = {
		voice_name = "战场互动5",
		key = "link5",
		resource_key = "link5",
		spine_action = "attcak",
		profile_index = 35,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.character_voice

	var_1_35.link6 = {
		voice_name = "战场互动6",
		key = "link6",
		resource_key = "link6",
		spine_action = "attcak",
		profile_index = 36,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.character_voice

	var_1_36.profile = {
		voice_name = "资料",
		key = "profile",
		resource_key = "profile",
		spine_action = "stand2",
		profile_index = 37,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.character_voice

	var_1_37.link7 = {
		voice_name = "战场互动7",
		key = "link7",
		resource_key = "link7",
		spine_action = "attcak",
		profile_index = 38,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			-1,
			0
		}
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.character_voice

	var_1_38.ryza_item1 = {
		voice_name = "素材收集1 ",
		key = "ryza_item1",
		resource_key = "ryza_item1",
		spine_action = "stand",
		profile_index = 39,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.character_voice

	var_1_39.ryza_item2 = {
		voice_name = "素材收集2",
		key = "ryza_item2",
		resource_key = "ryza_item2",
		spine_action = "stand",
		profile_index = 40,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.character_voice

	var_1_40.ryza_item3 = {
		voice_name = "素材收集3",
		key = "ryza_item3",
		resource_key = "ryza_item3",
		spine_action = "stand",
		profile_index = 41,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.character_voice

	var_1_41.ryza_item4 = {
		voice_name = "素材收集4",
		key = "ryza_item4",
		resource_key = "ryza_item4",
		spine_action = "stand",
		profile_index = 42,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.character_voice

	var_1_42.ryza_item5 = {
		voice_name = "素材收集5",
		key = "ryza_item5",
		resource_key = "ryza_item5",
		spine_action = "stand",
		profile_index = 43,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.character_voice

	var_1_43.ryza_shop1 = {
		voice_name = "商店1",
		key = "ryza_shop1",
		resource_key = "ryza_shop1",
		spine_action = "stand",
		profile_index = 44,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.character_voice

	var_1_44.ryza_shop2 = {
		voice_name = "商店2",
		key = "ryza_shop2",
		resource_key = "ryza_shop2",
		spine_action = "stand",
		profile_index = 45,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.character_voice

	var_1_45.ryza_shop3 = {
		voice_name = "商店3",
		key = "ryza_shop3",
		resource_key = "ryza_shop3",
		spine_action = "stand",
		profile_index = 46,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.character_voice

	var_1_46.ryza_shop4 = {
		voice_name = "商店4",
		key = "ryza_shop4",
		resource_key = "ryza_shop4",
		spine_action = "stand",
		profile_index = 47,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.character_voice

	var_1_47.ryza_shop5 = {
		voice_name = "商店5",
		key = "ryza_shop5",
		resource_key = "ryza_shop5",
		spine_action = "stand",
		profile_index = 48,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.character_voice

	var_1_48.skill_1 = {
		voice_name = "技能1",
		key = "skill_1",
		resource_key = "skill_1",
		spine_action = "skill",
		profile_index = 49,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.character_voice

	var_1_49.skill_2 = {
		voice_name = "技能2",
		key = "skill_2",
		resource_key = "skill_2",
		spine_action = "skill",
		profile_index = 50,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.character_voice

	var_1_50.atelier_yumia_shop_1 = {
		voice_name = "商店1",
		key = "atelier_yumia_shop_1",
		resource_key = "atelier_yumia_shop_1",
		spine_action = "stand",
		profile_index = 51,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.character_voice

	var_1_51.atelier_yumia_shop_2 = {
		voice_name = "商店2",
		key = "atelier_yumia_shop_2",
		resource_key = "atelier_yumia_shop_2",
		spine_action = "stand",
		profile_index = 52,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.character_voice

	var_1_52.atelier_yumia_shop_3 = {
		voice_name = "商店3",
		key = "atelier_yumia_shop_3",
		resource_key = "atelier_yumia_shop_3",
		spine_action = "stand",
		profile_index = 53,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.character_voice

	var_1_53.atelier_yumia_shop_4 = {
		voice_name = "商店4",
		key = "atelier_yumia_shop_4",
		resource_key = "atelier_yumia_shop_4",
		spine_action = "stand",
		profile_index = 54,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.character_voice

	var_1_54.atelier_yumia_shop_5 = {
		voice_name = "商店5",
		key = "atelier_yumia_shop_5",
		resource_key = "atelier_yumia_shop_5",
		spine_action = "stand",
		profile_index = 55,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.character_voice

	var_1_55.atelier_yumia_item_1 = {
		voice_name = "素材收集1 ",
		key = "atelier_yumia_item_1",
		resource_key = "atelier_yumia_item_1",
		spine_action = "stand",
		profile_index = 56,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_55

	local var_1_56 = var_1_55.base.character_voice

	var_1_56.atelier_yumia_item_2 = {
		voice_name = "素材收集2",
		key = "atelier_yumia_item_2",
		resource_key = "atelier_yumia_item_2",
		spine_action = "stand",
		profile_index = 57,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_56

	local var_1_57 = var_1_56.base.character_voice

	var_1_57.atelier_yumia_item_3 = {
		voice_name = "素材收集3",
		key = "atelier_yumia_item_3",
		resource_key = "atelier_yumia_item_3",
		spine_action = "stand",
		profile_index = 58,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_57

	local var_1_58 = var_1_57.base.character_voice

	var_1_58.atelier_yumia_item_4 = {
		voice_name = "素材收集4",
		key = "atelier_yumia_item_4",
		resource_key = "atelier_yumia_item_4",
		spine_action = "stand",
		profile_index = 59,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_58

	local var_1_59 = var_1_58.base.character_voice

	var_1_59.atelier_yumia_item_5 = {
		voice_name = "素材收集5",
		key = "atelier_yumia_item_5",
		resource_key = "atelier_yumia_item_5",
		spine_action = "stand",
		profile_index = 60,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_59

	local var_1_60 = var_1_59.base.character_voice

	var_1_60.atelier_yumia_item_6 = {
		voice_name = "素材收集6",
		key = "atelier_yumia_item_6",
		resource_key = "atelier_yumia_item_6",
		spine_action = "stand",
		profile_index = 61,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_60

	local var_1_61 = var_1_60.base.character_voice

	var_1_61.atelier_yumia_item_7 = {
		voice_name = "素材收集7",
		key = "atelier_yumia_item_7",
		resource_key = "atelier_yumia_item_7",
		spine_action = "stand",
		profile_index = 62,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_61

	local var_1_62 = var_1_61.base.character_voice

	var_1_62.atelier_yumia_item_8 = {
		voice_name = "素材收集8",
		key = "atelier_yumia_item_8",
		resource_key = "atelier_yumia_item_8",
		spine_action = "stand",
		profile_index = 63,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_62

	local var_1_63 = var_1_62.base.character_voice

	var_1_63.atelier_yumia_item_9 = {
		voice_name = "素材收集9",
		key = "atelier_yumia_item_9",
		resource_key = "atelier_yumia_item_9",
		spine_action = "stand",
		profile_index = 64,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_63

	local var_1_64 = var_1_63.base.character_voice

	var_1_64.atelier_yumia_item_10 = {
		voice_name = "素材收集10",
		key = "atelier_yumia_item_10",
		resource_key = "atelier_yumia_item_10",
		spine_action = "stand",
		profile_index = 65,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_64

	local var_1_65 = var_1_64.base.character_voice

	var_1_65.atelier_yumia_item_11 = {
		voice_name = "素材收集11",
		key = "atelier_yumia_item_11",
		resource_key = "atelier_yumia_item_11",
		spine_action = "stand",
		profile_index = 66,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_65

	local var_1_66 = var_1_65.base.character_voice

	var_1_66.atelier_yumia_item_12 = {
		voice_name = "素材收集12",
		key = "atelier_yumia_item_12",
		resource_key = "atelier_yumia_item_12",
		spine_action = "stand",
		profile_index = 67,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_66

	local var_1_67 = var_1_66.base.character_voice

	var_1_67.skill_dal_1 = {
		voice_name = "技能EX-1",
		key = "skill_dal_1",
		resource_key = "skill_dal_1",
		spine_action = "stand",
		profile_index = 68,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_67

	local var_1_68 = var_1_67.base.character_voice

	var_1_68.skill_dal_2 = {
		voice_name = "技能EX-2",
		key = "skill_dal_2",
		resource_key = "skill_dal_2",
		spine_action = "stand",
		profile_index = 69,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_68

	local var_1_69 = var_1_68.base.character_voice

	var_1_69.dal_shop1 = {
		voice_name = "商店1",
		key = "dal_shop1",
		resource_key = "dal_shop1",
		spine_action = "stand",
		profile_index = 70,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_69

	local var_1_70 = var_1_69.base.character_voice

	var_1_70.dal_shop2 = {
		voice_name = "商店2",
		key = "dal_shop2",
		resource_key = "dal_shop2",
		spine_action = "stand",
		profile_index = 71,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_70

	local var_1_71 = var_1_70.base.character_voice

	var_1_71.dal_shop3 = {
		voice_name = "商店3",
		key = "dal_shop3",
		resource_key = "dal_shop3",
		spine_action = "stand",
		profile_index = 72,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_71

	local var_1_72 = var_1_71.base.character_voice

	var_1_72.dal_shop4 = {
		voice_name = "商店4",
		key = "dal_shop4",
		resource_key = "dal_shop4",
		spine_action = "stand",
		profile_index = 73,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_72

	local var_1_73 = var_1_72.base.character_voice

	var_1_73.dal_shop5 = {
		voice_name = "商店5",
		key = "dal_shop5",
		resource_key = "dal_shop5",
		spine_action = "stand",
		profile_index = 74,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_73

	local var_1_74 = var_1_73.base.character_voice

	var_1_74.asmr_001 = {
		voice_name = "asmr语音1",
		key = "asmr_001",
		resource_key = "asmr_001",
		spine_action = "asmr_001",
		profile_index = 68,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_74

	local var_1_75 = var_1_74.base.character_voice

	var_1_75.asmr_002 = {
		voice_name = "asmr语音2",
		key = "asmr_002",
		resource_key = "asmr_002",
		spine_action = "asmr_002",
		profile_index = 69,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_75

	local var_1_76 = var_1_75.base.character_voice

	var_1_76.asmr_003 = {
		voice_name = "asmr语音3",
		key = "asmr_003",
		resource_key = "asmr_003",
		spine_action = "asmr_003",
		profile_index = 70,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_76

	local var_1_77 = var_1_76.base.character_voice

	var_1_77.asmr_004 = {
		voice_name = "asmr语音4",
		key = "asmr_004",
		resource_key = "asmr_004",
		spine_action = "asmr_004",
		profile_index = 71,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_77

	local var_1_78 = var_1_77.base.character_voice

	var_1_78.asmr_005 = {
		voice_name = "asmr语音5",
		key = "asmr_005",
		resource_key = "asmr_005",
		spine_action = "asmr_005",
		profile_index = 72,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_78

	local var_1_79 = var_1_78.base.character_voice

	var_1_79.asmr_006 = {
		voice_name = "asmr语音6",
		key = "asmr_006",
		resource_key = "asmr_006",
		spine_action = "asmr_006",
		profile_index = 73,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_79

	local var_1_80 = var_1_79.base.character_voice

	var_1_80.asmr_007 = {
		voice_name = "asmr语音7",
		key = "asmr_007",
		resource_key = "asmr_007",
		spine_action = "asmr_007",
		profile_index = 74,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_80

	local var_1_81 = var_1_80.base.character_voice

	var_1_81.asmr_008 = {
		voice_name = "asmr语音8",
		key = "asmr_008",
		resource_key = "asmr_008",
		spine_action = "asmr_008",
		profile_index = 75,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_81

	local var_1_82 = var_1_81.base.character_voice

	var_1_82.asmr_009 = {
		voice_name = "asmr语音9",
		key = "asmr_009",
		resource_key = "asmr_009",
		spine_action = "asmr_009",
		profile_index = 76,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_82

	local var_1_83 = var_1_82.base.character_voice

	var_1_83.asmr_010 = {
		voice_name = "asmr语音10",
		key = "asmr_010",
		resource_key = "asmr_010",
		spine_action = "asmr_010",
		profile_index = 77,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}
	pg = var_1_83
	var_1_83.base.character_voice.gift_prefer = {
		voice_name = "礼物",
		key = "gift_prefer",
		resource_key = "present_like",
		spine_action = "normal",
		profile_index = 78,
		sp_trans_l2d = 0,
		l2d_action = "",
		unlock_condition = {
			0,
			0
		}
	}

	return
end)()

return
