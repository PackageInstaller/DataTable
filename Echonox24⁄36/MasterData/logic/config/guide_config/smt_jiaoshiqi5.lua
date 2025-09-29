-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/smt_jiaoshiqi5.lua

local configData = {
	step1 = {
		tips = "已经镶嵌的六面体可以通过重置再刷新生效的词条，其取决于六面体的投掷结果",
		img = "smt_jiaoshiqi6",
		mask = true,
		imgKuang = {
			{
				372.4433,
				-71.54085,
				0,
				283.1,
				190.1
			},
			{
				385.7184,
				-211.668,
				0,
				252.7,
				57.6
			},
			{
				-8.11264,
				12.53548,
				0,
				182.8,
				85.8
			}
		},
		leftHint = {
			{
				541.0898,
				-224.0146,
				0,
				"六个词条"
			},
			{
				212.1598,
				-73.56228,
				0,
				"生效词条"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "校时器上不能无限地进行重置，一件校时器只能进行30次",
		img = "smt_jiaoshiqi6",
		mask = true,
		imgKuang = {
			{
				-227.891,
				-213.143,
				0,
				164.5,
				50
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step3 = {
		tips = "校时器原生的词条不能进行重置，这是校时器的固有属性",
		img = "smt_jiaoshiqi6",
		mask = true,
		imgKuang = {
			{
				-21.38779,
				99.56182,
				0,
				210.2,
				70
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
