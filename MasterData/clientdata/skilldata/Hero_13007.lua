-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13007.lua

local Data = {
	cueFile = "13008",
	[1300701] = {
		bhEvent = "skill.1300701",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1300701,
				flyCueId = 130080002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080001
					}
				}
			}
		}
	},
	[1300751] = {
		actTime = 35,
		skillTarget = 1,
		bhEvent = "skill.1300751",
		atkEvents = {
			{
				flyCueId = 130070001,
				unitDelay = 0.05,
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1300701
				},
				hitCue = {
					cueList = {
						130080001
					}
				}
			},
			[100] = {
				state = {}
			},
			{
				state = {}
			},
			[1001] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			}
		}
	},
	[1300702] = {
		bhEvent = "skill.1300702",
		atkEvents = {
			[2] = {
				state = {}
			},
			{
				unitDelay = 0.15,
				boxId = 1300702,
				flyCueId = 130080005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080004
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
