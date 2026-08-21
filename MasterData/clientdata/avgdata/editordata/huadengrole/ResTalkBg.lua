-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\huadengrole\\ResTalkBg.lua

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
	5.707878,
	156.4169,
	-5e-06
}
RT[2] = {
	48.9148,
	11.12809,
	11.13546
}
RT[3] = {
	10.00506,
	190.7942,
	-8e-06
}
RT[4] = {
	254.3728,
	183.302,
	-0.331208
}
RT[5] = {
	8.973835,
	337.1385,
	-9e-06
}
RT[6] = {
	9.034621,
	11.23479,
	-46.32561
}
RT[7] = {
	2.95774,
	198.0818,
	2e-06
}
RT[8] = {
	31.94,
	-4.3,
	128.34
}
RT[9] = {
	1.239022,
	229.0893,
	-8e-06
}
RT[10] = {
	20.08,
	3.660004,
	18.35
}
RT[11] = {
	0,
	300,
	0
}
RT[12] = {
	3.98901,
	184.2267,
	-6e-06
}
RT[13] = {
	-61.74433,
	-10.62458,
	154.8149
}

local Data = {
	[25700] = {
		25700,
		3001,
		RT[1],
		RT[2],
		nil,
		nil,
		"ModelStage/AVGModelStage_chunjie"
	},
	[25710] = {
		25710,
		3001,
		RT[3],
		RT[4],
		nil,
		nil,
		"ModelStage/NewDisplayModelStage",
		[12] = 1,
		[13] = 0
	},
	[25720] = {
		25720,
		3001,
		RT[5],
		RT[6],
		nil,
		nil,
		"ModelStage/AvgModelstage_shiyanshi"
	},
	[25740] = {
		25740,
		3001,
		RT[7],
		RT[8],
		nil,
		nil,
		"ModelStage/AvgModelstage_kitchen"
	},
	[25750] = {
		25750,
		1060,
		RT[9],
		RT[10],
		nil,
		nil,
		"ModelStage/AVGModelStage_chunjie",
		RT[11]
	},
	[25730] = {
		25730,
		3001,
		RT[12],
		RT[13],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin_houzhai"
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
