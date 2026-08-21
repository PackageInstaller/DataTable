-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11201_01.lua

local Data = {
	cueFile = "10001",
	[1120103] = {
		bhEvent = "skill.1120103",
		atkEvents = {
			{
				state = {}
			}
		}
	},
	[1120122] = {
		bhEvent = "skill.1120122",
		atkEvents = {
			[2] = {
				targetArea = 2,
				state = {}
			},
			{
				boxId = 1100409,
				targetChoose = 1,
				state = {},
				hitCue = {
					cueList = {
						10000029
					}
				}
			}
		}
	},
	[1120152] = {
		bhEvent = "skill.1120152",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				state = {}
			},
			{
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220101
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
