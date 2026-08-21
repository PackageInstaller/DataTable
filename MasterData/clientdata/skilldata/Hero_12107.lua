-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12107.lua

local Data = {
	cueFile = "12107",
	[1210709] = {
		bhEvent = "skill.1210709",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121070001,
						121071001
					}
				}
			},
			{
				boxId = 1210709,
				state = {},
				hitCue = {
					cueList = {
						121070002
					}
				}
			}
		}
	},
	[1210729] = {
		bhEvent = "skill.1210729",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1210701
				}
			},
			{
				boxId = 1210729,
				state = {}
			},
			[90] = {
				targetArea = 3,
				state = {
					chooseStateType = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1001] = {
				boxType = 1,
				delay = 0.7,
				subEventSkill = 1210729,
				boxId = 1210729,
				targetChoose = 23,
				subEventId = 1002,
				state = {},
				hitCue = {
					cueList = {
						121070006
					}
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventSkill = 1210729,
				boxId = 1210730,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				subEventId = 1004,
				targetChoose = 23,
				subEventSkill = 1210729,
				state = {
					duration = -999,
					stateId = 1210701
				}
			},
			[1004] = {
				eventCondition = "1,1,1210711",
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1210712
				}
			},
			[1005] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						121071003
					}
				},
				hitCue = {
					cueList = {
						121070005
					}
				}
			}
		}
	},
	[1210759] = {
		hideEffect = 1,
		actTime = 89,
		videoActTime = 60,
		hideTime = 10,
		hideEvent = 4,
		bhEvent = "skill.1210759",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1210751,
					chooseStateMode = 2
				},
				atkCue = {
					cueList = {
						121070018,
						121075001,
						121070007,
						121070008,
						121070009,
						121070010,
						121070013,
						121070016,
						121070017,
						121071006
					}
				}
			},
			[2] = {
				state = {
					duration = 1,
					stateId = 1210752
				}
			},
			{
				boxId = 1210759,
				hitedAnim = "HIT",
				state = {},
				hitCue = {
					cueList = {
						121070011,
						121073001
					}
				}
			},
			[3] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 7,
							stateId = 1210754
						}
					},
					[3] = {
						state = {
							duration = 7,
							stateId = 1210754
						}
					},
					[4] = {
						state = {
							duration = 7
						}
					},
					[5] = {
						state = {
							duration = 7
						}
					},
					[6] = {
						state = {
							duration = 7
						}
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121070019,
						121075002,
						121071005
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[4] = {
				state = {},
				hitCue = {
					cueList = {
						121070012
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				121078001,
				121071004
			}
		}
	},
	[1210710] = {
		bhEvent = "skill.1210710",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121070003,
						121071002
					}
				}
			},
			{
				boxId = 1210709,
				state = {},
				hitCue = {
					cueList = {
						121070004
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
