-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\wuhuang\\ResTalkBg.lua

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
	24.78823,
	83.46893,
	3.7e-05
}
RT[2] = {
	206.3719,
	581.1705,
	-43.54851
}
RT[3] = {
	65.35438,
	120.3728,
	-0.000385
}
RT[4] = {
	207.5706,
	585.0537,
	-46.34587
}
RT[5] = {
	22.38195,
	208.7233,
	-0.000195
}
RT[6] = {
	212.0837,
	581.0731,
	-44.28218
}
RT[7] = {
	22.38195,
	208.7233,
	-0.000195
}
RT[8] = {
	22.0391,
	233.475,
	-0.000228
}
RT[9] = {
	215.7415,
	582.1043,
	-44.65058
}
RT[10] = {
	26.68,
	196.0037,
	-0.000197
}
RT[11] = {
	213.1787,
	582.7267,
	-41.82858
}
RT[12] = {
	38.88415,
	277.9939,
	-0.000204
}
RT[13] = {
	216.9714,
	583.4168,
	-48.74631
}
RT[14] = {
	46.79103,
	198.0662,
	-0.000216
}
RT[15] = {
	216.3659,
	587.8616,
	-40.4296
}

local Data = {
	[32301] = {
		32301,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32302] = {
		32302,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32303] = {
		32303,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32304] = {
		32304,
		1,
		RT[7],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32305] = {
		32305,
		1,
		RT[8],
		RT[9],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32306] = {
		32306,
		1,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32307] = {
		32307,
		1,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[32308] = {
		32308,
		1,
		RT[14],
		RT[15],
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
