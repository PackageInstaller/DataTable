return {
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		pos = cc.p(320, 568)
	},
	btnDetail = {
		zorder = 21,
		path = "btn_detail.png",
		pos = cc.p(296, 1030 + GameDisplay.fix_y * 0.45)
	},
	btnBp = {
		zorder = 35,
		path = "btn_bp.png",
		pos = cc.p(246, 152 - GameDisplay.fix_y),
		reddotpos = cc.p(200, 100)
	},
	btnReturn = {
		zorder = 31,
		path = "btn_return.png",
		pos = cc.p(78, 38 - GameDisplay.fix_y)
	},
	btnRecharge = {
		zorder = 38,
		path = "btn_recharge.png",
		pos = cc.p(160, 257 - GameDisplay.fix_y)
	},
	btnTwist = {
		zorder = 31,
		path = "btn_twist.png",
		pos = cc.p(460, 234 - GameDisplay.fix_y)
	},
	textFinishtime = {
		str = "",
		size = 22,
		zorder = 41,
		pos = cc.p(462, 918 + GameDisplay.fix_y * 0.45),
		color = cc.c3b(241, 234, 241),
		font = FONT_NAME
	}
}
