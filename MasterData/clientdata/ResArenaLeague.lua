-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResArenaLeague.lua

local RT = {}

RT[1] = {
	1,
	30,
	30
}
RT[2] = {
	1,
	25,
	30
}
RT[3] = {
	1,
	20,
	30
}

local Data = {
	{
		challenge_limit = 8,
		dan_low_limit = 26,
		award = 98851,
		lvup_dan = 99,
		challenge_times = 4,
		dan_high_limit = 35,
		init_score = 6000,
		league = 1,
		lvup_stage = {
			1,
			99,
			30
		},
		name = Lang.get(2733),
		need_stage = RT[1]
	},
	{
		challenge_limit = 6,
		dan_low_limit = 17,
		award = 98852,
		lvup_dan = 24,
		challenge_times = 3,
		dan_high_limit = 25,
		init_score = 4200,
		league = 2,
		lvup_stage = RT[1],
		name = Lang.get(2734),
		need_stage = RT[2]
	},
	{
		challenge_limit = 5,
		dan_low_limit = 9,
		award = 98853,
		lvup_dan = 15,
		challenge_times = 2,
		dan_high_limit = 16,
		init_score = 2600,
		league = 3,
		lvup_stage = RT[2],
		name = Lang.get(2735),
		need_stage = RT[3]
	},
	{
		challenge_limit = 5,
		dan_low_limit = 1,
		award = 98854,
		lvup_dan = 7,
		challenge_times = 2,
		dan_high_limit = 8,
		init_score = 1000,
		league = 4,
		lvup_stage = RT[3],
		name = Lang.get(2736),
		need_stage = {
			1,
			15,
			30
		}
	}
}

return Data
