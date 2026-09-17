return {
	template = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 794 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 866 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(540, 30)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 975 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = true,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = true,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 704 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 32)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(320, 31)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	},
	[2] = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 635 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 710 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(566, 688 + GameDisplay.fix_y * 2)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 820 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = false,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = false,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 610 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 0)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(566, 738 + GameDisplay.fix_y * 2)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	},
	[406] = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 635 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 710 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(566, 688 + GameDisplay.fix_y * 2)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 820 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = false,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = false,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 610 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 0)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(566, 738 + GameDisplay.fix_y * 2)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	},
	[486] = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 635 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 710 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(566, 688 + GameDisplay.fix_y * 2)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 820 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = false,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = false,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 610 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 0)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(566, 738 + GameDisplay.fix_y * 2)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	},
	[176] = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 635 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 710 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(566, 688 + GameDisplay.fix_y * 2)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 820 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = false,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = false,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 610 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 0)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(566, 738 + GameDisplay.fix_y * 2)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	},
	[710] = {
		img_bg = {
			zorder = 1,
			path = "bg.png",
			pos = cc.p(320, 568 + GameDisplay.fix_y)
		},
		img_reward_type = {
			zorder = 5,
			path = "reward_type.png",
			pos = cc.p(320, 635 + GameDisplay.fix_y * 2)
		},
		btn_buy_vip = {
			zorder = 4,
			path_off = "buy_btn_off.png",
			path = "buy_btn_normal.png",
			pos = cc.p(156, 710 + GameDisplay.fix_y * 2)
		},
		btn_all_gain = {
			zorder = 4,
			path_off = "all_get_off.png",
			path = "all_get_normal.png",
			pos = cc.p(566, 688 + GameDisplay.fix_y * 2)
		},
		img_title = {
			zorder = 3,
			path = "title.png",
			pos = cc.p(320, 820 + GameDisplay.fix_y * 2)
		},
		img_bottom = {
			zorder = 3,
			visible = false,
			path = "bottom_bg.png",
			pos = cc.p(320, 31)
		},
		btn_return = {
			zorder = 4,
			visible = false,
			path = "return_btn.png",
			pos = cc.p(62, 62)
		},
		tableview = {
			zorder = 2,
			size = cc.size(640, 610 + GameDisplay.fix_y * 2),
			pos = cc.p(0, 0)
		},
		btn_big_gift = {
			zorder = 4,
			path = "btn_big_gift.png",
			pos = cc.p(566, 738 + GameDisplay.fix_y * 2)
		},
		cell_clone = {
			zorder = 100,
			pos = cc.p(0, 0),
			size = cc.size(640, 124),
			child = {
				btn_bg = {
					zorder = 1,
					path = "cell_bg.png",
					anchorpoint = cc.p(0, 0),
					pos = cc.p(0, 0)
				},
				itemsmallsprite_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(240, 62)
				},
				itemsmallsprite_ext_award = {
					scale = 0.6,
					zorder = 2,
					pos = cc.p(420, 62)
				},
				text_name1 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 67),
					color = cc.c3b(255, 255, 255)
				},
				text_name2 = {
					fontsize = 22,
					zorder = 2,
					pos = cc.p(84, 45),
					color = cc.c3b(255, 255, 255)
				},
				btn_gain = {
					path = "get_award_normal.png",
					path_vip = "get_vip_award.png",
					path_free = "get_free_award.png",
					path_got = "got_award.png",
					path_off = "get_award_off.png",
					zorder = 211,
					pos = cc.p(568, 62)
				},
				img_lock = {
					zorder = 3,
					path = "lock_icon.png",
					pos = cc.p(390, 90)
				},
				img_normal_mask = {
					zorder = 4,
					path = "normal_mask.png",
					pos = cc.p(240, 62)
				},
				img_extra_mask = {
					zorder = 4,
					path = "extra_mask.png",
					pos = cc.p(420, 62)
				},
				img_all_mask = {
					zorder = 4,
					visible = true,
					path = "all_mask.png",
					pos = cc.p(260, 62)
				}
			}
		}
	}
}
