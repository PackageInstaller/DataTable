-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_doom_forecast_character_name.lua

module("logic.config.t_doom_forecast_character_name", package.seeall)

local title = {
	characterNames = 2,
	code = 1
}
local dataList = {
	{
		2000005,
		{
			"幻星",
			"旅人",
			"落魄公主"
		}
	},
	{
		2000007,
		{
			"欧几里得",
			"犯罪侧写师",
			"假面"
		}
	},
	{
		2000008,
		{
			"六分仪",
			"管家",
			"监护人"
		}
	},
	{
		2000011,
		{
			"一云",
			"剑客"
		}
	},
	{
		2000012,
		{
			"芬里尔",
			"豆丁",
			"魔方代言人"
		}
	},
	{
		2000013,
		{
			"安妮薇",
			"千金大小姐"
		}
	},
	{
		2000014,
		{
			"七芒星",
			"恶劣女仆"
		}
	},
	{
		2000016,
		{
			"烟火",
			"密码学家"
		}
	},
	{
		2000019,
		{
			"多里安",
			"调查科长",
			"公义的伙伴"
		}
	},
	{
		2000020,
		{
			"安布蕾拉",
			"暴力笨蛋",
			"炸弹人"
		}
	},
	{
		2000021,
		{
			"暮雪",
			"手上长游戏机的家伙",
			"财务管家",
			"技术宅"
		}
	},
	{
		2000022,
		{
			"飞鸟",
			"害怕影子的人"
		}
	},
	{
		2000028,
		{
			"创",
			"弑亲者",
			"吸血鬼猎人"
		}
	},
	{
		2000030,
		{
			"波波莎",
			"违纪者"
		}
	},
	{
		2000031,
		{
			"卡布奇诺",
			"狗狗"
		}
	},
	{
		2000036,
		{
			"多萝西",
			"乖孩子",
			"幺女"
		}
	},
	{
		2000039,
		{
			"伊丽莎白",
			"不老童颜",
			"照镜子的人"
		}
	},
	{
		2000041,
		{
			"辛德瑞拉",
			"假小子",
			"次女"
		}
	},
	{
		2000043,
		{
			"雅",
			"面包小子",
			"贫苦的人"
		}
	},
	{
		2000047,
		{
			"奥杰塔",
			"黑天鹅"
		}
	},
	{
		2000053,
		{
			"阿妮亚",
			"清理部队成员",
			"胆小鬼"
		}
	},
	{
		2000055,
		{
			"格里高列",
			"黑与白的诫律",
			"审判者"
		}
	},
	{
		2000057,
		{
			"厄迪普斯",
			"疯狂的融合者",
			"水滴的智囊"
		}
	},
	{
		2000056,
		{
			"提亚",
			"毒苹果"
		}
	},
	{
		2000010,
		{
			"林鸮",
			"百灵鸟"
		}
	},
	{
		2000025,
		{
			"磷火",
			"百鬼缠身"
		}
	}
}
local t_doom_forecast_character_name = {}

t_doom_forecast_character_name.dataList = dataList

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
	t_doom_forecast_character_name[v[1]] = v

	setmetatable(v, mt)
end

return t_doom_forecast_character_name
