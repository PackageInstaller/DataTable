-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\wuhuang\\ResTalk.lua

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
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[3] = {
	3,
	244,
	nil,
	nil,
	0
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 800
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 800
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 799,
	[3] = {
		2
	}
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 799
}
RTResTalkAction[10] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 800
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 799
}
RTResTalkAction[13] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 799,
	[3] = {
		3
	}
}
RTResTalkAction[15] = {
	1,
	244,
	nil,
	nil,
	3
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 800,
	[3] = {
		3
	}
}

local Data = {
	[32301001] = {
		32301001,
		0,
		Lang.get(80759),
		32301,
		1,
		800,
		nil,
		1,
		nil,
		nil,
		nil,
		24,
		32301,
		nil,
		nil,
		nil,
		nil,
		nil,
		32301
	},
	[32301002] = {
		32301002,
		0,
		Lang.get(80760),
		32301,
		2,
		800,
		nil,
		1
	},
	[32301003] = {
		32301003,
		0,
		Lang.get(80761),
		32301,
		3,
		800,
		nil,
		1
	},
	[32301004] = {
		32301004,
		0,
		Lang.get(80762),
		32301,
		4,
		799,
		nil,
		1
	},
	[32301005] = {
		32301005,
		0,
		Lang.get(80763),
		32301,
		5,
		799,
		nil,
		1
	},
	[32301006] = {
		32301006,
		0,
		Lang.get(80764),
		32301,
		6,
		799,
		nil,
		1
	},
	[32301007] = {
		32301007,
		0,
		Lang.get(80765),
		32301,
		7,
		800,
		nil,
		1
	},
	[32301008] = {
		32301008,
		0,
		Lang.get(80766),
		32301,
		8,
		799,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32302,
		[19] = 32302,
		[17] = 1
	},
	[32301009] = {
		32301009,
		0,
		Lang.get(80767),
		32301,
		9,
		800,
		nil,
		1
	},
	[32301010] = {
		32301010,
		0,
		Lang.get(80768),
		32301,
		10,
		799,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32303,
		[19] = 32303
	},
	[32301011] = {
		32301011,
		5,
		Lang.get(80769),
		32301,
		11,
		799,
		nil,
		1
	},
	[32301012] = {
		32301012,
		0,
		Lang.get(80770),
		32301,
		12,
		800,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32304,
		1
	},
	[32301013] = {
		32301013,
		0,
		Lang.get(80771),
		32301,
		13,
		244,
		nil,
		1
	},
	[32301014] = {
		32301014,
		0,
		Lang.get(80772),
		32301,
		14,
		244,
		nil,
		1,
		1
	},
	[32301015] = {
		32301015,
		0,
		Lang.get(80773),
		32301,
		15,
		244,
		nil,
		1,
		3
	},
	[32301016] = {
		32301016,
		5,
		Lang.get(80774),
		32301,
		16,
		800,
		nil,
		1
	},
	[32301017] = {
		32301017,
		5,
		Lang.get(80775),
		32301,
		17,
		799,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32305,
		[19] = 32305
	},
	[32301018] = {
		32301018,
		0,
		Lang.get(80776),
		32301,
		18,
		800,
		nil,
		1
	},
	[32301019] = {
		32301019,
		0,
		Lang.get(80777),
		32301,
		19,
		107,
		nil,
		1
	},
	[32301020] = {
		32301020,
		0,
		Lang.get(80778),
		32301,
		20,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		48,
		32306,
		1,
		1,
		nil,
		1,
		nil,
		32306
	},
	[32301021] = {
		32301021,
		0,
		Lang.get(80779),
		32301,
		21,
		244,
		nil,
		1,
		3
	},
	[32301022] = {
		32301022,
		0,
		Lang.get(80780),
		32301,
		22,
		800,
		nil,
		1
	},
	[32301023] = {
		32301023,
		0,
		Lang.get(80781),
		32301,
		23,
		799,
		nil,
		1
	},
	[32301024] = {
		32301024,
		0,
		Lang.get(80782),
		32301,
		24,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[32301025] = {
		32301025,
		0,
		Lang.get(80783),
		32301,
		25,
		244,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[32301026] = {
		32301026,
		0,
		Lang.get(80784),
		32301,
		26,
		800,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[32301027] = {
		32301027,
		0,
		Lang.get(80785),
		32301,
		27,
		799,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[32301028] = {
		32301028,
		0,
		Lang.get(80786),
		32301,
		28,
		800,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[32301029] = {
		32301029,
		0,
		Lang.get(80787),
		32301,
		29,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[32301030] = {
		32301030,
		0,
		Lang.get(80788),
		32301,
		30,
		799,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[32301031] = {
		32301031,
		0,
		Lang.get(80789),
		32301,
		31,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[32301032] = {
		32301032,
		0,
		"……！",
		32301,
		32,
		799,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[32301033] = {
		32301033,
		0,
		Lang.get(80790),
		32301,
		33,
		244,
		{
			RTResTalkAction[15],
			RTResTalkAction[12]
		}
	},
	[32301034] = {
		32301034,
		0,
		"！",
		32301,
		34,
		800,
		{
			RTResTalkAction[16],
			RTResTalkAction[6]
		}
	},
	[32301035] = {
		32301035,
		0,
		Lang.get(80791),
		32301,
		35,
		800,
		{
			RTResTalkAction[11]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32307,
		1,
		1,
		nil,
		nil,
		nil,
		32307
	},
	[32301036] = {
		32301036,
		3,
		Lang.get(80792),
		32301,
		36,
		605,
		[22] = 1
	},
	[32301037] = {
		32301037,
		0,
		Lang.get(80793),
		32301,
		37,
		799,
		nil,
		1
	},
	[32301038] = {
		32301038,
		0,
		Lang.get(80794),
		32301,
		38,
		799,
		nil,
		1
	},
	[32301039] = {
		32301039,
		0,
		Lang.get(80795),
		32301,
		39,
		800,
		nil,
		1
	},
	[32301040] = {
		32301040,
		0,
		Lang.get(80796),
		32301,
		40,
		107,
		nil,
		1
	},
	[32301041] = {
		32301041,
		0,
		Lang.get(80797),
		32301,
		41,
		799,
		nil,
		1
	},
	[32301042] = {
		32301042,
		0,
		Lang.get(80798),
		32301,
		42,
		244,
		nil,
		1,
		3
	},
	[32301043] = {
		32301043,
		0,
		Lang.get(80799),
		32301,
		43,
		107,
		nil,
		1
	},
	[32301044] = {
		32301044,
		3,
		Lang.get(80800),
		32301,
		44,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		32308,
		1,
		1,
		nil,
		1,
		nil,
		32308,
		200,
		nil,
		1
	},
	[32301045] = {
		32301045,
		3,
		Lang.get(80801),
		32301,
		45,
		605,
		[22] = 1,
		[20] = 245
	},
	[32302001] = {
		32302001,
		11,
		"Videos/AVG_wuhuang.mp4",
		32302,
		1,
		605
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
