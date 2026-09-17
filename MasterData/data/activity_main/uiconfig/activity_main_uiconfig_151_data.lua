return {
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		pos = cc.p(320, 568)
	},
	btnSign = {
		zorder = 31,
		path = "btn_sign.png",
		pos = cc.p(56, 828 + GameDisplay.fix_y),
		reddotpos = cc.p(80, 80)
	},
	btnTwist = {
		zorder = 31,
		path = "btn_twist.png",
		pos = cc.p(568, 262 - GameDisplay.fix_y * 3 / 3),
		reddotpos = cc.p(120, 120)
	},
	btnBp = {
		zorder = 31,
		path = "btn_bp.png",
		pos = cc.p(470, 116 - GameDisplay.fix_y * 3 / 3),
		reddotpos = cc.p(120, 120)
	},
	btnRandfight = {
		zorder = 31,
		path = "btn_randfight.png",
		pos = cc.p(70, 210 - GameDisplay.fix_y),
		reddotpos = cc.p(84, 84)
	},
	btnLevel = {
		zorder = 31,
		path = "btn_level.png",
		pos = cc.p(68, 344 - GameDisplay.fix_y),
		reddotpos = cc.p(84, 84)
	},
	btnReturn = {
		zorder = 31,
		path = "btn_return.png",
		pos = cc.p(120, 56 - GameDisplay.fix_y)
	},
	btnDetail = {
		zorder = 31,
		path = "btn_detail.png",
		pos = cc.p(320, 1054 + GameDisplay.fix_y)
	},
	btnRole = {
		zorder = 2,
		path_on = "btn_role.png",
		path = "btn_role.png",
		pos = cc.p(320, 430 + GameDisplay.fix_y / 2)
	},
	btnTotalTask = {
		zorder = 31,
		action = "jump",
		path = "btn_total_task.png",
		pos = cc.p(590, 430 - GameDisplay.fix_y * 3 / 3),
		reddotpos = cc.p(80, 180)
	},
	btnRecharge = {
		zorder = 31,
		path = "btn_recharge.png",
		pos = cc.p(414, 260 - GameDisplay.fix_y * 3 / 3)
	},
	btnGetRole = {
		zorder = 31,
		visible = false,
		path = "btn_getrole.png",
		pos = cc.p(235, 580 + GameDisplay.fix_y)
	},
	imgTop = {
		zorder = 2,
		path = "img_top.png",
		pos = cc.p(320, 1136 + GameDisplay.fix_y),
		anchorpoint = cc.p(0.5, 1)
	},
	imgBottom = {
		zorder = 2,
		path = "img_bottom.png",
		pos = cc.p(320, 0 - GameDisplay.fix_y),
		anchorpoint = cc.p(0.5, 0)
	},
	textFinishtime = {
		str = "",
		size = 24,
		zorder = 41,
		pos = cc.p(320, 950 + GameDisplay.fix_y)
	},
	particle1 = {
		zorder = 11,
		path = "effect/particle/christmas_snow.plist"
	}
}
