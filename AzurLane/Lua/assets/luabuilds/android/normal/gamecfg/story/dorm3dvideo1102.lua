local var_0_0 = {
	mode = 2,
	shipGroup = 10517,
	id = "DORM3DVIDEO1102",
	label = "dorm3d_VIDEO_CHAT_LABEL"
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone25",
	wait = 1,
	say = "嗯？Honey接电话的速度真快~~"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "talk_02-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_yihuo_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone26",
	wait = 1,
	say = "难道是……一直在那边默默地等着我的电话嘛~♪"
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_amazed_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone27",
	wait = 1,
	say = "咦，Honey你这是认真地在等我？对不起，是我来迟了~"
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
			name = "face_amazed_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone28",
	wait = 1,
	say = "但是好开心~乖乖期待着我的电话的Honey……"
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
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
			name = "face_smile_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone29",
	wait = 1,
	say = "以静制动，等待我主动出击的Honey……"
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
	op_list = {
		{
			param = "Play",
			name = "idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_smile_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone30",
	wait = 1,
	say = "怎么想都可爱过头了吧~♡"
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone31",
	wait = 1,
	say = "说起来，我的表现也值得夸奖吧？"
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
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
			name = "face_smile_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone32",
	wait = 1,
	say = "精心地筹划，又辛辛苦苦地忍耐了这么久……"
}

local var_0_23 = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone33",
	wait = 2,
	say = "就为了在Honey最想我的时候，闪耀登场——"
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone34",
	wait = 1,
	say = "呼呼，这番表现也很惊艳吧！"
}
local var_0_27 = {}

STORY_EVENT = var_0_25
var_0_27.name = var_0_25.TEST
var_0_27.data = {
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone35",
	wait = 1,
	say = "Honey的视线要牢牢地锁定在我身上，绝对不能移开哦~♪"
}
var_0_1[12] = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone36",
	wait = 1,
	say = "既然我们配合得这么默契——"
}

local var_0_29 = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone37",
	wait = 1,
	say = "那我也要好好想想怎么奖励你才行呢~~"
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
			name = "face_think_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone38",
	wait = 1,
	say = "要怎么办呢……奖励的话，好像只能我亲自上了嘛~？"
}
local var_0_33 = {}

STORY_EVENT = var_0_31
var_0_33.name = var_0_31.TEST
var_0_33.data = {
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone39",
	wait = 1,
	say = "想对Honey你做些，这样的……那样的事情……"
}
local var_0_36 = {}

STORY_EVENT = var_0_34
var_0_36.name = var_0_34.TEST
var_0_36.data = {
	op_list = {
		{
			param = "Play",
			name = "talk_02-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_shy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone40",
	wait = 1,
	say = "再像甜甜的冰淇淋一样，包裹着你……"
}

local var_0_38 = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone41",
	wait = 1,
	say = "呼呼，要融化了~♡"
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone42",
	wait = 2,
	say = "Honey现在的表情好有趣，好想录下来啊",
	options = {
		{
			content = "我也很喜欢你现在的表情。",
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
			name = "face_smile_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone43",
	wait = 0.5,
	say = "咦，竟然被你抓到了反击点？"
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
			name = "face_yihuo_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone44",
	wait = 0.5,
	say = "不愧是Honey，从不放过任何战略机会啊~♪"
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
			name = "face_yihuo_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone45",
	wait = 0.5,
	say = "不过呢，现在还有一个更好的机会摆在你面前哦……"
}
local var_0_51 = {}

STORY_EVENT = var_0_49
var_0_51.name = var_0_49.TEST
var_0_51.data = {
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
			name = "face_happy_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone46",
	wait = 0.5,
	say = "我可是特地为稍后的约会，安排了奖励的kiss和……更甜蜜的环节~♡"
}
local var_0_54 = {}

STORY_EVENT = var_0_52
var_0_54.name = var_0_52.TEST
var_0_54.data = {
	op_list = {
		{
			param = "Play",
			name = "talk_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_smile_start",
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
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone47",
	wait = 0.5,
	say = "所以，快点来见我吧~！"
}
local var_0_57 = {}

STORY_EVENT = var_0_55
var_0_57.name = var_0_55.TEST
var_0_57.data = {
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
			name = "face_smile_start",
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

local var_0_59 = {
	voice = "event:/dorm/drom3d_NewJersey_other/dorm3d_newjersey_telephone48",
	wait = 0.5,
	say = "否则……我就要主动出击了！"
}
local var_0_60 = {}

STORY_EVENT = var_0_58
var_0_60.name = var_0_58.TEST
var_0_60.data = {
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
			name = "face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_61 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_61.name = var_5.TEST_DONE
var_0_60.callbackData = var_0_61
var_0_59.dispatcher = var_0_60
var_0_1[24] = var_0_59
var_0_0.scripts = var_0_1

return var_0_0
