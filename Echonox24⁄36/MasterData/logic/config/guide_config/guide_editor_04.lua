-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_04.lua

local configData = {
	step1 = {
		tips = "点击任意板块移动；若板块未探索，则会消耗队员理智",
		img = "guide_editor_401",
		mask = true,
		imgKuang = {
			{
				3.051758e-05,
				25.69624,
				0,
				90,
				160
			},
			{
				142.4305,
				25.69624,
				0,
				160,
				160
			},
			{
				-478.6835,
				-50.6582,
				0,
				50,
				350
			}
		},
		leftHint = {},
		rightHint = {
			{
				693.8494,
				-60.4038,
				0,
				"板块"
			}
		}
	},
	step2 = {
		tips = "任何时候都可以查看状态、执行操作",
		img = "guide_editor_401",
		mask = true,
		imgKuang = {
			{
				-508.0506,
				-12.48098,
				0,
				127,
				485
			},
			{
				525.671,
				93.24052,
				0,
				100,
				200
			},
			{
				527.1393,
				244.481,
				0,
				100,
				70
			}
		},
		leftHint = {
			{
				777.5457,
				4.203773,
				0,
				"额外操作"
			},
			{
				784.8875,
				159.8493,
				0,
				"退出按钮"
			}
		},
		rightHint = {
			{
				24.27979,
				-97.11266,
				0,
				"状态栏"
			}
		}
	},
	step3 = {
		tips = "撤退会放弃当前进度，失去所有纪念品和熊熊币",
		img = "guide_editor_403",
		mask = true,
		imgKuang = {
			{
				-139.4936,
				-116.7342,
				0,
				240,
				70
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step4 = {
		tips = "保存并退出后探索进度和状态全部都会被保留",
		img = "guide_editor_403",
		mask = true,
		imgKuang = {
			{
				145.3671,
				-118.2025,
				0,
				240,
				70
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
