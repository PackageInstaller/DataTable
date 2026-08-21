-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14006.lua

local Data = {
	cueFile = "14006",
	[1400609] = {
		bhEvent = "skill.1400609",
		atkEvents = {
			[0] = {
				boxId = 1400609,
				unitDelay = 0.12,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140060001,
						140061001
					}
				},
				hitCue = {
					cueList = {
						140060003
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						140060002
					}
				}
			}
		}
	},
	[1400629] = {
		bhEvent = "skill.1400629",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1400601
				},
				atkCue = {
					cueList = {
						140060008,
						140061005
					}
				}
			},
			[0] = {
				randomTargetNumber = 2,
				boxId = 1400629,
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				flyCueId = 140060009,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						140060010,
						140061006
					}
				}
			},
			[1001] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1400659] = {
		hideTime = 10,
		hideEvent = 2,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 70,
		bhEvent = "skill.1400659",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140060005,
						140060011
					}
				}
			},
			[2] = {
				boxId = 1400659,
				targetChoose = 7,
				hitedAnim = "Hit",
				eventType = 1,
				state = {
					stateProbId = 1400601,
					stateId = 1000003,
					duration = 8
				},
				atkCue = {
					cueList = {
						140063001
					}
				},
				hitCue = {
					cueList = {
						140060006,
						140061004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = -15
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[21] = {
				state = {},
				atkCue = {
					cueList = {
						140060007,
						140065001
					}
				}
			},
			[22] = {
				delay = 0.5,
				flyCueId = 140060012,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						140060013,
						140063001
					}
				}
			},
			[1001] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 3
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[3] = {
				targetChoose = 7,
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {}
			},
			[1002] = {
				boxId = 1400660,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140060006
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				140068001,
				140061003
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
