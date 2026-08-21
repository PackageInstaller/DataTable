-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12201.lua

local Data = {
	cueFile = "12201",
	[1220109] = {
		bhEvent = "skill.1220109",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122010001,
						122011001
					}
				}
			},
			[99] = {
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1220101
					}
				}
			},
			{
				boxId = 1220109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1220159] = {
		hideTime = 10,
		hideEvent = 1003,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 95,
		bhEvent = "skill.1220159",
		atkEvents = {
			{
				boxId = 1220159,
				eventType = 1,
				state = {}
			},
			[100] = {
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						122010007
					}
				}
			},
			[27] = {
				state = {},
				hitCue = {
					cueList = {
						122010009,
						122010010
					}
				},
				levelAtkEvents = {
					[2] = {
						hitCue = {
							cueList = {
								122010014,
								122010015
							}
						}
					},
					[3] = {
						hitCue = {
							cueList = {
								122010014,
								122010015
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[23] = {
				hitedAnim = "end",
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						122015001,
						122010012,
						122011006
					}
				}
			},
			{
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						122013001
					}
				},
				hitCue = {
					cueList = {
						10006003
					}
				}
			},
			[1002] = {
				delay = 0.5,
				boxType = 1,
				targetArea = 2,
				state = {},
				hitCue = {
					cueList = {
						122010011
					}
				}
			},
			{
				boxId = 1220161,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						122010008,
						122013002
					}
				}
			},
			[1003] = {
				disablePassive = 1,
				boxId = 1220160,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						122010013
					}
				}
			},
			[1004] = {
				stunTime = 1,
				state = {}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1220159,
						eventType = 1
					},
					[3] = {
						boxId = 1220159,
						eventType = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {}
			},
			[1005] = {
				randomTargetNumber = 1,
				stunTime = 1,
				targetChoose = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						randomTargetNumber = 2
					},
					[3] = {
						randomTargetNumber = 3
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				122018001,
				122011005
			}
		}
	},
	[1220129] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.1220129",
		atkEvents = {
			[100] = {
				targetArea = 2,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220105
					}
				},
				atkCue = {
					cueList = {
						122010005,
						122011004,
						10005003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5.5,
					stateId = 1220102
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220101,
						1220112
					}
				}
			},
			[1002] = {
				eventCondition = "1,1,1220111,1",
				boxId = 1220130,
				targetArea = 3,
				eventType = 1,
				state = {}
			},
			[1003] = {
				boxId = 1220131,
				eventType = 1,
				state = {}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1220102
					}
				}
			},
			[1005] = {
				disablePassive = 1,
				boxId = 1220160,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						122010013
					}
				}
			},
			[1006] = {
				boxId = 1220132,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1220110] = {
		bhEvent = "skill.1220110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122010002,
						122011002
					}
				}
			},
			{
				boxId = 1220109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[99] = {
				targetArea = 2,
				state = {}
			}
		}
	},
	[1220111] = {
		bhEvent = "skill.1220111"
	},
	[1220112] = {
		bhEvent = "skill.1220112",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122010003,
						122011003
					}
				}
			},
			{
				boxId = 1220109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[99] = {
				targetArea = 2,
				state = {}
			}
		}
	},
	[1220130] = {
		bhEvent = "skill.1220130",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122010005
					}
				}
			},
			{
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
