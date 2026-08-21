-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12006.lua

local Data = {
	cueFile = "12006",
	[1200609] = {
		bhEvent = "skill.1200609",
		atkEvents = {
			[0] = {
				boxId = 1200609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1200660,
				addManaNumber = -5,
				delay = 0.15,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120060001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120060001,
						120061001
					}
				}
			}
		}
	},
	[1200610] = {
		bhEvent = "skill.1200610",
		atkEvents = {
			[0] = {
				boxId = 1200609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120060002,
						120061002
					}
				}
			}
		}
	},
	[1200629] = {
		bhEvent = "skill.1200629",
		atkEvents = {
			[0] = {
				boxId = 1200629,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120060005
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -15
					},
					[3] = {
						addManaNumber = -15
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120060004,
						120061003
					}
				}
			}
		}
	},
	[1200659] = {
		actTime = 78,
		skillTarget = 1,
		bhEvent = "skill.1200659",
		atkEvents = {
			[0] = {
				boxId = 1200651,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1200601
				},
				hitCue = {
					cueList = {
						10000001,
						10000008
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1200602
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1200602
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120060007,
						120060006,
						120060008,
						120061004
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
