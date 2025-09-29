-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_module.lua

module("logic.config.t_house_hold_module", package.seeall)

local title = {
	effect1 = 6,
	name = 4,
	param2 = 9,
	param1 = 7,
	cost = 11,
	module = 2,
	modulePoint = 12,
	desc = 5,
	moduletyp = 3,
	preModule = 10,
	id = 1,
	effect2 = 8
}
local dataList = {
	{
		101,
		1,
		1,
		"模块1_1",
		"描述文案",
		1,
		1,
		0,
		0,
		nil,
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		1
	},
	{
		101,
		2,
		1,
		"强化隔音设备",
		"强化管制室的隔音效果，降低潜在风险。",
		2,
		1,
		0,
		0,
		nil,
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		1
	},
	{
		101,
		3,
		1,
		"模块1_3",
		"描述文案",
		3,
		1,
		0,
		0,
		nil,
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		1
	},
	{
		101,
		4,
		2,
		"模块2_1",
		"描述文案",
		1,
		1,
		0,
		0,
		{
			2
		},
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		2
	},
	{
		101,
		5,
		2,
		"模块2_2",
		"描述文案",
		1,
		1,
		0,
		0,
		{
			2
		},
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		2
	},
	{
		101,
		6,
		2,
		"模块2_3",
		"描述文案",
		2,
		1,
		0,
		0,
		{
			3
		},
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		2
	},
	{
		101,
		7,
		2,
		"模块2_4",
		"描述文案",
		3,
		1,
		0,
		0,
		{
			3
		},
		{
			{
				id = 1705001,
				num = 1
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		2
	},
	{
		102,
		1,
		1,
		"水体富养化",
		"阿巴阿巴阿巴",
		1,
		1,
		0,
		0,
		nil,
		nil,
		1
	},
	{
		102,
		2,
		1,
		"重构炉心",
		"阿巴阿巴阿巴",
		2,
		2,
		0,
		0,
		nil,
		nil,
		1
	},
	{
		102,
		3,
		1,
		"恒温系统",
		"阿巴阿巴阿巴",
		3,
		3,
		0,
		0,
		nil,
		nil,
		1
	},
	{
		102,
		4,
		2,
		"AAA",
		"阿巴阿巴阿巴",
		4,
		1,
		0,
		0,
		{
			2
		},
		nil,
		2
	},
	{
		102,
		5,
		2,
		"BBB",
		"BBB:阿巴阿巴阿巴",
		0,
		0,
		0,
		0,
		{
			2
		},
		nil,
		2
	},
	{
		102,
		6,
		2,
		"CCC",
		"CCC:阿巴阿巴阿巴",
		0,
		0,
		0,
		0,
		{
			2
		},
		nil,
		2
	},
	{
		102,
		7,
		2,
		"DDD",
		"DDD:阿巴阿巴阿巴",
		0,
		0,
		0,
		0,
		{
			2
		},
		nil,
		2
	},
	{
		103,
		1,
		1,
		"中级模块1",
		"测试异化物",
		1,
		2,
		2,
		-1,
		nil,
		nil,
		0
	},
	{
		103,
		2,
		1,
		"中级模块2",
		"测试异化物",
		2,
		3,
		3,
		-2,
		nil,
		nil,
		0
	},
	{
		103,
		3,
		1,
		"中级模块3",
		"测试异化物",
		3,
		4,
		1,
		-3,
		nil,
		nil,
		0
	},
	{
		103,
		4,
		2,
		"高级模块1",
		"测试异化物",
		0,
		0,
		0,
		0,
		nil,
		nil,
		0
	},
	{
		103,
		5,
		2,
		"高级模块2",
		"测试异化物",
		0,
		0,
		0,
		0,
		nil,
		nil,
		0
	},
	{
		103,
		6,
		2,
		"高级模块3",
		"测试异化物",
		0,
		0,
		0,
		0,
		nil,
		nil,
		0
	},
	{
		103,
		7,
		2,
		"高级模块4",
		"测试异化物",
		0,
		0,
		0,
		0,
		nil,
		nil,
		0
	}
}
local t_house_hold_module = {}

t_house_hold_module.dataList = dataList

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
	local parent1 = t_house_hold_module[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_hold_module[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_house_hold_module
