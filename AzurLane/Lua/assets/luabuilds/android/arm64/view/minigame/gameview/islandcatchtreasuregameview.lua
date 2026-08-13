class = var_0_10000

local var_0_0 = "IslandCatchTreasureGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "blueocean-image"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/taosheng"
local var_0_5 = "event:/ui/zhuahuo"
local var_0_6 = "event:/ui/deshou"
local var_0_7 = "event:/ui/shibai"
local var_0_8 = 60
local var_0_9 = "ui/islandcatchtreasuregameui_atlas"
local var_0_10 = "salvage_tips"
local var_0_11 = "event item done"
local var_0_12 = "boat state stand"
local var_0_13 = "boat state thorw"
local var_0_14 = "boat state wait"
local var_0_15 = "item act static"
local var_0_16 = "item act dynamic"
local var_0_17 = "item catch normal"
local var_0_18 = "item catch release"
local var_0_19 = "item catch unable"
local var_0_20 = "item good happy"
local var_0_21 = "item good surprise"
local var_0_22 = "item good release"
local var_0_23 = "item good none"
local var_0_24 = "item scene back"
local var_0_25 = "item scene middle"
local var_0_26 = "item scene front"
local var_0_27 = "item type fish"
local var_0_28 = "item type submarine"
local var_0_29 = "item type goods"
local var_0_30 = "item type sundries"
local var_0_31 = "item type time"
local var_0_32 = "item type back"
local var_0_33 = "item type bind"
local var_0_34 = "item type name "
local var_0_35 = {
	{
		type = var_0_15,
		range = {
			5,
			8
		}
	},
	{
		type = var_0_16,
		range = {
			5,
			8
		}
	}
}
local var_0_36 = {
	{
		{
			repeated = true,
			type = var_0_32,
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_30,
			amount = {
				3,
				3
			}
		},
		{
			repeated = true,
			type = var_0_31,
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_32,
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_30,
			amount = {
				0,
				0
			}
		},
		{
			repeated = true,
			type = var_0_31,
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_28,
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
			type = var_0_32,
			amount = {
				8,
				10
			}
		},
		{
			repeated = true,
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_29,
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
			type = var_0_30,
			amount = {
				1,
				1
			}
		},
		{
			repeated = true,
			type = var_0_31,
			amount = {
				2,
				2
			}
		},
		{
			repeated = true,
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_27,
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
			type = var_0_28,
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
local var_0_37 = {
	{
		score = 200,
		name = "fish_1",
		catch_speed = 130,
		speed = 150,
		release_speed = 200,
		type = var_0_27,
		act = var_0_16,
		catch = var_0_18,
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
		good = var_0_22
	},
	{
		score = 250,
		name = "fish_2",
		catch_speed = 75,
		speed = 100,
		leave_direct = -1,
		release_speed = 200,
		type = var_0_27,
		act = var_0_16,
		catch = var_0_18,
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
		good = var_0_21
	},
	{
		score = 400,
		name = "fish_3",
		catch_speed = 220,
		speed = 350,
		release_speed = 300,
		type = var_0_27,
		act = var_0_16,
		catch = var_0_18,
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
		good = var_0_22
	},
	{
		score = 150,
		name = "fish_4",
		catch_speed = 160,
		speed = 120,
		release_speed = 200,
		type = var_0_27,
		act = var_0_16,
		catch = var_0_18,
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
		good = var_0_22
	},
	{
		score = 180,
		name = "turtle",
		catch_speed = 100,
		speed = 80,
		release_speed = 100,
		type = var_0_27,
		act = var_0_16,
		catch = var_0_18,
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
		good = var_0_22
	},
	{
		score = -150,
		name = "submarine_1",
		speed = 200,
		catch_speed = 100,
		release_speed = 200,
		type = var_0_28,
		act = var_0_16,
		catch = var_0_18,
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = var_0_22,
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
		type = var_0_28,
		act = var_0_16,
		catch = var_0_18,
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = var_0_22,
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
		type = var_0_28,
		act = var_0_16,
		catch = var_0_18,
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = var_0_22,
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
		type = var_0_28,
		act = var_0_16,
		catch = var_0_18,
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = var_0_22,
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
		type = var_0_30,
		act = var_0_16,
		catch = var_0_17,
		move_range = {
			-300,
			1800,
			0,
			0
		},
		good = var_0_21
	},
	{
		speed = 0,
		name = "rock",
		score = 50,
		catch_speed = 80,
		type = var_0_29,
		act = var_0_15,
		catch = var_0_17,
		good = var_0_23
	},
	{
		score = 300,
		name = "gold",
		speed = 0,
		catch_speed = 160,
		type = var_0_29,
		act = var_0_15,
		catch = var_0_17,
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = var_0_20
	},
	{
		score = 600,
		name = "treasure",
		speed = 0,
		catch_speed = 55,
		type = var_0_29,
		act = var_0_15,
		catch = var_0_17,
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = var_0_20
	},
	{
		name = "watch",
		time = 20,
		speed = 0,
		catch_speed = 180,
		type = var_0_31,
		act = var_0_15,
		catch = var_0_17,
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = var_0_20
	},
	{
		score = 200,
		name = "shell",
		speed = 0,
		catch_speed = 100,
		type = var_0_29,
		act = var_0_15,
		catch = var_0_17,
		create_range = {
			0,
			9999,
			0,
			130
		},
		good = var_0_20,
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
		type = var_0_33,
		act = var_0_15,
		catch = var_0_17,
		good = var_0_20
	},
	{
		name = "Anglerfish",
		direct = -1,
		speed = 30,
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
		type = var_0_32,
		act = var_0_16,
		scene = var_0_24,
		catch = var_0_19,
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
local var_0_38 = 500
local var_0_39 = 300
local var_0_40 = 200
local var_0_41 = 200
local var_0_42 = 45
local var_0_43 = 2.5
local var_0_44 = 50
local var_0_45 = 100
local var_0_46 = 580
local var_0_47 = 130
local var_0_48 = {
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
local var_0_49 = "char apply position"
local var_0_50 = "char apply move"
local var_0_51 = "char apply act"
local var_0_52 = {
	{
		speed = 3,
		tf = "Shiratsuyu",
		id = 1,
		bindIds = {
			2
		},
		actions = {
			{
				posX = -1200,
				type = var_0_49
			},
			{
				trigger = "moveA",
				type = var_0_51
			},
			{
				sync = true,
				direct = -1,
				offsetX = -50,
				type = var_0_50,
				moveToX = {
					300,
					400
				}
			},
			{
				time = 2,
				trigger = "actA",
				type = var_0_51
			},
			{
				time = 2,
				trigger = "actB",
				type = var_0_51
			},
			{
				time = 0,
				trigger = "moveB",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					2000,
					2000
				}
			}
		}
	},
	{
		id = 2,
		tf = "Shigure",
		speed = 3,
		actions = {
			{
				posX = 1200,
				type = var_0_49
			},
			{
				trigger = "moveA",
				type = var_0_51
			},
			{
				sync = true,
				direct = -1,
				offsetX = 50,
				type = var_0_50
			},
			{
				time = 2,
				trigger = "actA",
				type = var_0_51
			},
			{
				time = 2,
				trigger = "actB",
				type = var_0_51
			},
			{
				time = 0,
				trigger = "moveB",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					2100,
					2200
				}
			}
		}
	},
	{
		id = 3,
		tf = "eldridge",
		speed = 2,
		actions = {
			{
				posX = -1200,
				type = var_0_49
			},
			{
				trigger = "move",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					100,
					300
				}
			},
			{
				trigger = "act",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					600,
					700
				}
			},
			{
				trigger = "act",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					1300,
					1300
				}
			}
		}
	},
	{
		id = 4,
		tf = "bombBoat",
		speed = 4,
		actions = {
			{
				posX = 1200,
				type = var_0_49
			},
			{
				trigger = "move",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					-1100,
					-1300
				}
			}
		}
	},
	{
		id = 5,
		tf = "Fleet",
		speed = 3,
		actions = {
			{
				posX = -1200,
				type = var_0_49
			},
			{
				trigger = "move",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					500,
					700
				}
			},
			{
				time = 4,
				trigger = "act",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					1300,
					1500
				}
			}
		}
	},
	{
		id = 6,
		tf = "Glowworm",
		speed = 4,
		actions = {
			{
				posX = 1200,
				type = var_0_49
			},
			{
				trigger = "move",
				type = var_0_51
			},
			{
				direct = -1,
				type = var_0_50,
				moveToX = {
					-550,
					-1000
				}
			},
			{
				time = 2,
				trigger = "act",
				type = var_0_51
			}
		}
	}
}
local var_0_53 = {
	25,
	30
}
local var_0_54 = {
	1,
	3,
	4,
	5,
	6
}
local var_0_55 = {
	"actA",
	"actB"
}
local var_0_56 = {
	10,
	15
}

