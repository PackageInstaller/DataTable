-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11012.lua

local Data = {
	cueFile = "11012",
	[1101209] = {
		bhEvent = "skill.1101209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110120001,
						110120002,
						110120003,
						110120004,
						110121001
					}
				}
			},
			{
				boxId = 1101201,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110120005
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						110120006
					}
				}
			}
		}
	},
	[1101210] = {
		bhEvent = "skill.1101210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110120007,
						110120002,
						110120003,
						110121002
					}
				}
			},
			{
				boxId = 1101201,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110120008
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						110120006
					}
				}
			}
		}
	},
	[1101221] = {
		actTime = 65,
		skillTarget = 1,
		bhEvent = "skill.1101221",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110120009,
						110121003
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				subEventId = 1002,
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				eventCondition = "1,2,1101201",
				state = {
					duration = 2,
					stateId = 1101203
				}
			},
			[1005] = {
				targetChoose = 3,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 1.1,
					stateId = 1101201
				}
			},
			[1006] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = 1.1,
					stateId = 1101206
				}
			},
			[1008] = {
				stunTime = 0.1,
				boxId = 1101221,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110120016,
						110120015
					}
				}
			},
			[1010] = {
				subEventSkill = 1101221,
				boxId = 1101222,
				targetArea = 3,
				subEventId = 1035,
				state = {},
				atkCue = {
					cueList = {
						110120013
					}
				},
				hitCue = {
					cueList = {
						110120014,
						10000008
					}
				}
			},
			[1013] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1101203
				}
			},
			[1014] = {
				delay = 0.2,
				boxId = 1101223,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1015] = {
				subEventId = 1019,
				targetChoose = 7,
				subEventSkill = 1101221,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101202
				}
			},
			[1018] = {
				boxType = 1,
				delay = 0.5,
				boxId = 1101231,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						110120014,
						10000008
					}
				}
			},
			[1019] = {
				eventCondition = "1,2,1101206",
				targetChoose = 7,
				state = {
					duration = 1.1,
					stateId = 1101213
				}
			},
			[1020] = {
				targetChoose = 10,
				subEventId = 1021,
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1021] = {
				targetChoose = 10,
				targetArea = 3,
				eventCondition = "1,2,1101201",
				state = {
					duration = 8,
					stateId = 1101216
				}
			},
			[10] = {
				subEventId = 1037,
				eventCondition = "1,1,1101209,1",
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1022] = {
				subEventId = 1023,
				targetArea = 3,
				subEventSkill = 1101221,
				state = {}
			},
			[1023] = {
				eventCondition = "1,1,1101209,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101205
				}
			},
			[1024] = {
				targetChoose = 7,
				subEventId = 1028,
				subEventSkill = 1101221,
				targetArea = 2,
				state = {}
			},
			[1028] = {
				targetChoose = 7,
				targetArea = 2,
				state = {},
				levelAtkEvents = {
					[2] = {
						eventCondition = "1,2,1101206",
						stunTime = 0.5,
						state = {
							duration = -999,
							stateId = 1101218
						}
					},
					[3] = {
						eventCondition = "1,2,1101206",
						stunTime = 0.5,
						state = {
							duration = -999,
							stateId = 1101218
						}
					},
					[4] = {
						state = {
							stateId = 1101218
						}
					},
					[5] = {
						state = {
							stateId = 1101218
						}
					},
					[6] = {
						state = {
							stateId = 1101218
						}
					}
				}
			},
			[1029] = {
				targetChoose = 7,
				subEventId = 1030,
				subEventSkill = 1101221,
				targetArea = 2,
				state = {}
			},
			[1030] = {
				targetChoose = 7,
				targetArea = 2,
				eventCondition = "1,2,1101206",
				state = {
					duration = 1.1,
					stateId = 1101215
				}
			},
			[1031] = {
				state = {},
				hitCue = {
					cueList = {
						110120013
					}
				}
			},
			[1034] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 8,
					stateId = 8791431
				}
			},
			[1035] = {
				targetChoose = 10,
				subEventId = 1036,
				subEventSkill = 1101221,
				targetArea = 3,
				excludeTarget = 1,
				state = {}
			},
			[1036] = {
				boxId = 1101222,
				delay = 0.1,
				eventCondition = "1,2,8791431",
				boxType = 1,
				targetArea = 3,
				excludeTarget = 1,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						110120014
					}
				}
			},
			[1037] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101204
				}
			},
			[1038] = {
				targetChoose = 10,
				subEventId = 1040,
				subEventSkill = 1101221,
				targetArea = 1,
				state = {}
			},
			[1039] = {
				targetChoose = 7,
				subEventId = 1041,
				subEventSkill = 1101221,
				targetArea = 2,
				state = {}
			},
			[1040] = {
				eventCondition = "1,2,1101201",
				boxId = 1101241,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						110120014,
						10000008
					}
				}
			},
			[1041] = {
				targetChoose = 7,
				targetArea = 2,
				eventCondition = "1,2,1101206",
				state = {
					duration = 1,
					stateId = 1101220
				}
			},
			[1042] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 21101212
				}
			},
			[1043] = {
				targetChoose = 7,
				subEventId = 1044,
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1044] = {
				targetChoose = 7,
				targetArea = 3,
				eventCondition = "7,0,2,1101201,0,2,1101207",
				state = {
					duration = 6,
					stateId = 21101213
				}
			},
			[1045] = {
				targetChoose = 10,
				subEventId = 1046,
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1046] = {
				targetChoose = 10,
				eventCondition = "1,2,1101201",
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 1,
					stateId = 21101223
				}
			},
			[1047] = {
				targetChoose = 16,
				subEventId = 1048,
				subEventSkill = 1101221,
				targetArea = 3,
				state = {}
			},
			[1048] = {
				targetChoose = 16,
				targetArea = 3,
				eventCondition = "1,2,1101201",
				state = {
					duration = 1,
					stateId = 21101224
				}
			},
			[1049] = {
				addManaNumber = 8,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1101251] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 15,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 110,
		bhEvent = "skill.1101251",
		atkEvents = {
			{
				targetArea = 2,
				boxId = 1101251,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						110120021
					}
				},
				hitCue = {
					cueList = {
						110120023
					}
				}
			},
			[100] = {
				targetChoose = 3,
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						110120018,
						110120019,
						110120020,
						110120025,
						110121004
					}
				}
			},
			{
				targetArea = 2,
				boxId = 1101251,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						110120022
					}
				},
				hitCue = {
					cueList = {
						110120024
					}
				}
			},
			[1003] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 1.1,
					stateId = 1101201
				}
			},
			[1004] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = 1.1,
					stateId = 1101206
				}
			},
			[1006] = {
				targetChoose = 3,
				subEventId = 1007,
				subEventSkill = 1101251,
				eventCondition = "1,2,1101201",
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						targetChoose = 7
					},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1007] = {
				boxType = 1,
				delay = 0.1,
				boxId = 1101253,
				targetArea = 3,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110125001,
						110121006
					}
				}
			},
			{
				subEventId = 1006,
				subEventSkill = 1101251,
				boxId = 1101252,
				targetArea = 3,
				state = {}
			},
			[1008] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 2,
					stateId = 1101201
				}
			},
			[1009] = {
				targetChoose = 7,
				subEventId = 1010,
				subEventSkill = 1101251,
				targetArea = 2,
				state = {
					duration = 2,
					stateId = 1101206
				}
			},
			[1010] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101205
					}
				}
			},
			[1011] = {
				boxId = 1101254,
				targetArea = 3,
				targetChoose = 11,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1101204
							}
						}
					},
					[3] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1101204
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 11,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1101254
					},
					[4] = {
						boxId = 1101254
					},
					[5] = {
						boxId = 1101254
					},
					[6] = {
						boxId = 1101254
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				110128001,
				110121005
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
