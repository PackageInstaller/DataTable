local var_0_0 = {
	mode = 2,
	shipGroup = 30707,
	id = "DORM3DVIDEO1202",
	label = "dorm3d_VIDEO_CHAT_LABEL"
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone1/dorm3d_Taiho_telephone1",
	wait = 1,
	say = "{dorm3d}，您终于回来了~！"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "hello_01-start",
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2

local var_0_5 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone2/dorm3d_Taiho_telephone2",
	wait = 1,
	say = "与您分别的每时每刻，都让{namecode:97}焦虑难耐……"
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
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
			name = "Face_shame_start",
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
	voice = "event:/dorm/dorm3d_Taiho_telephone3/dorm3d_Taiho_telephone3",
	wait = 1,
	say = "尤其在入睡时刻，即使贪婪地吮吸着您残留在房间的气息……"
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
	voice = "event:/dorm/dorm3d_Taiho_telephone4/dorm3d_Taiho_telephone4",
	wait = 2,
	say = "但那孤身一人的夜晚，还是让{namecode:97}难以忍受……！",
	options = {
		{
			content = "我也很牵挂你，所以抓紧时间回来了。",
			flag = 1
		}
	}
}
local var_0_12 = {}

STORY_EVENT = var_4
var_0_12.name = var_4.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "refuse_01-start",
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[4] = var_0_11

local var_0_14 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone5/dorm3d_Taiho_telephone5",
	wait = 1,
	say = "啊啊，{dorm3d}的怜爱……{namecode:97}还想拥有更多，更多~♡"
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
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
			name = "Face_smile_start",
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
	voice = "event:/dorm/dorm3d_Taiho_telephone6/dorm3d_Taiho_telephone6",
	wait = 1,
	say = "直到{namecode:97}能够满满当当地占据您的心——"
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
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

local var_0_19 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_19.name = var_5.TEST_DONE
var_0_18.callbackData = var_0_19
var_0_17.dispatcher = var_0_18
var_0_1[6] = var_0_17

