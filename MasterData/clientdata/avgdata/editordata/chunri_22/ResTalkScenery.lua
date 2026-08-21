-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\chunri_22\\ResTalkScenery.lua

local indexMap = {
	timeline_clear = 8,
	model_stage_pos = 3,
	clear_all_npc = 4,
	timeline_path = 5,
	id = 1,
	timeline_config = 7,
	timeline_config_str = 6,
	action = 2
}
local RT = {}

RT[1] = {
	0,
	357,
	0
}
RT[2] = {
	221.18,
	578.49,
	-55.24
}
RT[3] = {
	0,
	32,
	0
}
RT[4] = {
	218.86,
	578.49,
	-55.06
}
RT[5] = {
	0,
	35,
	0
}
RT[6] = {
	219.6826,
	578.49,
	-51.49065
}
RT[7] = {
	227.38,
	578.49,
	-35.1
}
RT[8] = {
	0,
	17,
	0
}
RT[9] = {
	225.3715,
	578.49,
	-34.37432
}
RT[10] = {
	0,
	165,
	0
}
RT[11] = {
	227.64,
	578.49,
	-29.39
}
RT[12] = {
	0,
	269,
	0
}
RT[13] = {
	227.5969,
	578.37,
	-32.14274
}
RT[14] = {
	0,
	306,
	0
}
RT[15] = {
	223.51,
	578.49,
	-32.81
}
RT[16] = {
	0,
	24,
	0
}
RT[17] = {
	220.5988,
	578.49,
	-32.77477
}
RT[18] = {
	0,
	271,
	0
}
RT[19] = {
	227.4134,
	578.49,
	-35.2266
}
RT[20] = {
	0,
	272,
	0
}
RT[21] = {
	225.5685,
	578.49,
	-34.38531
}
RT[22] = {
	0,
	152,
	0
}
RT[23] = {
	245.67,
	578.439,
	-1.94
}
RT[24] = {
	0,
	330,
	0
}
RT[25] = {
	250.28,
	578.439,
	-1.68
}
RT[26] = {
	359,
	301,
	359
}
RT[27] = {
	248.5071,
	578.439,
	-4.974616
}
RT[28] = {
	0,
	354,
	0
}
RT[29] = {
	250.3,
	578.439,
	-6.48
}
RT[30] = {
	0,
	338,
	0
}
RT[31] = {
	246.65,
	578.439,
	-7.32
}

local Data = {
	[30501] = {
		[1] = 30501,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Happy",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				npc_id = 20030,
				move_duration = 0,
				action = "Idle02",
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				npc_id = 21068,
				move_duration = 0,
				action = "Proud",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[30502] = {
		[1] = 30502,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Happy",
				show = 0,
				rotation = RT[1],
				pos = RT[7]
			},
			{
				npc_id = 20030,
				move_duration = 0,
				action = "Idle02",
				show = 0,
				rotation = RT[8],
				pos = RT[9]
			},
			{
				npc_id = 21068,
				move_duration = 0,
				action = "Proud",
				show = 0,
				rotation = RT[10],
				pos = RT[11]
			},
			{
				npc_id = 21069,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			}
		}
	},
	[30503] = {
		[1] = 30503,
		[2] = {
			{
				npc_id = 21068,
				move_duration = 0,
				action = "Proud",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				npc_id = 22067,
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			},
			{
				npc_id = 20020,
				action = "Happy",
				show = 0,
				rotation = RT[18],
				pos = RT[19]
			},
			{
				npc_id = 20030,
				action = "Idle02",
				show = 0,
				rotation = RT[20],
				pos = RT[21]
			}
		}
	},
	[30505] = {
		[1] = 30505,
		[2] = {
			{
				npc_id = 20030,
				move_duration = 0,
				action = "Idle02",
				show = 0,
				rotation = RT[22],
				pos = RT[23]
			},
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Happy",
				show = 0,
				rotation = RT[24],
				pos = RT[25]
			},
			{
				move_duration = 0,
				npc_id = 22067,
				action = "Special",
				scale = 1.5,
				show = 0,
				rotation = RT[26],
				pos = RT[27]
			},
			{
				move_duration = 0,
				npc_id = 21068,
				action = "Proud",
				scale = 1.5,
				show = 0,
				rotation = RT[28],
				pos = RT[29]
			},
			{
				move_duration = 0,
				npc_id = 21069,
				action = "Idle",
				scale = 1.5,
				show = 0,
				rotation = RT[30],
				pos = RT[31]
			}
		}
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
