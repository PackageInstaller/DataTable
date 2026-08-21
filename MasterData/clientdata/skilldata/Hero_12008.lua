-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12008.lua

local Data = {
	cueFile = "12008",
	[1200801] = {
		bhEvent = "skill.1200801",
		atkEvents = {
			{
				boxId = 1200801,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120080007
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120080006,
						120081001
					}
				}
			}
		}
	},
	[1200802] = {
		bhEvent = "skill.1200802",
		atkEvents = {
			{
				unitDelay = 0.1,
				flyCueId = 120080002,
				boxId = 1200801,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120080007
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120080006,
						120081001
					}
				}
			}
		}
	},
	[1200803] = {
		bhEvent = "skill.1200803",
		atkEvents = {
			{
				targetArea = 2,
				boxId = 1200804,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120080009
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120080008,
						120080006,
						120081002
					}
				}
			}
		}
	},
	[1200851] = {
		actTime = 30,
		bhEvent = "skill.1200851",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1200801
				},
				hitCue = {
					cueList = {
						120080011,
						120081003
					}
				}
			},
			[100] = {
				state = {}
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
