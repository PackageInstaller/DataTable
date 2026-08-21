-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13013.lua

local Data = {
	cueFile = "13013",
	[1301309] = {
		bhEvent = "skill.1301309",
		atkEvents = {
			[0] = {
				unitDelay = 0.15,
				boxId = 1301309,
				flyCueId = 130130012,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130131002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130130011,
						130131001
					}
				}
			}
		}
	},
	[1301359] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 68,
		bhEvent = "skill.1301359",
		atkEvents = {
			[0] = {
				randomTargetNumber = 1,
				hitedAnim = "Hit",
				unitDelay = 0.1,
				boxId = 1301359,
				subEventSkill = 1301359,
				subEventId = 1002,
				eventType = 1,
				flyCueId = 140030001,
				targetChoose = 7,
				state = {
					chooseStateType = 2,
					chooseRandomNum = 1
				},
				hitCue = {
					cueList = {
						130130009
					}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {
						unitDelay = 0.1,
						flyCueId = 140030001
					},
					[3] = {
						randomTargetNumber = 1,
						hitedAnim = "Hit",
						unitDelay = 0.1,
						boxId = 1301359,
						targetChoose = 7,
						flyCueId = 140030001,
						eventType = 1,
						hitCue = {
							cueList = {
								130130009
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseRandomNum = 1
				},
				hitCue = {
					cueList = {
						130130010
					}
				}
			},
			[10] = {
				targetChoose = 7,
				targetArea = 2,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301301
					}
				}
			},
			[15] = {
				boxType = 1,
				delay = 0.2,
				state = {},
				hitCue = {
					cueList = {
						130130003
					}
				}
			},
			[25] = {
				state = {},
				atkCue = {
					cueList = {
						130136001
					}
				}
			},
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130130001
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130130018,
						130135001,
						130131005
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseRandomNum = 1
				},
				hitCue = {
					cueList = {
						130130010
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1301301
					}
				}
			},
			[1002] = {
				state = {
					duration = 10,
					stateId = 1301301
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1301303
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1301303
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				130138001,
				130131004
			}
		}
	},
	[1301329] = {
		bhEvent = "skill.1301329",
		atkEvents = {
			[0] = {
				flyCueId = 130130014,
				boxId = 1301329,
				unitDelay = 0.15,
				boxType = 1,
				subEventId = 1005,
				eventType = 1,
				subEventSkill = 1301329,
				state = {
					duration = 2,
					stateId = 1400001
				},
				hitCue = {
					cueList = {
						130130015
					}
				}
			},
			[1001] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301302
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseStateMode = 1
				},
				hitCue = {
					cueList = {
						130130010
					}
				}
			},
			[1004] = {
				boxId = 1301330,
				boxType = 1,
				subEventId = 1006,
				delay = 0.2,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 1301329,
				state = {},
				hitCue = {
					cueList = {
						130130017
					}
				}
			},
			{
				unitDelay = 0.1,
				baseToTarget = 1,
				flyCueId = 130130014,
				state = {}
			},
			[1005] = {
				randomTargetNumber = 2,
				randomRule = 2,
				unitDelay = 0.1,
				boxType = 1,
				flyCueId = 130130014,
				targetChoose = 7,
				baseToTarget = 1,
				state = {
					duration = -999,
					stateId = 1301302
				},
				hitCue = {
					cueList = {
						130130015
					}
				}
			},
			[1006] = {
				disablePassive = 1,
				excludeTarget = 1,
				boxId = 1301330,
				targetChoose = 3,
				eventCondition = "1,1,8791130",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130130017
					}
				}
			},
			[1007] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1301312
				}
			},
			[100] = {
				state = {}
			},
			[1008] = {
				boxId = 1301331,
				targetArea = 3,
				targetChoose = 14,
				state = {}
			}
		}
	},
	[1301330] = {
		bhEvent = "skill.1301330",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130130013,
						130131003
					}
				}
			},
			[0] = {
				unitDelay = 0.15,
				boxId = 1301329,
				flyCueId = 130130014,
				boxType = 1,
				subEventSkill = 1301330,
				subEventId = 1001,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 1400001
				}
			},
			{
				unitDelay = 0.1,
				baseToTarget = 1,
				flyCueId = 130130014,
				state = {}
			},
			[1001] = {
				flyCueId = 130130014,
				unitDelay = 0.1,
				boxType = 1,
				targetChoose = 7,
				baseToTarget = 1,
				state = {
					duration = -999,
					stateId = 1301302
				},
				hitCue = {
					cueList = {
						130130015
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
