return {
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		pos = cc.p(320, 568)
	},
	imgTime = {
		zorder = 3,
		path = "img_time.png",
		pos = cc.p(97, 903 + GameDisplay.fix_y)
	},
	btnShare = {
		zorder = 31,
		path = "btn_share.png",
		pos = cc.p(62, 660 + GameDisplay.fix_y * 0.3),
		reddotpos = cc.p(75, 75)
	},
	btnSign = {
		zorder = 31,
		path = "btn_sign.png",
		pos = cc.p(62, 765 + GameDisplay.fix_y * 0.3),
		reddotpos = cc.p(75, 75)
	},
	btnDetail = {
		zorder = 21,
		path = "btn_detail.png",
		pos = cc.p(260, 994 + GameDisplay.fix_y)
	},
	btnLevel = {
		zorder = 31,
		path = "btn_level.png",
		pos = cc.p(164, 256 - GameDisplay.fix_y),
		reddotpos = cc.p(20, 75)
	},
	btnBp = {
		zorder = 35,
		path = "btn_bp.png",
		pos = cc.p(444, 88 - GameDisplay.fix_y),
		reddotpos = cc.p(300, 64)
	},
	btnShop = {
		zorder = 35,
		path = "btn_shop.png",
		pos = cc.p(135, 160 - GameDisplay.fix_y),
		reddotpos = cc.p(300, 64)
	},
	btnReturn = {
		zorder = 31,
		path = "btn_return.png",
		pos = cc.p(94, 54 - GameDisplay.fix_y)
	},
	btnTotalTask = {
		zorder = 31,
		action = "jump",
		path = "btn_total_task.png",
		pos = cc.p(478, 196 - GameDisplay.fix_y),
		reddotpos = cc.p(250, 68)
	},
	btnTwist = {
		zorder = 31,
		path_on = "btn_twist_on.png",
		path = "btn_twist.png",
		pos = cc.p(498, 370 - GameDisplay.fix_y),
		reddotpos = cc.p(210, 180)
	},
	btnExplore = {
		zorder = 31,
		path = "btn_explore.png",
		pos = cc.p(204, 356 - GameDisplay.fix_y),
		reddotpos = cc.p(240, 80)
	},
	btnRoleinfo = {
		zorder = 31,
		path = "btn_roleinfo.png",
		pos = cc.p(536, 666)
	},
	btnFalseLevelInfo = {
		zorder = 31,
		path = "btn_falselevelinfo.png",
		pos = cc.p(120, 850 + GameDisplay.fix_y),
		reddotpos = cc.p(200, 60)
	},
	showgirlLayer = {
		need_background = false,
		zorder = 3,
		pos = cc.p(0, 100)
	},
	textFinishtime = {
		str = "",
		size = 25,
		zorder = 41,
		pos = cc.p(100, 893 + GameDisplay.fix_y)
	},
	btnSeeMore = {
		zorder = 31,
		path = "btn_seemore.png",
		pos = cc.p(125, 460 - GameDisplay.fix_y)
	}
}
