-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33113.lua

local Data = {
	cueFile = "33113",
	[3311301] = {
		bhEvent = "skill.3311301",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130001
					}
				}
			},
			{
				unitDelay = 0.08,
				boxId = 3311301,
				flyCueId = 331130002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331131002
					}
				}
			}
		}
	},
	[3311321] = {
		skillTarget = 1,
		bhEvent = "skill.3311321",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130005,
						331131004
					}
				}
			},
			{
				summonLineChoose = 2,
				targetArea = 3,
				summonMonsters = "3311310",
				state = {}
			},
			[1001] = {
				unitDelay = 0.15,
				boxId = 3311321,
				flyCueId = 331130003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331130004
					}
				}
			},
			{
				summonLineChoose = 4,
				targetArea = 3,
				summonMonsters = "3311310",
				state = {}
			},
			[1002] = {
				flyCueId = 331130011,
				boxId = 3311322,
				unitDelay = 0.3,
				boxType = 1,
				subEventSkill = 3311321,
				subEventId = 1003,
				eventType = 1,
				stunTime = 0.5,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				stunTime = 0.5,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311322,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311321,
				subEventId = 1004,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				stunTime = 0.5,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311322,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311321,
				subEventId = 1005,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				stunTime = 0.5,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311322,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			}
		}
	},
	[3311351] = {
		actTime = 35,
		bhEvent = "skill.3311301",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130006,
						331131006
					}
				}
			},
			{
				flyCueId = 331130007,
				boxId = 3311351,
				unitDelay = 0.1,
				boxType = 1,
				subEventSkill = 3311351,
				subEventId = 1001,
				eventType = 1,
				stunTime = 0.2,
				state = {},
				hitCue = {
					cueList = {
						331130008,
						331131007
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				stunTime = 0.2,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311351,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311351,
				subEventId = 1002,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				stunTime = 0.2,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311351,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311351,
				subEventId = 1003,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				stunTime = 0.2,
				unitDelay = 0.3,
				boxType = 1,
				boxId = 3311351,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 331130011,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008
					}
				}
			}
		}
	},
	[3311352] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3311352",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130009,
						331130012,
						331131005
					}
				}
			},
			{
				boxId = 3311352,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311301
				},
				hitCue = {
					cueList = {
						331130010
					}
				}
			}
		}
	},
	[3311353] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3311353",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130009,
						331130012,
						331131005
					}
				}
			},
			{
				boxId = 3311352,
				targetChoose = 10,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311301
				},
				hitCue = {
					cueList = {
						331130010
					}
				}
			}
		}
	},
	[3311354] = {
		actTime = 60,
		bhEvent = "skill.3311354",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130009,
						331130012,
						331131005
					}
				}
			},
			{
				boxId = 3311354,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 3311302
				},
				hitCue = {
					cueList = {
						331130010
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311304
					}
				}
			}
		}
	},
	[3311355] = {
		actTime = 35,
		bhEvent = "skill.3311355",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130006,
						331131006
					}
				}
			},
			{
				flyCueId = 331130007,
				boxId = 3311355,
				unitDelay = 0.1,
				boxType = 1,
				subEventSkill = 3311355,
				subEventId = 1001,
				eventType = 1,
				stunTime = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008,
						331131007
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				stunTime = 1,
				unitDelay = 0.1,
				boxType = 1,
				boxId = 3311355,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311355,
				subEventId = 1002,
				flyCueId = 331130007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008,
						331131007
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				stunTime = 1,
				unitDelay = 0.1,
				boxType = 1,
				boxId = 3311355,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 3311355,
				subEventId = 1003,
				flyCueId = 331130007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008,
						331131007
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				stunTime = 1,
				unitDelay = 0.1,
				boxType = 1,
				boxId = 3311355,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 331130007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						331130008,
						331131007
					}
				}
			}
		}
	},
	[3311356] = {
		actTime = 50,
		bhEvent = "skill.3311356",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331130005,
						331131004
					}
				}
			},
			[2] = {
				boxId = 3311356,
				unitDelay = 0.1,
				boxType = 1,
				stunTime = 1,
				eventType = 1,
				flyCueId = 331130007,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				},
				baseCue = {
					cueList = {
						10000086
					}
				}
			},
			{
				boxId = 3311356,
				unitDelay = 0.1,
				boxType = 1,
				stunTime = 1,
				eventType = 1,
				flyCueId = 331130007,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				},
				baseCue = {
					cueList = {
						10000086
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
