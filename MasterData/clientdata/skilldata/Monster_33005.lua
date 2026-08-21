-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33005.lua

local Data = {
	cueFile = "33005",
	[3300501] = {
		bhEvent = "skill.3300501",
		atkEvents = {
			{
				boxType = 1,
				unitDelay = 0.25,
				boxId = 3300501,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330050001
					}
				}
			}
		}
	},
	[3300551] = {
		actTime = 30,
		skillTarget = 1,
		bhEvent = "skill.3300551",
		atkEvents = {
			{
				targetArea = 2,
				boxId = 3300551,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330050001
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						330050002
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
