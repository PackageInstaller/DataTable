-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13008.lua

local Data = {
	cueFile = "13008",
	[1300801] = {
		bhEvent = "skill.1300801",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 1300801,
				flyCueId = 130080026,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080027,
						130081004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130080025,
						130081003
					}
				}
			}
		}
	},
	[1300851] = {
		actTime = 75,
		bhEvent = "skill.1300851",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1300801
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 12,
							stateId = 1300801
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1300801
						}
					},
					[5] = {
						state = {
							duration = 10,
							stateId = 1300801
						}
					},
					[6] = {
						state = {
							duration = 10,
							stateId = 1300801
						}
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130080033,
						130081007
					}
				}
			},
			{
				targetArea = 3,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1300851,
				delay = 0.2,
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
	[1300802] = {
		bhEvent = "skill.1300802",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1300802,
				flyCueId = 130080030,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080031,
						130081006
					}
				}
			},
			{
				targetArea = 3,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130080028,
						130080029,
						130081005
					}
				}
			}
		}
	},
	[1300821] = {
		bhEvent = "skill.1300821",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1300821,
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080032
					}
				},
				levelAtkEvents = {
					[2] = {
						controlTime = 3,
						controlAniName = "freeze"
					},
					[3] = {
						controlTime = 3,
						controlAniName = "freeze"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1300803] = {
		bhEvent = "skill.1300803",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130080028,
						130080029,
						130081005
					}
				}
			},
			[2] = {
				state = {}
			},
			{
				unitDelay = 0.05,
				boxId = 1300802,
				flyCueId = 130080035,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130080031,
						130081006
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
