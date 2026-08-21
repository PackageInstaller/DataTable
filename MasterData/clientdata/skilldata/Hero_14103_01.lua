-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14103_01.lua

local Data = {
	cueFile = "14103",
	[1620809] = {
		bhEvent = "skill.1620809",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141030006
					}
				}
			},
			[0] = {
				unitDelay = 0.15,
				boxId = 1620809,
				flyCueId = 141030007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141030008
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
