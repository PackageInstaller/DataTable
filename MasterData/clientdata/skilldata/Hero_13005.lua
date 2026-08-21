-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13005.lua

local Data = {
	cueFile = "13005",
	[1300509] = {
		bhEvent = "skill.1300509",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1300509,
				flyCueId = 130050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130050001,
						130051001
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1300510,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050006,
						10000057
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 5,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			}
		}
	},
	[1300510] = {
		bhEvent = "skill.1300510",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1300509,
				flyCueId = 130050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130050002,
						130051002
					}
				}
			}
		}
	},
	[1300559] = {
		actTime = 60,
		videoActTime = 52,
		bhEvent = "skill.1300559",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130050007,
						130050008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 2,
							stateId = 1300501
						}
					},
					[3] = {
						state = {
							duration = 2,
							stateId = 1300501
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130050012,
						130055001,
						130051004
					}
				}
			},
			{
				unitDelay = 0.08,
				flyCueId = 130050009,
				boxType = 1,
				subEventSkill = 1300559,
				subEventId = 1001,
				state = {},
				hitCue = {
					cueList = {
						130050010
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 3,
				state = {}
			},
			[1001] = {
				hitedAnim = "Hit",
				boxId = 1300559,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						130053001
					}
				},
				hitCue = {
					cueList = {
						130050011,
						10006009
					}
				}
			},
			[1002] = {
				boxId = 1300560,
				eventCondition = "1,2,1000001",
				eventType = 1,
				state = {}
			},
			[1003] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 82130051
				}
			}
		},
		videoActCue = {
			cueList = {
				130058001,
				130051005
			}
		}
	},
	[1300529] = {
		targetInherit = 1,
		bhEvent = "skill.1300529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130050005,
						130051003
					}
				}
			},
			[0] = {
				boxId = 1300529,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130050006
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 5
					},
					[3] = {
						addManaNumber = 5
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 5
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				delay = 0.1,
				boxId = 1300529,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						130050005
					}
				},
				hitCue = {
					cueList = {
						130050006,
						10000041
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 5,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1003] = {
				targetArea = 1,
				addManaNumber = 5,
				state = {},
				hitCue = {
					cueList = {
						10000035
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
