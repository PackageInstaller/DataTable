return {
	{
		chapterID = 1,
		name = "限时集成考验",
		activityID = 293231,
		type = 1,
		tetris_stage_list = {
			1
		},
		unlock_condition = {}
	},
	{
		chapterID = 2,
		name = "集成考验A",
		activityID = 293251,
		type = 2,
		tetris_stage_list = {
			2,
			3,
			4
		},
		unlock_condition = {}
	},
	{
		chapterID = 3,
		name = "集成考验B",
		activityID = 293252,
		type = 2,
		tetris_stage_list = {
			5,
			6
		},
		unlock_condition = {}
	},
	[40101] = {
		chapterID = 40101,
		name = "集成考验",
		activityID = 333231,
		type = 1,
		tetris_stage_list = {
			40101
		},
		unlock_condition = {
			1190207
		}
	},
	[40102] = {
		chapterID = 40102,
		name = "集成初试",
		activityID = 333251,
		type = 2,
		tetris_stage_list = {
			40102,
			40103
		},
		unlock_condition = {}
	},
	[40103] = {
		chapterID = 40103,
		name = "集成特训",
		activityID = 333252,
		type = 2,
		tetris_stage_list = {
			40104,
			40105,
			40106,
			40107,
			40108,
			40109
		},
		unlock_condition = {
			1190101
		}
	},
	[40801] = {
		chapterID = 40801,
		name = "集成考验",
		activityID = 4032301,
		type = 1,
		tetris_stage_list = {
			40801
		},
		unlock_condition = {
			1190217
		}
	},
	[40802] = {
		chapterID = 40802,
		name = "集成初试",
		activityID = 4032501,
		type = 2,
		tetris_stage_list = {
			40802,
			40803
		},
		unlock_condition = {}
	},
	[40803] = {
		chapterID = 40803,
		name = "集成特训",
		activityID = 4032502,
		type = 2,
		tetris_stage_list = {
			40804,
			40805,
			40806,
			40807,
			40808,
			40809
		},
		unlock_condition = {
			1190102
		}
	},
	get_id_list_by_activityID = {
		[4032502] = {
			40803
		},
		[4032501] = {
			40802
		},
		[4032301] = {
			40801
		},
		[333252] = {
			40103
		},
		[333251] = {
			40102
		},
		[333231] = {
			40101
		},
		[293252] = {
			3
		},
		[293251] = {
			2
		},
		[293231] = {
			1
		}
	},
	get_id_list_by_tetris_stage_list = {
		[40809] = {
			40803
		},
		[40808] = {
			40803
		},
		[40807] = {
			40803
		},
		[40806] = {
			40803
		},
		[40805] = {
			40803
		},
		[40804] = {
			40803
		},
		[40803] = {
			40802
		},
		[40802] = {
			40802
		},
		[40801] = {
			40801
		},
		[40109] = {
			40103
		},
		[40108] = {
			40103
		},
		[40107] = {
			40103
		},
		[40106] = {
			40103
		},
		[40105] = {
			40103
		},
		[40104] = {
			40103
		},
		[40103] = {
			40102
		},
		[40102] = {
			40102
		},
		[40101] = {
			40101
		},
		[6] = {
			3
		},
		[5] = {
			3
		},
		[4] = {
			2
		},
		[3] = {
			2
		},
		[2] = {
			2
		},
		{
			1
		}
	},
	get_id_list_by_type = {
		[2] = {
			2,
			3,
			40102,
			40103,
			40802,
			40803
		},
		{
			1,
			40101,
			40801
		}
	},
	all = {
		1,
		2,
		3,
		40101,
		40102,
		40103,
		40801,
		40802,
		40803
	}
}
