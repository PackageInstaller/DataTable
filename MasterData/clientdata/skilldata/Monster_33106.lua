-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33106.lua

local Data = {
	cueFile = "33106",
	[3310601] = {
		bhEvent = "skill.3310601",
		atkEvents = {
			{
				unitDelay = 0.25,
				boxId = 3310601,
				flyCueId = 331060002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063,
						331061002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331060001,
						331061001
					}
				}
			}
		}
	},
	[3310651] = {
		actTime = 50,
		bhEvent = "skill.3310651",
		atkEvents = {
			{
				delay = 0.8,
				boxId = 3310651,
				flyCueId = 331060016,
				boxType = 1,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331060014,
						331061010
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[3310602] = {
		bhEvent = "skill.3310602",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 3310601,
				flyCueId = 331060002,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063,
						331061002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331060001,
						331061001
					}
				}
			}
		}
	},
	[3310603] = {
		bhEvent = "skill.3310603",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331060012,
						331061009
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3310603,
				unitDelay = 0.2,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331060015,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331060014,
						331061010
					}
				}
			}
		}
	},
	[3310652] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.3310652",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3310601
				}
			},
			[100] = {
				state = {}
			},
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 3310602
				}
			}
		}
	},
	[3310653] = {
		actTime = 45,
		skillTarget = 2,
		bhEvent = "skill.3310653",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331060012,
						331061009
					}
				}
			},
			{
				delay = 0.8,
				boxId = 3310653,
				flyCueId = 331060015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331060014,
						331061010
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
