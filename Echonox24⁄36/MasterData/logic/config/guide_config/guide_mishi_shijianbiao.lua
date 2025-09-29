-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_mishi_shijianbiao.lua

local configData = {
	step1 = {
		tips = "残响时间(E.T.)代表当前游戏中的时间，以36小时为一循环",
		img = "mishi_shijianbiao",
		mask = true,
		imgKuang = {
			{
				-144.4201,
				103.5682,
				0,
				430,
				120
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "当残响时间处于24:00~35:59之间，将进入密室时间状态，并影响部分玩法内容的开启",
		img = "mishi_shijianbiao",
		mask = true,
		imgKuang = {
			{
				-144.42,
				103.5682,
				0,
				430,
				120
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step3 = {
		tips = "本地时间 表示当前的现实时间(北京时间)",
		img = "mishi_shijianbiao",
		mask = true,
		imgKuang = {
			{
				-304.7264,
				24.13717,
				0,
				100,
				70
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step4 = {
		tips = "此处展示本地时间7日内，会出现密室时间的时段，红色方块代表该时段将处于密室时间状态",
		img = "mishi_shijianbiao",
		mask = true,
		imgKuang = {
			{
				1.5,
				-114.5062,
				0,
				720,
				200
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
