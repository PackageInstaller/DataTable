-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12101.lua

local Data = {
	cueFile = "12101",
	[1210109] = {
		bhEvent = "skill.1210109",
		atkEvents = {
			{
				boxId = 1210109,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1210102
				},
				hitCue = {
					cueList = {
						121010011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121010009,
						121011001
					}
				}
			}
		}
	},
	[1210110] = {
		bhEvent = "skill.1210110",
		atkEvents = {
			{
				boxId = 1210109,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1210102
				},
				hitCue = {
					cueList = {
						121010011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121010010,
						121011002
					}
				}
			}
		}
	},
	[1210159] = {
		actTime = 48,
		bhEvent = "skill.1210159",
		atkEvents = {
			{
				boxId = 1210160,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1210101
						}
					},
					[4] = {
						state = {
							duration = 2,
							stateId = 1210101
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				boxId = 1210159,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1210102
				},
				hitCue = {
					cueList = {
						121010015,
						10006003
					}
				}
			},
			{
				boxId = 1210163,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1210162,
				delay = 0.3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121010008
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121010013,
						121010014,
						121011003
					}
				}
			}
		}
	},
	[1210129] = {
		bhEvent = "skill.1210129",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				boxId = 1210129,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						121010012
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 20,
						hitCue = {
							cueList = {
								10000025,
								10000035
							}
						}
					},
					[3] = {
						addManaNumber = 20,
						hitCue = {
							cueList = {
								10000025,
								10000035
							}
						}
					},
					[4] = {
						addManaNumber = 30,
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[5] = {
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[6] = {
						hitCue = {
							cueList = {
								10000025
							}
						}
					}
				}
			},
			{
				state = {}
			},
			[1002] = {
				boxId = 1210130,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
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
