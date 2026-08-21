-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Christmas2021\\ResTalkBg.lua

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
	0.894945,
	154.1824,
	0
}
RT[2] = {
	379.2184,
	4212.413,
	142.3744
}
RT[3] = {
	1.335808,
	112.5972,
	0.178051
}
RT[4] = {
	387.1559,
	4212.682,
	104.1168
}
RT[5] = {
	0,
	0,
	0
}
RT[6] = {
	0.894936,
	154.1824,
	0
}
RT[7] = {
	378.6578,
	4212.433,
	143.5331
}
RT[8] = {
	0.894961,
	154.1824,
	0
}

local Data = {
	[25800] = {
		25800,
		2070,
		RT[1],
		RT[2],
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
	[25801] = {
		25801,
		1060,
		RT[3],
		RT[4],
		nil,
		nil,
		"ModelStage/AVGModelStage_shop",
		[12] = 0,
		[13] = 0
	},
	[25802] = {
		25802,
		1,
		RT[5],
		RT[5],
		[16] = "NoAlpha/PlayerGuide/Story/Long013"
	},
	[25810] = {
		25810,
		1055,
		RT[6],
		RT[7],
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
	[25811] = {
		25811,
		1,
		RT[5],
		RT[5],
		[16] = "NoAlpha/PlayerGuide/Story/Long013"
	},
	[25820] = {
		25820,
		1055,
		RT[8],
		RT[7],
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
	[25821] = {
		25821,
		1,
		RT[5],
		RT[5],
		[16] = "NoAlpha/PlayerGuide/Story/Long013"
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
