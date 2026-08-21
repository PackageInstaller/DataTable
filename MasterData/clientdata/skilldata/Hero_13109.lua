-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13109.lua

local Data = {
	cueFile = "13109",
	[1310909] = {
		bhEvent = "skill.1310909",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131090001,
						131091001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1310909,
				flyCueId = 131090002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131090003,
						131091002
					}
				}
			},
			{
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1310910] = {
		bhEvent = "skill.1310910",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131090004,
						131091003
					}
				}
			},
			{
				boxId = 1310909,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131090005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1310904
				}
			},
			{
				state = {}
			}
		}
	},
	[1310929] = {
		bhEvent = "skill.1310929",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350350
				}
			},
			[1002] = {
				state = {
					duration = -999,
					stateId = 8350351
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350352
				}
			},
			[1004] = {
				subEventId = 1005,
				targetChoose = 7,
				subEventSkill = 1310929,
				state = {}
			},
			[1005] = {
				subEventId = 1006,
				eventCondition = "1,2,1310901",
				subEventSkill = 1310929,
				state = {}
			},
			[1006] = {
				boxId = 1310931,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1007] = {
				boxType = 1,
				subEventId = 1008,
				subEventSkill = 1310929,
				delay = 0.5,
				state = {
					duration = -999,
					stateId = 1310901
				}
			},
			[1008] = {
				boxId = 1310931,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1009] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 8791581
				}
			},
			[1010] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 8791582
				}
			}
		}
	},
	[1310959] = {
		hideEffect = 1,
		actTime = 90,
		videoActTime = 55,
		bhEvent = "skill.1310959",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131090008,
						131090009,
						131090010
					}
				}
			},
			{
				delay = 0.4,
				boxId = 1310959,
				flyCueId = 131090011,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131090012
					}
				}
			},
			{
				subEventId = 1003,
				subEventSkill = 1310959,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1001] = {
				subEventType = 1,
				boxId = 1310929,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1310901
				},
				hitCue = {
					cueList = {
						131090006
					}
				}
			},
			[1002] = {
				subEventId = 1004,
				targetChoose = 23,
				subEventSkill = 1310959,
				state = {}
			},
			[1003] = {
				randomTargetNumber = 1,
				subEventType = 1,
				boxId = 1310959,
				boxType = 1,
				filterChuyin = 1,
				excludeTarget = 1,
				eventType = 1,
				delay = 0.4,
				flyCueId = 131090011,
				targetChoose = 8,
				state = {},
				hitCue = {
					cueList = {
						131090012
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				filterChuyin = 1,
				boxId = 1310929,
				targetChoose = 8,
				excludeTarget = 1,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1310901
				},
				hitCue = {
					cueList = {
						131090006
					}
				}
			},
			[1005] = {
				filterChuyin = 1,
				subEventId = 1006,
				subEventSkill = 1310959,
				targetChoose = 7,
				state = {}
			},
			[1006] = {
				subEventId = 1007,
				eventCondition = "1,2,1310901",
				subEventSkill = 1310959,
				boxId = 1310929,
				eventType = 1,
				state = {
					duration = 6,
					stateId = 1310903
				}
			},
			[1007] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310901
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 8,
							stateId = 1310951
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1310951
						}
					},
					[4] = {
						state = {
							duration = 8
						}
					},
					[5] = {
						state = {
							duration = 8
						}
					},
					[6] = {
						state = {
							duration = 8
						}
					}
				}
			},
			[1008] = {
				filterChuyin = 1,
				eventCondition = "1,2,1310901",
				boxId = 1310910,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1009] = {
				boxId = 1310929,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1310901
				},
				hitCue = {
					cueList = {
						131090006
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131090013,
						131095001,
						131091005
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				131098001,
				131091004
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
