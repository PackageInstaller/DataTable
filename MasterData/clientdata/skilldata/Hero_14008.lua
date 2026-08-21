-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14008.lua

local Data = {
	cueFile = "14008",
	[1400801] = {
		bhEvent = "skill.1400801",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1400801,
				flyCueId = 140080007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140080008,
						140081003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140080006,
						140081002
					}
				}
			}
		}
	},
	[1400851] = {
		actTime = 45,
		bhEvent = "skill.1400851",
		atkEvents = {
			{
				boxId = 1400851,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140080012
					}
				}
			},
			{
				targetArea = 1,
				boxId = 1400852,
				targetChoose = 11,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140080011,
						140080010,
						140081005
					}
				}
			}
		}
	},
	[1400821] = {
		bhEvent = "skill.1400801",
		atkEvents = {
			{
				state = {}
			},
			[1001] = {
				boxId = 1400821,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						140080009,
						140081004
					}
				}
			},
			[100] = {
				state = {}
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
