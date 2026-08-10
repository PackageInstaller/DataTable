return {
	[101] = {
		name = "潜逃",
		pre_chapter = 0,
		chapterID = 101,
		activityID = 283121,
		conclusion_tips = "先还原他的工作流程，再确认他去了哪里吧……",
		chapter_desc = "镜头之外，阿尔忒弥斯似乎偶然遇见了熟悉的人影，他去了哪里？",
		tips_num = 1,
		chapter_question = "点击线索进行排序，推理出配送员的行动路线，然后确认他去了哪里。",
		puzzle_stage_list = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006
		},
		inference_stage_list = {
			1007
		},
		unlock_condition_list = {
			1150111
		}
	},
	[102] = {
		name = "藏踪",
		pre_chapter = 0,
		chapterID = 102,
		activityID = 283122,
		conclusion_tips = "时间先后顺序似乎能解答疑问……",
		chapter_desc = "环顾四周，配送员似乎并未出现在店内，他现在在哪里？",
		tips_num = 1,
		chapter_question = "点击线索进行排序，推理还原出阿波罗在游乐园的行动路线。",
		puzzle_stage_list = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2006
		},
		inference_stage_list = {
			2007
		},
		unlock_condition_list = {
			1150114
		}
	},
	get_id_list_by_puzzle_stage_list = {
		[2006] = {
			102
		},
		[2005] = {
			102
		},
		[2004] = {
			102
		},
		[2003] = {
			102
		},
		[2002] = {
			102
		},
		[2001] = {
			102
		},
		[1006] = {
			101
		},
		[1005] = {
			101
		},
		[1004] = {
			101
		},
		[1003] = {
			101
		},
		[1002] = {
			101
		},
		[1001] = {
			101
		}
	},
	get_id_list_by_inference_stage_list = {
		[2007] = {
			102
		},
		[1007] = {
			101
		}
	},
	all = {
		101,
		102
	}
}
