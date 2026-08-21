-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\longnianqiandao\\ResTalk.lua

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
	[2] = 1299
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1298
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1299
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 1298
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1298
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 107
}

local Data = {
	[42501001] = {
		42501001,
		0,
		Lang.get(114034),
		42501,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42501,
		nil,
		1,
		nil,
		1,
		nil,
		42501
	},
	[42501002] = {
		42501002,
		0,
		Lang.get(114035),
		42501,
		2,
		1299,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[42501003] = {
		42501003,
		0,
		Lang.get(114036),
		42501,
		3,
		1298,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[42501004] = {
		42501004,
		0,
		Lang.get(114037),
		42501,
		4,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42501005] = {
		42501005,
		0,
		Lang.get(114038),
		42501,
		5,
		605,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[42501006] = {
		42501006,
		0,
		Lang.get(114039),
		42501,
		6,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42501007] = {
		42501007,
		0,
		Lang.get(114040),
		42501,
		7,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[42501008] = {
		42501008,
		0,
		Lang.get(114041),
		42501,
		8,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[42501009] = {
		42501009,
		0,
		Lang.get(114042),
		42501,
		9,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[42501010] = {
		42501010,
		0,
		Lang.get(114043),
		42501,
		10,
		1298,
		{
			RTResTalkAction[2],
			RTResTalkAction[6]
		}
	},
	[42501011] = {
		42501011,
		0,
		Lang.get(114044),
		42501,
		11,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42501012] = {
		42501012,
		0,
		Lang.get(114045),
		42501,
		12,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[42501013] = {
		42501013,
		0,
		Lang.get(114046),
		42501,
		13,
		1299,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[42501014] = {
		42501014,
		0,
		Lang.get(114047),
		42501,
		14,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42501015] = {
		42501015,
		0,
		Lang.get(114048),
		42501,
		15,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42501016] = {
		42501016,
		0,
		Lang.get(114049),
		42501,
		16,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42502001] = {
		42502001,
		0,
		Lang.get(114050),
		42502,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42502,
		nil,
		1,
		nil,
		1,
		nil,
		42502
	},
	[42502002] = {
		42502002,
		4,
		nil,
		42502,
		2,
		1298,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 42502003,
				branch_content = Lang.get(114051)
			},
			{
				id = 42502003,
				branch_content = Lang.get(114052)
			}
		}
	},
	[42502003] = {
		42502003,
		0,
		Lang.get(114053),
		42502,
		3,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502004] = {
		42502004,
		0,
		Lang.get(114054),
		42502,
		4,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502005] = {
		42502005,
		0,
		Lang.get(114055),
		42502,
		5,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502006] = {
		42502006,
		0,
		Lang.get(114056),
		42502,
		6,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502007] = {
		42502007,
		0,
		Lang.get(114057),
		42502,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[42502008] = {
		42502008,
		0,
		Lang.get(114058),
		42502,
		8,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502009] = {
		42502009,
		0,
		Lang.get(114059),
		42502,
		9,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502010] = {
		42502010,
		0,
		Lang.get(114060),
		42502,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[42502011] = {
		42502011,
		0,
		Lang.get(114061),
		42502,
		11,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502012] = {
		42502012,
		0,
		Lang.get(114062),
		42502,
		12,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502013] = {
		42502013,
		0,
		Lang.get(114063),
		42502,
		13,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[42502014] = {
		42502014,
		0,
		Lang.get(114064),
		42502,
		14,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502015] = {
		42502015,
		0,
		Lang.get(114065),
		42502,
		15,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42502016] = {
		42502016,
		0,
		Lang.get(114066),
		42502,
		16,
		1298,
		{
			RTResTalkAction[2]
		}
	},
	[42503001] = {
		42503001,
		0,
		Lang.get(114067),
		42503,
		1,
		1299,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42503,
		nil,
		1,
		nil,
		1,
		nil,
		42503
	},
	[42503002] = {
		42503002,
		4,
		nil,
		42503,
		2,
		1299,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 42503003,
				branch_content = Lang.get(114068)
			},
			{
				id = 42503003,
				branch_content = Lang.get(114069)
			}
		}
	},
	[42503003] = {
		42503003,
		0,
		Lang.get(114070),
		42503,
		3,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503004] = {
		42503004,
		0,
		Lang.get(114071),
		42503,
		4,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503005] = {
		42503005,
		0,
		Lang.get(114072),
		42503,
		5,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42503006] = {
		42503006,
		0,
		Lang.get(114073),
		42503,
		6,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503007] = {
		42503007,
		0,
		Lang.get(114074),
		42503,
		7,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503008] = {
		42503008,
		0,
		Lang.get(114075),
		42503,
		8,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42503009] = {
		42503009,
		0,
		Lang.get(114076),
		42503,
		9,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503010] = {
		42503010,
		0,
		Lang.get(114077),
		42503,
		10,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503011] = {
		42503011,
		0,
		Lang.get(114078),
		42503,
		11,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42503012] = {
		42503012,
		0,
		Lang.get(114079),
		42503,
		12,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[42503013] = {
		42503013,
		0,
		Lang.get(114080),
		42503,
		13,
		1299,
		{
			RTResTalkAction[1]
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
