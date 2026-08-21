-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15203.lua

local Data = {
	cueFile = "15203",
	[1520309] = {
		bhEvent = "skill.1520309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152030001,
						152031001
					}
				}
			},
			{
				unitDelay = 0.13,
				boxId = 1520309,
				flyCueId = 152030002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						152030003,
						152031002
					}
				}
			},
			{
				targetChoose = 14,
				targetArea = 3,
				state = {
					duration = 0.5,
					stateId = 1520309
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1520310] = {
		bhEvent = "skill.1520309",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				eventType = 1,
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1520329] = {
		actTime = 60,
		bhEvent = "skill.1520329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						152030004,
						152031003
					}
				}
			},
			[2] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1520301
				}
			},
			[3] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1520302
				}
			},
			{
				boxId = 1520329,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1001] = {
				boxId = 1520329,
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1520302
				},
				hitCue = {
					cueList = {
						152030006
					}
				}
			},
			[1002] = {
				targetArea = 1,
				state = {
					duration = 4,
					stateId = 1520303
				},
				hitCue = {
					cueList = {
						152030005
					}
				}
			},
			[1003] = {
				boxId = 1520359,
				targetArea = 1,
				state = {}
			},
			[1004] = {
				controlTime = 4,
				targetArea = 1,
				controlAniName = "timelock",
				state = {
					duration = 4,
					stateId = 1520304
				}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791692
				}
			},
			[1006] = {
				boxId = 1520329,
				targetArea = 3,
				eventProbId = 1520301,
				state = {
					duration = -999,
					stateId = 1520302
				}
			},
			[1007] = {
				targetArea = 3,
				eventCondition = "1,1,8791693,1",
				boxId = 1520330,
				targetChoose = 10,
				addManaNumber = 100,
				state = {
					duration = -999,
					stateId = 8791693
				}
			},
			[1008] = {
				boxId = 1520331,
				targetArea = 3,
				targetChoose = 3,
				state = {}
			}
		}
	},
	[1520359] = {
		hideEffect = 1,
		actTime = 90,
		videoActTime = 20,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1520359",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						152030007,
						152031004,
						152030008,
						152030009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1520355
				}
			},
			[1001] = {
				controlTime = 4,
				controlAniName = "timelock",
				eventCondition = "1,2,1520355,1",
				targetArea = 1,
				state = {
					duration = 4,
					stateId = 1520352
				},
				hitCue = {
					cueList = {
						152030010,
						152033001
					}
				}
			},
			{
				randomTargetNumber = 1,
				targetArea = 3,
				targetChoose = 3,
				state = {
					duration = 0.5,
					stateId = 1520351
				}
			},
			[1002] = {
				targetArea = 1,
				state = {
					duration = 6,
					stateId = 1520353
				}
			},
			[1003] = {
				addManaNumber = 30,
				targetArea = 1,
				state = {}
			},
			[1004] = {
				boxId = 1520310,
				targetArea = 1,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						152030012,
						152035001
					}
				}
			},
			[1005] = {
				targetArea = 3,
				boxId = 1520361,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				eventCondition = "1,2,1520355",
				targetArea = 1,
				state = {
					duration = 0.5,
					stateId = 1520356
				}
			},
			[1007] = {
				controlTime = 4,
				targetChoose = 18,
				controlAniName = "timelock",
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1520352
				},
				hitCue = {
					cueList = {
						152030010,
						152033001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				152038001,
				152031005
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
