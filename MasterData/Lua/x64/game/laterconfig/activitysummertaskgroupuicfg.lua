return {
	[1001] = {
		activity_id = 280003,
		name = "探索任务",
		id = 1001,
		theme = 28,
		prefab_path = "Widget/System/Summer2024/Summer2024_Quest/Summer2024_QuestExploreUI",
		main_activity_id = 283011,
		group_id = 1,
		item_id_list = {},
		class_name = SummerChessBoardChessTaskView
	},
	[1002] = {
		id = 1002,
		activity_id = 0,
		theme = 28,
		main_activity_id = 0,
		group_id = 2,
		prefab_path = "",
		name = "挑战任务",
		item_id_list = {
			1,
			2
		}
	},
	[1003] = {
		id = 1003,
		activity_id = 0,
		theme = 28,
		main_activity_id = 0,
		group_id = 3,
		prefab_path = "",
		name = "限时任务",
		item_id_list = {
			3,
			4,
			5,
			6,
			7,
			8
		}
	},
	get_id_list_by_theme = {
		[28] = {
			1001,
			1002,
			1003
		}
	},
	all = {
		1001,
		1002,
		1003
	}
}
