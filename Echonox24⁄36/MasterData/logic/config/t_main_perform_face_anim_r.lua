-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_perform_face_anim_r.lua

module("logic.config.t_main_perform_face_anim_r", package.seeall)

local title = {
	id = 1,
	state = 2
}
local dataList = {
	{
		100002,
		{
			"chouka_loop_face#1,2",
			"xiangqing_loop_face#1,2",
			"shafa_loop_face#1,2"
		}
	},
	{
		100007,
		{
			"xiangqing_loop_face#1,3",
			"chouka_loop_face#1,3",
			"shafa_loop_face#1,3"
		}
	},
	{
		100008,
		{
			"chouka_loop_face#1,3",
			"shafa_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	},
	{
		100011,
		{
			"shafa_loop_face#1,2",
			"chouka_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100012,
		{
			"chouka_loop_face#1,3",
			"shafa_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	},
	{
		100013,
		{
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100016
	},
	{
		100020,
		{
			"shafa_loop_face#1,3",
			"chouka_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100021,
		{
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100022,
		{
			"shafa_loop_face#1,3",
			"chouka_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	},
	{
		100028,
		{
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100029,
		{
			"chouka_loop_face#1,3",
			"xiangqing_loop_face#1,3",
			"shafa_loop_face#1,3"
		}
	},
	{
		100030,
		{
			"shafa_loop_face#1,2",
			"chouka_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100039,
		{
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100043,
		{
			"chouka_loop_face#1,3",
			"shafa_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	},
	{
		100051,
		{
			"chouka_loop_face#1,3",
			"shafa_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	},
	{
		100053,
		{
			"xiangqing_loop_face#1,2",
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2"
		}
	},
	{
		100056,
		{
			"chouka_loop_face#1,2",
			"shafa_loop_face#1,2",
			"xiangqing_loop_face#1,2"
		}
	},
	{
		100057,
		{
			"shafa_loop_face#1,3",
			"chouka_loop_face#1,3",
			"xiangqing_loop_face#1,3"
		}
	}
}
local t_main_perform_face_anim_r = {}

t_main_perform_face_anim_r.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name[%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_main_perform_face_anim_r[v[1]] = v

	setmetatable(v, mt)
end

return t_main_perform_face_anim_r
