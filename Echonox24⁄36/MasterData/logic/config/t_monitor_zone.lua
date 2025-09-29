-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_monitor_zone.lua

module("logic.config.t_monitor_zone", package.seeall)

local title = {
	reward = 4,
	code = 1,
	name = 2,
	dungeonGroups = 3
}
local dataList = {
	{
		1,
		"禹土",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		2,
		"桑泽",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		3,
		"希利尔",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		4,
		"械城",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		5,
		"伊利亚特",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		6,
		"尤克特拉希尔",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		7,
		"西格纳斯",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		8,
		"白羽特别州",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		9,
		"次大陆",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		10,
		"万国",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		11,
		"尼伯龙根",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		12,
		"萨摩斯海域",
		{
			1,
			2,
			3
		},
		{
			0,
			0,
			0,
			0
		}
	},
	{
		-1,
		"尤克特拉希尔",
		{
			-1
		},
		{
			0,
			0,
			0,
			0
		}
	}
}
local t_monitor_zone = {}

t_monitor_zone.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_monitor_zone[v[1]] = v

	setmetatable(v, mt)
end

return t_monitor_zone
