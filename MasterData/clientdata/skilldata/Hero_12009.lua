-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12009.lua

local Data = {
	cueFile = "12009",
	[1200901] = {
		bhEvent = "skill.1200901",
		atkEvents = {
			{
				boxId = 1200901,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120090001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120090009
					}
				}
			}
		}
	},
	[1200902] = {
		bhEvent = "skill.1200902",
		atkEvents = {
			{
				boxId = 1200901,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120090001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120090008
					}
				}
			}
		}
	},
	[1200951] = {
		actTime = 40,
		bhEvent = "skill.1200951",
		atkEvents = {
			{
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						120090004,
						120090005,
						120090006,
						120091001
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1200902
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1200902
						}
					},
					[4] = {
						state = {
							duration = 3,
							stateId = 1200902
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				boxId = 1200951,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120090007
					}
				}
			},
			{
				targetArea = 3,
				state = {}
			},
			[1001] = {
				boxId = 1200952,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1200921] = {
		bhEvent = "skill.1200921",
		atkEvents = {
			[1001] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1200901
				}
			},
			[1002] = {
				state = {
					duration = -999,
					stateId = 1200903
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
