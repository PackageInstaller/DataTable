-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Pet_common.lua

local Data = {
	cueFile = "34000",
	[100000159] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.100000159",
		atkEvents = {
			{
				disablePassive = 1,
				randomTargetNumber = 1,
				boxId = 100000159,
				targetChoose = 7,
				eventType = 1,
				state = {}
			}
		}
	},
	[102000259] = {
		actTime = 60,
		hideEffect = 1,
		bhEvent = "skill.102000259",
		atkEvents = {
			{
				randomTargetNumber = 1,
				subEventId = 1001,
				boxId = 102000259,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 102000259,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						340000003
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				state = {
					duration = 5,
					stateId = 102000201
				}
			}
		}
	},
	[102000159] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000159",
		atkEvents = {
			{
				disablePassive = 1,
				boxId = 102000159,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 6,
					stateId = 102000101
				},
				hitCue = {
					cueList = {
						340000002
					}
				}
			}
		}
	},
	[102000359] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000359",
		atkEvents = {
			{
				disablePassive = 1,
				targetArea = 3,
				boxId = 102000359,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						340000004
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 102000359,
				targetArea = 3,
				eventProbId = 102000301,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 102000359,
				targetChoose = 7,
				randomTargetNumber = 2,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						340000004
					}
				}
			}
		}
	},
	[101000159] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.101000159",
		atkEvents = {
			{
				disablePassive = 1,
				randomTargetNumber = 3,
				boxId = 101000159,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000005
					}
				}
			}
		}
	},
	[101000259] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.101000259",
		atkEvents = {
			{
				disablePassive = 1,
				targetArea = 3,
				boxId = 101000259,
				targetChoose = 14,
				excludeTarget = 1,
				state = {
					duration = 5,
					stateId = 101000201
				},
				hitCue = {
					cueList = {
						340000006
					}
				}
			}
		}
	},
	[101000359] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.101000359",
		atkEvents = {
			{
				disablePassive = 1,
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 101000301
				},
				hitCue = {
					cueList = {
						340000007
					}
				}
			}
		}
	},
	[101000459] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.101000459",
		atkEvents = {
			{
				boxId = 101000459,
				targetChoose = 13,
				disablePassive = 1,
				state = {}
			}
		}
	},
	[100000129] = {
		bhEvent = "skill.100000129",
		atkEvents = {
			[1001] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 7,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000102
				}
			},
			[1002] = {
				boxId = 102000129,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1003] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 7,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000203
				}
			},
			[1004] = {
				boxId = 102000229,
				targetArea = 1,
				disablePassive = 1,
				state = {}
			},
			[1005] = {
				addManaNumber = 15,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 17
					},
					[3] = {
						addManaNumber = 20
					},
					[4] = {
						addManaNumber = 22
					},
					[5] = {
						addManaNumber = 25
					},
					[6] = {}
				}
			},
			[1006] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000301
				}
			},
			[1007] = {
				disablePassive = 1,
				targetArea = 1,
				addManaNumber = 6,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						102000301
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 7
					},
					[3] = {
						addManaNumber = 8
					},
					[4] = {
						addManaNumber = 9
					},
					[5] = {
						addManaNumber = 10
					},
					[6] = {}
				}
			},
			[1008] = {
				disablePassive = 1,
				targetArea = 3,
				boxId = 103000130,
				targetChoose = 19,
				state = {
					duration = -999,
					stateId = 103000102
				}
			},
			[1009] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 11,
				state = {
					duration = -999,
					stateId = 102001102
				}
			},
			[1010] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000602
				}
			},
			[1011] = {
				boxId = 102000629,
				targetArea = 1,
				disablePassive = 1,
				state = {}
			},
			[1012] = {
				disablePassive = 1,
				targetArea = 1,
				randomTargetNumber = 2,
				targetChoose = 20,
				state = {
					duration = 15,
					stateId = 102000501
				}
			},
			[1013] = {
				disablePassive = 1,
				targetArea = 1,
				randomTargetNumber = 2,
				targetChoose = 20,
				state = {
					duration = 15,
					stateId = 102000801
				}
			},
			[1014] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000702
				}
			},
			[1015] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000901
				}
			},
			[1016] = {
				disablePassive = 1,
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						102000903,
						102000904
					}
				}
			},
			[1017] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 102000401
				}
			},
			[1018] = {
				disablePassive = 1,
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						102000403
					}
				}
			},
			[1019] = {
				disablePassive = 1,
				boxId = 102000729,
				delay = 0.1,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1020] = {
				boxId = 102000429,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1021] = {
				boxId = 102000929,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1022] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 19,
				state = {
					duration = -999,
					stateId = 102001002
				}
			},
			[1023] = {
				boxId = 102001029,
				targetArea = 1,
				disablePassive = 1,
				state = {}
			},
			[1024] = {
				disablePassive = 1,
				boxId = 102001129,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[1025] = {
				disablePassive = 1,
				targetArea = 3,
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 103000202
				}
			},
			[1026] = {
				disablePassive = 1,
				boxId = 103000229,
				delay = 0.2,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1027] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 103000301
				}
			},
			[1028] = {
				disablePassive = 1,
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						103000303,
						103000304
					}
				}
			},
			[1029] = {
				boxId = 103000329,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1030] = {
				disablePassive = 1,
				eventCondition = "1,2,1000001",
				boxId = 103000329,
				eventType = 1,
				state = {}
			},
			[1031] = {
				disablePassive = 1,
				eventCondition = "1,2,1000003",
				boxId = 103000329,
				eventType = 1,
				state = {}
			},
			[1032] = {
				disablePassive = 1,
				eventCondition = "1,2,1000013",
				boxId = 103000329,
				eventType = 1,
				state = {}
			},
			[1033] = {
				disablePassive = 1,
				targetArea = 1,
				state = {
					duration = 5,
					stateId = 103000302
				}
			},
			[1034] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 103000401
				}
			},
			[1035] = {
				disablePassive = 1,
				randomTargetNumber = 1,
				stunTime = 1,
				boxId = 103000429,
				targetChoose = 20,
				eventType = 1,
				state = {}
			}
		}
	},
	[102000459] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000459",
		atkEvents = {
			{
				disablePassive = 1,
				subEventSkill = 102000459,
				randomTargetNumber = 1,
				targetChoose = 10,
				subEventId = 1001,
				state = {},
				hitCue = {
					cueList = {
						340000001
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 102000459,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000001
				}
			}
		}
	},
	[102000559] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000559",
		atkEvents = {
			{
				disablePassive = 1,
				addManaNumber = -5,
				boxId = 102000559,
				targetChoose = 14,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000021
					}
				}
			}
		}
	},
	[102000659] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000659",
		atkEvents = {
			{
				disablePassive = 1,
				boxId = 102000659,
				targetChoose = 14,
				eventType = 1,
				state = {
					duration = 5.1,
					stateId = 102000601
				},
				hitCue = {
					cueList = {
						340000022
					}
				}
			},
			[1001] = {
				boxId = 102000660,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[102000759] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000759",
		atkEvents = {
			{
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 5,
					stateId = 102000704
				}
			},
			{
				disablePassive = 1,
				targetArea = 3,
				boxId = 102000759,
				targetChoose = 10,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						340000001
					}
				}
			}
		}
	},
	[102000859] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000859",
		atkEvents = {
			{
				disablePassive = 1,
				boxId = 102000859,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000024
					}
				}
			},
			{
				disablePassive = 1,
				targetArea = 3,
				boxId = 102000860,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						340000025
					}
				}
			}
		}
	},
	[102000959] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102000959",
		atkEvents = {
			{
				disablePassive = 1,
				subEventId = 1001,
				subEventSkill = 102000959,
				targetChoose = 11,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 102000959,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						340000001
					}
				}
			}
		}
	},
	[103000159] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.103000159",
		atkEvents = {
			{
				disablePassive = 1,
				boxId = 103000159,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000035
					}
				}
			},
			{
				disablePassive = 1,
				targetChoose = 20,
				state = {
					duration = 5,
					stateId = 103000159
				}
			}
		}
	},
	[102001059] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102001059",
		atkEvents = {
			{
				randomTargetNumber = 1,
				disablePassive = 1,
				subEventSkill = 102001059,
				subEventId = 1001,
				targetChoose = 10,
				state = {}
			},
			{
				disablePassive = 1,
				targetArea = 3,
				subEventSkill = 102001059,
				randomTargetNumber = 1,
				targetChoose = 10,
				subEventId = 1002,
				excludeTarget = 1,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 102001059,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000031
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				targetChoose = 4,
				targetArea = 1,
				state = {
					duration = 5,
					stateId = 102001059
				},
				hitCue = {
					cueList = {
						340000036
					}
				}
			}
		}
	},
	[102001159] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102001159",
		atkEvents = {
			{
				disablePassive = 1,
				boxId = 102001159,
				targetChoose = 19,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						340000032
					}
				}
			}
		}
	},
	[102001259] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.102001259",
		atkEvents = {
			{
				disablePassive = 1,
				targetChoose = 14,
				targetArea = 3,
				addManaNumber = 30,
				state = {},
				hitCue = {
					cueList = {
						340000034
					}
				}
			},
			{
				disablePassive = 1,
				targetArea = 3,
				boxId = 102001259,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						340000033
					}
				}
			}
		}
	},
	[103000259] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.103000259",
		atkEvents = {
			{
				randomTargetNumber = 1,
				subEventId = 1001,
				boxId = 103000259,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 103000259,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						340000046
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				disablePassive = 1,
				subEventSkill = 103000259,
				subEventId = 1002,
				targetChoose = 3,
				state = {}
			},
			[1002] = {
				disablePassive = 1,
				state = {
					duration = 5.1,
					stateId = 103000259
				}
			},
			[1003] = {
				boxId = 103000260,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[103000359] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.103000359",
		atkEvents = {
			{
				randomTargetNumber = 1,
				subEventId = 1001,
				boxId = 103000359,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 103000359,
				targetChoose = 10,
				state = {
					duration = 5,
					stateId = 103000305
				},
				hitCue = {
					cueList = {
						340000051
					}
				}
			},
			[1001] = {
				state = {
					duration = 5,
					stateId = 103000306
				}
			}
		}
	},
	[103000459] = {
		actTime = 50,
		hideEffect = 1,
		bhEvent = "skill.103000459",
		atkEvents = {
			{
				randomTargetNumber = 1,
				subEventSkill = 103000459,
				subEventId = 1001,
				boxId = 103000459,
				eventType = 1,
				disablePassive = 1,
				stunTime = 3,
				targetChoose = 20,
				addManaNumber = -30,
				state = {},
				hitCue = {
					cueList = {
						340000057
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				delay = 5,
				boxId = 103000459,
				boxType = 1,
				recordSkillTargets = 1,
				subEventId = 1002,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 103000459,
				targetChoose = 20,
				addManaNumber = -30,
				state = {},
				hitCue = {
					cueList = {
						340000057
					}
				}
			},
			[1002] = {
				targetChoose = 12,
				stunTime = 3,
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
