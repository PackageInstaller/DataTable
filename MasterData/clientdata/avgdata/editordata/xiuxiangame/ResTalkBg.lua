-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\xiuxiangame\\ResTalkBg.lua

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
	8.360003,
	177.5,
	0.34
}
RT[2] = {
	134.27,
	4217.93,
	150.12
}
RT[3] = {
	5.000038,
	205,
	2.859988
}
RT[4] = {
	398.51,
	4233.63,
	110.72
}
RT[5] = {
	16.67,
	135.58,
	0.090018
}
RT[6] = {
	365.18,
	4213,
	134.2
}
RT[7] = {
	0,
	0,
	0
}
RT[8] = {
	28.36001,
	177.5,
	0.339999
}
RT[9] = {
	191.27,
	4210,
	85.12
}
RT[10] = {
	18.29,
	157.27,
	2e-06
}
RT[11] = {
	385.81,
	4215.88,
	113.11
}
RT[12] = {
	0,
	180,
	0
}
RT[13] = {
	249,
	183.1,
	27.8
}
RT[14] = {
	8.262223,
	155.9921,
	359.3852
}
RT[15] = {
	-68.08008,
	-20.16992,
	-51.26953
}
RT[16] = {
	-10000,
	-10000,
	-10000
}
RT[17] = {
	8.07035,
	343.4971,
	359.0203
}
RT[18] = {
	-228.73,
	144.46,
	1523.08
}
RT[19] = {
	100,
	100,
	100
}
RT[20] = {
	0,
	180,
	0
}

local Data = {
	[37401] = {
		37401,
		2070,
		RT[1],
		RT[2],
		nil,
		40,
		"ModelStage/AVGModelStage_1207",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_6001.anim",
		nil,
		nil,
		1,
		0
	},
	[37402] = {
		37402,
		1,
		RT[3],
		RT[4],
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
	[37403] = {
		37403,
		2070,
		RT[5],
		RT[6],
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
	[37404] = {
		[1] = 37404,
		[3] = RT[7],
		[4] = RT[7]
	},
	[37405] = {
		37405,
		2070,
		RT[8],
		RT[9],
		nil,
		40,
		"ModelStage/AVGModelStage_1207",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_6001.anim",
		nil,
		nil,
		1,
		0
	},
	[37406] = {
		37406,
		1,
		RT[10],
		RT[11],
		nil,
		40,
		"ModelStage/AVGModelStage_shop",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[37407] = {
		37407,
		2,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_Backhome.anim",
		nil,
		nil,
		1,
		0
	},
	[37408] = {
		37408,
		1060,
		RT[14],
		RT[15],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[16],
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37409] = {
		37409,
		1070,
		RT[17],
		RT[18],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[19]
	},
	[37410] = {
		37410,
		1055,
		RT[14],
		RT[15],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[16],
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37411] = {
		37411,
		2,
		RT[20],
		RT[13],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_Backhome.anim",
		nil,
		nil,
		1,
		0
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
