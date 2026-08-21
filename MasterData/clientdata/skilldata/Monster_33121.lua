-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33121.lua

local Data = {
	cueFile = "33121",
	[3312101] = {
		bhEvent = "skill.3312101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210001,
						331211001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3312101,
				flyCueId = 331210002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331211002
					}
				}
			}
		}
	},
	[3312121] = {
		bhEvent = "skill.3312121",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210005,
						331211004
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3312121,
				flyCueId = 331210006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210007
					}
				}
			},
			[1001] = {
				targetArea = 3,
				delay = 0.5,
				boxId = 3312122,
				boxType = 1,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 3312102
				},
				atkCue = {
					cueList = {
						331210003,
						331211003
					}
				},
				hitCue = {
					cueList = {
						10000008,
						331210004
					}
				}
			}
		}
	},
	[3312151] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3312151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210009,
						331211005
					}
				}
			},
			{
				randomTargetNumber = 1,
				randomRule = 1,
				boxId = 3312151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010,
						331211006
					}
				}
			},
			{
				randomTargetNumber = 1,
				randomRule = 1,
				boxId = 3312151,
				targetChoose = 7,
				eventCondition = "1,1,3312111",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010
					}
				}
			},
			{
				randomTargetNumber = 1,
				eventCondition = "1,1,3312112",
				boxId = 3312151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010
					}
				}
			},
			{
				randomTargetNumber = 1,
				eventCondition = "1,1,3312113",
				boxId = 3312151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010
					}
				}
			},
			{
				randomTargetNumber = 1,
				eventCondition = "1,1,3312114",
				boxId = 3312151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210009
					}
				}
			},
			{
				randomTargetNumber = 1,
				eventCondition = "1,1,3312115",
				boxId = 3312151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312111
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312112
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312113
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312114
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312115
				}
			}
		}
	},
	[3312152] = {
		actTime = 50,
		bhEvent = "skill.3312152",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210009,
						331211005
					}
				}
			},
			{
				state = {}
			},
			{
				randomTargetNumber = 3,
				randomRule = 2,
				boxId = 3312152,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010,
						331211006
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
