-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/smt_pt_002.lua

local configData = {
	step1 = {
		tips = "事件中守秘人可以投掷的骰子数量取决于事件所需属性和守秘人对应属性高低",
		img = "smt_pt_002",
		mask = true,
		imgKuang = {
			{
				-136.7735,
				113.4747,
				0,
				100,
				200
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "每一个骰子都有50%几率成功",
		img = "smt_pt_002",
		mask = true,
		imgKuang = {
			{
				-136.7735,
				113.4747,
				0,
				100,
				200
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step3 = {
		tips = "最终成功的骰子总数大于等于事件难度即判定成功",
		img = "smt_pt_002",
		mask = true,
		imgKuang = {
			{
				287.0742,
				39.82742,
				0,
				230.1,
				150
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
