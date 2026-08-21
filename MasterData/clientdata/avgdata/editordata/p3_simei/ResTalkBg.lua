-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_simei\\ResTalkBg.lua

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
	6.223695,
	87.49,
	-1.1e-05
}
RT[2] = {
	5.89,
	2.32,
	23.3
}
RT[3] = {
	0,
	180,
	0
}
RT[4] = {
	248.46,
	181.65,
	8.3
}
RT[5] = {
	12.92936,
	180.1929,
	5e-06
}
RT[6] = {
	-64.80952,
	-9.449585,
	149.249
}
RT[7] = {
	0,
	300,
	0
}

local Data = {
	[38801] = {
		38801,
		1,
		RT[1],
		RT[2],
		nil,
		20
	},
	[38802] = {
		38802,
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
	[38803] = {
		38803,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[7]
	},
	[38804] = {
		38804,
		1,
		RT[1],
		RT[2],
		nil,
		20
	},
	[38805] = {
		38805,
		1,
		RT[1],
		RT[2],
		nil,
		20
	},
	[38806] = {
		38806,
		1,
		RT[1],
		RT[2],
		nil,
		20
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
