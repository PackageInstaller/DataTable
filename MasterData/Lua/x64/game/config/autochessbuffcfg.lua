return {
	{
		name = "#通用加属性",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 1,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				0
			},
			{
				1,
				0
			}
		}
	},
	{
		name = "#通用永久加属性",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 2,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				0
			},
			{
				1,
				0
			}
		}
	},
	{
		name = "#圣盾",
		enum = 0,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 3,
		icon = "",
		moment = 1,
		action_type = 7,
		repeated = {
			3,
			401,
			1081,
			1082,
			1083
		},
		param = {}
	},
	{
		name = "#获得1经验",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 4,
		icon = "",
		moment = 1,
		action_type = 10,
		param = {
			1
		}
	},
	{
		name = "#通用加属性1回合",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 5,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				0
			},
			{
				1,
				0
			}
		}
	},
	{
		name = "#瓦解",
		enum = 0,
		effective_time = 0,
		keyword_type = 5,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>",
		gap = 0,
		trigger_time = 0,
		id = 6,
		icon = "",
		moment = 1,
		action_type = 33,
		repeated = {
			6
		},
		param = {}
	},
	{
		name = "#通用设置属性",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 7,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}
	},
	{
		param = "",
		name = "#通用空buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 8,
		icon = "",
		moment = 0,
		action_type = 0
	},
	[98] = {
		name = "#下1个道具免费",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 98,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			14,
			1
		}
	},
	[99] = {
		name = "#下2个棋子免费",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 99,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			15,
			2
		}
	},
	[101] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子+1/+1",
		gap = 0,
		trigger_time = 0,
		id = 101,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				1
			},
			{
				1,
				1
			}
		}
	},
	[102] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#随机偷取商店1个棋子",
		gap = 0,
		trigger_time = 0,
		id = 102,
		icon = "",
		moment = 1,
		action_type = 9,
		param = {
			1
		}
	},
	[103] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子+3攻击",
		gap = 0,
		trigger_time = 0,
		id = 103,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				3
			},
			{
				1,
				0
			}
		}
	},
	[104] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子+2血量",
		gap = 0,
		trigger_time = 0,
		id = 104,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				0
			},
			{
				1,
				2
			}
		}
	},
	[199] = {
		name = "",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#102附属buff，召唤时+1+1，一次性",
		gap = 0,
		trigger_time = 0,
		id = 199,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			13,
			1,
			{
				1,
				1
			}
		}
	},
	[201] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#金币上限+1",
		gap = 0,
		trigger_time = 0,
		id = 201,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			3,
			1
		}
	},
	[202] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#商店中的棋子永久+1/+1",
		gap = 0,
		trigger_time = 0,
		id = 202,
		icon = "",
		moment = 1,
		action_type = 24,
		param = {
			1,
			{
				1,
				1
			}
		}
	},
	[203] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使你的所有棋子+1/+1",
		gap = 0,
		trigger_time = 0,
		id = 203,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				1
			},
			{
				1,
				1
			}
		}
	},
	[204] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#刷新商店，其中会包含一个比商店星级高一级的棋子",
		gap = 0,
		trigger_time = 0,
		id = 204,
		icon = "",
		moment = 1,
		action_type = 15,
		param = {
			1,
			1
		}
	},
	[205] = {
		name = "",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#下一回合开始时，获得2枚金币",
		gap = 0,
		trigger_time = 0,
		id = 205,
		icon = "",
		moment = 9,
		action_type = 6,
		param = {
			1,
			1,
			2
		}
	},
	[299] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#金币重置值+1（201附属）",
		gap = 0,
		trigger_time = 0,
		id = 299,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			2,
			1
		}
	},
	[301] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#在本局对战的剩余时间内，己方棋子+1atk/+1hp",
		gap = 0,
		trigger_time = 0,
		id = 301,
		icon = "",
		moment = 1,
		action_type = 5,
		param = {
			112,
			1,
			{
				1,
				1
			}
		}
	},
	[302] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子经验值+1",
		gap = 0,
		trigger_time = 0,
		id = 302,
		icon = "",
		moment = 1,
		action_type = 10,
		param = {
			1
		}
	},
	[303] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子变为高一星级的棋子，并保留所有额外状态",
		gap = 0,
		trigger_time = 0,
		id = 303,
		icon = "",
		moment = 1,
		action_type = 16,
		param = {
			1
		}
	},
	[304] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使一个棋子+3/+3",
		gap = 0,
		trigger_time = 0,
		id = 304,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				3
			},
			{
				1,
				3
			}
		}
	},
	[305] = {
		name = "羲和的茼蒿汤",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 1,
		desc = "回合结束时：自身+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 305,
		icon = "buff_305",
		moment = 10,
		action_type = 41,
		param = {
			111,
			1,
			{
				1,
				1
			}
		}
	},
	[306] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#随机召唤一个4阶棋子",
		gap = 0,
		trigger_time = 0,
		id = 306,
		icon = "",
		moment = 1,
		action_type = 30,
		param = {
			4,
			1
		}
	},
	[401] = {
		name = "陵光的中药包",
		enum = 0,
		effective_time = 0,
		keyword_type = 1,
		is_show = 1,
		desc = "获得一层<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 401,
		icon = "buff_401",
		moment = 1,
		action_type = 7,
		repeated = {
			3,
			401,
			1081,
			1082,
			1083
		},
		param = {}
	},
	[402] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使你的棋子+2/+2",
		gap = 0,
		trigger_time = 0,
		id = 402,
		icon = "",
		moment = 1,
		action_type = 1,
		param = {
			{
				1,
				2
			},
			{
				1,
				2
			}
		}
	},
	[403] = {
		name = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#下一场战斗，使一个随机敌人血量变为1",
		gap = 0,
		trigger_time = 0,
		id = 403,
		icon = "",
		moment = 11,
		action_type = 5,
		repeated = {
			403
		},
		param = {
			214,
			7,
			{
				0,
				1
			}
		}
	},
	[404] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#移除一个友方棋子，使随机一个棋子获得其属性",
		gap = 0,
		trigger_time = 0,
		id = 404,
		icon = "",
		moment = 1,
		action_type = 17,
		param = {
			114,
			1
		}
	},
	[405] = {
		name = "",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使商店的一个随机棋子变为SSS",
		gap = 0,
		trigger_time = 0,
		id = 405,
		icon = "",
		moment = 1,
		action_type = 10,
		param = {
			5
		}
	},
	[407] = {
		name = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#下一场战斗开始时：召唤1个你hp最高的棋子的复制",
		gap = 0,
		trigger_time = 0,
		id = 407,
		icon = "",
		moment = 11,
		action_type = 35,
		repeated = {
			407
		},
		param = {
			2
		}
	},
	[502] = {
		name = "#2星技能1",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "所有己方棋子+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 502,
		icon = "manager_5",
		moment = 1,
		action_type = 5,
		param = {
			112,
			1,
			{
				0,
				1
			}
		}
	},
	[503] = {
		name = "#2星技能2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：自身+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 503,
		icon = "manager_5",
		moment = 10,
		action_type = 5,
		param = {
			111,
			1,
			{
				1,
				0
			}
		}
	},
	[504] = {
		name = "#2星技能3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>",
		gap = 0,
		trigger_time = 0,
		id = 504,
		icon = "manager_1",
		moment = 17,
		action_type = 4,
		param = {
			111,
			{
				6
			}
		}
	},
	[505] = {
		name = "#2星技能3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤时：使其+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 505,
		icon = "manager_2",
		moment = 18,
		action_type = 5,
		param = {
			13,
			1,
			{
				2,
				0
			}
		}
	},
	[506] = {
		name = "#2星技能4",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤3个1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的小型作战智械",
		gap = 0,
		trigger_time = 0,
		id = 506,
		icon = "manager_2",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				9001,
				9001,
				9001
			}
		}
	},
	[507] = {
		name = "#2星技能5",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：商店中被锁定的棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 507,
		icon = "manager_1",
		moment = 10,
		action_type = 5,
		param = {
			14,
			1,
			{
				2,
				2
			}
		}
	},
	[508] = {
		name = "#2星技能6",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：对随机3个敌方棋子造成1点伤害",
		gap = 0,
		trigger_time = 0,
		id = 508,
		icon = "manager_3",
		moment = 11,
		action_type = 2,
		param = {
			216,
			1
		}
	},
	[511] = {
		name = "#3星技能1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "回合开始时：获得2金币",
		gap = 0,
		trigger_time = 0,
		id = 511,
		icon = "manager_1",
		moment = 9,
		action_type = 6,
		param = {
			1,
			1,
			2
		}
	},
	[512] = {
		name = "#3星技能2",
		repeated = "",
		enum = 212,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "敌方棋子阵亡时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 512,
		icon = "manager_5",
		moment = 17,
		action_type = 5,
		param = {
			111,
			2,
			{
				1,
				0
			}
		}
	},
	[513] = {
		name = "#3星技能3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售棋子时：获得其<material=underline c=#FFFFFF h=2 event=terminology args=(1100003)>属性</material>，增益持续至本回合结束",
		gap = 0,
		trigger_time = 0,
		id = 513,
		icon = "manager_5",
		moment = 5,
		action_type = 19,
		param = {
			5
		}
	},
	[514] = {
		name = "#3星技能4",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "购买棋子时：使随机3个己方棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 514,
		icon = "manager_5",
		moment = 3,
		action_type = 5,
		param = {
			116,
			1,
			{
				1,
				0
			}
		}
	},
	[515] = {
		name = "#3星技能5",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使其他己方棋子+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 515,
		icon = "manager_5",
		moment = 17,
		action_type = 5,
		param = {
			113,
			1,
			{
				3,
				3
			}
		}
	},
	[516] = {
		name = "#3星技能6",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "战斗中召唤时：自身+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 516,
		icon = "manager_2",
		moment = 19,
		action_type = 5,
		param = {
			111,
			1,
			{
				3,
				3
			}
		}
	},
	[517] = {
		name = "#3星技能7",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合开始时：随机使用一个道具",
		gap = 0,
		trigger_time = 0,
		id = 517,
		icon = "manager_1",
		moment = 9,
		action_type = 11,
		param = {
			1,
			{
				303,
				404
			}
		}
	},
	[518] = {
		name = "#4星技能8",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "受伤时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 518,
		icon = "manager_5",
		moment = 16,
		action_type = 5,
		param = {
			111,
			2,
			{
				1,
				1
			}
		}
	},
	[521] = {
		name = "#4星技能1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：随机造成3点伤害，触发%s次（每经过1回合，额外触发1次）",
		gap = 0,
		trigger_time = 2,
		id = 521,
		icon = "manager_3",
		moment = 11,
		action_type = 38,
		param = {
			214,
			3,
			1
		}
	},
	[522] = {
		name = "#4星技能2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：所有己方棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 522,
		icon = "manager_5",
		moment = 10,
		action_type = 5,
		param = {
			112,
			1,
			{
				1,
				1
			}
		}
	},
	[523] = {
		name = "#4星技能3",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "己方棋子的<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果触发2次",
		gap = 0,
		trigger_time = 0,
		id = 523,
		icon = "manager_1",
		moment = 17,
		action_type = 14,
		param = {
			1,
			1
		}
	},
	[524] = {
		name = "#4星技能4",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤时：使其获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 524,
		icon = "manager_2",
		moment = 18,
		action_type = 5,
		param = {
			13,
			1,
			{
				6,
				6
			}
		}
	},
	[525] = {
		name = "#4星技能5",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：对随机1个敌方棋子造成等量伤害",
		gap = 0,
		trigger_time = 0,
		id = 525,
		icon = "manager_3",
		moment = 13,
		action_type = 18,
		param = {
			214
		}
	},
	[526] = {
		name = "#4星技能6",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：使随机1个己方非<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 526,
		icon = "manager_4",
		moment = 17,
		action_type = 4,
		param = {
			156,
			{
				3
			}
		}
	},
	[527] = {
		name = "#4星技能7",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合开始时：使后方相邻棋子+1经验",
		gap = 0,
		trigger_time = 0,
		id = 527,
		icon = "manager_1",
		moment = 9,
		action_type = 4,
		param = {
			127,
			{
				4
			}
		}
	},
	[528] = {
		name = "#4星技能8",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "受伤时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 528,
		icon = "manager_5",
		moment = 16,
		action_type = 5,
		param = {
			111,
			2,
			{
				1,
				1
			}
		}
	},
	[529] = {
		name = "#4星技能9",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤奥丁，消灭击杀管理员的棋子，并获得其战斗开始时的<material=underline c=#FFFFFF h=2 event=terminology args=(1100003)>属性</material>",
		gap = 0,
		trigger_time = 0,
		id = 529,
		icon = "manager_2",
		moment = 17,
		action_type = 39,
		param = {
			18
		}
	},
	[530] = {
		name = "#4星技能10",
		repeated = "",
		enum = 0,
		effective_time = 1,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：召唤被击杀棋子战斗开始时的复制，<material=underline c=#FFFFFF h=2 event=terminology args=(1100007)>全场</material>仅生效1次",
		gap = 0,
		trigger_time = 0,
		id = 530,
		icon = "manager_2",
		moment = 1,
		action_type = 4,
		param = {
			2,
			{
				713
			}
		}
	},
	[531] = {
		name = "#管理员初始效果",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：随机使一个己方棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 531,
		icon = "manager_5",
		moment = 10,
		action_type = 5,
		param = {
			114,
			1,
			{
				1,
				1
			}
		}
	},
	[541] = {
		name = "#管理员欧米茄效果",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>获得其双倍的<material=underline c=#FFFFFF h=2 event=terminology args=(1100003)>属性</material>",
		gap = 0,
		trigger_time = 0,
		id = 541,
		icon = "manager_6",
		moment = 1,
		action_type = 4,
		param = {
			2,
			{
				542,
				545
			}
		}
	},
	[542] = {
		name = "#管理员欧米茄实际的效果",
		repeated = "",
		enum = 152,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 542,
		icon = "",
		moment = 17,
		action_type = 26,
		param = {
			1,
			2
		}
	},
	[543] = {
		name = "#梵天变身效果，移除己方棋子+召唤大梵天",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 543,
		icon = "",
		moment = 11,
		action_type = 29,
		param = {
			17,
			5
		}
	},
	[544] = {
		name = "#梵天欧米茄效果",
		repeated = "",
		enum = 212,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>移除被击杀的棋子",
		gap = 0,
		trigger_time = 0,
		id = 544,
		icon = "",
		moment = 17,
		action_type = 28,
		param = {
			1
		}
	},
	[545] = {
		name = "#管理员欧米茄实际的效果*2",
		repeated = "",
		enum = 152,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 545,
		icon = "",
		moment = 17,
		action_type = 26,
		param = {
			1,
			2
		}
	},
	[601] = {
		name = "道馆挑战机制",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "商店升级时也会提供奖励棋子",
		gap = 0,
		trigger_time = 0,
		id = 601,
		icon = "",
		moment = 8,
		action_type = 20,
		param = {}
	},
	[611] = {
		name = "道馆挑战机制",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "棋子升级所需经验值-1",
		gap = 0,
		trigger_time = 0,
		id = 611,
		icon = "",
		moment = 1,
		action_type = 12,
		param = {
			-1
		}
	},
	[621] = {
		name = "道馆挑战机制",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "商店每回合升级，棋子初始SS",
		gap = 0,
		trigger_time = 0,
		id = 621,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			0,
			9,
			1
		}
	},
	[622] = {
		name = "#区域3畸变-附属",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "棋子初始2级",
		gap = 0,
		trigger_time = 0,
		id = 622,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			0,
			12,
			3
		}
	},
	[701] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤8<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/8<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 701,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4051
			}
		}
	},
	[702] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤10<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/10<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 702,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4052
			}
		}
	},
	[703] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 703,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4054
			}
		}
	},
	[704] = {
		name = "#欧申纳斯lv2-第二个加亡语buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方相邻棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤10<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/10<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”，生效2次",
		gap = 0,
		trigger_time = 0,
		id = 704,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			127,
			{
				706
			}
		}
	},
	[705] = {
		name = "#欧申纳斯lv3-第二个加亡语buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方相邻棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 705,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			127,
			{
				707
			}
		}
	},
	[706] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤10<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/10<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 706,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4053
			}
		}
	},
	[707] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 707,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4055
			}
		}
	},
	[708] = {
		name = "#欧申纳斯lv3-第三个加亡语buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方相邻棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 708,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			127,
			{
				709
			}
		}
	},
	[709] = {
		name = "流转之洋·欧申纳斯",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯",
		gap = 0,
		trigger_time = 0,
		id = 709,
		icon = "buff_4054",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				4056
			}
		}
	},
	[710] = {
		name = "#管理员529附属buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "#召唤奥丁，其属性等同于击杀者战斗开始时的属性",
		gap = 0,
		trigger_time = 0,
		id = 710,
		icon = "",
		moment = 17,
		action_type = 40,
		param = {
			1,
			9002,
			1
		}
	},
	[711] = {
		name = "#管理员513附属buff",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#购买其他棋子时：获得其属性，增益持续至下回合",
		gap = 0,
		trigger_time = 0,
		id = 711,
		icon = "",
		moment = 3,
		action_type = 19,
		param = {
			5
		}
	},
	[712] = {
		param = "",
		name = "#奥丁描述备注",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "消灭击杀管理员的棋子",
		gap = 0,
		trigger_time = 0,
		id = 712,
		icon = "",
		moment = 0,
		action_type = 0
	},
	[713] = {
		name = "#4星技能10-实际生效buff",
		enum = 133,
		effective_time = 1,
		keyword_type = 0,
		is_show = 0,
		desc = "#管理员击杀时：召唤被击杀棋子战斗开始时的复制，全场仅生效1次",
		gap = 0,
		trigger_time = 0,
		id = 713,
		icon = "manager_2",
		moment = 22,
		action_type = 31,
		repeated = {
			713
		},
		param = {
			1
		}
	},
	[714] = {
		name = "#荒獠·金固共用计数buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#获得时：抛99时机",
		gap = 8,
		trigger_time = 0,
		id = 714,
		icon = "",
		moment = 1,
		action_type = 8,
		param = {
			2,
			99
		}
	},
	[715] = {
		name = "#荒獠·金固共用计数buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#战斗开始时：抛99时机",
		gap = 0,
		trigger_time = 0,
		id = 715,
		icon = "",
		moment = 11,
		action_type = 8,
		param = {
			2,
			99
		}
	},
	[1011] = {
		name = "#禄良lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "回合开始时：获得1金币",
		gap = 0,
		trigger_time = 0,
		id = 1011,
		icon = "",
		moment = 9,
		action_type = 6,
		param = {
			1,
			1,
			1
		}
	},
	[1012] = {
		name = "#禄良lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "回合开始时：获得2金币",
		gap = 0,
		trigger_time = 0,
		id = 1012,
		icon = "",
		moment = 9,
		action_type = 6,
		param = {
			1,
			1,
			2
		}
	},
	[1013] = {
		name = "#禄良lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "回合开始时：获得3金币",
		gap = 0,
		trigger_time = 0,
		id = 1013,
		icon = "",
		moment = 9,
		action_type = 6,
		param = {
			1,
			1,
			3
		}
	},
	[1021] = {
		name = "#宁希达lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：使随机1个己方棋子+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1021,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			117,
			1,
			{
				0,
				3
			}
		}
	},
	[1022] = {
		name = "#宁希达lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：使随机1个己方棋子+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1022,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			117,
			1,
			{
				0,
				6
			}
		}
	},
	[1023] = {
		name = "#宁希达lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：使随机1个己方棋子+9<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1023,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			117,
			1,
			{
				0,
				9
			}
		}
	},
	[1031] = {
		name = "#A奥西里斯lv1",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：自身获得+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1031,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				1,
				1
			}
		}
	},
	[1032] = {
		name = "#A奥西里斯lv2",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：自身获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1032,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				2
			}
		}
	},
	[1033] = {
		name = "#A奥西里斯lv3",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：自身获得+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1033,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				3,
				3
			}
		}
	},
	[1041] = {
		name = "#冥王lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使后方相邻棋子获得+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1041,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			127,
			1,
			{
				1,
				1
			}
		}
	},
	[1042] = {
		name = "#冥王lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使后方相邻棋子获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1042,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			127,
			1,
			{
				2,
				2
			}
		}
	},
	[1043] = {
		name = "#冥王lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使后方相邻棋子获得+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1043,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			127,
			1,
			{
				3,
				3
			}
		}
	},
	[1051] = {
		name = "#海拉lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的迟钝",
		gap = 0,
		trigger_time = 0,
		id = 1051,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				1051
			}
		}
	},
	[1052] = {
		name = "#海拉lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的迟钝",
		gap = 0,
		trigger_time = 0,
		id = 1052,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				1052
			}
		}
	},
	[1053] = {
		name = "#海拉lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的迟钝",
		gap = 0,
		trigger_time = 0,
		id = 1053,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				1053
			}
		}
	},
	[1061] = {
		name = "#陆吾lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "己方棋子触发<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果时：获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1061,
		icon = "",
		moment = 21,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				1
			}
		}
	},
	[1062] = {
		name = "#陆吾lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "己方棋子触发<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果时：获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1062,
		icon = "",
		moment = 21,
		action_type = 5,
		param = {
			111,
			1,
			{
				4,
				2
			}
		}
	},
	[1063] = {
		name = "#陆吾lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "己方棋子触发<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果时：获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1063,
		icon = "",
		moment = 21,
		action_type = 5,
		param = {
			111,
			1,
			{
				6,
				3
			}
		}
	},
	[1071] = {
		name = "#S伽梨lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后1个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1071,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			127,
			{
				3
			}
		}
	},
	[1072] = {
		name = "#S伽梨lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后2个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1072,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			128,
			{
				3
			}
		}
	},
	[1073] = {
		name = "#S伽梨lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后3个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1073,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			129,
			{
				3
			}
		}
	},
	[1081] = {
		name = "#利维坦lv1",
		enum = 0,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1081,
		icon = "",
		moment = 1,
		action_type = 7,
		repeated = {
			3,
			401,
			1081,
			1082,
			1083
		},
		param = {}
	},
	[1082] = {
		name = "#利维坦lv2",
		enum = 0,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1082,
		icon = "",
		moment = 1,
		action_type = 7,
		repeated = {
			3,
			401,
			1081,
			1082,
			1083
		},
		param = {}
	},
	[1083] = {
		name = "#利维坦lv3",
		enum = 0,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 1083,
		icon = "",
		moment = 1,
		action_type = 7,
		repeated = {
			3,
			401,
			1081,
			1082,
			1083
		},
		param = {}
	},
	[1091] = {
		name = "#S丰前坊天狗lv1",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "己方棋子受伤时：获得+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1091,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				1,
				0
			}
		}
	},
	[1092] = {
		name = "#S丰前坊天狗lv2",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "己方棋子受伤时：获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1092,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				0
			}
		}
	},
	[1093] = {
		name = "#S丰前坊天狗lv3",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "己方棋子受伤时：获得+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1093,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				3,
				0
			}
		}
	},
	[1101] = {
		name = "#赫拉lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1101,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			2,
			{
				1,
				0
			}
		}
	},
	[1102] = {
		name = "#赫拉lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1102,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			2,
			{
				2,
				0
			}
		}
	},
	[1103] = {
		name = "#赫拉lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 1103,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			2,
			{
				3,
				0
			}
		}
	},
	[1111] = {
		name = "#熯天·提尔lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤其他棋子时：自身+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1111,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				1
			}
		}
	},
	[1112] = {
		name = "#熯天·提尔lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤其他棋子时：自身+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1112,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				2
			}
		}
	},
	[1113] = {
		name = "#熯天·提尔lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤其他棋子时：自身+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1113,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				3
			}
		}
	},
	[1121] = {
		name = "#狂鳄·索贝克lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 1121,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[1122] = {
		name = "#狂鳄·索贝克lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：随机对2个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 1122,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			215,
			3
		}
	},
	[1123] = {
		name = "#狂鳄·索贝克lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：随机对3个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 1123,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			216,
			3
		}
	},
	[1131] = {
		name = "#铃兰之弦·雅典娜lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子对敌造成伤害时：自身+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1131,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				1
			}
		}
	},
	[1132] = {
		name = "#铃兰之弦·雅典娜lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子对敌造成伤害时：自身+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1132,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				2
			}
		}
	},
	[1133] = {
		name = "#铃兰之弦·雅典娜lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子对敌造成伤害时：自身+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1133,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			111,
			1,
			{
				0,
				3
			}
		}
	},
	[1141] = {
		name = "#觅影·国常立lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使其他己方棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1141,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			113,
			1,
			{
				1,
				1
			}
		}
	},
	[1142] = {
		name = "#觅影·国常立lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使其他己方棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1142,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			113,
			1,
			{
				2,
				2
			}
		}
	},
	[1143] = {
		name = "#觅影·国常立lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使其他己方棋子+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 1143,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			113,
			1,
			{
				3,
				3
			}
		}
	},
	[2011] = {
		name = "#大国主lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：相邻棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2011,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			120,
			1,
			{
				1,
				0
			}
		}
	},
	[2012] = {
		name = "#大国主lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：相邻棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2012,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			120,
			1,
			{
				2,
				0
			}
		}
	},
	[2013] = {
		name = "#大国主lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：相邻棋子+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2013,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			120,
			1,
			{
				3,
				0
			}
		}
	},
	[2021] = {
		name = "#B前鬼lv1",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每回合可免费刷新2次",
		gap = 0,
		trigger_time = 0,
		id = 2021,
		icon = "",
		moment = 9,
		action_type = 4,
		param = {
			2,
			{
				2024
			}
		}
	},
	[2022] = {
		name = "#B前鬼lv2",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每回合可免费刷新4次",
		gap = 0,
		trigger_time = 0,
		id = 2022,
		icon = "",
		moment = 9,
		action_type = 4,
		param = {
			2,
			{
				2025
			}
		}
	},
	[2023] = {
		name = "#B前鬼lv3",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每回合可免费刷新6次",
		gap = 0,
		trigger_time = 0,
		id = 2023,
		icon = "",
		moment = 9,
		action_type = 4,
		param = {
			2,
			{
				2026
			}
		}
	},
	[2024] = {
		name = "#B前鬼lv1-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#免费刷新实现用buff-2次",
		gap = 0,
		trigger_time = 0,
		id = 2024,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			16,
			2
		}
	},
	[2025] = {
		name = "#B前鬼lv2-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#免费刷新实现用buff-4次",
		gap = 0,
		trigger_time = 0,
		id = 2025,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			16,
			4
		}
	},
	[2026] = {
		name = "#B前鬼lv3-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#免费刷新实现用buff-6次",
		gap = 0,
		trigger_time = 0,
		id = 2026,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			16,
			6
		}
	},
	[2031] = {
		name = "#B薇儿丹蒂lv1",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：使其+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2031,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			121,
			1,
			{
				0,
				2
			}
		}
	},
	[2032] = {
		name = "#B薇儿丹蒂lv2",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：使其+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2032,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			121,
			1,
			{
				0,
				4
			}
		}
	},
	[2033] = {
		name = "#B薇儿丹蒂lv3",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻棋子攻击时：使其+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2033,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			121,
			1,
			{
				0,
				6
			}
		}
	},
	[2041] = {
		name = "#A休lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使最前排的棋子获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2041,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			124,
			1,
			{
				2,
				2
			}
		}
	},
	[2042] = {
		name = "#A休lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使最前排的棋子获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2042,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			124,
			1,
			{
				4,
				4
			}
		}
	},
	[2043] = {
		name = "#A休lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使最前排的棋子获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2043,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			124,
			1,
			{
				6,
				6
			}
		}
	},
	[2051] = {
		name = "#伊里伽尔lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤2个3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的奈奈与奈提",
		gap = 0,
		trigger_time = 0,
		id = 2051,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				2051,
				2054
			}
		}
	},
	[2052] = {
		name = "#伊里伽尔lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤2个6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的奈奈与奈提",
		gap = 0,
		trigger_time = 0,
		id = 2052,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				2052,
				2055
			}
		}
	},
	[2053] = {
		name = "#伊里伽尔lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤2个9<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的奈奈与奈提",
		gap = 0,
		trigger_time = 0,
		id = 2053,
		icon = "",
		moment = 17,
		action_type = 3,
		param = {
			1,
			{
				2053,
				2056
			}
		}
	},
	[2061] = {
		name = "#麟钰lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2061,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			2,
			{
				2064
			}
		}
	},
	[2062] = {
		name = "#麟钰lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2062,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			2,
			{
				2065
			}
		}
	},
	[2063] = {
		name = "#麟钰lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2063,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			2,
			{
				2066
			}
		}
	},
	[2064] = {
		name = "#麟钰lv1-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1/+1（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2064,
		icon = "",
		moment = 1,
		action_type = 25,
		param = {
			206,
			1,
			{
				1,
				1
			}
		}
	},
	[2065] = {
		name = "#麟钰lv2-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2/+2（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2065,
		icon = "",
		moment = 1,
		action_type = 25,
		param = {
			206,
			1,
			{
				2,
				2
			}
		}
	},
	[2066] = {
		name = "#麟钰lv3-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使麟钰<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3/+3（<material=underline c=#FFFFFF h=2 event=terminology args=(1100004)>无论其在哪里</material>）",
		gap = 0,
		trigger_time = 0,
		id = 2066,
		icon = "",
		moment = 1,
		action_type = 25,
		param = {
			206,
			1,
			{
				3,
				3
			}
		}
	},
	[2071] = {
		name = "#陵光lv1",
		repeated = "",
		enum = 2,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。使用道具时：使具有<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>的棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2071,
		icon = "",
		moment = 4,
		action_type = 5,
		param = {
			151,
			1,
			{
				1,
				0
			}
		}
	},
	[2072] = {
		name = "#陵光lv2",
		repeated = "",
		enum = 2,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。使用道具时：使具有<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>的棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2072,
		icon = "",
		moment = 4,
		action_type = 5,
		param = {
			151,
			1,
			{
				2,
				0
			}
		}
	},
	[2073] = {
		name = "#陵光lv3",
		repeated = "",
		enum = 2,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。使用道具时：使具有<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>的棋子+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 2073,
		icon = "",
		moment = 4,
		action_type = 5,
		param = {
			151,
			1,
			{
				3,
				0
			}
		}
	},
	[2081] = {
		name = "#维达尔lv1",
		repeated = "",
		enum = 113,
		effective_time = 3,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗中召唤时：使其获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 2081,
		icon = "",
		moment = 19,
		action_type = 4,
		param = {
			13,
			{
				3
			}
		}
	},
	[2082] = {
		name = "#维达尔lv2",
		repeated = "",
		enum = 113,
		effective_time = 6,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗中召唤时：使其获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效6次",
		gap = 0,
		trigger_time = 0,
		id = 2082,
		icon = "",
		moment = 19,
		action_type = 4,
		param = {
			13,
			{
				3
			}
		}
	},
	[2083] = {
		name = "#维达尔lv3",
		repeated = "",
		enum = 113,
		effective_time = 9,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗中召唤时：使其获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效9次",
		gap = 0,
		trigger_time = 0,
		id = 2083,
		icon = "",
		moment = 19,
		action_type = 4,
		param = {
			13,
			{
				3
			}
		}
	},
	[2091] = {
		name = "#迦具土lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：对所有其他棋子造成1点伤害，触发1次",
		gap = 0,
		trigger_time = 0,
		id = 2091,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[2092] = {
		name = "#迦具土lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：对所有其他棋子造成1点伤害，触发2次",
		gap = 0,
		trigger_time = 1,
		id = 2092,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[2093] = {
		name = "#迦具土lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：对所有其他棋子造成1点伤害，触发3次",
		gap = 0,
		trigger_time = 2,
		id = 2093,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[2101] = {
		name = "#阿尔忒弥斯lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2101,
		icon = "",
		moment = 16,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[2102] = {
		name = "#阿尔忒弥斯lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机对1个敌方棋子造成6点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2102,
		icon = "",
		moment = 16,
		action_type = 2,
		param = {
			214,
			6
		}
	},
	[2103] = {
		name = "#阿尔忒弥斯lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机对1个敌方棋子造成9点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2103,
		icon = "",
		moment = 16,
		action_type = 2,
		param = {
			214,
			9
		}
	},
	[2111] = {
		name = "#光煌·阿波罗lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：随机召唤1个2阶棋子",
		gap = 0,
		trigger_time = 0,
		id = 2111,
		icon = "",
		moment = 5,
		action_type = 30,
		param = {
			2,
			1
		}
	},
	[2112] = {
		name = "#光煌·阿波罗lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：随机召唤1个3阶棋子",
		gap = 0,
		trigger_time = 0,
		id = 2112,
		icon = "",
		moment = 5,
		action_type = 30,
		param = {
			3,
			1
		}
	},
	[2113] = {
		name = "#光煌·阿波罗lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "出售时：随机召唤1个4阶棋子",
		gap = 0,
		trigger_time = 0,
		id = 2113,
		icon = "",
		moment = 5,
		action_type = 30,
		param = {
			4,
			1
		}
	},
	[2121] = {
		name = "#硝芒·埃克什瓦lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2121,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[2122] = {
		name = "#硝芒·埃克什瓦lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：随机对2个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2122,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			215,
			3
		}
	},
	[2123] = {
		name = "#硝芒·埃克什瓦lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：随机对3个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2123,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			216,
			3
		}
	},
	[2131] = {
		name = "#绮望·诗蔻蒂lv1",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻1个棋子攻击时：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2131,
		icon = "",
		moment = 12,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[2132] = {
		name = "#绮望·诗蔻蒂lv2",
		repeated = "",
		enum = 122,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻2个棋子攻击时：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2132,
		icon = "",
		moment = 12,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[2133] = {
		name = "#绮望·诗蔻蒂lv3",
		repeated = "",
		enum = 123,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻3个棋子攻击时：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 2133,
		icon = "",
		moment = 12,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[2141] = {
		name = "#裁暗之锋·塞尔凯特lv1",
		repeated = "",
		enum = 111,
		effective_time = 1,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。受伤时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>，生效1次",
		gap = 0,
		trigger_time = 0,
		id = 2141,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				6
			}
		}
	},
	[2142] = {
		name = "#裁暗之锋·塞尔凯特lv2",
		repeated = "",
		enum = 111,
		effective_time = 2,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。受伤时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>，生效2次",
		gap = 0,
		trigger_time = 0,
		id = 2142,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				6
			}
		}
	},
	[2143] = {
		name = "#裁暗之锋·塞尔凯特lv3",
		repeated = "",
		enum = 111,
		effective_time = 3,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。受伤时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 2143,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				6
			}
		}
	},
	[2151] = {
		name = "#青君·孟章lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2151,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			111,
			2,
			{
				0,
				1
			}
		}
	},
	[2152] = {
		name = "#青君·孟章lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2152,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			111,
			2,
			{
				0,
				2
			}
		}
	},
	[2153] = {
		name = "#青君·孟章lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：自身<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 2153,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			111,
			2,
			{
				0,
				3
			}
		}
	},
	[3011] = {
		name = "#海姆达尔lv1",
		repeated = "",
		enum = 0,
		effective_time = 1,
		keyword_type = 0,
		is_show = 0,
		desc = "下1个道具会生效2次，每回合重置",
		gap = 0,
		trigger_time = 0,
		id = 3011,
		icon = "",
		moment = 4,
		action_type = 13,
		param = {
			1
		}
	},
	[3012] = {
		name = "#海姆达尔lv2",
		repeated = "",
		enum = 0,
		effective_time = 2,
		keyword_type = 0,
		is_show = 0,
		desc = "下2个道具会生效2次，每回合重置",
		gap = 0,
		trigger_time = 0,
		id = 3012,
		icon = "",
		moment = 4,
		action_type = 13,
		param = {
			1
		}
	},
	[3013] = {
		name = "#海姆达尔lv3",
		repeated = "",
		enum = 0,
		effective_time = 3,
		keyword_type = 0,
		is_show = 0,
		desc = "下3个道具会生效2次，每回合重置",
		gap = 0,
		trigger_time = 0,
		id = 3013,
		icon = "",
		moment = 4,
		action_type = 13,
		param = {
			1
		}
	},
	[3021] = {
		name = "#托特lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你的回合结束时触发的效果可额外触发1次",
		gap = 0,
		trigger_time = 0,
		id = 3021,
		icon = "",
		moment = 10,
		action_type = 14,
		param = {
			1
		}
	},
	[3022] = {
		name = "#托特lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你的回合结束时触发的效果可额外触发2次",
		gap = 0,
		trigger_time = 0,
		id = 3022,
		icon = "",
		moment = 10,
		action_type = 14,
		param = {
			2
		}
	},
	[3023] = {
		name = "#托特lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你的回合结束时触发的效果可额外触发3次",
		gap = 0,
		trigger_time = 0,
		id = 3023,
		icon = "",
		moment = 10,
		action_type = 14,
		param = {
			3
		}
	},
	[3031] = {
		name = "#S薇儿丹蒂lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3031,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				2
			}
		}
	},
	[3032] = {
		name = "#S薇儿丹蒂lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3032,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				4,
				4
			}
		}
	},
	[3033] = {
		name = "#S薇儿丹蒂lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3033,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				6,
				6
			}
		}
	},
	[3034] = {
		name = "#S薇儿丹蒂lv1-附属buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使随机1个其他己方棋子获得该攻击时效果",
		gap = 0,
		trigger_time = 0,
		id = 3034,
		icon = "",
		moment = 12,
		action_type = 4,
		param = {
			117,
			{
				3037
			}
		}
	},
	[3035] = {
		name = "#S薇儿丹蒂lv2-附属buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使随机1个其他己方棋子获得该攻击时效果",
		gap = 0,
		trigger_time = 0,
		id = 3035,
		icon = "",
		moment = 12,
		action_type = 4,
		param = {
			117,
			{
				3038
			}
		}
	},
	[3036] = {
		name = "#S薇儿丹蒂lv3-附属buff",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#使随机1个其他己方棋子获得该攻击时效果",
		gap = 0,
		trigger_time = 0,
		id = 3036,
		icon = "",
		moment = 12,
		action_type = 4,
		param = {
			117,
			{
				3039
			}
		}
	},
	[3037] = {
		name = "黯耀·薇儿丹蒂",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 1,
		desc = "攻击时：获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3037,
		icon = "buff_3037",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				2
			}
		}
	},
	[3038] = {
		name = "黯耀·薇儿丹蒂",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 1,
		desc = "攻击时：获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3038,
		icon = "buff_3037",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				4,
				4
			}
		}
	},
	[3039] = {
		name = "黯耀·薇儿丹蒂",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 1,
		desc = "攻击时：获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3039,
		icon = "buff_3037",
		moment = 12,
		action_type = 5,
		param = {
			111,
			1,
			{
				6,
				6
			}
		}
	},
	[3041] = {
		name = "#霍德尔lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：使最前排棋子获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3041,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			124,
			1,
			{
				2,
				2
			}
		}
	},
	[3042] = {
		name = "#霍德尔lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：使最前排棋子获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3042,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			124,
			1,
			{
				4,
				4
			}
		}
	},
	[3043] = {
		name = "#霍德尔lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 3,
		is_show = 0,
		desc = "回合结束时：使最前排棋子获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3043,
		icon = "",
		moment = 10,
		action_type = 5,
		param = {
			124,
			1,
			{
				6,
				6
			}
		}
	},
	[3051] = {
		name = "#哈迪斯lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤时：使随机1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3051,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			114,
			2,
			{
				2,
				2
			}
		}
	},
	[3052] = {
		name = "#哈迪斯lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤时：使随机1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3052,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			114,
			2,
			{
				4,
				4
			}
		}
	},
	[3053] = {
		name = "#哈迪斯lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "召唤时：使随机1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 3053,
		icon = "",
		moment = 18,
		action_type = 5,
		param = {
			114,
			2,
			{
				6,
				6
			}
		}
	},
	[3061] = {
		name = "#金乌lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：触发后1个棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果",
		gap = 0,
		trigger_time = 0,
		id = 3061,
		icon = "",
		moment = 13,
		action_type = 8,
		param = {
			127,
			17,
			1,
			{
				523
			}
		}
	},
	[3062] = {
		name = "#金乌lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：触发后2个棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果",
		gap = 0,
		trigger_time = 0,
		id = 3062,
		icon = "",
		moment = 13,
		action_type = 8,
		param = {
			128,
			17,
			1,
			{
				523
			}
		}
	},
	[3063] = {
		name = "#金乌lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：触发后3个棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>效果",
		gap = 0,
		trigger_time = 0,
		id = 3063,
		icon = "",
		moment = 13,
		action_type = 8,
		param = {
			129,
			17,
			1,
			{
				523
			}
		}
	},
	[3071] = {
		name = "#阿修罗lv1",
		repeated = "",
		enum = 111,
		effective_time = 1,
		keyword_type = 4,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。受伤时：再次获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效1次",
		gap = 0,
		trigger_time = 0,
		id = 3071,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[3072] = {
		name = "#阿修罗lv2",
		repeated = "",
		enum = 111,
		effective_time = 2,
		keyword_type = 4,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。受伤时：再次获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效2次",
		gap = 0,
		trigger_time = 0,
		id = 3072,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[3073] = {
		name = "#阿修罗lv3",
		repeated = "",
		enum = 111,
		effective_time = 3,
		keyword_type = 4,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。受伤时：再次获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 3073,
		icon = "",
		moment = 16,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[3081] = {
		name = "#努阿达lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：相邻两个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>与+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 3081,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			120,
			{
				3
			}
		}
	},
	[3082] = {
		name = "#努阿达lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：相邻两个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>与+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 3082,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			120,
			{
				3
			}
		}
	},
	[3083] = {
		name = "#努阿达lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：相邻两个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>与+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>",
		gap = 0,
		trigger_time = 0,
		id = 3083,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			120,
			{
				3
			}
		}
	},
	[3084] = {
		name = "#努阿达lv1-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#+2攻击力",
		gap = 0,
		trigger_time = 0,
		id = 3084,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			120,
			1,
			{
				2,
				0
			}
		}
	},
	[3085] = {
		name = "#努阿达lv2-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#+4攻击力",
		gap = 0,
		trigger_time = 0,
		id = 3085,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			120,
			1,
			{
				4,
				0
			}
		}
	},
	[3086] = {
		name = "#努阿达lv3-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#+6攻击力",
		gap = 0,
		trigger_time = 0,
		id = 3086,
		icon = "",
		moment = 11,
		action_type = 5,
		param = {
			120,
			1,
			{
				6,
				0
			}
		}
	},
	[3091] = {
		name = "#阿努比斯lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：在最前方召唤一个4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的胡狼",
		gap = 0,
		trigger_time = 0,
		id = 3091,
		icon = "",
		moment = 16,
		action_type = 3,
		param = {
			2,
			{
				3091
			}
		}
	},
	[3092] = {
		name = "#阿努比斯lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：在最前方召唤一个8<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的胡狼",
		gap = 0,
		trigger_time = 0,
		id = 3092,
		icon = "",
		moment = 16,
		action_type = 3,
		param = {
			2,
			{
				3092
			}
		}
	},
	[3093] = {
		name = "#阿努比斯lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：在最前方召唤一个12<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/9<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的胡狼",
		gap = 0,
		trigger_time = 0,
		id = 3093,
		icon = "",
		moment = 16,
		action_type = 3,
		param = {
			2,
			{
				3093
			}
		}
	},
	[3101] = {
		name = "#瓦吉特lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：对所有其他棋子造成1点伤害，触发1次",
		gap = 0,
		trigger_time = 0,
		id = 3101,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[3102] = {
		name = "#瓦吉特lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：对所有其他棋子造成1点伤害，触发2次",
		gap = 0,
		trigger_time = 1,
		id = 3102,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[3103] = {
		name = "#瓦吉特lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击后：对所有其他棋子造成1点伤害，触发3次",
		gap = 0,
		trigger_time = 2,
		id = 3103,
		icon = "",
		moment = 13,
		action_type = 2,
		param = {
			5,
			1
		}
	},
	[3111] = {
		name = "#梦影·俄尼里伊lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每购买2次其他棋子时：商店中的棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 2,
		trigger_time = 0,
		id = 3111,
		icon = "",
		moment = 3,
		action_type = 4,
		param = {
			2,
			{
				3114
			}
		}
	},
	[3112] = {
		name = "#梦影·俄尼里伊lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每购买2次其他棋子时：商店中的棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 2,
		trigger_time = 0,
		id = 3112,
		icon = "",
		moment = 3,
		action_type = 4,
		param = {
			2,
			{
				3115
			}
		}
	},
	[3113] = {
		name = "#梦影·俄尼里伊lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "每购买2次其他棋子时：商店中的棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 2,
		trigger_time = 0,
		id = 3113,
		icon = "",
		moment = 3,
		action_type = 4,
		param = {
			2,
			{
				3116
			}
		}
	},
	[3114] = {
		name = "#俄尼里伊lv1-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#商店中的棋子永久+1atk/+1hp",
		gap = 0,
		trigger_time = 0,
		id = 3114,
		icon = "",
		moment = 1,
		action_type = 24,
		param = {
			1,
			{
				1,
				1
			}
		}
	},
	[3115] = {
		name = "#俄尼里伊lv2-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#商店中的棋子永久+2atk/+2hp",
		gap = 0,
		trigger_time = 0,
		id = 3115,
		icon = "",
		moment = 1,
		action_type = 24,
		param = {
			1,
			{
				2,
				2
			}
		}
	},
	[3116] = {
		name = "#俄尼里伊lv3-附属buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#商店中的棋子永久+3atk/+3hp",
		gap = 0,
		trigger_time = 0,
		id = 3116,
		icon = "",
		moment = 1,
		action_type = 24,
		param = {
			1,
			{
				3,
				3
			}
		}
	},
	[3121] = {
		name = "#羲和lv1",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你造成的伤害额外提升1点",
		gap = 0,
		trigger_time = 0,
		id = 3121,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			4,
			1
		}
	},
	[3122] = {
		name = "#羲和lv2",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你造成的伤害额外提升2点",
		gap = 0,
		trigger_time = 0,
		id = 3122,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			4,
			2
		}
	},
	[3123] = {
		name = "#羲和lv3",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "你造成的伤害额外提升3点",
		gap = 0,
		trigger_time = 0,
		id = 3123,
		icon = "",
		moment = 1,
		action_type = 6,
		param = {
			1,
			4,
			3
		}
	},
	[3131] = {
		name = "#天诫·白泽lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：随机对1个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 3131,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			214,
			3
		}
	},
	[3132] = {
		name = "#天诫·白泽lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：随机对2个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 3132,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			215,
			3
		}
	},
	[3133] = {
		name = "#天诫·白泽lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：随机对3个敌方棋子造成3点伤害",
		gap = 0,
		trigger_time = 0,
		id = 3133,
		icon = "",
		moment = 17,
		action_type = 2,
		param = {
			216,
			3
		}
	},
	[3141] = {
		name = "#霜影·暗御津羽lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。攻击后：使后1个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>",
		gap = 0,
		trigger_time = 0,
		id = 3141,
		icon = "",
		moment = 13,
		action_type = 4,
		param = {
			127,
			{
				6
			}
		}
	},
	[3142] = {
		name = "#霜影·暗御津羽lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。攻击后：使后2个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>",
		gap = 0,
		trigger_time = 0,
		id = 3142,
		icon = "",
		moment = 13,
		action_type = 4,
		param = {
			128,
			{
				6
			}
		}
	},
	[3143] = {
		name = "#霜影·暗御津羽lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>。攻击后：使后3个棋子获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100006)>瓦解</material>",
		gap = 0,
		trigger_time = 0,
		id = 3143,
		icon = "",
		moment = 13,
		action_type = 4,
		param = {
			129,
			{
				6
			}
		}
	},
	[3151] = {
		name = "#沐风·恩利尔lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使后1个棋子获得被击杀棋子战斗开始时的<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（恩利尔除外）",
		gap = 0,
		trigger_time = 0,
		id = 3151,
		icon = "",
		moment = 22,
		action_type = 34,
		param = {
			1,
			127,
			3154,
			{
				0,
				1
			}
		}
	},
	[3152] = {
		name = "#沐风·恩利尔lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使后1个棋子获得被击杀棋子战斗开始时2倍的<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（恩利尔除外）",
		gap = 0,
		trigger_time = 0,
		id = 3152,
		icon = "",
		moment = 22,
		action_type = 34,
		param = {
			1,
			127,
			3154,
			{
				0,
				1
			}
		}
	},
	[3153] = {
		name = "#沐风·恩利尔lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "击杀时：使后1个棋子获得被击杀棋子战斗开始时3倍的<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（恩利尔除外）",
		gap = 0,
		trigger_time = 0,
		id = 3153,
		icon = "",
		moment = 22,
		action_type = 34,
		param = {
			1,
			127,
			3154,
			{
				0,
				1
			}
		}
	},
	[3154] = {
		name = "#恩利尔专属加属性",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "",
		gap = 0,
		trigger_time = 0,
		id = 3154,
		icon = "",
		moment = 1,
		action_type = 1,
		repeated = {
			3151,
			3152,
			3153
		},
		param = {
			{
				1,
				0
			},
			{
				1,
				0
			}
		}
	},
	[4011] = {
		name = "#托尔lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "购买&出售其他棋子时：随机1个己方棋子获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4011,
		icon = "",
		moment = 3,
		action_type = 5,
		param = {
			114,
			1,
			{
				2,
				2
			}
		}
	},
	[4012] = {
		name = "#托尔lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "购买&出售其他棋子时：随机1个己方棋子获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4012,
		icon = "",
		moment = 3,
		action_type = 5,
		param = {
			114,
			1,
			{
				4,
				4
			}
		}
	},
	[4013] = {
		name = "#托尔lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "购买&出售其他棋子时：随机1个己方棋子获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4013,
		icon = "",
		moment = 3,
		action_type = 5,
		param = {
			114,
			1,
			{
				6,
				6
			}
		}
	},
	[4014] = {
		name = "#托尔lv1-附属buff",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#出售其他棋子时：随机1个己方棋子获得+2atk/+2hp",
		gap = 0,
		trigger_time = 0,
		id = 4014,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			114,
			1,
			{
				2,
				2
			}
		}
	},
	[4015] = {
		name = "#托尔lv2-附属buff",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#出售其他棋子时：随机1个己方棋子获得+4atk/+4hp",
		gap = 0,
		trigger_time = 0,
		id = 4015,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			114,
			1,
			{
				4,
				4
			}
		}
	},
	[4016] = {
		name = "#托尔lv3-附属buff",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#出售其他棋子时：随机1个己方棋子获得+6atk/+6hp",
		gap = 0,
		trigger_time = 0,
		id = 4016,
		icon = "",
		moment = 5,
		action_type = 5,
		param = {
			114,
			1,
			{
				6,
				6
			}
		}
	},
	[4021] = {
		name = "#波塞冬lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：使己方棋子+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4021,
		icon = "",
		moment = 17,
		action_type = 5,
		param = {
			112,
			1,
			{
				1,
				1
			}
		}
	},
	[4022] = {
		name = "#波塞冬lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：使己方棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4022,
		icon = "",
		moment = 17,
		action_type = 5,
		param = {
			112,
			1,
			{
				2,
				2
			}
		}
	},
	[4023] = {
		name = "#波塞冬lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子阵亡时：使己方棋子+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4023,
		icon = "",
		moment = 17,
		action_type = 5,
		param = {
			112,
			1,
			{
				3,
				3
			}
		}
	},
	[4031] = {
		name = "#S奥西里斯lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身获得效果“首次攻击后：召唤自身战斗开始时的复制”",
		gap = 0,
		trigger_time = 0,
		id = 4031,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			111,
			{
				4034
			}
		}
	},
	[4032] = {
		name = "#S奥西里斯lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身与随机1个其他己方棋子获得效果“首次攻击后：召唤自身战斗开始时的复制”",
		gap = 0,
		trigger_time = 0,
		id = 4032,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			117,
			{
				4034
			}
		}
	},
	[4033] = {
		name = "#S奥西里斯lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身与随机2个其他己方棋子获得效果“首次攻击后：召唤自身战斗开始时的复制”",
		gap = 0,
		trigger_time = 0,
		id = 4033,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			118,
			{
				4034
			}
		}
	},
	[4034] = {
		name = "魂羽·奥西里斯",
		repeated = "",
		enum = 111,
		effective_time = 1,
		keyword_type = 0,
		is_show = 1,
		desc = "首次攻击后：召唤自身战斗开始时的复制",
		gap = 0,
		trigger_time = 0,
		id = 4034,
		icon = "buff_4034",
		moment = 13,
		action_type = 22,
		param = {
			111
		}
	},
	[4041] = {
		name = "#荷鲁斯lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使其他己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+1<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4041,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			113,
			2,
			{
				1,
				1
			}
		}
	},
	[4042] = {
		name = "#荷鲁斯lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使其他己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4042,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			113,
			2,
			{
				2,
				2
			}
		}
	},
	[4043] = {
		name = "#荷鲁斯lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "攻击时：使其他己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4043,
		icon = "",
		moment = 12,
		action_type = 5,
		param = {
			113,
			2,
			{
				3,
				3
			}
		}
	},
	[4051] = {
		name = "#欧申纳斯lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方1个棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤8<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/8<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”",
		gap = 0,
		trigger_time = 0,
		id = 4051,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			127,
			{
				701
			}
		}
	},
	[4052] = {
		name = "#欧申纳斯lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方2个棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤10<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/10<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”",
		gap = 0,
		trigger_time = 0,
		id = 4052,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			128,
			{
				706
			}
		}
	},
	[4053] = {
		name = "#欧申纳斯lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：使后方3个棋子获得效果“<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤13<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/13<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的欧申纳斯”",
		gap = 0,
		trigger_time = 0,
		id = 4053,
		icon = "",
		moment = 17,
		action_type = 4,
		param = {
			129,
			{
				709
			}
		}
	},
	[4061] = {
		name = "#伊邪那美lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的日狭女，该场战斗中每阵亡一个友方棋子，使其+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4061,
		icon = "",
		moment = 17,
		action_type = 23,
		param = {
			4061,
			1,
			{
				3,
				3
			}
		}
	},
	[4062] = {
		name = "#伊邪那美lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的日狭女，该场战斗中每阵亡一个友方棋子，使其+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4062,
		icon = "",
		moment = 17,
		action_type = 23,
		param = {
			4062,
			1,
			{
				6,
				6
			}
		}
	},
	[4063] = {
		name = "#伊邪那美lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 2,
		is_show = 1,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100002)>离场</material>：召唤一个9<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/9<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>的日狭女，该场战斗中每阵亡一个友方棋子，使其+9<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+9<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4063,
		icon = "",
		moment = 17,
		action_type = 23,
		param = {
			4063,
			1,
			{
				9,
				9
			}
		}
	},
	[4071] = {
		name = "#丝卡蒂lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。战斗开始时：使随机1个<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>棋子获得效果“首次失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>”",
		gap = 0,
		trigger_time = 0,
		id = 4071,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			153,
			{
				4074
			}
		}
	},
	[4072] = {
		name = "#丝卡蒂lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。战斗开始时：使随机2个<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>棋子获得效果“首次失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>”",
		gap = 0,
		trigger_time = 0,
		id = 4072,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			154,
			{
				4074
			}
		}
	},
	[4073] = {
		name = "#丝卡蒂lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。战斗开始时：使随机3个<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>棋子获得效果“首次失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>”",
		gap = 0,
		trigger_time = 0,
		id = 4073,
		icon = "",
		moment = 11,
		action_type = 4,
		param = {
			155,
			{
				4074
			}
		}
	},
	[4074] = {
		name = "斩浪·丝卡蒂",
		repeated = "",
		enum = 111,
		effective_time = 1,
		keyword_type = 0,
		is_show = 1,
		desc = "首次失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>",
		gap = 0,
		trigger_time = 0,
		id = 4074,
		icon = "buff_4074",
		moment = 20,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[4081] = {
		name = "#帕尔瓦蒂lv1",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。己方棋子失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：使其<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+1<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4081,
		icon = "",
		moment = 20,
		action_type = 5,
		param = {
			13,
			2,
			{
				1,
				2
			}
		}
	},
	[4082] = {
		name = "#帕尔瓦蒂lv2",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。己方棋子失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：使其<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4082,
		icon = "",
		moment = 20,
		action_type = 5,
		param = {
			13,
			2,
			{
				2,
				4
			}
		}
	},
	[4083] = {
		name = "#帕尔瓦蒂lv3",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 1,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。己方棋子失去<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>时：使其<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4083,
		icon = "",
		moment = 20,
		action_type = 5,
		param = {
			13,
			2,
			{
				3,
				6
			}
		}
	},
	[4091] = {
		name = "#塞勒涅lv1",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4091,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			114,
			2,
			{
				2,
				2
			}
		}
	},
	[4092] = {
		name = "#塞勒涅lv2",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4092,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			114,
			2,
			{
				4,
				4
			}
		}
	},
	[4093] = {
		name = "#塞勒涅lv3",
		repeated = "",
		enum = 111,
		effective_time = 0,
		keyword_type = 4,
		is_show = 0,
		desc = "受伤时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4093,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			114,
			2,
			{
				6,
				6
			}
		}
	},
	[4101] = {
		name = "#S月读lv1",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子受伤时：使自身获得+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4101,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				2,
				2
			}
		}
	},
	[4102] = {
		name = "#S月读lv2",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子受伤时：使自身获得+4<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+4<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4102,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				4,
				4
			}
		}
	},
	[4103] = {
		name = "#S月读lv3",
		repeated = "",
		enum = 113,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "其他己方棋子受伤时：使自身获得+6<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+6<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4103,
		icon = "",
		moment = 16,
		action_type = 5,
		param = {
			111,
			1,
			{
				6,
				6
			}
		}
	},
	[4111] = {
		name = "#玄机·执明lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身与随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4111,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			111,
			1,
			{
				1,
				1
			},
			{
				1,
				1
			}
		}
	},
	[4112] = {
		name = "#玄机·执明lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身与随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4112,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			111,
			1,
			{
				2,
				2
			},
			{
				2,
				2
			}
		}
	},
	[4113] = {
		name = "#玄机·执明lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：使自身与随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4113,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			111,
			1,
			{
				3,
				3
			},
			{
				3,
				3
			}
		}
	},
	[4114] = {
		name = "#玄机·执明lv1-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#战斗开始时：使随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4114,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			117,
			1,
			{
				1,
				1
			},
			{
				1,
				1
			}
		}
	},
	[4115] = {
		name = "#玄机·执明lv2-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#战斗开始时：使随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4115,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			117,
			1,
			{
				2,
				2
			},
			{
				2,
				2
			}
		}
	},
	[4116] = {
		name = "#玄机·执明lv3-附属buff",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#战斗开始时：使随机1个其他己方棋子+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>（每使用一个道具额外+%s<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+%s<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>）",
		gap = 0,
		trigger_time = 0,
		id = 4116,
		icon = "",
		moment = 11,
		action_type = 36,
		param = {
			117,
			1,
			{
				3,
				3
			},
			{
				3,
				3
			}
		}
	},
	[4121] = {
		name = "#狂狮·塞赫麦特lv1",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻1个棋子对敌造成伤害时：随机使1个己方棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4121,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			114,
			1,
			{
				2,
				2
			}
		}
	},
	[4122] = {
		name = "#狂狮·塞赫麦特lv2",
		repeated = "",
		enum = 122,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻2个棋子对敌造成伤害时：随机使1个己方棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4122,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			114,
			1,
			{
				2,
				2
			}
		}
	},
	[4123] = {
		name = "#狂狮·塞赫麦特lv3",
		repeated = "",
		enum = 123,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻3个棋子对敌造成伤害时：随机使1个己方棋子+2<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+2<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4123,
		icon = "",
		moment = 23,
		action_type = 5,
		param = {
			114,
			1,
			{
				2,
				2
			}
		}
	},
	[4131] = {
		name = "#荒獠·金固lv1",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：在最前方召唤1个S级的索贝克\n己方棋子每对敌造成8次伤害时：再次召唤（<material=underline c=#FFFFFF h=2 event=terminology args=(1100007)>全场</material>召唤上限8）",
		gap = 0,
		trigger_time = 0,
		id = 4131,
		icon = "",
		moment = 11,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					1
				}
			}
		}
	},
	[4132] = {
		name = "#荒獠·金固lv2",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：在最前方召唤1个SS级的索贝克\n己方棋子每对敌造成8次伤害时：再次召唤（<material=underline c=#FFFFFF h=2 event=terminology args=(1100007)>全场</material>召唤上限8）",
		gap = 0,
		trigger_time = 0,
		id = 4132,
		icon = "",
		moment = 11,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					3
				}
			}
		}
	},
	[4133] = {
		name = "#荒獠·金固lv3",
		repeated = "",
		enum = 1,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "战斗开始时：在最前方召唤1个SSS级的索贝克\n己方棋子每对敌造成8次伤害时：再次召唤（<material=underline c=#FFFFFF h=2 event=terminology args=(1100007)>全场</material>召唤上限8）",
		gap = 0,
		trigger_time = 0,
		id = 4133,
		icon = "",
		moment = 11,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					6
				}
			}
		}
	},
	[4134] = {
		name = "#荒獠·金固lv1-附属buff",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#己方棋子每对敌造成8次伤害时：获得召唤buff与计数",
		gap = 8,
		trigger_time = 0,
		id = 4134,
		icon = "",
		moment = 23,
		action_type = 4,
		param = {
			2,
			{
				4137,
				714
			}
		}
	},
	[4135] = {
		name = "#荒獠·金固lv2-附属buff",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#己方棋子每对敌造成8次伤害时：获得召唤buff与计数",
		gap = 8,
		trigger_time = 0,
		id = 4135,
		icon = "",
		moment = 23,
		action_type = 4,
		param = {
			2,
			{
				4138,
				714
			}
		}
	},
	[4136] = {
		name = "#荒獠·金固lv3-附属buff",
		repeated = "",
		enum = 112,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#己方棋子每对敌造成8次伤害时：获得召唤buff与计数",
		gap = 8,
		trigger_time = 0,
		id = 4136,
		icon = "",
		moment = 23,
		action_type = 4,
		param = {
			2,
			{
				4139,
				714
			}
		}
	},
	[4137] = {
		name = "#金固lv1-召唤buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#获得时：在最前方召唤1个S级的索贝克",
		gap = 0,
		trigger_time = 0,
		id = 4137,
		icon = "",
		moment = 1,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					1
				}
			}
		}
	},
	[4138] = {
		name = "#金固lv2-召唤buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#获得时：在最前方召唤1个SS级的索贝克",
		gap = 0,
		trigger_time = 0,
		id = 4138,
		icon = "",
		moment = 1,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					3
				}
			}
		}
	},
	[4139] = {
		name = "#金固lv3-召唤buff",
		repeated = "",
		enum = 0,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "#获得时：在最前方召唤1个SSS级的索贝克",
		gap = 0,
		trigger_time = 0,
		id = 4139,
		icon = "",
		moment = 1,
		action_type = 37,
		param = {
			2,
			{
				{
					112,
					6
				}
			}
		}
	},
	[4141] = {
		name = "#怒蛇·马尔杜克v1",
		repeated = "",
		enum = 121,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻1个棋子击杀时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4141,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			114,
			2,
			{
				3,
				3
			}
		}
	},
	[4142] = {
		name = "#怒蛇·马尔杜克v2",
		repeated = "",
		enum = 122,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻2个棋子击杀时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4142,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			114,
			2,
			{
				3,
				3
			}
		}
	},
	[4143] = {
		name = "#怒蛇·马尔杜克v3",
		repeated = "",
		enum = 123,
		effective_time = 0,
		keyword_type = 0,
		is_show = 0,
		desc = "前方相邻3个棋子击杀时：随机使1个己方棋子<material=underline c=#FFFFFF h=2 event=terminology args=(1100005)>永久</material>+3<icon name=atk sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/atk/>/+3<icon name=hp sprite_path=TextureConfig/Activity_OsirisHorus/Text_Img/hp/>",
		gap = 0,
		trigger_time = 0,
		id = 4143,
		icon = "",
		moment = 22,
		action_type = 5,
		param = {
			114,
			2,
			{
				3,
				3
			}
		}
	},
	[4151] = {
		name = "#巡天·英招lv1",
		repeated = "",
		enum = 111,
		effective_time = 1,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。击杀时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效1次",
		gap = 0,
		trigger_time = 0,
		id = 4151,
		icon = "",
		moment = 22,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[4152] = {
		name = "#巡天·英招lv2",
		repeated = "",
		enum = 111,
		effective_time = 2,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。击杀时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效2次",
		gap = 0,
		trigger_time = 0,
		id = 4152,
		icon = "",
		moment = 22,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	[4153] = {
		name = "#巡天·英招lv3",
		repeated = "",
		enum = 111,
		effective_time = 3,
		keyword_type = 0,
		is_show = 0,
		desc = "<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>。击杀时：获得<material=underline c=#FFFFFF h=2 event=terminology args=(1100001)>护盾</material>，生效3次",
		gap = 0,
		trigger_time = 0,
		id = 4153,
		icon = "",
		moment = 22,
		action_type = 4,
		param = {
			111,
			{
				3
			}
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		98,
		99,
		101,
		102,
		103,
		104,
		199,
		201,
		202,
		203,
		204,
		205,
		299,
		301,
		302,
		303,
		304,
		305,
		306,
		401,
		402,
		403,
		404,
		405,
		407,
		502,
		503,
		504,
		505,
		506,
		507,
		508,
		511,
		512,
		513,
		514,
		515,
		516,
		517,
		518,
		521,
		522,
		523,
		524,
		525,
		526,
		527,
		528,
		529,
		530,
		531,
		541,
		542,
		543,
		544,
		545,
		601,
		611,
		621,
		622,
		701,
		702,
		703,
		704,
		705,
		706,
		707,
		708,
		709,
		710,
		711,
		712,
		713,
		714,
		715,
		1011,
		1012,
		1013,
		1021,
		1022,
		1023,
		1031,
		1032,
		1033,
		1041,
		1042,
		1043,
		1051,
		1052,
		1053,
		1061,
		1062,
		1063,
		1071,
		1072,
		1073,
		1081,
		1082,
		1083,
		1091,
		1092,
		1093,
		1101,
		1102,
		1103,
		1111,
		1112,
		1113,
		1121,
		1122,
		1123,
		1131,
		1132,
		1133,
		1141,
		1142,
		1143,
		2011,
		2012,
		2013,
		2021,
		2022,
		2023,
		2024,
		2025,
		2026,
		2031,
		2032,
		2033,
		2041,
		2042,
		2043,
		2051,
		2052,
		2053,
		2061,
		2062,
		2063,
		2064,
		2065,
		2066,
		2071,
		2072,
		2073,
		2081,
		2082,
		2083,
		2091,
		2092,
		2093,
		2101,
		2102,
		2103,
		2111,
		2112,
		2113,
		2121,
		2122,
		2123,
		2131,
		2132,
		2133,
		2141,
		2142,
		2143,
		2151,
		2152,
		2153,
		3011,
		3012,
		3013,
		3021,
		3022,
		3023,
		3031,
		3032,
		3033,
		3034,
		3035,
		3036,
		3037,
		3038,
		3039,
		3041,
		3042,
		3043,
		3051,
		3052,
		3053,
		3061,
		3062,
		3063,
		3071,
		3072,
		3073,
		3081,
		3082,
		3083,
		3084,
		3085,
		3086,
		3091,
		3092,
		3093,
		3101,
		3102,
		3103,
		3111,
		3112,
		3113,
		3114,
		3115,
		3116,
		3121,
		3122,
		3123,
		3131,
		3132,
		3133,
		3141,
		3142,
		3143,
		3151,
		3152,
		3153,
		3154,
		4011,
		4012,
		4013,
		4014,
		4015,
		4016,
		4021,
		4022,
		4023,
		4031,
		4032,
		4033,
		4034,
		4041,
		4042,
		4043,
		4051,
		4052,
		4053,
		4061,
		4062,
		4063,
		4071,
		4072,
		4073,
		4074,
		4081,
		4082,
		4083,
		4091,
		4092,
		4093,
		4101,
		4102,
		4103,
		4111,
		4112,
		4113,
		4114,
		4115,
		4116,
		4121,
		4122,
		4123,
		4131,
		4132,
		4133,
		4134,
		4135,
		4136,
		4137,
		4138,
		4139,
		4141,
		4142,
		4143,
		4151,
		4152,
		4153
	}
}
