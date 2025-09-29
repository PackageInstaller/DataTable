-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_weakness.lua

local configData = {
	step1 = {
		tips = "部分敌方单位拥有弱点",
		img = "battle_weakpoint1",
		mask = true,
		imgKuang = {
			{
				-27.3589,
				37.4441,
				0,
				227.9323,
				213.1013
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "受到伤害时，弱点值会等额削减；受到克制单位造成的伤害时，弱点值的削减量会增加",
		img = "battle_weakpoint2",
		mask = true,
		imgKuang = {
			{
				-48.3573,
				72.7727,
				0,
				305.3934,
				238.4652
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step3 = {
		tips = "当弱点条被削减为0时，该单位会陷入击破状态，此时单位受到的伤害翻倍，且无法行动一回合",
		img = "battle_weakpoint3",
		mask = true,
		imgKuang = {
			{
				-55.2578,
				0.9036,
				0,
				236.8257,
				247.6983
			}
		},
		leftHint = {
			{
				186,
				-24.5,
				0,
				"击破状态"
			}
		},
		rightHint = {}
	}
}

return configData
