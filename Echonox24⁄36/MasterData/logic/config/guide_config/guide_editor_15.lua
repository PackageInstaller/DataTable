-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_15.lua

local configData = {
	step1 = {
		tips = "生效的效果可以在上方总览",
		img = "paotuan_fujia1",
		mask = true,
		imgKuang = {
			{
				-308.8499,
				131.225,
				0,
				310,
				200
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "附加面只在判定中生效",
		img = "paotuan_fujia1",
		mask = true,
		imgKuang = {
			{
				-308.3543,
				-69.7468,
				0,
				310,
				140
			}
		},
		leftHint = {},
		rightHint = {
			{
				313.5456,
				-154.3785,
				0,
				"附加面总览"
			}
		}
	},
	step3 = {
		tips = "守秘人投掷瞬间附加面会随机附至骰子上的空白面",
		img = "paotuan_fujia3",
		mask = true,
		imgKuang = {
			{
				-149.7721,
				63.87345,
				0,
				100,
				200
			},
			{
				-68.14993,
				248.675,
				0,
				60,
				60
			}
		},
		leftHint = {
			{
				205.75,
				162.575,
				0,
				"附加面数量"
			}
		},
		rightHint = {}
	},
	step4 = {
		tips = "每回合中1个附加面会附加1次，切回合后大部分面重置",
		img = "paotuan_fujia4",
		mask = true,
		imgKuang = {
			{
				-11.59995,
				250.125,
				0,
				160,
				50
			},
			{
				-33.77213,
				138.7595,
				0,
				90,
				90
			}
		},
		leftHint = {
			{
				214.45,
				162.575,
				0,
				"回合重置附加面"
			}
		},
		rightHint = {
			{
				483.8747,
				52.65946,
				0,
				"暂时失效"
			}
		}
	},
	step5 = {
		tips = "投掷结果为附加面时，生效附加面的独有效果",
		img = "paotuan_fujia5",
		mask = true,
		imgKuang = {
			{
				-46.98727,
				31.56965,
				0,
				80,
				80
			}
		},
		leftHint = {},
		rightHint = {
			{
				460.381,
				-55.99874,
				0,
				"附加面生效"
			}
		}
	},
	step6 = {
		tips = "详细的附加面效果在此详细查看",
		img = "paotuan_fujia6",
		mask = true,
		imgKuang = {
			{
				-280.4556,
				-33.03796,
				0,
				50,
				50
			},
			{
				218.9501,
				-19.57497,
				0,
				750,
				400
			}
		},
		leftHint = {
			{
				3.722839,
				-117.6696,
				0,
				"效果说明"
			}
		},
		rightHint = {}
	}
}

return configData
