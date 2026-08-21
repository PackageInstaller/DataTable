-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\sweethome_yure\\ResTalkBg.lua

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
	249,
	181.6,
	19.89
}
RT[3] = {
	358.0181,
	121.2923,
	359.5922
}
RT[4] = {
	-1.93,
	2,
	75.46
}
RT[5] = {
	21.52392,
	318.4753,
	8.8e-05
}
RT[6] = {
	6.833297,
	4.903979,
	64.79117
}

local Data = {
	[31501] = {
		31501,
		2,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_Backhome.anim",
		nil,
		nil,
		1,
		0
	},
	[31502] = {
		31502,
		2,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		"Camera/CameraCurvy/Stage/AVG_camera_Backhome.anim",
		nil,
		nil,
		1,
		0
	},
	[31503] = {
		31503,
		1,
		RT[3],
		RT[4],
		nil,
		0
	},
	[31504] = {
		31504,
		1,
		RT[5],
		RT[6],
		nil,
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
