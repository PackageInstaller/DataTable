-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11102.lua

local Data = {
	cueFile = "11102",
	[1110259] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 13,
		actTime = 80,
		bhEvent = "skill.1110259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111020010,
						111020011,
						111020012,
						111025002
					}
				}
			},
			{
				state = {
					duration = 5,
					stateId = 1110203
				}
			},
			[0] = {
				boxId = 1110259,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						111020013,
						111023001
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1110204
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1110205
				}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1110259,
				boxId = 1110260,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetChoose = 14,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1110260
					},
					[3] = {
						boxId = 1110260
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				targetArea = 1,
				state = {
					duration = 3,
					stateId = 1110201
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						111020015,
						111025001,
						111021005
					}
				}
			},
			[12] = {
				state = {},
				hitCue = {
					cueList = {
						111029001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				111028001,
				111021004
			}
		}
	},
	[1110209] = {
		bhEvent = "skill.1110209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111020001,
						111021002
					}
				}
			},
			{
				boxId = 1110209,
				state = {},
				hitCue = {
					cueList = {
						111020002
					}
				}
			},
			{
				disablePassive = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1110210
					},
					[3] = {
						boxId = 1110210
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1110211
					},
					[4] = {
						boxId = 1110211
					},
					[5] = {
						boxId = 1110211
					},
					[6] = {
						boxId = 1110211
					}
				}
			}
		}
	},
	[1110210] = {
		bhEvent = "skill.1110210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111020003,
						111021002
					}
				}
			},
			{
				boxId = 1110209,
				state = {},
				hitCue = {
					cueList = {
						111020004
					}
				}
			},
			{
				disablePassive = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1110210
					},
					[3] = {
						boxId = 1110210
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1110211
					},
					[4] = {
						boxId = 1110211
					},
					[5] = {
						boxId = 1110211
					},
					[6] = {
						boxId = 1110211
					}
				}
			}
		}
	},
	[1110229] = {
		bhEvent = "skill.1110229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111020005,
						111020006,
						111020009,
						111021003
					}
				}
			},
			{
				subEventId = 1002,
				subEventSkill = 1110229,
				boxId = 1110229,
				state = {},
				hitCue = {
					cueList = {
						111020007
					}
				}
			},
			{
				boxId = 1110230,
				targetArea = 3,
				eventCondition = "1,1,1110202",
				state = {}
			},
			[10] = {
				subEventId = 1001,
				targetArea = 3,
				subEventSkill = 1110229,
				state = {
					duration = 3,
					stateId = 1110201
				}
			},
			[1001] = {
				targetChoose = 19,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1110201
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = 2.5,
					stateId = 1110206
				}
			},
			[90] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110206
					}
				}
			},
			[1002] = {
				state = {
					duration = 1,
					stateId = 1110207
				}
			},
			[1003] = {
				boxId = 1110231,
				disablePassive = 1,
				disableHpPassive = 1,
				state = {}
			},
			[1004] = {
				boxId = 1110232,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				delay = 0.2,
				addManaNumber = 2,
				boxType = 1,
				targetArea = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 4
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				boxId = 1110233,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				boxId = 1110234,
				targetChoose = 19,
				state = {
					duration = 5,
					stateId = 1110203
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
