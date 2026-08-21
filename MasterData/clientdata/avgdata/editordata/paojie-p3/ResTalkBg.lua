-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojie-P3\\ResTalkBg.lua

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
	249.26,
	182.12,
	18.38
}

local Data = {
	[30600] = {
		30600,
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
	[30601] = {
		30601,
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
	[30602] = {
		30602,
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
	[30603] = {
		30603,
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
	[30604] = {
		30604,
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
	[30605] = {
		30605,
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
	[30606] = {
		30606,
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
