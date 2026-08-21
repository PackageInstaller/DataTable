return {
	[81431] = {
		name = "首演剧场",
		setting_template_id = 1,
		type = 1,
		hero_template_id = 1,
		activity_id = 81431,
		init_effect_template_id = 1,
		preconditions = 0,
		custom_affix = {},
		race_list = {
			1
		},
		before_story_id = {
			900000001,
			900101001
		},
		after_story_id = {
			900102001
		},
		hero_trial = {
			104203
		}
	},
	[81432] = {
		name = "迷途剧场",
		setting_template_id = 1,
		type = 1,
		hero_template_id = 1,
		activity_id = 81432,
		init_effect_template_id = 1,
		preconditions = 81431,
		custom_affix = {},
		race_list = {
			2
		},
		before_story_id = {
			900201001
		},
		after_story_id = {
			900202001
		},
		hero_trial = {
			111903
		}
	},
	[81433] = {
		name = "异闻剧场",
		setting_template_id = 1,
		type = 1,
		hero_template_id = 1,
		activity_id = 81433,
		init_effect_template_id = 1,
		preconditions = 81432,
		custom_affix = {},
		race_list = {
			3
		},
		before_story_id = {
			900301001
		},
		after_story_id = {
			900302001
		},
		hero_trial = {
			105004
		}
	},
	[81434] = {
		name = "渴望剧场",
		setting_template_id = 1,
		type = 1,
		hero_template_id = 1,
		activity_id = 81434,
		init_effect_template_id = 1,
		preconditions = 81433,
		custom_affix = {},
		race_list = {
			4
		},
		before_story_id = {
			900401001
		},
		after_story_id = {
			900402001
		},
		hero_trial = {
			118404
		}
	},
	[81435] = {
		name = "真相剧场",
		setting_template_id = 1,
		type = 1,
		hero_template_id = 1,
		activity_id = 81435,
		init_effect_template_id = 1,
		preconditions = 81434,
		custom_affix = {},
		race_list = {
			5
		},
		before_story_id = {
			900501001
		},
		after_story_id = {
			900502001
		},
		hero_trial = {
			112703
		}
	},
	[81436] = {
		name = "终幕剧场",
		setting_template_id = 1,
		type = 2,
		hero_template_id = 1,
		activity_id = 81436,
		init_effect_template_id = 2,
		preconditions = 81435,
		custom_affix = {
			11063,
			11064,
			11065,
			11072,
			11073,
			11074,
			11093,
			11094,
			11095,
			11108,
			11109,
			11110,
			11111,
			11116,
			11117,
			11118,
			11246,
			11247,
			11248,
			11249,
			11250,
			11251,
			11252,
			11253,
			11254,
			11255
		},
		race_list = {
			1,
			2,
			3,
			4,
			5
		},
		before_story_id = {
			900601001
		},
		after_story_id = {
			900602001,
			900701001,
			900702001
		},
		hero_trial = {}
	},
	all = {
		81431,
		81432,
		81433,
		81434,
		81435,
		81436
	}
}
