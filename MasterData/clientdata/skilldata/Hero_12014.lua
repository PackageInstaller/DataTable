-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12014.lua

local Data = {
	cueFile = "12014",
	[1201409] = {
		bhEvent = "skill.1201409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120140001
					}
				}
			},
			[0] = {
				eventCondition = "1,1,1201401",
				state = {
					duration = 0.15,
					stateId = 1201408
				}
			},
			{
				boxId = 1201409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120140002,
						120141001
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				subEventId = 1002,
				boxId = 1201410,
				eventType = 1,
				subEventSkill = 1201409,
				targetChoose = 3,
				eventProbId = 1201401,
				state = {},
				hitCue = {
					cueList = {
						120140004
					}
				}
			},
			[1002] = {
				subEventId = 1001,
				subEventSkill = 1201429,
				targetArea = 3,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1201407
				}
			},
			[1003] = {
				state = {
					duration = 0.15,
					stateId = 1201408
				}
			},
			[1004] = {
				boxId = 1201409,
				state = {},
				hitCue = {
					cueList = {
						120140004
					}
				}
			},
			[1005] = {
				controlTime = 2,
				controlAniName = "freeze",
				eventCondition = "1,1,1201413",
				targetChoose = 23,
				state = {}
			},
			[1006] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201407
					}
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				subEventId = 1002,
				boxId = 1201410,
				eventType = 1,
				subEventSkill = 1201409,
				targetChoose = 3,
				eventProbId = 1201403,
				state = {},
				hitCue = {
					cueList = {
						120140004
					}
				}
			},
			[1008] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1201431
				}
			}
		}
	},
	[1201410] = {
		bhEvent = "skill.1201410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120140003
					}
				}
			},
			[0] = {
				eventCondition = "1,1,1201401",
				state = {
					duration = 0.15,
					stateId = 1201408
				}
			},
			{
				boxId = 1201409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120140002,
						120141002
					}
				}
			}
		}
	},
	[1201459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 45,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 45,
		actTime = 90,
		bhEvent = "skill.1201459",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						120140005,
						120140006,
						120140007,
						120141004
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120145001,
						120140011
					}
				}
			},
			[33] = {
				state = {}
			},
			[0] = {
				state = {}
			},
			{
				eventCondition = "1,1,1201401",
				state = {
					duration = 0.5,
					stateId = 1201402
				}
			},
			{
				eventCondition = "1,1,1201401",
				state = {
					duration = 0.5,
					stateId = 1201403
				}
			},
			[11] = {
				boxId = 1201459,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120140008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				hitCue = {
					cueList = {
						120140012,
						120143001
					}
				}
			},
			[32] = {
				boxId = 1201461,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[21] = {
				boxId = 1201460,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120140009
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 0.15,
							stateId = 1201412
						}
					},
					[3] = {
						state = {
							duration = 0.15,
							stateId = 1201412
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[31] = {
				eventCondition = "1,1,1201401",
				state = {
					duration = 0.3,
					stateId = 1201404
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1201462,
				targetChoose = 3,
				eventType = 1,
				eventProbId = 1201401,
				state = {},
				hitCue = {
					cueList = {
						120140012
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				boxId = 1201463,
				targetChoose = 3,
				eventType = 1,
				eventProbId = 1201401,
				state = {},
				hitCue = {
					cueList = {
						120140012
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 0.15,
							stateId = 1201412
						}
					},
					[3] = {
						state = {
							duration = 0.15,
							stateId = 1201412
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				randomRule = 1,
				targetChoose = 3,
				eventProbId = 1201402,
				state = {
					duration = 0.1,
					stateId = 1201405
				},
				hitCue = {
					cueList = {
						120140015,
						120143001,
						120141006
					}
				}
			},
			[1004] = {
				eventCondition = "1,1,1201406",
				state = {
					duration = 0.3,
					stateId = 1201404
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					stateId = 1201406,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1006] = {
				boxId = 1201464,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[111] = {
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1201406,
						1201407
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						120140010
					}
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				randomRule = 1,
				targetChoose = 3,
				state = {
					duration = 0.1,
					stateId = 1201405
				},
				hitCue = {
					cueList = {
						120140015,
						120143001,
						120141006
					}
				}
			},
			[1008] = {
				eventCondition = "1,1,1201427,1",
				state = {
					duration = 0.3,
					stateId = 1201404
				}
			},
			[1009] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201426
				}
			},
			[1010] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1201427
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201426
					}
				}
			},
			[1012] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 21201431
				}
			}
		},
		videoActCue = {
			cueList = {
				120148001,
				120141003
			}
		}
	},
	[1201429] = {
		bhEvent = "skill.1201429",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				state = {}
			},
			{
				state = {}
			},
			[1001] = {
				boxId = 1201429,
				targetArea = 3,
				eventCondition = "1,1,1201411",
				state = {}
			},
			[1002] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201415
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201406
				}
			},
			[1004] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1201421
				}
			},
			[1005] = {
				state = {
					duration = 0.2,
					stateId = 1201422
				},
				hitCue = {
					cueList = {
						120140013
					}
				}
			},
			[1006] = {
				boxId = 1201470,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120140014
					}
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				eventCondition = "1,1,1201401",
				randomRule = 1,
				targetChoose = 3,
				eventProbId = 1201401,
				state = {
					duration = 0.2,
					stateId = 1201423
				},
				hitCue = {
					cueList = {
						120140013
					}
				}
			},
			[1008] = {
				boxId = 1201471,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						120140014
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
