-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2022shengdan\\ResTalkBg.lua

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
	16.15762,
	206.3723,
	2.8e-05
}
RT[2] = {
	391.1192,
	4213.794,
	105.601
}
RT[3] = {
	22.51738,
	267.9078,
	-1.3e-05
}
RT[4] = {
	397.6859,
	4214.525,
	99.60068
}
RT[5] = {
	15.29827,
	224.5921,
	-4e-06
}
RT[6] = {
	393.3368,
	4213.988,
	103.8465
}
RT[7] = {
	5.844389,
	116.303,
	-1.6e-05
}
RT[8] = {
	392.6499,
	4213.056,
	106.2557
}
RT[9] = {
	0,
	0,
	0
}

local Data = {
	[34601] = {
		34601,
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
	[34602] = {
		34602,
		2070,
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
	[34603] = {
		34603,
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
	[34604] = {
		34604,
		2070,
		RT[7],
		RT[8],
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
	[34605] = {
		[1] = 34605,
		[2] = 2070,
		[3] = RT[9],
		[4] = RT[9]
	},
	[34606] = {
		[1] = 34606,
		[2] = 2070,
		[3] = RT[9],
		[4] = RT[9]
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
