local var_0_0 = {
	id = "ACTRUYUE01",
	label = "dorm3d_VIDEO_CHAT_LABEL",
	shipGroup = 20220
}
local var_0_1 = {
	{
		voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello1",
		wait = 3,
		say = "通话过程中背景会变为"
	}
}
local var_0_2 = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello2",
	wait = 1,
	say = "会结束当前播放"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "shuohua_buhaoyisi",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_xinxu",
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
var_0_1[2] = var_0_2
var_0_1[3] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello3",
	wait = 1,
	say = "播放结束后在下方出现"
}
var_0_1[4] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello4",
	wait = 1,
	say = "在挂断状态持"
}
var_0_1[5] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello5",
	wait = 1,
	say = "语音全部播放完",
	options = {
		{
			content = "选项1",
			flag = 1
		},
		{
			content = "选项2",
			flag = 2
		}
	}
}
var_0_1[6] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello6",
	optionFlag = 1,
	wait = 1,
	say = "选项1"
}
var_0_1[7] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello7",
	optionFlag = 2,
	wait = 1,
	say = "选项2"
}
var_0_1[8] = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello9",
	wait = 1,
	say = "到语音列表"
}
var_0_0.scripts = var_0_1

return var_0_0
