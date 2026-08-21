-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12011.lua

local Data = {
	cueFile = "12011",
	[1201109] = {
		bhEvent = "skill.1201109",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120110001,
						120111001
					}
				}
			},
			{
				boxId = 1201109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1001] = {
				stunTime = 1,
				state = {}
			}
		}
	},
	[1201110] = {
		bhEvent = "skill.1201110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120110002,
						120111002
					}
				}
			},
			{
				boxId = 1201109,
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
	[1201129] = {
		bhEvent = "skill.1201129",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120110003,
						120111003
					}
				}
			},
			{
				boxId = 1201129,
				delay = 0.15,
				boxType = 1,
				subEventSkill = 1201129,
				subEventId = 1001,
				eventType = 1,
				flyCueId = 120110004,
				state = {},
				atkCue = {
					cueList = {
						120116001
					}
				},
				hitCue = {
					cueList = {
						120110005,
						120111004
					}
				}
			},
			[1001] = {
				boxId = 1201129,
				delay = 0.15,
				subEventSkill = 1201129,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				flyCueId = 120110004,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						120110005,
						120111004
					}
				}
			},
			[1002] = {
				boxId = 1201129,
				delay = 0.15,
				boxType = 1,
				eventType = 1,
				flyCueId = 120110004,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						120110005,
						120111004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventSkill = 1201129,
						subEventId = 1003
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				delay = 0.15,
				boxId = 1201129,
				flyCueId = 120110004,
				boxType = 1,
				baseToTarget = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120110005,
						120111004
					}
				}
			},
			[1004] = {
				boxId = 1201131,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.2,
				boxId = 1201130,
				eventType = 1,
				state = {}
			},
			[1006] = {
				targetChoose = 23,
				stunTime = 1,
				state = {}
			}
		}
	},
	[1201159] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 72,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 62,
		bhEvent = "skill.1201159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120110006,
						120110007,
						120110010,
						120110011,
						120110012,
						120115002
					}
				}
			},
			{
				stunTime = 1,
				boxId = 1201159,
				hitedAnim = "Hit",
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						120113001
					}
				},
				hitCue = {
					cueList = {
						120110008,
						10006003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = -9
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120115001,
						120110009,
						120111006
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1201102
					}
				}
			},
			[1002] = {
				addManaNumber = -5,
				targetChoose = 23,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120118001,
				120111005
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
