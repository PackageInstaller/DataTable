-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_guozheng\\ResTalkBg.lua

local indexMap = {
	ui_anim = 14,
	dynamic_path = 5,
	bg_aspec_mode = 17,
	cam_anim = 9,
	is_loop = 19,
	video_path = 20,
	camera_data = 2,
	material_path = 18,
	main_menu_light = 13,
	extra_eff = 11,
	shadow_dist = 6,
	stage_reflect = 12,
	bg_effect = 10,
	bg_path = 16,
	camera_pos = 4,
	camera_rot = 3,
	ui_stage = 7,
	bg_color = 15,
	model_stage_pos = 8,
	id = 1
}
local RT = {}

RT[1] = {
	7.562982,
	169.4809,
	-7e-06
}
RT[2] = {
	38.80866,
	2.372579,
	11.99726
}
RT[3] = {
	13.57943,
	350.8907,
	-4e-06
}
RT[4] = {
	-228.5271,
	143.8122,
	1528.153
}
RT[5] = {
	100,
	100,
	100
}
RT[6] = {
	11.34452,
	70.81754,
	-1.5e-05
}
RT[7] = {
	-161.0318,
	145.4211,
	1507.62
}
RT[8] = {
	8.594358,
	132.3531,
	-6e-06
}
RT[9] = {
	362.6181,
	4221.441,
	122.9494
}
RT[10] = {
	19.93914,
	154.6338,
	-1e-05
}
RT[11] = {
	16.69604,
	-1.858674,
	133.0152
}
RT[12] = {
	10.14163,
	154.2901,
	-9e-06
}
RT[13] = {
	18.48499,
	-5.325219,
	132.6675
}
RT[14] = {
	0,
	0,
	0
}
RT[15] = {
	8.93804,
	164.0887,
	-6e-06
}
RT[16] = {
	370.9122,
	4225.257,
	122.63
}
RT[17] = {
	5.192227,
	178.2472,
	-3e-06
}
RT[18] = {
	-63.71589,
	-10.61112,
	147.0102
}
RT[19] = {
	6.567036,
	182.8872,
	-6e-06
}
RT[20] = {
	-203.7023,
	143.8279,
	1537.378
}
RT[21] = {
	13.27066,
	141.9785,
	2e-06
}
RT[22] = {
	370.3241,
	4225.859,
	121.1359
}

local Data = {
	[33401] = {
		33401,
		1060,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_chunjie"
	},
	[33402] = {
		33402,
		1070,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[5]
	},
	[33502] = {
		33502,
		1065,
		RT[6],
		RT[7],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin"
	},
	[33403] = {
		33403,
		1060,
		RT[8],
		RT[9],
		nil,
		90,
		"ModelStage/AVGModelStage_shop",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[33404] = {
		33404,
		2,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[33405] = {
		33405,
		3005,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen",
		RT[14]
	},
	[33406] = {
		33406,
		2070,
		RT[15],
		RT[16],
		nil,
		40,
		"ModelStage/AVGModelStage_shop"
	},
	[33407] = {
		33407,
		3001,
		RT[17],
		RT[18],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin_houzhai"
	},
	[33408] = {
		33408,
		3001,
		RT[19],
		RT[20],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai"
	},
	[33409] = {
		33409,
		2070,
		RT[21],
		RT[22],
		nil,
		40,
		"ModelStage/AVGModelStage_shop"
	}
}
local metaTable = {
	__index = function(table, key)
		local keyIndex = indexMap[key]

		if not keyIndex then
			return nil
		end

		return table[keyIndex]
	end
}

for k, v in pairs(Data) do
	setmetatable(v, metaTable)
end

return Data
