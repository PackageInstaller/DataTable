local var_0_0 = class("TowerClimbingGameSettings")

var_0_0.BLOCK_NAME = "block"
var_0_0.STAB_NAME = "stab"
var_0_0.STAB_HURT_AREA = "stab_hurt_area"
var_0_0.FIRE_NAME = "fire"
var_0_0.GROUND_NAME = "manjuu"
var_0_0.HEAD_BLOCK_TYPE = {
	"TowerClimbingBlock",
	375
}
var_0_0.MapId2BlockType = {
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
var_0_0.MAPID2EFFECT = {
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
var_0_0.AWARDEFFECT = "pata_huodedaoju_tuowei"
var_0_0.AWARDEFFECT1 = "pata_huodedaoju_baodian"
var_0_0.JUMP_VELOCITY = 31.7
var_0_0.MOVE_VELOCITY = 8.68
var_0_0.BEINJURED_VELOCITY = Vector2(0, 0)
var_0_0.BLOCK_START_POSITION = Vector2(-60, 385)
var_0_0.BLOCK_INTERVAL_HEIGHT = 150
var_0_0.BLOCK_MAX_INTERVAL_WIDTH = {
	-55,
	150
}
var_0_0.SINK_DISTANCE = var_0_0.BLOCK_INTERVAL_HEIGHT
var_0_0.BOUNDS = {
	-520,
	520
}
var_0_0.INVINCEIBLE_TIME = 3
var_0_0.GROUND_RISE_UP_LEVEL = 50
var_0_0.GROUND_SLEEP_TIME = 3
var_0_0.GROUND_SLIDE_DOWNWARD_DISTANCE = 130
var_0_0.FIRE_TIME = {
	3,
	5
}
var_0_0.MANJUU_START_POS = Vector2(4, -92.7)
var_0_0.MANJUU_HEIGHT = 230
var_0_0.GROUND_RISE_UP_SPEED = {
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

function var_0_0.GetBlockInitCnt(arg_1_0)
	return math.ceil((arg_1_0 - var_0_0.BLOCK_START_POSITION.y) / var_0_0.BLOCK_INTERVAL_HEIGHT) + 2
end

return var_0_0
