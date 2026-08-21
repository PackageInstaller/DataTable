-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13108.lua

local Data = {
	cueFile = "13108",
	[1310809] = {
		bhEvent = "skill.1310809",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131080001,
						131081001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1310809,
				flyCueId = 131080003,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1310802
				},
				hitCue = {
					cueList = {
						131080005,
						131081002
					}
				}
			},
			{
				eventType = 1,
				boxId = 1310810,
				unitDelay = 0.2,
				boxType = 1,
				eventCondition = "1,1,1310801",
				eventProbId = 1310801,
				state = {},
				hitCue = {
					cueList = {
						131080006
					}
				}
			},
			{
				state = {}
			},
			[1001] = {
				boxId = 1310860,
				subEventSkill = 1310809,
				unitDelay = 0.15,
				boxType = 1,
				targetChoose = 23,
				subEventId = 1002,
				eventType = 1,
				state = {}
			},
			[1002] = {
				randomTargetNumber = 1,
				randomRule = 1,
				eventCondition = "1,1,21310830",
				boxId = 1310860,
				targetChoose = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[1310829] = {
		bhEvent = "skill.1310829",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131080007,
						131080008,
						131081004
					}
				}
			},
			{
				delay = 0.3,
				boxId = 1310809,
				flyCueId = 131080009,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1310802
				},
				hitCue = {
					cueList = {
						131080010,
						131081005
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 1,
						controlAniName = "freeze"
					},
					[4] = {
						controlTime = 1,
						controlAniName = "freeze"
					},
					[5] = {
						controlTime = 1,
						controlAniName = "freeze"
					},
					[6] = {
						controlTime = 1,
						controlAniName = "freeze"
					}
				}
			},
			{
				delay = 0.3,
				boxType = 1,
				boxId = 1310810,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1310803
						}
					},
					[4] = {
						state = {
							duration = 6,
							stateId = 1310803
						}
					},
					[5] = {
						state = {
							duration = 6,
							stateId = 1310803
						}
					},
					[6] = {
						state = {
							duration = 6,
							stateId = 1310803
						}
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1310811
				}
			},
			[103] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1310812
				}
			},
			[102] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310813
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310815
				}
			},
			[1002] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310816
				}
			},
			[1003] = {
				boxId = 1310811,
				targetChoose = 23,
				state = {
					duration = 1,
					stateId = 1310817
				}
			},
			[1004] = {
				subEventId = 1003,
				eventCondition = "1,2,1310817,1",
				subEventSkill = 1310829,
				targetChoose = 23,
				state = {}
			}
		}
	},
	[1310859] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 110,
		bhEvent = "skill.1310859",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131080011,
						131080012,
						131080013,
						131080014
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1310852
				}
			},
			[102] = {
				manaNotShow = 1,
				targetArea = 2,
				addManaNumber = -29,
				state = {}
			},
			[103] = {
				eventCondition = "1,1,1310852",
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -30,
				state = {
					duration = 3,
					stateId = 1310853
				}
			},
			[104] = {
				eventCondition = "1,1,1310852",
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -30,
				state = {
					duration = 3,
					stateId = 1310853
				}
			},
			[105] = {
				eventCondition = "1,1,1310852",
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -30,
				state = {
					duration = 3,
					stateId = 1310853
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1310859,
				flyCueId = 131080015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131080016,
						131081008
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 2,
							stateId = 1310855
						}
					},
					[3] = {
						state = {
							duration = 2,
							stateId = 1310855
						}
					},
					[4] = {
						state = {
							duration = 2
						}
					},
					[5] = {
						state = {
							duration = 2
						}
					},
					[6] = {
						state = {
							duration = 2
						}
					}
				}
			},
			[99] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310852,
						1310853,
						1310855
					}
				}
			},
			[1001] = {
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310852
					}
				}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310854
				}
			},
			[1004] = {
				eventCondition = "1,1,1310856,1",
				targetChoose = 23,
				state = {
					duration = 3,
					stateId = 1310802
				}
			},
			[1005] = {
				eventCondition = "1,1,1310856,1",
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1310856
				}
			},
			[106] = {
				eventCondition = "1,1,1310815",
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[4] = {
				state = {}
			},
			{
				state = {}
			},
			[90] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131080017,
						131085001,
						131085002,
						131081007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				131088001,
				131081006
			}
		}
	},
	[1310810] = {
		bhEvent = "skill.1310810",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131080002,
						131081003
					}
				}
			},
			{
				unitDelay = 0.18,
				boxId = 1310809,
				flyCueId = 131080004,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1310802
				},
				hitCue = {
					cueList = {
						131080005,
						131081002
					}
				}
			},
			{
				eventType = 1,
				boxId = 1310810,
				unitDelay = 0.18,
				boxType = 1,
				eventCondition = "1,1,1310801",
				eventProbId = 1310801,
				state = {},
				hitCue = {
					cueList = {
						131080006
					}
				}
			},
			{
				state = {}
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
