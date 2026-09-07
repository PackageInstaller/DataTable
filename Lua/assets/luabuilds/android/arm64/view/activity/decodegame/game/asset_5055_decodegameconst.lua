local DecodeGameConst = class("DecodeGameConst")

DecodeGameConst.DISORDER = {
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
DecodeGameConst.START_POS = {
	-336.8,
	-93.6
}
DecodeGameConst.BLOCK_SIZE = {
	170,
	170
}
DecodeGameConst.MAP_ROW = 4
DecodeGameConst.MAP_COLUMN = 5
DecodeGameConst.MAP_NAME_OFFSET = 5
DecodeGameConst.PROGRESS2FILLAMOUMT = 0.0125
DecodeGameConst.PROGRESS2ANGLE = 4.5
DecodeGameConst.OPEN_DOOR_DELAY = 0
DecodeGameConst.MAX_MAP_COUNT = 3
DecodeGameConst.DECODE_MAP_TIME = 0.5
DecodeGameConst.SCAN_MAP_TIME = 1
DecodeGameConst.SWITCH_MAP = 0.5
DecodeGameConst.SCAN_GRID_TIME = 1
DecodeGameConst.SWITCH_TO_DECODE_TIME = 0.4
DecodeGameConst.GET_AWARD_ANIM_TIME = 0.7
DecodeGameConst.PASSWORDS = {
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
DecodeGameConst.PASSWORD = {
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
DecodeGameConst.MAPS_PASSWORD = {
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
DecodeGameConst.AWARD = {
	3,
	980,
	1
}
DecodeGameConst.STORYID = "MAOZIPT"
DecodeGameConst.UNLOCK_STORYID = {
	[40] = "LIMINGZHIAN2",
	[20] = "LIMINGZHIAN1",
	[60] = "LIMINGZHIAN3"
}
DecodeGameConst.LAST_STORYID = "LIMINGZHIAN4"

function DecodeGameConst:Vect2Index(arg_1_1)
	return (self - 1) * DecodeGameConst.MAP_COLUMN + arg_1_1
end

function DecodeGameConst:Index2Vect()
	local var_2_0 = math.ceil(self / DecodeGameConst.MAP_COLUMN)

	return var_2_0, self - (var_2_0 - 1) * DecodeGameConst.MAP_COLUMN
end

DecodeGameConst.HELP_BGS = {
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
DecodeGameConst.OPEN_DOOR_VOICE = ""
DecodeGameConst.SWITCH_MAP_VOCIE = "event:/ui/dg-youanniu"
DecodeGameConst.PRESS_DOWN_PASSWORDBTN = "event:/ui/dg-xiaanniu"
DecodeGameConst.PRESS_UP_PASSWORDBTN = "event:/ui/dg-xiaanniu"
DecodeGameConst.SCAN_MAP_VOICE = ""
DecodeGameConst.INCREASE_PROGRESS_VOICE = ""
DecodeGameConst.PASSWORD_IS_RIGHT_VOICE = "event:/ui/dg-zhengque"
DecodeGameConst.PASSWORD_IS_FALSE_VOICE = "event:/ui/dg-cuowu"
DecodeGameConst.INCREASE_PASSWORD_PROGRESS_VOICE = ""
DecodeGameConst.GET_AWARD_DONE_VOICE = "event:/ui/dg-jiangli"

return DecodeGameConst
