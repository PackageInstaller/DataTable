local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		mode = 1,
		stopbgm = true,
		sequence = {
			{
				"走廊\n\n正打算敲门的时候……",
				1
			}
		}
	},
	{
		say = "{dorm3d}，天狼星在此恭候您多时了。",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	say = "请进。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "Tianlangxing01",
			time = 15,
			type = "timeline",
			skip = true
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
var_0_1[3] = var_0_2

local var_0_5 = {
	say = "还请您原谅天狼星刚刚有些简陋的迎接仪式。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "Bow",
			time = 0,
			type = "action"
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
var_0_1[4] = var_0_5
var_0_1[5] = {
	say = "如果准备时间更充足的话，天狼星一定会安排得更加隆重和正式。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_8 = {
	say = "欸？这样就很好……不用道歉？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_9 = {}

STORY_EVENT = var_0_7
var_0_9.name = var_0_7.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "surprise1",
			time = 0,
			type = "action"
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
var_0_1[6] = var_0_8
var_0_1[7] = {
	say = "不过，能在这样……较为私密的场合中侍奉您，天狼星真的非常开心。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	say = "咦？把房间打扫得这么整洁，一定很辛苦吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "surprise2",
			time = 0,
			type = "action"
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
var_0_1[8] = var_0_11
var_0_1[9] = {
	say = "这些都是天狼星应该做的。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[10] = {
	say = "作为一名皇家女仆，天狼星份内的职责之一就是将{dorm3d}要经过的地方清扫得一尘不染呢。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[11] = {
	say = "事实上，为了随时迎接{dorm3d}的到来，天狼星已经做好了万全准备……！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[12] = {
	say = "以前天狼星对日常工作不太熟练，但现在的天狼星和过去相比，有所进步了。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_14 = {
	say = "而且为了能给{dorm3d}一个舒适的体验，天狼星特意请求女仆长进行了指导和协助。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
	op_list = {
		{
			param = "Play",
			name = "shy",
			time = 0,
			type = "action"
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
var_0_1[13] = var_0_14
var_0_1[14] = {
	say = "口感和温度恰到好处的红茶，鲜美且营养均衡的高级茶点……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[15] = {
	say = "干净整洁的寝具，还有天狼星本人，现在都已经是完美状态。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[16] = {
	say = "无论提出什么要求，天狼星都能满足{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_17 = {
	say = "您说，要和天狼星一起休息？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_18 = {}

STORY_EVENT = var_0_16
var_0_18.name = var_0_16.TEST
var_0_18.data = {
	op_list = {
		{
			param = "Play",
			name = "shy",
			time = 0,
			type = "action"
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
var_0_1[17] = var_0_17
var_0_1[18] = {
	say = "这是让……天狼星开始侍奉的意思么？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_20 = {
	say = "啊！终于，这一天终于来了……我和{dorm3d}一起……天狼星一直以来期待的……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_21 = {}

STORY_EVENT = var_0_19
var_0_21.name = var_0_19.TEST
var_0_21.data = {
	op_list = {
		{
			param = "Play",
			name = "shy",
			time = 0,
			type = "action"
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
var_0_1[19] = var_0_20
var_0_1[20] = {
	say = "只是普通的坐下休息？做了这么多事情应该很累……？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[21] = {
	say = "原来是这样……该怎么说呢……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[22] = {
	say = "没想到会收到这种要求……但如果这是{dorm3d}所希望的，天狼星当然会做到。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[23] = {
	say = "那么，就请和天狼星来沙发上休息吧，我骄傲的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
