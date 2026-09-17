return {
	template = {
		cell_row_space = 10,
		bg = {
			zorder = 1,
			pos = cc.p(320, 568 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5)
		},
		btn_close = {
			zorder = 2,
			pos = cc.p(600, 1100 + GameDisplay.fix_y),
			anchorpoint = cc.p(0.5, 0.5)
		},
		text_task_name = {
			zorder = 4,
			font_size = 24,
			pos = cc.p(170, 110),
			anchorpoint = cc.p(0, 1),
			font_name = FONT_DES,
			color = cc.c3b(44, 82, 133)
		},
		text_task_des = {
			font_size = 18,
			zorder = 4,
			pos = cc.p(170, 70),
			anchorpoint = cc.p(0, 1),
			textareasize = cc.size(240, 100),
			font_name = FONT_DES,
			color = cc.c3b(44, 82, 133)
		},
		tableView = {
			zorder = 3,
			pos = cc.p(55, 100 + GameDisplay.fix_y),
			size = cc.size(530, 620)
		},
		cell = {
			pos = cc.p(0, 0),
			anchorpoint = cc.p(0, 0),
			size = cc.size(530, 128)
		},
		item_sp = {
			scale = 0.6,
			zorder = 4,
			pos = cc.p(94, 70)
		},
		btn_get_award = {
			zorder = 4,
			pos = cc.p(460, 68)
		},
		cell_mask = {
			zorder = 5,
			pos = cc.p(265, 64),
			size = cc.size(514, 118)
		}
	}
}
