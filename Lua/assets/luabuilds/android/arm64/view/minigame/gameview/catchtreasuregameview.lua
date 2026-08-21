local var_0_0 = class("CatchTreasureGameView", import("..BaseMiniGameView"))
local var_0_1 = "story-richang-5"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/taosheng"
local var_0_4 = "event:/ui/zhuahuo"
local var_0_5 = "event:/ui/deshou"
local var_0_6 = "event:/ui/shibai"
local var_0_7 = 60
local var_0_8 = "ui/minigameui/catchtreasuregameui_atlas"
local var_0_9 = "salvage_tips"
local var_0_10 = "event item done"
local var_0_11 = "boat state stand"
local var_0_12 = "boat state thorw"
local var_0_13 = "boat state wait"
local var_0_14 = "item act dynamic"
local var_0_15 = "item catch normal"
local var_0_16 = "item catch release"
local var_0_17 = "item catch unable"
local var_0_18 = "item good happy"
local var_0_19 = "item good surprise"
local var_0_20 = "item good release"
local var_0_21 = "item good none"
local var_0_22 = "item scene back"

;({}).type = "item act static"
;({}).range = {
	5,
	8
}
;({})[1] = {}
;({})[2] = {
	type = "item act dynamic",
	range = {
		5,
		8
	}
}

local var_0_26 = {
	{
		{
			repeated = true,
			type = "item type back",
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				6,
				6
			},
			name = {
				"treasure",
				"gold"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				2,
				2
			},
			name = {
				"rock"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				4,
				4
			},
			name = {
				"shell"
			}
		},
		{
			repeated = true,
			type = "item type sundries",
			amount = {
				3,
				3
			}
		},
		{
			repeated = true,
			type = "item type time",
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				2,
				2
			},
			name = {
				"fish_1",
				"fish_2",
				"fish_3",
				"fish_4"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				1,
				1
			},
			name = {
				"turtle"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				1,
				1
			},
			name = {
				"submarine_1"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				0,
				0
			},
			name = {
				"submarine_2"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				0,
				0
			},
			name = {
				"submarine_3"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				1,
				1
			},
			name = {
				"submarine_4"
			}
		}
	},
	{
		{
			repeated = true,
			type = "item type back",
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				2,
				2
			},
			name = {
				"treasure",
				"gold",
				"shell"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				0,
				0
			},
			name = {
				"rock"
			}
		},
		{
			repeated = true,
			type = "item type sundries",
			amount = {
				0,
				0
			}
		},
		{
			repeated = true,
			type = "item type time",
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				2,
				2
			},
			name = {
				"fish_1",
				"fish_4"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				3,
				3
			},
			name = {
				"fish_2"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				6,
				6
			},
			name = {
				"fish_3"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				5,
				5
			},
			name = {
				"turtle"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				0,
				0
			},
			name = {
				"submarine_1"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				1,
				1
			},
			name = {
				"submarine_2"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				1,
				1
			},
			name = {
				"submarine_3"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				0,
				0
			},
			name = {
				"submarine_4"
			}
		}
	},
	{
		{
			repeated = true,
			type = "item type back",
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				2,
				2
			},
			name = {
				"treasure"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				1,
				1
			},
			name = {
				"rock"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				2,
				2
			},
			name = {
				"gold"
			}
		},
		{
			repeated = true,
			type = "item type goods",
			amount = {
				2,
				2
			},
			name = {
				"shell"
			}
		},
		{
			repeated = true,
			type = "item type sundries",
			amount = {
				1,
				1
			}
		},
		{
			repeated = true,
			type = "item type time",
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				2,
				2
			},
			name = {
				"fish_1",
				"fish_4"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				2,
				2
			},
			name = {
				"fish_2"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				3,
				3
			},
			name = {
				"fish_3"
			}
		},
		{
			repeated = true,
			type = "item type fish",
			amount = {
				2,
				2
			},
			name = {
				"turtle"
			}
		},
		{
			repeated = false,
			type = "item type submarine",
			amount = {
				3,
				3
			},
			name = {
				"submarine_1",
				"submarine_2",
				"submarine_3",
				"submarine_4"
			}
		}
	}
}
local var_0_27 = {
	{
		score = 200,
		name = "fish_1",
		catch_speed = 130,
		speed = 150,
		release_speed = 200,
		type = "item type fish",
		act = "item act dynamic",
		catch = "item catch release",
		create_range = {
			0,
			9999,
			130,
			260
		},
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release"
	},
	{
		score = 250,
		name = "fish_2",
		catch_speed = 75,
		speed = 100,
		leave_direct = -1,
		release_speed = 200,
		type = "item type fish",
		act = "item act dynamic",
		catch = "item catch release",
		create_range = {
			0,
			9999,
			130,
			260
		},
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good surprise"
	},
	{
		score = 400,
		name = "fish_3",
		catch_speed = 220,
		speed = 350,
		release_speed = 300,
		type = "item type fish",
		act = "item act dynamic",
		catch = "item catch release",
		create_range = {
			0,
			9999,
			130,
			260
		},
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release"
	},
	{
		score = 150,
		name = "fish_4",
		catch_speed = 160,
		speed = 120,
		release_speed = 200,
		type = "item type fish",
		act = "item act dynamic",
		catch = "item catch release",
		create_range = {
			0,
			9999,
			130,
			260
		},
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release"
	},
	{
		score = 180,
		name = "turtle",
		catch_speed = 100,
		speed = 80,
		release_speed = 100,
		type = "item type fish",
		act = "item act dynamic",
		catch = "item catch release",
		create_range = {
			0,
			9999,
			130,
			260
		},
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release"
	},
	{
		score = -150,
		name = "submarine_1",
		speed = 200,
		catch_speed = 100,
		release_speed = 200,
		type = "item type submarine",
		act = "item act dynamic",
		catch = "item catch release",
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release",
		interaction = {
			time = {
				3,
				7
			},
			parame = {
				"swim"
			}
		}
	},
	{
		score = -100,
		name = "submarine_2",
		speed = 150,
		catch_speed = 100,
		release_speed = 200,
		type = "item type submarine",
		act = "item act dynamic",
		catch = "item catch release",
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release",
		interaction = {
			time = {
				3,
				7
			},
			parame = {
				"swim"
			}
		}
	},
	{
		score = -80,
		name = "submarine_3",
		speed = 120,
		catch_speed = 100,
		release_speed = 200,
		type = "item type submarine",
		act = "item act dynamic",
		catch = "item catch release",
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release",
		interaction = {
			time = {
				3,
				7
			},
			parame = {
				"swim"
			}
		}
	},
	{
		score = -50,
		name = "submarine_4",
		speed = 90,
		catch_speed = 100,
		release_speed = 200,
		type = "item type submarine",
		act = "item act dynamic",
		catch = "item catch release",
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good release",
		interaction = {
			time = {
				3,
				7
			},
			parame = {
				"swim"
			}
		}
	},
	{
		score = -50,
		name = "boom",
		speed = 500,
		catch_speed = 300,
		type = "item type sundries",
		act = "item act dynamic",
		catch = "item catch normal",
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = "item good surprise"
	},
	{
		speed = 0,
		name = "rock",
		score = 50,
		catch_speed = 80,
		type = "item type goods",
		act = "item act static",
		catch = "item catch normal",
		good = "item good none"
	},
	{
		score = 300,
		name = "gold",
		speed = 0,
		catch_speed = 160,
		type = "item type goods",
		act = "item act static",
		catch = "item catch normal",
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = "item good happy"
	},
	{
		score = 600,
		name = "treasure",
		speed = 0,
		catch_speed = 55,
		type = "item type goods",
		act = "item act static",
		catch = "item catch normal",
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = "item good happy"
	},
	{
		score = 600,
		name = "watch",
		time = 20,
		catch_speed = 180,
		speed = 0,
		type = "item type time",
		act = "item act static",
		catch = "item catch normal",
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = "item good happy"
	},
	{
		score = 200,
		name = "shell",
		speed = 0,
		catch_speed = 100,
		type = "item type goods",
		act = "item act static",
		catch = "item catch normal",
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = "item good happy",
		catch_rule = {
			targetName = "pearl",
			state = {
				1
			}
		},
		anim_data = {
			state_change = {
				1,
				2
			},
			time = {
				3,
				5
			}
		}
	},
	{
		speed = 0,
		name = "pearl",
		score = 500,
		catch_speed = 200,
		type = "item type bind",
		act = "item act static",
		catch = "item catch normal",
		good = "item good happy"
	},
	{
		name = "Anglerfish",
		direct = -1,
		speed = 30,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_A",
		direct = -1,
		speed = 20,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_B",
		direct = -1,
		speed = 20,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_C",
		direct = -1,
		speed = 20,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_D",
		direct = -1,
		speed = 10,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_E",
		direct = -1,
		speed = 30,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Fish_manjuu",
		direct = -1,
		speed = 20,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Seal",
		direct = -1,
		speed = 30,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Submarine",
		direct = -1,
		speed = 30,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	},
	{
		name = "Sunfish",
		direct = -1,
		speed = 30,
		type = "item type back",
		act = "item act dynamic",
		scene = "item scene back",
		catch = "item catch unable",
		create_range = {
			-9999,
			9999,
			130,
			600
		},
		move_range = {
			-400,
			1800,
			0,
			0
		}
	}
}
local var_0_28 = 500
local var_0_29 = 300
local var_0_30 = 200
local var_0_31 = 200
local var_0_32 = 45
local var_0_33 = 2.5
local var_0_34 = 50
local var_0_35 = 100
local var_0_36 = 580
local var_0_37 = 130
local var_0_38 = {
	{
		color = "8dff1e",
		font = 44,
		score = 500
	},
	{
		color = "d0fb09",
		font = 44,
		score = 400
	},
	{
		color = "ffec1e",
		font = 44,
		score = 300
	},
	{
		score = 200,
		color = "fcdc2a"
	},
	{
		score = 100,
		color = "f1b524"
	},
	{
		score = 0,
		color = "ffa024"
	},
	{
		score = -100,
		color = "680c00"
	},
	{
		score = -200,
		color = "6f1807"
	}
}
local var_0_39 = "char apply position"
local var_0_40 = "char apply move"
local var_0_41 = "char apply act"
local var_0_42 = {}

;({
	posX = -1200
}).type = "char apply position"
;({})[1] = {
	posX = -1200
}
;({})[2] = {
	trigger = "moveA",
	type = "char apply act"
}
;({})[3] = {
	sync = true,
	direct = -1,
	offsetX = -50,
	type = "char apply move",
	moveToX = {
		300,
		400
	}
}
;({})[4] = {
	time = 2,
	trigger = "actA",
	type = "char apply act"
}
;({})[5] = {
	time = 2,
	trigger = "actB",
	type = "char apply act"
}
;({})[6] = {
	time = 0,
	trigger = "moveB",
	type = "char apply act"
}
;({})[7] = {
	direct = -1,
	type = "char apply move",
	moveToX = {
		2000,
		2000
	}
}
;({
	speed = 3,
	tf = "Shiratsuyu",
	id = 1,
	bindIds = {
		2
	}
}).actions = {}
;({})[1] = {
	speed = 3,
	tf = "Shiratsuyu",
	id = 1,
	bindIds = {
		2
	}
}
;({})[2] = {
	id = 2,
	tf = "Shigure",
	speed = 3,
	actions = {
		{
			posX = 1200,
			type = "char apply position"
		},
		{
			trigger = "moveA",
			type = "char apply act"
		},
		{
			sync = true,
			direct = -1,
			offsetX = 50,
			type = "char apply move"
		},
		{
			time = 2,
			trigger = "actA",
			type = "char apply act"
		},
		{
			time = 2,
			trigger = "actB",
			type = "char apply act"
		},
		{
			time = 0,
			trigger = "moveB",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				2100,
				2200
			}
		}
	}
}
;({})[3] = {
	id = 3,
	tf = "eldridge",
	speed = 2,
	actions = {
		{
			posX = -1200,
			type = "char apply position"
		},
		{
			trigger = "move",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				100,
				300
			}
		},
		{
			trigger = "act",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				600,
				700
			}
		},
		{
			trigger = "act",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				1300,
				1300
			}
		}
	}
}
;({})[4] = {
	id = 4,
	tf = "bombBoat",
	speed = 4,
	actions = {
		{
			posX = 1200,
			type = "char apply position"
		},
		{
			trigger = "move",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				-1100,
				-1300
			}
		}
	}
}
;({})[5] = {
	id = 5,
	tf = "Fleet",
	speed = 3,
	actions = {
		{
			posX = -1200,
			type = "char apply position"
		},
		{
			trigger = "move",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				500,
				700
			}
		},
		{
			time = 4,
			trigger = "act",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				1300,
				1500
			}
		}
	}
}
;({})[6] = {
	id = 6,
	tf = "Glowworm",
	speed = 4,
	actions = {
		{
			posX = 1200,
			type = "char apply position"
		},
		{
			trigger = "move",
			type = "char apply act"
		},
		{
			direct = -1,
			type = "char apply move",
			moveToX = {
				-550,
				-1000
			}
		},
		{
			time = 2,
			trigger = "act",
			type = "char apply act"
		}
	}
}

local var_0_43 = {
	25,
	30
}
local var_0_44 = {
	1,
	3,
	4,
	5,
	6
}
local var_0_45 = {
	"actA",
	"actB"
}
local var_0_46 = {
	10,
	15
}

