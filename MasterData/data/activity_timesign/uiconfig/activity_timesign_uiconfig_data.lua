return {
	debug = false,
	template = {
		img_bg = {
			zorder = 1,
			path = "img_bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		btn_return = {
			zorder = 4,
			path = "btn_return.png",
			pos = cc.p(594, 1084 + GameDisplay.fix_y)
		},
		tableview = {
			zorder = 2,
			size = cc.size(500, 800),
			pos = cc.p(80, 120 + GameDisplay.fix_y)
		},
		text_time = {
			fontsize = 20,
			zorder = 2,
			pos = cc.p(470, 940 + GameDisplay.fix_y),
			color = cc.c3b(189, 53, 53),
			font = FONT_NAME
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(10, 0),
			anchorpoint = cc.p(0, 0),
			size = cc.size(480, 370),
			child = {
				img_postcard = {
					zorder = 2,
					scale = 0.868,
					visible = true,
					path = "img_big_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(240, 185)
				},
				img_big_bottom = {
					opacity = 153,
					zorder = 1,
					visible = true,
					path = "img_big_bottom.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(240, 185)
				},
				img_big_mask = {
					will_path = "img_big_mask.png",
					zorder = 10,
					visible = true,
					path = "img_big_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(240, 185)
				},
				img_titletimebg = {
					zorder = 12,
					path = "img_titletimebg.png",
					pos = cc.p(92, 350)
				},
				text_lock = {
					fontsize = 30,
					zorder = 11,
					pos = cc.p(240, 185),
					color = cc.c3b(255, 255, 255)
				},
				text_titletime = {
					fontsize = 22,
					zorder = 13,
					pos = cc.p(92, 350),
					color = cc.c3b(255, 255, 255),
					font = FONT_NAME
				},
				btn_small_mask_1 = {
					zorder = 3,
					setSwallow = false,
					path = "btn_small_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(70, 185)
				},
				btn_small_mask_2 = {
					zorder = 3,
					setSwallow = false,
					path = "btn_small_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(183, 185)
				},
				btn_small_mask_3 = {
					zorder = 3,
					setSwallow = false,
					path = "btn_small_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(296, 185)
				},
				btn_small_mask_4 = {
					zorder = 3,
					setSwallow = false,
					path = "btn_small_mask.png",
					anchorpoint = cc.p(0.5, 0.5),
					pos = cc.p(409, 185)
				},
				itemsmallsprite_1 = {
					scale = 1,
					zorder = 4,
					pos = cc.p(70, 185)
				},
				itemsmallsprite_2 = {
					scale = 1,
					zorder = 4,
					pos = cc.p(183, 185)
				},
				itemsmallsprite_3 = {
					scale = 1,
					zorder = 4,
					pos = cc.p(296, 185)
				},
				itemsmallsprite_4 = {
					scale = 1,
					zorder = 4,
					pos = cc.p(409, 185)
				},
				text_effective_time_1 = {
					fontsize = 14,
					zorder = 6,
					pos = cc.p(70, 122),
					color = cc.c3b(255, 255, 255),
					font = FONT_NAME
				},
				text_effective_time_2 = {
					fontsize = 14,
					zorder = 6,
					pos = cc.p(183, 122),
					color = cc.c3b(255, 255, 255),
					font = FONT_NAME
				},
				text_effective_time_3 = {
					fontsize = 14,
					zorder = 6,
					pos = cc.p(296, 122),
					color = cc.c3b(255, 255, 255),
					font = FONT_NAME
				},
				text_effective_time_4 = {
					fontsize = 14,
					zorder = 6,
					pos = cc.p(409, 122),
					color = cc.c3b(255, 255, 255),
					font = FONT_NAME
				},
				img_effective_bg_1 = {
					zorder = 4,
					path = "img_timebg.png",
					pos = cc.p(70, 122)
				},
				img_effective_bg_2 = {
					zorder = 4,
					path = "img_timebg.png",
					pos = cc.p(183, 122)
				},
				img_effective_bg_3 = {
					zorder = 4,
					path = "img_timebg.png",
					pos = cc.p(296, 122)
				},
				img_effective_bg_4 = {
					zorder = 4,
					path = "img_timebg.png",
					pos = cc.p(409, 122)
				},
				img_tag_1 = {
					supplement_path = "img_tag_supplement.png",
					zorder = 10,
					get_path = "img_tag_get.png",
					path = "img_tag_get.png",
					pos = cc.p(88, 250)
				},
				img_tag_2 = {
					supplement_path = "img_tag_supplement.png",
					zorder = 10,
					get_path = "img_tag_get.png",
					path = "img_tag_get.png",
					pos = cc.p(201, 250)
				},
				img_tag_3 = {
					supplement_path = "img_tag_supplement.png",
					zorder = 10,
					get_path = "img_tag_get.png",
					path = "img_tag_get.png",
					pos = cc.p(314, 250)
				},
				img_tag_4 = {
					supplement_path = "img_tag_supplement.png",
					zorder = 10,
					get_path = "img_tag_get.png",
					path = "img_tag_get.png",
					pos = cc.p(427, 250)
				},
				img_item_mask_1 = {
					zorder = 11,
					path = "item_mask.png",
					pos = cc.p(70, 185)
				},
				img_item_mask_2 = {
					zorder = 11,
					path = "item_mask.png",
					pos = cc.p(183, 185)
				},
				img_item_mask_3 = {
					zorder = 11,
					path = "item_mask.png",
					pos = cc.p(296, 185)
				},
				img_item_mask_4 = {
					zorder = 11,
					path = "item_mask.png",
					pos = cc.p(409, 185)
				}
			}
		}
	}
}
