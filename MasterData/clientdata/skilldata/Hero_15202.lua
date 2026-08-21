-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15202.lua

local Data = {
	cueFile = "15202",
	[1520209] = {
		bhEvent = "skill.1520209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152020001,
						152021001
					}
				}
			},
			{
				boxType = 1,
				unitDelay = 0.15,
				boxId = 1520209,
				eventType = 1,
				state = {}
			},
			{
				targetChoose = 13,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1520210
					},
					[3] = {
						boxId = 1520210
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[10] = {
				boxType = 1,
				unitDelay = 0.15,
				flyCueId = 152020003,
				state = {}
			},
			[11] = {
				unitDelay = 0.15,
				flyCueId = 152020003,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						152020005
					}
				}
			}
		}
	},
	[1520210] = {
		bhEvent = "skill.1520210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152020002,
						152021002
					}
				}
			},
			{
				boxType = 1,
				unitDelay = 0.15,
				boxId = 1520209,
				eventType = 1,
				state = {}
			},
			{
				targetChoose = 13,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1520210
					},
					[3] = {
						boxId = 1520210
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				unitDelay = 0.15,
				flyCueId = 152020004,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						152020005
					}
				}
			},
			[10] = {
				boxType = 1,
				unitDelay = 0.15,
				flyCueId = 152020004,
				state = {}
			}
		}
	},
	[1520211] = {
		bhEvent = "skill.1520211",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152020006,
						152020007,
						152020008,
						152021004
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1520209,
				flyCueId = 152020009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						152020011,
						152021005
					}
				}
			},
			[3] = {
				randomTargetNumber = 1,
				boxId = 1520209,
				unitDelay = 0.15,
				boxType = 1,
				randomRule = 1,
				eventType = 1,
				flyCueId = 152020010,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						152020011
					}
				}
			},
			{
				targetChoose = 13,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1520210
					},
					[3] = {
						boxId = 1520210
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1520211
					}
				}
			}
		}
	},
	[1520229] = {
		actTime = 48,
		skillTarget = 1,
		bhEvent = "skill.1520229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152020012,
						152020013,
						152020014,
						152021006
					}
				}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1520205
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 10,
						state = {
							duration = 20,
							stateId = 1520205
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetArea = 3,
				addManaNumber = 30,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1520201
					}
				}
			},
			[3] = {
				state = {}
			},
			{
				state = {}
			},
			[4] = {
				state = {}
			},
			[1003] = {
				addManaNumber = 24,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 30
					},
					[3] = {
						addManaNumber = 30
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				addManaNumber = 24,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1520259] = {
		hideTime = 10,
		hideEvent = 13,
		videoActTime = 66,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 75,
		bhEvent = "skill.1520259",
		atkEvents = {
			[100] = {
				targetArea = 3,
				eventCondition = "1,1,1520201,1",
				state = {
					duration = 4,
					stateId = 1520202
				},
				atkCue = {
					cueList = {
						152020016,
						152020017,
						152020018,
						152020019,
						152020020,
						152020021,
						152020022
					}
				}
			},
			{
				boxId = 1520259,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1000006
				}
			},
			{
				randomTargetNumber = 1,
				targetArea = 3,
				eventCondition = "1,1,1520201,1",
				rebornMhp = 3200,
				targetChoose = 24,
				state = {}
			},
			[1001] = {
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						152020023
					}
				},
				levelAtkEvents = {
					[2] = {
						boxId = 1520260
					},
					[3] = {
						boxId = 1520260
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				boxId = 1520260,
				targetArea = 3,
				state = {
					duration = 20,
					stateId = 1520205
				}
			},
			[10] = {
				targetChoose = 7,
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						152023001
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {}
			},
			[13] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						152025001,
						152020025,
						152021008
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						152020026
					}
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1520201
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				152028001,
				152021007
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
