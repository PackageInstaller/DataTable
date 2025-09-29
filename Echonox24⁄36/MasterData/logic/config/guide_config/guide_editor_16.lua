-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_16.lua

local configData = {
	step1 = {
		tips = "附加面只在判定中生效",
		img = "paotuan_fujia2",
		mask = true,
		imgKuang = {
			{
				1.450043,
				112.375,
				0,
				310,
				200
			}
		},
		leftHint = {},
		rightHint = {
			{
				630.6001,
				21.925,
				0,
				"附加面总览"
			}
		}
	},
	step2 = {
		tips = "守秘人投掷瞬间附加面会随机附至骰子上的空白面",
		img = "paotuan_fujia3",
		mask = true,
		imgKuang = {
			{
				-151.2404,
				62.4051,
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
	step3 = {
		tips = "每回合中1个附加面会附加1次，切回合后大部分面会重置",
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
				-35.24045,
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
				479.4696,
				52.65946,
				0,
				"暂时失效"
			}
		}
	},
	step4 = {
		tips = "投掷结果为附加面时，生效附加面的独有效果",
		img = "paotuan_fujia5",
		mask = true,
		imgKuang = {
			{
				-46.98727,
				35.97471,
				0,
				80,
				80
			}
		},
		leftHint = {},
		rightHint = {
			{
				460.381,
				-50.12533,
				0,
				"附加面生效"
			}
		}
	},
	step5 = {
		tips = "详细的附加面效果在此详细查看",
		img = "paotuan_fujia7",
		mask = true,
		imgKuang = {
			{
				-252.5569,
				187.2152,
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
				25.74814,
				104.0519,
				0,
				"效果说明"
			}
		},
		rightHint = {}
	}
}

return configData
