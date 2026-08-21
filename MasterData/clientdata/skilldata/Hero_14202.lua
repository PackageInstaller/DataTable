-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14202.lua

local Data = {
	cueFile = "14202",
	[1420209] = {
		bhEvent = "skill.1420209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142020011,
						142021001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1420209,
				flyCueId = 142020012,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142020014,
						142021002
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.15,
				boxId = 1420210,
				eventType = 1,
				state = {}
			}
		}
	},
	[1420210] = {
		bhEvent = "skill.1420210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142020013,
						142021003
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1420209,
				flyCueId = 142020016,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142020014,
						142021002
					}
				}
			}
		}
	},
	[1420229] = {
		actTime = 60,
		bhEvent = "skill.1420229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142020006,
						142021004
					}
				},
				hitCue = {
					cueList = {
						142020007
					}
				}
			},
			{
				stunTime = 4,
				state = {
					duration = -999,
					stateId = 1420202
				}
			},
			[1001] = {
				excludeTarget = 1,
				boxId = 1420230,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1000013
				},
				baseCue = {
					cueList = {
						142020008
					}
				}
			},
			[1002] = {
				excludeTarget = 1,
				boxId = 1420229,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						142020009
					}
				}
			},
			[1003] = {
				boxId = 1420231,
				disablePassive = 1,
				state = {}
			},
			[1004] = {
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 1420202
				}
			},
			[1005] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 8791071
				}
			},
			[1006] = {
				boxId = 1420232,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						142020008
					}
				}
			}
		}
	},
	[1420259] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 95,
		bhEvent = "skill.1420259",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						142020015
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						142020017,
						142025001,
						142021006
					}
				}
			},
			[14] = {
				state = {},
				hitCue = {
					cueList = {
						142020002
					}
				}
			},
			[60] = {
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						142020003
					}
				}
			},
			{
				recordSkillTargets = 1,
				boxId = 1420259,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000013
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1000013
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				eventType = 1,
				state = {}
			},
			[1002] = {
				state = {
					duration = 3,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1000013
					}
				}
			},
			{
				targetChoose = 12,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1420201
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1420201
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
				142028001,
				142021005
			}
		}
	},
	[1420230] = {
		bhEvent = "skill.1420230",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142020006,
						142021004
					}
				},
				hitCue = {
					cueList = {
						142020007
					}
				}
			},
			{
				state = {
					duration = -999,
					stateId = 1420202
				},
				hitCue = {
					cueList = {
						142020010
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
