-- chunkname: @IQIGame\\Config\\CfgPlayerTalentTable.lua

local CfgPlayerTalentTable = {
	[10001] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10001,
		TalentType = 1,
		TalentStory = getI18NValue(180041200),
		Talent1Story = getI18NValue(180041201),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			1,
			1,
			5
		},
		Coordinate = {
			-320,
			-10
		}
	},
	[10002] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_01.png",
		EffectType = 1,
		Id = 10002,
		TalentType = 2,
		Precondition = {
			10001
		},
		TalentStory = getI18NValue(180041202),
		Talent1Story = getI18NValue(180041203),
		TalentCost = {
			15,
			2
		},
		EffectParam = {
			2,
			2,
			500
		},
		Coordinate = {
			-200,
			-10
		}
	},
	[10003] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10003,
		TalentType = 1,
		Precondition = {
			10002
		},
		TalentStory = getI18NValue(180041204),
		Talent1Story = getI18NValue(180041205),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			3,
			2,
			500
		},
		Coordinate = {
			-80,
			120
		}
	},
	[10004] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10004,
		TalentType = 1,
		Precondition = {
			10002
		},
		TalentStory = getI18NValue(180041206),
		Talent1Story = getI18NValue(180041207),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			4,
			1,
			3
		},
		Coordinate = {
			-80,
			-10
		}
	},
	[10005] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10005,
		TalentType = 1,
		Precondition = {
			10002
		},
		TalentStory = getI18NValue(180041208),
		Talent1Story = getI18NValue(180041209),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			5,
			1,
			10
		},
		Coordinate = {
			-80,
			-120
		}
	},
	[10006] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10006,
		TalentType = 1,
		Precondition = {
			10003,
			10004
		},
		TalentStory = getI18NValue(180041210),
		Talent1Story = getI18NValue(180041211),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			6,
			1,
			10
		},
		Coordinate = {
			30,
			50
		}
	},
	[10007] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10007,
		TalentType = 1,
		Precondition = {
			10004,
			10005
		},
		TalentStory = getI18NValue(180041212),
		Talent1Story = getI18NValue(180041213),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			1,
			1,
			5
		},
		Coordinate = {
			30,
			-70
		}
	},
	[10008] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_01.png",
		EffectType = 1,
		Id = 10008,
		TalentType = 2,
		Precondition = {
			10006,
			10007
		},
		TalentStory = getI18NValue(180041214),
		Talent1Story = getI18NValue(180041215),
		TalentCost = {
			15,
			2
		},
		EffectParam = {
			8,
			1,
			-5
		},
		Coordinate = {
			120,
			-10
		}
	},
	[10009] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10009,
		TalentType = 1,
		Precondition = {
			10008
		},
		TalentStory = getI18NValue(180041216),
		Talent1Story = getI18NValue(180041217),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			9,
			2,
			-1000
		},
		Coordinate = {
			120,
			170
		}
	},
	[10010] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 1,
		Id = 10010,
		TalentType = 1,
		Precondition = {
			10008
		},
		TalentStory = getI18NValue(180041218),
		Talent1Story = getI18NValue(180041219),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			10,
			2,
			-1000
		},
		Coordinate = {
			120,
			-170
		}
	},
	[10011] = {
		Id = 10011,
		TalentType = 1,
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		Precondition = {
			10008
		},
		TalentStory = getI18NValue(180041220),
		Talent1Story = getI18NValue(180041221),
		TalentCost = {
			15,
			1
		},
		Coordinate = {
			220,
			60
		}
	},
	[10012] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 2,
		Id = 10012,
		TalentType = 1,
		Precondition = {
			10008
		},
		TalentStory = getI18NValue(180041222),
		Talent1Story = getI18NValue(180041223),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			3,
			-1,
			-1,
			11,
			0,
			-1
		},
		Coordinate = {
			220,
			-60
		}
	},
	[10013] = {
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		EffectType = 3,
		Id = 10013,
		TalentType = 1,
		Precondition = {
			10011,
			10012
		},
		TalentStory = getI18NValue(180041224),
		Talent1Story = getI18NValue(180041225),
		TalentCost = {
			15,
			1
		},
		EffectParam = {
			-1,
			-1,
			-1,
			4,
			1,
			10
		},
		Coordinate = {
			320,
			-10
		}
	},
	[10014] = {
		Id = 10014,
		TalentType = 1,
		TalentIcon = "Assets/05_Images/DataResource/UIResource/TalentCommonImg/UserTalentUI_TalentImg_02.png",
		Precondition = {
			10013
		},
		TalentStory = getI18NValue(180041226),
		Talent1Story = getI18NValue(180041227),
		TalentCost = {
			15,
			1
		},
		Coordinate = {
			320,
			-120
		}
	}
}

setmetatable(CfgPlayerTalentTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlayerTalentTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Talent1Story = "",
		TalentStory = "",
		TalentIcon = "",
		EffectType = 0,
		TalentType = 0,
		Coordinate = {},
		Precondition = {},
		TalentCost = {},
		EffectParam = {}
	}
}

for i, data in pairs(CfgPlayerTalentTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlayerTalentTable
