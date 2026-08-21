-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32108.lua

local Data = {
	cueFile = "32108",
	[3210801] = {
		bhEvent = "skill.3210801",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321080001,
						321081001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 3210801,
				flyCueId = 321080002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321080003,
						321081002
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3210801,
				unitDelay = 0.25,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 321080002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						321080003,
						321081002
					}
				}
			}
		}
	},
	[3210802] = {
		bhEvent = "skill.3210802",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321080013,
						321081005
					}
				}
			},
			{
				boxId = 3210802,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321080015
					}
				}
			}
		}
	},
	[3210803] = {
		bhEvent = "skill.3210803",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321080014,
						321081006
					}
				}
			},
			{
				controlTime = 1,
				controlAniName = "Float",
				boxId = 3210803,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321080015
					}
				}
			}
		}
	},
	[3210821] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3210821",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321080016,
						321081007
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 9.5,
					stateId = 3210801
				}
			},
			[1001] = {
				eventType = 1,
				state = {
					duration = 2,
					stateId = 1000006
				},
				hitCue = {
					cueList = {
						321080004,
						321081003,
						321080022
					}
				}
			},
			[1002] = {
				delay = 0.5,
				boxType = 1,
				subEventSkill = 3210821,
				boxId = 3210821,
				subEventId = 1003,
				eventType = 1,
				state = {}
			},
			[1003] = {
				boxType = 1,
				delay = 0.6,
				boxId = 3210821,
				state = {}
			}
		}
	},
	[3210851] = {
		actTime = 70,
		bhEvent = "skill.3210851",
		atkEvents = {
			[100] = {
				targetChoose = 19,
				state = {},
				atkCue = {
					cueList = {
						321080008,
						321080009,
						321080010,
						321080011,
						321080012,
						321081004
					}
				},
				hitCue = {
					cueList = {
						321080005,
						321080006,
						321080007
					}
				}
			},
			{
				flyCueId = 321080020,
				unitDelay = 0.15,
				boxId = 3210852,
				targetChoose = 19,
				eventType = 1,
				state = {}
			},
			{
				hitedAnim = "Hit",
				targetChoose = 19,
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 19,
				state = {}
			}
		}
	},
	[3210852] = {
		actTime = 45,
		bhEvent = "skill.3210852",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321080019,
						321081008
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3210851,
				flyCueId = 321080020,
				boxType = 1,
				targetChoose = 18,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 3210807
				},
				hitCue = {
					cueList = {
						321081009,
						321080021
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3210851,
				flyCueId = 321080020,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321080021,
						321081009
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