local var_0_20 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone7/dorm3d_Taiho_telephone7",
	wait = 1,
	say = "为了{dorm3d}，{namecode:97}还需要更加努力才行呢……"
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
	op_list = {
		{
			param = "Play",
			name = "encourage_01-start",
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

local var_0_22 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_22.name = var_5.TEST_DONE
var_0_21.callbackData = var_0_22
var_0_20.dispatcher = var_0_21
var_0_1[7] = var_0_20

local var_0_23 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone8/dorm3d_Taiho_telephone8",
	wait = 2,
	say = "对了……您来找{namecode:97}的路上，没有被什么不长眼的害虫缠上吧~？",
	options = {
		{
			content = "没有，绝对没有。",
			flag = 1
		}
	}
}
local var_0_24 = {}

STORY_EVENT = var_4
var_0_24.name = var_4.TEST
var_0_24.data = {
	op_list = {
		{
			param = "Play",
			name = "enquire_01-start",
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

local var_0_25 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_25.name = var_5.TEST_DONE
var_0_24.callbackData = var_0_25
var_0_23.dispatcher = var_0_24
var_0_1[8] = var_0_23

local var_0_26 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone9/dorm3d_Taiho_telephone9",
	wait = 2,
	say = "{namecode:97}相信{dorm3d}……呵呵呵，您的一言一行，{namecode:97}都看在眼里~♡"
}
local var_0_27 = {}

STORY_EVENT = var_0_25
var_0_27.name = var_0_25.TEST
var_0_27.data = {
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

local var_0_28 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_28.name = var_5.TEST_DONE
var_0_27.callbackData = var_0_28
var_0_26.dispatcher = var_0_27
var_0_1[9] = var_0_26

local var_0_29 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone10/dorm3d_Taiho_telephone10",
	wait = 1,
	say = "但那些该死的害虫，总是仗着{dorm3d}心软，就贴到您身边……"
}
local var_0_30 = {}

STORY_EVENT = var_0_28
var_0_30.name = var_0_28.TEST
var_0_30.data = {
	op_list = {
		{
			param = "Play",
			name = "doubt_01-start",
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

local var_0_31 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_31.name = var_5.TEST_DONE
var_0_30.callbackData = var_0_31
var_0_29.dispatcher = var_0_30
var_0_1[10] = var_0_29
var_0_1[11] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone11/dorm3d_Taiho_telephone11",
	wait = 1,
	say = "呵呵呵呵，果然还是要找时间好好收拾一番……"
}
var_0_1[12] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone12/dorm3d_Taiho_telephone12",
	wait = 1,
	say = "不过，除虫的杂事，就留到之后再说吧。"
}

local var_0_32 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone13/dorm3d_Taiho_telephone13",
	wait = 1,
	say = "我对您的思念，只通过小小一块屏幕是没有办法缓解的……"
}
local var_0_33 = {}

STORY_EVENT = var_0_31
var_0_33.name = var_0_31.TEST
var_0_33.data = {
	op_list = {
		{
			param = "Play",
			name = "sad_01-start",
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

local var_0_34 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_34.name = var_5.TEST_DONE
var_0_33.callbackData = var_0_34
var_0_32.dispatcher = var_0_33
var_0_1[13] = var_0_32

local var_0_35 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone14/dorm3d_Taiho_telephone14",
	wait = 1,
	say = "现在，{namecode:97}只想与{dorm3d}一起，享受独属于彼此的时刻~"
}
local var_0_36 = {}

STORY_EVENT = var_0_34
var_0_36.name = var_0_34.TEST
var_0_36.data = {
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

local var_0_37 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_37.name = var_5.TEST_DONE
var_0_36.callbackData = var_0_37
var_0_35.dispatcher = var_0_36
var_0_1[14] = var_0_35

local var_0_38 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone15/dorm3d_Taiho_telephone15",
	wait = 1,
	say = "您应该知道的，{namecode:97}从不会对您设防……"
}
local var_0_39 = {}

STORY_EVENT = var_0_37
var_0_39.name = var_0_37.TEST
var_0_39.data = {
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

local var_0_40 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_40.name = var_5.TEST_DONE
var_0_39.callbackData = var_0_40
var_0_38.dispatcher = var_0_39
var_0_1[15] = var_0_38
var_0_1[16] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone16/dorm3d_Taiho_telephone16",
	wait = 1,
	say = "为了迎接您的到来，我的身体已经……开始提前预热了呢~"
}

local var_0_41 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone17/dorm3d_Taiho_telephone17",
	wait = 1,
	say = "请您到我身边吧，让{namecode:97}为您舒缓身体的疲劳，或者……将疲惫，全部释放出来吧~♡"
}
local var_0_42 = {}

STORY_EVENT = var_0_40
var_0_42.name = var_0_40.TEST
var_0_42.data = {
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
var_0_1[17] = var_0_41

local var_0_44 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone18/dorm3d_Taiho_telephone18",
	wait = 1,
	say = "在{namecode:97}的身边，您可以不用勉强自己呢……"
}
local var_0_45 = {}

STORY_EVENT = var_0_43
var_0_45.name = var_0_43.TEST
var_0_45.data = {
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

local var_0_46 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_46.name = var_5.TEST_DONE
var_0_45.callbackData = var_0_46
var_0_44.dispatcher = var_0_45
var_0_1[18] = var_0_44
var_0_1[19] = {
	voice = "event:/dorm/dorm3d_Taiho_telephone19/dorm3d_Taiho_telephone19",
	wait = 1,
	say = "所以，{dorm3d}……"
}

local var_0_47 = {
	voice = "event:/dorm/dorm3d_Taiho_telephone20/dorm3d_Taiho_telephone20",
	wait = 1,
	say = "请您快点来到{namecode:97}身边吧~♡"
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
			name = "Face_shame_start",
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
	voice = "event:/dorm/dorm3d_Taiho_telephone21/dorm3d_Taiho_telephone21",
	wait = 0.5,
	say = "{namecode:97}一定，会为{dorm3d}带来幸福的~"
}
local var_0_51 = {}

STORY_EVENT = var_0_49
var_0_51.name = var_0_49.TEST
var_0_51.data = {
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

local var_0_52 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_52.name = var_5.TEST_DONE
var_0_51.callbackData = var_0_52
var_0_50.dispatcher = var_0_51
var_0_1[21] = var_0_50
var_0_0.scripts = var_0_1

return var_0_0
