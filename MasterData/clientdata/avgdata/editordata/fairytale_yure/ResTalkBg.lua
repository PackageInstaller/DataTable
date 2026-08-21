-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\FairyTale_yure\\ResTalkBg.lua

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
	182.62,
	21.16
}
RT[3] = {
	7.58,
	180,
	0
}
RT[4] = {
	-68.74,
	-10.5,
	158.19
}
RT[5] = {
	6.397363,
	144.2789,
	-0.000218
}
RT[6] = {
	-216.95,
	111.82,
	1583.67
}

local Data = {
	[42921] = {
		42921,
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
	[42922] = {
		42922,
		1,
		RT[3],
		RT[4],
		nil,
		30,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[42923] = {
		42923,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"0"
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
