-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13011.lua

local Data = {
	cueFile = "13011",
	[1301109] = {
		bhEvent = "skill.1301109",
		atkEvents = {
			[0] = {
				unitDelay = 0.16,
				boxId = 1301109,
				flyCueId = 130110008,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						130111003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130110007,
						130111002
					}
				}
			},
			[10] = {
				state = {}
			}
		}
	},
	[1301159] = {
		actTime = 45,
		skillTarget = 2,
		bhEvent = "skill.1301159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130110010,
						130111004
					}
				}
			},
			[0] = {
				unitDelay = 0.2,
				boxId = 1301159,
				flyCueId = 130110011,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130110012,
						130111005
					}
				}
			},
			{
				state = {}
			},
			[1001] = {
				targetArea = 3,
				addManaNumber = 15,
				state = {},
				hitCue = {
					cueList = {
						130110003,
						10000035
					}
				}
			}
		}
	},
	[1301110] = {
		bhEvent = "skill.1301110",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1301109,
				flyCueId = 90010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130110001
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
