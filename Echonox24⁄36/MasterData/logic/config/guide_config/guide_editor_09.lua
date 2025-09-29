-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_09.lua

local configData = {
	step1 = {
		tips = "贩卖机可以消耗熊熊币购买纪念品",
		img = "paotuan_fanmai1",
		mask = true,
		imgKuang = {
			{
				-32.83017,
				6.566093,
				0,
				650,
				50
			},
			{
				477.2153,
				259.1646,
				0,
				170,
				50
			},
			{
				-32.83017,
				-200.6289,
				0,
				650,
				50
			}
		},
		leftHint = {
			{
				693.8494,
				171.5962,
				0,
				"存量"
			}
		},
		rightHint = {
			{
				758.3276,
				-79.53394,
				0,
				"价格"
			}
		}
	},
	step2 = {
		tips = "任意一个贩卖机都会固定出售2种恢复纪念品",
		img = "paotuan_fanmai1",
		mask = true,
		imgKuang = {
			{
				-289.2657,
				-38.91137,
				0,
				127,
				400
			}
		},
		leftHint = {},
		rightHint = {
			{
				246.0013,
				-119.138,
				0,
				"恢复品"
			}
		}
	},
	step3 = {
		tips = "还会出售6种随机的纪念品",
		img = "paotuan_fanmai1",
		mask = true,
		imgKuang = {
			{
				64.93082,
				-29.9119,
				0,
				450,
				400
			}
		},
		leftHint = {
			{
				145.4974,
				-113.0937,
				0,
				"随机商品"
			}
		},
		rightHint = {}
	}
}

return configData