local function var_0_47(arg_1_0, arg_1_1)
	({
		ctor = function(arg_2_0)
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._boatTf = findTF(arg_1_0, "boat")
			arg_2_0._event = arg_1_1
			arg_2_0._hookTf = findTF(arg_2_0._boatTf, "body/hook")
			arg_2_0._hookContent = findTF(arg_2_0._hookTf, "container/content")
			arg_2_0._hookCollider = findTF(arg_2_0._hookTf, "container/collider")
			arg_2_0._sceneContent = findTF(arg_2_0._sceneTf, "container/content")
			arg_2_0.hookAnimator = GetComponent(findTF(arg_2_0._hookTf, "bottom"), typeof(Animator))
			arg_2_0.hookMaskAnimator = GetComponent(findTF(arg_2_0._hookTf, "mask/img"), typeof(Animator))
			arg_2_0.captainAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(Animator))

			GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(DftAniEvent)):SetEndEvent(function()
				if arg_2_0.inGoodAct then
					arg_2_0.inGoodAct = false
				end

				return
			end)

			arg_2_0.marinerAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/mariner/img"), typeof(Animator))

			return
		end,
		start = function(arg_4_0)
			arg_4_0._hookTf.sizeDelta = Vector2(0, 1)
			arg_4_0.boatState = var_0_11
			arg_4_0.hookRotation = var_0_32
			arg_4_0.hookRotationSpeed = 0
			arg_4_0.hookTargetRotation = var_0_32
			arg_4_0.throwHook = false
			arg_4_0.inGoodAct = false

			if arg_4_0.catchItem then
				destroy(arg_4_0.catchItem.tf)

				arg_4_0.catchItem = nil
			end

			arg_4_0.marinerActTime = nil
			arg_4_0.marinerActName = nil

			arg_4_0:leaveItem()

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.boatState == var_0_11 then
				arg_5_0:checkChangeRotation()

				arg_5_0.hookRotation = arg_5_0.hookRotation + arg_5_0:getSpringRotation()
				arg_5_0._hookTf.localEulerAngles = Vector3(0, 0, arg_5_0.hookRotation)
			elseif arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0._hookTf.sizeDelta = Vector2(0, arg_5_0._hookTf.sizeDelta.y + var_0_30 * Time.deltaTime)

					if arg_5_0._hookTf.sizeDelta.y * math.cos(math.deg2Rad * math.abs(arg_5_0.hookRotation)) > var_0_29 or arg_5_0._hookTf.sizeDelta.y > var_0_28 then
						arg_5_0.throwHook = false
					end
				else
					local var_5_0 = arg_5_0:hookBack()

					if not arg_5_0.catchItem and var_5_0 then
						arg_5_0.boatState = var_0_11
					elseif arg_5_0.catchItem then
						if (arg_5_0.catchItem.data.catch == var_0_16 or arg_5_0.catchItem.data.act == var_0_14) and arg_5_0._sceneContent:InverseTransformPoint(arg_5_0._hookContent.position).y > var_0_36 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						elseif var_5_0 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						end
					end
				end
			elseif arg_5_0.boatState == var_0_13 then
				if not arg_5_0:hookBack() then
					return
				end

				if arg_5_0.inGoodAct then
					return
				end

				arg_5_0.boatState = var_0_11
			end

			if arg_5_0.boatState == var_0_12 and arg_5_0.throwHook then
				arg_5_0.hookAnimator:SetBool("hook", true)
				arg_5_0.hookMaskAnimator:SetBool("hook", true)
			else
				arg_5_0.hookAnimator:SetBool("hook", false)
				arg_5_0.hookMaskAnimator:SetBool("hook", false)
			end

			if arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0.captainAnimator:SetInteger("state", 4)
				else
					local var_5_1 = 1

					if arg_5_0.catchItem then
						var_5_1 = arg_5_0.catchItem.data.catch_speed >= 100 and 1 or arg_5_0.catchItem.data.catch_speed >= 50 and arg_5_0.catchItem.data.catch_speed <= 100 and 2 or 3
					end

					arg_5_0.captainAnimator:SetInteger("state", var_5_1)
				end
			else
				arg_5_0.captainAnimator:SetInteger("state", 0)
			end

			if not arg_5_0.marinerActTime then
				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			elseif arg_5_0.marinerActTime <= 0 then
				arg_5_0.marinerAnimator:SetTrigger(arg_5_0.marinerActName)

				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			else
				arg_5_0.marinerActTime = arg_5_0.marinerActTime - Time.deltaTime
			end

			return
		end,
		hookBack = function(arg_6_0)
			if arg_6_0._hookTf.sizeDelta.y > 1 then
				local var_6_0 = var_0_31 * Time.deltaTime

				if arg_6_0.catchItem then
					var_6_0 = arg_6_0.catchItem.data.catch_speed * Time.deltaTime
				end

				arg_6_0._hookTf.sizeDelta = Vector2(0, arg_6_0._hookTf.sizeDelta.y - var_6_0)

				return false
			elseif arg_6_0._hookTf.sizeDelta.y < 1 then
				arg_6_0._hookTf.sizeDelta = Vector2(0, 1)

				return false
			end

			return true
		end,
		leaveItem = function(arg_7_0)
			if arg_7_0.catchItem then
				arg_7_0._event:emit(var_0_10, arg_7_0.catchItem, function()
					return
				end)

				arg_7_0.inGoodAct = true

				if arg_7_0.catchItem.data.good == var_0_18 then
					arg_7_0.captainAnimator:SetTrigger("happy")
					arg_7_0.marinerAnimator:SetTrigger("happy")
				elseif arg_7_0.catchItem.data.good == var_0_20 then
					arg_7_0.captainAnimator:SetTrigger("release")
				elseif arg_7_0.catchItem.data.good == var_0_19 then
					arg_7_0.captainAnimator:SetTrigger("surprise")
					arg_7_0.marinerAnimator:SetTrigger("surprise")
				elseif arg_7_0.catchItem.data.good == var_0_21 then
					arg_7_0.inGoodAct = false
				end

				arg_7_0.catchItem = nil
			end

			return
		end,
		throw = function(arg_9_0)
			if arg_9_0.boatState ~= var_0_11 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			arg_9_0.throwHook = true
			arg_9_0.boatState = var_0_12

			return
		end,
		setCatchItem = function(arg_10_0, arg_10_1)
			if arg_10_0.boatState == var_0_12 and arg_10_0.throwHook then
				arg_10_0.catchItem = arg_10_1
				arg_10_0.throwHook = false
				arg_10_1.tf.localScale = Vector3(math.sign(arg_10_1.tf.localScale.x), 1, 1)

				SetParent(arg_10_1.tf, arg_10_0._hookContent)

				arg_10_1.tf.anchoredPosition = Vector2(0, 0)

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		getSpringRotation = function(arg_11_0)
			arg_11_0.hookRotationSpeed = arg_11_0.hookRotationSpeed + math.sign(arg_11_0.hookTargetRotation) * var_0_33

			if math.abs(arg_11_0.hookRotationSpeed) > var_0_34 then
				arg_11_0.hookRotationSpeed = var_0_34 * math.sign(arg_11_0.hookTargetRotation)
			end

			return arg_11_0.hookRotationSpeed * Time.deltaTime
		end,
		checkChangeRotation = function(arg_12_0)
			if arg_12_0.hookTargetRotation > 0 and arg_12_0.hookRotation > arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			elseif arg_12_0.hookTargetRotation < 0 and arg_12_0.hookRotation < arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			end

			return
		end,
		inCatch = function(arg_13_0)
			return arg_13_0.boatState == var_0_12 and arg_13_0.throwHook
		end,
		getHookPosition = function(arg_14_0)
			return arg_14_0._hookCollider.position
		end,
		gameOver = function(arg_15_0)
			arg_15_0.captainAnimator:SetTrigger("end")
			arg_15_0.marinerAnimator:SetTrigger("end")

			return
		end,
		destroy = function(arg_16_0)
			return
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._boatTf = findTF(arg_1_0, "boat")
			arg_2_0._event = arg_1_1
			arg_2_0._hookTf = findTF(arg_2_0._boatTf, "body/hook")
			arg_2_0._hookContent = findTF(arg_2_0._hookTf, "container/content")
			arg_2_0._hookCollider = findTF(arg_2_0._hookTf, "container/collider")
			arg_2_0._sceneContent = findTF(arg_2_0._sceneTf, "container/content")
			arg_2_0.hookAnimator = GetComponent(findTF(arg_2_0._hookTf, "bottom"), typeof(Animator))
			arg_2_0.hookMaskAnimator = GetComponent(findTF(arg_2_0._hookTf, "mask/img"), typeof(Animator))
			arg_2_0.captainAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(Animator))

			GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(DftAniEvent)):SetEndEvent(function()
				if arg_2_0.inGoodAct then
					arg_2_0.inGoodAct = false
				end

				return
			end)

			arg_2_0.marinerAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/mariner/img"), typeof(Animator))

			return
		end,
		start = function(arg_4_0)
			arg_4_0._hookTf.sizeDelta = Vector2(0, 1)
			arg_4_0.boatState = var_0_11
			arg_4_0.hookRotation = var_0_32
			arg_4_0.hookRotationSpeed = 0
			arg_4_0.hookTargetRotation = var_0_32
			arg_4_0.throwHook = false
			arg_4_0.inGoodAct = false

			if arg_4_0.catchItem then
				destroy(arg_4_0.catchItem.tf)

				arg_4_0.catchItem = nil
			end

			arg_4_0.marinerActTime = nil
			arg_4_0.marinerActName = nil

			arg_4_0:leaveItem()

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.boatState == var_0_11 then
				arg_5_0:checkChangeRotation()

				arg_5_0.hookRotation = arg_5_0.hookRotation + arg_5_0:getSpringRotation()
				arg_5_0._hookTf.localEulerAngles = Vector3(0, 0, arg_5_0.hookRotation)
			elseif arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0._hookTf.sizeDelta = Vector2(0, arg_5_0._hookTf.sizeDelta.y + var_0_30 * Time.deltaTime)

					if arg_5_0._hookTf.sizeDelta.y * math.cos(math.deg2Rad * math.abs(arg_5_0.hookRotation)) > var_0_29 or arg_5_0._hookTf.sizeDelta.y > var_0_28 then
						arg_5_0.throwHook = false
					end
				else
					local var_5_0 = arg_5_0:hookBack()

					if not arg_5_0.catchItem and var_5_0 then
						arg_5_0.boatState = var_0_11
					elseif arg_5_0.catchItem then
						if (arg_5_0.catchItem.data.catch == var_0_16 or arg_5_0.catchItem.data.act == var_0_14) and arg_5_0._sceneContent:InverseTransformPoint(arg_5_0._hookContent.position).y > var_0_36 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						elseif var_5_0 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						end
					end
				end
			elseif arg_5_0.boatState == var_0_13 then
				if not arg_5_0:hookBack() then
					return
				end

				if arg_5_0.inGoodAct then
					return
				end

				arg_5_0.boatState = var_0_11
			end

			if arg_5_0.boatState == var_0_12 and arg_5_0.throwHook then
				arg_5_0.hookAnimator:SetBool("hook", true)
				arg_5_0.hookMaskAnimator:SetBool("hook", true)
			else
				arg_5_0.hookAnimator:SetBool("hook", false)
				arg_5_0.hookMaskAnimator:SetBool("hook", false)
			end

			if arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0.captainAnimator:SetInteger("state", 4)
				else
					local var_5_1 = 1

					if arg_5_0.catchItem then
						var_5_1 = arg_5_0.catchItem.data.catch_speed >= 100 and 1 or arg_5_0.catchItem.data.catch_speed >= 50 and arg_5_0.catchItem.data.catch_speed <= 100 and 2 or 3
					end

					arg_5_0.captainAnimator:SetInteger("state", var_5_1)
				end
			else
				arg_5_0.captainAnimator:SetInteger("state", 0)
			end

			if not arg_5_0.marinerActTime then
				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			elseif arg_5_0.marinerActTime <= 0 then
				arg_5_0.marinerAnimator:SetTrigger(arg_5_0.marinerActName)

				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			else
				arg_5_0.marinerActTime = arg_5_0.marinerActTime - Time.deltaTime
			end

			return
		end,
		hookBack = function(arg_6_0)
			if arg_6_0._hookTf.sizeDelta.y > 1 then
				local var_6_0 = var_0_31 * Time.deltaTime

				if arg_6_0.catchItem then
					var_6_0 = arg_6_0.catchItem.data.catch_speed * Time.deltaTime
				end

				arg_6_0._hookTf.sizeDelta = Vector2(0, arg_6_0._hookTf.sizeDelta.y - var_6_0)

				return false
			elseif arg_6_0._hookTf.sizeDelta.y < 1 then
				arg_6_0._hookTf.sizeDelta = Vector2(0, 1)

				return false
			end

			return true
		end,
		leaveItem = function(arg_7_0)
			if arg_7_0.catchItem then
				arg_7_0._event:emit(var_0_10, arg_7_0.catchItem, function()
					return
				end)

				arg_7_0.inGoodAct = true

				if arg_7_0.catchItem.data.good == var_0_18 then
					arg_7_0.captainAnimator:SetTrigger("happy")
					arg_7_0.marinerAnimator:SetTrigger("happy")
				elseif arg_7_0.catchItem.data.good == var_0_20 then
					arg_7_0.captainAnimator:SetTrigger("release")
				elseif arg_7_0.catchItem.data.good == var_0_19 then
					arg_7_0.captainAnimator:SetTrigger("surprise")
					arg_7_0.marinerAnimator:SetTrigger("surprise")
				elseif arg_7_0.catchItem.data.good == var_0_21 then
					arg_7_0.inGoodAct = false
				end

				arg_7_0.catchItem = nil
			end

			return
		end,
		throw = function(arg_9_0)
			if arg_9_0.boatState ~= var_0_11 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			arg_9_0.throwHook = true
			arg_9_0.boatState = var_0_12

			return
		end,
		setCatchItem = function(arg_10_0, arg_10_1)
			if arg_10_0.boatState == var_0_12 and arg_10_0.throwHook then
				arg_10_0.catchItem = arg_10_1
				arg_10_0.throwHook = false
				arg_10_1.tf.localScale = Vector3(math.sign(arg_10_1.tf.localScale.x), 1, 1)

				SetParent(arg_10_1.tf, arg_10_0._hookContent)

				arg_10_1.tf.anchoredPosition = Vector2(0, 0)

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		getSpringRotation = function(arg_11_0)
			arg_11_0.hookRotationSpeed = arg_11_0.hookRotationSpeed + math.sign(arg_11_0.hookTargetRotation) * var_0_33

			if math.abs(arg_11_0.hookRotationSpeed) > var_0_34 then
				arg_11_0.hookRotationSpeed = var_0_34 * math.sign(arg_11_0.hookTargetRotation)
			end

			return arg_11_0.hookRotationSpeed * Time.deltaTime
		end,
		checkChangeRotation = function(arg_12_0)
			if arg_12_0.hookTargetRotation > 0 and arg_12_0.hookRotation > arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			elseif arg_12_0.hookTargetRotation < 0 and arg_12_0.hookRotation < arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			end

			return
		end,
		inCatch = function(arg_13_0)
			return arg_13_0.boatState == var_0_12 and arg_13_0.throwHook
		end,
		getHookPosition = function(arg_14_0)
			return arg_14_0._hookCollider.position
		end,
		gameOver = function(arg_15_0)
			arg_15_0.captainAnimator:SetTrigger("end")
			arg_15_0.marinerAnimator:SetTrigger("end")

			return
		end,
		destroy = function(arg_16_0)
			return
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._boatTf = findTF(arg_1_0, "boat")
			arg_2_0._event = arg_1_1
			arg_2_0._hookTf = findTF(arg_2_0._boatTf, "body/hook")
			arg_2_0._hookContent = findTF(arg_2_0._hookTf, "container/content")
			arg_2_0._hookCollider = findTF(arg_2_0._hookTf, "container/collider")
			arg_2_0._sceneContent = findTF(arg_2_0._sceneTf, "container/content")
			arg_2_0.hookAnimator = GetComponent(findTF(arg_2_0._hookTf, "bottom"), typeof(Animator))
			arg_2_0.hookMaskAnimator = GetComponent(findTF(arg_2_0._hookTf, "mask/img"), typeof(Animator))
			arg_2_0.captainAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(Animator))

			GetComponent(findTF(arg_2_0._boatTf, "body/captain/img"), typeof(DftAniEvent)):SetEndEvent(function()
				if arg_2_0.inGoodAct then
					arg_2_0.inGoodAct = false
				end

				return
			end)

			arg_2_0.marinerAnimator = GetComponent(findTF(arg_2_0._boatTf, "body/mariner/img"), typeof(Animator))

			return
		end,
		start = function(arg_4_0)
			arg_4_0._hookTf.sizeDelta = Vector2(0, 1)
			arg_4_0.boatState = var_0_11
			arg_4_0.hookRotation = var_0_32
			arg_4_0.hookRotationSpeed = 0
			arg_4_0.hookTargetRotation = var_0_32
			arg_4_0.throwHook = false
			arg_4_0.inGoodAct = false

			if arg_4_0.catchItem then
				destroy(arg_4_0.catchItem.tf)

				arg_4_0.catchItem = nil
			end

			arg_4_0.marinerActTime = nil
			arg_4_0.marinerActName = nil

			arg_4_0:leaveItem()

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.boatState == var_0_11 then
				arg_5_0:checkChangeRotation()

				arg_5_0.hookRotation = arg_5_0.hookRotation + arg_5_0:getSpringRotation()
				arg_5_0._hookTf.localEulerAngles = Vector3(0, 0, arg_5_0.hookRotation)
			elseif arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0._hookTf.sizeDelta = Vector2(0, arg_5_0._hookTf.sizeDelta.y + var_0_30 * Time.deltaTime)

					if arg_5_0._hookTf.sizeDelta.y * math.cos(math.deg2Rad * math.abs(arg_5_0.hookRotation)) > var_0_29 or arg_5_0._hookTf.sizeDelta.y > var_0_28 then
						arg_5_0.throwHook = false
					end
				else
					local var_5_0 = arg_5_0:hookBack()

					if not arg_5_0.catchItem and var_5_0 then
						arg_5_0.boatState = var_0_11
					elseif arg_5_0.catchItem then
						if (arg_5_0.catchItem.data.catch == var_0_16 or arg_5_0.catchItem.data.act == var_0_14) and arg_5_0._sceneContent:InverseTransformPoint(arg_5_0._hookContent.position).y > var_0_36 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						elseif var_5_0 then
							arg_5_0.boatState = var_0_13

							arg_5_0:leaveItem()
						end
					end
				end
			elseif arg_5_0.boatState == var_0_13 then
				if not arg_5_0:hookBack() then
					return
				end

				if arg_5_0.inGoodAct then
					return
				end

				arg_5_0.boatState = var_0_11
			end

			if arg_5_0.boatState == var_0_12 and arg_5_0.throwHook then
				arg_5_0.hookAnimator:SetBool("hook", true)
				arg_5_0.hookMaskAnimator:SetBool("hook", true)
			else
				arg_5_0.hookAnimator:SetBool("hook", false)
				arg_5_0.hookMaskAnimator:SetBool("hook", false)
			end

			if arg_5_0.boatState == var_0_12 then
				if arg_5_0.throwHook then
					arg_5_0.captainAnimator:SetInteger("state", 4)
				else
					local var_5_1 = 1

					if arg_5_0.catchItem then
						var_5_1 = arg_5_0.catchItem.data.catch_speed >= 100 and 1 or arg_5_0.catchItem.data.catch_speed >= 50 and arg_5_0.catchItem.data.catch_speed <= 100 and 2 or 3
					end

					arg_5_0.captainAnimator:SetInteger("state", var_5_1)
				end
			else
				arg_5_0.captainAnimator:SetInteger("state", 0)
			end

			if not arg_5_0.marinerActTime then
				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			elseif arg_5_0.marinerActTime <= 0 then
				arg_5_0.marinerAnimator:SetTrigger(arg_5_0.marinerActName)

				arg_5_0.marinerActTime = math.random(var_0_46[1], var_0_46[2])
				arg_5_0.marinerActName = var_0_45[math.random(1, #var_0_45)]
			else
				arg_5_0.marinerActTime = arg_5_0.marinerActTime - Time.deltaTime
			end

			return
		end,
		hookBack = function(arg_6_0)
			if arg_6_0._hookTf.sizeDelta.y > 1 then
				local var_6_0 = var_0_31 * Time.deltaTime

				if arg_6_0.catchItem then
					var_6_0 = arg_6_0.catchItem.data.catch_speed * Time.deltaTime
				end

				arg_6_0._hookTf.sizeDelta = Vector2(0, arg_6_0._hookTf.sizeDelta.y - var_6_0)

				return false
			elseif arg_6_0._hookTf.sizeDelta.y < 1 then
				arg_6_0._hookTf.sizeDelta = Vector2(0, 1)

				return false
			end

			return true
		end,
		leaveItem = function(arg_7_0)
			if arg_7_0.catchItem then
				arg_7_0._event:emit(var_0_10, arg_7_0.catchItem, function()
					return
				end)

				arg_7_0.inGoodAct = true

				if arg_7_0.catchItem.data.good == var_0_18 then
					arg_7_0.captainAnimator:SetTrigger("happy")
					arg_7_0.marinerAnimator:SetTrigger("happy")
				elseif arg_7_0.catchItem.data.good == var_0_20 then
					arg_7_0.captainAnimator:SetTrigger("release")
				elseif arg_7_0.catchItem.data.good == var_0_19 then
					arg_7_0.captainAnimator:SetTrigger("surprise")
					arg_7_0.marinerAnimator:SetTrigger("surprise")
				elseif arg_7_0.catchItem.data.good == var_0_21 then
					arg_7_0.inGoodAct = false
				end

				arg_7_0.catchItem = nil
			end

			return
		end,
		throw = function(arg_9_0)
			if arg_9_0.boatState ~= var_0_11 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			arg_9_0.throwHook = true
			arg_9_0.boatState = var_0_12

			return
		end,
		setCatchItem = function(arg_10_0, arg_10_1)
			if arg_10_0.boatState == var_0_12 and arg_10_0.throwHook then
				arg_10_0.catchItem = arg_10_1
				arg_10_0.throwHook = false
				arg_10_1.tf.localScale = Vector3(math.sign(arg_10_1.tf.localScale.x), 1, 1)

				SetParent(arg_10_1.tf, arg_10_0._hookContent)

				arg_10_1.tf.anchoredPosition = Vector2(0, 0)

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		getSpringRotation = function(arg_11_0)
			arg_11_0.hookRotationSpeed = arg_11_0.hookRotationSpeed + math.sign(arg_11_0.hookTargetRotation) * var_0_33

			if math.abs(arg_11_0.hookRotationSpeed) > var_0_34 then
				arg_11_0.hookRotationSpeed = var_0_34 * math.sign(arg_11_0.hookTargetRotation)
			end

			return arg_11_0.hookRotationSpeed * Time.deltaTime
		end,
		checkChangeRotation = function(arg_12_0)
			if arg_12_0.hookTargetRotation > 0 and arg_12_0.hookRotation > arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			elseif arg_12_0.hookTargetRotation < 0 and arg_12_0.hookRotation < arg_12_0.hookTargetRotation then
				arg_12_0.hookTargetRotation = -arg_12_0.hookTargetRotation
			end

			return
		end,
		inCatch = function(arg_13_0)
			return arg_13_0.boatState == var_0_12 and arg_13_0.throwHook
		end,
		getHookPosition = function(arg_14_0)
			return arg_14_0._hookCollider.position
		end,
		gameOver = function(arg_15_0)
			arg_15_0.captainAnimator:SetTrigger("end")
			arg_15_0.marinerAnimator:SetTrigger("end")

			return
		end,
		destroy = function(arg_16_0)
			return
		end
	}
end

local function var_0_48(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	({
		ctor = function(arg_18_0)
			arg_18_0._event = arg_17_3
			arg_18_0._sceneTpls = findTF(arg_17_0, "sceneTpls")
			arg_18_0._backSceneTpls = findTF(arg_17_1, "bgTpls")
			arg_18_0._gameMission = arg_17_2 + 1

			local var_18_0 = findTF(arg_17_0, "container")

			arg_18_0._createBounds = {
				var_18_0.sizeDelta.x,
				var_18_0.sizeDelta.y
			}
			arg_18_0._parentTf = findTF(var_18_0, "content")
			arg_18_0._backParentTf = findTF(arg_17_1, "container/content")
			arg_18_0.items = {}

			return
		end,
		getParentInversePos = function(arg_19_0, arg_19_1)
			return arg_19_1.data.scene and (arg_19_1.data.scene == var_0_22 and arg_19_0._backParentTf:InverseTransformPoint(arg_19_1.tf.position) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)
		end,
		addItemDone = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_20_0:getParentInversePos(arg_20_1)

			if arg_20_1.data.act == var_0_14 or arg_20_1.data.catch == var_0_16 then
				var_20_0.y = var_0_36
			end

			arg_20_1.tf.anchoredPosition = var_20_0

			arg_20_0:addItemParent(arg_20_1)

			arg_20_1.tf.localScale = Vector3(2.5 * math.sign(arg_20_1.tf.localScale.x), 2.5, 2.5)
			arg_20_1.tf.localEulerAngles = Vector3(0, 0, 0)
			arg_20_1.catchAble = false
			arg_20_1.targetRemove = true

			if arg_20_1.data.catch == var_0_15 then
				GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
					arg_20_0:destroyItem(arg_20_1)

					return
				end)
				GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("catch")

				goto label_20_0
			end

			::label_20_0::

			if arg_20_1.data.catch == var_0_16 then
				local var_20_1 = arg_20_1.data.leave_direct or 1

				arg_20_1.direct = var_20_1

				if var_20_1 * math.sign(arg_20_1.tf.localScale.x) == -1 then
					arg_20_1.targetX = arg_20_1.data.move_range[2] or arg_20_1.data.move_range[1]

					GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
						arg_20_1.moveAble = true

						return
					end)

					arg_20_1.moveAble = false

					GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("release")
					table.insert(arg_20_0.items, arg_20_1)

					return
				end
			end
		end,
		start = function(arg_23_0)
			arg_23_0:clearItems()
			arg_23_0:prepareItems()
			arg_23_0:setItemPosition()

			return
		end,
		clearItems = function(arg_24_0)
			for iter_24_0 = #arg_24_0.items, 1, -1 do
				arg_24_0:destroyItem((table.remove(arg_24_0.items, iter_24_0)))
			end

			arg_24_0.items = {}

			return
		end,
		prepareItems = function(arg_25_0)
			for iter_25_0, iter_25_1 in pairs(var_0_26[math.random(1, #var_0_26)]) do
				local var_25_0 = arg_25_0:getItemsByType(iter_25_1.type, iter_25_1.name)

				for iter_25_2 = 1, math.random(iter_25_1.amount[1], iter_25_1.amount[2]) do
					local var_25_1

					if iter_25_1.repeated then
						var_25_1 = var_25_0[math.random(1, #var_25_0)]
					elseif #var_25_0 > 0 then
						var_25_1 = table.remove(var_25_0, math.random(1, #var_25_0))
					end

					if var_25_1 then
						table.insert(arg_25_0.items, (arg_25_0:createItem(var_25_1)))
					end
				end
			end

			return
		end,
		getItemsByType = function(arg_26_0, arg_26_1, arg_26_2)
			for iter_26_0 = 1, #var_0_27 do
				if var_0_27[iter_26_0].type == arg_26_1 then
					if arg_26_2 then
						if table.contains(arg_26_2, var_0_27[iter_26_0].name) then
							table.insert({}, var_0_27[iter_26_0])
						end
					else
						table.insert({}, var_0_27[iter_26_0])
					end
				end
			end

			return {}
		end,
		getItemDataByName = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #var_0_27 do
				if var_0_27[iter_27_0].name == arg_27_1 then
					return var_0_27[iter_27_0]
				end
			end

			return nil
		end,
		createItem = function(arg_28_0, arg_28_1)
			({
				data = arg_28_1
			}).tf = nil
			;({
				data = arg_28_1
			}).targetX = nil
			;({
				data = arg_28_1
			}).targetY = nil
			;({
				data = arg_28_1
			}).direct = arg_28_1.direct or 1
			;({
				data = arg_28_1
			}).moveAble = true
			;({
				data = arg_28_1
			}).catchAble = true
			;({
				data = arg_28_1
			}).targetRemove = false
			;({
				data = arg_28_1
			}).interaction = not not arg_28_1.interaction
			;({
				data = arg_28_1
			}).interactionName = nil
			;({
				data = arg_28_1
			}).interactionTime = nil
			;({
				data = arg_28_1
			}).animStateIndex = nil
			;({
				data = arg_28_1
			}).nextAnimTime = nil

			arg_28_0:instantiateItem({
				data = arg_28_1
			})

			return {
				data = arg_28_1
			}
		end,
		instantiateItem = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_1.data.scene == var_0_22 and findTF(arg_29_0._backSceneTpls, arg_29_1.data.name) or findTF(arg_29_0._sceneTpls, arg_29_1.data.name)

			arg_29_1.tf = tf((Instantiate(var_29_0)))

			setActive(arg_29_1.tf, true)
			arg_29_0:addItemParent(arg_29_1)

			return
		end,
		addItemParent = function(arg_30_0, arg_30_1)
			if arg_30_1.data.scene then
				if arg_30_1.data.scene == var_0_22 then
					SetParent(arg_30_1.tf, arg_30_0._backParentTf)
				else
					SetParent(arg_30_1.tf, arg_30_0._parentTf)
				end
			else
				SetParent(arg_30_1.tf, arg_30_0._parentTf)
			end

			return
		end,
		setItemPosition = function(arg_31_0)
			if not arg_31_0.items or #arg_31_0.items == 0 then
				return
			end

			local var_31_0 = arg_31_0:mixSplitePos(arg_31_0:splitePositions(0, arg_31_0._createBounds[1]), (arg_31_0:splitePositions(0, arg_31_0._createBounds[2])))

			for iter_31_0 = 1, #arg_31_0.items do
				local var_31_1 = (function(arg_32_0)
					if arg_32_0 then
						for iter_32_0 = 1, #var_31_0 do
							if arg_32_0[1] <= var_31_0[iter_32_0][1][1] and var_31_0[iter_32_0][1][2] <= arg_32_0[2] and arg_32_0[3] <= var_31_0[iter_32_0][2][1] and var_31_0[iter_32_0][2][2] <= arg_32_0[4] then
								table.insert({}, iter_32_0)
							end
						end

						if #{} > 0 then
							return table.remove(var_31_0, ({})[math.random(1, #{})])
						end
					end

					if #var_31_0 > 0 then
						return table.remove(var_31_0, math.random(1, #var_31_0))
					else
						return {
							{
								0,
								1300
							},
							{
								100,
								300
							}
						}
					end

					return
				end)(arg_31_0.items[iter_31_0].data.create_range)

				if var_31_1 then
					arg_31_0.items[iter_31_0].tf.anchoredPosition = Vector2(var_31_1[1][1] + math.random() * (var_31_1[1][2] - var_31_1[1][1]) / 2, var_31_1[2][1] + math.random() * (var_31_1[2][2] - var_31_1[2][1]) / 2)
				end
			end

			return
		end,
		mixSplitePos = function(arg_33_0, arg_33_1, arg_33_2)
			for iter_33_0 = 1, #arg_33_1 do
				for iter_33_1 = 1, #arg_33_2 do
					table.insert({}, {
						arg_33_1[iter_33_0],
						arg_33_2[iter_33_1]
					})
				end
			end

			return {}
		end,
		splitePositions = function(arg_34_0, arg_34_1, arg_34_2)
			if not arg_34_1 or not arg_34_2 or arg_34_2 < arg_34_1 then
				return nil
			end

			for iter_34_0 = 1, (arg_34_2 - arg_34_1) / var_0_37 do
				table.insert({}, {
					arg_34_1 + (iter_34_0 - 1) * var_0_37,
					arg_34_1 + iter_34_0 * var_0_37
				})
			end

			return {}
		end,
		getItemByPos = function(arg_35_0, arg_35_1)
			local var_35_0 = arg_35_0:checkPosInCollider(arg_35_1)

			if var_35_0 then
				if var_35_0.data.catch_rule then
					if table.contains(var_35_0.data.catch_rule.state, (GetComponent(var_35_0.tf, typeof(Animator)):GetInteger("state"))) then
						arg_35_0:addItemDone(var_35_0)

						return (arg_35_0:createItem(arg_35_0:getItemDataByName(var_35_0.data.catch_rule.targetName)))
					end
				else
					return var_35_0
				end

				return var_35_0
			end

			return nil
		end,
		checkPosInCollider = function(arg_36_0, arg_36_1)
			local var_36_0 = arg_36_0._parentTf:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z)

			for iter_36_0 = 1, #arg_36_0.items do
				if arg_36_0.items[iter_36_0].data.catch ~= var_0_17 then
					if math.abs(var_36_0.x - arg_36_0.items[iter_36_0].tf.anchoredPosition.x) < var_0_35 and math.abs(var_36_0.y - arg_36_0.items[iter_36_0].tf.anchoredPosition.y) < var_0_35 and arg_36_0.items[iter_36_0].data.catch ~= var_0_17 and arg_36_0.items[iter_36_0].catchAble then
						table.insert({}, arg_36_0.items[iter_36_0])
					end
				end
			end

			for iter_36_1 = 1, #{} do
				local var_36_1 = findTF(({})[iter_36_1].tf, "collider")
				local var_36_2, var_36_3, var_36_4, var_36_5, var_36_6

				if not var_36_1 then
					print("can not find collider by" .. ({})[iter_36_1].data.name)

					goto label_36_0

					var_36_2 = arg_36_0
					var_36_3 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_4 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_5 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin)
					var_36_6 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin)
				end

				if arg_36_0:isPointInMatrix(var_36_3, var_36_4, var_36_5, var_36_6, (var_36_1:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z))) then
					return arg_36_0:removeItem(({})[iter_36_1])
				end

				::label_36_0::
			end

			return nil
		end,
		removeItem = function(arg_37_0, arg_37_1)
			for iter_37_0 = 1, #arg_37_0.items do
				if arg_37_0.items[iter_37_0] == arg_37_1 then
					return table.remove(arg_37_0.items, iter_37_0)
				end
			end

			return
		end,
		getCross = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
			return (arg_38_2.x - arg_38_1.x) * (arg_38_3.y - arg_38_1.y) - (arg_38_3.x - arg_38_1.x) * (arg_38_2.y - arg_38_1.y)
		end,
		isPointInMatrix = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
			return arg_39_0:getCross(arg_39_1, arg_39_2, arg_39_5) * arg_39_0:getCross(arg_39_3, arg_39_4, arg_39_5) >= 0 and arg_39_0:getCross(arg_39_2, arg_39_3, arg_39_5) * arg_39_0:getCross(arg_39_4, arg_39_1, arg_39_5) >= 0
		end,
		step = function(arg_40_0)
			for iter_40_0 = #arg_40_0.items, 1, -1 do
				local var_40_0 = arg_40_0.items[iter_40_0]

				if arg_40_0.items[iter_40_0].data.act == var_0_14 and var_40_0.moveAble then
					local var_40_3 = math.sign(var_40_0.targetX - var_40_0.tf.anchoredPosition.x)

					if not var_40_0.targetX then
						local var_40_1 = var_40_0.data.move_range[1]
						local var_40_2 = var_40_0.data.move_range[2]

						var_40_0.targetX = var_40_0.tf.anchoredPosition.x == var_40_0.data.move_range[1] and var_40_2 or var_40_0.tf.anchoredPosition.x == var_40_2 and var_40_1 or math.random() > 0.5 and var_40_1 or var_40_2

						goto label_40_0
					end

					::label_40_0::

					if var_40_0.targetRemove then
						do
							local var_40_4 = var_40_0.data.release_speed or var_40_0.data.speed

							var_40_0.tf.localScale = Vector3(-1 * var_40_3 * var_40_0.direct * math.abs(var_40_0.tf.localScale.x), var_40_0.tf.localScale.y, var_40_0.tf.localScale.z)
							var_40_0.tf.anchoredPosition = Vector2(var_40_0.tf.anchoredPosition.x + var_40_3 * var_40_4 * Time.deltaTime, var_40_0.tf.anchoredPosition.y)

							if var_40_3 == 1 and var_40_0.tf.anchoredPosition.x >= var_40_0.targetX or var_40_3 == -1 and var_40_0.tf.anchoredPosition.x <= var_40_0.targetX then
								var_40_0.tf.anchoredPosition = Vector2(var_40_0.targetX, var_40_0.tf.anchoredPosition.y)
								var_40_0.targetX = nil
							end
						end

						if var_40_0.data.anim_data then
							local var_40_5 = var_40_0.data.anim_data.state_change

							if var_40_0.data.anim_data.state_change and var_40_0.data.anim_data.time then
								if not var_40_0.nextAnimTime then
									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = 1
								elseif var_40_0.nextAnimTime <= 0 then
									GetComponent(var_40_0.tf, typeof(Animator)):SetInteger("state", var_40_5[var_40_0.animStateIndex])

									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = var_40_0.animStateIndex + 1
									var_40_0.animStateIndex = var_40_0.animStateIndex > #var_40_5 and 1 or var_40_0.animStateIndex
								else
									var_40_0.nextAnimTime = var_40_0.nextAnimTime - Time.deltaTime
								end
							end
						end

						if var_40_0.interaction and not var_40_0.targetRemove then
							if not var_40_0.interactionTime then
								var_40_0.interactionTime = math.random() * (var_40_0.data.interaction.time[2] - var_40_0.data.interaction.time[1]) + var_40_0.data.interaction.time[1]
								var_40_0.interactionName = var_40_0.data.interaction.parame[math.random(1, #var_40_0.data.interaction.parame)]
							elseif var_40_0.interactionTime <= 0 then
								GetComponent(var_40_0.tf, typeof(Animator)):SetTrigger(var_40_0.interactionName)

								var_40_0.interactionTime = nil
								var_40_0.interactionName = nil
							else
								var_40_0.interactionTime = var_40_0.interactionTime - Time.deltaTime
							end
						end

						if var_40_0.targetRemove and not var_40_0.targetX then
							table.remove(arg_40_0.items, iter_40_0)
							arg_40_0:destroyItem(var_40_0)
						end
					end
				end
			end

			return
		end,
		destroyItem = function(arg_41_0, arg_41_1)
			destroy(arg_41_1.tf)

			return
		end,
		destroy = function(arg_42_0)
			return
		end
	}).ctor({
		ctor = function(arg_18_0)
			arg_18_0._event = arg_17_3
			arg_18_0._sceneTpls = findTF(arg_17_0, "sceneTpls")
			arg_18_0._backSceneTpls = findTF(arg_17_1, "bgTpls")
			arg_18_0._gameMission = arg_17_2 + 1

			local var_18_0 = findTF(arg_17_0, "container")

			arg_18_0._createBounds = {
				var_18_0.sizeDelta.x,
				var_18_0.sizeDelta.y
			}
			arg_18_0._parentTf = findTF(var_18_0, "content")
			arg_18_0._backParentTf = findTF(arg_17_1, "container/content")
			arg_18_0.items = {}

			return
		end,
		getParentInversePos = function(arg_19_0, arg_19_1)
			return arg_19_1.data.scene and (arg_19_1.data.scene == var_0_22 and arg_19_0._backParentTf:InverseTransformPoint(arg_19_1.tf.position) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)
		end,
		addItemDone = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_20_0:getParentInversePos(arg_20_1)

			if arg_20_1.data.act == var_0_14 or arg_20_1.data.catch == var_0_16 then
				var_20_0.y = var_0_36
			end

			arg_20_1.tf.anchoredPosition = var_20_0

			arg_20_0:addItemParent(arg_20_1)

			arg_20_1.tf.localScale = Vector3(2.5 * math.sign(arg_20_1.tf.localScale.x), 2.5, 2.5)
			arg_20_1.tf.localEulerAngles = Vector3(0, 0, 0)
			arg_20_1.catchAble = false
			arg_20_1.targetRemove = true

			if arg_20_1.data.catch == var_0_15 then
				GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
					arg_20_0:destroyItem(arg_20_1)

					return
				end)
				GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("catch")

				goto label_20_0
			end

			::label_20_0::

			if arg_20_1.data.catch == var_0_16 then
				local var_20_1 = arg_20_1.data.leave_direct or 1

				arg_20_1.direct = var_20_1

				if var_20_1 * math.sign(arg_20_1.tf.localScale.x) == -1 then
					arg_20_1.targetX = arg_20_1.data.move_range[2] or arg_20_1.data.move_range[1]

					GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
						arg_20_1.moveAble = true

						return
					end)

					arg_20_1.moveAble = false

					GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("release")
					table.insert(arg_20_0.items, arg_20_1)

					return
				end
			end
		end,
		start = function(arg_23_0)
			arg_23_0:clearItems()
			arg_23_0:prepareItems()
			arg_23_0:setItemPosition()

			return
		end,
		clearItems = function(arg_24_0)
			for iter_24_0 = #arg_24_0.items, 1, -1 do
				arg_24_0:destroyItem((table.remove(arg_24_0.items, iter_24_0)))
			end

			arg_24_0.items = {}

			return
		end,
		prepareItems = function(arg_25_0)
			for iter_25_0, iter_25_1 in pairs(var_0_26[math.random(1, #var_0_26)]) do
				local var_25_0 = arg_25_0:getItemsByType(iter_25_1.type, iter_25_1.name)

				for iter_25_2 = 1, math.random(iter_25_1.amount[1], iter_25_1.amount[2]) do
					local var_25_1

					if iter_25_1.repeated then
						var_25_1 = var_25_0[math.random(1, #var_25_0)]
					elseif #var_25_0 > 0 then
						var_25_1 = table.remove(var_25_0, math.random(1, #var_25_0))
					end

					if var_25_1 then
						table.insert(arg_25_0.items, (arg_25_0:createItem(var_25_1)))
					end
				end
			end

			return
		end,
		getItemsByType = function(arg_26_0, arg_26_1, arg_26_2)
			for iter_26_0 = 1, #var_0_27 do
				if var_0_27[iter_26_0].type == arg_26_1 then
					if arg_26_2 then
						if table.contains(arg_26_2, var_0_27[iter_26_0].name) then
							table.insert({}, var_0_27[iter_26_0])
						end
					else
						table.insert({}, var_0_27[iter_26_0])
					end
				end
			end

			return {}
		end,
		getItemDataByName = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #var_0_27 do
				if var_0_27[iter_27_0].name == arg_27_1 then
					return var_0_27[iter_27_0]
				end
			end

			return nil
		end,
		createItem = function(arg_28_0, arg_28_1)
			({
				data = arg_28_1
			}).tf = nil
			;({
				data = arg_28_1
			}).targetX = nil
			;({
				data = arg_28_1
			}).targetY = nil
			;({
				data = arg_28_1
			}).direct = arg_28_1.direct or 1
			;({
				data = arg_28_1
			}).moveAble = true
			;({
				data = arg_28_1
			}).catchAble = true
			;({
				data = arg_28_1
			}).targetRemove = false
			;({
				data = arg_28_1
			}).interaction = not not arg_28_1.interaction
			;({
				data = arg_28_1
			}).interactionName = nil
			;({
				data = arg_28_1
			}).interactionTime = nil
			;({
				data = arg_28_1
			}).animStateIndex = nil
			;({
				data = arg_28_1
			}).nextAnimTime = nil

			arg_28_0:instantiateItem({
				data = arg_28_1
			})

			return {
				data = arg_28_1
			}
		end,
		instantiateItem = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_1.data.scene == var_0_22 and findTF(arg_29_0._backSceneTpls, arg_29_1.data.name) or findTF(arg_29_0._sceneTpls, arg_29_1.data.name)

			arg_29_1.tf = tf((Instantiate(var_29_0)))

			setActive(arg_29_1.tf, true)
			arg_29_0:addItemParent(arg_29_1)

			return
		end,
		addItemParent = function(arg_30_0, arg_30_1)
			if arg_30_1.data.scene then
				if arg_30_1.data.scene == var_0_22 then
					SetParent(arg_30_1.tf, arg_30_0._backParentTf)
				else
					SetParent(arg_30_1.tf, arg_30_0._parentTf)
				end
			else
				SetParent(arg_30_1.tf, arg_30_0._parentTf)
			end

			return
		end,
		setItemPosition = function(arg_31_0)
			if not arg_31_0.items or #arg_31_0.items == 0 then
				return
			end

			local var_31_0 = arg_31_0:mixSplitePos(arg_31_0:splitePositions(0, arg_31_0._createBounds[1]), (arg_31_0:splitePositions(0, arg_31_0._createBounds[2])))

			for iter_31_0 = 1, #arg_31_0.items do
				local var_31_1 = (function(arg_32_0)
					if arg_32_0 then
						for iter_32_0 = 1, #var_31_0 do
							if arg_32_0[1] <= var_31_0[iter_32_0][1][1] and var_31_0[iter_32_0][1][2] <= arg_32_0[2] and arg_32_0[3] <= var_31_0[iter_32_0][2][1] and var_31_0[iter_32_0][2][2] <= arg_32_0[4] then
								table.insert({}, iter_32_0)
							end
						end

						if #{} > 0 then
							return table.remove(var_31_0, ({})[math.random(1, #{})])
						end
					end

					if #var_31_0 > 0 then
						return table.remove(var_31_0, math.random(1, #var_31_0))
					else
						return {
							{
								0,
								1300
							},
							{
								100,
								300
							}
						}
					end

					return
				end)(arg_31_0.items[iter_31_0].data.create_range)

				if var_31_1 then
					arg_31_0.items[iter_31_0].tf.anchoredPosition = Vector2(var_31_1[1][1] + math.random() * (var_31_1[1][2] - var_31_1[1][1]) / 2, var_31_1[2][1] + math.random() * (var_31_1[2][2] - var_31_1[2][1]) / 2)
				end
			end

			return
		end,
		mixSplitePos = function(arg_33_0, arg_33_1, arg_33_2)
			for iter_33_0 = 1, #arg_33_1 do
				for iter_33_1 = 1, #arg_33_2 do
					table.insert({}, {
						arg_33_1[iter_33_0],
						arg_33_2[iter_33_1]
					})
				end
			end

			return {}
		end,
		splitePositions = function(arg_34_0, arg_34_1, arg_34_2)
			if not arg_34_1 or not arg_34_2 or arg_34_2 < arg_34_1 then
				return nil
			end

			for iter_34_0 = 1, (arg_34_2 - arg_34_1) / var_0_37 do
				table.insert({}, {
					arg_34_1 + (iter_34_0 - 1) * var_0_37,
					arg_34_1 + iter_34_0 * var_0_37
				})
			end

			return {}
		end,
		getItemByPos = function(arg_35_0, arg_35_1)
			local var_35_0 = arg_35_0:checkPosInCollider(arg_35_1)

			if var_35_0 then
				if var_35_0.data.catch_rule then
					if table.contains(var_35_0.data.catch_rule.state, (GetComponent(var_35_0.tf, typeof(Animator)):GetInteger("state"))) then
						arg_35_0:addItemDone(var_35_0)

						return (arg_35_0:createItem(arg_35_0:getItemDataByName(var_35_0.data.catch_rule.targetName)))
					end
				else
					return var_35_0
				end

				return var_35_0
			end

			return nil
		end,
		checkPosInCollider = function(arg_36_0, arg_36_1)
			local var_36_0 = arg_36_0._parentTf:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z)

			for iter_36_0 = 1, #arg_36_0.items do
				if arg_36_0.items[iter_36_0].data.catch ~= var_0_17 then
					if math.abs(var_36_0.x - arg_36_0.items[iter_36_0].tf.anchoredPosition.x) < var_0_35 and math.abs(var_36_0.y - arg_36_0.items[iter_36_0].tf.anchoredPosition.y) < var_0_35 and arg_36_0.items[iter_36_0].data.catch ~= var_0_17 and arg_36_0.items[iter_36_0].catchAble then
						table.insert({}, arg_36_0.items[iter_36_0])
					end
				end
			end

			for iter_36_1 = 1, #{} do
				local var_36_1 = findTF(({})[iter_36_1].tf, "collider")
				local var_36_2, var_36_3, var_36_4, var_36_5, var_36_6

				if not var_36_1 then
					print("can not find collider by" .. ({})[iter_36_1].data.name)

					goto label_36_0

					var_36_2 = arg_36_0
					var_36_3 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_4 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_5 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin)
					var_36_6 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin)
				end

				if arg_36_0:isPointInMatrix(var_36_3, var_36_4, var_36_5, var_36_6, (var_36_1:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z))) then
					return arg_36_0:removeItem(({})[iter_36_1])
				end

				::label_36_0::
			end

			return nil
		end,
		removeItem = function(arg_37_0, arg_37_1)
			for iter_37_0 = 1, #arg_37_0.items do
				if arg_37_0.items[iter_37_0] == arg_37_1 then
					return table.remove(arg_37_0.items, iter_37_0)
				end
			end

			return
		end,
		getCross = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
			return (arg_38_2.x - arg_38_1.x) * (arg_38_3.y - arg_38_1.y) - (arg_38_3.x - arg_38_1.x) * (arg_38_2.y - arg_38_1.y)
		end,
		isPointInMatrix = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
			return arg_39_0:getCross(arg_39_1, arg_39_2, arg_39_5) * arg_39_0:getCross(arg_39_3, arg_39_4, arg_39_5) >= 0 and arg_39_0:getCross(arg_39_2, arg_39_3, arg_39_5) * arg_39_0:getCross(arg_39_4, arg_39_1, arg_39_5) >= 0
		end,
		step = function(arg_40_0)
			for iter_40_0 = #arg_40_0.items, 1, -1 do
				local var_40_0 = arg_40_0.items[iter_40_0]

				if arg_40_0.items[iter_40_0].data.act == var_0_14 and var_40_0.moveAble then
					local var_40_3 = math.sign(var_40_0.targetX - var_40_0.tf.anchoredPosition.x)

					if not var_40_0.targetX then
						local var_40_1 = var_40_0.data.move_range[1]
						local var_40_2 = var_40_0.data.move_range[2]

						var_40_0.targetX = var_40_0.tf.anchoredPosition.x == var_40_0.data.move_range[1] and var_40_2 or var_40_0.tf.anchoredPosition.x == var_40_2 and var_40_1 or math.random() > 0.5 and var_40_1 or var_40_2

						goto label_40_0
					end

					::label_40_0::

					if var_40_0.targetRemove then
						do
							local var_40_4 = var_40_0.data.release_speed or var_40_0.data.speed

							var_40_0.tf.localScale = Vector3(-1 * var_40_3 * var_40_0.direct * math.abs(var_40_0.tf.localScale.x), var_40_0.tf.localScale.y, var_40_0.tf.localScale.z)
							var_40_0.tf.anchoredPosition = Vector2(var_40_0.tf.anchoredPosition.x + var_40_3 * var_40_4 * Time.deltaTime, var_40_0.tf.anchoredPosition.y)

							if var_40_3 == 1 and var_40_0.tf.anchoredPosition.x >= var_40_0.targetX or var_40_3 == -1 and var_40_0.tf.anchoredPosition.x <= var_40_0.targetX then
								var_40_0.tf.anchoredPosition = Vector2(var_40_0.targetX, var_40_0.tf.anchoredPosition.y)
								var_40_0.targetX = nil
							end
						end

						if var_40_0.data.anim_data then
							local var_40_5 = var_40_0.data.anim_data.state_change

							if var_40_0.data.anim_data.state_change and var_40_0.data.anim_data.time then
								if not var_40_0.nextAnimTime then
									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = 1
								elseif var_40_0.nextAnimTime <= 0 then
									GetComponent(var_40_0.tf, typeof(Animator)):SetInteger("state", var_40_5[var_40_0.animStateIndex])

									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = var_40_0.animStateIndex + 1
									var_40_0.animStateIndex = var_40_0.animStateIndex > #var_40_5 and 1 or var_40_0.animStateIndex
								else
									var_40_0.nextAnimTime = var_40_0.nextAnimTime - Time.deltaTime
								end
							end
						end

						if var_40_0.interaction and not var_40_0.targetRemove then
							if not var_40_0.interactionTime then
								var_40_0.interactionTime = math.random() * (var_40_0.data.interaction.time[2] - var_40_0.data.interaction.time[1]) + var_40_0.data.interaction.time[1]
								var_40_0.interactionName = var_40_0.data.interaction.parame[math.random(1, #var_40_0.data.interaction.parame)]
							elseif var_40_0.interactionTime <= 0 then
								GetComponent(var_40_0.tf, typeof(Animator)):SetTrigger(var_40_0.interactionName)

								var_40_0.interactionTime = nil
								var_40_0.interactionName = nil
							else
								var_40_0.interactionTime = var_40_0.interactionTime - Time.deltaTime
							end
						end

						if var_40_0.targetRemove and not var_40_0.targetX then
							table.remove(arg_40_0.items, iter_40_0)
							arg_40_0:destroyItem(var_40_0)
						end
					end
				end
			end

			return
		end,
		destroyItem = function(arg_41_0, arg_41_1)
			destroy(arg_41_1.tf)

			return
		end,
		destroy = function(arg_42_0)
			return
		end
	})

	return {
		ctor = function(arg_18_0)
			arg_18_0._event = arg_17_3
			arg_18_0._sceneTpls = findTF(arg_17_0, "sceneTpls")
			arg_18_0._backSceneTpls = findTF(arg_17_1, "bgTpls")
			arg_18_0._gameMission = arg_17_2 + 1

			local var_18_0 = findTF(arg_17_0, "container")

			arg_18_0._createBounds = {
				var_18_0.sizeDelta.x,
				var_18_0.sizeDelta.y
			}
			arg_18_0._parentTf = findTF(var_18_0, "content")
			arg_18_0._backParentTf = findTF(arg_17_1, "container/content")
			arg_18_0.items = {}

			return
		end,
		getParentInversePos = function(arg_19_0, arg_19_1)
			return arg_19_1.data.scene and (arg_19_1.data.scene == var_0_22 and arg_19_0._backParentTf:InverseTransformPoint(arg_19_1.tf.position) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)) or arg_19_0._parentTf:InverseTransformPoint(arg_19_1.tf.position)
		end,
		addItemDone = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_20_0:getParentInversePos(arg_20_1)

			if arg_20_1.data.act == var_0_14 or arg_20_1.data.catch == var_0_16 then
				var_20_0.y = var_0_36
			end

			arg_20_1.tf.anchoredPosition = var_20_0

			arg_20_0:addItemParent(arg_20_1)

			arg_20_1.tf.localScale = Vector3(2.5 * math.sign(arg_20_1.tf.localScale.x), 2.5, 2.5)
			arg_20_1.tf.localEulerAngles = Vector3(0, 0, 0)
			arg_20_1.catchAble = false
			arg_20_1.targetRemove = true

			if arg_20_1.data.catch == var_0_15 then
				GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
					arg_20_0:destroyItem(arg_20_1)

					return
				end)
				GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("catch")

				goto label_20_0
			end

			::label_20_0::

			if arg_20_1.data.catch == var_0_16 then
				local var_20_1 = arg_20_1.data.leave_direct or 1

				arg_20_1.direct = var_20_1

				if var_20_1 * math.sign(arg_20_1.tf.localScale.x) == -1 then
					arg_20_1.targetX = arg_20_1.data.move_range[2] or arg_20_1.data.move_range[1]

					GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
						arg_20_1.moveAble = true

						return
					end)

					arg_20_1.moveAble = false

					GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("release")
					table.insert(arg_20_0.items, arg_20_1)

					return
				end
			end
		end,
		start = function(arg_23_0)
			arg_23_0:clearItems()
			arg_23_0:prepareItems()
			arg_23_0:setItemPosition()

			return
		end,
		clearItems = function(arg_24_0)
			for iter_24_0 = #arg_24_0.items, 1, -1 do
				arg_24_0:destroyItem((table.remove(arg_24_0.items, iter_24_0)))
			end

			arg_24_0.items = {}

			return
		end,
		prepareItems = function(arg_25_0)
			for iter_25_0, iter_25_1 in pairs(var_0_26[math.random(1, #var_0_26)]) do
				local var_25_0 = arg_25_0:getItemsByType(iter_25_1.type, iter_25_1.name)

				for iter_25_2 = 1, math.random(iter_25_1.amount[1], iter_25_1.amount[2]) do
					local var_25_1

					if iter_25_1.repeated then
						var_25_1 = var_25_0[math.random(1, #var_25_0)]
					elseif #var_25_0 > 0 then
						var_25_1 = table.remove(var_25_0, math.random(1, #var_25_0))
					end

					if var_25_1 then
						table.insert(arg_25_0.items, (arg_25_0:createItem(var_25_1)))
					end
				end
			end

			return
		end,
		getItemsByType = function(arg_26_0, arg_26_1, arg_26_2)
			for iter_26_0 = 1, #var_0_27 do
				if var_0_27[iter_26_0].type == arg_26_1 then
					if arg_26_2 then
						if table.contains(arg_26_2, var_0_27[iter_26_0].name) then
							table.insert({}, var_0_27[iter_26_0])
						end
					else
						table.insert({}, var_0_27[iter_26_0])
					end
				end
			end

			return {}
		end,
		getItemDataByName = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #var_0_27 do
				if var_0_27[iter_27_0].name == arg_27_1 then
					return var_0_27[iter_27_0]
				end
			end

			return nil
		end,
		createItem = function(arg_28_0, arg_28_1)
			({
				data = arg_28_1
			}).tf = nil
			;({
				data = arg_28_1
			}).targetX = nil
			;({
				data = arg_28_1
			}).targetY = nil
			;({
				data = arg_28_1
			}).direct = arg_28_1.direct or 1
			;({
				data = arg_28_1
			}).moveAble = true
			;({
				data = arg_28_1
			}).catchAble = true
			;({
				data = arg_28_1
			}).targetRemove = false
			;({
				data = arg_28_1
			}).interaction = not not arg_28_1.interaction
			;({
				data = arg_28_1
			}).interactionName = nil
			;({
				data = arg_28_1
			}).interactionTime = nil
			;({
				data = arg_28_1
			}).animStateIndex = nil
			;({
				data = arg_28_1
			}).nextAnimTime = nil

			arg_28_0:instantiateItem({
				data = arg_28_1
			})

			return {
				data = arg_28_1
			}
		end,
		instantiateItem = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_1.data.scene == var_0_22 and findTF(arg_29_0._backSceneTpls, arg_29_1.data.name) or findTF(arg_29_0._sceneTpls, arg_29_1.data.name)

			arg_29_1.tf = tf((Instantiate(var_29_0)))

			setActive(arg_29_1.tf, true)
			arg_29_0:addItemParent(arg_29_1)

			return
		end,
		addItemParent = function(arg_30_0, arg_30_1)
			if arg_30_1.data.scene then
				if arg_30_1.data.scene == var_0_22 then
					SetParent(arg_30_1.tf, arg_30_0._backParentTf)
				else
					SetParent(arg_30_1.tf, arg_30_0._parentTf)
				end
			else
				SetParent(arg_30_1.tf, arg_30_0._parentTf)
			end

			return
		end,
		setItemPosition = function(arg_31_0)
			if not arg_31_0.items or #arg_31_0.items == 0 then
				return
			end

			local var_31_0 = arg_31_0:mixSplitePos(arg_31_0:splitePositions(0, arg_31_0._createBounds[1]), (arg_31_0:splitePositions(0, arg_31_0._createBounds[2])))

			for iter_31_0 = 1, #arg_31_0.items do
				local var_31_1 = (function(arg_32_0)
					if arg_32_0 then
						for iter_32_0 = 1, #var_31_0 do
							if arg_32_0[1] <= var_31_0[iter_32_0][1][1] and var_31_0[iter_32_0][1][2] <= arg_32_0[2] and arg_32_0[3] <= var_31_0[iter_32_0][2][1] and var_31_0[iter_32_0][2][2] <= arg_32_0[4] then
								table.insert({}, iter_32_0)
							end
						end

						if #{} > 0 then
							return table.remove(var_31_0, ({})[math.random(1, #{})])
						end
					end

					if #var_31_0 > 0 then
						return table.remove(var_31_0, math.random(1, #var_31_0))
					else
						return {
							{
								0,
								1300
							},
							{
								100,
								300
							}
						}
					end

					return
				end)(arg_31_0.items[iter_31_0].data.create_range)

				if var_31_1 then
					arg_31_0.items[iter_31_0].tf.anchoredPosition = Vector2(var_31_1[1][1] + math.random() * (var_31_1[1][2] - var_31_1[1][1]) / 2, var_31_1[2][1] + math.random() * (var_31_1[2][2] - var_31_1[2][1]) / 2)
				end
			end

			return
		end,
		mixSplitePos = function(arg_33_0, arg_33_1, arg_33_2)
			for iter_33_0 = 1, #arg_33_1 do
				for iter_33_1 = 1, #arg_33_2 do
					table.insert({}, {
						arg_33_1[iter_33_0],
						arg_33_2[iter_33_1]
					})
				end
			end

			return {}
		end,
		splitePositions = function(arg_34_0, arg_34_1, arg_34_2)
			if not arg_34_1 or not arg_34_2 or arg_34_2 < arg_34_1 then
				return nil
			end

			for iter_34_0 = 1, (arg_34_2 - arg_34_1) / var_0_37 do
				table.insert({}, {
					arg_34_1 + (iter_34_0 - 1) * var_0_37,
					arg_34_1 + iter_34_0 * var_0_37
				})
			end

			return {}
		end,
		getItemByPos = function(arg_35_0, arg_35_1)
			local var_35_0 = arg_35_0:checkPosInCollider(arg_35_1)

			if var_35_0 then
				if var_35_0.data.catch_rule then
					if table.contains(var_35_0.data.catch_rule.state, (GetComponent(var_35_0.tf, typeof(Animator)):GetInteger("state"))) then
						arg_35_0:addItemDone(var_35_0)

						return (arg_35_0:createItem(arg_35_0:getItemDataByName(var_35_0.data.catch_rule.targetName)))
					end
				else
					return var_35_0
				end

				return var_35_0
			end

			return nil
		end,
		checkPosInCollider = function(arg_36_0, arg_36_1)
			local var_36_0 = arg_36_0._parentTf:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z)

			for iter_36_0 = 1, #arg_36_0.items do
				if arg_36_0.items[iter_36_0].data.catch ~= var_0_17 then
					if math.abs(var_36_0.x - arg_36_0.items[iter_36_0].tf.anchoredPosition.x) < var_0_35 and math.abs(var_36_0.y - arg_36_0.items[iter_36_0].tf.anchoredPosition.y) < var_0_35 and arg_36_0.items[iter_36_0].data.catch ~= var_0_17 and arg_36_0.items[iter_36_0].catchAble then
						table.insert({}, arg_36_0.items[iter_36_0])
					end
				end
			end

			for iter_36_1 = 1, #{} do
				local var_36_1 = findTF(({})[iter_36_1].tf, "collider")
				local var_36_2, var_36_3, var_36_4, var_36_5, var_36_6

				if not var_36_1 then
					print("can not find collider by" .. ({})[iter_36_1].data.name)

					goto label_36_0

					var_36_2 = arg_36_0
					var_36_3 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_4 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin + var_36_1.rect.height)
					var_36_5 = Vector2(var_36_1.rect.xMin + var_36_1.rect.width, var_36_1.rect.yMin)
					var_36_6 = Vector2(var_36_1.rect.xMin, var_36_1.rect.yMin)
				end

				if arg_36_0:isPointInMatrix(var_36_3, var_36_4, var_36_5, var_36_6, (var_36_1:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z))) then
					return arg_36_0:removeItem(({})[iter_36_1])
				end

				::label_36_0::
			end

			return nil
		end,
		removeItem = function(arg_37_0, arg_37_1)
			for iter_37_0 = 1, #arg_37_0.items do
				if arg_37_0.items[iter_37_0] == arg_37_1 then
					return table.remove(arg_37_0.items, iter_37_0)
				end
			end

			return
		end,
		getCross = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
			return (arg_38_2.x - arg_38_1.x) * (arg_38_3.y - arg_38_1.y) - (arg_38_3.x - arg_38_1.x) * (arg_38_2.y - arg_38_1.y)
		end,
		isPointInMatrix = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
			return arg_39_0:getCross(arg_39_1, arg_39_2, arg_39_5) * arg_39_0:getCross(arg_39_3, arg_39_4, arg_39_5) >= 0 and arg_39_0:getCross(arg_39_2, arg_39_3, arg_39_5) * arg_39_0:getCross(arg_39_4, arg_39_1, arg_39_5) >= 0
		end,
		step = function(arg_40_0)
			for iter_40_0 = #arg_40_0.items, 1, -1 do
				local var_40_0 = arg_40_0.items[iter_40_0]

				if arg_40_0.items[iter_40_0].data.act == var_0_14 and var_40_0.moveAble then
					local var_40_3 = math.sign(var_40_0.targetX - var_40_0.tf.anchoredPosition.x)

					if not var_40_0.targetX then
						local var_40_1 = var_40_0.data.move_range[1]
						local var_40_2 = var_40_0.data.move_range[2]

						var_40_0.targetX = var_40_0.tf.anchoredPosition.x == var_40_0.data.move_range[1] and var_40_2 or var_40_0.tf.anchoredPosition.x == var_40_2 and var_40_1 or math.random() > 0.5 and var_40_1 or var_40_2

						goto label_40_0
					end

					::label_40_0::

					if var_40_0.targetRemove then
						do
							local var_40_4 = var_40_0.data.release_speed or var_40_0.data.speed

							var_40_0.tf.localScale = Vector3(-1 * var_40_3 * var_40_0.direct * math.abs(var_40_0.tf.localScale.x), var_40_0.tf.localScale.y, var_40_0.tf.localScale.z)
							var_40_0.tf.anchoredPosition = Vector2(var_40_0.tf.anchoredPosition.x + var_40_3 * var_40_4 * Time.deltaTime, var_40_0.tf.anchoredPosition.y)

							if var_40_3 == 1 and var_40_0.tf.anchoredPosition.x >= var_40_0.targetX or var_40_3 == -1 and var_40_0.tf.anchoredPosition.x <= var_40_0.targetX then
								var_40_0.tf.anchoredPosition = Vector2(var_40_0.targetX, var_40_0.tf.anchoredPosition.y)
								var_40_0.targetX = nil
							end
						end

						if var_40_0.data.anim_data then
							local var_40_5 = var_40_0.data.anim_data.state_change

							if var_40_0.data.anim_data.state_change and var_40_0.data.anim_data.time then
								if not var_40_0.nextAnimTime then
									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = 1
								elseif var_40_0.nextAnimTime <= 0 then
									GetComponent(var_40_0.tf, typeof(Animator)):SetInteger("state", var_40_5[var_40_0.animStateIndex])

									var_40_0.nextAnimTime = math.random(var_40_0.data.anim_data.time[1], var_40_0.data.anim_data.time[2])
									var_40_0.animStateIndex = var_40_0.animStateIndex + 1
									var_40_0.animStateIndex = var_40_0.animStateIndex > #var_40_5 and 1 or var_40_0.animStateIndex
								else
									var_40_0.nextAnimTime = var_40_0.nextAnimTime - Time.deltaTime
								end
							end
						end

						if var_40_0.interaction and not var_40_0.targetRemove then
							if not var_40_0.interactionTime then
								var_40_0.interactionTime = math.random() * (var_40_0.data.interaction.time[2] - var_40_0.data.interaction.time[1]) + var_40_0.data.interaction.time[1]
								var_40_0.interactionName = var_40_0.data.interaction.parame[math.random(1, #var_40_0.data.interaction.parame)]
							elseif var_40_0.interactionTime <= 0 then
								GetComponent(var_40_0.tf, typeof(Animator)):SetTrigger(var_40_0.interactionName)

								var_40_0.interactionTime = nil
								var_40_0.interactionName = nil
							else
								var_40_0.interactionTime = var_40_0.interactionTime - Time.deltaTime
							end
						end

						if var_40_0.targetRemove and not var_40_0.targetX then
							table.remove(arg_40_0.items, iter_40_0)
							arg_40_0:destroyItem(var_40_0)
						end
					end
				end
			end

			return
		end,
		destroyItem = function(arg_41_0, arg_41_1)
			destroy(arg_41_1.tf)

			return
		end,
		destroy = function(arg_42_0)
			return
		end
	}
end

local function var_0_49(arg_43_0, arg_43_1)
	({
		ctor = function(arg_44_0)
			arg_44_0._boatController = arg_43_0
			arg_44_0._itemController = arg_43_1

			return
		end,
		start = function(arg_45_0)
			return
		end,
		step = function(arg_46_0)
			if arg_46_0._boatController:inCatch() then
				local var_46_0 = arg_46_0._itemController:getItemByPos((arg_46_0._boatController:getHookPosition()))

				if var_46_0 then
					GetComponent(var_46_0.tf, typeof(Animator)):SetTrigger("hold")
					arg_46_0._boatController:setCatchItem(var_46_0)
				end
			end

			return
		end,
		destroy = function(arg_47_0)
			return
		end
	}).ctor({
		ctor = function(arg_44_0)
			arg_44_0._boatController = arg_43_0
			arg_44_0._itemController = arg_43_1

			return
		end,
		start = function(arg_45_0)
			return
		end,
		step = function(arg_46_0)
			if arg_46_0._boatController:inCatch() then
				local var_46_0 = arg_46_0._itemController:getItemByPos((arg_46_0._boatController:getHookPosition()))

				if var_46_0 then
					GetComponent(var_46_0.tf, typeof(Animator)):SetTrigger("hold")
					arg_46_0._boatController:setCatchItem(var_46_0)
				end
			end

			return
		end,
		destroy = function(arg_47_0)
			return
		end
	})

	return {
		ctor = function(arg_44_0)
			arg_44_0._boatController = arg_43_0
			arg_44_0._itemController = arg_43_1

			return
		end,
		start = function(arg_45_0)
			return
		end,
		step = function(arg_46_0)
			if arg_46_0._boatController:inCatch() then
				local var_46_0 = arg_46_0._itemController:getItemByPos((arg_46_0._boatController:getHookPosition()))

				if var_46_0 then
					GetComponent(var_46_0.tf, typeof(Animator)):SetTrigger("hold")
					arg_46_0._boatController:setCatchItem(var_46_0)
				end
			end

			return
		end,
		destroy = function(arg_47_0)
			return
		end
	}
end

local function var_0_50(arg_48_0, arg_48_1)
	({
		ctor = function(arg_49_0)
			arg_49_0._charTpls = findTF(arg_48_0, "charTpls")
			arg_49_0._content = findTF(arg_48_0, "charContainer/content")
			arg_49_0._event = arg_48_1

			return
		end,
		start = function(arg_50_0)
			arg_50_0:clear()

			arg_50_0.chars = {}
			arg_50_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			arg_50_0.showChars = Clone(var_0_44)

			return
		end,
		step = function(arg_51_0)
			if arg_51_0.nextTime <= 0 and #arg_51_0.showChars > 0 then
				table.insert(arg_51_0.chars, arg_51_0:createChar())

				arg_51_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			else
				arg_51_0.nextTime = arg_51_0.nextTime - Time.deltaTime
			end

			arg_51_0:setCharAction()

			for iter_51_0 = #arg_51_0.chars, 1, -1 do
				arg_51_0:stepChar(arg_51_0.chars[iter_51_0])

				if arg_51_0.chars[iter_51_0].removeFlag then
					arg_51_0:removeChar(table.remove(arg_51_0.chars, iter_51_0))
				end
			end

			return
		end,
		stepChar = function(arg_52_0, arg_52_1)
			local var_52_0 = false

			if arg_52_1.posX then
				local var_52_1 = arg_52_1.offsetX or 0
				local var_52_2 = arg_52_1.posX + var_52_1

				arg_52_1.tf.anchoredPosition = Vector2(var_52_2, 0)

				setActive(arg_52_1.tf, true)

				arg_52_1.posX = nil
				arg_52_1.offsetX = nil
			end

			if arg_52_1.moveToX then
				arg_52_1.tf.anchoredPosition = Vector3(arg_52_1.tf.anchoredPosition.x + math.sign(arg_52_1.moveToX + arg_52_1.offsetX - arg_52_1.tf.anchoredPosition.x) * arg_52_1.speed, 0)

				if arg_52_1.tf.anchoredPosition.x == arg_52_1.moveToX + arg_52_1.offsetX or math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) ~= math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) then
					arg_52_1.moveToX = nil
					arg_52_1.offsetX = nil
				else
					var_52_0 = true
				end
			end

			if arg_52_1.triggerName or arg_52_1.time then
				if arg_52_1.triggerName and arg_52_1.animator then
					arg_52_1.animator:SetTrigger(arg_52_1.triggerName)

					arg_52_1.triggerName = nil
				end

				arg_52_1.time = arg_52_1.time - Time.deltaTime

				if arg_52_1.triggerName == nil and arg_52_1.time <= 0 then
					arg_52_1.time = nil
				else
					var_52_0 = true
				end
			end

			arg_52_1.inAction = var_52_0

			return
		end,
		getRandomMoveX = function(arg_53_0, arg_53_1, arg_53_2)
			return arg_53_1 + math.random(0, arg_53_2 - arg_53_1)
		end,
		removeChar = function(arg_54_0, arg_54_1)
			if arg_54_1.bindChars then
				arg_54_1.bindChars = {}
			end

			destroy(arg_54_1.tf)

			return
		end,
		setCharAction = function(arg_55_0)
			for iter_55_0 = 1, #arg_55_0.chars do
				if not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos > 0 and not arg_55_0.chars[iter_55_0].inAction then
					if arg_55_0.chars[iter_55_0].sync and arg_55_0.chars[iter_55_0].bindIds and #arg_55_0.chars[iter_55_0].bindIds > 0 then
						local var_55_0 = true

						for iter_55_1, iter_55_2 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
							var_55_0 = not iter_55_2.inAction and iter_55_2.sync or false
						end

						if var_55_0 then
							arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)

							for iter_55_3, iter_55_4 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
								iter_55_4.sync = false
							end
						end
					elseif not arg_55_0.chars[iter_55_0].sync then
						arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)
					end
				end

				if arg_55_0.chars[iter_55_0].currentActionInfo and not arg_55_0.chars[iter_55_0].currentActionInfo.sync then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])
				elseif arg_55_0.chars[iter_55_0].currentActionInfo and arg_55_0.chars[iter_55_0].currentActionInfo.sync and arg_55_0.chars[iter_55_0].bindIds then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])

					for iter_55_5, iter_55_6 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
						if iter_55_6 and iter_55_6.currentActionInfo and iter_55_6.currentActionInfo.sync then
							arg_55_0:addBindCharAction(arg_55_0.chars[iter_55_0], iter_55_6)
						end
					end
				elseif not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos == 0 and not arg_55_0.chars[iter_55_0].inAction then
					arg_55_0.chars[iter_55_0].removeFlag = true
				end
			end

			return
		end,
		addBindCharAction = function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_2.currentActionInfo.type == var_0_40 then
				arg_56_2.moveToX = arg_56_1.moveToX
				arg_56_2.offsetX = arg_56_2.currentActionInfo.offsetX or 0
			elseif arg_56_2.currentActionInfo.type == var_0_39 then
				-- block empty
			elseif arg_56_2.currentActionInfo.type == var_0_41 then
				-- block empty
			end

			arg_56_2.sync = arg_56_2.currentActionInfo.sync
			arg_56_2.currentActionInfo = nil
			arg_56_2.inAction = true

			return
		end,
		addCharAction = function(arg_57_0, arg_57_1)
			if arg_57_1.currentActionInfo.type == var_0_40 then
				local var_57_0

				if arg_57_1.currentActionInfo.moveToX then
					var_57_0 = arg_57_0:getRandomMoveX(arg_57_1.currentActionInfo.moveToX[1], arg_57_1.currentActionInfo.moveToX[2])
				end

				arg_57_1.moveToX = var_57_0 or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_39 then
				arg_57_1.posX = arg_57_1.currentActionInfo.posX or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_41 then
				arg_57_1.triggerName = arg_57_1.currentActionInfo.trigger
				arg_57_1.time = arg_57_1.currentActionInfo.time or 0
			end

			arg_57_1.sync = arg_57_1.currentActionInfo.sync
			arg_57_1.inAction = true
			arg_57_1.currentActionInfo = nil

			return
		end,
		createChar = function(arg_58_0, arg_58_1)
			local var_58_0 = Clone(arg_58_1) or arg_58_0:getRandomData()

			if not var_58_0 then
				return
			end

			;({}).data = var_58_0
			;({}).id = var_58_0.id
			;({}).bindIds = var_58_0.bindIds
			;({}).bindChars = {}
			;({}).actionInfos = var_58_0.actions
			;({}).speed = var_58_0.speed
			;({}).tf = arg_58_0:getCharTf(var_58_0.tf)
			;({}).animator = GetComponent(findTF(({}).tf, "anim"), typeof(Animator))
			;({}).dft = GetComponent(findTF(({}).tf, "anim"), typeof(DftAniEvent))
			;({}).currentActionInfo = nil
			;({}).posX = nil
			;({}).moveToX = nil
			;({}).offsetX = nil
			;({}).triggerName = nil
			;({}).time = nil
			;({}).inAction = false
			;({}).removeFlag = false

			if ({}).bindIds then
				for iter_58_0 = 1, #({}).bindIds do
					local var_58_1 = arg_58_0:createChar(arg_58_0:getCharDataById(({}).bindIds[iter_58_0]))

					table.insert(arg_58_0.chars, var_58_1)
					table.insert(({}).bindChars, var_58_1)
				end
			end

			return {}
		end,
		getRandomData = function(arg_59_0)
			if arg_59_0.showChars and #arg_59_0.showChars > 0 then
				return arg_59_0:getCharDataById((table.remove(arg_59_0.showChars, math.random(1, #arg_59_0.showChars))))
			end

			return nil
		end,
		getCharDataById = function(arg_60_0, arg_60_1)
			for iter_60_0, iter_60_1 in ipairs(var_0_42) do
				if iter_60_1.id == arg_60_1 then
					return Clone(iter_60_1)
				end
			end

			return
		end,
		getCharTf = function(arg_61_0, arg_61_1)
			local var_61_0 = tf(instantiate(findTF(arg_61_0._charTpls, arg_61_1)))

			SetParent(var_61_0, arg_61_0._content)
			SetActive(var_61_0, false)

			return var_61_0
		end,
		clear = function(arg_62_0)
			if arg_62_0.chars then
				for iter_62_0 = #arg_62_0.chars, 1, -1 do
					arg_62_0:removeChar(table.remove(arg_62_0.chars, iter_62_0))
				end

				arg_62_0.chars = {}
			end

			return
		end
	}).ctor({
		ctor = function(arg_49_0)
			arg_49_0._charTpls = findTF(arg_48_0, "charTpls")
			arg_49_0._content = findTF(arg_48_0, "charContainer/content")
			arg_49_0._event = arg_48_1

			return
		end,
		start = function(arg_50_0)
			arg_50_0:clear()

			arg_50_0.chars = {}
			arg_50_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			arg_50_0.showChars = Clone(var_0_44)

			return
		end,
		step = function(arg_51_0)
			if arg_51_0.nextTime <= 0 and #arg_51_0.showChars > 0 then
				table.insert(arg_51_0.chars, arg_51_0:createChar())

				arg_51_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			else
				arg_51_0.nextTime = arg_51_0.nextTime - Time.deltaTime
			end

			arg_51_0:setCharAction()

			for iter_51_0 = #arg_51_0.chars, 1, -1 do
				arg_51_0:stepChar(arg_51_0.chars[iter_51_0])

				if arg_51_0.chars[iter_51_0].removeFlag then
					arg_51_0:removeChar(table.remove(arg_51_0.chars, iter_51_0))
				end
			end

			return
		end,
		stepChar = function(arg_52_0, arg_52_1)
			local var_52_0 = false

			if arg_52_1.posX then
				local var_52_1 = arg_52_1.offsetX or 0
				local var_52_2 = arg_52_1.posX + var_52_1

				arg_52_1.tf.anchoredPosition = Vector2(var_52_2, 0)

				setActive(arg_52_1.tf, true)

				arg_52_1.posX = nil
				arg_52_1.offsetX = nil
			end

			if arg_52_1.moveToX then
				arg_52_1.tf.anchoredPosition = Vector3(arg_52_1.tf.anchoredPosition.x + math.sign(arg_52_1.moveToX + arg_52_1.offsetX - arg_52_1.tf.anchoredPosition.x) * arg_52_1.speed, 0)

				if arg_52_1.tf.anchoredPosition.x == arg_52_1.moveToX + arg_52_1.offsetX or math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) ~= math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) then
					arg_52_1.moveToX = nil
					arg_52_1.offsetX = nil
				else
					var_52_0 = true
				end
			end

			if arg_52_1.triggerName or arg_52_1.time then
				if arg_52_1.triggerName and arg_52_1.animator then
					arg_52_1.animator:SetTrigger(arg_52_1.triggerName)

					arg_52_1.triggerName = nil
				end

				arg_52_1.time = arg_52_1.time - Time.deltaTime

				if arg_52_1.triggerName == nil and arg_52_1.time <= 0 then
					arg_52_1.time = nil
				else
					var_52_0 = true
				end
			end

			arg_52_1.inAction = var_52_0

			return
		end,
		getRandomMoveX = function(arg_53_0, arg_53_1, arg_53_2)
			return arg_53_1 + math.random(0, arg_53_2 - arg_53_1)
		end,
		removeChar = function(arg_54_0, arg_54_1)
			if arg_54_1.bindChars then
				arg_54_1.bindChars = {}
			end

			destroy(arg_54_1.tf)

			return
		end,
		setCharAction = function(arg_55_0)
			for iter_55_0 = 1, #arg_55_0.chars do
				if not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos > 0 and not arg_55_0.chars[iter_55_0].inAction then
					if arg_55_0.chars[iter_55_0].sync and arg_55_0.chars[iter_55_0].bindIds and #arg_55_0.chars[iter_55_0].bindIds > 0 then
						local var_55_0 = true

						for iter_55_1, iter_55_2 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
							var_55_0 = not iter_55_2.inAction and iter_55_2.sync or false
						end

						if var_55_0 then
							arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)

							for iter_55_3, iter_55_4 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
								iter_55_4.sync = false
							end
						end
					elseif not arg_55_0.chars[iter_55_0].sync then
						arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)
					end
				end

				if arg_55_0.chars[iter_55_0].currentActionInfo and not arg_55_0.chars[iter_55_0].currentActionInfo.sync then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])
				elseif arg_55_0.chars[iter_55_0].currentActionInfo and arg_55_0.chars[iter_55_0].currentActionInfo.sync and arg_55_0.chars[iter_55_0].bindIds then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])

					for iter_55_5, iter_55_6 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
						if iter_55_6 and iter_55_6.currentActionInfo and iter_55_6.currentActionInfo.sync then
							arg_55_0:addBindCharAction(arg_55_0.chars[iter_55_0], iter_55_6)
						end
					end
				elseif not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos == 0 and not arg_55_0.chars[iter_55_0].inAction then
					arg_55_0.chars[iter_55_0].removeFlag = true
				end
			end

			return
		end,
		addBindCharAction = function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_2.currentActionInfo.type == var_0_40 then
				arg_56_2.moveToX = arg_56_1.moveToX
				arg_56_2.offsetX = arg_56_2.currentActionInfo.offsetX or 0
			elseif arg_56_2.currentActionInfo.type == var_0_39 then
				-- block empty
			elseif arg_56_2.currentActionInfo.type == var_0_41 then
				-- block empty
			end

			arg_56_2.sync = arg_56_2.currentActionInfo.sync
			arg_56_2.currentActionInfo = nil
			arg_56_2.inAction = true

			return
		end,
		addCharAction = function(arg_57_0, arg_57_1)
			if arg_57_1.currentActionInfo.type == var_0_40 then
				local var_57_0

				if arg_57_1.currentActionInfo.moveToX then
					var_57_0 = arg_57_0:getRandomMoveX(arg_57_1.currentActionInfo.moveToX[1], arg_57_1.currentActionInfo.moveToX[2])
				end

				arg_57_1.moveToX = var_57_0 or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_39 then
				arg_57_1.posX = arg_57_1.currentActionInfo.posX or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_41 then
				arg_57_1.triggerName = arg_57_1.currentActionInfo.trigger
				arg_57_1.time = arg_57_1.currentActionInfo.time or 0
			end

			arg_57_1.sync = arg_57_1.currentActionInfo.sync
			arg_57_1.inAction = true
			arg_57_1.currentActionInfo = nil

			return
		end,
		createChar = function(arg_58_0, arg_58_1)
			local var_58_0 = Clone(arg_58_1) or arg_58_0:getRandomData()

			if not var_58_0 then
				return
			end

			;({}).data = var_58_0
			;({}).id = var_58_0.id
			;({}).bindIds = var_58_0.bindIds
			;({}).bindChars = {}
			;({}).actionInfos = var_58_0.actions
			;({}).speed = var_58_0.speed
			;({}).tf = arg_58_0:getCharTf(var_58_0.tf)
			;({}).animator = GetComponent(findTF(({}).tf, "anim"), typeof(Animator))
			;({}).dft = GetComponent(findTF(({}).tf, "anim"), typeof(DftAniEvent))
			;({}).currentActionInfo = nil
			;({}).posX = nil
			;({}).moveToX = nil
			;({}).offsetX = nil
			;({}).triggerName = nil
			;({}).time = nil
			;({}).inAction = false
			;({}).removeFlag = false

			if ({}).bindIds then
				for iter_58_0 = 1, #({}).bindIds do
					local var_58_1 = arg_58_0:createChar(arg_58_0:getCharDataById(({}).bindIds[iter_58_0]))

					table.insert(arg_58_0.chars, var_58_1)
					table.insert(({}).bindChars, var_58_1)
				end
			end

			return {}
		end,
		getRandomData = function(arg_59_0)
			if arg_59_0.showChars and #arg_59_0.showChars > 0 then
				return arg_59_0:getCharDataById((table.remove(arg_59_0.showChars, math.random(1, #arg_59_0.showChars))))
			end

			return nil
		end,
		getCharDataById = function(arg_60_0, arg_60_1)
			for iter_60_0, iter_60_1 in ipairs(var_0_42) do
				if iter_60_1.id == arg_60_1 then
					return Clone(iter_60_1)
				end
			end

			return
		end,
		getCharTf = function(arg_61_0, arg_61_1)
			local var_61_0 = tf(instantiate(findTF(arg_61_0._charTpls, arg_61_1)))

			SetParent(var_61_0, arg_61_0._content)
			SetActive(var_61_0, false)

			return var_61_0
		end,
		clear = function(arg_62_0)
			if arg_62_0.chars then
				for iter_62_0 = #arg_62_0.chars, 1, -1 do
					arg_62_0:removeChar(table.remove(arg_62_0.chars, iter_62_0))
				end

				arg_62_0.chars = {}
			end

			return
		end
	})

	return {
		ctor = function(arg_49_0)
			arg_49_0._charTpls = findTF(arg_48_0, "charTpls")
			arg_49_0._content = findTF(arg_48_0, "charContainer/content")
			arg_49_0._event = arg_48_1

			return
		end,
		start = function(arg_50_0)
			arg_50_0:clear()

			arg_50_0.chars = {}
			arg_50_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			arg_50_0.showChars = Clone(var_0_44)

			return
		end,
		step = function(arg_51_0)
			if arg_51_0.nextTime <= 0 and #arg_51_0.showChars > 0 then
				table.insert(arg_51_0.chars, arg_51_0:createChar())

				arg_51_0.nextTime = math.random(var_0_43[1], var_0_43[2])
			else
				arg_51_0.nextTime = arg_51_0.nextTime - Time.deltaTime
			end

			arg_51_0:setCharAction()

			for iter_51_0 = #arg_51_0.chars, 1, -1 do
				arg_51_0:stepChar(arg_51_0.chars[iter_51_0])

				if arg_51_0.chars[iter_51_0].removeFlag then
					arg_51_0:removeChar(table.remove(arg_51_0.chars, iter_51_0))
				end
			end

			return
		end,
		stepChar = function(arg_52_0, arg_52_1)
			local var_52_0 = false

			if arg_52_1.posX then
				local var_52_1 = arg_52_1.offsetX or 0
				local var_52_2 = arg_52_1.posX + var_52_1

				arg_52_1.tf.anchoredPosition = Vector2(var_52_2, 0)

				setActive(arg_52_1.tf, true)

				arg_52_1.posX = nil
				arg_52_1.offsetX = nil
			end

			if arg_52_1.moveToX then
				arg_52_1.tf.anchoredPosition = Vector3(arg_52_1.tf.anchoredPosition.x + math.sign(arg_52_1.moveToX + arg_52_1.offsetX - arg_52_1.tf.anchoredPosition.x) * arg_52_1.speed, 0)

				if arg_52_1.tf.anchoredPosition.x == arg_52_1.moveToX + arg_52_1.offsetX or math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) ~= math.sign(arg_52_1.tf.anchoredPosition.x - (arg_52_1.moveToX + arg_52_1.offsetX)) then
					arg_52_1.moveToX = nil
					arg_52_1.offsetX = nil
				else
					var_52_0 = true
				end
			end

			if arg_52_1.triggerName or arg_52_1.time then
				if arg_52_1.triggerName and arg_52_1.animator then
					arg_52_1.animator:SetTrigger(arg_52_1.triggerName)

					arg_52_1.triggerName = nil
				end

				arg_52_1.time = arg_52_1.time - Time.deltaTime

				if arg_52_1.triggerName == nil and arg_52_1.time <= 0 then
					arg_52_1.time = nil
				else
					var_52_0 = true
				end
			end

			arg_52_1.inAction = var_52_0

			return
		end,
		getRandomMoveX = function(arg_53_0, arg_53_1, arg_53_2)
			return arg_53_1 + math.random(0, arg_53_2 - arg_53_1)
		end,
		removeChar = function(arg_54_0, arg_54_1)
			if arg_54_1.bindChars then
				arg_54_1.bindChars = {}
			end

			destroy(arg_54_1.tf)

			return
		end,
		setCharAction = function(arg_55_0)
			for iter_55_0 = 1, #arg_55_0.chars do
				if not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos > 0 and not arg_55_0.chars[iter_55_0].inAction then
					if arg_55_0.chars[iter_55_0].sync and arg_55_0.chars[iter_55_0].bindIds and #arg_55_0.chars[iter_55_0].bindIds > 0 then
						local var_55_0 = true

						for iter_55_1, iter_55_2 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
							var_55_0 = not iter_55_2.inAction and iter_55_2.sync or false
						end

						if var_55_0 then
							arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)

							for iter_55_3, iter_55_4 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
								iter_55_4.sync = false
							end
						end
					elseif not arg_55_0.chars[iter_55_0].sync then
						arg_55_0.chars[iter_55_0].currentActionInfo = table.remove(arg_55_0.chars[iter_55_0].actionInfos, 1)
					end
				end

				if arg_55_0.chars[iter_55_0].currentActionInfo and not arg_55_0.chars[iter_55_0].currentActionInfo.sync then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])
				elseif arg_55_0.chars[iter_55_0].currentActionInfo and arg_55_0.chars[iter_55_0].currentActionInfo.sync and arg_55_0.chars[iter_55_0].bindIds then
					arg_55_0:addCharAction(arg_55_0.chars[iter_55_0])

					for iter_55_5, iter_55_6 in ipairs(arg_55_0.chars[iter_55_0].bindChars) do
						if iter_55_6 and iter_55_6.currentActionInfo and iter_55_6.currentActionInfo.sync then
							arg_55_0:addBindCharAction(arg_55_0.chars[iter_55_0], iter_55_6)
						end
					end
				elseif not arg_55_0.chars[iter_55_0].currentActionInfo and #arg_55_0.chars[iter_55_0].actionInfos == 0 and not arg_55_0.chars[iter_55_0].inAction then
					arg_55_0.chars[iter_55_0].removeFlag = true
				end
			end

			return
		end,
		addBindCharAction = function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_2.currentActionInfo.type == var_0_40 then
				arg_56_2.moveToX = arg_56_1.moveToX
				arg_56_2.offsetX = arg_56_2.currentActionInfo.offsetX or 0
			elseif arg_56_2.currentActionInfo.type == var_0_39 then
				-- block empty
			elseif arg_56_2.currentActionInfo.type == var_0_41 then
				-- block empty
			end

			arg_56_2.sync = arg_56_2.currentActionInfo.sync
			arg_56_2.currentActionInfo = nil
			arg_56_2.inAction = true

			return
		end,
		addCharAction = function(arg_57_0, arg_57_1)
			if arg_57_1.currentActionInfo.type == var_0_40 then
				local var_57_0

				if arg_57_1.currentActionInfo.moveToX then
					var_57_0 = arg_57_0:getRandomMoveX(arg_57_1.currentActionInfo.moveToX[1], arg_57_1.currentActionInfo.moveToX[2])
				end

				arg_57_1.moveToX = var_57_0 or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_39 then
				arg_57_1.posX = arg_57_1.currentActionInfo.posX or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_41 then
				arg_57_1.triggerName = arg_57_1.currentActionInfo.trigger
				arg_57_1.time = arg_57_1.currentActionInfo.time or 0
			end

			arg_57_1.sync = arg_57_1.currentActionInfo.sync
			arg_57_1.inAction = true
			arg_57_1.currentActionInfo = nil

			return
		end,
		createChar = function(arg_58_0, arg_58_1)
			local var_58_0 = Clone(arg_58_1) or arg_58_0:getRandomData()

			if not var_58_0 then
				return
			end

			;({}).data = var_58_0
			;({}).id = var_58_0.id
			;({}).bindIds = var_58_0.bindIds
			;({}).bindChars = {}
			;({}).actionInfos = var_58_0.actions
			;({}).speed = var_58_0.speed
			;({}).tf = arg_58_0:getCharTf(var_58_0.tf)
			;({}).animator = GetComponent(findTF(({}).tf, "anim"), typeof(Animator))
			;({}).dft = GetComponent(findTF(({}).tf, "anim"), typeof(DftAniEvent))
			;({}).currentActionInfo = nil
			;({}).posX = nil
			;({}).moveToX = nil
			;({}).offsetX = nil
			;({}).triggerName = nil
			;({}).time = nil
			;({}).inAction = false
			;({}).removeFlag = false

			if ({}).bindIds then
				for iter_58_0 = 1, #({}).bindIds do
					local var_58_1 = arg_58_0:createChar(arg_58_0:getCharDataById(({}).bindIds[iter_58_0]))

					table.insert(arg_58_0.chars, var_58_1)
					table.insert(({}).bindChars, var_58_1)
				end
			end

			return {}
		end,
		getRandomData = function(arg_59_0)
			if arg_59_0.showChars and #arg_59_0.showChars > 0 then
				return arg_59_0:getCharDataById((table.remove(arg_59_0.showChars, math.random(1, #arg_59_0.showChars))))
			end

			return nil
		end,
		getCharDataById = function(arg_60_0, arg_60_1)
			for iter_60_0, iter_60_1 in ipairs(var_0_42) do
				if iter_60_1.id == arg_60_1 then
					return Clone(iter_60_1)
				end
			end

			return
		end,
		getCharTf = function(arg_61_0, arg_61_1)
			local var_61_0 = tf(instantiate(findTF(arg_61_0._charTpls, arg_61_1)))

			SetParent(var_61_0, arg_61_0._content)
			SetActive(var_61_0, false)

			return var_61_0
		end,
		clear = function(arg_62_0)
			if arg_62_0.chars then
				for iter_62_0 = #arg_62_0.chars, 1, -1 do
					arg_62_0:removeChar(table.remove(arg_62_0.chars, iter_62_0))
				end

				arg_62_0.chars = {}
			end

			return
		end
	}
end

function var_0_0.getUIName(arg_63_0)
	return "CatchTreasureGameUI"
end

function var_0_0.getBGM(arg_64_0)
	return var_0_1
end

function var_0_0.didEnter(arg_65_0)
	arg_65_0:initEvent()
	arg_65_0:initData()
	arg_65_0:initUI()
	arg_65_0:initGameUI()
	arg_65_0:updateMenuUI()
	arg_65_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_66_0)
	arg_66_0:bind(var_0_10, function(arg_67_0, arg_67_1, arg_67_2)
		if arg_66_0.itemController then
			arg_66_0.itemController:addItemDone(arg_67_1, arg_67_2)
		end

		arg_66_0:addScore(arg_67_1.data.score, arg_67_1.data.time)

		return
	end)

	return
end

function var_0_0.initData(arg_68_0)
	arg_68_0.dropData = pg.mini_game[arg_68_0:GetMGData().id].simple_config_data.drop_ids

	local var_68_0 = Application.targetFrameRate or 60

	if var_68_0 > 60 then
		var_68_0 = 60
	end

	arg_68_0.timer = Timer.New(function()
		arg_68_0:onTimer()

		return
	end, 1 / var_68_0, -1)

	return
end

function var_0_0.initUI(arg_70_0)
	arg_70_0.backSceneTf = findTF(arg_70_0._tf, "scene_container/scene_background")
	arg_70_0.sceneTf = findTF(arg_70_0._tf, "scene_container/scene")
	arg_70_0.bgTf = findTF(arg_70_0._tf, "bg")
	arg_70_0.clickMask = findTF(arg_70_0._tf, "clickMask")
	arg_70_0.countUI = findTF(arg_70_0._tf, "pop/CountUI")
	arg_70_0.countAnimator = GetComponent(findTF(arg_70_0.countUI, "count"), typeof(Animator))
	arg_70_0.countDft = GetOrAddComponent(findTF(arg_70_0.countUI, "count"), typeof(DftAniEvent))

	arg_70_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_70_0.countDft:SetEndEvent(function()
		setActive(arg_70_0.countUI, false)
		arg_70_0:gameStart()

		return
	end)
	SetActive(arg_70_0.countUI, false)

	arg_70_0.leaveUI = findTF(arg_70_0._tf, "pop/LeaveUI")

	GetComponent(findTF(arg_70_0.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	onButton(arg_70_0, findTF(arg_70_0.leaveUI, "ad/btnOk"), function()
		arg_70_0:resumeGame()
		arg_70_0:onGameOver(false)

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.leaveUI, "ad/btnCancel"), function()
		arg_70_0:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(arg_70_0.leaveUI, false)

	arg_70_0.pauseUI = findTF(arg_70_0._tf, "pop/pauseUI")

	GetComponent(findTF(arg_70_0.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	onButton(arg_70_0, findTF(arg_70_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_70_0.pauseUI, false)
		arg_70_0:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(arg_70_0.pauseUI, false)

	arg_70_0.settlementUI = findTF(arg_70_0._tf, "pop/SettleMentUI")

	onButton(arg_70_0, findTF(arg_70_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_70_0.settlementUI, false)
		arg_70_0:openMenuUI()

		return
	end, SFX_CANCEL)
	SetActive(arg_70_0.settlementUI, false)

	arg_70_0.menuUI = findTF(arg_70_0._tf, "pop/menuUI")
	arg_70_0.battleScrollRect = GetComponent(findTF(arg_70_0.menuUI, "battList"), typeof(ScrollRect))
	arg_70_0.titleDesc = findTF(arg_70_0.menuUI, "desc")

	GetComponent(arg_70_0.titleDesc, typeof(Image)):SetNativeSize()

	arg_70_0.totalTimes = arg_70_0:getGameTotalTime()

	scrollTo(arg_70_0.battleScrollRect, 0, 1 - (arg_70_0:getGameUsedTimes() - 4 < 0 and 0 or arg_70_0:getGameUsedTimes() - 4) / (arg_70_0.totalTimes - 4))
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_77_0 = arg_70_0.battleScrollRect.normalizedPosition.y + 1 / (arg_70_0.totalTimes - 4)

		if arg_70_0.battleScrollRect.normalizedPosition.y + 1 / (arg_70_0.totalTimes - 4) > 1 then
			var_77_0 = 1
		end

		scrollTo(arg_70_0.battleScrollRect, 0, var_77_0)

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_78_0 = arg_70_0.battleScrollRect.normalizedPosition.y - 1 / (arg_70_0.totalTimes - 4)

		if arg_70_0.battleScrollRect.normalizedPosition.y - 1 / (arg_70_0.totalTimes - 4) < 0 then
			var_78_0 = 0
		end

		scrollTo(arg_70_0.battleScrollRect, 0, var_78_0)

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "btnBack"), function()
		arg_70_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_9].tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "btnStart"), function()
		setActive(arg_70_0.menuUI, false)
		arg_70_0:readyStart()

		return
	end, SFX_CANCEL)
	onButton(arg_70_0, findTF(arg_70_0.menuUI, "home"), function()
		arg_70_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_70_0 = findTF(arg_70_0.menuUI, "tplBattleItem")

	arg_70_0.battleItems = {}
	arg_70_0.dropItems = {}

	for iter_70_0 = 1, 7 do
		local var_70_2 = tf(instantiate(var_70_0))

		var_70_2.name = "battleItem_" .. iter_70_0

		setParent(var_70_2, findTF(arg_70_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(var_0_8, "buttomDesc" .. iter_70_0, function(arg_83_0)
			if arg_83_0 then
				setImageSprite(findTF(var_70_2, "state_open/bg"), arg_83_0, true)
				setImageSprite(findTF(var_70_2, "state_clear/bg"), arg_83_0, true)
				setImageSprite(findTF(var_70_2, "state_current/bg"), arg_83_0, true)
				setImageSprite(findTF(var_70_2, "state_closed/bg"), arg_83_0, true)
			end

			return
		end)

		local var_70_3 = findTF(var_70_2, "icon")

		updateDrop(var_70_3, {
			type = arg_70_0.dropData[iter_70_0][1],
			id = arg_70_0.dropData[iter_70_0][2],
			count = arg_70_0.dropData[iter_70_0][3]
		})
		onButton(arg_70_0._event, var_70_3, function()
			arg_70_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_70_0.dropItems, var_70_3)
		setActive(var_70_2, true)
		table.insert(arg_70_0.battleItems, var_70_2)
	end

	arg_70_0.handle = arg_70_0.handle or UpdateBeat:CreateListener(arg_70_0.Update, arg_70_0)

	UpdateBeat:AddListener(arg_70_0.handle)

	return
end

function var_0_0.initGameUI(arg_85_0)
	arg_85_0.gameUI = findTF(arg_85_0._tf, "ui/gameUI")

	onButton(arg_85_0, findTF(arg_85_0.gameUI, "topRight/btnStop"), function()
		arg_85_0:stopGame()
		setActive(arg_85_0.pauseUI, true)

		return
	end)
	onButton(arg_85_0, findTF(arg_85_0.gameUI, "btnLeave"), function()
		arg_85_0:stopGame()
		setActive(arg_85_0.leaveUI, true)

		return
	end)

	arg_85_0.dragDelegate = GetOrAddComponent(arg_85_0.sceneTf, "EventTriggerListener")
	arg_85_0.dragDelegate.enabled = true

	arg_85_0.dragDelegate:AddPointDownFunc(function(arg_88_0, arg_88_1)
		if arg_85_0.boatController then
			arg_85_0.boatController:throw()
		end

		return
	end)

	arg_85_0.gameTimeS = findTF(arg_85_0.gameUI, "top/time/s")
	arg_85_0.scoreTf = findTF(arg_85_0.gameUI, "top/score")
	arg_85_0.boatController = var_0_47(arg_85_0.sceneTf, arg_85_0)
	arg_85_0.itemController = var_0_48(arg_85_0.sceneTf, arg_85_0.backSceneTf, arg_85_0:getGameUsedTimes(), arg_85_0)
	arg_85_0.catchController = var_0_49(arg_85_0.boatController, arg_85_0.itemController)
	arg_85_0.charController = var_0_50(arg_85_0.backSceneTf, arg_85_0)
	arg_85_0.sceneScoreTf = findTF(arg_85_0.sceneTf, "scoreTf")

	setActive(arg_85_0.sceneScoreTf, false)

	return
end

function var_0_0.Update(arg_89_0)
	arg_89_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_90_0)
	if arg_90_0.gameStop or arg_90_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_91_0)
	local var_91_0 = arg_91_0:getGameUsedTimes()
	local var_91_1 = arg_91_0:getGameTimes()

	for iter_91_0 = 1, 7 do
		setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_open"), false)
		setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_closed"), false)
		setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_clear"), false)
		setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_current"), false)

		if iter_91_0 <= var_91_0 then
			SetParent(arg_91_0.dropItems[iter_91_0], findTF(arg_91_0.battleItems[iter_91_0], "state_clear/icon"))
			setActive(arg_91_0.dropItems[iter_91_0], true)
			setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_clear"), true)
		elseif iter_91_0 == var_91_0 + 1 and var_91_1 >= 1 then
			setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_current"), true)
			SetParent(arg_91_0.dropItems[iter_91_0], findTF(arg_91_0.battleItems[iter_91_0], "state_current/icon"))
			setActive(arg_91_0.dropItems[iter_91_0], true)
		elseif var_91_0 < iter_91_0 and iter_91_0 <= var_91_0 + var_91_1 then
			setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_open"), true)
			SetParent(arg_91_0.dropItems[iter_91_0], findTF(arg_91_0.battleItems[iter_91_0], "state_open/icon"))
			setActive(arg_91_0.dropItems[iter_91_0], true)
		else
			setActive(findTF(arg_91_0.battleItems[iter_91_0], "state_closed"), true)
			SetParent(arg_91_0.dropItems[iter_91_0], findTF(arg_91_0.battleItems[iter_91_0], "state_closed/icon"))
			setActive(arg_91_0.dropItems[iter_91_0], true)
		end
	end

	arg_91_0.totalTimes = arg_91_0:getGameTotalTime()

	local var_91_2 = 1 - (arg_91_0:getGameUsedTimes() - 3 < 0 and 0 or arg_91_0:getGameUsedTimes() - 3) / (arg_91_0.totalTimes - 4)

	if var_91_2 > 1 then
		var_91_2 = 1
	end

	scrollTo(arg_91_0.battleScrollRect, 0, var_91_2)
	setActive(findTF(arg_91_0.menuUI, "btnStart/tip"), var_91_1 > 0)
	arg_91_0:CheckGet()

	local var_91_3 = arg_91_0:GetMGData():GetRuntimeData("elements")

	if var_91_3 and #var_91_3 > 0 then
		local var_91_4 = var_91_3[1] or 0

		setText(findTF(arg_91_0.menuUI, "high"), var_91_4)

		return
	end
end

function var_0_0.CheckGet(arg_92_0)
	setActive(findTF(arg_92_0.menuUI, "got"), false)

	if arg_92_0:getUltimate() and arg_92_0:getUltimate() ~= 0 then
		setActive(findTF(arg_92_0.menuUI, "got"), true)
	end

	if arg_92_0:getUltimate() == 0 then
		if arg_92_0:getGameTotalTime() > arg_92_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_92_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_92_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_93_0)
	setActive(findTF(arg_93_0._tf, "scene_container"), false)
	setActive(findTF(arg_93_0.bgTf, "on"), true)
	setActive(arg_93_0.gameUI, false)
	setActive(arg_93_0.menuUI, true)
	arg_93_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_94_0)
	setActive(arg_94_0.sceneTf, false)
	setActive(arg_94_0.settlementUI, false)
	setActive(arg_94_0.countUI, false)
	setActive(arg_94_0.menuUI, false)
	setActive(arg_94_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_95_0)
	setActive(arg_95_0.countUI, true)
	arg_95_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	return
end

function var_0_0.getGameTimes(arg_96_0)
	return arg_96_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_97_0)
	return arg_97_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_98_0)
	return arg_98_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_99_0)
	return (arg_99_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.gameStart(arg_100_0)
	setActive(findTF(arg_100_0._tf, "scene_container"), true)
	setActive(findTF(arg_100_0.bgTf, "on"), false)
	setActive(arg_100_0.gameUI, true)

	arg_100_0.gameStartFlag = true
	arg_100_0.scoreNum = 0
	arg_100_0.playerPosIndex = 2
	arg_100_0.gameStepTime = 0
	arg_100_0.heart = 3
	arg_100_0.gameTime = var_0_7

	SetActive(arg_100_0.sceneScoreTf, false)

	if arg_100_0.boatController then
		arg_100_0.boatController:start()
	end

	if arg_100_0.itemController then
		arg_100_0.itemController:start()
	end

	if arg_100_0.catchController then
		arg_100_0.catchController:start()
	end

	if arg_100_0.charController then
		arg_100_0.charController:start()
	end

	arg_100_0:updateGameUI()
	arg_100_0:timerStart()

	return
end

function var_0_0.transformColor(arg_101_0, arg_101_1)
	return Color.New(tonumber(string.sub(arg_101_1, 1, 2), 16) / 255, tonumber(string.sub(arg_101_1, 3, 4), 16) / 255, tonumber(string.sub(arg_101_1, 5, 6), 16) / 255)
end

function var_0_0.addScore(arg_102_0, arg_102_1, arg_102_2)
	if arg_102_1 and arg_102_1 > 0 or arg_102_2 and arg_102_2 > 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
	elseif arg_102_1 and arg_102_1 < 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
	end

	setActive(arg_102_0.sceneScoreTf, false)

	local var_102_0 = findTF(arg_102_0.sceneScoreTf, "img")
	local var_102_1 = GetComponent(var_102_0, typeof(Text))
	local var_102_2 = "6f1807"

	if arg_102_1 then
		local var_102_3

		for iter_102_0 = 1, #var_0_38 do
			if arg_102_1 and arg_102_1 >= var_0_38[iter_102_0].score then
				var_102_2 = var_0_38[iter_102_0].color
				var_102_3 = var_0_38[iter_102_0].font

				break
			end
		end

		local var_102_4 = arg_102_0:transformColor(var_102_2)

		arg_102_0.scoreNum = arg_102_0.scoreNum + arg_102_1

		setText(var_102_0, (arg_102_1 >= 0 and "+" or "") .. arg_102_1)

		var_102_1.fontSize = var_102_3 or 40

		setTextColor(var_102_0, var_102_4)
	end

	if arg_102_2 then
		var_102_1.fontSize = 40

		setTextColor(var_102_0, (arg_102_0:transformColor("66f2fb")))

		local var_102_5

		if arg_102_0.gameTime > 0 then
			arg_102_0.gameTime = arg_102_0.gameTime + arg_102_2
			var_102_5 = setText
		end

		var_102_5(var_102_0, (arg_102_2 > 0 and "+" or "") .. arg_102_2 .. "s")
	end

	setActive(arg_102_0.sceneScoreTf, true)

	return
end

function var_0_0.onTimer(arg_103_0)
	arg_103_0:gameStep()

	return
end

function var_0_0.gameStep(arg_104_0)
	arg_104_0.gameTime = arg_104_0.gameTime - Time.deltaTime
	arg_104_0.gameStepTime = arg_104_0.gameStepTime + Time.deltaTime

	if arg_104_0.boatController then
		arg_104_0.boatController:step()
	end

	if arg_104_0.itemController then
		arg_104_0.itemController:step()
	end

	if arg_104_0.catchController then
		arg_104_0.catchController:step()
	end

	if arg_104_0.charController then
		arg_104_0.charController:step()
	end

	if arg_104_0.gameTime < 0 then
		arg_104_0.gameTime = 0
	end

	arg_104_0:updateGameUI()

	if arg_104_0.gameTime <= 0 then
		arg_104_0:onGameOver(true)

		return
	end

	return
end

function var_0_0.timerStart(arg_105_0)
	if not arg_105_0.timer.running then
		arg_105_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_106_0)
	if arg_106_0.timer.running then
		arg_106_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_107_0)
	setText(arg_107_0.scoreTf, arg_107_0.scoreNum)
	setText(arg_107_0.gameTimeS, math.ceil(arg_107_0.gameTime))

	return
end

function var_0_0.onGameOver(arg_108_0, arg_108_1)
	if arg_108_0.settlementFlag then
		return
	end

	arg_108_0:timerStop()

	arg_108_0.settlementFlag = true

	setActive(arg_108_0.clickMask, true)

	if arg_108_0.boatController then
		arg_108_0.boatController:gameOver()
	end

	LeanTween.delayedCall(go(arg_108_0._tf), 2, System.Action(function()
		arg_108_0.settlementFlag = false
		arg_108_0.gameStartFlag = false

		setActive(arg_108_0.clickMask, false)
		arg_108_0:showSettlement()

		return
	end))
	arg_108_0:emit(BaseMiniGameMediator.GAME_FINISH_TRACKING, {
		game_id = arg_108_0:GetMGData().id,
		hub_id = arg_108_0:GetMGHubData().id,
		isComplete = arg_108_1 and 1 or 0
	})

	return
end

function var_0_0.showSettlement(arg_110_0)
	setActive(arg_110_0.settlementUI, true)
	GetComponent(findTF(arg_110_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_110_0 = arg_110_0:GetMGData():GetRuntimeData("elements")
	local var_110_1 = arg_110_0.scoreNum

	if var_110_0 and #var_110_0 > 0 then
		local var_110_2 = var_110_0[1] or 0

		setActive(findTF(arg_110_0.settlementUI, "ad/new"), var_110_2 < var_110_1)

		if var_110_2 <= var_110_1 then
			var_110_2 = var_110_1

			arg_110_0:StoreDataToServer({
				var_110_1
			})
		end

		setText(findTF(arg_110_0.settlementUI, "ad/highText"), var_110_2)
		setText(findTF(arg_110_0.settlementUI, "ad/currentText"), var_110_1)

		if arg_110_0:getGameTimes() and arg_110_0:getGameTimes() > 0 then
			arg_110_0.sendSuccessFlag = true

			arg_110_0:SendSuccess(0)
		end

		return
	end
end

function var_0_0.resumeGame(arg_111_0)
	arg_111_0.gameStop = false

	setActive(arg_111_0.leaveUI, false)
	arg_111_0:timerStart()

	return
end

function var_0_0.stopGame(arg_112_0)
	arg_112_0.gameStop = true

	arg_112_0:timerStop()

	return
end

function var_0_0.onBackPressed(arg_113_0)
	if not arg_113_0.gameStartFlag then
		arg_113_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_113_0.settlementFlag then
			return
		end

		if isActive(arg_113_0.pauseUI) then
			setActive(arg_113_0.pauseUI, false)
		end

		arg_113_0:stopGame()
		setActive(arg_113_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_114_0)
	if arg_114_0.handle then
		UpdateBeat:RemoveListener(arg_114_0.handle)
	end

	if arg_114_0._tf and LeanTween.isTweening(go(arg_114_0._tf)) then
		LeanTween.cancel(go(arg_114_0._tf))
	end

	if arg_114_0.timer and arg_114_0.timer.running then
		arg_114_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_114_0.timer = nil

	return
end

return var_0_0
