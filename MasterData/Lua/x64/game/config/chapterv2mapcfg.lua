return {
	[40801] = {
		name = "4.8大荒序章",
		default_chara = 1001,
		sheet = "bgm_activity_4_8_ui",
		timeline_unlock_condition = 118083,
		chapter_client_id = 10123,
		bgm = "bgm_activity_4_8_ui",
		id = 40801,
		default_location = 4080110103,
		unlock_condition = {
			118006
		},
		switch_chara = {},
		mist_unlock_condition = {}
	},
	[40802] = {
		name = "4.8本土",
		default_chara = 1001,
		sheet = "bgm_activity_4_8_ui",
		timeline_unlock_condition = 118087,
		chapter_client_id = 10123,
		bgm = "bgm_activity_4_8_ui",
		id = 40802,
		default_location = 4080210201,
		unlock_condition = {
			118012
		},
		switch_chara = {
			{
				118023,
				1053
			}
		},
		mist_unlock_condition = {
			118089,
			118087,
			118090,
			118091
		}
	},
	[40803] = {
		name = "4.8大荒",
		default_chara = 1001,
		sheet = "bgm_activity_4_8_ui",
		timeline_unlock_condition = 0,
		chapter_client_id = 10123,
		bgm = "bgm_activity_4_8_ui",
		id = 40803,
		default_location = 40803204,
		unlock_condition = {
			118023
		},
		switch_chara = {},
		mist_unlock_condition = {
			118093,
			118094,
			118095
		}
	},
	[50002] = {
		name = "5.0本土",
		default_chara = 1001,
		sheet = "bgm_activity_5_0_ui",
		timeline_unlock_condition = 0,
		chapter_client_id = 10124,
		bgm = "bgm_activity_5_0_ui",
		id = 50002,
		default_location = 5000210201,
		unlock_condition = {},
		switch_chara = {},
		mist_unlock_condition = {}
	},
	[50003] = {
		name = "5.0大荒",
		default_chara = 1001,
		sheet = "bgm_activity_5_0_ui",
		timeline_unlock_condition = 0,
		chapter_client_id = 10124,
		bgm = "bgm_activity_5_0_ui",
		id = 50003,
		default_location = 50003203,
		unlock_condition = {},
		switch_chara = {},
		mist_unlock_condition = {}
	},
	[50101] = {
		name = "5.1大荒",
		default_chara = 1001,
		sheet = "bgm_activity_5_0_ui",
		timeline_unlock_condition = 0,
		chapter_client_id = 10125,
		bgm = "bgm_activity_5_0_ui",
		id = 50101,
		default_location = 50101101,
		unlock_condition = {},
		switch_chara = {},
		mist_unlock_condition = {}
	},
	[50102] = {
		name = "5.1本土",
		default_chara = 1001,
		sheet = "bgm_activity_5_0_ui",
		timeline_unlock_condition = 0,
		chapter_client_id = 10125,
		bgm = "bgm_activity_5_0_ui",
		id = 50102,
		default_location = 5010210303,
		unlock_condition = {},
		switch_chara = {},
		mist_unlock_condition = {}
	},
	get_id_list_by_chapter_client_id = {
		[10125] = {
			50101,
			50102
		},
		[10124] = {
			50002,
			50003
		},
		[10123] = {
			40801,
			40802,
			40803
		}
	},
	all = {
		40801,
		40802,
		40803,
		50002,
		50003,
		50101,
		50102
	}
}
