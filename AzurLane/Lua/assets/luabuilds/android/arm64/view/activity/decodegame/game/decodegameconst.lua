class = var_0_10000

local var_0_0 = var_0_10000("DecodeGameConst")

var_0_0.DISORDER = {
	11,
	1,
	10,
	17,
	4,
	6,
	7,
	18,
	3,
	8,
	19,
	9,
	5,
	16,
	12,
	20,
	13,
	15,
	2,
	14,
	16
}
var_0_0.START_POS = {
	-336.8,
	-93.6
}
var_0_0.BLOCK_SIZE = {
	170,
	170
}
var_0_0.MAP_ROW = 4
var_0_0.MAP_COLUMN = 5
var_0_0.MAP_NAME_OFFSET = 5
var_0_0.PROGRESS2FILLAMOUMT = 0.0125
var_0_0.PROGRESS2ANGLE = 4.5
var_0_0.OPEN_DOOR_DELAY = 0
var_0_0.MAX_MAP_COUNT = 3
var_0_0.DECODE_MAP_TIME = 0.5
var_0_0.SCAN_MAP_TIME = 1
var_0_0.SWITCH_MAP = 0.5
var_0_0.SCAN_GRID_TIME = 1
var_0_0.SWITCH_TO_DECODE_TIME = 0.4
var_0_0.GET_AWARD_ANIM_TIME = 0.7
var_0_0.PASSWORDS = {
	"4",
	"8",
	"-",
	"1",
	"9",
	"0",
	"3",
	"-",
	"7",
	"1",
	"5",
	"4",
	"3",
	"-",
	"8",
	"9",
	"2",
	"6",
	"4",
	"1"
}
var_0_0.PASSWORD = {
	{
		2,
		2
	},
	{
		4,
		2
	},
	{
		3,
		4
	},
	{
		3,
		3
	},
	{
		2,
		1
	},
	{
		4,
		3
	},
	{
		3,
		2
	},
	{
		2,
		4
	},
	{
		1,
		1
	}
}
var_0_0.MAPS_PASSWORD = {
	{
		{
			3,
			2
		},
		{
			2,
			4
		},
		{
			1,
			1
		}
	},
	{
		{
			2,
			2
		},
		{
			4,
			2
		},
		{
			3,
			4
		}
	},
	{
		{
			3,
			3
		},
		{
			2,
			1
		},
		{
			4,
			3
		}
	}
}
var_0_0.AWARD = {
	3,
	980,
	1
}
var_0_0.STORYID = "MAOZIPT"
var_0_0.UNLOCK_STORYID = {
	[40] = "LIMINGZHIAN2",
	[20] = "LIMINGZHIAN1",
	[60] = "LIMINGZHIAN3"
}
var_0_0.LAST_STORYID = "LIMINGZHIAN4"

function var_0_0.Vect2Index(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0 - 1

	DecodeGameConst = var_1_10003

	return var_1_0 * var_1_10003.MAP_COLUMN + arg_1_1
end

function var_0_0.Index2Vect(arg_2_0)
	math = var_1_10001

	local var_2_0 = arg_2_0 - (var_1_10001.ceil(arg_2_0 / var_0_0.MAP_COLUMN) - 1) * var_0_0.MAP_COLUMN

	return var_1, var_2_0
end

var_0_0.HELP_BGS = {
	{
		"decode_helper_1",
		{
			1714,
			771
		},
		{
			1,
			1
		}
	},
	{
		"decode_helper_2",
		{
			1546,
			769
		},
		{
			1,
			1
		}
	},
	{
		"decode_helper_3",
		{
			1723,
			885
		},
		{
			1,
			1
		}
	}
}
var_0_0.OPEN_DOOR_VOICE = ""
var_0_0.SWITCH_MAP_VOCIE = "event:/ui/dg-youanniu"
var_0_0.PRESS_DOWN_PASSWORDBTN = "event:/ui/dg-xiaanniu"
var_0_0.PRESS_UP_PASSWORDBTN = "event:/ui/dg-xiaanniu"
var_0_0.SCAN_MAP_VOICE = ""
var_0_0.INCREASE_PROGRESS_VOICE = ""
var_0_0.PASSWORD_IS_RIGHT_VOICE = "event:/ui/dg-zhengque"
var_0_0.PASSWORD_IS_FALSE_VOICE = "event:/ui/dg-cuowu"
var_0_0.INCREASE_PASSWORD_PROGRESS_VOICE = ""
var_0_0.GET_AWARD_DONE_VOICE = "event:/ui/dg-jiangli"

return var_0_0