local function var_0_57(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._sceneTf = arg_1_0
			findTF = var_1
			arg_2_0._boatTf = var_1(arg_1_0, "boat")
			arg_2_0._event = arg_1_1
			findTF = var_1
			arg_2_0._hookTf = var_1(arg_2_0._boatTf, "body/hook")
			findTF = var_1
			arg_2_0._hookContent = var_1(arg_2_0._hookTf, "container/content")
			findTF = var_1
			arg_2_0._hookCollider = var_1(arg_2_0._hookTf, "container/collider")
			findTF = var_1
			arg_2_0._sceneContent = var_1(arg_2_0._sceneTf, "container/content")
			GetComponent = var_1
			findTF = var_3

			local var_2_0 = var_3(arg_2_0._hookTf, "bottom")

			typeof = var_4
			Animator = var_6
			arg_2_0.hookAnimator = var_1(var_2_0, var_4(var_6))
			GetComponent = var_1
			findTF = var_2_0

			local var_2_1 = var_2_0(arg_2_0._hookTf, "mask/img")

			typeof = var_4
			Animator = var_6
			arg_2_0.hookMaskAnimator = var_1(var_2_1, var_4(var_6))
			GetComponent = var_1
			findTF = var_2_1

			local var_2_2 = var_2_1(arg_2_0._boatTf, "body/captain/img")

			typeof = var_4
			Animator = var_6
			arg_2_0.captainAnimator = var_1(var_2_2, var_4(var_6))
			GetComponent = var_1
			findTF = var_2_2

			local var_2_3 = var_2_2(arg_2_0._boatTf, "body/captain/img")

			typeof = var_4
			DftAniEvent = var_6

			local var_2_4 = var_1(var_2_3, var_4(var_6))

			var_1.SetEndEvent(var_2_4, function()
				if arg_2_0.inGoodAct then
					arg_2_0.inGoodAct = false
				end

				return
			end)

			GetComponent = var_2
			findTF = var_2_4

			local var_2_5 = var_2_4(arg_2_0._boatTf, "body/mariner/img")

			typeof = var_5
			Animator = var_7
			arg_2_0.marinerAnimator = var_2(var_2_5, var_5(var_7))

			return
		end,
		start = function(arg_4_0)
			local var_4_0 = arg_4_0._hookTf

			Vector2 = var_2_10002
			var_4_0.sizeDelta = var_2_10002(0, 1)
			arg_4_0.boatState = var_0_12
			arg_4_0.hookRotation = var_0_42
			arg_4_0.hookRotationSpeed = 0
			arg_4_0.hookTargetRotation = var_0_42
			arg_4_0.throwHook = false
			arg_4_0.inGoodAct = false

			if arg_4_0.catchItem then
				destroy = var_1

				var_1(arg_4_0.catchItem.tf)

				arg_4_0.catchItem = nil
			end

			arg_4_0.marinerActTime = nil
			arg_4_0.marinerActName = nil

			arg_4_0:leaveItem()

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.boatState == var_0_12 then
				var_2_10003 = arg_5_0

				arg_5_0.checkChangeRotation(var_2_10003)

				arg_5_0.hookRotation = arg_5_0.hookRotation + arg_5_0:getSpringRotation()

				local var_5_0 = arg_5_0._hookTf

				Vector3 = var_2
				var_5_0.localEulerAngles = var_2(0, 0, arg_5_0.hookRotation)
			elseif arg_5_0.boatState == var_0_13 then
				if arg_5_0.throwHook then
					local var_5_1 = arg_5_0._hookTf

					Vector2 = var_2

					local var_5_2 = 0
					local var_5_3 = arg_5_0._hookTf.sizeDelta.y
					local var_5_4 = var_0_40

					Time = var_2_10007
					var_5_1.sizeDelta = var_2(var_5_2, var_5_3 + var_5_4 * var_2_10007.deltaTime)
					math = var_5_1

					local var_5_5 = var_5_1.cos

					math = var_2_10003

					local var_5_6 = var_2_10003.deg2Rad

					math = var_5_2

					local var_5_7 = var_5_5(var_5_6 * var_5_2.abs(arg_5_0.hookRotation))

					if arg_5_0._hookTf.sizeDelta.y * var_5_7 > var_0_39 or arg_5_0._hookTf.sizeDelta.y > var_0_38 then
						arg_5_0.throwHook = false
					end
				else
					local var_5_8 = arg_5_0:hookBack()

					if not arg_5_0.catchItem and var_5_8 then
						arg_5_0.boatState = var_0_12
					elseif arg_5_0.catchItem then
						local var_5_9 = arg_5_0._hookContent.position
						local var_5_10 = arg_5_0._sceneContent
						local var_5_11 = var_3.InverseTransformPoint(var_5_10, var_5_9)

						if (arg_5_0.catchItem.data.catch == var_0_18 or arg_5_0.catchItem.data.act == var_0_16) and var_5_11.y > var_0_46 then
							arg_5_0.boatState = var_0_14

							arg_5_0:leaveItem()
						elseif var_5_8 then
							arg_5_0.boatState = var_0_14

							arg_5_0:leaveItem()
						end
					end
				end
			elseif arg_5_0.boatState == var_0_14 then
				if not arg_5_0:hookBack() then
					return
				end

				if arg_5_0.inGoodAct then
					return
				end

				arg_5_0.boatState = var_0_12
			end

			if arg_5_0.boatState == var_0_13 and arg_5_0.throwHook then
				local var_5_12 = arg_5_0.hookAnimator

				var_1.SetBool(var_5_12, "hook", true)

				local var_5_13 = arg_5_0.hookMaskAnimator

				var_1.SetBool(var_5_13, "hook", true)
			else
				local var_5_14 = arg_5_0.hookAnimator

				var_1.SetBool(var_5_14, "hook", false)

				local var_5_15 = arg_5_0.hookMaskAnimator

				var_1.SetBool(var_5_15, "hook", false)
			end

			if arg_5_0.boatState == var_0_13 then
				if arg_5_0.throwHook then
					local var_5_16 = arg_5_0.captainAnimator

					var_1.SetInteger(var_5_16, "state", 4)
				else
					local var_5_17 = 1

					if arg_5_0.catchItem then
						var_5_17 = arg_5_0.catchItem.data.catch_speed >= 100 and 1 or arg_5_0.catchItem.data.catch_speed >= 50 and arg_5_0.catchItem.data.catch_speed <= 100 and 2 or 3
					end

					local var_5_18 = arg_5_0.captainAnimator

					var_2.SetInteger(var_5_18, "state", var_5_17)
				end
			else
				local var_5_19 = arg_5_0.captainAnimator

				var_1.SetInteger(var_5_19, "state", 0)
			end

			if not arg_5_0.marinerActTime then
				math = var_1
				arg_5_0.marinerActTime = var_1.random(var_0_56[1], var_0_56[2])

				local var_5_20 = var_0_55

				math = var_2
				arg_5_0.marinerActName = var_5_20[var_2.random(1, #var_0_55)]
			elseif arg_5_0.marinerActTime <= 0 then
				local var_5_21 = arg_5_0.marinerAnimator

				var_1.SetTrigger(var_5_21, arg_5_0.marinerActName)

				math = var_1
				arg_5_0.marinerActTime = var_1.random(var_0_56[1], var_0_56[2])

				local var_5_22 = var_0_55

				math = var_2
				arg_5_0.marinerActName = var_5_22[var_2.random(1, #var_0_55)]
			else
				local var_5_23 = arg_5_0.marinerActTime

				Time = var_2
				arg_5_0.marinerActTime = var_5_23 - var_2.deltaTime
			end

			return
		end,
		hookBack = function(arg_6_0)
			local var_6_0 = arg_6_0._hookTf.sizeDelta.y

			if 1 < var_6_0 then
				local var_6_1 = var_0_41

				Time = var_2

				local var_6_2 = var_6_1 * var_2.deltaTime

				if arg_6_0.catchItem then
					local var_6_3 = arg_6_0.catchItem.data.catch_speed

					Time = var_2_10003
					var_6_2 = var_6_3 * var_2_10003.deltaTime
				end

				local var_6_4 = arg_6_0._hookTf

				Vector2 = var_2_10003
				var_6_4.sizeDelta = var_2_10003(0, arg_6_0._hookTf.sizeDelta.y - var_6_2)

				return false
			elseif arg_6_0._hookTf.sizeDelta.y < 1 then
				local var_6_5 = arg_6_0._hookTf

				Vector2 = var_2
				var_6_5.sizeDelta = var_2(0, 1)

				return false
			end

			return true
		end,
		leaveItem = function(arg_7_0)
			if arg_7_0.catchItem then
				local var_7_0 = arg_7_0._event

				var_1.emit(var_7_0, var_0_11, arg_7_0.catchItem, function()
					return
				end)

				arg_7_0.inGoodAct = true

				if arg_7_0.catchItem.data.good == var_0_20 then
					local var_7_1 = arg_7_0.captainAnimator

					var_1.SetTrigger(var_7_1, "happy")

					local var_7_2 = arg_7_0.marinerAnimator

					var_1.SetTrigger(var_7_2, "happy")
				elseif arg_7_0.catchItem.data.good == var_0_22 then
					local var_7_3 = arg_7_0.captainAnimator

					var_1.SetTrigger(var_7_3, "release")
				elseif arg_7_0.catchItem.data.good == var_0_21 then
					local var_7_4 = arg_7_0.captainAnimator

					var_1.SetTrigger(var_7_4, "surprise")

					local var_7_5 = arg_7_0.marinerAnimator

					var_1.SetTrigger(var_7_5, "surprise")
				elseif arg_7_0.catchItem.data.good == var_0_23 then
					arg_7_0.inGoodAct = false
				end

				arg_7_0.catchItem = nil
			end

			return
		end,
		throw = function(arg_9_0)
			if arg_9_0.boatState ~= var_0_12 then
				return
			end

			pg = var_1

			local var_9_0 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_9_0, var_0_4)

			arg_9_0.throwHook = true
			arg_9_0.boatState = var_0_13

			return
		end,
		setCatchItem = function(arg_10_0, arg_10_1)
			if arg_10_0.boatState == var_0_13 and arg_10_0.throwHook then
				arg_10_0.catchItem = arg_10_1
				arg_10_0.throwHook = false

				local var_10_0 = arg_10_1.tf

				Vector3 = var_3
				math = var_2_10005
				var_10_0.localScale = var_3(var_2_10005.sign(arg_10_1.tf.localScale.x), 1, 1)
				SetParent = var_10_0

				var_10_0(arg_10_1.tf, arg_10_0._hookContent)

				local var_10_1 = arg_10_1.tf

				Vector2 = var_3
				var_10_1.anchoredPosition = var_3(0, 0)
				pg = var_10_1

				local var_10_2 = var_10_1.CriMgr.GetInstance()

				var_2.PlaySoundEffect_V3(var_10_2, var_0_5)
			end

			return
		end,
		getSpringRotation = function(arg_11_0)
			local var_11_0 = arg_11_0.hookRotationSpeed

			math = var_2_10002
			arg_11_0.hookRotationSpeed = var_11_0 + var_2_10002.sign(arg_11_0.hookTargetRotation) * var_0_43
			math = var_1

			local var_11_1 = var_1.abs(arg_11_0.hookRotationSpeed)

			if var_0_44 < var_11_1 then
				local var_11_2 = var_0_44

				math = var_2
				arg_11_0.hookRotationSpeed = var_11_2 * var_2.sign(arg_11_0.hookTargetRotation)
			end

			local var_11_3 = arg_11_0.hookRotationSpeed

			Time = var_2

			return var_11_3 * var_2.deltaTime
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
			return arg_13_0.boatState == var_0_13 and arg_13_0.throwHook
		end,
		getHookPosition = function(arg_14_0)
			return arg_14_0._hookCollider.position
		end,
		gameOver = function(arg_15_0)
			local var_15_0 = arg_15_0.captainAnimator

			var_1.SetTrigger(var_15_0, "end")

			local var_15_1 = arg_15_0.marinerAnimator

			var_1.SetTrigger(var_15_1, "end")

			return
		end,
		destroy = function(arg_16_0)
			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

local function var_0_58(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {
		ctor = function(arg_18_0)
			arg_18_0._event = arg_17_3
			findTF = var_1
			arg_18_0._sceneTpls = var_1(arg_17_0, "sceneTpls")
			findTF = var_1
			arg_18_0._backSceneTpls = var_1(arg_17_1, "bgTpls")
			arg_18_0._gameMission = arg_17_2 + 1
			findTF = var_1

			local var_18_0 = var_1(arg_17_0, "container")

			arg_18_0._createBounds = {
				var_18_0.sizeDelta.x,
				var_18_0.sizeDelta.y
			}
			findTF = var_2
			arg_18_0._parentTf = var_2(var_18_0, "content")
			findTF = var_2
			arg_18_0._backParentTf = var_2(arg_17_1, "container/content")
			arg_18_0.items = {}

			return
		end,
		getParentInversePos = function(arg_19_0, arg_19_1)
			local var_19_0 = arg_19_1.tf.position
			local var_19_1

			if arg_19_1.data.scene then
				if arg_19_1.data.scene == var_0_24 then
					local var_19_2 = arg_19_0._backParentTf

					var_19_1 = var_4.InverseTransformPoint(var_19_2, var_19_0)
				else
					local var_19_3 = arg_19_0._parentTf

					var_19_1 = var_4.InverseTransformPoint(var_19_3, var_19_0)
				end
			else
				local var_19_4 = arg_19_0._parentTf

				var_19_1 = var_4.InverseTransformPoint(var_19_4, var_19_0)
			end

			return var_19_1
		end,
		addItemDone = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_20_0:getParentInversePos(arg_20_1)

			if arg_20_1.data.act == var_0_16 or arg_20_1.data.catch == var_0_18 then
				var_20_0.y = var_0_46
			end

			arg_20_1.tf.anchoredPosition = var_20_0

			arg_20_0:addItemParent(arg_20_1)

			local var_20_1 = arg_20_1.tf

			Vector3 = var_5
			math = var_7
			var_20_1.localScale = var_5(2.5 * var_7.sign(arg_20_1.tf.localScale.x), 2.5, 2.5)

			local var_20_2 = arg_20_1.tf

			Vector3 = var_5
			var_20_2.localEulerAngles = var_5(0, 0, 0)
			arg_20_1.catchAble = false
			arg_20_1.targetRemove = true

			if arg_20_1.data.catch == var_0_17 then
				GetComponent = var_4

				local var_20_3 = arg_20_1.tf

				typeof = var_7
				DftAniEvent = var_9

				local var_20_4 = var_4(var_20_3, var_7(var_9))

				var_4.SetEndEvent(var_20_4, function()
					local var_21_0 = arg_20_0

					var_0.destroyItem(var_21_0, arg_20_1)

					return
				end)

				GetComponent = var_5

				local var_20_5 = arg_20_1.tf

				typeof = var_8
				Animator = var_2_10010

				local var_20_6 = var_5(var_20_5, var_8(var_2_10010))

				var_5.SetTrigger(var_20_6, "catch")
			elseif arg_20_1.data.catch == var_0_18 then
				local var_20_7

				if not arg_20_1.data.leave_direct then
					var_20_7 = 1
				end

				arg_20_1.direct = var_20_7
				math = var_5

				local var_20_8

				if var_20_7 * var_5.sign(arg_20_1.tf.localScale.x) ~= -1 or not arg_20_1.data.move_range[2] then
					var_20_8 = arg_20_1.data.move_range[1]
				end

				arg_20_1.targetX = var_20_8
				GetComponent = var_20_8

				local var_20_9 = arg_20_1.tf

				typeof = var_9
				DftAniEvent = var_2_10011

				local var_20_10 = var_20_8(var_20_9, var_9(var_2_10011))

				var_6.SetEndEvent(var_20_10, function()
					arg_20_1.moveAble = true

					return
				end)

				arg_20_1.moveAble = false
				GetComponent = var_7

				local var_20_11 = arg_20_1.tf

				typeof = var_10
				Animator = var_2_10012

				local var_20_12 = var_7(var_20_11, var_10(var_2_10012))

				var_7.SetTrigger(var_20_12, "release")

				table = var_7

				var_7.insert(arg_20_0.items, arg_20_1)
			end

			return
		end,
		start = function(arg_23_0)
			arg_23_0:clearItems()
			arg_23_0:prepareItems()
			arg_23_0:setItemPosition()

			return
		end,
		clearItems = function(arg_24_0)
			for iter_24_0 = #arg_24_0.items, 1, -1 do
				table = var_2_10005
				var_2_10005 = var_2_10005.remove(arg_24_0.items, iter_24_0)

				arg_24_0:destroyItem(var_2_10005)

				var_2_10005 = nil
			end

			arg_24_0.items = {}

			return
		end,
		prepareItems = function(arg_25_0)
			local var_25_0 = var_0_36

			math = var_2_10002

			local var_25_1 = var_25_0[var_2_10002.random(1, #var_0_36)]

			pairs = var_2

			for iter_25_0, iter_25_1 in var_2(var_25_1) do
				math = var_2_10007
				var_2_10007 = var_2_10007.random(iter_25_1.amount[1], iter_25_1.amount[2])

				local var_25_2 = iter_25_1.type
				local var_25_3 = iter_25_1.repeated
				local var_25_4 = iter_25_1.name
				local var_25_5 = arg_25_0:getItemsByType(var_25_2, var_25_4)

				for iter_25_2 = 1, var_2_10007 do
					local var_25_6

					if var_25_3 then
						math = var_2_10017
						var_25_6 = var_25_5[var_2_10017.random(1, #var_25_5)]
					else
						var_2_10017 = #var_25_5

						if 0 < var_2_10017 then
							table = var_2_10017
							var_2_10017 = var_2_10017.remove

							local var_25_7 = var_25_5

							math = var_2_10020
							var_25_6 = var_2_10017(var_25_7, var_2_10020.random(1, #var_25_5))
						end
					end

					if var_25_6 then
						var_2_10017 = arg_25_0:createItem(var_25_6)
						table = var_2_10018

						var_2_10018.insert(arg_25_0.items, var_2_10017)
					end
				end
			end

			return
		end,
		getItemsByType = function(arg_26_0, arg_26_1, arg_26_2)
			local var_26_0 = {}

			for iter_26_0 = 1, #var_0_37 do
				if var_0_37[iter_26_0].type == arg_26_1 then
					if arg_26_2 then
						table = var_8

						if var_8.contains(arg_26_2, var_0_37[iter_26_0].name) then
							table = var_8

							var_8.insert(var_26_0, var_0_37[iter_26_0])
						end
					else
						table = var_8

						var_8.insert(var_26_0, var_0_37[iter_26_0])
					end
				end
			end

			return var_26_0
		end,
		getItemDataByName = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #var_0_37 do
				if var_0_37[iter_27_0].name == arg_27_1 then
					return var_0_37[iter_27_0]
				end
			end

			return nil
		end,
		createItem = function(arg_28_0, arg_28_1)
			local var_28_0 = {
				data = arg_28_1
			}

			var_28_0.tf = nil
			var_28_0.targetX = nil
			var_28_0.targetY = nil

			local var_28_1

			if not arg_28_1.direct then
				var_28_1 = 1
			end

			var_28_0.direct = var_28_1
			var_28_0.moveAble = true
			var_28_0.catchAble = true
			var_28_0.targetRemove = false
			var_28_0.interaction = arg_28_1.interaction and true or false
			var_28_0.interactionName = nil
			var_28_0.interactionTime = nil
			var_28_0.animStateIndex = nil
			var_28_0.nextAnimTime = nil

			arg_28_0:instantiateItem(var_28_0)

			return var_28_0
		end,
		instantiateItem = function(arg_29_0, arg_29_1)
			local var_29_0

			if arg_29_1.data.scene == var_0_24 then
				findTF = var_3
				var_29_0 = var_3(arg_29_0._backSceneTpls, arg_29_1.data.name)
			else
				findTF = var_3
				var_29_0 = var_3(arg_29_0._sceneTpls, arg_29_1.data.name)
			end

			Instantiate = var_3

			local var_29_1 = var_3(var_29_0)

			tf = var_4
			arg_29_1.tf = var_4(var_29_1)
			setActive = var_4

			var_4(arg_29_1.tf, true)
			arg_29_0:addItemParent(arg_29_1)

			return
		end,
		addItemParent = function(arg_30_0, arg_30_1)
			if arg_30_1.data.scene then
				if arg_30_1.data.scene == var_0_24 then
					SetParent = var_2

					var_2(arg_30_1.tf, arg_30_0._backParentTf)
				else
					SetParent = var_2

					var_2(arg_30_1.tf, arg_30_0._parentTf)
				end
			else
				SetParent = var_2

				var_2(arg_30_1.tf, arg_30_0._parentTf)
			end

			return
		end,
		setItemPosition = function(arg_31_0)
			if not arg_31_0.items or #arg_31_0.items == 0 then
				return
			end

			local var_31_0 = arg_31_0:splitePositions(0, arg_31_0._createBounds[1])
			local var_31_1 = arg_31_0:splitePositions(0, arg_31_0._createBounds[2])
			local var_31_2 = arg_31_0:mixSplitePos(var_31_0, var_31_1)

			local function var_31_3(arg_32_0)
				if arg_32_0 then
					local var_32_0 = {}

					for iter_32_0 = 1, #var_31_2 do
						local var_32_1 = iter_32_0
						local var_32_2 = var_31_2[iter_32_0]
						local var_32_3 = arg_32_0[1]
						local var_32_4 = arg_32_0[2]
						local var_32_5 = arg_32_0[3]
						local var_32_6 = arg_32_0[4]
						local var_32_7 = var_32_2[1][1]
						local var_32_8 = var_32_2[1][2]
						local var_32_9 = var_32_2[2][1]
						local var_32_10 = var_32_2[2][2]

						if var_32_3 <= var_32_7 and var_32_8 <= var_32_4 and var_32_5 <= var_32_9 and var_32_10 <= var_32_6 then
							table = var_3_10016

							var_3_10016.insert(var_32_0, var_32_1)
						end
					end

					if #var_32_0 > 0 then
						table = var_2

						local var_32_11 = var_2.remove

						var_3_10004 = var_31_2
						math = iter_32_0

						return var_32_11(var_3_10004, var_32_0[iter_32_0.random(1, #var_32_0)])
					end
				end

				if #var_31_2 > 0 then
					table = var_1

					local var_32_12 = var_1.remove
					local var_32_13 = var_31_2

					math = var_3_10004

					return var_32_12(var_32_13, var_3_10004.random(1, #var_31_2))
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
			end

			for iter_31_0 = 1, #arg_31_0.items do
				if var_31_3(arg_31_0.items[iter_31_0].data.create_range) then
					local var_31_4 = var_9[1][1]

					math = var_11

					local var_31_5 = var_31_4 + var_11.random() * (var_9[1][2] - var_9[1][1]) / 2
					local var_31_6 = var_9[2][1]

					math = var_12

					local var_31_7 = var_31_6 + var_12.random() * (var_9[2][2] - var_9[2][1]) / 2
					local var_31_8 = arg_31_0.items[iter_31_0].tf

					Vector2 = var_13
					var_31_8.anchoredPosition = var_13(var_31_5, var_31_7)
				end
			end

			return
		end,
		mixSplitePos = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = {}

			for iter_33_0 = 1, #arg_33_1 do
				local var_33_1 = arg_33_1[iter_33_0]

				for iter_33_1 = 1, #arg_33_2 do
					local var_33_2 = arg_33_2[iter_33_1]

					table = var_2_10014

					var_2_10014.insert(var_33_0, {
						var_33_1,
						var_33_2
					})
				end
			end

			return var_33_0
		end,
		splitePositions = function(arg_34_0, arg_34_1, arg_34_2)
			local var_34_0 = {}

			if not arg_34_1 or not arg_34_2 or arg_34_2 < arg_34_1 then
				return nil
			end

			local var_34_1 = (arg_34_2 - arg_34_1) / var_0_47

			for iter_34_0 = 1, var_34_1 do
				table = var_2_10009

				var_2_10009.insert(var_34_0, {
					arg_34_1 + (iter_34_0 - 1) * var_0_47,
					arg_34_1 + iter_34_0 * var_0_47
				})
			end

			return var_34_0
		end,
		getItemByPos = function(arg_35_0, arg_35_1)
			if arg_35_0:checkPosInCollider(arg_35_1) then
				if var_2.data.catch_rule then
					GetComponent = var_3

					local var_35_0 = var_2.tf

					typeof = var_2_10006
					Animator = var_2_10008

					local var_35_1 = var_3(var_35_0, var_2_10006(var_2_10008))
					local var_35_2 = var_3.GetInteger(var_35_1, "state")
					local var_35_3 = var_2.data.catch_rule.state

					table = var_35_1

					if var_35_1.contains(var_35_3, var_35_2) then
						arg_35_0:addItemDone(var_2)

						return (arg_35_0:createItem(arg_35_0:getItemDataByName(var_2.data.catch_rule.targetName)))
					end
				else
					return var_2
				end

				return var_2
			end

			return nil
		end,
		checkPosInCollider = function(arg_36_0, arg_36_1)
			local var_36_0 = {}
			local var_36_1 = arg_36_0._parentTf
			local var_36_2 = var_3.InverseTransformPoint(var_36_1, arg_36_1.x, arg_36_1.y, arg_36_1.z)

			for iter_36_0 = 1, #arg_36_0.items do
				local var_36_3

				if arg_36_0.items[iter_36_0].data.catch ~= var_0_19 then
					var_36_3 = arg_36_0.items[iter_36_0].tf
					math = var_2_10009

					if var_2_10009.abs(var_36_2.x - var_36_3.anchoredPosition.x) < var_0_45 then
						math = var_2_10009

						if var_2_10009.abs(var_36_2.y - var_36_3.anchoredPosition.y) < var_0_45 and arg_36_0.items[iter_36_0].data.catch ~= var_0_19 and arg_36_0.items[iter_36_0].catchAble then
							table = var_2_10009

							var_2_10009.insert(var_36_0, arg_36_0.items[iter_36_0])
						end
					end
				end
			end

			for iter_36_1 = 1, #var_36_0 do
				findTF = var_36_3

				if not var_36_3(var_36_0[iter_36_1].tf, "collider") then
					print = var_2_10009

					var_2_10009("can not find collider by" .. var_36_0[iter_36_1].data.name)
				else
					var_2_10009 = var_36_3:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z)

					local var_36_4 = var_36_3.rect.xMin
					local var_36_5 = var_36_3.rect.yMin
					local var_36_6 = var_36_3.rect.width
					local var_36_7 = var_36_3.rect.height
					local var_36_8 = arg_36_0
					local var_36_9 = arg_36_0.isPointInMatrix

					Vector2 = var_2_10017
					var_2_10017 = var_2_10017(var_36_4, var_36_5 + var_36_7)
					Vector2 = var_2_10018
					var_2_10018 = var_2_10018(var_36_4 + var_36_6, var_36_5 + var_36_7)
					Vector2 = var_19

					local var_36_10 = var_19(var_36_4 + var_36_6, var_36_5)

					Vector2 = var_20

					if var_36_9(var_36_8, var_2_10017, var_2_10018, var_36_10, var_20(var_36_4, var_36_5), var_2_10009) then
						var_2_10017 = arg_36_0

						return arg_36_0.removeItem(var_2_10017, var_36_0[iter_36_1])
					end
				end
			end

			return nil
		end,
		removeItem = function(arg_37_0, arg_37_1)
			for iter_37_0 = 1, #arg_37_0.items do
				if arg_37_0.items[iter_37_0] == arg_37_1 then
					table = var_6

					return var_6.remove(arg_37_0.items, iter_37_0)
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
				if arg_40_0.items[iter_40_0].data.act == var_0_16 and var_5.moveAble then
					local var_40_0

					if not var_5.targetX then
						var_40_0 = var_5.data.move_range[1]

						local var_40_1 = var_5.data.move_range[2]

						if var_5.tf.anchoredPosition.x == var_40_0 then
							var_5.targetX = var_40_1
						elseif var_5.tf.anchoredPosition.x == var_40_1 then
							var_5.targetX = var_40_0
						else
							math = var_8

							local var_40_2 = var_8.random()

							var_5.targetX = 0.5 < var_40_2 and var_40_0 or var_40_1
						end

						goto label_40_0
					end

					math = var_40_0

					local var_40_3 = var_40_0.sign(var_5.targetX - var_5.tf.anchoredPosition.x)
					local var_40_4

					if not var_5.targetRemove or not var_5.data.release_speed then
						var_40_4 = var_5.data.speed
					end

					local var_40_5 = var_5.tf

					Vector3 = var_2_10009
					var_2_10011 = -1 * var_40_3 * var_5.direct
					math = var_12
					var_40_5.localScale = var_2_10009(var_2_10011 * var_12.abs(var_5.tf.localScale.x), var_5.tf.localScale.y, var_5.tf.localScale.z)

					local var_40_6 = var_40_3 * var_40_4

					Time = var_2_10009

					local var_40_7 = var_40_6 * var_2_10009.deltaTime

					var_2_10009 = var_5.tf
					Vector2 = var_2_10010
					var_2_10009.anchoredPosition = var_2_10010(var_5.tf.anchoredPosition.x + var_40_7, var_5.tf.anchoredPosition.y)

					if var_40_3 == 1 then
						var_2_10009 = var_5.tf.anchoredPosition.x

						if not (var_5.targetX <= var_2_10009) then
							if var_40_3 == -1 and var_5.tf.anchoredPosition.x <= var_5.targetX then
								var_2_10009 = var_5.tf
								Vector2 = var_2_10010
								var_2_10009.anchoredPosition = var_2_10010(var_5.targetX, var_5.tf.anchoredPosition.y)
								var_5.targetX = nil
							end

							::label_40_0::

							if var_5.data.anim_data then
								local var_40_8 = var_5.data.anim_data.state_change
								local var_40_9 = var_5.data.anim_data.time

								if var_40_8 and var_40_9 then
									if not var_5.nextAnimTime then
										math = var_8
										var_5.nextAnimTime = var_8.random(var_40_9[1], var_40_9[2])
										var_5.animStateIndex = 1
									elseif var_5.nextAnimTime <= 0 then
										GetComponent = var_8
										var_2_10010 = var_5.tf
										typeof = var_2_10011
										Animator = var_2_10013
										var_2_10010 = var_8(var_2_10010, var_2_10011(var_2_10013))

										var_8.SetInteger(var_2_10010, "state", var_40_8[var_5.animStateIndex])

										math = var_8
										var_5.nextAnimTime = var_8.random(var_40_9[1], var_40_9[2])
										var_5.animStateIndex = var_5.animStateIndex + 1

										local var_40_10 = var_5.animStateIndex

										var_5.animStateIndex = #var_40_8 < var_40_10 and 1 or var_5.animStateIndex
									else
										local var_40_11 = var_5.nextAnimTime

										Time = var_2_10009
										var_5.nextAnimTime = var_40_11 - var_2_10009.deltaTime
									end
								end
							end

							if var_5.interaction and not var_5.targetRemove then
								if not var_5.interactionTime then
									math = var_6
									var_5.interactionTime = var_6.random() * (var_5.data.interaction.time[2] - var_5.data.interaction.time[1]) + var_5.data.interaction.time[1]

									local var_40_12 = var_5.data.interaction.parame

									math = var_7
									var_5.interactionName = var_40_12[var_7.random(1, #var_5.data.interaction.parame)]
								elseif var_5.interactionTime <= 0 then
									GetComponent = var_6

									local var_40_13 = var_5.tf

									typeof = var_2_10009
									Animator = var_2_10011

									local var_40_14 = var_6(var_40_13, var_2_10009(var_2_10011))

									var_6.SetTrigger(var_40_14, var_5.interactionName)

									var_5.interactionTime = nil
									var_5.interactionName = nil
								else
									local var_40_15 = var_5.interactionTime

									Time = var_7
									var_5.interactionTime = var_40_15 - var_7.deltaTime
								end
							end

							if var_5.targetRemove and not var_5.targetX then
								table = var_6

								var_6.remove(arg_40_0.items, iter_40_0)
								arg_40_0:destroyItem(var_5)
							end
						end
					end
				end
			end

			return
		end,
		destroyItem = function(arg_41_0, arg_41_1)
			destroy = var_2_10002

			var_2_10002(arg_41_1.tf)

			return
		end,
		destroy = function(arg_42_0)
			return
		end
	}

	var_4.ctor(var_17_0)

	return var_4
end

local function var_0_59(arg_43_0, arg_43_1)
	local var_43_0 = {
		ctor = function(arg_44_0)
			arg_44_0._boatController = arg_43_0
			arg_44_0._itemController = arg_43_1

			return
		end,
		start = function(arg_45_0)
			return
		end,
		step = function(arg_46_0)
			local var_46_0 = arg_46_0._boatController

			if var_1.inCatch(var_46_0) then
				local var_46_1 = arg_46_0._boatController
				local var_46_2 = var_1.getHookPosition(var_46_1)
				local var_46_3 = arg_46_0._itemController

				if var_2.getItemByPos(var_46_3, var_46_2) then
					GetComponent = var_46_1

					local var_46_4 = var_2.tf

					typeof = var_2_10006
					Animator = var_2_10008

					local var_46_5 = var_46_1(var_46_4, var_2_10006(var_2_10008))

					var_3.SetTrigger(var_46_5, "hold")

					local var_46_6 = arg_46_0._boatController

					var_3.setCatchItem(var_46_6, var_2)
				end
			end

			return
		end,
		destroy = function(arg_47_0)
			return
		end
	}

	var_2.ctor(var_43_0)

	return var_2
end

local function var_0_60(arg_48_0, arg_48_1)
	local var_48_0 = {
		ctor = function(arg_49_0)
			findTF = var_2_10001
			arg_49_0._charTpls = var_2_10001(arg_48_0, "charTpls")
			findTF = var_1
			arg_49_0._content = var_1(arg_48_0, "charContainer/content")
			arg_49_0._event = arg_48_1

			return
		end,
		start = function(arg_50_0)
			arg_50_0:clear()

			arg_50_0.chars = {}
			math = var_1
			arg_50_0.nextTime = var_1.random(var_0_53[1], var_0_53[2])
			Clone = var_1
			arg_50_0.showChars = var_1(var_0_54)

			return
		end,
		step = function(arg_51_0)
			if arg_51_0.nextTime <= 0 then
				local var_51_0 = #arg_51_0.showChars

				if 0 < var_51_0 then
					table = var_51_0

					var_51_0.insert(arg_51_0.chars, arg_51_0:createChar())

					math = var_1
					arg_51_0.nextTime = var_1.random(var_0_53[1], var_0_53[2])

					goto label_51_0
				end
			end

			do
				local var_51_1 = arg_51_0.nextTime

				Time = var_2
				arg_51_0.nextTime = var_51_1 - var_2.deltaTime
			end

			::label_51_0::

			arg_51_0:setCharAction()

			for iter_51_0 = #arg_51_0.chars, 1, -1 do
				arg_51_0:stepChar(arg_51_0.chars[iter_51_0])

				if arg_51_0.chars[iter_51_0].removeFlag then
					local var_51_2 = arg_51_0
					local var_51_3 = arg_51_0.removeChar

					table = var_8

					var_51_3(var_51_2, var_8.remove(arg_51_0.chars, iter_51_0))
				end
			end

			return
		end,
		stepChar = function(arg_52_0, arg_52_1)
			local var_52_0 = false

			if arg_52_1.posX then
				local var_52_1 = arg_52_1.tf

				Vector2 = var_2_10004

				local var_52_2 = arg_52_1.posX
				local var_52_3

				if not arg_52_1.offsetX then
					var_52_3 = 0
				end

				var_52_1.anchoredPosition = var_2_10004(var_52_2 + var_52_3, 0)
				setActive = var_52_1

				var_52_1(arg_52_1.tf, true)

				arg_52_1.posX = nil
				arg_52_1.offsetX = nil
			end

			if arg_52_1.moveToX then
				local var_52_4 = arg_52_1.moveToX + arg_52_1.offsetX

				var_2_10004 = arg_52_1.tf.anchoredPosition
				math = var_2_10005

				local var_52_5 = var_2_10005.sign(var_52_4 - var_2_10004.x)
				local var_52_6 = arg_52_1.tf

				Vector3 = var_7
				var_52_6.anchoredPosition = var_7(var_2_10004.x + var_52_5 * arg_52_1.speed, 0)
				math = var_52_6

				local var_52_7 = var_52_6.sign(var_2_10004.x - var_52_4)

				math = var_7

				local var_52_8 = var_7.sign(arg_52_1.tf.anchoredPosition.x - var_52_4)

				if arg_52_1.tf.anchoredPosition.x == var_52_4 or var_52_7 ~= var_52_8 then
					arg_52_1.moveToX = nil
					arg_52_1.offsetX = nil
				else
					var_52_0 = true
				end
			end

			if arg_52_1.triggerName or arg_52_1.time then
				if arg_52_1.triggerName and arg_52_1.animator then
					local var_52_9 = arg_52_1.animator

					var_3.SetTrigger(var_52_9, arg_52_1.triggerName)

					arg_52_1.triggerName = nil
				end

				local var_52_10 = arg_52_1.time

				Time = var_2_10004
				arg_52_1.time = var_52_10 - var_2_10004.deltaTime

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
			math = var_2_10003

			return arg_53_1 + var_2_10003.random(0, arg_53_2 - arg_53_1)
		end,
		removeChar = function(arg_54_0, arg_54_1)
			if arg_54_1.bindChars then
				arg_54_1.bindChars = {}
			end

			destroy = var_2

			var_2(arg_54_1.tf)

			return
		end,
		setCharAction = function(arg_55_0)
			for iter_55_0 = 1, #arg_55_0.chars do
				if not arg_55_0.chars[iter_55_0].currentActionInfo and #var_5.actionInfos > 0 and not var_5.inAction then
					if var_5.sync and var_5.bindIds then
						local var_55_0 = #var_5.bindIds

						if 0 < var_55_0 then
							local var_55_1 = true

							ipairs = var_7

							for iter_55_1, iter_55_2 in var_7(var_5.bindChars) do
								if iter_55_2.inAction or not iter_55_2.sync then
									var_55_1 = false
								end
							end

							if var_55_1 then
								table = var_7
								var_5.currentActionInfo = var_7.remove(var_5.actionInfos, 1)
								ipairs = var_8

								for iter_55_3, iter_55_4 in var_8(var_5.bindChars) do
									iter_55_4.sync = false
								end
							end

							goto label_55_0
						end
					end

					if not var_5.sync then
						table = var_6
						var_5.currentActionInfo = var_6.remove(var_5.actionInfos, 1)
					end
				end

				::label_55_0::

				if var_5.currentActionInfo and not var_5.currentActionInfo.sync then
					arg_55_0:addCharAction(var_5)
				elseif var_5.currentActionInfo and var_5.currentActionInfo.sync and var_5.bindIds then
					arg_55_0:addCharAction(var_5)

					ipairs = var_6

					for iter_55_5, iter_55_6 in var_6(var_5.bindChars) do
						if iter_55_6 and iter_55_6.currentActionInfo and iter_55_6.currentActionInfo.sync then
							arg_55_0:addBindCharAction(var_5, iter_55_6)
						end
					end
				elseif not var_5.currentActionInfo and #var_5.actionInfos == 0 and not var_5.inAction then
					var_5.removeFlag = true
				end
			end

			return
		end,
		addBindCharAction = function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_2.currentActionInfo.type == var_0_50 then
				arg_56_2.moveToX = arg_56_1.moveToX

				local var_56_0

				if not arg_56_2.currentActionInfo.offsetX then
					var_56_0 = 0
				end

				arg_56_2.offsetX = var_56_0
			elseif arg_56_2.currentActionInfo.type == var_0_49 then
				-- block empty
			elseif arg_56_2.currentActionInfo.type == var_0_51 then
				-- block empty
			end

			arg_56_2.sync = arg_56_2.currentActionInfo.sync
			arg_56_2.currentActionInfo = nil
			arg_56_2.inAction = true

			return
		end,
		addCharAction = function(arg_57_0, arg_57_1)
			if arg_57_1.currentActionInfo.type == var_0_50 then
				local var_57_0

				if arg_57_1.currentActionInfo.moveToX then
					var_57_0 = arg_57_0:getRandomMoveX(arg_57_1.currentActionInfo.moveToX[1], arg_57_1.currentActionInfo.moveToX[2])
				end

				arg_57_1.moveToX = var_57_0 or 0

				local var_57_1

				if not arg_57_1.currentActionInfo.offsetX then
					var_57_1 = 0
				end

				arg_57_1.offsetX = var_57_1
			elseif var_2 == var_0_49 then
				local var_57_2

				if not arg_57_1.currentActionInfo.posX then
					var_57_2 = 0
				end

				arg_57_1.posX = var_57_2

				local var_57_3

				if not arg_57_1.currentActionInfo.offsetX then
					var_57_3 = 0
				end

				arg_57_1.offsetX = var_57_3
			elseif var_2 == var_0_51 then
				arg_57_1.triggerName = arg_57_1.currentActionInfo.trigger

				local var_57_4

				if not arg_57_1.currentActionInfo.time then
					var_57_4 = 0
				end

				arg_57_1.time = var_57_4
			end

			arg_57_1.sync = arg_57_1.currentActionInfo.sync
			arg_57_1.inAction = true
			arg_57_1.currentActionInfo = nil

			return
		end,
		createChar = function(arg_58_0, arg_58_1)
			local var_58_0 = {}

			Clone = var_2_10003

			local var_58_1

			if not var_2_10003(arg_58_1) then
				var_58_1 = arg_58_0:getRandomData()
			end

			if not var_58_1 then
				return
			end

			var_58_0.data = var_58_1
			var_58_0.id = var_58_1.id
			var_58_0.bindIds = var_58_1.bindIds
			var_58_0.bindChars = {}
			var_58_0.actionInfos = var_58_1.actions
			var_58_0.speed = var_58_1.speed

			local var_58_2 = arg_58_0

			var_58_0.tf = arg_58_0.getCharTf(var_58_2, var_58_1.tf)
			GetComponent = var_4
			findTF = var_58_2

			local var_58_3 = var_58_2(var_58_0.tf, "anim")

			typeof = var_7
			Animator = var_9
			var_58_0.animator = var_4(var_58_3, var_7(var_9))
			GetComponent = var_4
			findTF = var_58_3

			local var_58_4 = var_58_3(var_58_0.tf, "anim")

			typeof = var_7
			DftAniEvent = var_9
			var_58_0.dft = var_4(var_58_4, var_7(var_9))
			var_58_0.currentActionInfo = nil
			var_58_0.posX = nil
			var_58_0.moveToX = nil
			var_58_0.offsetX = nil
			var_58_0.triggerName = nil
			var_58_0.time = nil
			var_58_0.inAction = false
			var_58_0.removeFlag = false

			if var_58_0.bindIds then
				for iter_58_0 = 1, #var_58_0.bindIds do
					local var_58_5 = arg_58_0:createChar(arg_58_0:getCharDataById(var_58_0.bindIds[iter_58_0]))

					table = var_9

					var_9.insert(arg_58_0.chars, var_58_5)

					table = var_9

					var_9.insert(var_58_0.bindChars, var_58_5)
				end
			end

			return var_58_0
		end,
		getRandomData = function(arg_59_0)
			if arg_59_0.showChars and #arg_59_0.showChars > 0 then
				table = var_1

				local var_59_0 = var_1.remove
				local var_59_1 = arg_59_0.showChars

				math = var_2_10004

				local var_59_2 = var_59_0(var_59_1, var_2_10004.random(1, #arg_59_0.showChars))

				return arg_59_0:getCharDataById(var_59_2)
			end

			return nil
		end,
		getCharDataById = function(arg_60_0, arg_60_1)
			ipairs = var_2_10002

			for iter_60_0, iter_60_1 in var_2_10002(var_0_52) do
				if iter_60_1.id == arg_60_1 then
					Clone = var_7

					return var_7(iter_60_1)
				end
			end

			return
		end,
		getCharTf = function(arg_61_0, arg_61_1)
			tf = var_2_10002
			instantiate = var_2_10004
			findTF = var_2_10006

			local var_61_0 = var_2_10002(var_2_10004(var_2_10006(arg_61_0._charTpls, arg_61_1)))

			SetParent = var_2_10003

			var_2_10003(var_61_0, arg_61_0._content)

			SetActive = var_2_10003

			var_2_10003(var_61_0, false)

			return var_61_0
		end,
		clear = function(arg_62_0)
			if arg_62_0.chars then
				for iter_62_0 = #arg_62_0.chars, 1, -1 do
					local var_62_0 = arg_62_0
					local var_62_1 = arg_62_0.removeChar

					table = var_2_10008

					var_62_1(var_62_0, var_2_10008.remove(arg_62_0.chars, iter_62_0))
				end

				arg_62_0.chars = {}
			end

			return
		end
	}

	var_2.ctor(var_48_0)

	return var_2
end

function var_0_1.getUIName(arg_63_0)
	return "IslandCatchTreasureGameUI"
end

function var_0_1.getBGM(arg_64_0)
	return var_0_2
end

function var_0_1.didEnter(arg_65_0)
	arg_65_0:initEvent()
	arg_65_0:initData()
	arg_65_0:initUI()
	arg_65_0:initGameUI()
	arg_65_0:updateMenuUI()
	arg_65_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_66_0)
	arg_66_0:bind(var_0_11, function(arg_67_0, arg_67_1, arg_67_2)
		if arg_66_0.itemController then
			local var_67_0 = arg_66_0.itemController

			var_3.addItemDone(var_67_0, arg_67_1, arg_67_2)
		end

		local var_67_1 = arg_66_0

		var_3.addScore(var_67_1, arg_67_1.data.score, arg_67_1.data.time)

		return
	end)

	return
end

function var_0_1.initData(arg_68_0)
	Application = var_1_10001

	local var_68_0

	if not var_1_10001.targetFrameRate then
		var_68_0 = 60
	end

	if 60 < var_68_0 then
		var_68_0 = 60
	end

	Timer = var_2
	arg_68_0.timer = var_2.New(function()
		local var_69_0 = arg_68_0

		var_0.onTimer(var_69_0)

		return
	end, 1 / var_68_0, -1)

	return
end

function var_0_1.initUI(arg_70_0)
	findTF = var_1_10001
	arg_70_0.backSceneTf = var_1_10001(arg_70_0._tf, "scene_container/scene_background")
	findTF = var_1
	arg_70_0.sceneTf = var_1(arg_70_0._tf, "scene_container/scene")
	findTF = var_1
	arg_70_0.bgTf = var_1(arg_70_0._tf, "bg")
	findTF = var_1
	arg_70_0.clickMask = var_1(arg_70_0._tf, "clickMask")
	findTF = var_1
	arg_70_0.countUI = var_1(arg_70_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_70_0 = var_3(arg_70_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_70_0.countAnimator = var_1(var_70_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_70_0

	local var_70_1 = var_70_0(arg_70_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_70_0.countDft = var_1(var_70_1, var_4(var_6))

	local var_70_2 = arg_70_0.countDft

	var_1.SetTriggerEvent(var_70_2, function()
		return
	end)

	local var_70_3 = arg_70_0.countDft

	var_1.SetEndEvent(var_70_3, function()
		setActive = var_2_10000

		var_2_10000(arg_70_0.countUI, false)

		local var_72_0 = arg_70_0

		var_0.gameStart(var_72_0)

		return
	end)

	SetActive = var_1

	var_1(arg_70_0.countUI, false)

	findTF = var_1
	arg_70_0.leaveUI = var_1(arg_70_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_70_4 = arg_70_0

	findTF = var_4

	local var_70_5 = var_4(arg_70_0.leaveUI, "ad/btnOk")

	local function var_70_6()
		local var_73_0 = arg_70_0

		var_0.resumeGame(var_73_0)

		local var_73_1 = arg_70_0

		var_0.onGameOver(var_73_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_70_4, var_70_5, var_70_6, var_6)

	onButton = var_1

	local var_70_7 = arg_70_0

	findTF = var_70_5

	local var_70_8 = var_70_5(arg_70_0.leaveUI, "ad/btnCancel")

	local function var_70_9()
		local var_74_0 = arg_70_0

		var_0.resumeGame(var_74_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_70_7, var_70_8, var_70_9, var_6)

	SetActive = var_1

	var_1(arg_70_0.leaveUI, false)

	findTF = var_1
	arg_70_0.pauseUI = var_1(arg_70_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_70_10 = arg_70_0

	findTF = var_4

	local var_70_11 = var_4(arg_70_0.pauseUI, "ad/btnOk")

	local function var_70_12()
		setActive = var_2_10000

		var_2_10000(arg_70_0.pauseUI, false)

		local var_75_0 = arg_70_0

		var_0.resumeGame(var_75_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_70_10, var_70_11, var_70_12, var_6)

	SetActive = var_1

	var_1(arg_70_0.pauseUI, false)

	findTF = var_1
	arg_70_0.settlementUI = var_1(arg_70_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_70_13 = arg_70_0

	findTF = var_4

	local var_70_14 = var_4(arg_70_0.settlementUI, "ad/btnOver")

	local function var_70_15()
		setActive = var_2_10000

		var_2_10000(arg_70_0.settlementUI, false)

		local var_76_0 = arg_70_0

		var_0.openMenuUI(var_76_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_70_13, var_70_14, var_70_15, var_6)

	SetActive = var_1

	var_1(arg_70_0.settlementUI, false)

	findTF = var_1
	arg_70_0.menuUI = var_1(arg_70_0._tf, "pop/menuUI")
	ActivityConst = var_1

	local var_70_16 = var_1.ISLAND_GAME_ID

	pg = var_1_10002

	local var_70_17 = var_1_10002.activity_template[var_70_16].config_client.item_id

	Item = var_3
	arg_70_0.itemConfig = var_3.getConfigData(var_70_17)
	LoadImageSpriteAsync = var_3

	local var_70_18 = arg_70_0.itemConfig.icon

	findTF = var_6

	var_3(var_70_18, var_6(arg_70_0.menuUI, "item/img"), true)

	pg = var_3
	arg_70_0.hub_id = var_3.activity_template[var_70_16].config_id
	onButton = var_3

	local var_70_19 = arg_70_0

	findTF = var_6

	local var_70_20 = var_6(arg_70_0.menuUI, "item")

	local function var_70_21()
		local var_77_0 = {}

		IslandGameLimitMediator = var_2_10001
		var_77_0.mediator = var_2_10001
		IslandGameLimitLayer = var_2_10001
		var_77_0.viewComponent = var_2_10001

		local var_77_1 = {}

		IslandGameLimitLayer = var_2_10002
		var_77_1.type = var_2_10002.limit_type_catch
		var_77_0.data = var_77_1

		local var_77_2 = arg_70_0
		local var_77_3 = var_1.emit

		BaseMiniGameMediator = var_2_10004

		var_77_3(var_77_2, var_2_10004.OPEN_SUB_LAYER, var_77_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_70_19, var_70_20, var_70_21, var_8)

	onButton = var_3

	local var_70_22 = arg_70_0

	findTF = var_70_20

	local var_70_23 = var_70_20(arg_70_0.menuUI, "btnBack")

	local function var_70_24()
		local var_78_0 = arg_70_0

		var_0.closeView(var_78_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_70_22, var_70_23, var_70_24, var_8)

	onButton = var_3

	local var_70_25 = arg_70_0

	findTF = var_70_23

	local var_70_26 = var_70_23(arg_70_0.menuUI, "btnStart")

	local function var_70_27()
		setActive = var_2_10000

		var_2_10000(arg_70_0.menuUI, false)

		local var_79_0 = arg_70_0

		var_0.readyStart(var_79_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_70_25, var_70_26, var_70_27, var_8)

	onButton = var_3

	local var_70_28 = arg_70_0

	findTF = var_70_26

	local var_70_29 = var_70_26(arg_70_0.menuUI, "btnRule")

	local function var_70_30()
		pg = var_2_10000

		local var_80_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_80_1 = var_0.ShowMsgBox
		local var_80_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_80_2.type = var_2_10004
		pg = var_2_10004
		var_80_2.helps = var_2_10004.gametip[var_0_10].tip

		var_80_1(var_80_0, var_80_2)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_70_28, var_70_29, var_70_30, var_8)

	if not arg_70_0.handle then
		UpdateBeat = var_3
		arg_70_0.handle = var_3:CreateListener(arg_70_0.Update, arg_70_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_70_0.handle)

	return
end

function var_0_1.initGameUI(arg_81_0)
	findTF = var_1_10001
	arg_81_0.gameUI = var_1_10001(arg_81_0._tf, "ui/gameUI")
	onButton = var_1

	local var_81_0 = arg_81_0

	findTF = var_4

	var_1(var_81_0, var_4(arg_81_0.gameUI, "topRight/btnStop"), function()
		local var_82_0 = arg_81_0

		var_0.stopGame(var_82_0)

		setActive = var_0

		var_0(arg_81_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_81_1 = arg_81_0

	findTF = var_4

	var_1(var_81_1, var_4(arg_81_0.gameUI, "btnLeave"), function()
		local var_83_0 = arg_81_0

		var_0.stopGame(var_83_0)

		setActive = var_0

		var_0(arg_81_0.leaveUI, true)

		return
	end)

	GetOrAddComponent = var_1
	arg_81_0.dragDelegate = var_1(arg_81_0.sceneTf, "EventTriggerListener")
	arg_81_0.dragDelegate.enabled = true

	local var_81_2 = arg_81_0.dragDelegate

	var_1.AddPointDownFunc(var_81_2, function(arg_84_0, arg_84_1)
		if arg_81_0.boatController then
			local var_84_0 = arg_81_0.boatController

			var_2.throw(var_84_0)
		end

		return
	end)

	findTF = var_1
	arg_81_0.gameTimeS = var_1(arg_81_0.gameUI, "top/time/s")
	findTF = var_1
	arg_81_0.scoreTf = var_1(arg_81_0.gameUI, "top/score")
	arg_81_0.boatController = var_0_57(arg_81_0.sceneTf, arg_81_0)
	arg_81_0.itemController = var_0_58(arg_81_0.sceneTf, arg_81_0.backSceneTf, arg_81_0:getGameUsedTimes(), arg_81_0)
	arg_81_0.catchController = var_0_59(arg_81_0.boatController, arg_81_0.itemController)
	arg_81_0.charController = var_0_60(arg_81_0.backSceneTf, arg_81_0)
	findTF = var_1
	arg_81_0.sceneScoreTf = var_1(arg_81_0.sceneTf, "scoreTf")
	setActive = var_1

	var_1(arg_81_0.sceneScoreTf, false)

	return
end

function var_0_1.Update(arg_85_0)
	arg_85_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_86_0)
	if arg_86_0.gameStop or arg_86_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateMenuUI(arg_87_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_87_0 = var_1_10001(var_1_10003)
	local var_87_1

	if not var_1.GetHubByHubId(var_87_0, arg_87_0.hub_id).count then
		var_87_1 = 0
	end

	arg_87_0.itemNums = var_87_1
	setText = var_87_1
	findTF = var_87_0

	var_87_1(var_87_0(arg_87_0.menuUI, "item/num"), arg_87_0.itemNums)

	return
end

function var_0_1.openMenuUI(arg_88_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_88_0._tf, "scene_container"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_88_0.bgTf, "on"), true)

	setActive = var_1_10001

	var_1_10001(arg_88_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_88_0.menuUI, true)
	arg_88_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_89_0)
	setActive = var_1_10001

	var_1_10001(arg_89_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_89_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_89_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_89_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_89_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_90_0)
	setActive = var_1_10001

	var_1_10001(arg_90_0.countUI, true)

	local var_90_0 = arg_90_0.countAnimator

	var_1.Play(var_90_0, "count")

	pg = var_1

	local var_90_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_90_1, var_0_3)

	return
end

function var_0_1.getGameTimes(arg_91_0)
	return arg_91_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_92_0)
	return arg_92_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_93_0)
	return arg_93_0:GetMGHubData().ultimate
end

function var_0_1.gameStart(arg_94_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_94_0._tf, "scene_container"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_94_0.bgTf, "on"), false)

	setActive = var_1_10001

	var_1_10001(arg_94_0.gameUI, true)

	arg_94_0.gameStartFlag = true
	arg_94_0.scoreNum = 0
	arg_94_0.playerPosIndex = 2
	arg_94_0.gameStepTime = 0
	arg_94_0.heart = 3
	arg_94_0.gameTime = var_0_8
	SetActive = var_1

	var_1(arg_94_0.sceneScoreTf, false)

	if arg_94_0.boatController then
		local var_94_0 = arg_94_0.boatController

		var_1.start(var_94_0)
	end

	if arg_94_0.itemController then
		local var_94_1 = arg_94_0.itemController

		var_1.start(var_94_1)
	end

	if arg_94_0.catchController then
		local var_94_2 = arg_94_0.catchController

		var_1.start(var_94_2)
	end

	if arg_94_0.charController then
		local var_94_3 = arg_94_0.charController

		var_1.start(var_94_3)
	end

	arg_94_0:updateGameUI()
	arg_94_0:timerStart()

	return
end

function var_0_1.transformColor(arg_95_0, arg_95_1)
	tonumber = var_1_10002
	string = var_1_10004

	local var_95_0 = var_1_10002(var_1_10004.sub(arg_95_1, 1, 2), 16)

	tonumber = var_1_10003
	string = var_5

	local var_95_1 = var_1_10003(var_5.sub(arg_95_1, 3, 4), 16)

	tonumber = var_4
	string = var_6

	local var_95_2 = var_4(var_6.sub(arg_95_1, 5, 6), 16)

	Color = var_5

	return var_5.New(var_95_0 / 255, var_95_1 / 255, var_95_2 / 255)
end

function var_0_1.addScore(arg_96_0, arg_96_1, arg_96_2)
	if arg_96_1 and 0 < arg_96_1 or arg_96_2 and 0 < arg_96_2 then
		pg = var_1_10003

		local var_96_0 = var_1_10003.CriMgr.GetInstance()

		var_1_10003.PlaySoundEffect_V3(var_96_0, var_0_6)
	elseif arg_96_1 and arg_96_1 < 0 then
		pg = var_1_10003

		local var_96_1 = var_1_10003.CriMgr.GetInstance()

		var_1_10003.PlaySoundEffect_V3(var_96_1, var_0_7)
	end

	setActive = var_1_10003

	var_1_10003(arg_96_0.sceneScoreTf, false)

	findTF = var_1_10003

	local var_96_2 = var_1_10003(arg_96_0.sceneScoreTf, "img")

	GetComponent = var_1_10004

	local var_96_3 = var_96_2

	typeof = var_1_10007
	Text = var_1_10009

	local var_96_4 = var_1_10004(var_96_3, var_1_10007(var_1_10009))
	local var_96_5 = "6f1807"

	if arg_96_1 then
		var_96_3 = nil

		for iter_96_0 = 1, #var_0_48 do
			if arg_96_1 and arg_96_1 >= var_0_48[iter_96_0].score then
				var_96_5 = var_0_48[iter_96_0].color
				var_96_3 = var_0_48[iter_96_0].font

				break
			end
		end

		local var_96_6 = arg_96_0:transformColor(var_96_5)

		arg_96_0.scoreNum = arg_96_0.scoreNum + arg_96_1

		local var_96_7 = arg_96_1 >= 0 and "+" or ""

		setText = var_8

		var_8(var_96_2, var_96_7 .. arg_96_1)

		var_96_4.fontSize = var_96_3 or 40
		setTextColor = var_8

		var_8(var_96_2, var_96_6)
	elseif arg_96_2 then
		local var_96_8 = arg_96_0:transformColor("66f2fb")

		var_96_4.fontSize = 40
		setTextColor = var_96_3

		var_96_3(var_96_2, var_96_8)

		var_96_3 = arg_96_0.gameTime

		if 0 < var_96_3 then
			arg_96_0.gameTime = arg_96_0.gameTime + arg_96_2
		end

		var_96_3 = 0 < arg_96_2 and "+" or ""
		setText = var_7

		var_7(var_96_2, var_96_3 .. arg_96_2 .. "s")
	end

	setActive = var_96_3

	var_96_3(arg_96_0.sceneScoreTf, true)

	return
end

function var_0_1.onTimer(arg_97_0)
	arg_97_0:gameStep()

	return
end

function var_0_1.gameStep(arg_98_0)
	local var_98_0 = arg_98_0.gameTime

	Time = var_1_10002
	arg_98_0.gameTime = var_98_0 - var_1_10002.deltaTime

	local var_98_1 = arg_98_0.gameStepTime

	Time = var_2
	arg_98_0.gameStepTime = var_98_1 + var_2.deltaTime

	if arg_98_0.boatController then
		local var_98_2 = arg_98_0.boatController

		var_1.step(var_98_2)
	end

	if arg_98_0.itemController then
		local var_98_3 = arg_98_0.itemController

		var_1.step(var_98_3)
	end

	if arg_98_0.catchController then
		local var_98_4 = arg_98_0.catchController

		var_1.step(var_98_4)
	end

	if arg_98_0.charController then
		local var_98_5 = arg_98_0.charController

		var_1.step(var_98_5)
	end

	if arg_98_0.gameTime < 0 then
		arg_98_0.gameTime = 0
	end

	arg_98_0:updateGameUI()

	if arg_98_0.gameTime <= 0 then
		arg_98_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_99_0)
	if not arg_99_0.timer.running then
		local var_99_0 = arg_99_0.timer

		var_1.Start(var_99_0)
	end

	return
end

function var_0_1.timerStop(arg_100_0)
	if arg_100_0.timer.running then
		local var_100_0 = arg_100_0.timer

		var_1.Stop(var_100_0)
	end

	return
end

function var_0_1.updateGameUI(arg_101_0)
	setText = var_1_10001

	var_1_10001(arg_101_0.scoreTf, arg_101_0.scoreNum)

	setText = var_1_10001

	local var_101_0 = arg_101_0.gameTimeS

	math = var_4

	var_1_10001(var_101_0, var_4.ceil(arg_101_0.gameTime))

	return
end

function var_0_1.onGameOver(arg_102_0)
	if arg_102_0.settlementFlag then
		return
	end

	arg_102_0:timerStop()

	arg_102_0.settlementFlag = true
	setActive = var_1

	var_1(arg_102_0.clickMask, true)

	local var_102_0

	if arg_102_0.boatController then
		var_102_0 = arg_102_0.boatController

		var_1.gameOver(var_102_0)
	end

	LeanTween = var_1

	local var_102_1 = var_1.delayedCall

	go = var_102_0

	local var_102_2 = var_102_0(arg_102_0._tf)
	local var_102_3 = 2

	System = var_5

	var_102_1(var_102_2, var_102_3, var_5.Action(function()
		arg_102_0.settlementFlag = false

		local var_103_0 = arg_102_0

		var_103_0.gameStartFlag = false
		setActive = var_103_0

		var_103_0(arg_102_0.clickMask, false)

		local var_103_1 = arg_102_0

		var_0.showSettlement(var_103_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_104_0)
	setActive = var_1_10001

	var_1_10001(arg_104_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_104_0 = var_3(arg_104_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_104_1 = var_1_10001(var_104_0, var_4(var_6))

	var_1.Play(var_104_1, "settlement", -1, 0)

	local var_104_2 = arg_104_0:GetMGData()
	local var_104_3 = var_2.GetRuntimeData(var_104_2, "elements")
	local var_104_4 = arg_104_0.scoreNum

	if var_104_3 then
		local var_104_5 = #var_104_3
		local var_104_6

		if not (0 < var_104_5) or not var_104_3[1] then
			var_104_6 = 0
		end

		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_104_0.settlementUI, "ad/new"), var_104_6 < var_104_4)

		if var_104_6 <= var_104_4 then
			var_104_6 = var_104_4

			arg_104_0:StoreDataToServer({
				var_104_6
			})
		end

		findTF = var_5

		local var_104_7 = var_5(arg_104_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_104_8 = var_6(arg_104_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_104_7, var_104_6)

		setText = var_7

		var_7(var_104_8, var_104_4)

		if arg_104_0:getGameTimes() and arg_104_0:getGameTimes() > 0 then
			arg_104_0.sendSuccessFlag = true

			arg_104_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_105_0)
	arg_105_0.gameStop = false
	setActive = var_1

	var_1(arg_105_0.leaveUI, false)
	arg_105_0:timerStart()

	return
end

function var_0_1.stopGame(arg_106_0)
	arg_106_0.gameStop = true

	arg_106_0:timerStop()

	return
end

function var_0_1.onBackPressed(arg_107_0)
	if not arg_107_0.gameStartFlag then
		arg_107_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_107_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_107_0.pauseUI) then
			setActive = var_1

			var_1(arg_107_0.pauseUI, false)
		end

		arg_107_0:stopGame()

		setActive = var_1

		var_1(arg_107_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_108_0)
	if arg_108_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_108_0.handle)
	end

	if arg_108_0._tf then
		LeanTween = var_1

		local var_108_0 = var_1.isTweening

		go = var_1_10003

		if var_108_0(var_1_10003(arg_108_0._tf)) then
			LeanTween = var_1

			local var_108_1 = var_1.cancel

			go = var_3

			var_108_1(var_3(arg_108_0._tf))
		end
	end

	if arg_108_0.timer and arg_108_0.timer.running then
		local var_108_2 = arg_108_0.timer

		var_1.Stop(var_108_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_108_0.timer = nil

	return
end

return var_0_1
