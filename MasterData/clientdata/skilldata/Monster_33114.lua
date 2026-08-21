-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33114.lua

local Data = {
	cueFile = "33114",
	[3311401] = {
		bhEvent = "skill.3311401",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140001,
						331141001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311401,
				flyCueId = 331140002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331140005,
						331141002
					}
				}
			}
		}
	},
	[3311402] = {
		bhEvent = "skill.3311402",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140001,
						331141001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311401,
				flyCueId = 331140003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331140005,
						331141002
					}
				}
			}
		}
	},
	[3311403] = {
		bhEvent = "skill.3311403",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140001,
						331141001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311401,
				flyCueId = 331140004,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331140005,
						331141002
					}
				}
			}
		}
	},
	[3311421] = {
		actTime = 30,
		bhEvent = "skill.3311421",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						10005003
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3311421,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331140018
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311404
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						331140006,
						331141003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						331140006,
						331141003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						331140006,
						331141003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						331140006,
						331141003
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311407
				}
			}
		}
	},
	[3311451] = {
		actTime = 50,
		bhEvent = "skill.3311451",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3311401
				},
				atkCue = {
					cueList = {
						331140010,
						331141004
					}
				}
			},
			{
				boxId = 3311451,
				targetChoose = 10,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311402
				}
			},
			[1001] = {
				disablePassive = 1,
				excludeTarget = 1,
				boxId = 3311451,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331140011,
						331141005
					}
				}
			}
		}
	},
	[3311452] = {
		actTime = 64,
		bhEvent = "skill.3311452",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140012
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3311452,
				unitDelay = 0.15,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331140013,
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 3311406
				},
				hitCue = {
					cueList = {
						331140014,
						331141006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311402
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311403
				}
			}
		}
	},
	[3311453] = {
		actTime = 60,
		bhEvent = "skill.3311453",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140016,
						331141007
					}
				},
				hitCue = {
					cueList = {
						331140017
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3311453,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311403
					}
				}
			}
		}
	},
	[3311461] = {
		actTime = 50,
		bhEvent = "skill.3311461",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140010,
						331141004
					}
				}
			},
			[3] = {
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331140011,
						331141005
					}
				}
			},
			{
				boxId = 3311461,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311422
				}
			}
		}
	},
	[3311462] = {
		actTime = 64,
		bhEvent = "skill.3311462",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140012
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3311462,
				unitDelay = 0.15,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331140013,
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 3311406
				},
				hitCue = {
					cueList = {
						331140014,
						331141006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311422
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311423
				}
			}
		}
	},
	[3311463] = {
		actTime = 60,
		bhEvent = "skill.3311463",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331140016,
						331141007
					}
				},
				hitCue = {
					cueList = {
						331140017
					}
				}
			},
			{
				boxId = 3311463,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311423
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
