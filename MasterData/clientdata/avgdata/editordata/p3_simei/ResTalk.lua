-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_simei\\ResTalk.lua

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
	1258,
	{
		0
	},
	nil,
	1
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1258
}
RTResTalkAction[3] = {
	1,
	1258,
	nil,
	nil,
	2
}
RTResTalkAction[4] = {
	1,
	1258,
	nil,
	nil,
	1
}
RTResTalkAction[5] = {
	1,
	1258,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[6] = {
	1,
	1258,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1258
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 1297
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1297
}

local Data = {
	[38801001] = {
		38801001,
		0,
		Lang.get(102551),
		38801,
		1,
		1258,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		38801,
		nil,
		nil,
		nil,
		nil,
		nil,
		38801
	},
	[38801002] = {
		38801002,
		0,
		Lang.get(102552),
		38801,
		2,
		300
	},
	[38801003] = {
		38801003,
		0,
		Lang.get(102553),
		38801,
		3,
		1258,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[38801004] = {
		38801004,
		0,
		Lang.get(102554),
		38801,
		4,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38801005] = {
		38801005,
		0,
		"！",
		38801,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38801006] = {
		38801006,
		0,
		Lang.get(102555),
		38801,
		6,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38801007] = {
		38801007,
		0,
		Lang.get(102556),
		38801,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38801008] = {
		38801008,
		0,
		Lang.get(102557),
		38801,
		8,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38801009] = {
		38801009,
		0,
		Lang.get(102558),
		38801,
		9,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38801010] = {
		38801010,
		0,
		Lang.get(68572),
		38801,
		10,
		1258,
		{
			RTResTalkAction[3]
		}
	},
	[38801011] = {
		38801011,
		0,
		Lang.get(102559),
		38801,
		11,
		1258,
		{
			RTResTalkAction[4]
		}
	},
	[38801012] = {
		38801012,
		0,
		Lang.get(102560),
		38801,
		12,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38801013] = {
		38801013,
		0,
		Lang.get(102561),
		38801,
		13,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38802001] = {
		38802001,
		0,
		Lang.get(102562),
		38802,
		1,
		1258,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		38802,
		nil,
		nil,
		nil,
		nil,
		nil,
		38802
	},
	[38802002] = {
		38802002,
		0,
		Lang.get(102563),
		38802,
		2,
		300
	},
	[38802003] = {
		38802003,
		0,
		Lang.get(102564),
		38802,
		3,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38802004] = {
		38802004,
		0,
		Lang.get(102565),
		38802,
		4,
		1258,
		{
			RTResTalkAction[5]
		}
	},
	[38802005] = {
		38802005,
		0,
		Lang.get(102566),
		38802,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38802006] = {
		38802006,
		0,
		Lang.get(102567),
		38802,
		6,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38802007] = {
		38802007,
		0,
		Lang.get(102568),
		38802,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38802008] = {
		38802008,
		0,
		Lang.get(102569),
		38802,
		8,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38802009] = {
		38802009,
		0,
		Lang.get(102570),
		38802,
		9,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38802010] = {
		38802010,
		0,
		Lang.get(102571),
		38802,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38802011] = {
		38802011,
		0,
		Lang.get(102572),
		38802,
		11,
		1258,
		{
			RTResTalkAction[6]
		}
	},
	[38802012] = {
		38802012,
		0,
		Lang.get(102573),
		38802,
		12,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38802013] = {
		38802013,
		0,
		Lang.get(102574),
		38802,
		13,
		1258,
		{
			RTResTalkAction[4]
		}
	},
	[38802014] = {
		38802014,
		0,
		Lang.get(102575),
		38802,
		14,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803001] = {
		38803001,
		0,
		Lang.get(102576),
		38803,
		1,
		1258,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		38803,
		nil,
		nil,
		nil,
		nil,
		nil,
		38803
	},
	[38803002] = {
		38803002,
		0,
		Lang.get(102577),
		38803,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[38803003] = {
		38803003,
		0,
		Lang.get(102578),
		38803,
		3,
		300
	},
	[38803004] = {
		38803004,
		0,
		Lang.get(102579),
		38803,
		4,
		1258,
		{
			RTResTalkAction[5]
		}
	},
	[38803005] = {
		38803005,
		0,
		Lang.get(102580),
		38803,
		5,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803006] = {
		38803006,
		0,
		Lang.get(102581),
		38803,
		6,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803007] = {
		38803007,
		0,
		Lang.get(102582),
		38803,
		7,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[38803008] = {
		38803008,
		0,
		Lang.get(102583),
		38803,
		8,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803009] = {
		38803009,
		0,
		Lang.get(102584),
		38803,
		9,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[38803010] = {
		38803010,
		0,
		Lang.get(102585),
		38803,
		10,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803011] = {
		38803011,
		0,
		Lang.get(102586),
		38803,
		11,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803012] = {
		38803012,
		0,
		Lang.get(102587),
		38803,
		12,
		1258,
		{
			RTResTalkAction[2]
		}
	},
	[38803013] = {
		38803013,
		0,
		Lang.get(102588),
		38803,
		13,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[38804001] = {
		38804001,
		0,
		Lang.get(112612),
		38804,
		1,
		1297,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		38804,
		nil,
		nil,
		nil,
		nil,
		nil,
		38804,
		nil,
		nil,
		nil,
		1
	},
	[38804002] = {
		38804002,
		0,
		Lang.get(112613),
		38804,
		2,
		1297,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[38804003] = {
		38804003,
		0,
		Lang.get(112614),
		38804,
		3,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38804004] = {
		38804004,
		0,
		Lang.get(112615),
		38804,
		4,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804005] = {
		38804005,
		4,
		nil,
		38804,
		5,
		1297,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 38804006,
				branch_content = Lang.get(112616)
			},
			{
				id = 38804006,
				branch_content = Lang.get(112617)
			}
		}
	},
	[38804006] = {
		38804006,
		0,
		Lang.get(112618),
		38804,
		6,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804007] = {
		38804007,
		0,
		Lang.get(112619),
		38804,
		7,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804008] = {
		38804008,
		0,
		Lang.get(112620),
		38804,
		8,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38804009] = {
		38804009,
		0,
		Lang.get(112621),
		38804,
		9,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804010] = {
		38804010,
		0,
		Lang.get(112622),
		38804,
		10,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38804011] = {
		38804011,
		0,
		Lang.get(112623),
		38804,
		11,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804012] = {
		38804012,
		0,
		Lang.get(112624),
		38804,
		12,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38804013] = {
		38804013,
		0,
		Lang.get(112625),
		38804,
		13,
		300
	},
	[38804014] = {
		38804014,
		0,
		"？",
		38804,
		14,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804015] = {
		38804015,
		0,
		Lang.get(112626),
		38804,
		15,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804016] = {
		38804016,
		4,
		nil,
		38804,
		16,
		1297,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 38804017,
				branch_content = Lang.get(112627)
			},
			{
				id = 38804017,
				branch_content = Lang.get(112628)
			}
		}
	},
	[38804017] = {
		38804017,
		0,
		Lang.get(112629),
		38804,
		17,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804018] = {
		38804018,
		0,
		Lang.get(112630),
		38804,
		18,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38804019] = {
		38804019,
		0,
		Lang.get(112631),
		38804,
		19,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38804020] = {
		38804020,
		0,
		Lang.get(112632),
		38804,
		20,
		300
	},
	[38805001] = {
		38805001,
		0,
		Lang.get(112633),
		38805,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		38805,
		nil,
		1,
		nil,
		1,
		nil,
		38805
	},
	[38805002] = {
		38805002,
		0,
		Lang.get(112634),
		38805,
		2,
		300
	},
	[38805003] = {
		38805003,
		0,
		Lang.get(112635),
		38805,
		3,
		1297,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[38805004] = {
		38805004,
		0,
		Lang.get(112636),
		38805,
		4,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38805005] = {
		38805005,
		0,
		Lang.get(112637),
		38805,
		5,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805006] = {
		38805006,
		4,
		nil,
		38805,
		6,
		1297,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 38805007,
				branch_content = Lang.get(112638)
			},
			{
				id = 38805007,
				branch_content = Lang.get(112639)
			}
		}
	},
	[38805007] = {
		38805007,
		0,
		Lang.get(112640),
		38805,
		7,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805008] = {
		38805008,
		0,
		Lang.get(112641),
		38805,
		8,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38805009] = {
		38805009,
		0,
		Lang.get(112642),
		38805,
		9,
		300
	},
	[38805010] = {
		38805010,
		0,
		Lang.get(112643),
		38805,
		10,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805011] = {
		38805011,
		0,
		Lang.get(112644),
		38805,
		11,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805012] = {
		38805012,
		0,
		Lang.get(112645),
		38805,
		12,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805013] = {
		38805013,
		4,
		nil,
		38805,
		13,
		1297,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 38805014,
				branch_content = Lang.get(112646)
			},
			{
				id = 38805014,
				branch_content = Lang.get(112647)
			}
		}
	},
	[38805014] = {
		38805014,
		0,
		Lang.get(112648),
		38805,
		14,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805015] = {
		38805015,
		0,
		"……",
		38805,
		15,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38805016] = {
		38805016,
		0,
		Lang.get(112649),
		38805,
		16,
		300
	},
	[38805017] = {
		38805017,
		0,
		Lang.get(112650),
		38805,
		17,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38805018] = {
		38805018,
		0,
		Lang.get(112651),
		38805,
		18,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38805019] = {
		38805019,
		0,
		Lang.get(112652),
		38805,
		19,
		300
	},
	[38806001] = {
		38806001,
		0,
		Lang.get(112653),
		38806,
		1,
		1297,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		38806,
		nil,
		1,
		nil,
		1,
		nil,
		38806
	},
	[38806002] = {
		38806002,
		0,
		Lang.get(112654),
		38806,
		2,
		1297,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[38806003] = {
		38806003,
		4,
		nil,
		38806,
		3,
		1297,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 38806004,
				branch_content = Lang.get(112655)
			},
			{
				id = 38806004,
				branch_content = Lang.get(112656)
			}
		}
	},
	[38806004] = {
		38806004,
		0,
		Lang.get(112657),
		38806,
		4,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806005] = {
		38806005,
		0,
		Lang.get(112658),
		38806,
		5,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38806006] = {
		38806006,
		0,
		Lang.get(112659),
		38806,
		6,
		300
	},
	[38806007] = {
		38806007,
		0,
		Lang.get(112660),
		38806,
		7,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806008] = {
		38806008,
		0,
		Lang.get(112661),
		38806,
		8,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38806009] = {
		38806009,
		0,
		Lang.get(112662),
		38806,
		9,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806010] = {
		38806010,
		0,
		Lang.get(112663),
		38806,
		10,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38806011] = {
		38806011,
		0,
		Lang.get(112664),
		38806,
		11,
		300
	},
	[38806012] = {
		38806012,
		0,
		Lang.get(112665),
		38806,
		12,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806013] = {
		38806013,
		0,
		Lang.get(112666),
		38806,
		13,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38806014] = {
		38806014,
		0,
		Lang.get(112667),
		38806,
		14,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806015] = {
		38806015,
		0,
		Lang.get(112668),
		38806,
		15,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[38806016] = {
		38806016,
		0,
		Lang.get(112669),
		38806,
		16,
		1297,
		{
			RTResTalkAction[8]
		}
	},
	[38806017] = {
		38806017,
		0,
		Lang.get(112670),
		38806,
		17,
		1297,
		{
			RTResTalkAction[8]
		}
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
