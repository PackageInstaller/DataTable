-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32107.lua

local Data = {
	cueFile = "32107",
	[3210701] = {
		bhEvent = "skill.3210701",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070001,
						321071001
					}
				}
			},
			{
				boxId = 3210701,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210702] = {
		bhEvent = "skill.3210702",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070002,
						321071002
					}
				}
			},
			{
				boxId = 3210701,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210703] = {
		bhEvent = "skill.3210703",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070003,
						321071003
					}
				}
			},
			{
				boxId = 3210703,
				targetChoose = 2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321070004
					}
				}
			}
		}
	},
	[3210751] = {
		actTime = 60,
		bhEvent = "skill.3210751",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070005,
						321071004
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210551,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000005
				},
				hitCue = {
					cueList = {
						321070006
					}
				}
			}
		}
	},
	[3210752] = {
		actTime = 60,
		bhEvent = "skill.3210752",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070007,
						321071005
					}
				}
			},
			{
				boxId = 3210752,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000064
					}
				}
			}
		}
	},
	[3210753] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3210753",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321070008,
						321071006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3210701
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
