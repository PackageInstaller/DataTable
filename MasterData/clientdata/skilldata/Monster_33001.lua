-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33001.lua

local Data = {
	cueFile = "33001",
	[3300101] = {
		bhEvent = "skill.3300101",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 3300101,
				flyCueId = 330010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330010003,
						330011002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330010001,
						330011001
					}
				}
			}
		}
	},
	[3300102] = {
		bhEvent = "skill.3300102",
		atkEvents = {
			[2] = {
				state = {}
			},
			{
				unitDelay = 0.1,
				boxId = 3300102,
				flyCueId = 330010005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330010006,
						330011004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330010004,
						330011003
					}
				}
			}
		}
	},
	[3300151] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.3300151",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3300101
				}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 3200101
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330010007,
						330010008,
						330010009,
						330011005
					}
				}
			},
			[0] = {
				state = {}
			}
		}
	},
	[3300152] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.3300152",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330010007,
						330010008,
						330010009,
						330011005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3300101
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
