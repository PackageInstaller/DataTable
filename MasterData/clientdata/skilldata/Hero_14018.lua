-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14018.lua

local Data = {
	cueFile = "14018",
	[1401809] = {
		bhEvent = "skill.1401809",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180001,
						140181001
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1401809,
				flyCueId = 140180004,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140180003,
						140181002
					}
				}
			}
		}
	},
	[1401810] = {
		bhEvent = "skill.1401810",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180002,
						140181003
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1401809,
				flyCueId = 140180015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140180003,
						140181002
					}
				}
			}
		}
	},
	[1401829] = {
		bhEvent = "skill.1401829",
		atkEvents = {
			{
				subEventId = 1006,
				subEventSkill = 1401829,
				boxId = 1401829,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140181005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0,
						0,
						0
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 8.1,
					stateId = 1401811
				}
			},
			[1002] = {
				targetChoose = 7,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1401804
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401802
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401802,
						1401806,
						1401812,
						1401814
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401806
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180005,
						140181004
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140180006
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				eventCondition = "1,1,1401806",
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1401831
					},
					[3] = {
						boxId = 1401831
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1007] = {
				targetArea = 3,
				state = {}
			},
			[1008] = {
				boxId = 1401833,
				delay = 0.15,
				subEventSkill = 1401829,
				boxType = 1,
				subEventId = 1009,
				eventType = 1,
				flyCueId = 140180004,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						140180006
					}
				}
			},
			[1009] = {
				randomTargetNumber = 1,
				delay = 0.1,
				boxId = 1401833,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 140180004,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						140180006
					}
				}
			},
			[1010] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 16,
					stateId = 8791461
				}
			},
			[1011] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				boxId = 1401810,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1012] = {
				boxId = 1401834,
				targetChoose = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[1401830] = {
		bhEvent = "skill.1401830",
		atkEvents = {
			{
				subEventId = 1001,
				subEventSkill = 1401830,
				boxId = 1401830,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140181007
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0,
						0,
						0
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180007,
						140181006
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140180008
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				eventCondition = "1,1,1401806",
				boxId = 1401832,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401812
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401814
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1401803
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1401805
				}
			}
		}
	},
	[1401859] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 28,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 92,
		bhEvent = "skill.1401859",
		atkEvents = {
			{
				boxId = 1401829,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140180013
					}
				}
			},
			{
				boxId = 1401859,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140180014,
						140183001,
						140181009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401802,
						1401806,
						1401811,
						1401812,
						1401813,
						1401814
					}
				}
			},
			{
				subEventId = 1001,
				targetArea = 3,
				subEventSkill = 1401859,
				state = {
					duration = 8.1,
					stateId = 1401813
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401808
						}
					},
					[4] = {
						state = {
							duration = 5,
							stateId = 1401808
						}
					},
					[5] = {
						state = {
							duration = 5,
							stateId = 1401808
						}
					},
					[6] = {
						state = {
							duration = 5,
							stateId = 1401808
						}
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1401807
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401807
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180011,
						140180012,
						140180016
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140185001,
						140180017,
						140181008
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				140188001,
				140181010
			}
		}
	},
	[1401860] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 28,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 92,
		bhEvent = "skill.1401860",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180011,
						140180012,
						140180016
					}
				}
			},
			[2] = {
				state = {},
				hitCue = {
					cueList = {
						140180014,
						140185001,
						140181009
					}
				}
			},
			{
				boxId = 1401860,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140180013
					}
				}
			},
			[13] = {
				state = {},
				hitCue = {
					cueList = {
						140185001,
						140180017,
						140181008
					}
				}
			},
			[3] = {
				targetArea = 3,
				boxId = 1401861,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401845
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				boxId = 1401862,
				targetChoose = 3,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140188001,
				140181010
			}
		}
	},
	[1401840] = {
		bhEvent = "skill.1401840",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140181004,
						140180005
					}
				}
			},
			[2] = {
				subEventId = 1003,
				subEventSkill = 1401840,
				boxId = 1401840,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140181005
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401842
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401840
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1401843
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401843
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401840
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140180006
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				boxId = 1401841,
				targetChoose = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[1401841] = {
		bhEvent = "skill.1401841",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140180007,
						140181006
					}
				}
			},
			[2] = {
				subEventId = 1001,
				subEventSkill = 1401841,
				boxId = 1401842,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140181007
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401840,
						1401844
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1401843
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401843
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140180008
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
