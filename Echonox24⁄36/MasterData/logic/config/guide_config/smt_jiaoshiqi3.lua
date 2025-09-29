-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/smt_jiaoshiqi3.lua

local configData = {
	step1 = {
		tips = "校时器的孔位可以镶嵌六面体来生效一个新的词条",
		img = "smt_jiaoshiqi7",
		mask = true,
		imgKuang = {
			{
				-6.637604,
				12.53548,
				0,
				191.31,
				70
			},
			{
				385.7184,
				-211.668,
				0,
				253,
				60
			}
		},
		leftHint = {
			{
				206.2597,
				-70.61224,
				0,
				"六面体孔位"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "在同一个校时器上相同图案的词条越多，对应词条的效果就会越强",
		img = "smt_jiaoshiqi6",
		mask = true,
		imgKuang = {
			{
				-0.7375183,
				12.53548,
				0,
				207.1,
				70
			},
			{
				-86.28879,
				-74.49089,
				0,
				70.6,
				70
			},
			{
				328.1926,
				-117.2666,
				0,
				218.3,
				40
			}
		},
		leftHint = {
			{
				206.2597,
				-72.08724,
				0,
				"强化后"
			},
			{
				185.6094,
				-162.0637,
				0,
				"菱形共鸣"
			},
			{
				529.2897,
				-203.3643,
				0,
				"原效果"
			}
		},
		rightHint = {}
	}
}

return configData
