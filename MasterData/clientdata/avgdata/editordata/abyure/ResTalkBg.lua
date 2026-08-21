-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\abyure\\ResTalkBg.lua

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
	66.70158,
	203.0414,
	351.2006
}
RT[2] = {
	-211.168,
	-255.156,
	-220.258
}
RT[3] = {
	83.80571,
	241.0152,
	337.4643
}
RT[4] = {
	-210.59,
	-252.72,
	-220.47
}
RT[5] = {
	343.1463,
	259.4093,
	5e-05
}
RT[6] = {
	-189.65,
	-250.43,
	-215.66
}
RT[7] = {
	7.57384,
	310.1161,
	5.7e-05
}
RT[8] = {
	-207.95,
	-254.68,
	-222.67
}
RT[9] = {
	3.302598,
	334.5241,
	5.5e-05
}
RT[10] = {
	-213.82,
	-254.52,
	-216.16
}
RT[11] = {
	12.41264,
	296.1931,
	4.4e-05
}
RT[12] = {
	-207.1,
	-254.48,
	-220.36
}
RT[13] = {
	16.28605,
	268.9033,
	359.2315
}
RT[14] = {
	-209.41,
	-252.5,
	-218.95
}
RT[15] = {
	14.99732,
	307.897,
	0.589972
}
RT[16] = {
	-210.49,
	-252.522,
	-221.63
}
RT[17] = {
	16.66247,
	233.7978,
	5.2e-05
}
RT[18] = {
	-226.28,
	-249.37,
	-239.3
}
RT[19] = {
	2.271405,
	230.3602,
	6.7e-05
}
RT[20] = {
	-217.56,
	-245.78,
	-224.69
}
RT[21] = {
	0,
	0,
	0
}
RT[22] = {
	0.552546,
	130.5615,
	6.7e-05
}
RT[23] = {
	-83.97,
	1.860001,
	22.2
}
RT[24] = {
	200,
	200,
	200
}
RT[25] = {
	-85.73,
	1.880005,
	23.69
}

local Data = {
	[36901] = {
		36901,
		1016,
		RT[1],
		RT[2],
		nil,
		20
	},
	[36902] = {
		36902,
		1040,
		RT[3],
		RT[4],
		nil,
		20
	},
	[36903] = {
		36903,
		1060,
		RT[5],
		RT[6],
		nil,
		20
	},
	[36904] = {
		36904,
		1060,
		RT[7],
		RT[8],
		nil,
		20
	},
	[36905] = {
		36905,
		1050,
		RT[9],
		RT[10],
		nil,
		20
	},
	[36906] = {
		36906,
		1060,
		RT[11],
		RT[12],
		nil,
		20
	},
	[36910] = {
		36910,
		1050,
		RT[13],
		RT[14],
		nil,
		20
	},
	[36911] = {
		36911,
		1050,
		RT[15],
		RT[16],
		nil,
		20
	},
	[36912] = {
		36912,
		1050,
		RT[15],
		RT[16],
		nil,
		20
	},
	[36913] = {
		36913,
		1060,
		RT[17],
		RT[18],
		nil,
		20
	},
	[36914] = {
		[1] = 36914,
		[2] = 1060,
		[3] = RT[19],
		[4] = RT[20]
	},
	[36920] = {
		36920,
		1050,
		RT[21],
		RT[21],
		[16] = "NoAlpha/PlayerGuide/Story/L036",
		[17] = 1
	},
	[36921] = {
		36921,
		1060,
		RT[22],
		RT[23],
		nil,
		20,
		"ModelStage/AvgModelstage_xiangzi",
		RT[24]
	},
	[36922] = {
		36922,
		1060,
		RT[22],
		RT[25],
		nil,
		20,
		"ModelStage/AvgModelstage_xiangzi",
		RT[24]
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
