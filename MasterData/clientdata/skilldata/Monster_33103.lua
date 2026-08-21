-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33103.lua

local Data = {
	cueFile = "33102",
	[3310301] = {
		bhEvent = "skill.3310301",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331020018,
						331021006
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 3310301,
				flyCueId = 331020019,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331020020,
						331021003
					}
				}
			}
		}
	},
	[3310351] = {
		actTime = 55,
		skillTarget = 1,
		bhEvent = "skill.3310351",
		atkEvents = {
			{
				unitDelay = 0.1,
				targetChoose = 4,
				flyCueId = 331030005,
				boxId = 3310351,
				targetArea = 2,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 1000002
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331020021,
						331020022,
						331020023,
						331021004
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
