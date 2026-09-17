value_list = {
	btnRoulette = {
		zorder = 2,
		path = "btn_roulette.png",
		desc = "转盘",
		pos = {
			{
				x = 160,
				y = 500
			},
			[2] = -1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	},
	btnReturn = {
		path = "btn_return.png",
		zorder = 2,
		desc = "返回键",
		pos = {
			{
				x = 480,
				y = 1000
			},
			[2] = 1
		}
	},
	btnFlop = {
		zorder = 2,
		path = "btn_flop.png",
		desc = "翻牌",
		pos = {
			{
				x = 320,
				y = 400
			},
			[2] = -1
		},
		reddotpos = {
			x = 240,
			y = 86
		}
	},
	textFinishtime = {
		zorder = 41,
		font = "fonts/W5.ttf",
		fontstr = "剩余时间：",
		str = "",
		size = 30,
		desc = "结束时间",
		pos = {
			{
				x = 240,
				y = 952
			},
			[2] = 1
		},
		color = {
			g = 232,
			b = 255,
			r = 242
		}
	}
}

return value_list
