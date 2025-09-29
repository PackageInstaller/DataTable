-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_01.lua

local configData = {
	step1 = {
		tips = "在记忆世界完成目标可以获得奖励",
		img = "guide_editor_101",
		mask = true,
		imgKuang = {
			{
				-48.44522,
				117.8594,
				0,
				200,
				70
			},
			{
				316.6168,
				256.7365,
				0,
				330,
				50
			}
		},
		leftHint = {
			{
				459.5108,
				172.1335,
				0,
				"奖励货币"
			}
		},
		rightHint = {
			{
				517.8822,
				31.75932,
				0,
				"目标"
			}
		}
	},
	step2 = {
		tips = "货币可以在采购中兑换其他物品",
		img = "guide_editor_102",
		mask = true,
		imgKuang = {
			{
				199.8503,
				90.56889,
				0,
				400,
				240
			},
			{
				-193.8623,
				90.56889,
				0,
				400,
				240
			}
		},
		leftHint = {
			{
				-80.90842,
				4.468849,
				0,
				"其他物资"
			}
		},
		rightHint = {
			{
				856.2174,
				4.468849,
				0,
				"意识核心"
			}
		}
	}
}

return configData
