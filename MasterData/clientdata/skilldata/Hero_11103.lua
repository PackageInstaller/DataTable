-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11103.lua

local Data = {
	cueFile = "11103",
	[1110359] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 85,
		bhEvent = "skill.1110359",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111030008
					}
				}
			},
			{
				controlTime = 2,
				controlAniName = "freeze",
				boxId = 1110359,
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						111030010,
						111030011,
						111033001
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1110360,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						111030012
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1110305
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1110305
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						111030009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1110361
					},
					[4] = {
						boxId = 1110361
					},
					[5] = {
						boxId = 1110361
					},
					[6] = {
						boxId = 1110361
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						111030013,
						111035001,
						111031005
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				111038001,
				111031004
			}
		}
	},
	[1110309] = {
		bhEvent = "skill.1110309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111030001,
						111031001,
						111030014
					}
				}
			},
			{
				boxId = 1110309,
				state = {
					duration = 4,
					stateId = 1110304
				}
			},
			{
				state = {},
				hitCue = {
					cueList = {
						111030002
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1110329] = {
		bhEvent = "skill.1110329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111030005,
						111030006,
						111031003
					}
				}
			},
			{
				boxId = 1110329,
				state = {
					duration = 4,
					stateId = 1110304
				},
				hitCue = {
					cueList = {
						111030007
					}
				}
			},
			{
				boxId = 1110330,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1110331,
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[4] = {
						boxId = 1110331
					},
					[5] = {
						boxId = 1110331
					},
					[6] = {
						boxId = 1110331
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1110303
				}
			},
			[1002] = {
				boxId = 1110332,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {}
			},
			[1004] = {
				boxId = 1110333,
				targetArea = 3,
				targetChoose = 7,
				state = {}
			},
			[11] = {
				state = {}
			},
			[10] = {
				state = {}
			},
			[90] = {
				state = {}
			}
		}
	},
	[1110310] = {
		bhEvent = "skill.1110310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111030003,
						111031002,
						111030014
					}
				}
			},
			{
				boxId = 1110309,
				state = {
					duration = 4,
					stateId = 1110304
				},
				hitCue = {
					cueList = {
						111030004
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
