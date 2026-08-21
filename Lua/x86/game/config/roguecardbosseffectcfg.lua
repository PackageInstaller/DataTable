return {
	[101] = {
		weight = 50,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 101,
		desc = "出牌次数+1",
		effect_list = {
			601
		}
	},
	[102] = {
		weight = 75,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 102,
		desc = "弃牌次数+1",
		effect_list = {
			602
		}
	},
	[103] = {
		weight = 100,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 103,
		desc = "无常的连携支援重置数+2",
		effect_list = {
			603
		}
	},
	[104] = {
		weight = 100,
		coefficient = 0,
		max_num = 2,
		type = 1,
		id = 104,
		desc = "商店刷新花费-2<icon name=Activity_JokerCard_texticon_01 sprite_path=TextureConfig/Activity_JokerCard/item/Activity_JokerCard_texticon_01/>",
		effect_list = {
			604
		}
	},
	[105] = {
		weight = 75,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 105,
		desc = "可携带异常物件数+1",
		effect_list = {
			605
		}
	},
	[106] = {
		weight = 100,
		coefficient = 0,
		max_num = 2,
		type = 1,
		id = 106,
		desc = "商店货物售价-25%",
		effect_list = {
			606
		}
	},
	[107] = {
		weight = 75,
		coefficient = 0,
		max_num = 2,
		type = 1,
		id = 107,
		desc = "商店物件槽位+1",
		effect_list = {
			607
		}
	},
	[108] = {
		weight = 100,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 108,
		desc = "提升所有的牌型1个等级",
		effect_list = {
			608
		}
	},
	[109] = {
		weight = 75,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 109,
		desc = "随机强化一个异常物件",
		effect_list = {
			609
		}
	},
	[110] = {
		weight = 100,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 110,
		desc = "获得10<icon name=Activity_JokerCard_texticon_01 sprite_path=TextureConfig/Activity_JokerCard/item/Activity_JokerCard_texticon_01/>",
		effect_list = {
			610
		}
	},
	[111] = {
		weight = 100,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 111,
		desc = "随机获得一个稀有异常物件（需要有空位）",
		effect_list = {
			611
		}
	},
	[112] = {
		weight = 25,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 112,
		desc = "下一个商店所有商品免费",
		effect_list = {
			612
		}
	},
	[113] = {
		weight = 100,
		coefficient = 0,
		max_num = 2,
		type = 1,
		id = 113,
		desc = "降低普通异常物件出现概率",
		effect_list = {
			613
		}
	},
	[199] = {
		weight = 0,
		coefficient = 0,
		max_num = 0,
		type = 1,
		id = 199,
		desc = "#空恩效果",
		effect_list = {}
	},
	[201] = {
		weight = 100,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 201,
		desc = "失去所有弃牌次数",
		effect_list = {
			701
		}
	},
	[202] = {
		weight = 100,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 202,
		desc = "需要更多目标分",
		effect_list = {
			702
		}
	},
	[203] = {
		weight = 25,
		coefficient = 100,
		max_num = 0,
		type = 2,
		id = 203,
		desc = "只允许出1次牌",
		effect_list = {
			703
		}
	},
	[204] = {
		weight = 100,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 204,
		desc = "强制选中1张牌",
		effect_list = {
			704
		}
	},
	[205] = {
		weight = 100,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 205,
		desc = "抽牌时，1/4概率使其失效",
		effect_list = {
			705
		}
	},
	[206] = {
		weight = 75,
		coefficient = 150,
		max_num = 0,
		type = 2,
		id = 206,
		desc = "禁止打出重复牌型",
		effect_list = {
			706
		}
	},
	[207] = {
		weight = 50,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 207,
		desc = "只能打出1种牌型",
		effect_list = {
			707
		}
	},
	[208] = {
		weight = 75,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 208,
		desc = "手牌上限-1",
		effect_list = {
			708
		}
	},
	[209] = {
		weight = 50,
		coefficient = 100,
		max_num = 0,
		type = 2,
		id = 209,
		desc = "无咎牌失效",
		effect_list = {
			709
		}
	},
	[210] = {
		weight = 100,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 210,
		desc = "每次出牌后，随机弃1张手牌",
		effect_list = {
			710
		}
	},
	[299] = {
		weight = 0,
		coefficient = 200,
		max_num = 0,
		type = 2,
		id = 299,
		desc = "#空祸效果，分数X2",
		effect_list = {}
	},
	get_id_list_by_type = {
		[2] = {
			201,
			202,
			203,
			204,
			205,
			206,
			207,
			208,
			209,
			210,
			299
		},
		{
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
			199
		}
	},
	all = {
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
		199,
		201,
		202,
		203,
		204,
		205,
		206,
		207,
		208,
		209,
		210,
		299
	}
}
