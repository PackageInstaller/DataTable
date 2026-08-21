-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32104.lua

local Data = {
	cueFile = "32104",
	[3210401] = {
		bhEvent = "skill.3210401",
		atkEvents = {
			{
				boxId = 3210401,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040011,
						321041001
					}
				}
			}
		}
	},
	[3210402] = {
		bhEvent = "skill.3210402",
		atkEvents = {
			{
				boxId = 3210401,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[0] = {
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040012,
						321041002
					}
				}
			}
		}
	},
	[3210451] = {
		actTime = 80,
		bhEvent = "skill.3210451",
		atkEvents = {
			{
				hitedAnim = "Hit",
				stunTime = 3,
				unitDelay = 0.1,
				boxId = 3210451,
				eventType = 1,
				flyCueId = 321040008,
				targetChoose = 2,
				state = {},
				hitCue = {
					cueList = {
						321040016
					}
				}
			},
			[10] = {
				targetChoose = 2,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040014,
						321040015,
						321041003
					}
				}
			}
		}
	},
	[3210452] = {
		actTime = 55,
		bhEvent = "skill.3210452",
		atkEvents = {
			[2] = {
				eventType = 1,
				state = {}
			},
			{
				hitedAnim = "Hit",
				stunTime = 2,
				boxId = 3210452,
				targetChoose = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321040020
					}
				}
			},
			[10] = {
				hitedAnim = "end",
				targetChoose = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040017,
						321040018,
						321040019,
						321041004
					}
				}
			}
		}
	},
	[3210453] = {
		actTime = 70,
		bhEvent = "skill.3210453",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210401
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040021,
						321041005
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
