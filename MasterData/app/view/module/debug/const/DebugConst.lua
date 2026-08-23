local var_0_0 = {
	MOVE_X_STEP = 1,
	KNIGHT_AREA_HEIGHT = 600,
	FURNITURE_ROLE_OFF_Y = 44,
	KNIGHT_PIC_AREA_HEIGHT = 998,
	KNIGHT_HEAD_WIDTH = 100,
	KNIGHT_PIC_AREA_WIDTH = 1000,
	SCALE_MAX = 2,
	MOVE_FURNITURE_TOUCH_MAX = 200,
	CHECK_DELTA_TIME = 0.1,
	KNIGHT_PIC_HEAD_OFF_Y = 200,
	MOVE_TOUCH_MAX = 50,
	MOVE_SPINE_GAP = 5,
	MOVE_Y_STEP = 1,
	MOVE_PIC_GAP = 8,
	MOVE_FURNITURE_GAP = 5,
	SCALE_STEP = 0.01,
	KNIGHT_AREA_WIDTH = 800,
	SCALE_MIN = 0.2,
	KNIGHT_HEAD_OFF_Y = 160,
	TAB_CONFIG = {
		{
			index = 1,
			title = "GM工具",
			comp = "GMComp"
		},
		{
			index = 2,
			title = "多语言",
			comp = "DebugSwitchComp"
		},
		{
			index = 3,
			title = "立绘",
			comp = "DebugKnightComp"
		},
		{
			index = 4,
			title = "图片立绘",
			comp = "DebugKnightPicComp"
		},
		{
			index = 5,
			title = "战斗小人",
			comp = "DebugBattleActorComp"
		},
		{
			index = 6,
			title = "播放战报",
			comp = "DebugPlayBattleRecordComp"
		},
		{
			index = 7,
			title = "战报导出",
			comp = "DebugBattleEditorComp"
		},
		{
			index = 8,
			title = "家具",
			comp = "DebugFurnitureComp"
		},
		{
			index = 9,
			title = "视频测试",
			comp = "DebugCriComp"
		},
		{
			index = 10,
			title = "故障风",
			comp = "DebugGlitchComp"
		},
		{
			index = 10,
			title = "spine测试",
			comp = "DebugSpineComp"
		},
		{
			index = 11,
			title = "剧情游戏",
			comp = "DebugStoryGameComp"
		},
		{
			index = 12,
			title = "滚动文本",
			comp = "DebugScrollTextComp"
		},
		{
			index = 13,
			title = "剧情json",
			comp = "DebugCheckStoryJsonComp"
		},
		{
			index = 14,
			title = "视差特效\n引用检查",
			comp = "DebugCheckParallaxJsonComp"
		},
		{
			index = 15,
			title = "裁切遮罩",
			comp = "DebugKnightPicCheatComp"
		},
		{
			index = 16,
			title = "GVE地块\n衔接检查",
			comp = "DebugGveGridCheck"
		},
		{
			index = 16,
			title = "K-Means测试",
			comp = "DebugKMeansTest"
		},
		{
			index = 17,
			title = "寻路测试",
			comp = "DebugFindPath"
		},
		{
			index = 18,
			title = "柏青哥",
			comp = "DebugMarblesPathComp"
		},
		{
			index = 19,
			title = "多Spine\n性能测试",
			comp = "DebugMultiSpineComp"
		},
		{
			index = 20,
			title = "Navmesh2D\n三角剖分技术",
			comp = "DebugNavmesh2D"
		},
		{
			index = 21,
			title = "摇杆控制",
			comp = "DebugPubg2"
		}
	},
	ACTOR_CONFIG = {
		{
			index = 1,
			anim = "idle",
			title = "待机",
			loop = true
		},
		{
			index = 2,
			anim = "show",
			title = "个性",
			loop = true
		},
		{
			index = 3,
			anim = "run",
			title = "跑步",
			loop = true
		},
		{
			index = 4,
			anim = "attack",
			title = "攻击",
			loop = false
		},
		{
			index = 5,
			anim = "skill",
			title = "技能",
			loop = false
		},
		{
			index = 6,
			anim = "hit",
			title = "受击",
			loop = false
		},
		{
			index = 7,
			anim = "dead",
			title = "死亡",
			loop = false
		},
		{
			index = 8,
			anim = "fly",
			title = "浮空",
			loop = false
		},
		{
			index = 9,
			anim = "fall",
			title = "倒地",
			loop = false
		},
		{
			index = 10,
			anim = "back",
			title = "回跳",
			loop = false
		},
		{
			index = 11,
			anim = "in",
			title = "入场",
			loop = false
		},
		{
			index = 12,
			anim = "out",
			title = "出场",
			loop = false
		},
		{
			index = 13,
			anim = "failure",
			title = "失败",
			loop = false
		},
		{
			index = 14,
			anim = "walk",
			title = "行走",
			loop = true
		},
		{
			index = 15,
			anim = "stand",
			title = "站立",
			loop = true
		},
		{
			index = 16,
			anim = "sleep",
			title = "睡觉",
			loop = true
		},
		{
			index = 17,
			anim = "sit",
			title = "坐下",
			loop = true
		},
		{
			index = 18,
			anim = "bathe",
			title = "洗澡",
			loop = true
		},
		{
			index = 19,
			anim = "fall2",
			title = "起身",
			loop = false
		}
	},
	DRAW_KNIGHT_ANIM = {
		"happy",
		"angry",
		"shy",
		"sad"
	},
	SPINE_FILE_LIST = {
		{
			shotPath = "/res/common/effect_spine",
			name = "ui特效\neffect_spine",
			specialFileCount = {
				eff_ui_guilddungeon_baoxiang1 = 4,
				recruit_pet_draw_sr = 5,
				recruit_pet_draw_r = 5,
				recruit_artifact_draw_sr = 5,
				map_bio_dongxi_64 = 4,
				eff_ui_redpacket_ticket = 5,
				eff_ui_recruit_ssr = 6,
				wujinmengyan_kv_03 = 4,
				recruit_artifact_draw_r = 5,
				eff_ui_dungeon_start = 4,
				wujing_xuanguan_01 = 4,
				eff_ui_transistor_idle = 4,
				wujing_xuanguan_03 = 4,
				wujinmengyan_kv_02 = 4,
				wujing_xuanguan_02 = 4,
				recruit_pet_draw_ssr = 5,
				recruit_artifact_draw_ssr = 5
			}
		},
		{
			shotPath = "/res/common/knight_spine",
			name = "立绘(这个废弃)\nknight_spine"
		},
		{
			shotPath = "/res/common/battle/effect_spine",
			name = "战斗特效\nbattle/effect_spine",
			specialFileCount = {
				["500010_skill"] = 4,
				["400030_skill5"] = 4,
				["600020_skill1"] = 4,
				["400020_skill4"] = 4,
				["400120_skill_hit"] = 4,
				["302540_skill1"] = 4,
				["500070_skill2"] = 4
			}
		},
		{
			shotPath = "/res/common/battle/attr_spine",
			name = "战斗状态 \nbattle/attr_spine"
		},
		{
			shotPath = "/res/common/battle/buff_spine",
			name = "战斗buff\nbattle/buff_spine"
		},
		{
			shotPath = "/res/common/battle/knight_spine",
			name = "战斗小人\nbattle/knight_spine"
		}
	},
	PARALLAX_EFFECT_INGNORE_LIST = {
		nvzhu_denglu = true,
		recruit_pet_draw_sr = true,
		train_yxzx = true,
		jhhy_shan = true,
		recruit_artifact_draw_sr = true,
		map_bio_dongxi_2 = true,
		homeland = true,
		dlt_stage_eff_login01 = true,
		train_gwzx = true,
		wujing_xuanguan_02 = true,
		wujing_xuanguan_03 = true,
		wujinmengyan_kv_01 = true,
		wujinmengyan_kv_02 = true,
		recruit_artifact_draw_r = true,
		wujinmengyan_kv_play = true,
		train_ct = true,
		wujing_xuanguan_04 = true,
		recruit_pet_draw_ssr = true,
		wujing_xuanguan_01 = true,
		battle_guanghuan = true,
		train_xlzx = true,
		nanzhu_denglu = true,
		dungeon_stage_01_eff_xiaxue88 = true,
		recruit_pet_draw_r = true,
		train_ylzx = true,
		battle_shunyi = true,
		map_bio_dongxi_6huo = true,
		jhhy_hai = true,
		xinnian_chouqian_01 = true,
		game_turntable_times = true,
		wujinmengyan_kv_03 = true,
		recruit_artifact_draw_ssr = true
	},
	TOOL = {
		SUB_COMP = {
			"NumChangeComp",
			"DebugGameSetComp",
			"DebugOneKeyComp",
			"DebugQAComp",
			"ServerComp",
			"DebugScriptRunComp",
			"ObtClient"
		}
	}
}

