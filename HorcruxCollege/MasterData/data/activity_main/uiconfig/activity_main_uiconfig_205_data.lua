return {
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		pos = cc.p(320, 568)
	},
	textFinishtime = {
		widget = "up",
		str = "",
		size = 24,
		zorder = 41,
		pos = cc.p(100, 975 - GameDisplay.fix_y),
		color = cc.c3b(255, 255, 255)
	},
	textFinishtime1 = {
		widget = "up",
		str = "",
		size = 24,
		zorder = 41,
		pos = cc.p(102, 975 - GameDisplay.fix_y),
		color = cc.c3b(14, 133, 140)
	},
	imgTitle = {
		zorder = 2,
		widget = "up",
		path = "title.png",
		pos = cc.p(10, 820 - GameDisplay.fix_y),
		anchorpoint = cc.p(0, 0)
	},
	btnLevel1 = {
		zorder = 32,
		locktime = "2021-09-15 00:00:00",
		open_reddot = "once",
		path = "btn_level.png",
		pos = cc.p(140, 850 - GameDisplay.fix_y),
		reddotpos = cc.p(250, 250)
	},
	btnRecharge = {
		zorder = 31,
		path = "btn_recharge.png",
		pos = cc.p(515, 240 - GameDisplay.fix_y)
	},
	btnShop = {
		zorder = 35,
		path = "btn_shop.png",
		pos = cc.p(520, 80 - GameDisplay.fix_y)
	},
	btnReturn = {
		zorder = 31,
		path = "btn_return.png",
		pos = cc.p(120, 74 - GameDisplay.fix_y)
	},
	btnQuestion1 = {
		arrayid = 1,
		zorder = 31,
		locktime = "2021-09-05 00:00:00",
		open_reddot = "once",
		title = "语文考试",
		path = "btn_question1.png",
		pos = cc.p(160, 625 - GameDisplay.fix_y),
		reddotpos = cc.p(295, 65)
	},
	btnQuestion2 = {
		arrayid = 2,
		zorder = 31,
		locktime = "2021-09-08 00:00:00",
		open_reddot = "once",
		title = "数学考试",
		path = "btn_question2.png",
		pos = cc.p(200, 540 - GameDisplay.fix_y),
		reddotpos = cc.p(295, 65)
	},
	btnQuestion3 = {
		arrayid = 3,
		zorder = 31,
		locktime = "2021-09-11 00:00:00",
		open_reddot = "once",
		title = "外语考试",
		path = "btn_question3.png",
		pos = cc.p(170, 460 - GameDisplay.fix_y),
		reddotpos = cc.p(295, 65)
	},
	btnQuestion4 = {
		arrayid = 4,
		zorder = 31,
		locktime = "2021-09-14 00:00:00",
		open_reddot = "once",
		title = "科学考试",
		path = "btn_question4.png",
		pos = cc.p(205, 370 - GameDisplay.fix_y),
		reddotpos = cc.p(295, 65)
	}
}
