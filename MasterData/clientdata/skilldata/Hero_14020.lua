-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14020.lua

local Data = {
	cueFile = "14020",
	[1402009] = {
		bhEvent = "skill.1402009",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140200001,
						140201001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1402009,
				flyCueId = 140200003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140200002,
						140201002
					}
				}
			},
			[1001] = {
				boxId = 1402010,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1402010] = {
		bhEvent = "skill.1402010",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1402009,
				flyCueId = 140200003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140200002,
						140201002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140200001,
						140201001
					}
				}
			}
		}
	},
	[1402029] = {
		actTime = 60,
		bhEvent = "skill.1402029",
		atkEvents = {
			{
				targetChoose = 23,
				state = {
					duration = 2,
					stateId = 1402001
				},
				hitCue = {
					cueList = {
						140201004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140200004,
						140200005,
						140201003
					}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402003
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140200006
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				eventCondition = "1,1,1402021,1",
				state = {
					duration = 0.1,
					stateId = 1402005
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1402005
				}
			},
			{
				targetChoose = 10,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1402006
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1402006
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				state = {
					duration = 8,
					stateId = 1402007
				}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1402005
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402020
				}
			},
			[1005] = {
				state = {
					duration = 0.1,
					stateId = 1402005
				}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791611
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = 2,
					stateId = 1402001
				}
			},
			[1008] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21402011
				}
			},
			[1009] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21402031
				}
			}
		}
	},
	[1402059] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 55,
		prepareCamera = 1,
		prepareCamDruation = 55,
		actTime = 100,
		bhEvent = "skill.1402059",
		atkEvents = {
			{
				boxId = 1402059,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140200010,
						140200013,
						140203001,
						140201007
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140200011,
						140200012,
						140200001
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140205001,
						140200014,
						140201006
					}
				},
				hitCue = {
					cueList = {
						140200009
					}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 0.5,
					stateId = 1402011
				}
			},
			[1001] = {
				boxId = 1402060,
				targetArea = 1,
				state = {
					duration = 10,
					stateId = 1402012
				}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 1,
				state = {
					duration = 0.5,
					stateId = 1402013
				}
			},
			[1003] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1402012
					}
				},
				levelAtkEvents = {
					[2] = {
						boxId = 1402060
					},
					[3] = {
						boxId = 1402060
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				targetArea = 1,
				state = {
					duration = 9.5,
					stateId = 1402014
				}
			},
			[1005] = {
				targetChoose = 23,
				state = {
					duration = 10,
					stateId = 21402021
				}
			},
			[1006] = {
				targetArea = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1402060
					},
					[3] = {
						boxId = 1402060
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				eventCondition = "1,1,1402032",
				state = {
					duration = 0.5,
					stateId = 1402031
				}
			},
			[1007] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402032
				}
			},
			[1008] = {
				boxId = 1402060,
				targetArea = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140208001,
				140201005
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
