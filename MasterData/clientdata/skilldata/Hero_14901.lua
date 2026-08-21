-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14901.lua

local Data = {
	cueFile = "14012",
	[1490101] = {
		bhEvent = "skill.1490101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1490101,
				flyCueId = 140120002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120003
					}
				}
			}
		}
	},
	[1490121] = {
		bhEvent = "skill.1490101",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				unitDelay = 0.15,
				boxId = 1490121,
				flyCueId = 140120002,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120007
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1490151] = {
		actTime = 70,
		videoActTime = 60,
		bhEvent = "skill.1490151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120009
					}
				}
			},
			{
				boxId = 1490151,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120010
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1490101
				}
			}
		},
		videoActCue = {
			cueList = {
				140128001,
				140121005
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
