local var_0_0 = {
	mode = 2,
	shipGroup = 30707,
	id = "DORM3DVIDEO1201",
	label = "dorm3d_VIDEO_CHAT_LABEL"
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone22/dorm3d_Taiho_telephone22",
	wait = 1,
	say = "呜呜呜……{dorm3d}，终于找到您了……！"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "shake_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
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

local var_0_5 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone23/dorm3d_Taiho_telephone23",
	wait = 1,
	say = "{namecode:97}……呜，{namecode:97}做了一个可怕的噩梦……！"
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "shy_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[2] = var_0_5

local var_0_8 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone24/dorm3d_Taiho_telephone24",
	wait = 1,
	say = "梦里，{namecode:97}独自走在昏暗的林间小道中……"
}
local var_0_9 = {}

STORY_EVENT = var_0_7
var_0_9.name = var_0_7.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "excited_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_amazed_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[3] = var_0_8

local var_0_11 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone25/dorm3d_Taiho_telephone25",
	wait = 1,
	say = "偶尔刮过的风摇晃着树影，发出让人害怕的声响……"
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "emotion_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[4] = var_0_11

local var_0_14 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone26/dorm3d_Taiho_telephone26",
	wait = 1,
	say = "在那片幽绿的世界中，{namecode:97}看到了无数双猩红的眼睛……！…"
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
	op_list = {
		{
			param = "Play",
			name = "shake_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1,
			type = "wait"
		}
	}
}

local var_0_16 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_16.name = var_5.TEST_DONE
var_0_15.callbackData = var_0_16
var_0_14.dispatcher = var_0_15
var_0_1[5] = var_0_14

