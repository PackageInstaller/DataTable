value_list = {
	cell_mask = {
		zorder = 5,
		desc = "每天的大格子的遮罩",
		pos = {
			x = 265,
			y = 64
		},
		size = {
			width = 514,
			height = 128
		}
	},
	bg = {
		zorder = 1,
		desc = "背景",
		pos = {
			fix_y = 1,
			x = 320,
			y = 550
		}
	},
	sp = {
		desc = "每天的的每个奖励格子",
		pos = {
			x = 0,
			y = 0
		},
		size = {
			width = 530,
			height = 128
		}
	},
	cell = {
		desc = "每天的大格子",
		size = {
			width = 530,
			height = 128
		}
	},
	item_2 = {
		zorder = 3,
		scale = 1,
		desc = "奖励2",
		pos = {
			x = 255,
			y = 64
		}
	},
	sp_num_lab = {
		size = 18,
		desc = "每天的的每个奖励格子的奖励数量",
		color = {
			g = 255,
			b = 255,
			r = 255
		}
	},
	numimg = {
		zorder = 2,
		desc = "天数图片",
		pos = {
			x = 56,
			y = 64
		}
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
	title = {
		zorder = 2,
		desc = "标题",
		pos = {
			fix_y = 1,
			x = 320,
			y = 930
		}
	},
	sign_des = {
		zorder = 4,
		desc = "签到说明",
		pos = {
			x = 442,
			y = 24
		}
	},
	cellscrollview = {
		iscreate = false,
		zorder = 3,
		desc = "每天奖励是否需要滚动",
		pos = {
			x = 0,
			y = 0
		},
		size = {
			width = 530,
			height = 128
		},
		containersize = {
			width = 530,
			height = 128
		}
	},
	btn_sign = {
		zorder = 6,
		desc = "签到按钮",
		pos = {
			x = 460,
			y = 68
		}
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
		anchorpoint = {
			x = 1,
			y = 0.5
		}
	},
	tableView = {
		zorder = 3,
		desc = "下面的滚动容器",
		pos = {
			fix_y = 1,
			x = 55,
			y = 140
		},
		size = {
			width = 530,
			height = 614
		}
	},
	item_4 = {
		zorder = 3,
		scale = 1,
		desc = "奖励4",
		pos = {
			x = 461,
			y = 64
		}
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
		color = {
			g = 169,
			b = 255,
			r = 193
		},
		anchorpoint = {
			x = 1,
			y = 0.5
		}
	},
	item_1 = {
		zorder = 3,
		scale = 1,
		desc = "奖励1",
		pos = {
			x = 160,
			y = 64
		}
	},
	item_3 = {
		zorder = 3,
		scale = 1,
		desc = "奖励3",
		pos = {
			x = 358,
			y = 64
		}
	}
}

return value_list
