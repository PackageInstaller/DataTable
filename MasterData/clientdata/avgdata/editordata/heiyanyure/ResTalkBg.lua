-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\heiyanyure\\ResTalkBg.lua

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
	9.145645,
	180.1371,
	3e-06
}
RT[2] = {
	249.7822,
	184.3383,
	5.830549
}
RT[3] = {
	19.80256,
	160.1982,
	1e-05
}
RT[4] = {
	-69.96355,
	-7.653656,
	151.9775
}
RT[5] = {
	0,
	300,
	0
}
RT[6] = {
	13.7863,
	214.1711,
	5e-06
}
RT[7] = {
	259.117,
	184.9044,
	1.736041
}

local Data = {
	[32000] = {
		32000,
		2,
		RT[1],
		RT[2],
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
	[32001] = {
		32001,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[5]
	},
	[32002] = {
		32002,
		2,
		RT[6],
		RT[7],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
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
