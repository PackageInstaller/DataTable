-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023spring\\ResTalkBg.lua

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
	7.256798,
	0.907394,
	-0.000132
}
RT[2] = {
	-209.75,
	143.62,
	1545.27
}
RT[3] = {
	7.181323,
	114.948,
	-0.004415
}
RT[4] = {
	-252.12,
	145.97,
	1565.8
}
RT[5] = {
	17.2361,
	180.7037,
	0.551382
}
RT[6] = {
	-225.3,
	147.28,
	1533.13
}
RT[7] = {
	0,
	180,
	0
}
RT[8] = {
	250.48,
	183.1,
	30.95
}
RT[9] = {
	30.37325,
	268.5604,
	4.407681
}
RT[10] = {
	-223.481,
	146.119,
	1536.16
}
RT[11] = {
	100,
	100,
	100
}
RT[12] = {
	1.322868,
	271.9679,
	0.124045
}
RT[13] = {
	-230,
	143.05,
	1537.26
}
RT[14] = {
	11.66172,
	346.6642,
	359.6057
}
RT[15] = {
	-228.72,
	143.49,
	1525.6
}
RT[16] = {
	-233.007,
	146.813,
	1537.35
}
RT[17] = {
	12.56065,
	182.1004,
	0.51449
}
RT[18] = {
	49.879,
	12.201,
	16.544
}

local Data = {
	[36391] = {
		36391,
		3001,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai"
	},
	[36392] = {
		36392,
		3001,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai",
		nil,
		nil,
		nil,
		1
	},
	[36393] = {
		36393,
		3004,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai",
		nil,
		nil,
		nil,
		1,
		1,
		0
	},
	[36394] = {
		36394,
		2,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_Backhome.anim",
		nil,
		1,
		1,
		0
	},
	[36395] = {
		36395,
		1040,
		RT[9],
		RT[10],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[11],
		nil,
		nil,
		1
	},
	[36396] = {
		36396,
		3001,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[11]
	},
	[36397] = {
		36397,
		1070,
		RT[14],
		RT[15],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[11],
		nil,
		nil,
		1
	},
	[36398] = {
		36398,
		1050,
		RT[12],
		RT[16],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[11]
	},
	[36399] = {
		36399,
		3001,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai",
		nil,
		nil,
		nil,
		1
	},
	[36400] = {
		36400,
		1,
		RT[17],
		RT[18],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie"
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
