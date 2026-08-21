-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32103.lua

local Data = {
	cueFile = "32103",
	[3210301] = {
		bhEvent = "skill.3210301",
		atkEvents = {
			{
				boxId = 3210301,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321030002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321030009
					}
				}
			}
		}
	},
	[3210351] = {
		actTime = 55,
		bhEvent = "skill.3210351",
		atkEvents = {
			{
				state = {},
				atkCue = {
					cueList = {
						321030004,
						321030005,
						321030006,
						321031001
					}
				}
			},
			[0] = {
				boxId = 3210351,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321030007
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[3210302] = {
		bhEvent = "skill.3210302",
		atkEvents = {
			{
				boxId = 3210301,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321030001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321030008
					}
				}
			}
		}
	},
	[3210303] = {
		bhEvent = "skill.3210303",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321030018
					}
				}
			},
			{
				boxId = 3210303,
				targetChoose = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321030007
					}
				}
			}
		}
	},
	[3210352] = {
		actTime = 45,
		bhEvent = "skill.3210352",
		atkEvents = {
			{
				boxId = 3210352,
				targetChoose = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321030016
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321030011
					}
				}
			}
		}
	},
	[3210353] = {
		actTime = 55,
		skillTarget = 1,
		bhEvent = "skill.3210353",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210301
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
