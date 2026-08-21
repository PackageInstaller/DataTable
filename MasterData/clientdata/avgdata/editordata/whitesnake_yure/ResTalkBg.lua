-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\WhiteSnake_yure\\ResTalkBg.lua

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
	180,
	0
}
RT[2] = {
	249.97,
	182.89,
	21.84
}
RT[3] = {
	16.38538,
	180,
	0
}
RT[4] = {
	251.42,
	186.98,
	19.1
}
RT[5] = {
	12.88176,
	211.3055,
	0.799489
}
RT[6] = {
	223.69,
	581.34,
	-47.92
}
RT[7] = {
	26.501,
	209.9148,
	0.000236
}
RT[8] = {
	213.38,
	583.68,
	-52.04
}
RT[9] = {
	5.883429,
	176.3277,
	-5.5e-05
}
RT[10] = {
	248.98,
	580.41,
	1.61
}

local Data = {
	[35901] = {
		35901,
		2,
		RT[1],
		RT[2],
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
	[35902] = {
		35902,
		2,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[35903] = {
		35903,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[35904] = {
		35904,
		1,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[35905] = {
		35905,
		1060,
		RT[9],
		RT[10],
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
