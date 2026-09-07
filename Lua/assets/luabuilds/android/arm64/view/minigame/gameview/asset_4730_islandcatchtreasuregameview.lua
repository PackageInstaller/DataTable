local IslandCatchTreasureGameView = class("IslandCatchTreasureGameView", import("..BaseMiniGameView"))
local var_0_1 = "blueocean-image"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/taosheng"
local var_0_4 = "event:/ui/zhuahuo"
local var_0_5 = "event:/ui/deshou"
local var_0_6 = "event:/ui/shibai"
local var_0_7 = 60
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
local var_0_26 = {}
local var_0_27 = {}

var_0_27.type = "item act static"
var_0_27.range = {
	5,
	8
}
var_0_26[1] = var_0_27
var_0_26[2] = {
	type = "item act dynamic",
	range = {
		5,
		8
	}
}

local var_0_28 = {
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
local var_0_29 = {
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
		name = "watch",
		time = 20,
		speed = 0,
		catch_speed = 180,
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
local var_0_30 = 500
local var_0_31 = 300
local var_0_32 = 200
local var_0_33 = 200
local var_0_34 = 45
local var_0_35 = 2.5
local var_0_36 = 50
local var_0_37 = 100
local var_0_38 = 580
local var_0_39 = 130
local var_0_40 = {
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
local var_0_41 = "char apply position"
local var_0_42 = "char apply move"
local var_0_43 = "char apply act"
local var_0_44 = {}
local var_0_45 = {
	speed = 3,
	tf = "Shiratsuyu",
	id = 1,
	bindIds = {
		2
	}
}
local var_0_46 = {}
local var_0_47 = {
	posX = -1200
}

var_0_47.type = "char apply position"
var_0_46[1] = var_0_47
var_0_46[2] = {
	trigger = "moveA",
	type = "char apply act"
}
var_0_46[3] = {
	sync = true,
	direct = -1,
	offsetX = -50,
	type = "char apply move",
	moveToX = {
		300,
		400
	}
}
var_0_46[4] = {
	time = 2,
	trigger = "actA",
	type = "char apply act"
}
var_0_46[5] = {
	time = 2,
	trigger = "actB",
	type = "char apply act"
}
var_0_46[6] = {
	time = 0,
	trigger = "moveB",
	type = "char apply act"
}
var_0_46[7] = {
	direct = -1,
	type = "char apply move",
	moveToX = {
		2000,
		2000
	}
}
var_0_45.actions = var_0_46
var_0_44[1] = var_0_45
var_0_44[2] = {
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
var_0_44[3] = {
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
var_0_44[4] = {
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
var_0_44[5] = {
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
var_0_44[6] = {
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

local var_0_48 = {
	25,
	30
}
local var_0_49 = {
	1,
	3,
	4,
	5,
	6
}
local var_0_50 = {
	"actA",
	"actB"
}
local var_0_51 = {
	10,
	15
}

local function var_0_52(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._sceneTf = arg_1_0
			self._boatTf = findTF(arg_1_0, "boat")
			self._event = arg_1_1
			self._hookTf = findTF(self._boatTf, "body/hook")
			self._hookContent = findTF(self._hookTf, "container/content")
			self._hookCollider = findTF(self._hookTf, "container/collider")
			self._sceneContent = findTF(self._sceneTf, "container/content")
			self.hookAnimator = GetComponent(findTF(self._hookTf, "bottom"), typeof(Animator))
			self.hookMaskAnimator = GetComponent(findTF(self._hookTf, "mask/img"), typeof(Animator))
			self.captainAnimator = GetComponent(findTF(self._boatTf, "body/captain/img"), typeof(Animator))

			GetComponent(findTF(self._boatTf, "body/captain/img"), typeof(DftAniEvent)):SetEndEvent(function()
				if self.inGoodAct then
					self.inGoodAct = false
				end

				return
			end)

			self.marinerAnimator = GetComponent(findTF(self._boatTf, "body/mariner/img"), typeof(Animator))

			return
		end,
		start = function(self)
			self._hookTf.sizeDelta = Vector2(0, 1)
			self.boatState = var_0_11
			self.hookRotation = var_0_34
			self.hookRotationSpeed = 0
			self.hookTargetRotation = var_0_34
			self.throwHook = false
			self.inGoodAct = false

			if self.catchItem then
				destroy(self.catchItem.tf)

				self.catchItem = nil
			end

			self.marinerActTime = nil
			self.marinerActName = nil

			self:leaveItem()

			return
		end,
		step = function(self)
			if self.boatState == var_0_11 then
				self:checkChangeRotation()

				self.hookRotation = self.hookRotation + self:getSpringRotation()
				self._hookTf.localEulerAngles = Vector3(0, 0, self.hookRotation)
			elseif self.boatState == var_0_12 then
				if self.throwHook then
					self._hookTf.sizeDelta = Vector2(0, self._hookTf.sizeDelta.y + var_0_32 * Time.deltaTime)

					if self._hookTf.sizeDelta.y * math.cos(math.deg2Rad * math.abs(self.hookRotation)) > var_0_31 or self._hookTf.sizeDelta.y > var_0_30 then
						self.throwHook = false
					end
				else
					local var_5_0 = self:hookBack()

					if not self.catchItem and var_5_0 then
						self.boatState = var_0_11
					elseif self.catchItem then
						if (self.catchItem.data.catch == var_0_16 or self.catchItem.data.act == var_0_14) and self._sceneContent:InverseTransformPoint(self._hookContent.position).y > var_0_38 then
							self.boatState = var_0_13

							self:leaveItem()
						elseif var_5_0 then
							self.boatState = var_0_13

							self:leaveItem()
						end
					end
				end
			elseif self.boatState == var_0_13 then
				if not self:hookBack() then
					return
				end

				if self.inGoodAct then
					return
				end

				self.boatState = var_0_11
			end

			if self.boatState == var_0_12 and self.throwHook then
				self.hookAnimator:SetBool("hook", true)
				self.hookMaskAnimator:SetBool("hook", true)
			else
				self.hookAnimator:SetBool("hook", false)
				self.hookMaskAnimator:SetBool("hook", false)
			end

			if self.boatState == var_0_12 then
				if self.throwHook then
					self.captainAnimator:SetInteger("state", 4)
				else
					self.captainAnimator:SetInteger("state", (self.catchItem or nil) and (self.catchItem.data.catch_speed >= 100 and 1 or self.catchItem.data.catch_speed >= 50 and self.catchItem.data.catch_speed <= 100 and 2 or 3))
				end
			else
				self.captainAnimator:SetInteger("state", 0)
			end

			if not self.marinerActTime then
				self.marinerActTime = math.random(var_0_51[1], var_0_51[2])
				self.marinerActName = var_0_50[math.random(1, #var_0_50)]
			elseif self.marinerActTime <= 0 then
				self.marinerAnimator:SetTrigger(self.marinerActName)

				self.marinerActTime = math.random(var_0_51[1], var_0_51[2])
				self.marinerActName = var_0_50[math.random(1, #var_0_50)]
			else
				self.marinerActTime = self.marinerActTime - Time.deltaTime
			end

			return
		end,
		hookBack = function(self)
			if self._hookTf.sizeDelta.y > 1 then
				self._hookTf.sizeDelta = Vector2(0, self._hookTf.sizeDelta.y - ((self.catchItem or nil) and self.catchItem.data.catch_speed * Time.deltaTime))

				return false
			elseif self._hookTf.sizeDelta.y < 1 then
				self._hookTf.sizeDelta = Vector2(0, 1)

				return false
			end

			return true
		end,
		leaveItem = function(self)
			if self.catchItem then
				self._event:emit(var_0_10, self.catchItem, function()
					return
				end)

				self.inGoodAct = true

				if self.catchItem.data.good == var_0_18 then
					self.captainAnimator:SetTrigger("happy")
					self.marinerAnimator:SetTrigger("happy")
				elseif self.catchItem.data.good == var_0_20 then
					self.captainAnimator:SetTrigger("release")
				elseif self.catchItem.data.good == var_0_19 then
					self.captainAnimator:SetTrigger("surprise")
					self.marinerAnimator:SetTrigger("surprise")
				elseif self.catchItem.data.good == var_0_21 then
					self.inGoodAct = false
				end

				self.catchItem = nil
			end

			return
		end,
		throw = function(self)
			if self.boatState ~= var_0_11 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			self.throwHook = true
			self.boatState = var_0_12

			return
		end,
		setCatchItem = function(self, arg_10_1)
			if self.boatState == var_0_12 and self.throwHook then
				self.catchItem = arg_10_1
				self.throwHook = false
				arg_10_1.tf.localScale = Vector3(math.sign(arg_10_1.tf.localScale.x), 1, 1)

				SetParent(arg_10_1.tf, self._hookContent)

				arg_10_1.tf.anchoredPosition = Vector2(0, 0)

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		getSpringRotation = function(self)
			self.hookRotationSpeed = self.hookRotationSpeed + math.sign(self.hookTargetRotation) * var_0_35

			if math.abs(self.hookRotationSpeed) > var_0_36 then
				self.hookRotationSpeed = var_0_36 * math.sign(self.hookTargetRotation)
			end

			return self.hookRotationSpeed * Time.deltaTime
		end,
		checkChangeRotation = function(self)
			if self.hookTargetRotation > 0 and self.hookRotation > self.hookTargetRotation then
				self.hookTargetRotation = -self.hookTargetRotation
			elseif self.hookTargetRotation < 0 and self.hookRotation < self.hookTargetRotation then
				self.hookTargetRotation = -self.hookTargetRotation
			end

			return
		end,
		inCatch = function(self)
			return self.boatState == var_0_12 and self.throwHook
		end,
		getHookPosition = function(self)
			return self._hookCollider.position
		end,
		gameOver = function(self)
			self.captainAnimator:SetTrigger("end")
			self.marinerAnimator:SetTrigger("end")

			return
		end,
		destroy = function(arg_16_0)
			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local function var_0_53(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {
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
		getParentInversePos = function(self, arg_19_1)
			return arg_19_1.data.scene and (arg_19_1.data.scene == var_0_22 and self._backParentTf:InverseTransformPoint(arg_19_1.tf.position) or self._parentTf:InverseTransformPoint(arg_19_1.tf.position)) or self._parentTf:InverseTransformPoint(arg_19_1.tf.position)
		end,
		addItemDone = function(self, arg_20_1, arg_20_2)
			local var_20_0 = self:getParentInversePos(arg_20_1)

			if arg_20_1.data.act == var_0_14 or arg_20_1.data.catch == var_0_16 then
				var_20_0.y = var_0_38
			end

			arg_20_1.tf.anchoredPosition = var_20_0

			self:addItemParent(arg_20_1)

			arg_20_1.tf.localScale = Vector3(2.5 * math.sign(arg_20_1.tf.localScale.x), 2.5, 2.5)
			arg_20_1.tf.localEulerAngles = Vector3(0, 0, 0)
			arg_20_1.catchAble = false
			arg_20_1.targetRemove = true

			if arg_20_1.data.catch == var_0_15 then
				GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
					self:destroyItem(arg_20_1)

					return
				end)
				GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("catch")
			elseif arg_20_1.data.catch == var_0_16 then
				local var_20_1 = arg_20_1.data.leave_direct or 1

				arg_20_1.direct = var_20_1

				if var_20_1 * math.sign(arg_20_1.tf.localScale.x) == -1 then
					arg_20_1.targetX = arg_20_1.data.move_range[2] or arg_20_1.data.move_range[1]
				end

				GetComponent(arg_20_1.tf, typeof(DftAniEvent)):SetEndEvent(function()
					arg_20_1.moveAble = true

					return
				end)

				arg_20_1.moveAble = false

				GetComponent(arg_20_1.tf, typeof(Animator)):SetTrigger("release")
				table.insert(self.items, arg_20_1)
			end

			return
		end,
		start = function(self)
			self:clearItems()
			self:prepareItems()
			self:setItemPosition()

			return
		end,
		clearItems = function(self)
			for iter_24_0 = #self.items, 1, -1 do
				self:destroyItem((table.remove(self.items, iter_24_0)))
			end

			self.items = {}

			return
		end,
		prepareItems = function(self)
			for iter_25_0, iter_25_1 in pairs(var_0_28[math.random(1, #var_0_28)]) do
				local var_25_0 = self:getItemsByType(iter_25_1.type, iter_25_1.name)

				for iter_25_2 = 1, math.random(iter_25_1.amount[1], iter_25_1.amount[2]) do
					local var_25_1

					if iter_25_1.repeated then
						var_25_1 = var_25_0[math.random(1, #var_25_0)]
					elseif #var_25_0 > 0 then
						var_25_1 = table.remove(var_25_0, math.random(1, #var_25_0))
					end

					if var_25_1 then
						table.insert(self.items, (self:createItem(var_25_1)))
					end
				end
			end

			return
		end,
		getItemsByType = function(arg_26_0, arg_26_1, arg_26_2)
			local var_26_0 = {}

			for iter_26_0 = 1, #var_0_29 do
				if var_0_29[iter_26_0].type == arg_26_1 then
					if arg_26_2 then
						if table.contains(arg_26_2, var_0_29[iter_26_0].name) then
							table.insert(var_26_0, var_0_29[iter_26_0])
						end
					else
						table.insert(var_26_0, var_0_29[iter_26_0])
					end
				end
			end

			return var_26_0
		end,
		getItemDataByName = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #var_0_29 do
				if var_0_29[iter_27_0].name == arg_27_1 then
					return var_0_29[iter_27_0]
				end
			end

			return nil
		end,
		createItem = function(self, arg_28_1)
			local var_28_0 = {
				data = arg_28_1
			}

			var_28_0.tf = nil
			var_28_0.targetX = nil
			var_28_0.targetY = nil
			var_28_0.direct = arg_28_1.direct or 1
			var_28_0.moveAble = true
			var_28_0.catchAble = true
			var_28_0.targetRemove = false
			var_28_0.interaction = not not arg_28_1.interaction
			var_28_0.interactionName = nil
			var_28_0.interactionTime = nil
			var_28_0.animStateIndex = nil
			var_28_0.nextAnimTime = nil

			self:instantiateItem(var_28_0)

			return var_28_0
		end,
		instantiateItem = function(self, arg_29_1)
			arg_29_1.tf = tf((Instantiate(arg_29_1.data.scene == var_0_22 and findTF(self._backSceneTpls, arg_29_1.data.name) or findTF(self._sceneTpls, arg_29_1.data.name))))

			setActive(arg_29_1.tf, true)
			self:addItemParent(arg_29_1)

			return
		end,
		addItemParent = function(self, arg_30_1)
			if arg_30_1.data.scene then
				if arg_30_1.data.scene == var_0_22 then
					SetParent(arg_30_1.tf, self._backParentTf)
				else
					SetParent(arg_30_1.tf, self._parentTf)
				end
			else
				SetParent(arg_30_1.tf, self._parentTf)
			end

			return
		end,
		setItemPosition = function(self)
			if not self.items or #self.items == 0 then
				return
			end

			local var_31_0 = self:mixSplitePos(self:splitePositions(0, self._createBounds[1]), (self:splitePositions(0, self._createBounds[2])))

			local function var_31_1(arg_32_0)
				if arg_32_0 then
					local var_32_0 = {}

					for iter_32_0 = 1, #var_31_0 do
						if arg_32_0[1] <= var_31_0[iter_32_0][1][1] and var_31_0[iter_32_0][1][2] <= arg_32_0[2] and arg_32_0[3] <= var_31_0[iter_32_0][2][1] and var_31_0[iter_32_0][2][2] <= arg_32_0[4] then
							table.insert(var_32_0, iter_32_0)
						end
					end

					if #var_32_0 > 0 then
						return table.remove(var_31_0, var_32_0[math.random(1, #var_32_0)])
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
			end

			for iter_31_0 = 1, #self.items do
				local var_31_2 = var_31_1(self.items[iter_31_0].data.create_range)

				if var_31_2 then
					self.items[iter_31_0].tf.anchoredPosition = Vector2(var_31_2[1][1] + math.random() * (var_31_2[1][2] - var_31_2[1][1]) / 2, var_31_2[2][1] + math.random() * (var_31_2[2][2] - var_31_2[2][1]) / 2)
				end
			end

			return
		end,
		mixSplitePos = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = {}

			for iter_33_0 = 1, #arg_33_1 do
				for iter_33_1 = 1, #arg_33_2 do
					table.insert(var_33_0, {
						arg_33_1[iter_33_0],
						arg_33_2[iter_33_1]
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

			for iter_34_0 = 1, (arg_34_2 - arg_34_1) / var_0_39 do
				table.insert(var_34_0, {
					arg_34_1 + (iter_34_0 - 1) * var_0_39,
					arg_34_1 + iter_34_0 * var_0_39
				})
			end

			return var_34_0
		end,
		getItemByPos = function(self, arg_35_1)
			local var_35_0 = self:checkPosInCollider(arg_35_1)

			if var_35_0 then
				if var_35_0.data.catch_rule then
					if table.contains(var_35_0.data.catch_rule.state, (GetComponent(var_35_0.tf, typeof(Animator)):GetInteger("state"))) then
						self:addItemDone(var_35_0)

						return (self:createItem(self:getItemDataByName(var_35_0.data.catch_rule.targetName)))
					end
				else
					return var_35_0
				end

				return var_35_0
			end

			return nil
		end,
		checkPosInCollider = function(self, arg_36_1)
			local var_36_0 = {}
			local var_36_1 = self._parentTf:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z)

			for iter_36_0 = 1, #self.items do
				if self.items[iter_36_0].data.catch ~= var_0_17 then
					if math.abs(var_36_1.x - self.items[iter_36_0].tf.anchoredPosition.x) < var_0_37 and math.abs(var_36_1.y - self.items[iter_36_0].tf.anchoredPosition.y) < var_0_37 and self.items[iter_36_0].data.catch ~= var_0_17 and self.items[iter_36_0].catchAble then
						table.insert(var_36_0, self.items[iter_36_0])
					end
				end
			end

			for iter_36_1 = 1, #var_36_0 do
				local var_36_2 = findTF(var_36_0[iter_36_1].tf, "collider")

				if not var_36_2 then
					print("can not find collider by" .. var_36_0[iter_36_1].data.name)
				else
					local var_36_3 = Vector2(var_36_2.rect.xMin, var_36_2.rect.yMin + var_36_2.rect.height)

					if self:isPointInMatrix(var_36_3, Vector2(var_36_2.rect.xMin + var_36_2.rect.width, var_36_2.rect.yMin + var_36_2.rect.height), Vector2(var_36_2.rect.xMin + var_36_2.rect.width, var_36_2.rect.yMin), Vector2(var_36_2.rect.xMin, var_36_2.rect.yMin), (var_36_2:InverseTransformPoint(arg_36_1.x, arg_36_1.y, arg_36_1.z))) then
						return self:removeItem(var_36_0[iter_36_1])
					end
				end
			end

			return nil
		end,
		removeItem = function(self, arg_37_1)
			for iter_37_0 = 1, #self.items do
				if self.items[iter_37_0] == arg_37_1 then
					return table.remove(self.items, iter_37_0)
				end
			end

			return
		end,
		getCross = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
			return (arg_38_2.x - arg_38_1.x) * (arg_38_3.y - arg_38_1.y) - (arg_38_3.x - arg_38_1.x) * (arg_38_2.y - arg_38_1.y)
		end,
		isPointInMatrix = function(self, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
			return self:getCross(arg_39_1, arg_39_2, arg_39_5) * self:getCross(arg_39_3, arg_39_4, arg_39_5) >= 0 and self:getCross(arg_39_2, arg_39_3, arg_39_5) * self:getCross(arg_39_4, arg_39_1, arg_39_5) >= 0
		end,
		step = function(self)
			for iter_40_0 = #self.items, 1, -1 do
				local var_40_0 = self.items[iter_40_0]

				if self.items[iter_40_0].data.act == var_0_14 and var_40_0.moveAble then
					if not var_40_0.targetX then
						local var_40_1 = var_40_0.data.move_range[1]
						local var_40_2 = var_40_0.data.move_range[2]

						var_40_0.targetX = var_40_0.tf.anchoredPosition.x == var_40_0.data.move_range[1] and var_40_2 or var_40_0.tf.anchoredPosition.x == var_40_2 and var_40_1 or math.random() > 0.5 and var_40_1 or var_40_2
					else
						local var_40_3 = math.sign(var_40_0.targetX - var_40_0.tf.anchoredPosition.x)
						local var_40_4

						if var_40_0.targetRemove then
							var_40_4 = var_40_0.data.release_speed or var_40_0.data.speed
						end

						var_40_0.tf.localScale = Vector3(-1 * var_40_3 * var_40_0.direct * math.abs(var_40_0.tf.localScale.x), var_40_0.tf.localScale.y, var_40_0.tf.localScale.z)
						var_40_0.tf.anchoredPosition = Vector2(var_40_0.tf.anchoredPosition.x + var_40_3 * var_40_4 * Time.deltaTime, var_40_0.tf.anchoredPosition.y)

						if var_40_3 == 1 and var_40_0.tf.anchoredPosition.x >= var_40_0.targetX or var_40_3 == -1 and var_40_0.tf.anchoredPosition.x <= var_40_0.targetX then
							var_40_0.tf.anchoredPosition = Vector2(var_40_0.targetX, var_40_0.tf.anchoredPosition.y)
							var_40_0.targetX = nil
						end
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
					table.remove(self.items, iter_40_0)
					self:destroyItem(var_40_0)
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

	var_17_0:ctor()

	return var_17_0
end

local function var_0_54(arg_43_0, arg_43_1)
	local var_43_0 = {
		ctor = function(arg_44_0)
			arg_44_0._boatController = arg_43_0
			arg_44_0._itemController = arg_43_1

			return
		end,
		start = function(arg_45_0)
			return
		end,
		step = function(self)
			if self._boatController:inCatch() then
				local var_46_0 = self._itemController:getItemByPos((self._boatController:getHookPosition()))

				if var_46_0 then
					GetComponent(var_46_0.tf, typeof(Animator)):SetTrigger("hold")
					self._boatController:setCatchItem(var_46_0)
				end
			end

			return
		end,
		destroy = function(arg_47_0)
			return
		end
	}

	var_43_0:ctor()

	return var_43_0
end

local function var_0_55(arg_48_0, arg_48_1)
	local var_48_0 = {
		ctor = function(arg_49_0)
			arg_49_0._charTpls = findTF(arg_48_0, "charTpls")
			arg_49_0._content = findTF(arg_48_0, "charContainer/content")
			arg_49_0._event = arg_48_1

			return
		end,
		start = function(self)
			self:clear()

			self.chars = {}
			self.nextTime = math.random(var_0_48[1], var_0_48[2])
			self.showChars = Clone(var_0_49)

			return
		end,
		step = function(self)
			if self.nextTime <= 0 and #self.showChars > 0 then
				table.insert(self.chars, self:createChar())

				self.nextTime = math.random(var_0_48[1], var_0_48[2])
			else
				self.nextTime = self.nextTime - Time.deltaTime
			end

			self:setCharAction()

			for iter_51_0 = #self.chars, 1, -1 do
				self:stepChar(self.chars[iter_51_0])

				if self.chars[iter_51_0].removeFlag then
					self:removeChar(table.remove(self.chars, iter_51_0))
				end
			end

			return
		end,
		stepChar = function(arg_52_0, arg_52_1)
			local var_52_0 = false

			if arg_52_1.posX then
				arg_52_1.tf.anchoredPosition = Vector2(arg_52_1.posX + (arg_52_1.offsetX or 0), 0)

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
		setCharAction = function(self)
			for iter_55_0 = 1, #self.chars do
				if not self.chars[iter_55_0].currentActionInfo and #self.chars[iter_55_0].actionInfos > 0 and not self.chars[iter_55_0].inAction then
					if self.chars[iter_55_0].sync and self.chars[iter_55_0].bindIds and #self.chars[iter_55_0].bindIds > 0 then
						local var_55_0 = true

						for iter_55_1, iter_55_2 in ipairs(self.chars[iter_55_0].bindChars) do
							var_55_0 = not iter_55_2.inAction and iter_55_2.sync or false
						end

						if var_55_0 then
							self.chars[iter_55_0].currentActionInfo = table.remove(self.chars[iter_55_0].actionInfos, 1)

							for iter_55_3, iter_55_4 in ipairs(self.chars[iter_55_0].bindChars) do
								iter_55_4.sync = false
							end
						end
					elseif not self.chars[iter_55_0].sync then
						self.chars[iter_55_0].currentActionInfo = table.remove(self.chars[iter_55_0].actionInfos, 1)
					end
				end

				if self.chars[iter_55_0].currentActionInfo and not self.chars[iter_55_0].currentActionInfo.sync then
					self:addCharAction(self.chars[iter_55_0])
				elseif self.chars[iter_55_0].currentActionInfo and self.chars[iter_55_0].currentActionInfo.sync and self.chars[iter_55_0].bindIds then
					self:addCharAction(self.chars[iter_55_0])

					for iter_55_5, iter_55_6 in ipairs(self.chars[iter_55_0].bindChars) do
						if iter_55_6 and iter_55_6.currentActionInfo and iter_55_6.currentActionInfo.sync then
							self:addBindCharAction(self.chars[iter_55_0], iter_55_6)
						end
					end
				elseif not self.chars[iter_55_0].currentActionInfo and #self.chars[iter_55_0].actionInfos == 0 and not self.chars[iter_55_0].inAction then
					self.chars[iter_55_0].removeFlag = true
				end
			end

			return
		end,
		addBindCharAction = function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_2.currentActionInfo.type == var_0_42 then
				arg_56_2.moveToX = arg_56_1.moveToX
				arg_56_2.offsetX = arg_56_2.currentActionInfo.offsetX or 0
			elseif arg_56_2.currentActionInfo.type == var_0_41 then
				-- block empty
			elseif arg_56_2.currentActionInfo.type == var_0_43 then
				-- block empty
			end

			arg_56_2.sync = arg_56_2.currentActionInfo.sync
			arg_56_2.currentActionInfo = nil
			arg_56_2.inAction = true

			return
		end,
		addCharAction = function(self, arg_57_1)
			if arg_57_1.currentActionInfo.type == var_0_42 then
				arg_57_1.moveToX = (arg_57_1.currentActionInfo.moveToX or nil) and self:getRandomMoveX(arg_57_1.currentActionInfo.moveToX[1], arg_57_1.currentActionInfo.moveToX[2]) or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_41 then
				arg_57_1.posX = arg_57_1.currentActionInfo.posX or 0
				arg_57_1.offsetX = arg_57_1.currentActionInfo.offsetX or 0
			elseif arg_57_1.currentActionInfo.type == var_0_43 then
				arg_57_1.triggerName = arg_57_1.currentActionInfo.trigger
				arg_57_1.time = arg_57_1.currentActionInfo.time or 0
			end

			arg_57_1.sync = arg_57_1.currentActionInfo.sync
			arg_57_1.inAction = true
			arg_57_1.currentActionInfo = nil

			return
		end,
		createChar = function(self, arg_58_1)
			local var_58_0 = {}
			local var_58_1 = Clone(arg_58_1) or self:getRandomData()

			if not var_58_1 then
				return
			end

			var_58_0.data = var_58_1
			var_58_0.id = var_58_1.id
			var_58_0.bindIds = var_58_1.bindIds
			var_58_0.bindChars = {}
			var_58_0.actionInfos = var_58_1.actions
			var_58_0.speed = var_58_1.speed
			var_58_0.tf = self:getCharTf(var_58_1.tf)
			var_58_0.animator = GetComponent(findTF(var_58_0.tf, "anim"), typeof(Animator))
			var_58_0.dft = GetComponent(findTF(var_58_0.tf, "anim"), typeof(DftAniEvent))
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
					local var_58_2 = self:createChar(self:getCharDataById(var_58_0.bindIds[iter_58_0]))

					table.insert(self.chars, var_58_2)
					table.insert(var_58_0.bindChars, var_58_2)
				end
			end

			return var_58_0
		end,
		getRandomData = function(self)
			if self.showChars and #self.showChars > 0 then
				return self:getCharDataById((table.remove(self.showChars, math.random(1, #self.showChars))))
			end

			return nil
		end,
		getCharDataById = function(arg_60_0, arg_60_1)
			for iter_60_0, iter_60_1 in ipairs(var_0_44) do
				if iter_60_1.id == arg_60_1 then
					return Clone(iter_60_1)
				end
			end

			return
		end,
		getCharTf = function(self, arg_61_1)
			local var_61_0 = tf(instantiate(findTF(self._charTpls, arg_61_1)))

			SetParent(var_61_0, self._content)
			SetActive(var_61_0, false)

			return var_61_0
		end,
		clear = function(self)
			if self.chars then
				for iter_62_0 = #self.chars, 1, -1 do
					self:removeChar(table.remove(self.chars, iter_62_0))
				end

				self.chars = {}
			end

			return
		end
	}

	var_48_0:ctor()

	return var_48_0
end

function IslandCatchTreasureGameView:getUIName()
	return "IslandCatchTreasureGameUI"
end

function IslandCatchTreasureGameView:getBGM()
	return var_0_1
end

function IslandCatchTreasureGameView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function IslandCatchTreasureGameView:initEvent()
	self:bind(var_0_10, function(arg_67_0, arg_67_1, arg_67_2)
		if self.itemController then
			self.itemController:addItemDone(arg_67_1, arg_67_2)
		end

		self:addScore(arg_67_1.data.score, arg_67_1.data.time)

		return
	end)

	return
end

function IslandCatchTreasureGameView:initData()
	local var_68_0 = Application.targetFrameRate or 60

	if var_68_0 > 60 then
		var_68_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_68_0, -1)

	return
end

function IslandCatchTreasureGameView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_container/scene_background")
	self.sceneTf = findTF(self._tf, "scene_container/scene")
	self.bgTf = findTF(self._tf, "bg")
	self.clickMask = findTF(self._tf, "clickMask")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)
	SetActive(self.countUI, false)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.leaveUI, false)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.pauseUI, false)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)
	SetActive(self.settlementUI, false)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.itemConfig = Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id)

	LoadImageSpriteAsync(self.itemConfig.icon, findTF(self.menuUI, "item/img"), true)

	self.hub_id = pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_id

	onButton(self, findTF(self.menuUI, "item"), function()
		self:emit(BaseMiniGameMediator.OPEN_SUB_LAYER, {
			mediator = IslandGameLimitMediator,
			viewComponent = IslandGameLimitLayer,
			data = {
				type = IslandGameLimitLayer.limit_type_catch
			}
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_9].tip
		})

		return
	end, SFX_CANCEL)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function IslandCatchTreasureGameView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")

	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.dragDelegate = GetOrAddComponent(self.sceneTf, "EventTriggerListener")
	self.dragDelegate.enabled = true

	self.dragDelegate:AddPointDownFunc(function(arg_84_0, arg_84_1)
		if self.boatController then
			self.boatController:throw()
		end

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.boatController = var_0_52(self.sceneTf, self)
	self.itemController = var_0_53(self.sceneTf, self.backSceneTf, self:getGameUsedTimes(), self)
	self.catchController = var_0_54(self.boatController, self.itemController)
	self.charController = var_0_55(self.backSceneTf, self)
	self.sceneScoreTf = findTF(self.sceneTf, "scoreTf")

	setActive(self.sceneScoreTf, false)

	return
end

function IslandCatchTreasureGameView:Update()
	self:AddDebugInput()

	return
end

function IslandCatchTreasureGameView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function IslandCatchTreasureGameView:updateMenuUI()
	local var_87_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hub_id).count

	var_87_0 = var_87_0 or 0
	self.itemNums = var_87_0

	setText(findTF(self.menuUI, "item/num"), self.itemNums)

	return
end

function IslandCatchTreasureGameView:openMenuUI()
	setActive(findTF(self._tf, "scene_container"), false)
	setActive(findTF(self.bgTf, "on"), true)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:updateMenuUI()

	return
end

function IslandCatchTreasureGameView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function IslandCatchTreasureGameView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	return
end

function IslandCatchTreasureGameView:getGameTimes()
	return self:GetMGHubData().count
end

function IslandCatchTreasureGameView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function IslandCatchTreasureGameView:getUltimate()
	return self:GetMGHubData().ultimate
end

function IslandCatchTreasureGameView:gameStart()
	setActive(findTF(self._tf, "scene_container"), true)
	setActive(findTF(self.bgTf, "on"), false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.heart = 3
	self.gameTime = var_0_7

	SetActive(self.sceneScoreTf, false)

	if self.boatController then
		self.boatController:start()
	end

	if self.itemController then
		self.itemController:start()
	end

	if self.catchController then
		self.catchController:start()
	end

	if self.charController then
		self.charController:start()
	end

	self:updateGameUI()
	self:timerStart()

	return
end

function IslandCatchTreasureGameView:transformColor(arg_95_1)
	return Color.New(tonumber(string.sub(arg_95_1, 1, 2), 16) / 255, tonumber(string.sub(arg_95_1, 3, 4), 16) / 255, tonumber(string.sub(arg_95_1, 5, 6), 16) / 255)
end

function IslandCatchTreasureGameView:addScore(arg_96_1, arg_96_2)
	if arg_96_1 and arg_96_1 > 0 or arg_96_2 and arg_96_2 > 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
	elseif arg_96_1 and arg_96_1 < 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
	end

	setActive(self.sceneScoreTf, false)

	local var_96_0 = findTF(self.sceneScoreTf, "img")
	local var_96_1 = GetComponent(var_96_0, typeof(Text))

	if arg_96_1 then
		local var_96_2

		for iter_96_0 = 1, #var_0_40 do
			if arg_96_1 and arg_96_1 >= var_0_40[iter_96_0].score then
				var_96_2 = var_0_40[iter_96_0].font

				break
			end
		end

		local var_96_4 = self:transformColor("6f1807")

		self.scoreNum = self.scoreNum + arg_96_1

		setText(var_96_0, (arg_96_1 >= 0 and "+" or "") .. arg_96_1)

		var_96_1.fontSize = var_96_2 or 40

		setTextColor(var_96_0, var_96_4)
	elseif arg_96_2 then
		var_96_1.fontSize = 40

		setTextColor(var_96_0, (self:transformColor("66f2fb")))

		local var_96_5

		if self.gameTime > 0 then
			self.gameTime = self.gameTime + arg_96_2
			var_96_5 = setText
		end

		var_96_5(var_96_0, (arg_96_2 > 0 and "+" or "") .. arg_96_2 .. "s")
	end

	setActive(self.sceneScoreTf, true)

	return
end

function IslandCatchTreasureGameView:onTimer()
	self:gameStep()

	return
end

function IslandCatchTreasureGameView:gameStep()
	self.gameTime = self.gameTime - Time.deltaTime
	self.gameStepTime = self.gameStepTime + Time.deltaTime

	if self.boatController then
		self.boatController:step()
	end

	if self.itemController then
		self.itemController:step()
	end

	if self.catchController then
		self.catchController:step()
	end

	if self.charController then
		self.charController:step()
	end

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function IslandCatchTreasureGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function IslandCatchTreasureGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function IslandCatchTreasureGameView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function IslandCatchTreasureGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)

	if self.boatController then
		self.boatController:gameOver()
	end

	LeanTween.delayedCall(go(self._tf), 2, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function IslandCatchTreasureGameView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_104_0 = self:GetMGData():GetRuntimeData("elements")
	local var_104_1 = self.scoreNum
	local var_104_2

	if var_104_0 and #var_104_0 > 0 then
		var_104_2 = var_104_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_104_2 < var_104_1)

	if var_104_2 <= var_104_1 then
		var_104_2 = var_104_1

		self:StoreDataToServer({
			var_104_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_104_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_104_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(0)
	end

	return
end

function IslandCatchTreasureGameView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:timerStart()

	return
end

function IslandCatchTreasureGameView:stopGame()
	self.gameStop = true

	self:timerStop()

	return
end

function IslandCatchTreasureGameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(IslandCatchTreasureGameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function IslandCatchTreasureGameView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return IslandCatchTreasureGameView
