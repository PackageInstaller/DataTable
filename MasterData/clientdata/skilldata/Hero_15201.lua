-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15201.lua

local Data = {
	cueFile = "15201",
	[1520109] = {
		bhEvent = "skill.1520109",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152010001,
						152010002,
						152011001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1520109,
				flyCueId = 152010005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						152010006,
						152011004
					}
				}
			}
		}
	},
	[1520110] = {
		bhEvent = "skill.1520110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152010003,
						152010004,
						152011003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1520109,
				flyCueId = 152010019,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						152010006,
						152011004
					}
				}
			}
		}
	},
	[1520129] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.1520129",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152010007,
						152010008,
						152010009,
						152010010,
						152011005
					}
				}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1520106
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1520105
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				eventCondition = "1,2,1520105",
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350012
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				randomTargetNumber = 2,
				targetArea = 3,
				boxId = 1520130,
				targetChoose = 10,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82152011
				}
			}
		}
	},
	[1520159] = {
		hideTime = 10,
		hideEvent = 10,
		videoActTime = 75,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 81,
		bhEvent = "skill.1520159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152010013,
						152010014,
						152010015,
						152010012
					}
				}
			},
			{
				boxId = 1520160,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 20,
					stateId = 1520107
				},
				hitCue = {
					cueList = {
						152010017
					}
				}
			},
			[1001] = {
				boxId = 1520151,
				targetChoose = 7,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						10000025
					}
				},
				hitCue = {
					cueList = {
						10000024
					}
				},
				baseCue = {
					cueList = {
						10000056
					}
				}
			},
			[1002] = {
				boxId = 1520161,
				eventCondition = "1,2,1000001",
				state = {},
				hitCue = {
					cueList = {
						10000078
					}
				}
			},
			[10] = {
				targetChoose = 7,
				state = {}
			},
			[13] = {
				targetArea = 3,
				weatherTime = 10,
				weatherFlag = 1520101,
				state = {},
				atkCue = {
					cueList = {
						152010018,
						152015001,
						152011007
					}
				},
				levelAtkEvents = {
					[2] = {
						weatherFlag = 1520102
					},
					[3] = {
						weatherTime = 12,
						weatherFlag = 1520103
					},
					[4] = {
						weatherTime = 8
					},
					[5] = {
						weatherTime = 8
					},
					[6] = {
						weatherTime = 8
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						152010016
					}
				}
			},
			[99] = {
				state = {}
			},
			[1003] = {
				targetChoose = 7,
				state = {
					duration = 12,
					stateId = 1520108
				}
			},
			[1004] = {
				boxId = 1520151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000024
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				152018001,
				152011006
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