local var_0_17 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone27/dorm3d_Taiho_telephone27",
	wait = 1,
	say = "{namecode:97}不敢细看，也不敢回头！{namecode:97}知道，它们就紧紧跟在我的身后！"
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
	op_list = {
		{
			param = "Play",
			name = "amazed_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_19 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_19.name = var_5.TEST_DONE
var_0_18.callbackData = var_0_19
var_0_17.dispatcher = var_0_18
var_0_1[6] = var_0_17

local var_0_20 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone28/dorm3d_Taiho_telephone28",
	wait = 1,
	say = "就在黑暗几乎完全吞噬{namecode:97}的前一秒——{dorm3d}，您就像奇迹般出现在我的面前！"
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
	op_list = {
		{
			param = "Play",
			name = "amazed_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_22 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_22.name = var_5.TEST_DONE
var_0_21.callbackData = var_0_22
var_0_20.dispatcher = var_0_21
var_0_1[7] = var_0_20
var_0_1[8] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone29/dorm3d_Taiho_telephone29",
	wait = 1,
	say = "是您击退了那些红眼的怪物，救出了{namecode:97}！"
}

local var_0_23 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone30/dorm3d_Taiho_telephone30",
	wait = 2,
	say = "果然，{dorm3d}是不会抛下{namecode:97}的……无论何时，您都会陪伴在我身边~"
}
local var_0_24 = {}

STORY_EVENT = var_0_22
var_0_24.name = var_0_22.TEST
var_0_24.data = {
	op_list = {
		{
			param = "Play",
			name = "invite_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_happy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_25 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_25.name = var_5.TEST_DONE
var_0_24.callbackData = var_0_25
var_0_23.dispatcher = var_0_24
var_0_1[9] = var_0_23

local var_0_26 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone31/dorm3d_Taiho_telephone31",
	wait = 2,
	say = "梦中的您，也会让{namecode:97}激动到颤抖~♡",
	options = {
		{
			content = "颤抖……有没有被吓醒呢？",
			flag = 1
		}
	}
}
local var_0_27 = {}

STORY_EVENT = var_4
var_0_27.name = var_4.TEST
var_0_27.data = {
	op_list = {
		{
			param = "Play",
			name = "excited_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_happy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_28 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_28.name = var_5.TEST_DONE
var_0_27.callbackData = var_0_28
var_0_26.dispatcher = var_0_27
var_0_1[10] = var_0_26
var_0_1[11] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone32/dorm3d_Taiho_telephone32",
	wait = 1,
	say = "才没有呢~梦中的{namecode:97}受到{dorm3d}的保护，还在感谢您的这份怜爱——"
}
var_0_1[12] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone33/dorm3d_Taiho_telephone33",
	wait = 1,
	say = "您带着我在树林里飞驰，还有一滴汗水落在了我的唇边~"
}

local var_0_29 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone34/dorm3d_Taiho_telephone34",
	wait = 1,
	say = "我正要对{dorm3d}倾诉我的爱意，一阵狂风吹了过来！~~"
}
local var_0_30 = {}

STORY_EVENT = var_0_28
var_0_30.name = var_0_28.TEST
var_0_30.data = {
	op_list = {
		{
			param = "Play",
			name = "nod_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_think_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_31 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_31.name = var_5.TEST_DONE
var_0_30.callbackData = var_0_31
var_0_29.dispatcher = var_0_30
var_0_1[13] = var_0_29

local var_0_32 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone35/dorm3d_Taiho_telephone35",
	wait = 1,
	say = "啊，真讨厌~！！{namecode:97}就这么醒了过来……",
	options = {
		{
			content = "是睡觉的时候，没有关窗户……然后下雨了？",
			flag = 1
		}
	}
}
local var_0_33 = {}

STORY_EVENT = var_4
var_0_33.name = var_4.TEST
var_0_33.data = {
	op_list = {
		{
			param = "Play",
			name = "shake_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_34 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_34.name = var_5.TEST_DONE
var_0_33.callbackData = var_0_34
var_0_32.dispatcher = var_0_33
var_0_1[14] = var_0_32

local var_0_35 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone36/dorm3d_Taiho_telephone36",
	wait = 1,
	say = "……"
}
local var_0_36 = {}

STORY_EVENT = var_0_34
var_0_36.name = var_0_34.TEST
var_0_36.data = {
	op_list = {
		{
			param = "Play",
			name = "Idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_37 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_37.name = var_5.TEST_DONE
var_0_36.callbackData = var_0_37
var_0_35.dispatcher = var_0_36
var_0_1[15] = var_0_35
var_0_1[16] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone37/dorm3d_Taiho_telephone37",
	wait = 1,
	say = "是{namecode:97}特意打开窗，在窗边等{dorm3d}来着~可是您迟迟不到。"
}

local var_0_38 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone38/dorm3d_Taiho_telephone38",
	wait = 1,
	say = "{namecode:97}等啊等啊~等啊~等啊~"
}
local var_0_39 = {}

STORY_EVENT = var_0_37
var_0_39.name = var_0_37.TEST
var_0_39.data = {
	op_list = {
		{
			param = "Play",
			name = "amazed_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_think_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_40 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_40.name = var_5.TEST_DONE
var_0_39.callbackData = var_0_40
var_0_38.dispatcher = var_0_39
var_0_1[17] = var_0_38

local var_0_41 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone39/dorm3d_Taiho_telephone39",
	wait = 2,
	say = "{dorm3d}……{namecode:97}，现在就想见您……",
	options = {
		{
			content = "身上擦干了吗？别着凉，我现在就过来看看情况。",
			flag = 1
		}
	}
}
local var_0_42 = {}

STORY_EVENT = var_4
var_0_42.name = var_4.TEST
var_0_42.data = {
	op_list = {
		{
			param = "Play",
			name = "shy_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_smile_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_43 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_43.name = var_5.TEST_DONE
var_0_42.callbackData = var_0_43
var_0_41.dispatcher = var_0_42
var_0_1[18] = var_0_41

local var_0_44 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone40/dorm3d_Taiho_telephone40",
	wait = 0.5,
	say = "{dorm3d}……您总是这样，愿意包容这{namecode:97}的任性和无理取闹……"
}
local var_0_45 = {}

STORY_EVENT = var_0_43
var_0_45.name = var_0_43.TEST
var_0_45.data = {
	op_list = {
		{
			param = "Play",
			name = "Idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_happy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_46 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_46.name = var_5.TEST_DONE
var_0_45.callbackData = var_0_46
var_0_44.dispatcher = var_0_45
var_0_1[19] = var_0_44

local var_0_47 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone41/dorm3d_Taiho_telephone41",
	wait = 0.5,
	say = "{namecode:97}会不会就这样，被您纵容成一个过分的人了呢……？"
}
local var_0_48 = {}

STORY_EVENT = var_0_46
var_0_48.name = var_0_46.TEST
var_0_48.data = {
	op_list = {
		{
			param = "Play",
			name = "Idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_happy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_49 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_49.name = var_5.TEST_DONE
var_0_48.callbackData = var_0_49
var_0_47.dispatcher = var_0_48
var_0_1[20] = var_0_47

local var_0_50 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone42/dorm3d_Taiho_telephone42",
	wait = 0.5,
	say = "让{namecode:97}变得这样情不自禁……{dorm3d}可不能逃避责任。"
}
local var_0_51 = {}

STORY_EVENT = var_0_49
var_0_51.name = var_0_49.TEST
var_0_51.data = {
	op_list = {
		{
			param = "Play",
			name = "yandere_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_52 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_52.name = var_5.TEST_DONE
var_0_51.callbackData = var_0_52
var_0_50.dispatcher = var_0_51
var_0_1[21] = var_0_50

local var_0_53 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone43/dorm3d_Taiho_telephone43",
	wait = 0.5,
	say = "{namecode:97}已经擦干了雨水，等您到来时门窗一定都会锁好。"
}
local var_0_54 = {}

STORY_EVENT = var_0_52
var_0_54.name = var_0_52.TEST
var_0_54.data = {
	op_list = {
		{
			param = "Play",
			name = "invite_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_smile_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_55 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_55.name = var_5.TEST_DONE
var_0_54.callbackData = var_0_55
var_0_53.dispatcher = var_0_54
var_0_1[22] = var_0_53

local var_0_56 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone44/dorm3d_Taiho_telephone44",
	wait = 0.5,
	say = "之后，就拜托{dorm3d}……好好地疼爱{namecode:97}吧~♡"
}
local var_0_57 = {}

STORY_EVENT = var_0_55
var_0_57.name = var_0_55.TEST
var_0_57.data = {
	op_list = {
		{
			param = "Play",
			name = "happy_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shy_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_58 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_58.name = var_5.TEST_DONE
var_0_57.callbackData = var_0_58
var_0_56.dispatcher = var_0_57
var_0_1[23] = var_0_56
var_0_0.scripts = var_0_1

return var_0_0
