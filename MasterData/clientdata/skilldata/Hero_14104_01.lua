-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14104_01.lua

local Data = {
	cueFile = "14104",
	[1620909] = {
		bhEvent = "skill.1620909",
		atkEvents = {
			[1001] = {
				boxId = 1620910,
				unitDelay = 0.2,
				boxType = 1,
				subEventSkill = 1620909,
				subEventId = 1002,
				eventType = 1,
				eventCondition = "1,2,1410402",
				flyCueId = 141040007,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						141041005
					}
				},
				hitCue = {
					cueList = {
						141040008,
						141041006
					}
				}
			},
			[1002] = {
				targetChoose = 7,
				subEventSkill = 1620909,
				subEventId = 1003,
				targetArea = 3,
				eventCondition = "1,2,1410413",
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				},
				levelAtkEvents = {
					[2] = {
						boxId = 1620909
					},
					[3] = {
						boxId = 1620909
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				targetChoose = 15,
				eventCondition = "1,2,1410415,1",
				targetArea = 3,
				eventProbId = 1410401,
				state = {
					duration = 1,
					stateId = 1410415,
					chooseStateIds = {
						0
					}
				}
			},
			[1004] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1410403
				}
			},
			[1005] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410414
				}
			},
			[1006] = {
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						141040006,
						141041007
					}
				}
			},
			[1007] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410417
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
