local var_0_0 = {
	SCALE_MAX = 2,
	SCALE_MIN = 0.2,
	MOVE_TOUCH_MAX = 50,
	MOVE_SPINE_GAP = 5,
	KNIGHT_HEAD_WIDTH = 100,
	MOVE_X_STEP = 1,
	FURNITURE_ROLE_OFF_Y = 44,
	MOVE_FURNITURE_TOUCH_MAX = 200,
	MOVE_FURNITURE_GAP = 5,
	KNIGHT_PIC_HEAD_OFF_Y = 200,
	KNIGHT_PIC_AREA_HEIGHT = 998,
	KNIGHT_PIC_AREA_WIDTH = 1000,
	MOVE_PIC_GAP = 8,
	KNIGHT_HEAD_OFF_Y = 160,
	KNIGHT_AREA_HEIGHT = 600,
	KNIGHT_AREA_WIDTH = 800,
	CHECK_DELTA_TIME = 0.1,
	MOVE_Y_STEP = 1,
	SCALE_STEP = 0.01,
	TAB_CONFIG = {
		{
			title = "GM工具",
			index = 1,
			comp = "GMComp"
		},
		{
			title = "多语言",
			index = 2,
			comp = "DebugSwitchComp"
		},
		{
			title = "立绘",
			index = 3,
			comp = "DebugKnightComp"
		},
		{
			title = "图片立绘",
			index = 4,
			comp = "DebugKnightPicComp"
		},
		{
			title = "战斗小人",
			index = 5,
			comp = "DebugBattleActorComp"
		},
		{
			title = "播放战报",
			index = 6,
			comp = "DebugPlayBattleRecordComp"
		},
		{
			title = "战报导出",
			index = 7,
			comp = "DebugBattleEditorComp"
		},
		{
			title = "家具",
			index = 8,
			comp = "DebugFurnitureComp"
		},
		{
			title = "视频测试",
			index = 9,
			comp = "DebugCriComp"
		},
		{
			title = "故障风",
			index = 10,
			comp = "DebugGlitchComp"
		},
		{
			title = "spine测试",
			index = 10,
			comp = "DebugSpineComp"
		},
		{
			title = "剧情游戏",
			index = 11,
			comp = "DebugStoryGameComp"
		},
		{
			title = "滚动文本",
			index = 12,
			comp = "DebugScrollTextComp"
		},
		{
			title = "剧情json",
			index = 13,
			comp = "DebugCheckStoryJsonComp"
		},
		{
			title = "视差特效\n引用检查",
			index = 14,
			comp = "DebugCheckParallaxJsonComp"
		},
		{
			title = "裁切遮罩",
			index = 15,
			comp = "DebugKnightPicCheatComp"
		},
		{
			title = "GVE地块\n衔接检查",
			index = 16,
			comp = "DebugGveGridCheck"
		},
		{
			title = "K-Means测试",
			index = 16,
			comp = "DebugKMeansTest"
		},
		{
			title = "寻路测试",
			index = 17,
			comp = "DebugFindPath"
		},
		{
			title = "柏青哥",
			index = 18,
			comp = "DebugMarblesPathComp"
		},
		{
			title = "多Spine\n性能测试",
			index = 19,
			comp = "DebugMultiSpineComp"
		},
		{
			title = "Navmesh2D\n三角剖分技术",
			index = 20,
			comp = "DebugNavmesh2D"
		},
		{
			title = "摇杆控制",
			index = 21,
			comp = "DebugPubg2"
		}
	},
	ACTOR_CONFIG = {
		{
			title = "待机",
			index = 1,
			loop = true,
			anim = "idle"
		},
		{
			title = "个性",
			index = 2,
			loop = true,
			anim = "show"
		},
		{
			title = "跑步",
			index = 3,
			loop = true,
			anim = "run"
		},
		{
			title = "攻击",
			index = 4,
			loop = false,
			anim = "attack"
		},
		{
			title = "技能",
			index = 5,
			loop = false,
			anim = "skill"
		},
		{
			title = "受击",
			index = 6,
			loop = false,
			anim = "hit"
		},
		{
			title = "死亡",
			index = 7,
			loop = false,
			anim = "dead"
		},
		{
			title = "浮空",
			index = 8,
			loop = false,
			anim = "fly"
		},
		{
			title = "倒地",
			index = 9,
			loop = false,
			anim = "fall"
		},
		{
			title = "回跳",
			index = 10,
			loop = false,
			anim = "back"
		},
		{
			title = "入场",
			index = 11,
			loop = false,
			anim = "in"
		},
		{
			title = "出场",
			index = 12,
			loop = false,
			anim = "out"
		},
		{
			title = "失败",
			index = 13,
			loop = false,
			anim = "failure"
		},
		{
			title = "行走",
			index = 14,
			loop = true,
			anim = "walk"
		},
		{
			title = "站立",
			index = 15,
			loop = true,
			anim = "stand"
		},
		{
			title = "睡觉",
			index = 16,
			loop = true,
			anim = "sleep"
		},
		{
			title = "坐下",
			index = 17,
			loop = true,
			anim = "sit"
		},
		{
			title = "洗澡",
			index = 18,
			loop = true,
			anim = "bathe"
		},
		{
			title = "起身",
			index = 19,
			loop = false,
			anim = "fall2"
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
			name = "ui特效\neffect_spine",
			shotPath = "/res/common/effect_spine",
			specialFileCount = {
				wujinmengyan_kv_03 = 4,
				wujinmengyan_kv_02 = 4,
				wujing_xuanguan_03 = 4,
				wujing_xuanguan_02 = 4,
				wujing_xuanguan_01 = 4,
				recruit_pet_draw_ssr = 5,
				recruit_pet_draw_sr = 5,
				recruit_pet_draw_r = 5,
				recruit_artifact_draw_ssr = 5,
				recruit_artifact_draw_sr = 5,
				recruit_artifact_draw_r = 5,
				eff_ui_recruit_ssr = 6,
				eff_ui_guilddungeon_baoxiang1 = 4,
				eff_ui_dungeon_start = 4,
				eff_ui_redpacket_ticket = 5,
				eff_ui_transistor_idle = 4,
				map_bio_dongxi_64 = 4
			}
		},
		{
			name = "立绘(这个废弃)\nknight_spine",
			shotPath = "/res/common/knight_spine"
		},
		{
			name = "战斗特效\nbattle/effect_spine",
			shotPath = "/res/common/battle/effect_spine",
			specialFileCount = {
				["600020_skill1"] = 4,
				["500070_skill2"] = 4,
				["500010_skill"] = 4,
				["400120_skill_hit"] = 4,
				["400030_skill5"] = 4,
				["400020_skill4"] = 4,
				["302540_skill1"] = 4
			}
		},
		{
			name = "战斗状态 \nbattle/attr_spine",
			shotPath = "/res/common/battle/attr_spine"
		},
		{
			name = "战斗buff\nbattle/buff_spine",
			shotPath = "/res/common/battle/buff_spine"
		},
		{
			name = "战斗小人\nbattle/knight_spine",
			shotPath = "/res/common/battle/knight_spine"
		}
	},
	PARALLAX_EFFECT_INGNORE_LIST = {
		train_xlzx = true,
		train_ct = true,
		recruit_artifact_draw_ssr = true,
		wujing_xuanguan_01 = true,
		map_bio_dongxi_6huo = true,
		wujing_xuanguan_04 = true,
		wujinmengyan_kv_play = true,
		wujinmengyan_kv_01 = true,
		map_bio_dongxi_2 = true,
		xinnian_chouqian_01 = true,
		game_turntable_times = true,
		jhhy_shan = true,
		dlt_stage_eff_login01 = true,
		jhhy_hai = true,
		battle_shunyi = true,
		battle_guanghuan = true,
		nvzhu_denglu = true,
		nanzhu_denglu = true,
		homeland = true,
		dungeon_stage_01_eff_xiaxue88 = true,
		recruit_artifact_draw_sr = true,
		recruit_artifact_draw_r = true,
		train_gwzx = true,
		train_yxzx = true,
		train_ylzx = true,
		wujinmengyan_kv_02 = true,
		wujing_xuanguan_03 = true,
		wujing_xuanguan_02 = true,
		recruit_pet_draw_ssr = true,
		recruit_pet_draw_sr = true,
		recruit_pet_draw_r = true,
		wujinmengyan_kv_03 = true
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