var_0_0.TOOL.SEND_DATA_LIST = {
	{
		999,
		"元宝"
	},
	{
		1,
		"资源",
		"resource_info"
	},
	{
		2,
		"碎片",
		"fragment_info"
	},
	{
		3,
		"道具",
		"item_info"
	},
	{
		4,
		"武将",
		"knight_info"
	},
	{
		5,
		"合击兵符",
		"unite_token_info"
	},
	{
		6,
		"武将进阶材料",
		"knight_advance_material_info"
	},
	{
		7,
		"装备",
		"equipment_info"
	},
	{
		8,
		"宝物",
		"treasure_info"
	},
	{
		9,
		"称号",
		"title_info"
	},
	{
		10,
		"军团红包",
		"redpacket_info"
	},
	{
		11,
		"时装",
		"dress_info"
	},
	{
		12,
		"名将传道具",
		"biography_item_info"
	},
	{
		13,
		"武将变装",
		"skin_info"
	},
	{
		14,
		"神兵",
		"artifact_info"
	},
	{
		15,
		"化身卡",
		"transformation_card_info"
	},
	{
		16,
		"神翼",
		"wing_info"
	},
	{
		17,
		"神兽",
		"pet_info"
	},
	{
		18,
		"神兽装备",
		"pet_equipment_info"
	},
	{
		19,
		"将灵",
		"ksoul_info"
	},
	{
		20,
		"好感度",
		"knight_favorability_item_info"
	},
	{
		21,
		"宿舍家具",
		"furniture_info"
	},
	{
		23,
		"头像",
		"avata_info"
	},
	{
		24,
		"头像框",
		"avatar_frame_info"
	},
	{
		25,
		"场景皮肤",
		"bg_book_info"
	},
	{
		26,
		"表情包组",
		"talk_show_group_info"
	},
	{
		27,
		"圣物",
		"gve_equipment_info"
	},
	{
		33,
		"主题活动列传道具",
		"theme_biography_item_info"
	},
	{
		34,
		"限时道具",
		"expirable_item_info"
	},
	{
		35,
		"贵重品",
		"precious_info"
	},
	{
		36,
		"主角皮肤",
		"role_skin_info"
	},
	{
		37,
		"魔女",
		"succuba_info"
	},
	{
		38,
		"模拟经营道具",
		"outpost_item_info"
	}
}
var_0_0.BATTLE_EDITOR_GROUP = {
	LEFT = 0,
	RIGHT = 1
}

return var_0_0
