-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33108.lua

local Data = {
	cueFile = "33108",
	[3310801] = {
		bhEvent = "skill.3310801",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3310801,
				flyCueId = 331080002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				disablePassive = 1,
				boxId = 3310801,
				flyCueId = 331080002,
				boxType = 1,
				unitDelay = 0.12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080001,
						331081001
					}
				}
			},
			[0] = {
				state = {}
			}
		}
	},
	[3310802] = {
		bhEvent = "skill.3310802",
		atkEvents = {
			[5] = {
				targetArea = 3,
				state = {
					duration = 2.2,
					stateId = 3310803
				}
			},
			{
				boxId = 3310802,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080005,
						331081006
					}
				}
			},
			{
				boxId = 3310802,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080005,
						331081006
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080004,
						331081005
					}
				}
			}
		}
	},
	[3310851] = {
		actTime = 81,
		skillTarget = 1,
		bhEvent = "skill.3310851",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3310801
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080006,
						331081007
					}
				}
			}
		}
	},
	[3310852] = {
		actTime = 16,
		bhEvent = "skill.3310852",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3310852,
				flyCueId = 331080010,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080011,
						331080012,
						331080013,
						331081009
					}
				}
			},
			[5] = {
				targetArea = 3,
				state = {
					duration = 4.5,
					stateId = 3310802
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3310852,
				flyCueId = 331080010,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080011,
						331080012,
						331080013,
						331081009
					}
				}
			},
			[6] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3310802
					}
				}
			},
			[100] = {
				state = {}
			},
			[15] = {
				state = {},
				atkCue = {
					cueList = {
						331080008,
						331080009
					}
				},
				hitCue = {
					cueList = {
						331080013,
						331080012
					}
				}
			}
		}
	},
	[3310853] = {
		actTime = 71,
		bhEvent = "skill.3310853",
		atkEvents = {
			{
				unitDelay = 0.09,
				boxId = 3310853,
				flyCueId = 331080017,
				boxType = 1,
				addManaNumber = -30,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080016,
						331081004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080015,
						331081003
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
