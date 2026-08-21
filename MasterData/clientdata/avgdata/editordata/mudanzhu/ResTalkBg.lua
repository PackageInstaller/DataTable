-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\mudanzhu\\ResTalkBg.lua

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
	9.145805,
	159.4788,
	-1e-05
}
RT[2] = {
	17.765,
	-5.285,
	134.99
}
RT[3] = {
	0,
	0,
	0
}
RT[4] = {
	13.31871,
	152.9471,
	-2.9e-05
}
RT[5] = {
	-60.50195,
	-19.84766,
	-49.62891
}
RT[6] = {
	-10000,
	-10000,
	-10000
}
RT[7] = {
	19.23705,
	216.0297,
	2.7e-05
}
RT[8] = {
	-33.47559,
	-18.95605,
	-54.71191
}

local Data = {
	[38500] = {
		38500,
		3005,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen",
		RT[3]
	},
	[38501] = {
		38501,
		1,
		RT[4],
		RT[5],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[6],
		nil,
		nil,
		nil,
		nil,
		1
	},
	[38502] = {
		38502,
		1,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[6],
		nil,
		nil,
		nil,
		nil,
		1
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
