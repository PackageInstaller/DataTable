-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12013_03.lua

local Data = {
	cueFile = "12013",
	[1620609] = {
		actTime = 50,
		bhEvent = "skill.1620609",
		atkEvents = {
			[11] = {
				boxId = 1620609,
				subEventId = 1001,
				subEventSkill = 1620609,
				state = {}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1620609,
				boxId = 1620631,
				targetChoose = 4,
				state = {}
			},
			[1002] = {
				boxId = 1620610,
				targetChoose = 22,
				state = {}
			}
		}
	},
	[1620629] = {
		actTime = 50,
		bhEvent = "skill.1620629",
		atkEvents = {
			[11] = {
				boxType = 1,
				boxId = 1620629,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120130021,
						120131010
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130020,
						120130022,
						120131009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1201302
				}
			},
			{
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1201303
				}
			},
			{
				boxId = 1620630,
				targetArea = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10006006
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
