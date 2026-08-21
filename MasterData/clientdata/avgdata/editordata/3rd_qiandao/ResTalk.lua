-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\3rd_qiandao\\ResTalk.lua

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
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[2] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[11] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[12] = {
	2,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[14] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[15] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[18] = {
	1,
	876,
	nil,
	nil,
	2
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 876
}
RTResTalkAction[21] = {
	1,
	876,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	1,
	876,
	nil,
	nil,
	5
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 876
}
RTResTalkAction[24] = {
	3,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[25] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[29] = {
	1,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	1,
	1071,
	nil,
	nil,
	0
}
RTResTalkAction[31] = {
	2,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[32] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 430
}

local Data = {
	[40302001] = {
		40302001,
		0,
		Lang.get(106518),
		40302,
		1,
		133,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		40302,
		nil,
		1,
		nil,
		1,
		nil,
		40302
	},
	[40302002] = {
		40302002,
		0,
		Lang.get(106519),
		40302,
		2,
		141,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[40302003] = {
		40302003,
		0,
		Lang.get(106520),
		40302,
		3,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[40302004] = {
		40302004,
		4,
		nil,
		40302,
		4,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 40302005,
				branch_content = Lang.get(106521)
			},
			{
				id = 40302005,
				branch_content = Lang.get(106522)
			}
		}
	},
	[40302005] = {
		40302005,
		0,
		Lang.get(106523),
		40302,
		5,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[40302006] = {
		40302006,
		0,
		Lang.get(106524),
		40302,
		6,
		133,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[40302007] = {
		40302007,
		0,
		Lang.get(106525),
		40302,
		7,
		141,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[40302008] = {
		40302008,
		0,
		Lang.get(106526),
		40302,
		8,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[40302009] = {
		40302009,
		0,
		Lang.get(106527),
		40302,
		9,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[40302010] = {
		40302010,
		0,
		Lang.get(106528),
		40302,
		10,
		605,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		40303,
		nil,
		1,
		[19] = 40303,
		[17] = 1
	},
	[40302011] = {
		40302011,
		0,
		Lang.get(106529),
		40302,
		11,
		107,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[40302012] = {
		40302012,
		0,
		Lang.get(106530),
		40302,
		12,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[40302013] = {
		40302013,
		0,
		Lang.get(106531),
		40302,
		13,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[40302014] = {
		40302014,
		0,
		Lang.get(106532),
		40302,
		14,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[40302015] = {
		40302015,
		0,
		Lang.get(106533),
		40302,
		15,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[40302016] = {
		40302016,
		0,
		Lang.get(106534),
		40302,
		16,
		107,
		{
			RTResTalkAction[16]
		}
	},
	[40302017] = {
		40302017,
		0,
		Lang.get(106535),
		40302,
		17,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[40302018] = {
		40302018,
		0,
		Lang.get(106536),
		40302,
		18,
		605
	},
	[40303001] = {
		40303001,
		0,
		Lang.get(106537),
		40303,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		40304,
		nil,
		1,
		nil,
		1,
		nil,
		40304
	},
	[40303002] = {
		40303002,
		0,
		Lang.get(106538),
		40303,
		2,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		[27] = 2
	},
	[40303003] = {
		40303003,
		13,
		Lang.get(106539),
		40303,
		3,
		876,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		},
		[27] = 3
	},
	[40303004] = {
		40303004,
		13,
		Lang.get(25688),
		40303,
		4,
		300,
		{
			RTResTalkAction[20]
		},
		[27] = 3
	},
	[40303005] = {
		40303005,
		13,
		Lang.get(106540),
		40303,
		5,
		876,
		{
			RTResTalkAction[20]
		},
		[27] = 3
	},
	[40303006] = {
		40303006,
		13,
		Lang.get(106541),
		40303,
		6,
		876,
		{
			RTResTalkAction[21]
		},
		[27] = 3
	},
	[40303007] = {
		40303007,
		13,
		Lang.get(106542),
		40303,
		7,
		107,
		{
			RTResTalkAction[20]
		},
		1,
		[27] = 3
	},
	[40303008] = {
		40303008,
		13,
		Lang.get(106543),
		40303,
		8,
		876,
		{
			RTResTalkAction[20]
		},
		[27] = 3
	},
	[40303009] = {
		40303009,
		13,
		Lang.get(106544),
		40303,
		9,
		300,
		{
			RTResTalkAction[20]
		},
		[27] = 3
	},
	[40303010] = {
		40303010,
		13,
		Lang.get(106545),
		40303,
		10,
		876,
		{
			RTResTalkAction[22]
		},
		[27] = 3
	},
	[40303011] = {
		40303011,
		0,
		Lang.get(106546),
		40303,
		11,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		40305,
		nil,
		1,
		[19] = 40305,
		[17] = 1
	},
	[40303012] = {
		40303012,
		0,
		Lang.get(106547),
		40303,
		12,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[40303013] = {
		40303013,
		0,
		Lang.get(106548),
		40303,
		13,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[24]
		}
	},
	[40303014] = {
		40303014,
		0,
		Lang.get(106549),
		40303,
		14,
		133,
		{
			RTResTalkAction[7],
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[40303015] = {
		40303015,
		4,
		nil,
		40303,
		15,
		133,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 40303016,
				branch_content = Lang.get(107102)
			},
			{
				id = 40303016,
				branch_content = Lang.get(107103)
			}
		}
	},
	[40303016] = {
		40303016,
		0,
		Lang.get(106551),
		40303,
		16,
		158,
		{
			RTResTalkAction[25]
		}
	},
	[40303017] = {
		40303017,
		0,
		Lang.get(106552),
		40303,
		17,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[26]
		}
	},
	[40303018] = {
		40303018,
		0,
		Lang.get(106553),
		40303,
		18,
		605,
		{
			RTResTalkAction[8]
		}
	},
	[40303019] = {
		40303019,
		0,
		Lang.get(106554),
		40303,
		19,
		300
	},
	[40304001] = {
		40304001,
		0,
		Lang.get(106555),
		40304,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		40306,
		nil,
		1,
		nil,
		1,
		nil,
		40306
	},
	[40304002] = {
		40304002,
		0,
		Lang.get(106556),
		40304,
		2,
		300
	},
	[40304003] = {
		40304003,
		0,
		Lang.get(106557),
		40304,
		3,
		1071,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[40304004] = {
		40304004,
		0,
		Lang.get(106558),
		40304,
		4,
		1071,
		{
			RTResTalkAction[27]
		}
	},
	[40304005] = {
		40304005,
		0,
		Lang.get(106559),
		40304,
		5,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[40304006] = {
		40304006,
		0,
		Lang.get(106560),
		40304,
		6,
		1071,
		{
			RTResTalkAction[29]
		}
	},
	[40304007] = {
		40304007,
		0,
		Lang.get(106561),
		40304,
		7,
		1071,
		{
			RTResTalkAction[27]
		}
	},
	[40304008] = {
		40304008,
		0,
		Lang.get(106562),
		40304,
		8,
		1071,
		{
			RTResTalkAction[27]
		}
	},
	[40304009] = {
		40304009,
		0,
		Lang.get(106563),
		40304,
		9,
		1071,
		{
			RTResTalkAction[30]
		}
	},
	[40304010] = {
		40304010,
		0,
		Lang.get(106564),
		40304,
		10,
		107,
		{
			RTResTalkAction[28]
		},
		1,
		10
	},
	[40304011] = {
		40304011,
		0,
		Lang.get(106209),
		40304,
		11,
		605,
		nil,
		nil,
		0,
		nil,
		nil,
		62,
		40307,
		nil,
		1,
		nil,
		1,
		nil,
		40307
	},
	[40304012] = {
		40304012,
		0,
		Lang.get(106565),
		40304,
		12,
		107,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[40304013] = {
		40304013,
		0,
		Lang.get(106566),
		40304,
		13,
		107,
		{
			RTResTalkAction[16]
		}
	},
	[40304014] = {
		40304014,
		4,
		nil,
		40304,
		14,
		107,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 40304015,
				branch_content = Lang.get(106567)
			},
			{
				id = 40304015,
				branch_content = Lang.get(106568)
			}
		}
	},
	[40304015] = {
		40304015,
		0,
		Lang.get(106569),
		40304,
		15,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[40304016] = {
		40304016,
		0,
		Lang.get(106570),
		40304,
		16,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[24]
		}
	},
	[40304017] = {
		40304017,
		0,
		Lang.get(106571),
		40304,
		17,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[3]
		}
	},
	[40304018] = {
		40304018,
		0,
		Lang.get(106572),
		40304,
		18,
		300,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[40304019] = {
		40304019,
		0,
		Lang.get(106573),
		40304,
		19,
		107,
		{
			RTResTalkAction[32]
		}
	},
	[40304020] = {
		40304020,
		0,
		Lang.get(106574),
		40304,
		20,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[40304021] = {
		40304021,
		0,
		Lang.get(106575),
		40304,
		21,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[40304022] = {
		40304022,
		0,
		Lang.get(106576),
		40304,
		22,
		107,
		{
			RTResTalkAction[8]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		40308,
		nil,
		1,
		nil,
		1,
		nil,
		40308
	},
	[40304023] = {
		40304023,
		0,
		Lang.get(106577),
		40304,
		23,
		300,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		[21] = 430
	},
	[40304024] = {
		40304024,
		0,
		Lang.get(106578),
		40304,
		24,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		[21] = 430
	},
	[40304025] = {
		40304025,
		0,
		Lang.get(106579),
		40304,
		25,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		[21] = 430
	},
	[40304026] = {
		40304026,
		4,
		nil,
		40304,
		26,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		[21] = 430,
		[29] = {
			{
				id = 40304027,
				branch_content = Lang.get(99428)
			},
			{
				id = 40304027,
				branch_content = Lang.get(106580)
			}
		}
	},
	[40304027] = {
		40304027,
		0,
		Lang.get(106581),
		40304,
		27,
		605,
		{
			RTResTalkAction[33]
		},
		[21] = 430
	},
	[40304028] = {
		40304028,
		0,
		Lang.get(106582),
		40304,
		28,
		605,
		{
			RTResTalkAction[33]
		},
		[21] = 430
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
