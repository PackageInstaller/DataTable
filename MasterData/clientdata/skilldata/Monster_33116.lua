-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33116.lua

local Data = {
	cueFile = "33116",
	[3311601] = {
		bhEvent = "skill.3311601",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3311601
				},
				atkCue = {
					cueList = {
						331160001,
						331161001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3311601,
				flyCueId = 331160002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331161002
					}
				}
			}
		}
	},
	[3311651] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311651",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331160003,
						331161003
					}
				}
			},
			{
				unitDelay = 0.15,
				targetChoose = 18,
				flyCueId = 331160004,
				boxType = 1,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 3311602
				},
				hitCue = {
					cueList = {
						331161004
					}
				}
			},
			[1001] = {
				boxId = 3311651,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			}
		}
	},
	[3311652] = {
		actTime = 45,
		bhEvent = "skill.3311652",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331160006,
						331161005
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3311652,
				flyCueId = 331160007,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 3311603
				},
				hitCue = {
					cueList = {
						331160008,
						331161006
					}
				}
			},
			[1001] = {
				boxId = 3311660,
				state = {},
				hitCue = {
					cueList = {
						10000063
					}
				}
			}
		}
	},
	[3311653] = {
		actTime = 46,
		bhEvent = "skill.3311653",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331160006,
						331161007
					}
				}
			},
			{
				boxId = 3311653,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 3311603
				},
				hitCue = {
					cueList = {
						331160008
					}
				}
			},
			{
				delay = 0.4,
				flyCueId = 331160011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331160010,
						331161008
					}
				}
			},
			{
				state = {},
				hitCue = {
					cueList = {
						331160012
					}
				}
			}
		}
	},
	[3311602] = {
		bhEvent = "skill.3311602",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331160001,
						331161001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3311601,
				flyCueId = 331160002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331161002
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
