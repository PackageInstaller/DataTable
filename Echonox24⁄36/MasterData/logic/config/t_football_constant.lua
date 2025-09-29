-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_football_constant.lua

module("logic.config.t_football_constant", package.seeall)

local title = {
	numValue = 2,
	key = 1,
	jsonObjects = 5,
	strValue = 3,
	numValues = 4
}
local dataList = {
	{
		"MatchRange",
		10,
		""
	},
	{
		"MatchIncr",
		100,
		""
	},
	{
		"MatchIncrSeconds",
		10,
		""
	},
	{
		"RankSize",
		100,
		""
	},
	{
		"LatestRecordCount",
		20,
		""
	},
	{
		"ScoreArea",
		0,
		"",
		[5] = {
			{
				teamId = 2,
				area = {
					{
						x = 5,
						y = 14
					},
					{
						x = 6,
						y = 14
					},
					{
						x = 7,
						y = 14
					},
					{
						x = 8,
						y = 14
					},
					{
						x = 9,
						y = 14
					},
					{
						x = 5,
						y = 13
					},
					{
						x = 6,
						y = 13
					},
					{
						x = 7,
						y = 13
					},
					{
						x = 8,
						y = 13
					},
					{
						x = 9,
						y = 13
					}
				}
			},
			{
				teamId = 1,
				area = {
					{
						x = 5,
						y = 0
					},
					{
						x = 6,
						y = 0
					},
					{
						x = 7,
						y = 0
					},
					{
						x = 8,
						y = 0
					},
					{
						x = 9,
						y = 0
					},
					{
						x = 5,
						y = 1
					},
					{
						x = 6,
						y = 1
					},
					{
						x = 7,
						y = 1
					},
					{
						x = 8,
						y = 1
					},
					{
						x = 9,
						y = 1
					}
				}
			}
		}
	},
	{
		"BornArea",
		0,
		"",
		[5] = {
			{
				teamId = 1,
				area = {
					{
						x = 7,
						y = 9
					},
					{
						x = 6,
						y = 10
					},
					{
						x = 8,
						y = 10
					}
				}
			},
			{
				teamId = 2,
				area = {
					{
						x = 7,
						y = 5
					},
					{
						x = 6,
						y = 4
					},
					{
						x = 8,
						y = 4
					}
				}
			}
		}
	},
	{
		"MaxRound",
		8,
		""
	},
	{
		"Score",
		1,
		""
	},
	{
		"MatchTimeLimit",
		60,
		""
	},
	{
		"ReadyTimeLimit",
		60,
		""
	},
	{
		"OperateTimeLimit",
		30,
		""
	},
	{
		"LevelId",
		170101,
		""
	},
	{
		"ExpectedEntityCount",
		3,
		""
	},
	{
		"CommonSkill",
		1217001,
		""
	},
	{
		"ResetRound",
		3,
		""
	},
	{
		"QTETime",
		3,
		""
	},
	{
		"QTEInitSpeed",
		0,
		"0.1"
	},
	{
		"ChangeToAutoTimeoutCount",
		3,
		""
	},
	{
		"NormalAttackScores",
		0,
		"",
		[5] = {
			{
				1,
				50
			},
			{
				2,
				40
			},
			{
				3,
				10
			}
		}
	},
	{
		"QTEScores",
		0,
		"",
		{
			1,
			3,
			5
		}
	}
}
local t_football_constant = {}

t_football_constant.dataList = dataList

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
	t_football_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_football_constant
