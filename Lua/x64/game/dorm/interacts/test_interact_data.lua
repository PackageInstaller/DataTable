local var_0_0 = {
	[1.65] = {
		{
			{
				grabBy = 0,
				m_Time = 1.65,
				action = "grabPart",
				attachPoint = "q",
				itemPartName = "w",
				grabFrom = 0
			}
		}
	},
	[2] = {
		{
			{
				grabBy = 0,
				m_Time = 2,
				action = "grabPart",
				attachPoint = "df",
				itemPartName = "as",
				grabFrom = 0
			}
		}
	},
	[3.06666666666667] = {
		{
			{
				m_Time = 3.066667,
				animeActionSubName = "s",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "a"
			}
		}
	},
	[4.16666666666667] = {
		{
			{
				m_Time = 4.166667,
				referenceTarget = 0,
				action = "putAt",
				entity = 0,
				referencePointName = "d"
			}
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		1.65,
		2,
		3.06666666666667,
		4.16666666666667
	}
}

var_0_1.duration = 5
var_0_1.fps = 60

return var_0_1
