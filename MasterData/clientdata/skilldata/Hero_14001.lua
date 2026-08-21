-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14001.lua

local Data = {
	cueFile = "33108",
	[1400109] = {
		bhEvent = "skill.1400109",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1400109,
				flyCueId = 331080002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080003,
						331081002
					}
				}
			},
			{
				unitDelay = 0.08,
				flyCueId = 331080002,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080003,
						331081002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080001,
						331081001
					}
				}
			}
		}
	},
	[1400110] = {
		bhEvent = "skill.1400110",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1400109,
				flyCueId = 90010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080001,
						130081002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140010002
					}
				}
			},
			{
				unitDelay = 0.08,
				boxType = 1,
				flyCueId = 140010003,
				boxId = 1400109,
				state = {},
				hitCue = {
					cueList = {
						140010005
					}
				}
			}
		}
	},
	[1400129] = {
		actTime = 40,
		bhEvent = "skill.1400129",
		atkEvents = {
			[0] = {
				targetArea = 2,
				boxType = 1,
				flyCueId = 90010021,
				delay = 0.5,
				targetChoose = 4,
				boxId = 1400129,
				state = {},
				hitCue = {
					cueList = {
						331080001
					}
				}
			},
			[1001] = {
				targetArea = 3,
				boxId = 1400129,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1400102
				}
			},
			[1003] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1400159] = {
		actTime = 60,
		hideEvent = 100,
		bhEvent = "skill.1400159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331080015,
						331081003
					}
				}
			},
			[1001] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			{
				eventType = 1,
				state = {
					duration = 10,
					stateId = 1400101
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1400101
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1400101
						}
					},
					[5] = {
						state = {
							duration = 15,
							stateId = 1400101
						}
					},
					[6] = {}
				}
			},
			[11] = {
				unitDelay = 0.12,
				boxId = 1400159,
				flyCueId = 331080017,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331080016,
						331081004
					}
				}
			},
			[12] = {
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
