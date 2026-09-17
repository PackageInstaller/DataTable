local var_0_0 = {}

var_0_0.debug = true
var_0_0.template = {
	cell_row_space = 10,
	default_usemodule = "total_recharge",
	item_bg_path = "public/box/box_activity_recharge_",
	Image_bg = {
		desc = "背景图片",
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		desc = "前往完成按钮",
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		desc = "前往完成按钮下的进度提示文字",
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		desc = "剩余时间文字",
		pos = cc.p(50, 790),
		color = cc.c3b(255, 255, 255)
	},
	Label_des = {
		visible = true,
		desc = "说明文字",
		pos = cc.p(-290, 232),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		desc = "说明文字1",
		pos = cc.p(16, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_2 = {
		fontsize = 20,
		visible = true,
		desc = "说明文字2",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_3 = {
		fontsize = 20,
		visible = true,
		desc = "说明文字3",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_4 = {
		fontsize = 20,
		visible = true,
		desc = "说明文字4",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_5 = {
		fontsize = 20,
		visible = true,
		desc = "说明文字5",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow = {
		visible = false,
		desc = "说明文字(黑)",
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Label_desshadow_1 = {
		fontsize = 20,
		visible = false,
		desc = "说明文字(黑)1",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow_2 = {
		fontsize = 20,
		visible = false,
		desc = "说明文字(黑)2",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow_3 = {
		fontsize = 20,
		visible = false,
		desc = "说明文字(黑)3",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow_4 = {
		fontsize = 20,
		visible = false,
		desc = "说明文字(黑)4",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow_5 = {
		fontsize = 20,
		visible = false,
		desc = "说明文字(黑)5",
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Panel_scrollarena = {
		desc = "滑动区域",
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		desc = "装饰",
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		desc = "详细信息按钮",
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = false,
		desc = "显示皮肤点击区域",
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_taskinfo = {
		visible = true,
		desc = "任务进度详情按钮",
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Panel_cell = {
		desc = "每个滑动单位",
		size = cc.size(590, 136)
	},
	Button_cell = {
		desc = "无用1",
		pos = cc.p(365, 68)
	},
	Image_mark = {
		path = "mark",
		visible = false,
		path_on = "mark_on",
		desc = "领取后遮罩",
		pos = cc.p(20, 68)
	},
	Image_condition = {
		desc = "箭头图片",
		pos = cc.p(81, 68)
	},
	cellscrollview = {
		desc = "掉落尾品的滚动层",
		pos = cc.p(170, 16),
		size = cc.size(280, 120),
		containersize = cc.size(340, 100)
	},
	Panel_item1 = {
		desc = "掉落1",
		pos = cc.p(0, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		desc = "掉落2",
		pos = cc.p(90, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		desc = "掉落3",
		pos = cc.p(180, 0),
		size = cc.size(87, 100)
	},
	Panel_item4 = {
		desc = "掉落4",
		pos = cc.p(360, 0),
		size = cc.size(87, 100)
	},
	Panel_item5 = {
		desc = "掉落5",
		pos = cc.p(480, 0),
		size = cc.size(87, 100)
	},
	Panel_item6 = {
		desc = "掉落6",
		pos = cc.p(600, 0),
		size = cc.size(87, 100)
	},
	Button_award = {
		desc = "领取奖励按钮",
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		desc = "多少次文字",
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		desc = "多少次文字(次)",
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		desc = "进度条背景",
		pos = cc.p(16, 68)
	},
	Image_progress = {
		desc = "进度条背景",
		pos = cc.p(16, 68)
	},
	Image_cell_mask = {
		desc = "掉落物品遮罩",
		pos = cc.p(381, 68)
	},
	Button_module_group_1 = {
		desc = "切换模组按钮1",
		pos = cc.p(200, 0)
	},
	Button_module_group_2 = {
		desc = "切换模组按钮2",
		pos = cc.p(400, 0)
	},
	Button_module_group_3 = {
		desc = "切换模组按钮3",
		pos = cc.p(380, 1030)
	},
	Button_module_group_4 = {
		desc = "切换模组按钮4",
		pos = cc.p(380, 1030)
	},
	Button_module_group_5 = {
		desc = "切换模组按钮5",
		pos = cc.p(530, 820)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		desc = "切换模组按钮红点1",
		pos = cc.p(0, 0)
	},
	Button_module_group_2_reddot = {
		path = "public/reddotr/eddot2.png",
		desc = "切换模组按钮红点1",
		pos = cc.p(0, 0)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		desc = "切换模组按钮红点1",
		pos = cc.p(370, 1054)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		desc = "切换模组按钮红点1",
		pos = cc.p(450, 1054)
	},
	Button_module_group_5_reddot = {
		path = "public/reddot/reddot2.png",
		desc = "切换模组按钮红点1",
		pos = cc.p(450, 1054)
	}
}
var_0_0[128] = {
	Button_sure = {
		visible = true,
		pos = cc.p(320, 90)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, 80),
		color = cc.c3b(0, 0, 0)
	},
	Label_time = {
		visible = true,
		pos = cc.p(30, 934),
		color = cc.c3b(255, 255, 255)
	},
	Label_des = {
		visible = true,
		pos = cc.p(30, 832),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = true,
		pos = cc.p(32, 830),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 144),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = true,
		pos = cc.p(56, 124)
	},
	Button_cell = {
		pos = cc.p(381, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Panel_item1 = {
		pos = cc.p(209, 18),
		size = cc.size(87, 92)
	},
	Panel_item2 = {
		pos = cc.p(319, 18),
		size = cc.size(87, 92)
	},
	Button_award = {
		pos = cc.p(515, 68)
	},
	Label_scoredes = {},
	Label_score = {
		pos = cc.p(110, 46),
		color = cc.c3b(255, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(32, 60)
	},
	Image_progress = {
		pos = cc.p(32, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	Button_module_group_1 = {
		pos = cc.p(180, 1030)
	},
	Button_module_group_2 = {
		pos = cc.p(460, 1030)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(270, 1054)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(550, 1054)
	},
	module_group = {
		{
			key = "total_recharge"
		},
		{
			key = "total_twist"
		}
	}
}
var_0_0[132] = {
	default_usemodule = "total_twist_huoyu",
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 790),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(50, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_2 = {
		visible = true,
		pos = cc.p(50, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_3 = {
		visible = true,
		pos = cc.p(50, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_4 = {
		visible = true,
		pos = cc.p(50, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_5 = {
		visible = true,
		pos = cc.p(50, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(381, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(515, 68)
	},
	Label_scoredes = {},
	Label_score = {
		pos = cc.p(110, 46),
		color = cc.c3b(255, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(24, 60)
	},
	Image_progress = {
		pos = cc.p(24, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	Button_module_group_1 = {
		pos = cc.p(80, 870)
	},
	Button_module_group_2 = {
		pos = cc.p(240, 870)
	},
	Button_module_group_3 = {
		pos = cc.p(400, 870)
	},
	Button_module_group_4 = {
		pos = cc.p(560, 870)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(136, 886)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(296, 886)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(456, 886)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(616, 886)
	},
	module_group = {
		{
			previewitemid = 64101255,
			key = "total_twist_huoyu"
		},
		{
			previewitemid = 6418855,
			key = "total_twist_meiluodi"
		},
		{
			previewitemid = 6418720,
			key = "total_recharge"
		},
		{
			key = "total_consume_diamond"
		}
	}
}
var_0_0[137] = {
	default_usemodule = "total_recharge",
	Label_score_BMfont = "fonts/umr_package_number.fnt",
	Label_score_des_BMfont = "fonts/umr_package_number.fnt",
	item_bg_path = "public/box/box_umaru_recharge_",
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		font_size = 26,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67),
		font = FONT_BUTTON
	},
	Label_time = {
		visible = false,
		pos = cc.p(50, 750),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		fontsize = 16,
		pos = cc.p(40, 740),
		size = cc.size(200, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_2 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 740),
		size = cc.size(300, 526),
		color = cc.c3b(79, 58, 133)
	},
	Label_des_3 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 740),
		size = cc.size(300, 526),
		color = cc.c3b(79, 58, 133)
	},
	Label_des_4 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 740),
		size = cc.size(300, 526),
		color = cc.c3b(79, 58, 133)
	},
	Label_des_5 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 740),
		size = cc.size(300, 526),
		color = cc.c3b(79, 58, 133)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(42, 738),
		size = cc.size(300, 526),
		color = cc.c3b(0, 0, 0)
	},
	Panel_scrollarena = {
		pos = cc.p(15, 45),
		size = cc.size(590, 515),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = false,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(381, 68)
	},
	Image_condition = {
		pos = cc.p(92, 78)
	},
	cellscrollview = {
		pos = cc.p(190, 16),
		size = cc.size(260, 120),
		containersize = cc.size(460, 100)
	},
	Button_award = {
		pos = cc.p(515, 68)
	},
	Label_scoredes = {
		pos = cc.p(100, 40)
	},
	Label_score = {
		pos = cc.p(100, 30),
		color = cc.c3b(255, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(24, 60)
	},
	Image_progress = {
		pos = cc.p(24, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	Button_module_group_1 = {
		pos = cc.p(120, 900)
	},
	Button_module_group_2 = {
		pos = cc.p(350, 905)
	},
	Button_module_group_3 = {
		pos = cc.p(530, 905)
	},
	Button_module_group_4 = {
		pos = cc.p(350, 850)
	},
	Button_module_group_5 = {
		pos = cc.p(530, 850)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(225, 920)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(430, 920)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 920)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(430, 870)
	},
	Button_module_group_5_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 870)
	},
	module_group = {
		{
			key = "total_recharge"
		},
		{
			key = "total_twist_umaru"
		},
		{
			key = "total_twist_shirufin"
		},
		{
			key = "total_twist_nanami"
		},
		{
			key = "total_twist_kirie"
		}
	},
	cell_bg_path = {
		{
			path = "cell_recharge_bg"
		}
	},
	cell_bg_special_path = {
		{
			path = "cell_recharge_special_bg"
		}
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[148] = {
	Image_bg = {
		pos = cc.p(320, 620),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		font_size = 26,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67),
		font = FONT_BUTTON
	},
	Label_time = {
		visible = false,
		pos = cc.p(50, 750),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_2 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_3 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_4 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_5 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(42, 838),
		size = cc.size(300, 526),
		color = cc.c3b(0, 0, 0)
	},
	Label_desshadow_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(52, 96, 159)
	},
	Label_desshadow_2 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(52, 96, 159)
	},
	Label_desshadow_3 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(52, 96, 159)
	},
	Label_desshadow_4 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow_5 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Panel_scrollarena = {
		pos = cc.p(15, 45),
		size = cc.size(590, 515),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = false,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_taskinfo = {
		visible = true,
		pos = cc.p(580, 874)
	},
	Button_cell = {
		pos = cc.p(320, 68)
	},
	Image_mark = {
		visible = true,
		path_on = "mark_on",
		path = "mark",
		pos = cc.p(24, 68)
	},
	Image_condition = {
		visible = false,
		pos = cc.p(24, 68)
	},
	cellscrollview = {
		pos = cc.p(210, 16),
		size = cc.size(260, 120),
		containersize = cc.size(460, 100)
	},
	Button_award = {
		pos = cc.p(515, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(120, 78),
		color = cc.c3b(255, 255, 255),
		color_got = cc.c3b(81, 100, 207)
	},
	Label_score = {
		font_size = 32,
		pos = cc.p(120, 40),
		color = cc.c3b(180, 251, 255)
	},
	Image_progress_bg = {
		pos = cc.p(24, 68)
	},
	Image_progress = {
		pos = cc.p(24, 68)
	},
	Image_cell_mask = {
		visible = false,
		pos = cc.p(381, 68)
	},
	Panel_item1 = {
		pos = cc.p(20, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(140, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(250, 0),
		size = cc.size(87, 100)
	},
	Button_award = {
		pos = cc.p(520, 70)
	},
	Button_module_group_1 = {
		pos = cc.p(120, 980)
	},
	Button_module_group_2 = {
		pos = cc.p(320, 980)
	},
	Button_module_group_3 = {
		pos = cc.p(520, 980)
	},
	Button_module_group_4 = {
		pos = cc.p(350, 980)
	},
	Button_module_group_5 = {
		pos = cc.p(530, 980)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(205, 1000)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(410, 1000)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(430, 1000)
	},
	Button_module_group_5_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	cell_bg_special_index = {
		{
			10
		}
	},
	Image_item_got_mask = {
		path = "item_got_mask"
	}
}
var_0_0[151] = {
	Image_bg = {
		pos = cc.p(320, 620),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		font_size = 26,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67),
		font = FONT_BUTTON
	},
	Label_time = {
		visible = false,
		pos = cc.p(50, 750),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_2 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_3 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_4 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_des_5 = {
		visible = true,
		fontsize = 20,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 246, 218)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(42, 838),
		size = cc.size(300, 526),
		color = cc.c3b(0, 0, 0)
	},
	Panel_scrollarena = {
		pos = cc.p(15, 45),
		size = cc.size(590, 515),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = false,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(320, 68)
	},
	Image_mark = {
		visible = true,
		path_on = "mark_on",
		path = "mark",
		pos = cc.p(24, 68)
	},
	Image_condition = {
		visible = false,
		pos = cc.p(24, 68)
	},
	cellscrollview = {
		pos = cc.p(190, 16),
		size = cc.size(260, 120),
		containersize = cc.size(460, 100)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(120, 78),
		color = cc.c3b(255, 255, 255),
		color_got = cc.c3b(81, 100, 207)
	},
	Label_score = {
		font_size = 32,
		pos = cc.p(120, 40),
		color = cc.c3b(180, 251, 255)
	},
	Image_progress_bg = {
		pos = cc.p(24, 68)
	},
	Image_progress = {
		pos = cc.p(24, 68)
	},
	Image_cell_mask = {
		visible = false,
		pos = cc.p(381, 68)
	},
	Panel_item1 = {
		pos = cc.p(40, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(160, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(270, 0),
		size = cc.size(87, 100)
	},
	Button_award = {
		pos = cc.p(520, 70)
	},
	Button_module_group_1 = {
		pos = cc.p(120, 980)
	},
	Button_module_group_2 = {
		pos = cc.p(320, 980)
	},
	Button_module_group_3 = {
		pos = cc.p(520, 980)
	},
	Button_module_group_4 = {
		pos = cc.p(350, 980)
	},
	Button_module_group_5 = {
		pos = cc.p(530, 980)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(205, 1000)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(410, 1000)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(430, 1000)
	},
	Button_module_group_5_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	Button_award_bg = {},
	cell_bg_special_index = {
		{
			10
		}
	},
	Image_item_got_mask = {
		path = "item_got_mask"
	}
}
var_0_0[154] = {
	Image_bg = {
		pos = cc.p(320, 620),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		font_size = 26,
		pos = cc.p(320, -50),
		color = cc.c3b(255, 210, 67),
		font = FONT_BUTTON
	},
	Label_time = {
		visible = false,
		pos = cc.p(50, 750),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_2 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_3 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_4 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_5 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(40, 810),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(42, 838),
		size = cc.size(300, 526),
		color = cc.c3b(0, 0, 0)
	},
	Label_desshadow_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Label_desshadow_2 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Label_desshadow_3 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Label_desshadow_4 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Label_desshadow_5 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Panel_scrollarena = {
		pos = cc.p(15, 45),
		size = cc.size(590, 515),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = false,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_taskinfo = {
		visible = true,
		pos = cc.p(580, 874)
	},
	Button_cell = {
		pos = cc.p(320, 68)
	},
	Image_mark = {
		visible = true,
		path_on = "mark_on",
		path = "mark",
		pos = cc.p(24, 68)
	},
	Image_condition = {
		visible = false,
		pos = cc.p(24, 68)
	},
	cellscrollview = {
		pos = cc.p(180, 16),
		size = cc.size(260, 120),
		containersize = cc.size(260, 120)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(105, 100),
		color = cc.c3b(191, 67, 67),
		color_get = cc.c3b(255, 97, 97),
		color_got = cc.c3b(191, 67, 67)
	},
	Label_score = {
		font_size = 34,
		pos = cc.p(105, 45),
		color = cc.c3b(171, 56, 56),
		color_get = cc.c3b(255, 217, 136),
		color_got = cc.c3b(171, 56, 56)
	},
	Image_progress_bg = {
		pos = cc.p(24, 68)
	},
	Image_progress = {
		pos = cc.p(24, 68)
	},
	Image_cell_mask = {
		visible = true,
		pos = cc.p(320, 68)
	},
	Panel_item1 = {
		pos = cc.p(10, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(115, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(220, 0),
		size = cc.size(87, 100)
	},
	Button_award = {
		pos = cc.p(500, 70)
	},
	Button_module_group_1 = {
		pos = cc.p(120, 980)
	},
	Button_module_group_2 = {
		pos = cc.p(320, 980)
	},
	Button_module_group_3 = {
		pos = cc.p(520, 980)
	},
	Button_module_group_4 = {
		pos = cc.p(350, 980)
	},
	Button_module_group_5 = {
		pos = cc.p(530, 980)
	},
	Button_module_group_1_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(205, 1000)
	},
	Button_module_group_2_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(410, 1000)
	},
	Button_module_group_3_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	Button_module_group_4_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(430, 1000)
	},
	Button_module_group_5_reddot = {
		path = "public/reddot/reddot2.png",
		pos = cc.p(610, 1000)
	},
	cell_bg_special_index = {
		{
			10
		}
	},
	Image_item_got_mask = {
		visible = false,
		path = "item_got_mask"
	}
}
var_0_0[170] = {
	Image_bg = {
		pos = cc.p(320, 620),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		font_size = 22,
		pos = cc.p(320, -90),
		color = cc.c3b(255, 255, 255),
		font = FONT_BUTTON
	},
	Label_time = {
		visible = false,
		pos = cc.p(50, 750),
		color = cc.c3b(255, 255, 255)
	},
	Label_time = {
		fontsize = 22,
		visible = true,
		pos = cc.p(34, 776),
		color = cc.c3b(255, 244, 92)
	},
	Label_des_1 = {
		visible = true,
		fontsize = 22,
		pos = cc.p(34, 754),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(42, 838),
		size = cc.size(300, 526),
		color = cc.c3b(0, 0, 0)
	},
	Label_desshadow_1 = {
		visible = false,
		fontsize = 22,
		pos = cc.p(42, 808),
		size = cc.size(300, 526),
		color = cc.c3b(60, 12, 12)
	},
	Panel_scrollarena = {
		pos = cc.p(15, 45),
		size = cc.size(590, 515),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = false,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(320, 600),
		size = cc.size(320, 200)
	},
	Button_taskinfo = {
		visible = true,
		pos = cc.p(580, 874)
	},
	Button_cell = {
		pos = cc.p(320, 68)
	},
	Image_mark = {
		visible = true,
		path_on = "mark_on",
		path = "mark",
		pos = cc.p(24, 68)
	},
	Image_condition = {
		visible = false,
		pos = cc.p(24, 68)
	},
	cellscrollview = {
		pos = cc.p(220, 16),
		size = cc.size(260, 120),
		containersize = cc.size(260, 120)
	},
	Label_scoredes = {
		font_size = 24,
		visible = false,
		pos = cc.p(105, 100),
		color = cc.c3b(191, 67, 67),
		color_get = cc.c3b(255, 97, 97),
		color_got = cc.c3b(191, 67, 67)
	},
	Label_score = {
		font_size = 36,
		pos = cc.p(130, 45),
		color = cc.c3b(184, 201, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Image_progress_bg = {
		pos = cc.p(24, 68)
	},
	Image_progress = {
		pos = cc.p(24, 68)
	},
	Image_cell_mask = {
		visible = true,
		pos = cc.p(320, 68)
	},
	Panel_item1 = {
		pos = cc.p(10, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(115, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(220, 0),
		size = cc.size(87, 100)
	},
	Button_award = {
		pos = cc.p(500, 70)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[171] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 790),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(16, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(365, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[173] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 790),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(16, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(365, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	cellscrollview = {
		pos = cc.p(170, 16),
		size = cc.size(280, 120),
		containersize = cc.size(340, 100)
	},
	Panel_item1 = {
		pos = cc.p(0, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(90, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(180, 0),
		size = cc.size(87, 100)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[177] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 790),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(16, 680),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(365, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[180] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 760),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 730),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(365, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[182] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -70),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(50, 760),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 730),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[190] = {
	Button_sure = {
		visible = true,
		pos = cc.p(320, 90)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, 80),
		color = cc.c3b(0, 0, 0)
	},
	Label_time = {
		visible = true,
		pos = cc.p(30, 934),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(50, 832),
		size = cc.size(300, 526),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow_1 = {
		visible = true,
		pos = cc.p(52, 830),
		size = cc.size(300, 526),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 144),
		size = cc.size(590, 526),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = true,
		pos = cc.p(56, 124)
	},
	Button_cell = {
		pos = cc.p(381, 68)
	},
	Panel_item1 = {
		pos = cc.p(20, 0),
		size = cc.size(87, 100)
	},
	Panel_item2 = {
		pos = cc.p(140, 0),
		size = cc.size(87, 100)
	},
	Panel_item3 = {
		pos = cc.p(250, 0),
		size = cc.size(87, 100)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(515, 68)
	},
	Label_score = {
		pos = cc.p(110, 46),
		color = cc.c3b(255, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(32, 68)
	},
	Image_progress = {
		pos = cc.p(32, 68)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	}
}
var_0_0[195] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -100),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(25, 776),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 690),
		size = cc.size(300, 556),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 556),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 556),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[199] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -20),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(25, 776),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 690),
		size = cc.size(300, 556),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 556),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 556),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[207] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -100),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(25, 776),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 690),
		size = cc.size(300, 556),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 556),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 556),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[225] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -100),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(25, 776),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 690),
		size = cc.size(300, 556),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 556),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 556),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}
var_0_0[220] = {
	Image_bg = {
		pos = cc.p(320, 640),
		anchorpoint = cc.p(0.5, 0.5)
	},
	Button_sure = {
		visible = true,
		pos = cc.p(320, -50)
	},
	Label_totalrecharge = {
		visible = true,
		pos = cc.p(320, -100),
		color = cc.c3b(255, 210, 67)
	},
	Label_time = {
		visible = true,
		pos = cc.p(25, 776),
		color = cc.c3b(255, 255, 255)
	},
	Label_des_1 = {
		visible = true,
		pos = cc.p(26, 690),
		size = cc.size(300, 556),
		color = cc.c3b(255, 255, 255)
	},
	Label_desshadow = {
		visible = false,
		pos = cc.p(32, 698),
		size = cc.size(300, 556),
		color = cc.c3b(19, 83, 133)
	},
	Panel_scrollarena = {
		pos = cc.p(25, 10),
		size = cc.size(590, 556),
		anchorpoint = cc.p(0, 0)
	},
	Image_ornament = {
		visible = false,
		pos = cc.p(56, 124)
	},
	Image_magnifier = {
		visible = true,
		pos = cc.p(600, 780)
	},
	item_touch_panel = {
		visible = true,
		pos = cc.p(360, 600),
		size = cc.size(320, 200)
	},
	Button_cell = {
		pos = cc.p(345, 68)
	},
	Image_condition = {
		pos = cc.p(81, 68)
	},
	Button_award = {
		pos = cc.p(506, 68)
	},
	Label_scoredes = {
		font_size = 24,
		pos = cc.p(200, 45),
		color = cc.c3b(255, 255, 255),
		color_get = cc.c3b(255, 255, 255),
		color_got = cc.c3b(255, 255, 255)
	},
	Label_score = {
		font_size = 22,
		pos = cc.p(100, 45),
		color = cc.c3b(255, 245, 114),
		color_get = cc.c3b(255, 245, 114),
		color_got = cc.c3b(171, 245, 114)
	},
	Image_progress_bg = {
		pos = cc.p(16, 60)
	},
	Image_progress = {
		pos = cc.p(16, 60)
	},
	Image_cell_mask = {
		pos = cc.p(381, 68)
	},
	cell_bg_special_index = {
		{
			10
		}
	}
}

return var_0_0
