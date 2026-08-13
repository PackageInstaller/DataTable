local var_0_0 = {
	mode = 2,
	shipGroup = 49905,
	id = "DORM3DVIDEO1401",
	label = "dorm3d_VIDEO_CHAT_LABEL"
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/dorm3d_aegir_telephone1/dorm3d_aegir_telephone1",
	wait = 1,
	say = "……嗯？你总算接电话了。"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone2/dorm3d_aegir_telephone2",
	wait = 1,
	say = "等你的这段时间，我连天上的星星都数了个遍呢。"
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone3/dorm3d_aegir_telephone3",
	wait = 1,
	say = "甚至还考虑了一下，要不要过去找你，然后把你绑回来——"
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

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[3] = var_0_8

local var_0_11 = {
	voice = "event:/dorm/dorm3d_aegir_telephone4/dorm3d_aegir_telephone4",
	wait = 1,
	say = "不过想了想……还是算了。"
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
	voice = "event:/dorm/dorm3d_aegir_telephone5/dorm3d_aegir_telephone5",
	wait = 1,
	say = "难得给你打个电话……你就没有什么想对我说的吗？"
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
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
			name = "Face_shame_start",
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
	voice = "event:/dorm/dorm3d_aegir_telephone6/dorm3d_aegir_telephone6",
	wait = 1,
	say = "所、所以说，你是打算盯着我看到什么时候？"
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
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

local var_0_19 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_19.name = var_5.TEST_DONE
var_0_18.callbackData = var_0_19
var_0_17.dispatcher = var_0_18
var_0_1[6] = var_0_17

local var_0_20 = {
	voice = "event:/dorm/dorm3d_aegir_telephone7/dorm3d_aegir_telephone7",
	wait = 1,
	say = "真是的……总觉得烦躁了起来……"
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
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

local var_0_22 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_22.name = var_5.TEST_DONE
var_0_21.callbackData = var_0_22
var_0_20.dispatcher = var_0_21
var_0_1[7] = var_0_20
var_0_1[8] = {
	voice = "event:/dorm/dorm3d_aegir_telephone8/dorm3d_aegir_telephone8",
	wait = 1,
	say = "……你也不许动。对，就保持这个角度。"
}

local var_0_23 = {
	voice = "event:/dorm/dorm3d_aegir_telephone9/dorm3d_aegir_telephone9",
	wait = 2,
	say = "单方面被你盯着，总觉得有点不爽。"
}
local var_0_24 = {}

STORY_EVENT = var_0_22
var_0_24.name = var_0_22.TEST
var_0_24.data = {
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

local var_0_25 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_25.name = var_5.TEST_DONE
var_0_24.callbackData = var_0_25
var_0_23.dispatcher = var_0_24
var_0_1[9] = var_0_23

local var_0_26 = {
	voice = "event:/dorm/dorm3d_aegir_telephone10/dorm3d_aegir_telephone10",
	wait = 2,
	say = "既然如此，我也要这样紧紧盯着你……"
}
local var_0_27 = {}

STORY_EVENT = var_0_25
var_0_27.name = var_0_25.TEST
var_0_27.data = {
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

local var_0_28 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_28.name = var_5.TEST_DONE
var_0_27.callbackData = var_0_28
var_0_26.dispatcher = var_0_27
var_0_1[10] = var_0_26
var_0_1[11] = {
	voice = "event:/dorm/dorm3d_aegir_telephone11/dorm3d_aegir_telephone11",
	wait = 1,
	say = "……啊真是的！为什么你能这样……眼神一点也不闪躲……！"
}
var_0_1[12] = {
	voice = "event:/dorm/dorm3d_aegir_telephone12/dorm3d_aegir_telephone12",
	wait = 1,
	say = "哼……既然你这么想看，那就让你看个够好了。"
}

local var_0_29 = {
	voice = "event:/dorm/dorm3d_aegir_telephone13/dorm3d_aegir_telephone13",
	wait = 1,
	say = "……喂，这种时候不该说点什么吗？"
}
local var_0_30 = {}

STORY_EVENT = var_0_28
var_0_30.name = var_0_28.TEST
var_0_30.data = {
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
var_0_1[13] = var_0_29

local var_0_32 = {
	voice = "event:/dorm/dorm3d_aegir_telephone14/dorm3d_aegir_telephone14",
	wait = 1,
	say = "……明明是我主动提的建议，最后心跳加速的怎么也是我啊。"
}
local var_0_33 = {}

STORY_EVENT = var_0_31
var_0_33.name = var_0_31.TEST
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
	voice = "event:/dorm/dorm3d_aegir_telephone15/dorm3d_aegir_telephone15",
	wait = 1,
	say = "啧……总觉得好像莫名其妙就输给你了。"
}
local var_0_36 = {}

STORY_EVENT = var_0_34
var_0_36.name = var_0_34.TEST
var_0_36.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone16/dorm3d_aegir_telephone16",
	wait = 1,
	say = "再来一次，别动，让我看着你……"
}

local var_0_38 = {
	voice = "event:/dorm/dorm3d_aegir_telephone17/dorm3d_aegir_telephone17",
	wait = 1,
	say = "嗯，比刚刚稍微习惯一点了……"
}
local var_0_39 = {}

STORY_EVENT = var_0_37
var_0_39.name = var_0_37.TEST
var_0_39.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone18/dorm3d_aegir_telephone18",
	wait = 2,
	say = "说起来……现在的你，看着有些疲倦呢。",
	options = {
		{
			content = "最近的工作稍微有点多。",
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
			name = "Idle",
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

local var_0_43 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_43.name = var_5.TEST_DONE
var_0_42.callbackData = var_0_43
var_0_41.dispatcher = var_0_42
var_0_1[18] = var_0_41

local var_0_44 = {
	voice = "event:/dorm/dorm3d_aegir_telephone19/dorm3d_aegir_telephone19",
	wait = 0.5,
	say = "最近？感觉每天都是这样吧，真可怜呢。"
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

local var_0_46 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_46.name = var_5.TEST_DONE
var_0_45.callbackData = var_0_46
var_0_44.dispatcher = var_0_45
var_0_1[19] = var_0_44

local var_0_47 = {
	voice = "event:/dorm/dorm3d_aegir_telephone20/dorm3d_aegir_telephone20",
	wait = 0.5,
	say = "既然如此，就让我为你做点能消除疲劳的事情吧？"
}
local var_0_48 = {}

STORY_EVENT = var_0_46
var_0_48.name = var_0_46.TEST
var_0_48.data = {
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
	voice = "event:/dorm/dorm3d_aegir_telephone21/dorm3d_aegir_telephone21",
	wait = 0.5,
	say = "……别笑了！我只是觉得刚才那种心跳加速的感觉，还蛮有趣的。"
}
local var_0_51 = {}

STORY_EVENT = var_0_49
var_0_51.name = var_0_49.TEST
var_0_51.data = {
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

local var_0_52 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_52.name = var_5.TEST_DONE
var_0_51.callbackData = var_0_52
var_0_50.dispatcher = var_0_51
var_0_1[21] = var_0_50

local var_0_53 = {
	voice = "event:/dorm/dorm3d_aegir_telephone22/dorm3d_aegir_telephone22",
	wait = 0.5,
	say = "不过，这种事可不是像这样聊天就能办到的哦？"
}
local var_0_54 = {}

STORY_EVENT = var_0_52
var_0_54.name = var_0_52.TEST
var_0_54.data = {
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

local var_0_55 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_55.name = var_5.TEST_DONE
var_0_54.callbackData = var_0_55
var_0_53.dispatcher = var_0_54
var_0_1[22] = var_0_53

local var_0_56 = {
	voice = "event:/dorm/dorm3d_aegir_telephone23/dorm3d_aegir_telephone23",
	wait = 0.5,
	say = "……所以你明白了吗？"
}
local var_0_57 = {}

STORY_EVENT = var_0_55
var_0_57.name = var_0_55.TEST
var_0_57.data = {
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

local var_0_59 = {
	voice = "event:/dorm/dorm3d_aegir_telephone24/dorm3d_aegir_telephone24",
	wait = 0.5,
	say = "我等你。"
}
local var_0_60 = {}

STORY_EVENT = var_0_58
var_0_60.name = var_0_58.TEST
var_0_60.data = {
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
