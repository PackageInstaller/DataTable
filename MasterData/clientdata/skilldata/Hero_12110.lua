-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12110.lua

local Data = {
	cueFile = "12110",
	[1211009] = {
		bhEvent = "skill.1211009",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121100001,
						121101001
					}
				}
			},
			{
				boxId = 1211009,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121100003
					}
				}
			}
		}
	},
	[1211010] = {
		bhEvent = "skill.1211010",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121100002,
						121101002
					}
				}
			},
			{
				boxId = 1211009,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121100003
					}
				}
			}
		}
	},
	[1211029] = {
		bhEvent = "skill.1211029",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121100004
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1211002
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1211002
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				boxId = 1211020,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			{
				subEventType = 1,
				subEventSkill = 1211029,
				boxId = 1211021,
				subEventId = 1014,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121103001,
						121101006
					}
				}
			},
			[5] = {
				boxId = 1211022,
				eventCondition = "2,2,1,3,5000,2",
				eventType = 1,
				state = {}
			},
			[1001] = {
				delay = 0.1,
				boxType = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211003
					}
				}
			},
			[3] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1211001
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1211001
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				delay = 0.1,
				targetArea = 3,
				boxType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211002
					}
				}
			},
			[4] = {
				eventCondition = "1,1,1211002",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1211003
				}
			},
			[6] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211002,
						1211001
					}
				}
			},
			[1003] = {
				boxType = 1,
				delay = 0.1,
				boxId = 1211024,
				targetArea = 3,
				state = {}
			},
			[1004] = {
				boxType = 1,
				delay = 0.2,
				boxId = 1211023,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				subEventId = 1006,
				subEventSkill = 1211029,
				boxId = 1211025,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 30
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211004
					}
				}
			},
			[1007] = {
				subEventId = 1008,
				targetArea = 3,
				subEventSkill = 1211029,
				state = {
					duration = -999,
					stateId = 8350401
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350402
					}
				}
			},
			[1009] = {
				subEventId = 1010,
				targetArea = 3,
				subEventSkill = 1211029,
				state = {
					duration = -999,
					stateId = 8350402
				}
			},
			[1010] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350401
					}
				}
			},
			[1011] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121101003
					}
				},
				hitCue = {
					cueList = {
						121100005
					}
				}
			},
			[1012] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121101005
					}
				},
				hitCue = {
					cueList = {
						121100006
					}
				}
			},
			[1013] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121101007
					}
				},
				hitCue = {
					cueList = {
						121100007
					}
				}
			},
			[12] = {
				subEventSkill = 1211029,
				targetArea = 3,
				subRandomNum = 1,
				subRandomEvents = "1011,1012,1013",
				state = {}
			},
			[1014] = {
				eventType = 1,
				eventCondition = "1,1,8791660",
				boxId = 1211021,
				eventProbId = 1211001,
				state = {},
				hitCue = {
					cueList = {
						121103001
					}
				}
			}
		}
	},
	[1211059] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 15,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 102,
		bhEvent = "skill.1211059",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121100008,
						121100009,
						121100010
					}
				}
			},
			[1001] = {
				delay = 0.1,
				boxType = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211052
					}
				}
			},
			{
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1211060,
						eventCondition = "2,2,1,3,5000,2"
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
						boxId = 1211062,
						eventCondition = "2,2,2,3,5000,2"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				boxId = 1211061,
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0,
						0
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1211052
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1211052
						}
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
					[2] = {
						state = {
							duration = 3,
							stateId = 1211051
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1211051
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				boxId = 1211059,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121103002,
						121101011
					}
				}
			},
			{
				eventCondition = "1,1,1211052",
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1211053
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1211051,
						1211052
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121105001,
						121100011,
						121101010
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				121108001,
				121101009
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
