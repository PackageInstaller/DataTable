-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojie-P3\\ResTalk.lua

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
	[2] = 750
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 750
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 752
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 752
}

local Data = {
	[30600001] = {
		30600001,
		0,
		Lang.get(67794),
		30600,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		30600,
		[19] = 30600
	},
	[30600002] = {
		30600002,
		0,
		Lang.get(22522),
		30600,
		2,
		750,
		nil,
		1
	},
	[30600003] = {
		30600003,
		0,
		Lang.get(67795),
		30600,
		3,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30600004] = {
		30600004,
		0,
		Lang.get(67796),
		30600,
		4,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30600005] = {
		30600005,
		0,
		Lang.get(67797),
		30600,
		5,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30600006] = {
		30600006,
		5,
		Lang.get(67798),
		30600,
		6,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30600007] = {
		30600007,
		0,
		Lang.get(67799),
		30600,
		7,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30600008] = {
		30600008,
		0,
		Lang.get(67800),
		30600,
		8,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30600009] = {
		30600009,
		0,
		Lang.get(67801),
		30600,
		9,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30600010] = {
		30600010,
		0,
		Lang.get(67802),
		30600,
		10,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30600011] = {
		30600011,
		0,
		Lang.get(67803),
		30600,
		11,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30600012] = {
		30600012,
		5,
		Lang.get(67804),
		30600,
		12,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30600013] = {
		30600013,
		0,
		Lang.get(67805),
		30600,
		13,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30600014] = {
		30600014,
		0,
		Lang.get(67806),
		30600,
		14,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30610001] = {
		30610001,
		0,
		Lang.get(67807),
		30610,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		30601,
		[19] = 30601
	},
	[30610002] = {
		30610002,
		0,
		Lang.get(67808),
		30610,
		2,
		750,
		nil,
		1
	},
	[30610003] = {
		30610003,
		0,
		Lang.get(67809),
		30610,
		3,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30610004] = {
		30610004,
		0,
		Lang.get(67810),
		30610,
		4,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30610005] = {
		30610005,
		0,
		Lang.get(67811),
		30610,
		5,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30610006] = {
		30610006,
		0,
		Lang.get(67812),
		30610,
		6,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30610007] = {
		30610007,
		0,
		Lang.get(67813),
		30610,
		7,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30610008] = {
		30610008,
		5,
		Lang.get(67814),
		30610,
		8,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30610009] = {
		30610009,
		0,
		Lang.get(67815),
		30610,
		9,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30610010] = {
		30610010,
		5,
		Lang.get(67816),
		30610,
		10,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30610011] = {
		30610011,
		0,
		Lang.get(67817),
		30610,
		11,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620001] = {
		30620001,
		0,
		Lang.get(67818),
		30620,
		1,
		750,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		30602,
		nil,
		nil,
		nil,
		nil,
		nil,
		30602
	},
	[30620002] = {
		30620002,
		0,
		Lang.get(67819),
		30620,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30620003] = {
		30620003,
		0,
		Lang.get(67820),
		30620,
		3,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620004] = {
		30620004,
		0,
		Lang.get(67821),
		30620,
		4,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30620005] = {
		30620005,
		0,
		Lang.get(67822),
		30620,
		5,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620006] = {
		30620006,
		0,
		Lang.get(67823),
		30620,
		6,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620007] = {
		30620007,
		0,
		Lang.get(67824),
		30620,
		7,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620008] = {
		30620008,
		0,
		Lang.get(67825),
		30620,
		8,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30620009] = {
		30620009,
		0,
		Lang.get(67826),
		30620,
		9,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30620010] = {
		30620010,
		0,
		Lang.get(67827),
		30620,
		10,
		750,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30630001] = {
		30630001,
		0,
		Lang.get(67828),
		30630,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		30603,
		[19] = 30603
	},
	[30630002] = {
		30630002,
		0,
		Lang.get(67829),
		30630,
		2,
		752,
		nil,
		1
	},
	[30630003] = {
		30630003,
		0,
		Lang.get(67830),
		30630,
		3,
		752,
		nil,
		1
	},
	[30630004] = {
		30630004,
		0,
		Lang.get(67831),
		30630,
		4,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30606,
		[19] = 30606
	},
	[30630005] = {
		30630005,
		0,
		Lang.get(67832),
		30630,
		5,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30630006] = {
		30630006,
		0,
		Lang.get(67833),
		30630,
		6,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30630007] = {
		30630007,
		0,
		Lang.get(67834),
		30630,
		7,
		300,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30630008] = {
		30630008,
		0,
		Lang.get(67835),
		30630,
		8,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30630009] = {
		30630009,
		0,
		Lang.get(67836),
		30630,
		9,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30630010] = {
		30630010,
		0,
		Lang.get(67837),
		30630,
		10,
		300,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30630011] = {
		30630011,
		0,
		Lang.get(67838),
		30630,
		11,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30630012] = {
		30630012,
		5,
		Lang.get(67839),
		30630,
		12,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30640001] = {
		30640001,
		0,
		Lang.get(67840),
		30640,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		30604,
		[19] = 30604
	},
	[30640002] = {
		30640002,
		0,
		Lang.get(67841),
		30640,
		2,
		300
	},
	[30640003] = {
		30640003,
		0,
		Lang.get(67842),
		30640,
		3,
		752,
		nil,
		1
	},
	[30640004] = {
		30640004,
		0,
		Lang.get(67843),
		30640,
		4,
		752,
		nil,
		1
	},
	[30640005] = {
		30640005,
		0,
		Lang.get(67844),
		30640,
		5,
		752,
		nil,
		1
	},
	[30640006] = {
		30640006,
		0,
		Lang.get(67845),
		30640,
		6,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30640007] = {
		30640007,
		0,
		Lang.get(67846),
		30640,
		7,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30640008] = {
		30640008,
		0,
		Lang.get(67847),
		30640,
		8,
		300,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30640009] = {
		30640009,
		5,
		Lang.get(67848),
		30640,
		9,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30640010] = {
		30640010,
		0,
		Lang.get(67849),
		30640,
		10,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30650001] = {
		30650001,
		0,
		Lang.get(67850),
		30650,
		1,
		752,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		30605,
		nil,
		nil,
		nil,
		nil,
		nil,
		30605
	},
	[30650002] = {
		30650002,
		0,
		Lang.get(67851),
		30650,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[30650003] = {
		30650003,
		0,
		Lang.get(67852),
		30650,
		3,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30650004] = {
		30650004,
		0,
		Lang.get(67853),
		30650,
		4,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30650005] = {
		30650005,
		0,
		Lang.get(67854),
		30650,
		5,
		300,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30650006] = {
		30650006,
		0,
		Lang.get(67855),
		30650,
		6,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30650007] = {
		30650007,
		0,
		Lang.get(67856),
		30650,
		7,
		300,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30650008] = {
		30650008,
		0,
		Lang.get(67857),
		30650,
		8,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[30650009] = {
		30650009,
		0,
		Lang.get(67858),
		30650,
		9,
		752,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
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
