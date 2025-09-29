-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_thinking.lua

module("logic.config.t_thinking", package.seeall)

local title = {
	description = 7,
	name = 2,
	iconBg = 5,
	careerNames = 8,
	online = 3,
	tags = 6,
	skills = 9,
	id = 1,
	icon = 4
}
local dataList = {
	{
		1,
		"重塑",
		1,
		"thought_104",
		"smrsw_img_0002_4",
		{
			"追击",
			"振荡"
		},
		"",
		[9] = {
			1400101,
			1400102,
			1400103,
			1400104,
			1400105,
			1400106
		}
	},
	{
		2,
		"消解",
		1,
		"thought_105",
		"smrsw_img_0002_5",
		{
			"振荡"
		},
		"",
		[9] = {
			1400107,
			1400108,
			1400109
		}
	},
	{
		3,
		"裂变",
		0,
		"thought_106",
		"smrsw_img_0002_6",
		{
			"超感",
			"诅咒"
		},
		"",
		[9] = {
			1400113,
			1400114,
			1400115,
			1400116,
			1400117,
			1400118
		}
	},
	{
		4,
		"吞没",
		1,
		"thought_107",
		"smrsw_img_0002_7",
		{
			"弧光",
			"锁定"
		},
		"",
		[9] = {
			1400119,
			1400120,
			1400121,
			1400122,
			1400123,
			1400124
		}
	},
	{
		5,
		"弥散",
		1,
		"thought_108",
		"smrsw_img_0002_8",
		{
			"援护"
		},
		"",
		[9] = {
			1400125,
			1400126,
			1400127
		}
	},
	{
		6,
		"破坏",
		1,
		"thought_101",
		"smrsw_img_0002_1",
		{
			"低血",
			"非低血"
		},
		"",
		[9] = {
			1400131,
			1400132,
			1400133,
			1400134,
			1400135,
			1400136
		}
	},
	{
		7,
		"创造",
		1,
		"thought_102",
		"smrsw_img_0002_2",
		{
			"孤军"
		},
		"",
		[9] = {
			1400137,
			1400138,
			1400139
		}
	},
	{
		8,
		"寄生",
		1,
		"thought_103",
		"smrsw_img_0002_3",
		{
			"奔袭",
			"蓄势"
		},
		"",
		[9] = {
			1400143,
			1400144,
			1400145,
			1400146,
			1400147,
			1400148
		}
	},
	{
		9,
		"崇拜",
		1,
		"thought_104",
		"smrsw_img_0002_4",
		{
			"负理智"
		},
		"",
		[9] = {
			1400149,
			1400150,
			1400151
		}
	},
	{
		10,
		"叛乱",
		1,
		"thought_105",
		"smrsw_img_0002_5",
		{
			"压制"
		},
		"",
		[9] = {
			1400158,
			1400159,
			1400160
		}
	},
	{
		11,
		"支配",
		0,
		"thought_106",
		"smrsw_img_0002_6",
		{
			"锋刃",
			"衰退"
		},
		"",
		[9] = {
			1400161,
			1400162,
			1400163,
			1400164,
			1400165,
			1400166
		}
	},
	{
		12,
		"停滞",
		1,
		"thought_107",
		"smrsw_img_0002_7",
		{
			"高昂",
			"破甲"
		},
		"",
		[9] = {
			1400167,
			1400168,
			1400169,
			1400170,
			1400171,
			1400172
		}
	},
	{
		13,
		"进化",
		1,
		"thought_108",
		"smrsw_img_0002_8",
		{
			"瓦解"
		},
		"",
		[9] = {
			1400176,
			1400177,
			1400178
		}
	}
}
local t_thinking = {}

t_thinking.dataList = dataList

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
	t_thinking[v[1]] = v

	setmetatable(v, mt)
end

return t_thinking
