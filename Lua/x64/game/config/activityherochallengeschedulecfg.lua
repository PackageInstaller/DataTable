return {
	[2428401] = {
		score = 25,
		name = "回响启示",
		select_type = 0,
		linkgame_des = "完成1次未通关的回响启示关卡",
		type = 1,
		server_type = 1,
		priority = 1,
		activity_id = 242841,
		id = 2428401,
		pre_condition = {},
		remove_condition = {
			112001
		}
	},
	[2428402] = {
		score = 25,
		name = "神能训练",
		select_type = 0,
		linkgame_des = "完成1次神能训练关卡",
		type = 1,
		server_type = 2,
		priority = 2,
		activity_id = 242841,
		id = 2428402,
		pre_condition = {
			112001
		},
		remove_condition = {}
	},
	[2428403] = {
		score = 25,
		name = "意志训练",
		select_type = 0,
		linkgame_des = "完成1次意志训练关卡",
		type = 1,
		server_type = 3,
		priority = 3,
		activity_id = 242841,
		id = 2428403,
		pre_condition = {
			112001
		},
		remove_condition = {}
	},
	[2428404] = {
		score = 25,
		name = "技巧训练",
		select_type = 0,
		linkgame_des = "完成1次技巧训练关卡",
		type = 1,
		server_type = 4,
		priority = 4,
		activity_id = 242841,
		id = 2428404,
		pre_condition = {
			112001
		},
		remove_condition = {}
	},
	[2428405] = {
		score = 100,
		name = "侵蚀抵抗",
		select_type = 0,
		linkgame_des = "完成1次侵蚀抵抗关卡",
		type = 1,
		server_type = 5,
		priority = 5,
		activity_id = 242851,
		id = 2428405,
		pre_condition = {
			112001
		},
		remove_condition = {}
	},
	[2428406] = {
		score = 25,
		name = "演绎行乐",
		select_type = 0,
		linkgame_des = "完成1次演绎行乐关卡",
		type = 2,
		server_type = 6,
		priority = 1,
		activity_id = 242841,
		id = 2428406,
		pre_condition = {},
		remove_condition = {
			112011
		}
	},
	[2428407] = {
		score = 25,
		name = "闲暇时刻",
		select_type = 0,
		linkgame_des = "完成1次闲暇时刻小游戏",
		type = 2,
		server_type = 7,
		priority = 2,
		activity_id = 242841,
		id = 2428407,
		pre_condition = {},
		remove_condition = {}
	},
	[2428408] = {
		score = 25,
		name = "故地重游",
		select_type = 0,
		linkgame_des = "接取1次故地重游任意等级委托",
		type = 3,
		server_type = 8,
		priority = 1,
		activity_id = 242841,
		id = 2428408,
		pre_condition = {},
		remove_condition = {}
	},
	get_id_list_by_type = {
		[3] = {
			2428408
		},
		[2] = {
			2428406,
			2428407
		},
		{
			2428401,
			2428402,
			2428403,
			2428404,
			2428405
		}
	},
	get_id_list_by_server_type = {
		[8] = {
			2428408
		},
		[7] = {
			2428407
		},
		[6] = {
			2428406
		},
		[5] = {
			2428405
		},
		[4] = {
			2428404
		},
		[3] = {
			2428403
		},
		[2] = {
			2428402
		},
		{
			2428401
		}
	},
	all = {
		2428401,
		2428402,
		2428403,
		2428404,
		2428405,
		2428406,
		2428407,
		2428408
	}
}
