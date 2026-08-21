-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12104.lua

local Data = {
	cueFile = "12104",
	[1210409] = {
		bhEvent = "skill.1210409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121040011,
						121041001
					}
				}
			},
			[0] = {
				boxId = 1210409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121040013
					}
				}
			},
			{
				eventCondition = "1,2,1210401,1",
				state = {
					duration = 0.1,
					stateId = 1210402
				}
			}
		}
	},
	[1210410] = {
		bhEvent = "skill.1210410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121040012,
						121041002
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxId = 1210410,
				flyCueId = 121040006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121040014,
						121041003
					}
				}
			},
			{
				eventCondition = "1,2,1210401,1",
				state = {
					duration = 0.1,
					stateId = 1210402
				}
			}
		}
	},
	[1210429] = {
		bhEvent = "skill.1210429",
		atkEvents = {
			[100] = {
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0,
						0,
						0
					}
				}
			},
			[1001] = {
				stunTime = 1,
				eventType = 1,
				state = {
					duration = 0.1,
					stateId = 1210403
				},
				atkCue = {
					cueList = {
						121041004
					}
				},
				baseCue = {
					cueList = {
						121040010
					}
				}
			},
			[1002] = {
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1210401
				}
			},
			[1003] = {
				boxType = 1,
				delay = 1,
				boxId = 1210431,
				targetArea = 3,
				state = {
					chooseStateMode = 2
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1004] = {
				subEventId = 1005,
				targetArea = 3,
				subEventSkill = 1210429,
				state = {
					duration = -999,
					stateId = 1210421
				}
			},
			[1005] = {
				subEventId = 1006,
				targetArea = 3,
				subEventSkill = 1210429,
				state = {
					duration = -999,
					stateId = 1210422
				}
			},
			[1006] = {
				subEventId = 1007,
				targetArea = 3,
				subEventSkill = 1210429,
				state = {
					duration = -999,
					stateId = 1210423
				}
			},
			[1007] = {
				subEventId = 1008,
				targetArea = 3,
				subEventSkill = 1210429,
				state = {
					duration = -999,
					stateId = 1210424
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210425
				}
			},
			[1009] = {
				delay = 0.3,
				boxType = 1,
				boxId = 1210429,
				state = {},
				hitCue = {
					cueList = {
						121040003
					}
				}
			},
			[1010] = {
				boxId = 1210430,
				delay = 1,
				state = {},
				hitCue = {
					cueList = {
						121040004
					}
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1210426
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210427
				}
			},
			[0] = {
				state = {}
			},
			[1013] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1210407
				}
			},
			[1014] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1015] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210408
				}
			},
			[1016] = {
				eventCondition = "1,1,1210408,1",
				boxId = 1210430,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						121040004
					}
				}
			}
		}
	},
	[1210459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 68,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 109,
		bhEvent = "skill.1210459",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						121040009
					}
				}
			},
			[0] = {
				filterChuyin = 1,
				subEventId = 1001,
				subEventSkill = 1210459,
				boxId = 1210459,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[2] = {
				filterChuyin = 1,
				targetChoose = 3,
				eventCondition = "1,1,1210427",
				state = {
					duration = 0.1,
					stateId = 1210405
				}
			},
			{
				state = {},
				hitCue = {
					cueList = {
						121040005
					}
				}
			},
			[13] = {
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1210430
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1210430
						}
					},
					[5] = {
						state = {
							duration = 8,
							stateId = 1210430
						}
					},
					[6] = {
						state = {
							duration = 8,
							stateId = 1210430
						}
					}
				}
			},
			[99] = {
				state = {}
			},
			[90] = {
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1001] = {
				delay = 0.5,
				targetArea = 3,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1210451
				}
			},
			[3] = {
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121040008
					}
				}
			},
			[4] = {
				subEventId = 1002,
				eventCondition = "1,1,1210406",
				subEventSkill = 1210459,
				targetArea = 3,
				state = {
					stateOperation = 1,
					stateId = 1210403,
					chooseStateMode = 2,
					duration = 0.1,
					chooseStateIds = {
						1210406
					}
				}
			},
			[1002] = {
				targetChoose = 23,
				stunTime = 1,
				state = {
					duration = 0.1,
					stateId = 1210403,
					chooseStateMode = 2,
					chooseStateIds = {
						1210406
					}
				},
				hitCue = {
					cueList = {
						121040010
					}
				}
			},
			[1003] = {
				boxType = 1,
				delay = 0.5,
				subEventSkill = 1210459,
				boxId = 1210461,
				targetArea = 3,
				subEventId = 1008,
				state = {
					duration = 8,
					stateId = 1210426
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1004] = {
				boxType = 1,
				delay = 0.5,
				subEventSkill = 1210459,
				boxId = 1210461,
				targetArea = 3,
				subEventId = 1009,
				state = {
					duration = -999,
					stateId = 1210427
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1005] = {
				boxType = 1,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210452
				}
			},
			[5] = {
				eventCondition = "1,1,1210427",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210427
					}
				}
			},
			[11] = {
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1210428
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1210428
						}
					},
					[5] = {
						state = {
							duration = 8,
							stateId = 1210428
						}
					},
					[6] = {
						state = {
							duration = 8,
							stateId = 1210428
						}
					}
				}
			},
			[1006] = {
				delay = 0.1,
				boxType = 1,
				targetChoose = 3,
				state = {},
				baseCue = {
					cueList = {
						121040010
					}
				}
			},
			[12] = {
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1210429
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1210429
						}
					},
					[5] = {
						state = {
							duration = 8,
							stateId = 1210429
						}
					},
					[6] = {
						state = {
							duration = 8,
							stateId = 1210429
						}
					}
				}
			},
			[14] = {
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1210431
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1210431
						}
					},
					[5] = {
						state = {
							duration = 8,
							stateId = 1210431
						}
					},
					[6] = {
						state = {
							duration = 8,
							stateId = 1210431
						}
					}
				}
			},
			[15] = {
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1210432
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1210432
						}
					},
					[5] = {
						state = {
							duration = 8,
							stateId = 1210432
						}
					},
					[6] = {
						state = {
							duration = 8,
							stateId = 1210432
						}
					}
				}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						121040015,
						121045001,
						121041006
					}
				}
			},
			[6] = {
				subEventId = 1005,
				eventCondition = "1,2,1000013",
				subEventSkill = 1210459,
				state = {}
			},
			[7] = {
				boxId = 1210460,
				subEventId = 1007,
				subEventSkill = 1210459,
				state = {}
			},
			[1007] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210451,
						1210452
					}
				}
			},
			[1008] = {
				eventCondition = "1,1,8350181",
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1210426
				}
			},
			[1009] = {
				eventCondition = "1,1,8350181",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210427
				}
			},
			[1010] = {
				eventCondition = "1,1,8350182",
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 8350183
				}
			},
			[1011] = {
				eventCondition = "1,1,8350182",
				targetArea = 3,
				addManaNumber = 15,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 30
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[8] = {
				subEventId = 1012,
				eventCondition = "1,1,1210406,1",
				subEventSkill = 1210459,
				targetArea = 3,
				state = {}
			},
			[1012] = {
				eventCondition = "1,1,1210412",
				stunTime = 1,
				targetChoose = 23,
				state = {
					duration = 0.1,
					stateId = 1210403
				},
				hitCue = {
					cueList = {
						121040010
					}
				}
			},
			[1013] = {
				subEventId = 1014,
				subEventSkill = 1210459,
				state = {
					duration = 8,
					stateId = 1210428
				}
			},
			[1014] = {
				subEventId = 1015,
				subEventSkill = 1210459,
				state = {
					duration = 8,
					stateId = 1210429
				}
			},
			[1015] = {
				subEventId = 1016,
				subEventSkill = 1210459,
				state = {
					duration = 8,
					stateId = 1210430
				}
			},
			[1016] = {
				subEventId = 1017,
				subEventSkill = 1210459,
				state = {
					duration = 8,
					stateId = 1210431
				}
			},
			[1017] = {
				state = {
					duration = 8,
					stateId = 1210432
				}
			},
			[1018] = {
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1210433
				}
			},
			[1019] = {
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1210434
				}
			},
			[1020] = {
				randomTargetNumber = 1,
				stunTime = 1,
				boxId = 1210432,
				targetChoose = 7,
				filterChuyin = 1,
				excludeTarget = 1,
				state = {
					duration = 0.1,
					stateId = 1210403
				},
				hitCue = {
					cueList = {
						121040010
					}
				}
			},
			[1021] = {
				subEventId = 1020,
				targetChoose = 23,
				subEventSkill = 1210459,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				121048001,
				121041005
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
