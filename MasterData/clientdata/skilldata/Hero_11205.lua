-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11205.lua

local Data = {
	cueFile = "11205",
	[1120509] = {
		bhEvent = "skill.1120509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112050001,
						112051001
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 1120509,
				boxId = 1120509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112050003
					}
				}
			},
			[3] = {
				eventCondition = "1,1,1120516",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120519
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120519
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120520
				}
			},
			{
				excludeTarget = 1,
				eventCondition = "1,1,1120512",
				boxId = 1120509,
				targetChoose = 4,
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
	[1120510] = {
		bhEvent = "skill.1120510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112050002,
						112051002
					}
				}
			},
			[3] = {
				eventCondition = "1,1,1120516",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120519
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120519
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 1120510,
				boxId = 1120509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112050003
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120520
				}
			},
			{
				excludeTarget = 1,
				eventCondition = "1,1,1120512",
				boxId = 1120509,
				targetChoose = 4,
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
	[1120529] = {
		skillTarget = 1,
		bhEvent = "skill.1120529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112050004,
						112051003
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				subEventId = 1002,
				subEventSkill = 1120529,
				eventCondition = "1,2,1200010",
				targetArea = 1,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120507
				}
			},
			[1003] = {
				targetChoose = 10,
				subEventId = 1004,
				subEventSkill = 1120529,
				eventCondition = "1,2,1400010",
				targetArea = 1,
				state = {}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120508
				}
			},
			[1005] = {
				targetChoose = 10,
				subEventId = 1006,
				subEventSkill = 1120529,
				eventCondition = "1,2,1300010",
				targetArea = 1,
				state = {}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120509
				}
			},
			[1007] = {
				targetChoose = 10,
				subEventId = 1008,
				subEventSkill = 1120529,
				eventCondition = "1,2,1500010",
				targetArea = 1,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120511
				}
			},
			[1009] = {
				subEventType = 1,
				subEventSkill = 1120529,
				targetArea = 3,
				subRandomNum = 1,
				subRandomEvents = "1010,1011,1012,1013",
				state = {}
			},
			[1010] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120507
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120508
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120509
				}
			},
			[1013] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120511
				}
			},
			[1014] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1120505
				}
			},
			[1015] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1120506
				}
			},
			[1016] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120512
				}
			},
			[1017] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120513
				}
			},
			[1018] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120514
				}
			},
			[1019] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120515
				}
			},
			[2] = {
				excludeTarget = 1,
				eventCondition = "1,1,1120512",
				boxId = 1120529,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			{
				boxId = 1120529,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112050005
					}
				}
			},
			[1022] = {
				boxId = 1120561,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1023] = {
				excludeTarget = 1,
				eventCondition = "7,1,1,1120512,0,1,1120516,0",
				boxId = 1120561,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[3] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120507,
						1120508,
						1120509,
						1120511
					}
				}
			},
			[4] = {
				boxId = 1120530,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1024] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120533
				}
			},
			[1025] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120534
				}
			},
			[1026] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1120535
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {
							duration = 8,
							stateId = 1120535
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[1027] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120523
					}
				}
			},
			[1028] = {
				subEventType = 1,
				delay = 0.2,
				boxType = 1,
				boxId = 1120529,
				subEventId = 1029,
				eventType = 1,
				subEventSkill = 1120529,
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						112050020
					}
				},
				hitCue = {
					cueList = {
						112050021
					}
				}
			},
			[1029] = {
				subEventType = 1,
				subEventSkill = 1120529,
				boxId = 1120530,
				targetArea = 3,
				subEventId = 1030,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1030] = {
				subEventId = 1031,
				subEventType = 1,
				subEventSkill = 1120529,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120507,
						1120508,
						1120509,
						1120511
					}
				}
			},
			[1031] = {
				excludeTarget = 1,
				eventCondition = "1,1,1120512",
				boxId = 1120529,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[1032] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21120511
				}
			},
			[1033] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 21120521
				}
			}
		}
	},
	[1120559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 55,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 90,
		bhEvent = "skill.1120559",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112050015
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1120517
				}
			},
			{
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						112050017,
						112050018
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1120516
						}
					},
					[3] = {
						state = {
							duration = 6,
							stateId = 1120516
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
			{
				targetChoose = 3,
				targetArea = 1,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1120518
						}
					},
					[4] = {
						state = {
							duration = 9
						}
					},
					[5] = {
						state = {
							duration = 9
						}
					},
					[6] = {
						state = {
							duration = 9
						}
					}
				}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1120559,
				boxId = 1120559,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				boxId = 1120560,
				targetArea = 3,
				state = {}
			},
			{
				targetChoose = 3,
				subEventType = 1,
				subEventSkill = 1120559,
				subEventId = 1007,
				targetArea = 1,
				eventCondition = "1,1,1120513",
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120521
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120524
				}
			},
			{
				targetChoose = 3,
				subEventType = 1,
				subEventSkill = 1120559,
				subEventId = 1009,
				targetArea = 1,
				eventCondition = "1,1,1120514",
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120522
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120525
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120526
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120527
				}
			},
			[1007] = {
				targetChoose = 3,
				subEventType = 1,
				subEventSkill = 1120559,
				subEventId = 1008,
				targetArea = 3,
				eventCondition = "1,1,1120524",
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120521
				}
			},
			[1008] = {
				targetChoose = 3,
				subEventType = 1,
				eventCondition = "1,1,1120525",
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120521
				}
			},
			[1009] = {
				targetChoose = 3,
				subEventType = 1,
				subEventSkill = 1120559,
				subEventId = 1010,
				targetArea = 3,
				eventCondition = "1,1,1120526",
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120522
				}
			},
			[1010] = {
				targetChoose = 3,
				subEventType = 1,
				eventCondition = "1,1,1120527",
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1120522
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						112050019,
						112055001,
						112051005
					}
				}
			},
			[1011] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = 5,
					stateId = 1120530
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {
							duration = 8,
							stateId = 1120530
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[1012] = {
				excludeTarget = 1,
				targetChoose = 3,
				state = {
					duration = 4,
					stateId = 1000004
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000004
						}
					},
					[3] = {
						state = {
							duration = 6,
							stateId = 1000004
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				112058001,
				112051004
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
