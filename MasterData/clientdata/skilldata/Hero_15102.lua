-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15102.lua

local Data = {
	cueFile = "15102",
	[1510260] = {
		bhEvent = "skill.1510260",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151020010
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1510209] = {
		bhEvent = "skill.1510209",
		atkEvents = {
			{
				unitDelay = 0.16,
				boxId = 1510209,
				flyCueId = 151020002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						151020003,
						151021002
					}
				},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1510229,
						subEventId = 1005
					},
					[3] = {
						subEventSkill = 1510229,
						subEventId = 1005
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
						151020001,
						151021001
					}
				}
			}
		}
	},
	[1510210] = {
		bhEvent = "skill.1510210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151020004,
						151021003
					}
				}
			},
			{
				unitDelay = 0.16,
				boxId = 1510209,
				flyCueId = 151020005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						151020006,
						151021002
					}
				},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1510229,
						subEventId = 1005
					},
					[3] = {
						subEventSkill = 1510229,
						subEventId = 1005
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1510229] = {
		actTime = 55,
		bhEvent = "skill.1510229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151020007,
						151021004
					}
				}
			},
			{
				targetChoose = 10,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					duration = 20,
					stateId = 1510201
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1510204
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1510204
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1510204
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1510204
						}
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1510205
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1510205
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1510205
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1510205
						}
					}
				}
			},
			[1001] = {
				boxId = 1510229,
				targetArea = 1,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1510206
				}
			},
			[1003] = {
				boxId = 1510262,
				targetChoose = 23,
				state = {
					duration = 2,
					stateId = 1510256
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				stunTime = 0.5,
				boxId = 1510262,
				targetChoose = 10,
				eventCondition = "1,1,1510261",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						151020013
					}
				}
			},
			[1005] = {
				stunTime = 0.5,
				boxId = 1510262,
				targetChoose = 23,
				eventProbId = 1510201,
				state = {},
				hitCue = {
					cueList = {
						151020013
					}
				}
			},
			[1006] = {
				targetArea = 3,
				boxId = 1510229,
				targetChoose = 14,
				excludeTarget = 1,
				state = {}
			},
			[1007] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1510211
				}
			},
			[1008] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1510212,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1009] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510212
					}
				}
			},
			[1010] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 20,
					stateId = 8350310
				}
			},
			[1011] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350313
				}
			},
			[1012] = {
				boxId = 1510231,
				targetArea = 3,
				targetChoose = 18,
				state = {}
			},
			[1013] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 8791491
				}
			},
			[1014] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1015] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 21510211
				}
			},
			[1016] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 21510212
				}
			},
			[1017] = {
				targetArea = 3,
				boxId = 1510232,
				targetChoose = 10,
				addManaNumber = 10,
				state = {}
			},
			[1018] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 21510231
				}
			},
			[1019] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 21510232
				}
			},
			[1020] = {
				boxId = 1510233,
				targetArea = 1,
				state = {}
			},
			[101] = {
				targetChoose = 10,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						151020008
					}
				}
			}
		}
	},
	[1510259] = {
		hideEffect = 1,
		actTime = 150,
		videoActTime = 50,
		bhEvent = "skill.1510259",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						151020011,
						151020012,
						151020014,
						151025001,
						151021006
					}
				}
			},
			[104] = {
				targetChoose = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1510255
						}
					},
					[4] = {
						state = {
							duration = 6,
							stateId = 1510255
						}
					},
					[5] = {
						state = {
							duration = 6,
							stateId = 1510255
						}
					},
					[6] = {
						state = {
							duration = 6,
							stateId = 1510255
						}
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1510251
				},
				hitCue = {
					cueList = {
						151020016
					}
				}
			},
			[1001] = {
				boxId = 1510259,
				targetArea = 1,
				state = {}
			},
			[1002] = {
				boxId = 1510260,
				targetArea = 1,
				state = {}
			},
			[11] = {
				weatherFlag = 1510201,
				weatherTime = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						weatherFlag = 1510202
					},
					[3] = {
						weatherFlag = 1510203
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[102] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1510253
						}
					},
					[3] = {
						state = {
							duration = 6,
							stateId = 1510253
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[103] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1510254
				}
			},
			[1003] = {
				targetArea = 3,
				boxId = 1510261,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						151020015,
						151025002,
						151021007
					}
				}
			},
			[99] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				151028001,
				151021005
			}
		}
	},
	[1510230] = {
		actTime = 55,
		bhEvent = "skill.1510230",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151020007,
						151021004
					}
				}
			},
			{
				targetChoose = 10,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					duration = 20,
					stateId = 1510201
				}
			},
			{
				boxId = 1510230,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510205,
						1510207
					}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510204
					}
				}
			},
			[101] = {
				targetChoose = 10,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						151020008
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
