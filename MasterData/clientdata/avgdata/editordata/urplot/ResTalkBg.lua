-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URplot\\ResTalkBg.lua

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
	250.62,
	181.78,
	12.51
}
RT[3] = {
	4.073766,
	190.758,
	359.7193
}
RT[4] = {
	3.28,
	16.02,
	-135.8
}
RT[5] = {
	14.95517,
	143.3712,
	358.8059
}
RT[6] = {
	79.03859,
	14.85,
	-188.72
}
RT[7] = {
	6.321281,
	247.9071,
	359.3185
}
RT[8] = {
	0.289993,
	1.529999,
	-3.289993
}
RT[9] = {
	110.66,
	57.7,
	-218.5
}
RT[10] = {
	16.80004,
	143.9701,
	-2e-06
}
RT[11] = {
	158.5,
	159.34,
	49.4
}
RT[12] = {
	359.6266,
	127.7361,
	359.9938
}
RT[13] = {
	71.6,
	5.9,
	-176.5
}
RT[14] = {
	2.959911,
	129.9547,
	1.112306
}
RT[15] = {
	18.69,
	6.04,
	49.9
}
RT[16] = {
	5.948577,
	180.3553,
	0.000121
}
RT[17] = {
	48.7207,
	11.28003,
	14.90979
}
RT[18] = {
	0,
	600,
	0
}

local Data = {
	[43400] = {
		43400,
		2,
		RT[1],
		RT[2],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
		nil,
		1,
		0
	},
	[43401] = {
		43401,
		1060,
		RT[3],
		RT[4],
		nil,
		30
	},
	[43402] = {
		[1] = 43402,
		[2] = 1050,
		[3] = RT[5],
		[4] = RT[6]
	},
	[43403] = {
		43403,
		1060,
		RT[3],
		RT[4],
		nil,
		30
	},
	[43405] = {
		43405,
		1040,
		RT[7],
		RT[8],
		nil,
		nil,
		"ModelStage/avg_ms_xiaoqiao",
		RT[9],
		[11] = -1
	},
	[43406] = {
		43406,
		1060,
		RT[10],
		RT[11],
		nil,
		nil,
		"0"
	},
	[43407] = {
		[1] = 43407,
		[2] = 1045,
		[3] = RT[12],
		[4] = RT[13]
	},
	[43404] = {
		43404,
		1060,
		RT[14],
		RT[15],
		nil,
		30
	},
	[43408] = {
		43408,
		1,
		RT[16],
		RT[17],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie",
		RT[18],
		nil,
		nil,
		-1
	},
	[43409] = {
		43409,
		2,
		RT[1],
		RT[2],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
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
