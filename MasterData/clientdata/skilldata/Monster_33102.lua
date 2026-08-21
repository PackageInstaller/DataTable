-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33102.lua

local Data = {
	cueFile = "33102",
	[3310201] = {
		bhEvent = "skill.3310201",
		atkEvents = {
			[100] = {
				unitDelay = 0.15,
				flyCueId = 140070001,
				state = {},
				atkCue = {
					cueList = {
						331020003
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 3310201,
				flyCueId = 331020001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331020002,
						331021001
					}
				}
			}
		}
	},
	[3310251] = {
		actTime = 55,
		skillTarget = 1,
		bhEvent = "skill.3310251",
		atkEvents = {
			{
				targetArea = 3,
				flyCueId = 331020001,
				boxId = 3310251,
				targetChoose = 18,
				state = {
					duration = 1.5,
					stateId = 3310201
				},
				hitCue = {
					cueList = {
						331020015,
						10000008
					}
				}
			},
			{
				targetChoose = 18,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						331020010,
						331020013
					}
				}
			},
			[1001] = {
				excludeTarget = 1,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331020002
					}
				}
			}
		}
	},
	[3310202] = {
		bhEvent = "skill.3310202",
		atkEvents = {
			[0] = {
				unitDelay = 0.2,
				boxId = 3310302,
				flyCueId = 331020001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331020002,
						331021001
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[3310252] = {
		skillTarget = 1,
		bhEvent = "skill.3310252",
		atkEvents = {
			[2] = {
				state = {}
			},
			{
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3310202
				},
				hitCue = {
					cueList = {
						331020007
					}
				}
			},
			[1001] = {
				boxId = 3310253,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			}
		}
	},
	[3310253] = {
		bhEvent = "skill.3310252",
		atkEvents = {
			[2] = {
				state = {},
				atkCue = {
					cueList = {
						331020021,
						331020022,
						331020023
					}
				}
			},
			{
				targetArea = 2,
				stunTime = 1,
				boxId = 3310254,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331020020
					}
				}
			}
		}
	},
	[3310254] = {
		actTime = 30,
		bhEvent = "skill.3310252",
		atkEvents = {
			[2] = {
				state = {},
				atkCue = {
					cueList = {
						331020009
					}
				}
			},
			{
				targetArea = 3,
				summonMonsters = "3310201,3310201",
				state = {
					duration = -999,
					stateId = 3310203
				}
			},
			[1001] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					stateOperation = 1,
					stateId = 3310203,
					chooseStateMode = 2,
					delLayer = 1,
					chooseStateIds = {
						3310203
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
