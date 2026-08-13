local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTEST01",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	recallOption = true,
	say = "第二个分区，名为《夕阳》，同样摆放着四副画作——",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "查看《跛脚巨人》",
			flag = 1
		},
		{
			content = "查看《值得警戒》",
			flag = 2
		},
		{
			content = "查看《被孤立的巨人》",
			flag = 3
		},
		{
			content = "查看《圣诞之夜静悄悄》",
			flag = 4
		}
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			skip = false,
			name = "surprise2",
			type = "action"
		},
		{
			skip = false,
			type = "clickOption",
			options = {
				{
					flag = 1,
					pos = {
						10,
						10
					}
				},
				{
					flag = 2,
					pos = {
						-100,
						-10
					}
				},
				{
					flag = 3,
					pos = {
						200,
						-100
					}
				},
				{
					flag = 4,
					pos = {
						-300,
						200
					}
				}
			}
		}
	}
}

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2
var_0_1[2] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 1,
	say = "“这是一幅描绘了小镇居民正在进行节日采购的油画。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 1,
	say = "“面包店前已排起长队，人群聚集在这里，等待着列巴与伏特加。“",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	expression = 5,
	side = 2,
	dir = 1,
	optionFlag = 1,
	actor = 701110,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "这个画面倒是有些熟悉呢……",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	side = 2,
	dir = 1,
	optionFlag = 1,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "是啊……不过近两年随着海运的打通与战况的好转。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[6] = {
	expression = 1,
	side = 2,
	dir = 1,
	optionFlag = 1,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "现在的粮食供应愈发充足，这种景象已经越来越少看到了。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[7] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 2,
	say = "“这是一幅描绘了审判会场的油画。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[8] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 2,
	say = "“被审判的人是一名试图指挥军舰冲向圣彼得伯格的海军军官。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[9] = {
	expression = 5,
	side = 2,
	dir = 1,
	optionFlag = 2,
	actor = 705020,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "指挥军舰冲向圣彼得伯格……看来这场审判的结果已经注定了。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[10] = {
	expression = 4,
	side = 2,
	dir = 1,
	optionFlag = 2,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "……画面描绘的，依然是未曾听说过的事件。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[11] = {
	expression = 1,
	side = 2,
	dir = 1,
	optionFlag = 2,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "是军舰不是舰船……有点摸不透这张作品的创作时期与背景呢。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[12] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 3,
	say = "“这是一幅依照古怪风格重绘的抽象艺术画。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[13] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 3,
	say = "“画面中以凌乱线条组成的北方联合代表，与用整齐线条绘制的人群形成鲜明对比。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[14] = {
	expression = 4,
	side = 2,
	dir = 1,
	optionFlag = 3,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "用了这样的艺术展现方式啊。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[15] = {
	expression = 7,
	side = 2,
	dir = 1,
	optionFlag = 3,
	actor = 705080,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "不得不说，真是抽象得恰到好处……",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[16] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 4,
	say = "“这是一幅简笔画，内容似乎是某个建筑上的旗帜在夜幕中缓缓降下。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[17] = {
	actorName = "艺术品介绍",
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	optionFlag = 4,
	say = "“由于是儿童绘制，细节并不清晰，但仍能令人感受到其中蕴含的肃穆。”",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[18] = {
	expression = 6,
	side = 2,
	dir = 1,
	optionFlag = 4,
	actor = 701120,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "……这什么啊，怎么连儿童画也能放到画廊里展示了。",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[19] = {
	expression = 4,
	side = 2,
	dir = 1,
	optionFlag = 4,
	actor = 701110,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "虽然看不清内容，但是看到这幅画，让我有些说不出的不舒服……",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[20] = {
	expression = 1,
	side = 2,
	dir = 1,
	optionFlag = 4,
	actor = 701120,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "同感，看到就有股无名火！",
	painting = {
		alpha = 0.3,
		time = 1
	},
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[21] = {
	side = 2,
	nameColor = "#A9F548FF",
	hidePaintObj = true,
	say = "众人继续前进，来到画廊的下一个分区。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	flashout = {
		dur = 1,
		black = true,
		alpha = {
			0,
			1
		}
	},
	flashin = {
		dur = 1,
		black = true,
		delay = 1,
		alpha = {
			1,
			0
		}
	}
}

local var_0_5 = {
	say = "对话2",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_6 = {}

STORY_EVENT = var_4
var_0_6.name = var_4.TEST
var_0_6.data = {
	op_list = {
		{
			skip = true,
			name = "surprise2",
			type = "action"
		},
		{
			skip = false,
			time = 0.5,
			type = "wait"
		}
	}
}

local var_0_7 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[22] = var_0_5
var_0_0.scripts = var_0_1

return var_0_0
