-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_universally_unlock.lua

module("logic.config.t_character_universally_unlock", package.seeall)

local title = {
	id = 1,
	condition = 2
}
local dataList = {
	{
		1001
	},
	{
		1002
	},
	{
		1003
	},
	{
		1004
	},
	{
		1005
	},
	{
		1006
	},
	{
		1007
	},
	{
		1008
	},
	{
		1101
	},
	{
		1102
	},
	{
		1103
	},
	{
		1201
	},
	{
		1202,
		{
			{
				value = 2,
				type = "tacitLv"
			}
		}
	},
	{
		1203,
		{
			{
				value = 3,
				type = "tacitLv"
			}
		}
	},
	{
		1204,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3001
	},
	{
		3002
	},
	{
		3003
	},
	{
		3004
	},
	{
		3005
	},
	{
		3006
	},
	{
		3007
	},
	{
		3008
	},
	{
		3009
	},
	{
		3010
	},
	{
		3011
	},
	{
		3012
	},
	{
		3013
	},
	{
		3014
	},
	{
		3015
	},
	{
		3016
	},
	{
		3017
	},
	{
		3018
	},
	{
		3019
	},
	{
		3020
	},
	{
		3021,
		{
			{
				value = 2,
				type = "heroLv"
			}
		}
	},
	{
		3022,
		{
			{
				value = 1,
				type = "breakLv"
			}
		}
	},
	{
		3023,
		{
			{
				value = 1,
				type = "powerLv"
			}
		}
	},
	{
		3024,
		{
			{
				value = 1,
				type = "tacitLv"
			}
		}
	},
	{
		3025
	},
	{
		3026
	},
	{
		3027,
		{
			{
				value = 5,
				type = "tacitLv"
			}
		}
	},
	{
		3028
	},
	{
		3029
	},
	{
		3030
	},
	{
		3031
	},
	{
		3032
	},
	{
		3033
	},
	{
		3034
	},
	{
		3035
	},
	{
		3036
	},
	{
		3037
	},
	{
		3038
	},
	{
		3039
	},
	{
		3040
	},
	{
		3041
	},
	{
		3042
	},
	{
		3043
	},
	{
		3044,
		{
			{
				value = 1,
				type = "tacitLv"
			}
		}
	},
	{
		3045,
		{
			{
				value = 2,
				type = "tacitLv"
			}
		}
	},
	{
		3046,
		{
			{
				value = 3,
				type = "tacitLv"
			}
		}
	},
	{
		3047,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3048,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3049,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3050,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3051,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	},
	{
		3052,
		{
			{
				value = 4,
				type = "tacitLv"
			}
		}
	}
}
local t_character_universally_unlock = {}

t_character_universally_unlock.dataList = dataList

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
	t_character_universally_unlock[v[1]] = v

	setmetatable(v, mt)
end

return t_character_universally_unlock
