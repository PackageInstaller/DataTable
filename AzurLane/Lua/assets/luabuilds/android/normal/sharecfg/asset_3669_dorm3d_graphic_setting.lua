pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_graphic_setting") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_graphic_setting"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_graphic_setting = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_graphic_setting

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm3d_graphic_setting = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_graphic_setting

	var_1_0[1] = {
		parentSetting = 0,
		displayType = 1,
		id = 1,
		dispaySelectName = "",
		settingName = "允许GPGPU",
		isShow = 1
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_graphic_setting

	var_1_1[2] = {
		parentSetting = 0,
		displayType = 1,
		id = 2,
		dispaySelectName = "",
		settingName = "高精度渲染",
		isShow = 1
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_graphic_setting

	var_1_2[3] = {
		parentSetting = 0,
		displayType = 2,
		id = 3,
		settingName = "绘制深度",
		isShow = 1,
		dispaySelectName = {
			"自动",
			"强制启用"
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_graphic_setting

	var_1_3[4] = {
		parentSetting = 0,
		displayType = 2,
		id = 4,
		settingName = "着色器精度",
		isShow = 1,
		dispaySelectName = {
			"低",
			"中",
			"高"
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_graphic_setting

	var_1_4[5] = {
		parentSetting = 0,
		displayType = 2,
		id = 5,
		settingName = "硬件抗锯齿",
		isShow = 1,
		dispaySelectName = {
			"None",
			"MSAA 2x",
			"MSAA 4x",
			"MSAA 8x"
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_graphic_setting

	var_1_5[6] = {
		parentSetting = 0,
		displayType = 2,
		id = 6,
		settingName = "最大分辨率",
		isShow = 1,
		dispaySelectName = {
			"720P",
			"900P",
			"1080P",
			"2k"
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_graphic_setting

	var_1_6[7] = {
		parentSetting = 0,
		displayType = 2,
		id = 7,
		settingName = "场景分辨率",
		isShow = 0,
		dispaySelectName = {
			"Full",
			"90%",
			"80%",
			"70%",
			"60%",
			"50%",
			"40%",
			"30%",
			"20%",
			"10%"
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_graphic_setting

	var_1_7[8] = {
		parentSetting = 0,
		displayType = 2,
		id = 8,
		settingName = "场景最低分辨率",
		isShow = 0,
		dispaySelectName = {
			"360P",
			"540P",
			"720P"
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_graphic_setting

	var_1_8[9] = {
		parentSetting = 0,
		displayType = 2,
		id = 9,
		settingName = "贴图分辨率",
		isShow = 0,
		dispaySelectName = {
			"低",
			"中",
			"高",
			"最高"
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_graphic_setting

	var_1_9[10] = {
		parentSetting = 0,
		displayType = 2,
		id = 10,
		settingName = "静态阴影",
		isShow = 0,
		dispaySelectName = {
			"禁用",
			"静态硬阴影",
			"静态软阴影"
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_graphic_setting

	var_1_10[11] = {
		parentSetting = 0,
		displayType = 1,
		id = 11,
		dispaySelectName = "",
		settingName = "实时阴影",
		isShow = 1
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_graphic_setting

	var_1_11[12] = {
		parentSetting = 0,
		displayType = 1,
		id = 12,
		dispaySelectName = "",
		settingName = "反射",
		isShow = 1
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_graphic_setting

	var_1_12[13] = {
		parentSetting = 0,
		displayType = 1,
		id = 13,
		dispaySelectName = "",
		settingName = "多光源",
		isShow = 1
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_graphic_setting

	var_1_13[14] = {
		parentSetting = 0,
		displayType = 1,
		id = 14,
		dispaySelectName = "",
		settingName = "角色描边",
		isShow = 1
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.dorm3d_graphic_setting

	var_1_14[15] = {
		parentSetting = 0,
		displayType = 2,
		id = 15,
		settingName = "后处理",
		isShow = 1,
		dispaySelectName = {
			"关",
			"开",
			"高品质"
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.dorm3d_graphic_setting

	var_1_15[16] = {
		parentSetting = 15,
		displayType = 1,
		id = 16,
		dispaySelectName = "",
		settingName = "抗锯齿",
		isShow = 1
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.dorm3d_graphic_setting

	var_1_16[17] = {
		parentSetting = 15,
		displayType = 1,
		id = 17,
		dispaySelectName = "",
		settingName = "HDR",
		isShow = 1
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.dorm3d_graphic_setting

	var_1_17[18] = {
		parentSetting = 15,
		displayType = 1,
		id = 18,
		dispaySelectName = "",
		settingName = "景深",
		isShow = 1
	}
	pg = var_1_17
	var_1_17.base.dorm3d_graphic_setting[19] = {
		parentSetting = 15,
		displayType = 1,
		id = 19,
		dispaySelectName = "",
		settingName = "扭曲",
		isShow = 1
	}

	return
end)()

return
