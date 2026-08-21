-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11007.lua

local Data = {
	cueFile = "11007",
	[1100701] = {
		bhEvent = "skill.1100701",
		atkEvents = {
			{
				boxId = 1100709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1100702] = {
		bhEvent = "skill.1100702",
		atkEvents = {
			{
				boxId = 1100709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1100729] = {
		bhEvent = "skill.1100701",
		atkEvents = {
			[0] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100701
				}
			}
		}
	},
	[1100751] = {
		actTime = 60,
		bhEvent = "skill.1100751",
		atkEvents = {
			[2] = {
				boxId = 1100751,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				targetArea = 2,
				boxId = 1100759,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110070004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110070005
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
