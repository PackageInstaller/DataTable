-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13901.lua

local Data = {
	cueFile = "13005",
	[1390101] = {
		bhEvent = "skill.1390101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130050001
					}
				}
			},
			[0] = {
				unitDelay = 0.15,
				boxId = 1390101,
				flyCueId = 130050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050004
					}
				}
			}
		}
	},
	[1390121] = {
		bhEvent = "skill.1390101",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				unitDelay = 0.15,
				boxId = 1390121,
				flyCueId = 130050003,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050006
					}
				}
			}
		}
	},
	[1390151] = {
		actTime = 60,
		videoActTime = 52,
		bhEvent = "skill.1390151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130050007,
						130050008
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1390151,
				flyCueId = 130050009,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050010
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130058001,
				130051005
			}
		}
	},
	[1390152] = {
		actTime = 60,
		videoActTime = 52,
		bhEvent = "skill.1390152",
		atkEvents = {
			[100] = {
				randomTargetNumber = 1,
				targetArea = 3,
				rebornMhp = 10000,
				targetChoose = 24,
				state = {}
			},
			{
				unitDelay = 0.15,
				boxId = 1390161,
				flyCueId = 130050009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050010
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130058001,
				130051005
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
