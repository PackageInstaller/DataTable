-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye_yure\\ResTalkBg.lua

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
	21.78002,
	36.63,
	-7e-06
}
RT[2] = {
	-180.67,
	108.69,
	1571.04
}
RT[3] = {
	24.27921,
	184.6995,
	2.771559
}
RT[4] = {
	-232,
	145.82,
	1534.33
}

local Data = {
	[35027] = {
		35027,
		1,
		RT[1],
		RT[2],
		nil,
		20
	},
	[35028] = {
		35028,
		3004,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai",
		nil,
		nil,
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
