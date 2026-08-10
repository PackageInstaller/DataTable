return {
	[101] = {
		event_id = 101,
		event_desc = "在训练的同时，霍德尔用权钥详细记录了刚才的作战实况。",
		event_title = "同步录像",
		condition = 5310220,
		event_option = {
			1011,
			1012
		}
	},
	[201] = {
		event_id = 201,
		event_desc = "明明是数据构筑的空间，却凭空掉下一本书来，你下意识看去……这是一本「画工大胆」的漫画，光是封面就已经超越了大多数人的理解阈值。",
		event_title = "彩色漫画",
		condition = 0,
		event_option = {
			2011,
			2012
		}
	},
	[202] = {
		event_id = 202,
		event_desc = "数据复现的欧莫菲斯景观依旧灿烂动人，霍德尔目不转睛地欣赏着陈列在面前的工艺品们。",
		event_title = "咫尺艺术",
		condition = 5310213,
		event_option = {
			2021,
			2022
		}
	},
	[203] = {
		event_id = 203,
		event_desc = "数据复现了夏什瓦特的市集，你们在这里找到了一张熟悉的古典音乐CD。",
		event_title = "过去的CD",
		condition = 5310211,
		event_option = {
			2031,
			2032
		}
	},
	[301] = {
		event_id = 301,
		event_desc = "连续的战斗让霍德尔汗湿了衣襟，她抱歉地擦了擦镜片上的雾气。",
		event_title = "热意",
		condition = 0,
		event_option = {
			3011,
			3012
		}
	},
	[302] = {
		event_id = 302,
		event_desc = "数据复现的笹波音乐剧别具特色，你隐约听到身侧传来低低的唱和声。",
		event_title = "天籁",
		condition = 5310201,
		event_option = {
			3021,
			3022
		}
	},
	[303] = {
		event_id = 303,
		event_desc = "短促却接连不停的震动声传来，你竟在权钥内发现了一个无主终端。",
		event_title = "讯息",
		condition = 5310202,
		event_option = {
			3031,
			3032
		}
	},
	get_id_list_by_event_option = {
		[3032] = {
			303
		},
		[3031] = {
			303
		},
		[3022] = {
			302
		},
		[3021] = {
			302
		},
		[3012] = {
			301
		},
		[3011] = {
			301
		},
		[2032] = {
			203
		},
		[2031] = {
			203
		},
		[2022] = {
			202
		},
		[2021] = {
			202
		},
		[2012] = {
			201
		},
		[2011] = {
			201
		},
		[1012] = {
			101
		},
		[1011] = {
			101
		}
	},
	all = {
		101,
		201,
		202,
		203,
		301,
		302,
		303
	}
}
