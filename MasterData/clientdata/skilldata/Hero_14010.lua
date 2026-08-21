-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14010.lua

local Data = {
	cueFile = "14010",
	[1401009] = {
		bhEvent = "skill.1401009",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140100001
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxId = 1401001,
				flyCueId = 140100002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140100003
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1401059] = {
		actTime = 81,
		bhEvent = "skill.1401059",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140100004
					}
				}
			},
			[0] = {
				flyCueId = 140100005,
				boxId = 1401051,
				unitDelay = 0.12,
				boxType = 1,
				subEventId = 1001,
				eventType = 1,
				subEventSkill = 1401059,
				state = {},
				hitCue = {
					cueList = {
						140100006
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1401001
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1401051,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				subEventSkill = 1401059,
				eventType = 1,
				subEventId = 1002,
				flyCueId = 140100007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						140100008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1401001
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				boxId = 1401051,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				subEventSkill = 1401059,
				eventType = 1,
				subEventId = 1003,
				flyCueId = 140100007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						140100008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1401001
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxId = 1401051,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 140100007,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						140100008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1401001
						}
					},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1401029] = {
		skillTarget = 1,
		bhEvent = "skill.1401029",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140100009
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1401021,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000025,
						140100011
					}
				}
			},
			[1001] = {
				boxType = 1,
				delay = 0.5,
				boxId = 1401021,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1401002
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1401002
						}
					},
					[4] = {
						delay = 0.2
					},
					[5] = {
						delay = 0.2
					},
					[6] = {
						delay = 0.2
					}
				}
			},
			[1002] = {
				addManaNumber = 6,
				targetArea = 3,
				state = {}
			},
			[0] = {
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
