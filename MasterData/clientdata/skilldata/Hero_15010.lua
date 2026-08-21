-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15010.lua

local Data = {
	cueFile = "14007",
	[1501009] = {
		bhEvent = "skill.1501009",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxType = 1,
				flyCueId = 140070001,
				boxId = 1501009,
				state = {},
				hitCue = {
					cueList = {
						140070002,
						140071001
					}
				}
			},
			{
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140070003
					}
				}
			}
		}
	},
	[1501010] = {
		bhEvent = "skill.1501009",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1501009,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						90010008
					}
				}
			}
		}
	},
	[1501021] = {
		actTime = 40,
		bhEvent = "skill.1501021",
		atkEvents = {
			{
				targetChoose = 7,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140070004,
						140070005
					}
				}
			},
			[10] = {
				state = {}
			},
			{
				targetChoose = 4,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1501002
				},
				hitCue = {
					cueList = {
						140070008
					}
				}
			}
		}
	},
	[1501059] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1501059",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						140070011,
						140070014
					}
				}
			},
			[2] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1501059,
				targetChoose = 4,
				randomRule = 1,
				state = {
					duration = 10,
					stateId = 1501001
				},
				hitCue = {
					cueList = {
						140070008,
						140070017
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
