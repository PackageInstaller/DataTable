-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URlovestory\\ResTalkBg.lua

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
	0,
	0,
	0
}
RT[2] = {
	10.60841,
	180.1929,
	5e-06
}
RT[3] = {
	-64.1,
	-9.279999,
	152.26
}
RT[4] = {
	0,
	300,
	0
}
RT[5] = {
	36.64819,
	98.73031,
	-0.000134
}
RT[6] = {
	-55.38965,
	-11.5,
	-62.33984
}
RT[7] = {
	-10000,
	-10000,
	-10000
}
RT[8] = {
	8.286565,
	345.3569,
	1.4e-05
}
RT[9] = {
	-228.72,
	143.55,
	1525.61
}
RT[10] = {
	100,
	100,
	100
}
RT[11] = {
	-59.27,
	-10,
	152.26
}

local Data = {
	[43801] = {
		[1] = 43801,
		[2] = 1,
		[3] = RT[1],
		[4] = RT[1]
	},
	[43802] = {
		43802,
		1,
		RT[2],
		RT[3],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[4]
	},
	[43805] = {
		43805,
		1,
		RT[2],
		RT[3],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[4]
	},
	[43810] = {
		43810,
		1050,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[7]
	},
	[43803] = {
		43803,
		1070,
		RT[8],
		RT[9],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[10]
	},
	[43811] = {
		43811,
		1,
		RT[2],
		RT[11],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[4]
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
