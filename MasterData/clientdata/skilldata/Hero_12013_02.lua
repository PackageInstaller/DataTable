-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12013_02.lua

local Data = {
	cueFile = "12013",
	[1620509] = {
		bhEvent = "skill.1620509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130017,
						120131007
					}
				}
			},
			[0] = {
				flyCueId = 120130017,
				boxId = 1620509,
				unitDelay = 0.12,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				subEventSkill = 1620509,
				state = {},
				hitCue = {
					cueList = {
						120130019,
						120131011
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1620512,
				targetChoose = 15,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				boxId = 1620511,
				targetArea = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[1620510] = {
		bhEvent = "skill.1620510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130018,
						120131007
					}
				}
			},
			[1001] = {
				boxId = 1620511,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				subEventId = 1001,
				subEventSkill = 1620510,
				boxId = 1620512,
				targetChoose = 15,
				state = {}
			},
			[0] = {
				flyCueId = 120130018,
				boxId = 1620509,
				unitDelay = 0.12,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				subEventSkill = 1620510,
				state = {},
				hitCue = {
					cueList = {
						120130019,
						120131011
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
