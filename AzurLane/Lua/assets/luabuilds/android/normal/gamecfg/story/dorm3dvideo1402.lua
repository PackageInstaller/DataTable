local var_0_0 = {
	mode = 2,
	shipGroup = 49905,
	id = "DORM3DVIDEO1402",
	label = "dorm3d_VIDEO_CHAT_LABEL"
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/dorm3d_aegir_telephone25/dorm3d_aegir_telephone25",
	wait = 1,
	say = "哦~接电话的速度这么快？"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2

local var_0_5 = {
	voice = "event:/dorm/dorm3d_aegir_telephone26/dorm3d_aegir_telephone26",
	wait = 1,
	say = "你的手指……该不会一直放在接听键上吧？"
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
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
			name = "Empty",
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
	voice = "event:/dorm/dorm3d_aegir_telephone27/dorm3d_aegir_telephone27",
	wait = 1,
	say = "你就承认吧~我也不会因为你在傻笑着等我的电话就嘲笑……"
}
local var_0_9 = {}

STORY_EVENT = var_0_7
var_0_9.name = var_0_7.TEST
var_0_9.data = {
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

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[3] = var_0_8

local var_0_11 = {
	voice = "event:/dorm/dorm3d_aegir_telephone28/dorm3d_aegir_telephone28",
	wait = 2,
	say = "你、你承认得也太干脆了吧！"
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[4] = var_0_11

local var_0_14 = {
	voice = "event:/dorm/dorm3d_aegir_telephone29/dorm3d_aegir_telephone29",
	wait = 1,
	say = "那我不就没办法捉弄你了嘛。"
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone30/dorm3d_aegir_telephone30",
	wait = 1,
	say = "就连提前准备好的调侃都用不上了，真遗憾啊……"
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
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

local var_0_19 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_19.name = var_5.TEST_DONE
var_0_18.callbackData = var_0_19
var_0_17.dispatcher = var_0_18
var_0_1[6] = var_0_17

local var_0_20 = {
	voice = "event:/dorm/dorm3d_aegir_telephone31/dorm3d_aegir_telephone31",
	wait = 1,
	say = "……啊，至于现在打过来的理由？……唔……"
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
	op_list = {
		{
			param = "Play",
			name = "think_01-start",
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

local var_0_22 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_22.name = var_5.TEST_DONE
var_0_21.callbackData = var_0_22
var_0_20.dispatcher = var_0_21
var_0_1[7] = var_0_20

local var_0_23 = {
	voice = "event:/dorm/dorm3d_aegir_telephone32/dorm3d_aegir_telephone32",
	wait = 2,
	say = "现在特别想听听你的声音，比平时更想，就这么简单。"
}
local var_0_24 = {}

STORY_EVENT = var_0_22
var_0_24.name = var_0_22.TEST
var_0_24.data = {
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

local var_0_25 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_25.name = var_5.TEST_DONE
var_0_24.callbackData = var_0_25
var_0_23.dispatcher = var_0_24
var_0_1[8] = var_0_23

local var_0_26 = {
	voice = "event:/dorm/dorm3d_aegir_telephone33/dorm3d_aegir_telephone33",
	wait = 2,
	say = "你刚刚在忙些什么？"
}
local var_0_27 = {}

STORY_EVENT = var_0_25
var_0_27.name = var_0_25.TEST
var_0_27.data = {
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

local var_0_28 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_28.name = var_5.TEST_DONE
var_0_27.callbackData = var_0_28
var_0_26.dispatcher = var_0_27
var_0_1[9] = var_0_26

local var_0_29 = {
	voice = "event:/dorm/dorm3d_aegir_telephone34/dorm3d_aegir_telephone34",
	wait = 1,
	say = "该不会是一边工作一边偷看我们的合照吧？"
}
local var_0_30 = {}

STORY_EVENT = var_0_28
var_0_30.name = var_0_28.TEST
var_0_30.data = {
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

local var_0_31 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_31.name = var_5.TEST_DONE
var_0_30.callbackData = var_0_31
var_0_29.dispatcher = var_0_30
var_0_1[10] = var_0_29
var_0_1[11] = {
	voice = "event:/dorm/dorm3d_aegir_telephone35/dorm3d_aegir_telephone35",
	wait = 1,
	say = "呵呵……没关系，我允许了。"
}
var_0_1[12] = {
	voice = "event:/dorm/dorm3d_aegir_telephone36/dorm3d_aegir_telephone36",
	wait = 1,
	say = "只不过……比起合照，果然还是本人更加生动吧？"
}

local var_0_32 = {
	voice = "event:/dorm/dorm3d_aegir_telephone37/dorm3d_aegir_telephone37",
	wait = 1,
	say = "唔……这一点对我来说也是一样的呢……"
}
local var_0_33 = {}

STORY_EVENT = var_0_31
var_0_33.name = var_0_31.TEST
var_0_33.data = {
	op_list = {
		{
			param = "Play",
			name = "anger_01-start",
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

local var_0_34 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_34.name = var_5.TEST_DONE
var_0_33.callbackData = var_0_34
var_0_32.dispatcher = var_0_33
var_0_1[13] = var_0_32

local var_0_35 = {
	voice = "event:/dorm/dorm3d_aegir_telephone38/dorm3d_aegir_telephone38",
	wait = 1,
	say = "所以——我现在就要见到你，立刻，马上。"
}
local var_0_36 = {}

STORY_EVENT = var_0_34
var_0_36.name = var_0_34.TEST
var_0_36.data = {
	op_list = {
		{
			param = "Play",
			name = "stare_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_angry_start",
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
	voice = "event:/dorm/dorm3d_aegir_telephone39/dorm3d_aegir_telephone39",
	wait = 1,
	say = "当然，你也可以选择是你来见我，或者……我去找你。"
}
local var_0_39 = {}

STORY_EVENT = var_0_37
var_0_39.name = var_0_37.TEST
var_0_39.data = {
	op_list = {
		{
			param = "Play",
			name = "satisfied_01-start",
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

local var_0_40 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_40.name = var_5.TEST_DONE
var_0_39.callbackData = var_0_40
var_0_38.dispatcher = var_0_39
var_0_1[15] = var_0_38
var_0_1[16] = {
	voice = "event:/dorm/dorm3d_aegir_telephone40/dorm3d_aegir_telephone40",
	wait = 1,
	say = "但在做出选择之前，可得好好想清楚后果哦~"
}

local var_0_41 = {
	voice = "event:/dorm/dorm3d_aegir_telephone41/dorm3d_aegir_telephone41",
	wait = 1,
	say = "哪个选择有奖励……哪个选择有惩罚……"
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
	voice = "event:/dorm/dorm3d_aegir_telephone42/dorm3d_aegir_telephone42",
	wait = 1,
	say = "我想，你应该是明白的吧？",
	options = {
		{
			content = "我这就来见你。",
			flag = 1
		}
	}
}
local var_0_45 = {}

STORY_EVENT = var_4
var_0_45.name = var_4.TEST
var_0_45.data = {
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
			name = "Face_angry_start",
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
	voice = "event:/dorm/dorm3d_aegir_telephone43/dorm3d_aegir_telephone43",
	wait = 1,
	say = "呵呵……看样子，你对自己的决定很有把握呢……"
}

local var_0_47 = {
	voice = "event:/dorm/dorm3d_aegir_telephone44/dorm3d_aegir_telephone44",
	wait = 1,
	say = "既然如此，那就等你来到我身边的时候，再为你揭晓答案吧？"
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

local var_0_49 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_49.name = var_5.TEST_DONE
var_0_48.callbackData = var_0_49
var_0_47.dispatcher = var_0_48
var_0_1[20] = var_0_47

local var_0_50 = {
	voice = "event:/dorm/dorm3d_aegir_telephone45/dorm3d_aegir_telephone45",
	wait = 0.5,
	say = "这种暧昧不清的感觉，最让人心痒难耐了啊~"
}
local var_0_51 = {}

STORY_EVENT = var_0_49
var_0_51.name = var_0_49.TEST
var_0_51.data = {
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
			name = "Face_common",
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
	voice = "event:/dorm/dorm3d_aegir_telephone46/dorm3d_aegir_telephone46",
	wait = 0.5,
	say = "所以……快来吧。"
}
local var_0_54 = {}

STORY_EVENT = var_0_52
var_0_54.name = var_0_52.TEST
var_0_54.data = {
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

local var_0_55 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_55.name = var_5.TEST_DONE
var_0_54.callbackData = var_0_55
var_0_53.dispatcher = var_0_54
var_0_1[22] = var_0_53

local var_0_56 = {
	voice = "event:/dorm/dorm3d_aegir_telephone47/dorm3d_aegir_telephone47",
	wait = 0.5,
	say = "当你知道答案的那一刻，会露出什么样的表情呢？"
}
local var_0_57 = {}

STORY_EVENT = var_0_55
var_0_57.name = var_0_55.TEST
var_0_57.data = {
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

local var_0_58 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_58.name = var_5.TEST_DONE
var_0_57.callbackData = var_0_58
var_0_56.dispatcher = var_0_57
var_0_1[23] = var_0_56

local var_0_59 = {
	voice = "event:/dorm/dorm3d_aegir_telephone48/dorm3d_aegir_telephone48",
	wait = 0.5,
	say = "真是……美味得让人无比期待啊……"
}
local var_0_60 = {}

STORY_EVENT = var_0_58
var_0_60.name = var_0_58.TEST
var_0_60.data = {
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
