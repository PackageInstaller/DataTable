-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_13.lua

local configData = {
	step1 = {
		tips = "多人事件的最终目的是击飞右侧全部的骰子",
		img = "paotuan_duoren1",
		mask = true,
		imgKuang = {
			{
				218.7849,
				24.22788,
				0,
				100,
				150
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "多人事件每一个守秘人都会投掷一次",
		img = "paotuan_duoren1",
		mask = true,
		imgKuang = {
			{
				-302.4809,
				49.18989,
				0,
				280,
				250
			}
		},
		leftHint = {},
		rightHint = {
			{
				304.7355,
				-42.78356,
				0,
				"依次投掷"
			}
		}
	},
	step3 = {
		tips = "轮到守秘人投掷时，会拿出数量和考验属性数值对应的骰子",
		img = "paotuan_danren8",
		mask = true,
		imgKuang = {
			{
				-532.5549,
				123.6289,
				0,
				127,
				330
			},
			{
				-168.2522,
				78.2739,
				0,
				100,
				170
			}
		},
		leftHint = {
			{
				88.50903,
				36.06577,
				0,
				"基础骰"
			}
		},
		rightHint = {
			{
				3.651367,
				110.682,
				0,
				"对应关系"
			}
		}
	},
	step4 = {
		tips = "每一个基础骰上都初始固定为3个考验属性图案、3个空白",
		img = "paotuan_danren9",
		mask = true,
		imgKuang = {
			{
				-1.462982,
				9.509956,
				0,
				350,
				180
			}
		},
		leftHint = {
			{
				130.9378,
				-79.51623,
				0,
				"图案分布"
			}
		},
		rightHint = {}
	},
	step5 = {
		tips = "投掷后结果为属性图案的骰子会撞飞1颗对应的骰子",
		img = "paotuan_danren4",
		mask = true,
		imgKuang = {
			{
				-5.852203,
				43.16041,
				0,
				400,
				200
			}
		},
		leftHint = {
			{
				97.28738,
				22.8982,
				0,
				"生效结果"
			}
		},
		rightHint = {}
	}
}

return configData
