return {
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		pos = cc.p(320, 568)
	},
	btnDetail = {
		zorder = 21,
		path = "btn_detail.png",
		pos = cc.p(270, 1012 + GameDisplay.fix_y)
	},
	btnBp = {
		zorder = 35,
		path = "btn_bp.png",
		pos = cc.p(210, 142 - GameDisplay.fix_y),
		reddotpos = cc.p(240, 86)
	},
	btnReturn = {
		zorder = 31,
		path = "btn_return.png",
		pos = cc.p(92, 30 - GameDisplay.fix_y)
	},
	btnRecharge = {
		zorder = 38,
		path = "btn_recharge.png",
		pos = cc.p(166, 258 - GameDisplay.fix_y)
	},
	btnTwist = {
		zorder = 31,
		path = "btn_twist.png",
		pos = cc.p(486, 180 - GameDisplay.fix_y)
	},
	textFinishtime = {
		zorder = 41,
		str = "",
		size = 24,
		fontstr = "剩余时间：",
		pos = cc.p(156, 916 + GameDisplay.fix_y),
		color = cc.c3b(242, 232, 255),
		font = FONT_W5
	}
}
