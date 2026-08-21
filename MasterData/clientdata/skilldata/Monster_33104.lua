-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33104.lua

local Data = {
	cueFile = "33104",
	[3310401] = {
		bhEvent = "skill.3310401",
		atkEvents = {
			{
				unitDelay = 0.2,
				boxId = 3310401,
				flyCueId = 331040002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040001
					}
				}
			}
		}
	},
	[3310451] = {
		actTime = 54,
		skillTarget = 1,
		bhEvent = "skill.3310451",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				flyCueId = 331040014,
				targetArea = 3,
				unitDelay = 0.1,
				state = {
					duration = 6,
					stateId = 3310401
				}
			}
		}
	},
	[3310402] = {
		bhEvent = "skill.3310402",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 3310402,
				flyCueId = 331040005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			},
			[10] = {
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[3310452] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3310452",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 3310402
				}
			},
			{
				state = {}
			}
		}
	},
	[3310403] = {
		bhEvent = "skill.3310403",
		atkEvents = {
			{
				randomTargetNumber = 2,
				boxId = 3310403,
				unitDelay = 0.08,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331040005,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			}
		}
	},
	[3310453] = {
		actTime = 62,
		skillTarget = 1,
		bhEvent = "skill.3310453",
		atkEvents = {
			{
				targetArea = 3,
				summonMonsters = "3310410",
				state = {}
			},
			[1001] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3310406
					}
				}
			}
		}
	},
	[3310454] = {
		actTime = 45,
		bhEvent = "skill.3310454",
		atkEvents = {
			{
				boxId = 3310454,
				delay = 0.2,
				boxType = 1,
				eventType = 1,
				flyCueId = 331040020,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						331040017
					}
				},
				baseCue = {
					cueList = {
						331040024
					}
				}
			}
		}
	},
	[3310455] = {
		actTime = 54,
		skillTarget = 1,
		bhEvent = "skill.3310455",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3310403
				}
			}
		}
	},
	[3310456] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3310456",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3310404
				}
			}
		}
	},
	[3310457] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3310457",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3310405
				}
			},
			[1001] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {
					duration = 3,
					stateId = 3310407
				}
			}
		}
	},
	[3310404] = {
		bhEvent = "skill.3310404",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 3310404,
				flyCueId = 331040005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			},
			[10] = {
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[3310405] = {
		bhEvent = "skill.3310405",
		atkEvents = {
			{
				delay = 0.5,
				flyCueId = 331040039,
				boxId = 3310405,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			},
			{
				boxId = 3310407,
				targetArea = 3,
				state = {}
			},
			[10] = {
				delay = 0.4,
				boxType = 1,
				flyCueId = 331040039,
				state = {}
			}
		}
	},
	[3310406] = {
		bhEvent = "skill.3310406",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 3310406,
				flyCueId = 331040005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			}
		}
	},
	[3310458] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3310458",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3310408
				}
			}
		}
	},
	[3310409] = {
		bhEvent = "skill.3310409",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 3310401,
				flyCueId = 331040041,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331040004
					}
				}
			}
		}
	},
	[3310410] = {
		bhEvent = "skill.3310410",
		atkEvents = {
			{
				randomTargetNumber = 2,
				boxId = 3310403,
				unitDelay = 0.1,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331040041,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331040021
					}
				}
			}
		}
	}
}
local skillDefault = {}
local atkEventsDefault = {
	randomTargetNumber = 0,
	boxType = 0,
	flyCueId = 0,
	eventType = 0,
	delay = 0,
	stateCondition = 0,
	boxId = 0,
	eventProbId = 0
}

for k, skillData in pairs(Data) do
	if k ~= "cueFile" then
		setmetatable(skillData, {
			__index = skillDefault
		})

		for skillKey, skillInfo in pairs(skillData) do
			if skillKey == "atkEvents" then
				for eventsKey, event in pairs(skillInfo) do
					setmetatable(event, {
						__index = atkEventsDefault
					})
				end
			end
		end
	end
end

return Data
