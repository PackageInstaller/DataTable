-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13104.lua

local Data = {
	cueFile = "13104",
	[1310409] = {
		bhEvent = "skill.1310409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131040001,
						131041001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxType = 1,
				flyCueId = 131040002,
				boxId = 1310409,
				state = {},
				hitCue = {
					cueList = {
						131040003,
						131041002
					}
				}
			}
		}
	},
	[1310429] = {
		bhEvent = "skill.1310429",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131040007,
						131041005
					}
				}
			},
			{
				targetChoose = 12,
				state = {
					duration = -999,
					stateId = 1310401
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310402
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1310403
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310404
				}
			},
			[1004] = {
				delay = 0.6,
				boxType = 1,
				targetChoose = 3,
				state = {
					duration = -999,
					stateId = 1310401
				},
				hitCue = {
					cueList = {
						131040008
					}
				}
			},
			{
				recordSkillTargets = 1,
				state = {},
				hitCue = {
					cueList = {
						131040008
					}
				}
			},
			[1005] = {
				state = {
					duration = -999,
					stateId = 8350190
				}
			},
			[1006] = {
				addManaNumber = 1,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 2
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1007] = {
				subEventId = 1009,
				subEventSkill = 1310429,
				targetChoose = 7,
				excludeTarget = 1,
				state = {}
			},
			[1008] = {
				stunTime = 1,
				boxId = 1310431,
				targetChoose = 3,
				excludeTarget = 1,
				state = {}
			},
			[1009] = {
				boxId = 1310432,
				eventCondition = "1,2,1310401",
				state = {}
			},
			[1010] = {
				targetArea = 3,
				state = {
					stateOperation = 4,
					stateId = 1310402,
					chooseStateMode = 2,
					delLayer = 1,
					chooseStateIds = {
						1310402
					}
				}
			},
			[1011] = {
				randomTargetNumber = 1,
				targetChoose = 7,
				randomRule = 1,
				filterChuyin = 1,
				state = {
					duration = -999,
					stateId = 1310401
				}
			}
		}
	},
	[1310459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 95,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 92,
		bhEvent = "skill.1310459",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						131040013,
						131040014,
						131040015
					}
				}
			},
			{
				filterChuyin = 1,
				boxId = 1310459,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1310405
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1310406
				}
			},
			[90] = {
				targetChoose = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310405
					}
				}
			},
			[91] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310409,
						1310406
					}
				}
			},
			[92] = {
				eventCondition = "1,1,1310407,1",
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1310408
						}
					},
					[4] = {
						state = {
							duration = 2,
							stateId = 1310408
						}
					},
					[5] = {
						state = {
							duration = 2,
							stateId = 1310408
						}
					},
					[6] = {
						state = {
							duration = 2,
							stateId = 1310408
						}
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131040018,
						131045001,
						131041009
					}
				}
			},
			[1001] = {
				state = {
					duration = 3,
					stateId = 1310451,
					chooseStateMode = 2,
					chooseStateIds = {
						1310405
					}
				}
			},
			[1002] = {
				delay = 0.2,
				subEventSkill = 1310459,
				boxId = 1310460,
				subEventId = 1003,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131040017
					}
				}
			},
			[1003] = {
				delay = 0.5,
				boxType = 1,
				boxId = 1310461,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131040017
					}
				}
			},
			[1004] = {
				eventType = 1,
				delay = 0.2,
				subEventSkill = 1310459,
				boxId = 1310460,
				subEventId = 1005,
				eventProbId = 1310401,
				state = {},
				hitCue = {
					cueList = {
						131040017
					}
				}
			},
			[1005] = {
				eventType = 1,
				delay = 0.5,
				boxId = 1310461,
				boxType = 1,
				eventProbId = 1310401,
				state = {},
				hitCue = {
					cueList = {
						131040017
					}
				}
			},
			{
				subEventId = 1002,
				eventCondition = "1,2,1310451",
				subEventSkill = 1310459,
				targetChoose = 3,
				state = {}
			},
			[11] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				subEventId = 1004,
				eventCondition = "1,2,1310451,1",
				subEventSkill = 1310459,
				targetChoose = 3,
				state = {}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						131040016
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				131048001,
				131041008
			}
		}
	},
	[1310460] = {
		hideEffect = 1,
		actTime = 92,
		hideTime = 1,
		hideEvent = 100,
		bhEvent = "skill.1310460",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						131040013,
						131040014,
						131040015
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[4] = {},
					[5] = {},
					[6] = {
						state = {
							duration = 3
						}
					}
				}
			},
			{
				boxId = 1310462,
				targetChoose = 3,
				filterChuyin = 1,
				state = {}
			},
			[92] = {
				state = {}
			},
			[11] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131040018,
						131045001,
						131041009
					}
				}
			},
			{
				state = {}
			},
			{
				state = {}
			},
			[90] = {
				state = {}
			},
			[91] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310409
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						131040016
					}
				}
			}
		}
	},
	[1310410] = {
		bhEvent = "skill.1310410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131040004,
						131040005,
						131041003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1310409,
				flyCueId = 131040006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131040003,
						131041004
					}
				}
			}
		}
	},
	[1310430] = {
		bhEvent = "skill.1310430",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131040009,
						131041006
					}
				}
			},
			{
				stunTime = 1,
				boxId = 1310429,
				state = {},
				hitCue = {
					cueList = {
						131040012
					}
				},
				baseCue = {
					cueList = {
						131040011
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -9
					},
					[3] = {
						addManaNumber = -9
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				stunTime = 1,
				boxId = 1310430,
				targetChoose = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						131040012
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131040010
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 9
					},
					[3] = {
						addManaNumber = 9
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1310461] = {
		hideEffect = 1,
		actTime = 92,
		hideTime = 1,
		hideEvent = 100,
		bhEvent = "skill.1310460",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {}
			},
			[10] = {
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1310409
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131040018,
						131045001
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						131040016
					}
				}
			},
			{
				boxId = 1310462,
				targetChoose = 3,
				state = {}
			},
			{
				state = {}
			},
			[91] = {
				targetArea = 2,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310409
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
