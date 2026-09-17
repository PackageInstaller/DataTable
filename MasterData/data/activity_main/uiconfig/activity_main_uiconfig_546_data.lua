value_list = {
	btnSwim = {
		zorder = 3,
		path = "btn_swim.png",
		desc = "游泳",
		pos = {
			{
				x = 160,
				y = 400
			},
			[2] = -1
		}
	},
	textFinishtime = {
		fontstr = "剩余时间：",
		font = "fonts/W5.ttf",
		zorder = 41,
		str = "",
		size = 30,
		desc = "结束时间",
		pos = {
			{
				x = 320,
				y = 880
			},
			[2] = 1
		},
		color = {
			g = 232,
			b = 255,
			r = 242
		}
	},
	imgBg = {
		zorder = 1,
		path = "img_bg.png",
		desc = "背景",
		pos = {
			{
				x = 320,
				y = 680
			},
			[2] = -1
		}
	},
	btnDetail = {
		zorder = 2,
		path = "btn_detail.png",
		desc = "标题",
		pos = {
			{
				x = 320,
				y = 1000
			},
			[2] = 1
		}
	},
	btnSign = {
		zorder = 2,
		path = "btn_sign.png",
		desc = "签到",
		pos = {
			{
				x = 60,
				y = 850
			},
			[2] = 1
		},
		reddotpos = {
			x = "80",
			y = "80"
		}
	},
	btnRoulette = {
		zorder = 2,
		path = "btn_roulette.png",
		desc = "转盘",
		pos = {
			{
				x = 450,
				y = 200
			},
			[2] = -1
		},
		reddotpos = {
			x = "80",
			y = "80"
		}
	},
	btnBp = {
		path = "btn_bp.png",
		zorder = 2,
		action = "jump",
		desc = "bp",
		pos = {
			{
				x = 450,
				y = 400
			},
			[2] = 1
		},
		reddotpos = {
			x = "80",
			y = "80"
		}
	},
	btnRandfight = {
		zorder = 2,
		path = "btn_randfight.png",
		desc = "随机(boss)挑战",
		pos = {
			{
				x = 160,
				y = 600
			},
			[2] = 1
		},
		reddotpos = {
			x = "80",
			y = "80"
		}
	},
	btnReturn = {
		zorder = 2,
		path = "btn_return.png",
		desc = "返回键",
		pos = {
			{
				x = 80,
				y = 60
			},
			[2] = -1
		}
	}
}

return value_list
