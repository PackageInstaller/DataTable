return {
	template = {
		bg = {
			zorder = 1,
			desc = "背景",
			pos = {
				fix_y = 1,
				x = 320,
				y = 568
			}
		},
		title = {
			zorder = 2,
			desc = "标题",
			pos = {
				fix_y = 1,
				x = 320,
				y = 878
			}
		},
		tableView = {
			zorder = 3,
			desc = "下面的滚动容器",
			pos = {
				fix_y = 1,
				x = 55,
				y = 164
			},
			size = cc.size(530, 614)
		},
		cell = {
			desc = "每天的大格子",
			size = cc.size(530, 128)
		},
		sp = {
			desc = "每天的的每个奖励格子",
			pos = cc.p(0, 0),
			size = cc.size(530, 128)
		},
		numimg = {
			zorder = 2,
			desc = "天数图片",
			pos = cc.p(56, 64)
		},
		item_1 = {
			zorder = 3,
			scale = 1,
			desc = "奖励1",
			pos = cc.p(152, 64)
		},
		item_2 = {
			zorder = 3,
			scale = 1,
			desc = "奖励2",
			pos = cc.p(255, 64)
		},
		item_3 = {
			zorder = 3,
			scale = 1,
			desc = "奖励3",
			pos = cc.p(358, 64)
		},
		item_4 = {
			zorder = 3,
			scale = 1,
			desc = "奖励4",
			pos = cc.p(461, 64)
		},
		btn_sign = {
			zorder = 6,
			desc = "签到按钮",
			pos = cc.p(460, 68)
		},
		cell_mask = {
			zorder = 5,
			desc = "每天的大格子的遮罩",
			pos = cc.p(265, 64),
			size = cc.size(514, 118)
		},
		label_time = {
			zorder = 10,
			fontsize = 18,
			visible = false,
			desc = "剩余时间",
			pos = {
				fix_y = 1,
				x = 360,
				y = 850
			},
			anchorpoint = cc.p(1, 0.5),
			color = cc.c3b(193, 169, 255)
		},
		time_bg = {
			zorder = 9,
			visible = false,
			desc = "剩余时间的背景",
			pos = {
				fix_y = 1,
				x = 360,
				y = 850
			},
			anchorpoint = cc.p(1, 0.5)
		},
		sign_des = {
			zorder = 4,
			desc = "签到说明",
			pos = cc.p(442, 24)
		},
		sp_bg = {
			blue = "public/box/sign_3.png",
			white = "public/box/sign_1.png",
			orange = "public/box/sign_5.png",
			red = "public/box/sign_6.png",
			green = "public/box/sign_2.png",
			purple = "public/box/sign_4.png",
			desc = "每天的的每个奖励格子的背景"
		},
		sp_num_lab = {
			size = 18,
			desc = "每天的的每个奖励格子的奖励数量",
			color = cc.c3b(255, 255, 255)
		},
		cellscrollview = {
			iscreate = false,
			zorder = 3,
			desc = "每天奖励是否需要滚动",
			pos = cc.p(0, 0),
			size = cc.size(530, 128),
			containersize = cc.size(530, 128)
		}
	},
	sign_123 = {
		label_time = {
			fontsize = 16,
			zorder = 10,
			pos = cc.p(435, 818 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(255, 255, 255)
		},
		time_bg = {
			visible = true,
			zorder = 9,
			pos = cc.p(435, 818 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5)
		}
	},
	sign_128 = {
		label_time = {
			fontsize = 18,
			zorder = 10,
			pos = cc.p(240, 844 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(83, 191, 200)
		},
		time_bg = {
			visible = true,
			zorder = 9,
			pos = cc.p(240, 844 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5)
		},
		sp_bg = {
			blue = "mainScenebg/activity/sign/sign_128/sign_3.png",
			orange = "mainScenebg/activity/sign/sign_128/sign_5.png",
			red = "mainScenebg/activity/sign/sign_128/sign_6.png",
			green = "mainScenebg/activity/sign/sign_128/sign_2.png",
			purple = "mainScenebg/activity/sign/sign_128/sign_4.png",
			white = "mainScenebg/activity/sign/sign_128/sign_1.png"
		},
		sp_num_lab = {
			size = 18,
			color = cc.c3b(51, 45, 29)
		}
	},
	sign_131 = {
		label_time = {
			fontsize = 18,
			zorder = 10,
			pos = cc.p(204, 844 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(56, 35, 102)
		},
		time_bg = {
			visible = true,
			zorder = 9,
			pos = cc.p(204, 844 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5)
		},
		sp_bg = {
			blue = "mainScenebg/activity/sign/sign_131/sign_3.png",
			orange = "mainScenebg/activity/sign/sign_131/sign_5.png",
			red = "mainScenebg/activity/sign/sign_131/sign_6.png",
			green = "mainScenebg/activity/sign/sign_131/sign_2.png",
			purple = "mainScenebg/activity/sign/sign_131/sign_4.png",
			white = "mainScenebg/activity/sign/sign_131/sign_1.png"
		},
		sp_num_lab = {
			size = 18,
			color = cc.c3b(51, 45, 29)
		},
		tableView = {
			cell_bottom_space = 100,
			zorder = 3,
			pos = cc.p(55, 200 + GameDisplay.fix_y),
			size = cc.size(530, 584)
		}
	},
	sign_132 = {
		tableView = {
			zorder = 3,
			pos = cc.p(55, 160 + GameDisplay.fix_y),
			size = cc.size(530, 610)
		},
		label_time = {
			fontsize = 16,
			visible = false,
			zorder = 10,
			pos = cc.p(490, 850 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(255, 255, 255)
		},
		time_bg = {
			visible = false,
			zorder = 9,
			pos = cc.p(370, 880 + GameDisplay.fix_y),
			anchorpoint = cc.p(1, 0.5)
		},
		sign_des = {
			visible = false,
			zorder = 4,
			pos = cc.p(442, 24)
		},
		cellscrollview = {
			zorder = 13,
			iscreate = true,
			pos = cc.p(120, 0),
			size = cc.size(280, 128),
			containersize = cc.size(400, 128)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(50, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(150, 64)
		},
		item_3 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(250, 64)
		},
		item_4 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(350, 64)
		},
		cell = {
			size = cc.size(530, 133)
		}
	},
	sign_142 = {
		tableView = {
			zorder = 3,
			pos = cc.p(55, 160 + GameDisplay.fix_y),
			size = cc.size(530, 610)
		},
		title = {
			zorder = 2,
			pos = cc.p(320, 870 + GameDisplay.fix_y)
		},
		label_time = {
			fontsize = 16,
			visible = false,
			zorder = 10,
			pos = cc.p(490, 850 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(255, 255, 255)
		},
		time_bg = {
			visible = false,
			zorder = 9,
			pos = cc.p(370, 880 + GameDisplay.fix_y),
			anchorpoint = cc.p(1, 0.5)
		},
		sign_des = {
			visible = false,
			zorder = 4,
			pos = cc.p(442, 24)
		},
		cellscrollview = {
			zorder = 13,
			iscreate = true,
			pos = cc.p(120, 0),
			size = cc.size(280, 128),
			containersize = cc.size(400, 128)
		},
		numimg = {
			zorder = 2,
			pos = cc.p(65, 64)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(50, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(150, 64)
		},
		item_3 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(250, 64)
		},
		item_4 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(350, 64)
		},
		cell = {
			size = cc.size(530, 133)
		}
	},
	sign_143 = {
		tableView = {
			zorder = 3,
			pos = cc.p(55, 160 + GameDisplay.fix_y),
			size = cc.size(530, 610)
		},
		title = {
			zorder = 2,
			pos = cc.p(320, 874 + GameDisplay.fix_y)
		},
		label_time = {
			fontsize = 16,
			visible = false,
			zorder = 10,
			pos = cc.p(490, 850 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(255, 255, 255)
		},
		time_bg = {
			visible = false,
			zorder = 9,
			pos = cc.p(370, 880 + GameDisplay.fix_y),
			anchorpoint = cc.p(1, 0.5)
		},
		sign_des = {
			visible = false,
			zorder = 4,
			pos = cc.p(442, 24)
		},
		cellscrollview = {
			zorder = 13,
			iscreate = true,
			pos = cc.p(120, 0),
			size = cc.size(280, 128),
			containersize = cc.size(400, 128)
		},
		numimg = {
			zorder = 2,
			pos = cc.p(65, 64)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(50, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(150, 64)
		},
		item_3 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(250, 64)
		},
		item_4 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(350, 64)
		},
		cell = {
			size = cc.size(530, 133)
		}
	},
	sign_137 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 960 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(55, 100 + GameDisplay.fix_y),
			size = cc.size(530, 700)
		},
		label_time = {
			fontsize = 16,
			visible = false,
			zorder = 10,
			pos = cc.p(490, 850 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5),
			color = cc.c3b(255, 255, 255)
		},
		time_bg = {
			visible = false,
			zorder = 9,
			pos = cc.p(370, 880 + GameDisplay.fix_y),
			anchorpoint = cc.p(1, 0.5)
		},
		sign_des = {
			visible = false,
			zorder = 4,
			pos = cc.p(442, 24)
		},
		cellscrollview = {
			zorder = 13,
			iscreate = true,
			pos = cc.p(120, 0),
			size = cc.size(280, 128),
			containersize = cc.size(400, 128)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(50, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(150, 64)
		},
		item_3 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(250, 64)
		},
		item_4 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(350, 64)
		},
		btn_sign = {
			zorder = 6,
			pos = cc.p(474, 68)
		},
		cell_mask = {
			zorder = 5,
			pos = cc.p(265, 64),
			size = cc.size(530, 118)
		},
		cell = {
			size = cc.size(530, 133)
		}
	},
	sign_145 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 878 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(55, 164 + GameDisplay.fix_y),
			size = cc.size(530, 614)
		}
	},
	sign_148 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 860 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(55, 152 + GameDisplay.fix_y),
			size = cc.size(530, 606)
		}
	},
	sign_151 = {
		tableView = {
			zorder = 3,
			pos = cc.p(55, 164 + GameDisplay.fix_y),
			size = cc.size(530, 614)
		},
		cell = {
			size = cc.size(530, 128)
		},
		sp = {
			pos = cc.p(0, 0),
			size = cc.size(530, 128)
		},
		numimg = {
			zorder = 2,
			pos = cc.p(56, 64)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(160, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(263, 64)
		},
		item_3 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(365, 64)
		},
		btn_sign = {
			zorder = 6,
			pos = cc.p(460, 68)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(462, 25)
		}
	},
	sign_152 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 878 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(55, 164 + GameDisplay.fix_y),
			size = cc.size(530, 614)
		},
		cell = {
			size = cc.size(530, 128)
		},
		sp = {
			pos = cc.p(0, 0),
			size = cc.size(530, 128)
		},
		numimg = {
			zorder = 2,
			pos = cc.p(75, 64)
		},
		item_1 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(199, 64)
		},
		item_2 = {
			scale = 1,
			zorder = 3,
			pos = cc.p(308, 64)
		},
		btn_sign = {
			zorder = 6,
			pos = cc.p(450, 68)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(454, 25)
		}
	},
	sign_154 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 920 + GameDisplay.fix_y)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_156 = {
		title = {
			zorder = 2,
			pos = cc.p(320, 920 + GameDisplay.fix_y)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_167 = {
		title = {
			zorder = 2,
			pos = cc.p(352, 944 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(62, 164 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_180 = {
		title = {
			zorder = 2,
			pos = cc.p(328, 980 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_182 = {
		title = {
			zorder = 2,
			pos = cc.p(324, 945 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_193 = {
		title = {
			zorder = 2,
			pos = cc.p(324, 945 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(400, 40)
		},
		btn_sign = {
			zorder = 6,
			pos = cc.p(430, 60)
		}
	},
	sign_186 = {
		title = {
			zorder = 2,
			pos = cc.p(324, 945 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(400, 40)
		},
		btn_sign = {
			zorder = 6,
			pos = cc.p(430, 60)
		}
	},
	sign_199 = {
		title = {
			zorder = 2,
			pos = cc.p(324, 945 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_195 = {
		title = {
			zorder = 2,
			pos = cc.p(328, 940 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 165 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_202 = {
		title = {
			zorder = 2,
			pos = cc.p(324, 945 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 171 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_207 = {
		title = {
			zorder = 2,
			pos = cc.p(328, 940 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 165 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	},
	sign_207 = {
		title = {
			zorder = 2,
			pos = cc.p(328, 940 + GameDisplay.fix_y)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(56, 165 + GameDisplay.fix_y),
			size = cc.size(530, 600)
		},
		sign_des = {
			zorder = 4,
			pos = cc.p(468, 25)
		}
	}
}
