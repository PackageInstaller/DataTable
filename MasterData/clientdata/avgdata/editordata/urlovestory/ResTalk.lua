-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URlovestory\\ResTalk.lua

local indexMap = {
	id = 1,
	npc_id = 6,
	bg_blur = 10,
	play_delay = 14,
	scenery_id = 13,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 18,
	terminal_type = 27,
	extra_npc = 21,
	hide_name = 22,
	talk_in_ani = 24,
	terminal_effect = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 17,
	font_size = 23,
	terminal_bg = 26,
	bg_id = 19,
	mask_alpha = 20,
	special_effect = 28,
	talk = 3,
	branch_info = 29,
	switch_effect = 16,
	show_head = 8
}
local indexMapResTalkAction = {
	emoji = 5,
	pos = 1,
	action = 3,
	npc_id = 2,
	show = 4
}
local RTResTalkAction = {}

RTResTalkAction[1] = {
	[1] = 1,
	[2] = 1307,
	[3] = {
		2
	}
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1307
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1307
}

local Data = {
	[43801001] = {
		43801001,
		0,
		"|101|……",
		43801,
		1,
		1309,
		nil,
		1,
		0,
		nil,
		nil,
		8,
		43801,
		nil,
		nil,
		nil,
		nil,
		nil,
		43801,
		255
	},
	[43801002] = {
		43801002,
		0,
		Lang.get(118112),
		43801,
		2,
		1309,
		nil,
		1
	},
	[43801003] = {
		43801003,
		3,
		Lang.get(118113),
		43801,
		3,
		605,
		[22] = 1
	},
	[43801004] = {
		43801004,
		4,
		nil,
		43801,
		4,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		43802,
		[19] = 43802,
		[20] = 0,
		[29] = {
			{
				id = 43801005,
				branch_content = "……？"
			},
			{
				id = 43801005,
				branch_content = Lang.get(11617)
			}
		}
	},
	[43801005] = {
		43801005,
		0,
		Lang.get(118114),
		43801,
		5,
		1307,
		{
			RTResTalkAction[1]
		}
	},
	[43801006] = {
		43801006,
		4,
		nil,
		43801,
		6,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 43801007,
				branch_content = Lang.get(64783)
			},
			{
				id = 43801007,
				branch_content = Lang.get(118115)
			}
		}
	},
	[43801007] = {
		43801007,
		0,
		Lang.get(118116),
		43801,
		7,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801008] = {
		43801008,
		3,
		Lang.get(85710),
		43801,
		8,
		605,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		nil,
		14,
		43803,
		1,
		1,
		nil,
		1,
		nil,
		43803,
		nil,
		nil,
		1
	},
	[43801009] = {
		43801009,
		0,
		Lang.get(118117),
		43801,
		9,
		1307,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[43801010] = {
		43801010,
		4,
		nil,
		43801,
		10,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43801011,
				branch_content = Lang.get(24462)
			},
			{
				id = 43801011,
				branch_content = Lang.get(118118)
			}
		}
	},
	[43801011] = {
		43801011,
		0,
		Lang.get(118119),
		43801,
		11,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801012] = {
		43801012,
		0,
		Lang.get(118120),
		43801,
		12,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801013] = {
		43801013,
		3,
		Lang.get(118121),
		43801,
		13,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[43801014] = {
		43801014,
		0,
		Lang.get(118122),
		43801,
		14,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801015] = {
		43801015,
		4,
		nil,
		43801,
		15,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43801016,
				branch_content = Lang.get(118123)
			}
		}
	},
	[43801016] = {
		43801016,
		0,
		Lang.get(118124),
		43801,
		16,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801017] = {
		43801017,
		4,
		nil,
		43801,
		17,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43801018,
				branch_content = Lang.get(118125)
			}
		}
	},
	[43801018] = {
		43801018,
		0,
		Lang.get(118126),
		43801,
		18,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43801019] = {
		43801019,
		4,
		nil,
		43801,
		19,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43801020,
				branch_content = Lang.get(118127)
			},
			{
				id = 43801020,
				branch_content = Lang.get(118128)
			}
		}
	},
	[43801020] = {
		43801020,
		3,
		Lang.get(118129),
		43801,
		20,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[43802001] = {
		43802001,
		3,
		Lang.get(118130),
		43802,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		8,
		43805,
		[19] = 43805,
		[22] = 1
	},
	[43802002] = {
		43802002,
		3,
		Lang.get(118131),
		43802,
		2,
		605,
		[22] = 1,
		[20] = 250
	},
	[43802003] = {
		43802003,
		4,
		nil,
		43802,
		3,
		300,
		[29] = {
			{
				id = 43802004,
				branch_content = Lang.get(118132)
			},
			{
				id = 43802004,
				branch_content = Lang.get(118133)
			}
		}
	},
	[43802004] = {
		43802004,
		3,
		"……",
		43802,
		4,
		605,
		[22] = 1
	},
	[43802005] = {
		43802005,
		3,
		Lang.get(118134),
		43802,
		5,
		605,
		[22] = 1
	},
	[43802006] = {
		43802006,
		4,
		nil,
		43802,
		6,
		300,
		[29] = {
			{
				id = 43802007,
				branch_content = Lang.get(118135)
			}
		}
	},
	[43802007] = {
		43802007,
		0,
		Lang.get(118136),
		43802,
		7,
		1307,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[43802008] = {
		43802008,
		4,
		nil,
		43802,
		8,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43802009,
				branch_content = Lang.get(118137)
			}
		}
	},
	[43802009] = {
		43802009,
		0,
		Lang.get(118138),
		43802,
		9,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43802010] = {
		43802010,
		0,
		Lang.get(118139),
		43802,
		10,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43802011] = {
		43802011,
		0,
		Lang.get(118140),
		43802,
		11,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[43802012] = {
		43802012,
		0,
		Lang.get(118141),
		43802,
		12,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43802013] = {
		43802013,
		4,
		nil,
		43802,
		13,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43802014,
				branch_content = Lang.get(118142)
			}
		}
	},
	[43802014] = {
		43802014,
		0,
		Lang.get(118143),
		43802,
		14,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43802015] = {
		43802015,
		0,
		Lang.get(118144),
		43802,
		15,
		1307,
		{
			RTResTalkAction[1]
		}
	},
	[43802016] = {
		43802016,
		0,
		"……",
		43802,
		16,
		1307,
		{
			RTResTalkAction[2]
		},
		1,
		0
	},
	[43802017] = {
		43802017,
		4,
		nil,
		43802,
		17,
		300,
		[29] = {
			{
				id = 43802018,
				branch_content = Lang.get(118145)
			},
			{
				id = 43802018,
				branch_content = Lang.get(118146)
			}
		}
	},
	[43802018] = {
		43802018,
		3,
		Lang.get(118147),
		43802,
		18,
		605,
		[22] = 1
	},
	[43802019] = {
		43802019,
		3,
		Lang.get(118148),
		43802,
		19,
		605,
		[22] = 1
	},
	[43803001] = {
		43803001,
		3,
		Lang.get(118149),
		43803,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		213,
		43810,
		[19] = 43810,
		[22] = 1
	},
	[43803002] = {
		43803002,
		0,
		Lang.get(118150),
		43803,
		2,
		1307,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43803003] = {
		43803003,
		4,
		nil,
		43803,
		3,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43803004,
				branch_content = Lang.get(118151)
			},
			{
				id = 43803004,
				branch_content = Lang.get(118152)
			}
		}
	},
	[43803004] = {
		43803004,
		0,
		Lang.get(118153),
		43803,
		4,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803005] = {
		43803005,
		0,
		Lang.get(118154),
		43803,
		5,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803006] = {
		43803006,
		3,
		Lang.get(118155),
		43803,
		6,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[43803007] = {
		43803007,
		0,
		Lang.get(118156),
		43803,
		7,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803008] = {
		43803008,
		0,
		Lang.get(118157),
		43803,
		8,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803009] = {
		43803009,
		3,
		Lang.get(118158),
		43803,
		9,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[43803010] = {
		43803010,
		0,
		Lang.get(118159),
		43803,
		10,
		1307,
		{
			RTResTalkAction[1]
		}
	},
	[43803011] = {
		43803011,
		3,
		Lang.get(118160),
		43803,
		11,
		605,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43811,
		1,
		1,
		nil,
		1,
		nil,
		43811,
		nil,
		nil,
		1
	},
	[43803012] = {
		43803012,
		0,
		Lang.get(118161),
		43803,
		12,
		1307,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43803013] = {
		43803013,
		0,
		Lang.get(118162),
		43803,
		13,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803014] = {
		43803014,
		4,
		nil,
		43803,
		14,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43803015,
				branch_content = Lang.get(118163)
			},
			{
				id = 43803015,
				branch_content = Lang.get(118164)
			}
		}
	},
	[43803015] = {
		43803015,
		0,
		Lang.get(118165),
		43803,
		15,
		1307,
		{
			RTResTalkAction[1]
		}
	},
	[43803016] = {
		43803016,
		4,
		nil,
		43803,
		16,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 43803017,
				branch_content = Lang.get(22381)
			}
		}
	},
	[43803017] = {
		43803017,
		0,
		Lang.get(118166),
		43803,
		17,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803018] = {
		43803018,
		0,
		Lang.get(118167),
		43803,
		18,
		1307,
		{
			RTResTalkAction[3]
		}
	},
	[43803019] = {
		43803019,
		3,
		Lang.get(118168),
		43803,
		19,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	}
}
local metaTableResTalkAction = {
	__index = function(table, key)
		local keyIndexRT = indexMapResTalkAction[key]

		if not keyIndexRT then
			return nil
		end

		return table[keyIndexRT]
	end
}

for k, v in pairs(RTResTalkAction) do
	setmetatable(v, metaTableResTalkAction)
end

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
