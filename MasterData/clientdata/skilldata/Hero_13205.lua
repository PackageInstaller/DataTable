-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13205.lua

local Data = {
	cueFile = "13205",
	[1320509] = {
		bhEvent = "skill.1320509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132050001,
						132051001
					}
				}
			},
			{
				delay = 0.18,
				boxId = 1320509,
				flyCueId = 132050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132050004,
						132051003
					}
				}
			}
		}
	},
	[1320510] = {
		bhEvent = "skill.1320510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132050002,
						132051002
					}
				}
			},
			{
				delay = 0.18,
				boxId = 1320509,
				flyCueId = 132050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132050004,
						132051003
					}
				}
			}
		}
	},
	[1320559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 46,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 45,
		actTime = 90,
		bhEvent = "skill.1320559",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						132050008,
						132050009,
						132050013,
						132055001
					}
				}
			},
			{
				delay = 0.3,
				boxId = 1320559,
				flyCueId = 132050010,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000001
				},
				hitCue = {
					cueList = {
						132050011,
						132053001,
						132051008
					}
				}
			},
			[1001] = {
				boxId = 1320561,
				eventCondition = "1,2,1000001",
				eventType = 1,
				state = {}
			},
			{
				randomTargetNumber = 1,
				boxId = 1320560,
				targetChoose = 3,
				state = {
					duration = 1,
					stateId = 1320501
				},
				hitCue = {
					cueList = {
						132050012,
						132051009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						stunTime = 0.5
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1320502
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1320502
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						132050014,
						132055002,
						132051007
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				stunTime = 0.5,
				boxId = 1320562,
				targetChoose = 23,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						132050012,
						132051009
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				132058001,
				132051006
			}
		}
	},
	[1320529] = {
		bhEvent = "skill.1320529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132050005,
						132051004
					}
				}
			},
			{
				flyCueId = 132050006,
				boxId = 1320529,
				delay = 0.3,
				boxType = 1,
				eventType = 1,
				stunTime = 0.5,
				state = {},
				hitCue = {
					cueList = {
						132050007,
						132051005
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventSkill = 1320529,
						subEventId = 1001
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1320530,
						eventCondition = "1,2,1000001"
					},
					[3] = {
						boxId = 1320530,
						eventCondition = "1,2,1000001"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			{
				randomTargetNumber = 1,
				boxType = 1,
				stunTime = 0.5,
				delay = 0.2,
				boxId = 1320529,
				excludeTarget = 1,
				eventType = 1,
				eventCondition = "1,1,8791300",
				flyCueId = 132050006,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						132050007
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
