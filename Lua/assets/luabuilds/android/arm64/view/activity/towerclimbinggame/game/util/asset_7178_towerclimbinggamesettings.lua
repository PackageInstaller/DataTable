local TowerClimbingGameSettings = class("TowerClimbingGameSettings")

TowerClimbingGameSettings.BLOCK_NAME = "block"
TowerClimbingGameSettings.STAB_NAME = "stab"
TowerClimbingGameSettings.STAB_HURT_AREA = "stab_hurt_area"
TowerClimbingGameSettings.FIRE_NAME = "fire"
TowerClimbingGameSettings.GROUND_NAME = "manjuu"
TowerClimbingGameSettings.HEAD_BLOCK_TYPE = {
	"TowerClimbingBlock",
	375
}
TowerClimbingGameSettings.MapId2BlockType = {
	{
		{
			{
				"TowerClimbingBlock",
				375
			},
			33
		},
		{
			{
				"TowerClimbingBlock1",
				278
			},
			66
		},
		{
			{
				"TowerClimbingBlock2",
				213
			},
			100
		}
	},
	{
		{
			{
				"TowerClimbingBlock",
				375
			},
			20
		},
		{
			{
				"TowerClimbingBlock1",
				278
			},
			40
		},
		{
			{
				"TowerClimbingBlock2",
				213
			},
			60
		},
		{
			{
				"TowerClimbingBlock3",
				213
			},
			70
		},
		{
			{
				"TowerClimbingBlock4",
				213
			},
			20
		},
		{
			{
				"TowerClimbingBlock5",
				213
			},
			50
		},
		{
			{
				"TowerClimbingBlock6",
				278
			},
			80
		},
		{
			{
				"TowerClimbingBlock7",
				375
			},
			90
		},
		{
			{
				"TowerClimbingBlock8",
				375
			},
			100
		}
	},
	{
		{
			{
				"TowerClimbingBlock",
				375
			},
			20
		},
		{
			{
				"TowerClimbingBlock1",
				278
			},
			40
		},
		{
			{
				"TowerClimbingBlock2",
				213
			},
			60
		},
		{
			{
				"TowerClimbingBlock3",
				213
			},
			70
		},
		{
			{
				"TowerClimbingBlock4",
				213
			},
			20
		},
		{
			{
				"TowerClimbingBlock5",
				213
			},
			50
		},
		{
			{
				"TowerClimbingBlock6",
				278
			},
			80
		},
		{
			{
				"TowerClimbingBlock7",
				375
			},
			90
		},
		{
			{
				"TowerClimbingBlock9",
				375
			},
			90
		},
		{
			{
				"TowerClimbingBlock10",
				375
			},
			100
		}
	}
}
TowerClimbingGameSettings.MAPID2EFFECT = {
	[3] = {
		{
			"pata_feng",
			{
				0,
				-98.04945
			}
		},
		{
			"pata_xiayu",
			{
				-51.20945,
				-640.9627
			}
		}
	}
}
TowerClimbingGameSettings.AWARDEFFECT = "pata_huodedaoju_tuowei"
TowerClimbingGameSettings.AWARDEFFECT1 = "pata_huodedaoju_baodian"
TowerClimbingGameSettings.JUMP_VELOCITY = 31.7
TowerClimbingGameSettings.MOVE_VELOCITY = 8.68
TowerClimbingGameSettings.BEINJURED_VELOCITY = Vector2(0, 0)
TowerClimbingGameSettings.BLOCK_START_POSITION = Vector2(-60, 385)
TowerClimbingGameSettings.BLOCK_INTERVAL_HEIGHT = 150
TowerClimbingGameSettings.BLOCK_MAX_INTERVAL_WIDTH = {
	-55,
	150
}
TowerClimbingGameSettings.SINK_DISTANCE = TowerClimbingGameSettings.BLOCK_INTERVAL_HEIGHT
TowerClimbingGameSettings.BOUNDS = {
	-520,
	520
}
TowerClimbingGameSettings.INVINCEIBLE_TIME = 3
TowerClimbingGameSettings.GROUND_RISE_UP_LEVEL = 50
TowerClimbingGameSettings.GROUND_SLEEP_TIME = 3
TowerClimbingGameSettings.GROUND_SLIDE_DOWNWARD_DISTANCE = 130
TowerClimbingGameSettings.FIRE_TIME = {
	3,
	5
}
TowerClimbingGameSettings.MANJUU_START_POS = Vector2(4, -92.7)
TowerClimbingGameSettings.MANJUU_HEIGHT = 230
TowerClimbingGameSettings.GROUND_RISE_UP_SPEED = {
	{
		50,
		110
	},
	{
		60,
		111
	},
	{
		70,
		112
	},
	{
		90,
		115
	},
	{
		110,
		117
	},
	{
		130,
		120
	},
	{
		150,
		122
	},
	{
		180,
		123
	},
	{
		210,
		125
	},
	{
		300,
		126
	},
	{
		350,
		127
	}
}

function TowerClimbingGameSettings:GetBlockInitCnt()
	return math.ceil((self - TowerClimbingGameSettings.BLOCK_START_POSITION.y) / TowerClimbingGameSettings.BLOCK_INTERVAL_HEIGHT) + 2
end

return TowerClimbingGameSettings
