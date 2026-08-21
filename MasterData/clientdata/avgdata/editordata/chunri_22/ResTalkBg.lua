-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\chunri_22\\ResTalkBg.lua

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
	12.88176,
	211.3055,
	0.799489
}
RT[2] = {
	222.86,
	581.35,
	-47.42
}
RT[3] = {
	28.73515,
	118.1225,
	0.00017
}
RT[4] = {
	220.31,
	583.9792,
	-28.41
}
RT[5] = {
	5.883429,
	176.3277,
	-5.5e-05
}
RT[6] = {
	247.77,
	580.54,
	5.02
}
RT[7] = {
	24.95364,
	169.1731,
	0.000181
}
RT[8] = {
	220.3915,
	583.247,
	-25.29299
}

local Data = {
	[30501] = {
		30501,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[30502] = {
		30502,
		1045,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[30504] = {
		30504,
		1050,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[30503] = {
		30503,
		1045,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AVGModelStage"
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
