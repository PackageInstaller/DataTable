-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14014.lua

local Data = {
	cueFile = "14014",
	[1401409] = {
		bhEvent = "skill.1401409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140140001,
						140141001
					}
				}
			},
			{
				unitDelay = 0.16,
				boxId = 1401409,
				flyCueId = 140140002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140140003,
						140141002
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				subEventId = 1002,
				subEventSkill = 1401409,
				eventCondition = "1,2,1401401",
				targetArea = 2,
				state = {}
			},
			[1002] = {
				subEventId = 1003,
				subEventSkill = 1401409,
				boxId = 1401411,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1003] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {}
			},
			[1004] = {
				eventCondition = "1,2,1401411",
				boxId = 1401420,
				targetChoose = 7,
				eventType = 1,
				state = {}
			}
		}
	},
	[1401410] = {
		bhEvent = "skill.1401410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140140004,
						140141003
					}
				}
			},
			{
				unitDelay = 0.16,
				boxId = 1401412,
				flyCueId = 140140002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140140005,
						140141004
					}
				}
			}
		}
	},
	[1401429] = {
		actTime = 50,
		bhEvent = "skill.1401429",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140140006,
						140141005
					}
				}
			},
			{
				state = {
					duration = -999,
					stateId = 1401401
				}
			},
			[1001] = {
				state = {
					duration = -999,
					stateId = 1401402
				}
			},
			[1002] = {
				delay = 0.1,
				boxType = 1,
				boxId = 1401410,
				eventType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401402
					}
				},
				hitCue = {
					cueList = {
						140140008
					}
				}
			},
			[1003] = {
				subEventId = 1004,
				subEventSkill = 1401429,
				eventProbId = 1401401,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1401402
					}
				}
			},
			[1004] = {
				targetChoose = 3,
				state = {
					duration = -999,
					stateId = 1401401
				},
				hitCue = {
					cueList = {
						140140001
					}
				}
			},
			[1005] = {
				targetChoose = 7,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401401,
						1401411
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1401459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 90,
		bhEvent = "skill.1401459",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						140140009,
						140140010
					}
				}
			},
			[11] = {
				boxType = 1,
				unitDelay = 0.18,
				boxId = 1401459,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1401459,
						subEventId = 1001
					},
					[3] = {
						subEventSkill = 1401459,
						subEventId = 1001
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[23] = {
				boxType = 1,
				unitDelay = 0.18,
				flyCueId = 140140013,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140140015,
						140145001,
						140141007
					}
				}
			},
			[21] = {
				unitDelay = 0.18,
				flyCueId = 140140011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						140140014
					}
				}
			},
			[22] = {
				boxType = 1,
				unitDelay = 0.18,
				flyCueId = 140140012,
				state = {}
			},
			[1001] = {
				subEventId = 1002,
				eventCondition = "1,2,1401401",
				subEventSkill = 1401459,
				targetChoose = 7,
				state = {}
			},
			[12] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1401459
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 4
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				delay = 0.7,
				boxType = 1,
				boxId = 1401460,
				eventType = 1,
				state = {}
			},
			[1003] = {
				subEventId = 1004,
				eventCondition = "1,2,1401401",
				subEventSkill = 1401459,
				targetChoose = 7,
				state = {}
			},
			[1004] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1401461
				}
			},
			[1005] = {
				state = {}
			},
			[1006] = {
				subEventId = 1004,
				eventCondition = "1,2,1401411",
				subEventSkill = 1401459,
				targetChoose = 7,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140148001,
				140141006
			}
		}
	},
	[1401460] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 90,
		bhEvent = "skill.1401460",
		atkEvents = {
			[100] = {
				flyCueId = 140140011,
				unitDelay = 0.18,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						140140009,
						140140010
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140140015,
						140145001,
						140141007
					}
				}
			},
			[21] = {
				unitDelay = 0.18,
				flyCueId = 140140011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						140140014
					}
				}
			},
			[22] = {
				boxType = 1,
				unitDelay = 0.18,
				flyCueId = 140140012,
				state = {}
			},
			[23] = {
				boxType = 1,
				unitDelay = 0.18,
				flyCueId = 140140013,
				state = {}
			},
			[11] = {
				boxType = 1,
				unitDelay = 0.18,
				boxId = 1401459,
				eventType = 1,
				state = {}
			},
			[12] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1401451
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 4
					},
					[3] = {
						targetChoose = 4
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				140148001,
				140141006
			}
		}
	},
	[1401430] = {
		actTime = 50,
		bhEvent = "skill.1401430",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140140006,
						140141005
					}
				}
			},
			{
				state = {
					duration = -999,
					stateId = 1401411
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401412
				}
			},
			[1001] = {
				targetArea = 1,
				eventProbId = 1401411,
				state = {
					duration = 0.2,
					stateId = 1401413
				}
			},
			[1002] = {
				boxId = 1401420,
				eventCondition = "1,2,1401411",
				eventType = 1,
				state = {}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1401452
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				targetArea = 2,
				targetChoose = 19,
				state = {
					duration = -999,
					stateId = 1401411
				}
			},
			[1005] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1401462
				}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791471
				}
			},
			[1007] = {
				boxId = 1401421,
				targetArea = 1,
				eventProbId = 1401412,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1008] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401465
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
