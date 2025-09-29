-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_clip_doll_redeem.lua

module("logic.config.t_clip_doll_redeem", package.seeall)

local title = {
	reward = 4,
	activityid = 1,
	cost = 3,
	name = 6,
	id = 2,
	times = 5
}
local dataList = {
	{
		80001,
		1,
		{
			{
				id = 1012001,
				num = 1
			}
		},
		2280002,
		1,
		"炸鸡剑圣"
	},
	{
		80001,
		2,
		{
			{
				id = 1012003,
				num = 1
			}
		},
		2280003,
		1,
		"破译专员"
	},
	{
		80001,
		3,
		{
			{
				id = 1012005,
				num = 1
			}
		},
		2280004,
		1,
		"灵性视觉"
	},
	{
		80001,
		4,
		{
			{
				id = 1012006,
				num = 1
			}
		},
		2280005,
		1,
		"不熟别碰"
	},
	{
		80001,
		5,
		{
			{
				id = 1012001,
				num = 1
			},
			{
				id = 1012003,
				num = 1
			}
		},
		2280006,
		1,
		"默契拍档"
	},
	{
		80001,
		6,
		{
			{
				id = 1012003,
				num = 1
			},
			{
				id = 1012005,
				num = 1
			}
		},
		2280007,
		1,
		"12号红雾区"
	},
	{
		80001,
		7,
		{
			{
				id = 1012002,
				num = 1
			},
			{
				id = 1012008,
				num = 1
			}
		},
		2280008,
		1,
		"“罪天使”之系"
	},
	{
		80001,
		8,
		{
			{
				id = 1012007,
				num = 1
			},
			{
				id = 1012009,
				num = 1
			}
		},
		2280009,
		1,
		"白银的女儿们"
	},
	{
		80001,
		9,
		{
			{
				id = 1012008,
				num = 1
			},
			{
				id = 1012011,
				num = 1
			}
		},
		2280010,
		1,
		"小心接触"
	},
	{
		80001,
		10,
		{
			{
				id = 1012006,
				num = 1
			},
			{
				id = 1012009,
				num = 1
			}
		},
		2280011,
		1,
		"毛绒绒富翁"
	},
	{
		80001,
		11,
		{
			{
				id = 1012006,
				num = 1
			},
			{
				id = 1012007,
				num = 1
			}
		},
		2280012,
		1,
		"非人类亲和力"
	},
	{
		80001,
		12,
		{
			{
				id = 1012012,
				num = 1
			},
			{
				id = 1012013,
				num = 1
			}
		},
		2280013,
		1,
		"面具行人"
	},
	{
		80001,
		13,
		{
			{
				id = 1012014,
				num = 1
			},
			{
				id = 1012015,
				num = 1
			}
		},
		2280014,
		1,
		"天降正义"
	},
	{
		80001,
		14,
		{
			{
				id = 1012001,
				num = 1
			},
			{
				id = 1012003,
				num = 1
			},
			{
				id = 1012005,
				num = 1
			}
		},
		2280015,
		1,
		"校时者们"
	},
	{
		80001,
		15,
		{
			{
				id = 1012004,
				num = 1
			},
			{
				id = 1012008,
				num = 1
			},
			{
				id = 1012011,
				num = 1
			}
		},
		2280016,
		1,
		"深陷漩涡者"
	},
	{
		80001,
		16,
		{
			{
				id = 1012001,
				num = 1
			},
			{
				id = 1012007,
				num = 1
			},
			{
				id = 1012009,
				num = 1
			}
		},
		2280017,
		1,
		"离家之人"
	},
	{
		80001,
		17,
		{
			{
				id = 1012001,
				num = 1
			},
			{
				id = 1012006,
				num = 1
			},
			{
				id = 1012008,
				num = 1
			}
		},
		2280018,
		1,
		"幻影之刃"
	}
}
local t_clip_doll_redeem = {}

t_clip_doll_redeem.dataList = dataList

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
	local parent1 = t_clip_doll_redeem[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_clip_doll_redeem[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_clip_doll_redeem
