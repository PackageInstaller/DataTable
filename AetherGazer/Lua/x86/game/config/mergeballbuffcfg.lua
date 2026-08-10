return {
	[1001] = {
		name = "广域打击",
		type = 1,
		combine_buff_ID = 0,
		desc = "机甲造成的范围伤害增加%s%%。\n*影响<color=#E78300>闪电</color>类与<color=#E78300>激光</color>类武装。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/1001",
		merge_weight = 0,
		id = 1001,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				20
			},
			{
				40
			}
		},
		tag = {
			2
		},
		relate = {},
		skill_id = {
			5011001,
			50110010
		},
		skill_type = {},
		parent_id = {}
	},
	[1002] = {
		name = "动能强化",
		type = 1,
		combine_buff_ID = 0,
		desc = "机甲与衍生物造成的撞击伤害增加%s%%。\n*影响<color=#E78300>分裂弹</color>类武装。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/1002",
		merge_weight = 0,
		id = 1002,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				20
			},
			{
				40
			}
		},
		tag = {
			1
		},
		relate = {},
		skill_id = {
			5011002,
			50110020
		},
		skill_type = {},
		parent_id = {}
	},
	[1003] = {
		name = "脉冲推进",
		type = 1,
		combine_buff_ID = 0,
		desc = "机甲的初始速度增加%s%%。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/1003",
		merge_weight = 0,
		id = 1003,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				10
			},
			{
				20
			}
		},
		tag = {
			3
		},
		relate = {},
		skill_id = {
			5011003,
			50110030
		},
		skill_type = {},
		parent_id = {}
	},
	[1004] = {
		name = "目标标记",
		type = 1,
		combine_buff_ID = 0,
		desc = "一回合内连击数达到%s后，本回合内机甲造成的伤害增加%s，回合结束时重置。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/1004",
		merge_weight = 0,
		id = 1004,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				20,
				50
			},
			{
				20,
				100
			}
		},
		tag = {
			3
		},
		relate = {},
		skill_id = {
			5011004,
			50110040
		},
		skill_type = {},
		parent_id = {}
	},
	[2001] = {
		name = "流弹",
		type = 2,
		combine_buff_ID = 0,
		desc = "撞击敌人时有%s%%概率发射%s颗「动能弹」,「动能弹」造成%s点撞击伤害。",
		combine_text1 = "动能弹",
		combine_text2 = "概率发射动能弹",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/2001",
		merge_weight = 2,
		id = 2001,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				50,
				1,
				10
			},
			{
				50,
				2,
				10
			}
		},
		tag = {
			1
		},
		relate = {
			2002,
			2005
		},
		skill_id = {
			5012001,
			50120010
		},
		skill_type = {
			3
		},
		parent_id = {
			3001,
			3005
		}
	},
	[2002] = {
		name = "灼烧",
		type = 2,
		combine_buff_ID = 0,
		desc = "撞击敌人时施加%s层「燃烧」，每层「燃烧」使敌人在承受其他类型伤害时额外受到%s点伤害，最多可叠加%s层。",
		combine_text1 = "",
		combine_text2 = "燃烧叠层",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/2002",
		merge_weight = 1,
		id = 2002,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				1,
				5,
				10
			},
			{
				2,
				5,
				10
			}
		},
		tag = {
			1
		},
		relate = {
			2001,
			2004
		},
		skill_id = {
			5012002,
			50120020
		},
		skill_type = {
			4
		},
		parent_id = {
			3001,
			3002
		}
	},
	[2003] = {
		name = "闪电",
		type = 2,
		combine_buff_ID = 0,
		desc = "撞击敌人时落下闪电，造成%s点范围伤害。",
		combine_text1 = "闪电命中",
		combine_text2 = "闪电",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/2003",
		merge_weight = 3,
		id = 2003,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				30
			},
			{
				60
			}
		},
		tag = {
			2
		},
		relate = {
			2004,
			2005
		},
		skill_id = {
			5012003,
			50120030
		},
		skill_type = {
			2
		},
		parent_id = {
			3003,
			3004
		}
	},
	[2004] = {
		name = "激光",
		type = 2,
		combine_buff_ID = 0,
		desc = "撞击敌人时随机射出横向或纵向激光，对命中的敌人造成%s点伤害。",
		combine_text1 = "激光命中",
		combine_text2 = "激光",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/2004",
		merge_weight = 3,
		id = 2004,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				20
			},
			{
				40
			}
		},
		tag = {
			2
		},
		relate = {
			2002,
			2003
		},
		skill_id = {
			5012004,
			50120040
		},
		skill_type = {
			2
		},
		parent_id = {
			3002,
			3003
		}
	},
	[2005] = {
		name = "贯穿",
		type = 2,
		combine_buff_ID = 0,
		desc = "可穿过敌人并额外造成%s点伤害。",
		combine_text1 = "贯穿时",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/2005",
		merge_weight = 0,
		id = 2005,
		formula = {},
		reward = {
			1,
			10
		},
		param_level = {
			{
				30
			},
			{
				60
			}
		},
		tag = {
			3
		},
		relate = {
			2001,
			2003
		},
		skill_id = {
			5012005,
			50120050
		},
		skill_type = {
			1
		},
		parent_id = {
			3004,
			3005
		}
	},
	[3001] = {
		name = "熔弹",
		type = 3,
		combine_buff_ID = 0,
		desc = "撞击敌人时施加%s层「燃烧」并生成%s颗「热核弹」，「热核弹」撞击敌人时会造成%s点伤害并施加%s层「燃烧」，每层「燃烧」使敌人在承受其他类型伤害时额外受到%s点伤害，最多可叠加%s层。",
		combine_text1 = "热核弹",
		combine_text2 = "发射热核弹",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/3001",
		merge_weight = 2,
		id = 3001,
		formula = {
			2001,
			2002
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				2,
				1,
				10,
				1,
				5,
				10
			},
			{
				2,
				1,
				20,
				1,
				5,
				10
			}
		},
		tag = {
			1
		},
		relate = {
			3002,
			3005
		},
		skill_id = {
			5013001,
			50130010
		},
		skill_type = {
			3,
			4
		},
		parent_id = {
			4001
		}
	},
	[3002] = {
		name = "热载",
		type = 3,
		combine_buff_ID = 0,
		desc = "撞击敌人时射出十字形激光，对激光命中的敌人造成%s点伤害并施加%s层「燃烧」，每层「燃烧」使敌人在承受其他类型伤害时额外受到%s点伤害，最多可叠加%s层。",
		combine_text1 = "激光命中",
		combine_text2 = "十字激光",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/3002",
		merge_weight = 3,
		id = 3002,
		formula = {
			2002,
			2004
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				40,
				2,
				5,
				10
			},
			{
				80,
				2,
				5,
				10
			}
		},
		tag = {
			2
		},
		relate = {
			3001,
			3003,
			3004,
			3005
		},
		skill_id = {
			5013002,
			50130020
		},
		skill_type = {
			2,
			4
		},
		parent_id = {
			4001,
			4002
		}
	},
	[3003] = {
		name = "闪电链",
		type = 3,
		combine_buff_ID = 0,
		desc = "撞击敌人时引发闪电链，对附近%s个敌人造成%s点伤害。",
		combine_text1 = "闪电链命中",
		combine_text2 = "闪电链",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/3003",
		merge_weight = 3,
		id = 3003,
		formula = {
			2003,
			2004
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				4,
				200
			},
			{
				4,
				400
			}
		},
		tag = {
			2
		},
		relate = {
			3002,
			3004
		},
		skill_id = {
			5013003,
			50130030
		},
		skill_type = {
			2
		},
		parent_id = {
			4002
		}
	},
	[3004] = {
		name = "闪电束",
		type = 3,
		combine_buff_ID = 50130043,
		desc = "可穿过敌人，且速度每降低%s后引发一次爆炸，造成%s点范围伤害；每穿透%s个敌人会提升%s格爆炸范围半径与%s点爆炸伤害。",
		combine_text1 = "爆炸命中时",
		combine_text2 = "爆炸",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/3004",
		merge_weight = 3,
		id = 3004,
		formula = {
			2003,
			2005
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				30,
				200,
				10,
				1,
				100
			},
			{
				30,
				400,
				10,
				1,
				200
			}
		},
		tag = {
			2
		},
		relate = {
			3002,
			3003
		},
		skill_id = {
			5013004,
			50130040
		},
		skill_type = {
			1,
			2
		},
		parent_id = {
			4002
		}
	},
	[3005] = {
		name = "裂变",
		type = 3,
		combine_buff_ID = 50130053,
		desc = "可穿过敌人并额外造成%s点伤害，撞击敌人会生成%s颗「动能弹」,「动能弹」造成%s点撞击伤害，每多穿透%s个敌人，撞击时额外生成%s颗「动能弹」，最多增加至%s颗，回合结束时重置。",
		combine_text1 = "动能弹",
		combine_text2 = "发射动能弹",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/3005",
		merge_weight = 2,
		id = 3005,
		formula = {
			2001,
			2005
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				60,
				1,
				10,
				3,
				1,
				3
			},
			{
				120,
				1,
				10,
				3,
				2,
				5
			}
		},
		tag = {
			1
		},
		relate = {
			3001,
			3002
		},
		skill_id = {
			5013005,
			50130050
		},
		skill_type = {
			1,
			3
		},
		parent_id = {
			4001
		}
	},
	[4001] = {
		name = "簇射",
		type = 4,
		combine_buff_ID = 50140011,
		desc = "撞击敌人时生成%s颗速度更快的「热核弹」，「热核弹」撞击敌人时会造成%s点伤害并施加%s层「燃烧」，每层「燃烧」使敌人在承受其他类型伤害时额外受到%s点伤害，最多可叠加%s层。",
		combine_text1 = "动能弹",
		combine_text2 = "发射动能弹",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/4001",
		merge_weight = 2,
		id = 4001,
		formula = {
			3001,
			3002,
			3005
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				3,
				100,
				1,
				5,
				10
			},
			{
				5,
				200,
				1,
				5,
				10
			}
		},
		tag = {
			1
		},
		relate = {},
		skill_id = {
			5014001,
			50140010
		},
		skill_type = {
			3
		},
		parent_id = {}
	},
	[4002] = {
		name = "闪电风暴",
		type = 4,
		combine_buff_ID = 0,
		desc = "撞击时引发闪电风暴，在大范围内造成%s点伤害。",
		combine_text1 = "闪电风暴命中",
		combine_text2 = "闪电风暴",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/4002",
		merge_weight = 3,
		id = 4002,
		formula = {
			3002,
			3003,
			3004
		},
		reward = {
			1,
			10
		},
		param_level = {
			{
				1500
			},
			{
				5000
			}
		},
		tag = {
			2
		},
		relate = {},
		skill_id = {
			5014002,
			50140020
		},
		skill_type = {
			2
		},
		parent_id = {}
	},
	[5001] = {
		name = "快速维修",
		type = 5,
		combine_buff_ID = 0,
		desc = "回复机甲%s%%生命值。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/5001",
		merge_weight = 0,
		id = 5001,
		formula = {},
		reward = {},
		param_level = {
			{
				50
			}
		},
		tag = {
			3
		},
		relate = {},
		skill_id = {
			5015001
		},
		skill_type = {},
		parent_id = {}
	},
	[5002] = {
		name = "火力增强",
		type = 5,
		combine_buff_ID = 0,
		desc = "机甲造成伤害增加%s，持续一回合。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/5002",
		merge_weight = 0,
		id = 5002,
		formula = {},
		reward = {},
		param_level = {
			{
				100
			}
		},
		tag = {
			3
		},
		relate = {},
		skill_id = {
			5015002
		},
		skill_type = {},
		parent_id = {}
	},
	[5004] = {
		formula = "",
		name = "循环回收",
		type = 5,
		combine_buff_ID = 0,
		desc = "跳过本回合改装环节，返还%s%%改装进度值。",
		combine_text1 = "",
		combine_text2 = "",
		icon = "TextureConfig/Activity_WuLuo/BuffIcon/5004",
		merge_weight = 0,
		id = 5004,
		reward = {},
		param_level = {
			{
				80
			}
		},
		tag = {
			3
		},
		relate = {},
		skill_id = {
			5015004
		},
		skill_type = {},
		parent_id = {}
	},
	get_id_list_by_type = {
		[5] = {
			5001,
			5002,
			5004
		},
		[4] = {
			4001,
			4002
		},
		[3] = {
			3001,
			3002,
			3003,
			3004,
			3005
		},
		[2] = {
			2001,
			2002,
			2003,
			2004,
			2005
		},
		{
			1001,
			1002,
			1003,
			1004
		}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		2001,
		2002,
		2003,
		2004,
		2005,
		3001,
		3002,
		3003,
		3004,
		3005,
		4001,
		4002,
		5001,
		5002,
		5004
	}
}
