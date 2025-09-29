-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_17.lua

local configData = {
	step1 = {
		tips = "花费一定的熊熊币可以获得一次丢骰机会",
		img = "paotuan_youxi1",
		mask = true,
		imgKuang = {
			{
				313.2001,
				-166.025,
				0,
				250,
				120
			},
			{
				-150.8,
				22.47504,
				0,
				570,
				400
			}
		},
		leftHint = {},
		rightHint = {
			{
				605.9501,
				-67.975,
				0,
				"掉落区域"
			}
		}
	},
	step2 = {
		tips = "落入下方指定区域，即可获得区域内的纪念品",
		img = "paotuan_youxi1",
		mask = true,
		imgKuang = {
			{
				-152.25,
				-181.975,
				0,
				570,
				70
			}
		},
		leftHint = {},
		rightHint = {
			{
				595.8,
				-269.525,
				0,
				"底部奖励"
			}
		}
	},
	step3 = {
		tips = "当下方四个纪念品都被获取，即可解锁大奖",
		img = "paotuan_youxi1",
		mask = true,
		imgKuang = {
			{
				308.8502,
				39.87504,
				0,
				120,
				120
			}
		},
		leftHint = {
			{
				561,
				-47.67501,
				0,
				"纪念品大奖"
			}
		},
		rightHint = {}
	}
}

return configData
