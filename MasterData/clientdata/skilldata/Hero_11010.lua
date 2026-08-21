-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11010.lua

local Data = {
	cueFile = "11010",
	[1101001] = {
		bhEvent = "skill.1101001",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110100001,
						110100003,
						110101001
					}
				}
			},
			{
				boxId = 1101001,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110100005
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1101002,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000042
					}
				}
			}
		}
	},
	[1101002] = {
		bhEvent = "skill.1101002",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110100002,
						110100004,
						110101002
					}
				}
			},
			{
				boxId = 1101001,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110100005
					}
				}
			}
		}
	},
	[1101021] = {
		bhEvent = "skill.1101021",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101001
				}
			},
			[1002] = {
				boxId = 1101021,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						110101003,
						110100006
					}
				}
			},
			[1003] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1004] = {
				boxId = 1101022,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						110101003,
						110100006
					}
				}
			},
			[1005] = {
				targetArea = 3,
				boxId = 1101022,
				targetChoose = 8,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						110101003,
						110100006
					}
				}
			},
			{
				state = {}
			},
			[1006] = {
				boxId = 1101023,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						110100006
					}
				}
			}
		}
	},
	[1101051] = {
		hideTime = 10,
		hideEvent = 99,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 84,
		bhEvent = "skill.1101051",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101006
				},
				atkCue = {
					cueList = {
						110100007,
						110100008,
						110100009,
						110100022
					}
				}
			},
			{
				randomTargetNumber = 1,
				unitDelay = 0.25,
				boxId = 1101051,
				targetArea = 2,
				boxType = 1,
				eventType = 1,
				excludeTarget = 1,
				flyCueId = 110100012,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						110100020,
						110101006
					}
				},
				hitCue = {
					cueList = {
						110100016
					}
				}
			},
			[1001] = {
				controlTime = 0.9,
				controlAniName = "freeze",
				state = {}
			},
			[1002] = {
				controlTime = 1.5,
				controlAniName = "freeze",
				state = {}
			},
			[1003] = {
				boxId = 1101052,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101007
				},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[4] = {
				randomTargetNumber = 1,
				unitDelay = 0.25,
				boxId = 1101051,
				targetArea = 2,
				boxType = 1,
				eventType = 1,
				excludeTarget = 1,
				flyCueId = 110100015,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						110100020,
						110101006
					}
				},
				hitCue = {
					cueList = {
						110100019
					}
				}
			},
			{
				randomTargetNumber = 1,
				unitDelay = 0.25,
				boxId = 1101051,
				targetArea = 2,
				boxType = 1,
				eventType = 1,
				excludeTarget = 1,
				flyCueId = 110100013,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						110100020,
						110101006
					}
				},
				hitCue = {
					cueList = {
						110100017
					}
				}
			},
			{
				randomTargetNumber = 1,
				unitDelay = 0.25,
				boxId = 1101051,
				targetArea = 2,
				boxType = 1,
				eventType = 1,
				excludeTarget = 1,
				flyCueId = 110100014,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						110100020,
						110101006
					}
				},
				hitCue = {
					cueList = {
						110100018
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110100010,
						110100011
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110105001,
						110100021,
						110101005
					}
				}
			},
			[99] = {
				targetChoose = 3,
				targetArea = 2,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110108001,
				110101004
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
