-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResOpActTower.lua

local RT = {}

RT[1] = {
	1,
	2,
	7,
	8,
	13,
	14,
	19,
	21
}
RT[2] = {
	3,
	4,
	9,
	10,
	15,
	16,
	20,
	21
}
RT[3] = {
	5,
	6,
	11,
	12,
	17,
	18,
	21
}

local Data = {
	[1302] = {
		{
			group_limit = 1,
			mini_count = 2,
			type = 1,
			id = 1,
			detail_id = 1302,
			desc = Lang.get(36740),
			limit_desc = Lang.get(36740),
			name = Lang.get(2606)
		},
		{
			group_limit = 2,
			mini_count = 2,
			type = 1,
			id = 2,
			detail_id = 1302,
			desc = Lang.get(36741),
			limit_desc = Lang.get(36741),
			name = Lang.get(8850)
		},
		{
			group_limit = 3,
			mini_count = 2,
			type = 1,
			id = 3,
			detail_id = 1302,
			desc = Lang.get(36742),
			limit_desc = Lang.get(36742),
			name = Lang.get(4499)
		},
		{
			group_limit = 4,
			mini_count = 2,
			type = 1,
			id = 4,
			detail_id = 1302,
			desc = Lang.get(36743),
			limit_desc = Lang.get(36743),
			name = Lang.get(4502)
		},
		{
			group_limit = 5,
			mini_count = 2,
			type = 1,
			id = 5,
			detail_id = 1302,
			desc = Lang.get(36744),
			limit_desc = Lang.get(36744),
			name = Lang.get(4504)
		},
		{
			group_limit = 6,
			mini_count = 2,
			type = 1,
			id = 6,
			detail_id = 1302,
			desc = Lang.get(36745),
			limit_desc = Lang.get(36745),
			name = Lang.get(4506)
		},
		[101] = {
			detail_id = 1302,
			type = 2,
			id = 101,
			day_limit = RT[1],
			name = Lang.get(8855)
		},
		[102] = {
			detail_id = 1302,
			type = 2,
			id = 102,
			day_limit = RT[2],
			name = Lang.get(8856)
		},
		[103] = {
			detail_id = 1302,
			type = 2,
			id = 103,
			day_limit = RT[3],
			name = Lang.get(8857)
		}
	},
	[1305] = {
		[101] = {
			detail_id = 1305,
			type = 2,
			id = 101,
			day_limit = RT[1],
			name = Lang.get(8855)
		},
		[102] = {
			detail_id = 1305,
			type = 2,
			id = 102,
			day_limit = RT[2],
			name = Lang.get(8856)
		},
		[103] = {
			detail_id = 1305,
			type = 2,
			id = 103,
			day_limit = RT[3],
			name = Lang.get(8857)
		}
	}
}

return Data
