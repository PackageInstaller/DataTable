-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\100days_J\\ResTalkBg.lua

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
	0,
	0
}
RT[2] = {
	2.785964,
	186.3253,
	2.6e-05
}
RT[3] = {
	253.5676,
	182.1865,
	8.38
}
RT[4] = {
	4.161977,
	65.79607,
	4.7e-05
}
RT[5] = {
	178.144,
	162.448,
	10.254
}
RT[6] = {
	358.0181,
	121.2923,
	359.5922
}
RT[7] = {
	-3.13,
	2,
	75.3
}
RT[8] = {
	11.55222,
	201.2796,
	2.2e-05
}
RT[9] = {
	33.44995,
	5.469971,
	39.18005
}
RT[10] = {
	1000,
	1000,
	1000
}
RT[11] = {
	359.8638,
	137.6812,
	8e-06
}
RT[12] = {
	-0.468276,
	1.464987,
	77.60652
}

local Data = {
	[22500] = {
		22500,
		1055,
		RT[1],
		RT[1],
		[16] = "NoAlpha/PlayerGuide/Story/102"
	},
	[22501] = {
		22501,
		1060,
		RT[2],
		RT[3],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		nil,
		nil,
		1
	},
	[22502] = {
		22502,
		1050,
		RT[4],
		RT[5],
		nil,
		40,
		"0",
		[19] = 0
	},
	[22503] = {
		22503,
		1,
		RT[6],
		RT[7],
		nil,
		0,
		[19] = 0
	},
	[22505] = {
		22505,
		1055,
		RT[8],
		RT[9],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie",
		RT[10],
		[19] = 0
	},
	[22504] = {
		22504,
		1,
		RT[11],
		RT[12],
		nil,
		0,
		[19] = 0
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
