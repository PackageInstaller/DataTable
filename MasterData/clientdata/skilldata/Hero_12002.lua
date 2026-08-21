-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12002.lua

local Data = {
	cueFile = "12002",
	[1200209] = {
		bhEvent = "skill.1200209",
		atkEvents = {
			{
				boxId = 1200209,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200210] = {
		bhEvent = "skill.1200210",
		atkEvents = {
			{
				boxId = 1200209,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200229] = {
		skillTarget = 1,
		bhEvent = "skill.1200229",
		atkEvents = {
			{
				targetArea = 3,
				summonMonsters = "1610101,1610101,1610101",
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1000012
					}
				},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1610102,1610102,1610102"
					},
					[3] = {
						summonMonsters = "1610103,1610103,1610103"
					},
					[4] = {
						summonMonsters = "1610101,1610101"
					},
					[5] = {
						summonMonsters = "1610101,1610101"
					},
					[6] = {
						summonMonsters = "1610101,1610101"
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {}
			},
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1000012
				},
				atkCue = {
					cueList = {
						120020001
					}
				}
			},
			[1001] = {
				targetChoose = 15,
				targetArea = 1,
				state = {
					duration = 5,
					stateId = 1200213
				}
			},
			[1002] = {
				boxId = 1200235,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1200259] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 32,
		shortVideoActTime = 2,
		bhEvent = "skill.1200259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120020006
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1200260,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120028001
					}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1200259,
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1200201
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[10] = {
				state = {},
				hitCue = {
					cueList = {
						120029001
					}
				}
			},
			[11] = {
				hitedAnim = "Hit",
				state = {}
			},
			[12] = {
				hitedAnim = "Hit",
				targetChoose = 3,
				state = {}
			},
			{
				state = {}
			},
			[13] = {
				hitedAnim = "end",
				targetChoose = 3,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				boxId = 1200260,
				targetChoose = 17,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1200205
				}
			},
			[1004] = {
				targetArea = 3,
				summonMonsters = "1610101",
				state = {}
			},
			[1005] = {
				targetArea = 3,
				summonMonsters = "1610102",
				state = {}
			},
			[1006] = {
				targetArea = 3,
				summonMonsters = "1610103",
				state = {}
			},
			[26] = {
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						120020007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120028001,
				120029002,
				120021001
			}
		},
		shortVideoActCue = {
			cueList = {
				120028002,
				120021004
			}
		}
	},
	[1200222] = {
		bhEvent = "skill.1200222",
		atkEvents = {
			{
				unitDelay = 0.25,
				flyCueId = 120020004,
				boxType = 1,
				targetChoose = 3,
				boxId = 1200222,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						120020005,
						120021002,
						120021003
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 10
					},
					[3] = {
						addManaNumber = 10
					},
					[4] = {
						addManaNumber = 10
					},
					[5] = {},
					[6] = {}
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
