-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12018.lua

local Data = {
	cueFile = "12018",
	[1201809] = {
		bhEvent = "skill.1201809",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120180001,
						120181001
					}
				}
			},
			{
				boxId = 1201809,
				eventType = 1,
				state = {}
			},
			{
				eventType = 1,
				state = {
					duration = 10,
					stateId = 1201802
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						120180003
					}
				}
			}
		}
	},
	[1201810] = {
		bhEvent = "skill.1201810",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120180002,
						120181002
					}
				}
			},
			{
				boxId = 1201809,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120180004
					}
				}
			},
			{
				eventType = 1,
				state = {
					duration = 10,
					stateId = 1201802
				}
			}
		}
	},
	[1201829] = {
		bhEvent = "skill.1201829",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				boxId = 1201810,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxId = 1201811,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1003] = {
				subEventId = 1008,
				subEventSkill = 1201829,
				state = {
					duration = -999,
					stateId = 1201801
				},
				hitCue = {
					cueList = {
						120180006
					}
				}
			},
			[1004] = {
				boxId = 1201829,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201804
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201805
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201806
				}
			},
			[1007] = {
				state = {
					duration = -999,
					stateId = 1201811
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201812
				}
			},
			[1009] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201812
					}
				}
			},
			[1010] = {
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						120180007
					}
				}
			},
			{
				state = {}
			},
			[1011] = {
				subEventId = 1012,
				subEventSkill = 1201829,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1201813
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 4,
							stateId = 1201813
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1201813
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1201814
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 4,
							stateId = 1201814
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1201814
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1201859] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 69,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 90,
		bhEvent = "skill.1201859",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120180009,
						120180010
					}
				}
			},
			{
				boxId = 1201859,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						120183002
					}
				}
			},
			{
				boxId = 1201859,
				eventCondition = "1,1,1201804",
				eventType = 1,
				state = {}
			},
			{
				boxId = 1201859,
				eventCondition = "1,1,1201805",
				eventType = 1,
				state = {}
			},
			{
				boxId = 1201859,
				eventCondition = "1,1,1201806",
				eventType = 1,
				state = {}
			},
			[6] = {
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {
						eventCondition = "1,2,1201811",
						subEventSkill = 1201859,
						subEventId = 1002
					},
					[3] = {
						eventCondition = "1,2,1201811",
						subEventSkill = 1201859,
						subEventId = 1002
					},
					[4] = {
						eventCondition = "1,2,1201811"
					},
					[5] = {},
					[6] = {}
				}
			},
			[7] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201807
					}
				}
			},
			[8] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventId = 1001,
						subEventSkill = 1201859,
						state = {
							duration = 5,
							stateId = 1201808
						}
					},
					[4] = {
						subEventId = 1001,
						subEventSkill = 1201859,
						state = {
							duration = 5,
							stateId = 1201808
						}
					},
					[5] = {
						state = {
							duration = 5
						}
					},
					[6] = {
						state = {
							duration = 5
						}
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201809
				}
			},
			[1002] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1201807
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1201807
						}
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
						120180012,
						120185001,
						120181004,
						120181005
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						120180011
					}
				}
			},
			[16] = {
				state = {},
				hitCue = {
					cueList = {
						120183001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120188001,
				120181003
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
