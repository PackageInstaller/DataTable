-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\DOAYURE\\ResTalkBg.lua

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
	10.96557,
	180.6568,
	-8.7e-05
}
RT[2] = {
	-165.632,
	59.28,
	1596.348
}
RT[3] = {
	17.27136,
	151.2323,
	1.316654
}
RT[4] = {
	-58.49,
	4.81,
	-80.93546
}
RT[5] = {
	5.948577,
	180.3553,
	0.000121
}
RT[6] = {
	48.7207,
	11.28,
	14.90979
}
RT[7] = {
	23.48088,
	167.1552,
	0.000116
}
RT[8] = {
	-174.0428,
	60.43771,
	1592.836
}
RT[9] = {
	20.21502,
	116.6204,
	0.000112
}
RT[10] = {
	-175.0799,
	60.39817,
	1590.53
}
RT[11] = {
	23.35153,
	155.2142,
	359.7601
}
RT[12] = {
	-56.06,
	5.42,
	-84.31
}
RT[13] = {
	23.30914,
	102.6971,
	0.000151
}
RT[14] = {
	40.47125,
	12.77243,
	14.91928
}
RT[15] = {
	9.558178,
	151.6696,
	0.000159
}
RT[16] = {
	4.19,
	3.587197,
	26.263
}

local Data = {
	[34900] = {
		34900,
		1,
		RT[1],
		RT[2],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20,
		"ModelStage/AVGModelStage_1207"
	},
	[34910] = {
		34910,
		1060,
		RT[3],
		RT[4],
		nil,
		60,
		[11] = 1
	},
	[34920] = {
		34920,
		1,
		RT[5],
		RT[6],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie",
		nil,
		nil,
		nil,
		1
	},
	[34901] = {
		34901,
		1,
		RT[7],
		RT[8],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34902] = {
		34902,
		1,
		RT[9],
		RT[10],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34911] = {
		34911,
		1060,
		RT[11],
		RT[12],
		nil,
		60,
		[11] = 1
	},
	[34921] = {
		34921,
		1,
		RT[5],
		RT[6],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie",
		nil,
		nil,
		nil,
		-1
	},
	[34922] = {
		34922,
		1,
		RT[13],
		RT[14],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie"
	},
	[34923] = {
		34923,
		1,
		RT[15],
		RT[16],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie"
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
