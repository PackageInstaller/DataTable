local var_0_0 = {
	id = "WorldG015_2"
}
local var_0_1 = {}
local var_0_2 = {
	alpha = 0,
	code = {
		"showAllMargin"
	}
}
local var_0_3 = {}
local var_0_4 = {
	notify = "world show margin"
}
local var_0_5 = {}

WorldConst = var_0_10006
var_0_5.tdType = var_0_10006.TransportDisplayGuideEnable
var_0_4.body = var_0_5
var_0_3[1] = var_0_4
var_0_2.notifies = var_0_3
var_0_1[1] = var_0_2
var_0_1[2] = {
	alpha = 0.3,
	code = {
		"showTransportTip"
	},
	style = {
		text = "舰队访问地图边缘的虚拟单元格就可以跨地图移动",
		mode = 2,
		dir = -1,
		posY = 296.05,
		posX = -417.84
	}
}

local var_0_6 = {
	alpha = 0,
	code = {
		"showDangerousMargin"
	}
}
local var_0_7 = {}
local var_0_8 = {
	notify = "world show margin"
}
local var_0_9 = {}

WorldConst = var_6
var_0_9.tdType = var_6.TransportDisplayGuideDanger
var_0_8.body = var_0_9
var_0_7[1] = var_0_8
var_0_6.notifies = var_0_7
var_0_1[3] = var_0_6
var_0_1[4] = {
	alpha = 0.3,
	delay = 0.2,
	code = {
		"getCompassDangerousPos"
	},
	notifies = {
		{
			notify = "world get compass pos",
			body = {
				row = 13,
				column = 2
			}
		}
	}
}
var_0_1[5] = {
	alpha = 0.2,
	code = {
		"showWorldDangerousSign"
	},
	showSign = {
		simultaneously = true,
		type = 1,
		signList = {
			{
				pos = "useCachePos",
				signType = 2
			}
		}
	}
}
var_0_1[6] = {
	alpha = 0.3,
	code = {
		"showDangerousTip"
	},
	style = {
		text = "红色的虚拟单元格意味着当前的海域过于危险",
		mode = 2,
		dir = -1,
		posY = 296.05,
		posX = -417.84
	}
}

local var_0_10 = {
	alpha = 0,
	code = {
		"showForbiddenMargin"
	}
}
local var_0_11 = {}
local var_0_12 = {
	notify = "world show margin"
}
local var_0_13 = {}

WorldConst = var_6
var_0_13.tdType = var_6.TransportDisplayGuideForbid
var_0_12.body = var_0_13
var_0_11[1] = var_0_12
var_0_10.notifies = var_0_11
var_0_1[7] = var_0_10
var_0_1[8] = {
	alpha = 0.3,
	delay = 0.2,
	code = {
		"getCompassForbiddenPos"
	},
	notifies = {
		{
			notify = "world get compass pos",
			body = {
				row = 13,
				column = 2
			}
		}
	}
}
var_0_1[9] = {
	alpha = 0.2,
	code = {
		"showWorldForbiddenSign"
	},
	showSign = {
		simultaneously = true,
		type = 1,
		signList = {
			{
				pos = "useCachePos",
				signType = 3
			}
		}
	}
}
var_0_1[10] = {
	alpha = 0.3,
	code = {
		"showForbiddenTip"
	},
	style = {
		text = "禁止标记则意味着当前海域无法进行边缘传送",
		mode = 2,
		dir = -1,
		posY = 296.05,
		posX = -417.84
	}
}

local var_0_14 = {
	alpha = 0,
	code = {
		"showNormalMargin"
	}
}
local var_0_15 = {}
local var_0_16 = {
	notify = "world show margin"
}
local var_0_17 = {}

WorldConst = var_6
var_0_17.tdType = var_6.TransportDisplayNormal
var_0_16.body = var_0_17
var_0_15[1] = var_0_16
var_0_14.notifies = var_0_15
var_0_1[11] = var_0_14
var_0_1[12] = {
	alpha = 0.3,
	delay = 0.2,
	code = {
		"getCompassTargetPos"
	},
	notifies = {
		{
			notify = "world get compass map pos",
			body = {
				mapId = 31
			}
		}
	}
}
var_0_1[13] = {
	alpha = 0.2,
	code = {
		"showWorldTargetSign"
	},
	showSign = {
		simultaneously = true,
		type = 1,
		signList = {
			{
				pos = "useCachePos",
				signType = 1
			}
		}
	}
}
var_0_1[14] = {
	alpha = 0.3,
	code = {
		"showForbiddenTip"
	},
	style = {
		text = "好的，现在请按照罗经指示的方向开始移动到新水域吧",
		mode = 2,
		dir = -1,
		posY = 296.05,
		posX = -417.84
	}
}
var_0_0.events = var_0_1

return var_0_0
