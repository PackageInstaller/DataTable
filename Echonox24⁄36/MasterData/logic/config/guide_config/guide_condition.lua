-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_condition.lua

local configData = {
	step1 = {
		tips = "在战场中满足某些条件下，单位释放的异能会发生改变",
		img = "battle_condition_jingzhun",
		mask = true,
		imgKuang = {
			{
				-153.1482,
				-15.0579,
				0,
				242.9539,
				330.0283
			}
		},
		leftHint = {},
		rightHint = {
			{
				451.85,
				0,
				0,
				"精准：以最大射程攻击目标"
			}
		}
	},
	step2 = {
		tips = "在战斗中满足特定状态，从而使释放的异能得到强化",
		img = "battle_condition_benxi",
		mask = true,
		imgKuang = {
			{
				-29.89079,
				-76.86886,
				0,
				269.2791,
				276.7634
			}
		},
		leftHint = {},
		rightHint = {
			{
				574.3,
				-114,
				0,
				"奔袭：主动攻击前移动3格以上"
			}
		}
	}
}

return configData
