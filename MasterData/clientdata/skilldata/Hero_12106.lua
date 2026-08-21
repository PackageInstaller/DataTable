-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12106.lua

local Data = {
	cueFile = "12106",
	[1210609] = {
		bhEvent = "skill.1210609",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121060001,
						121061001
					}
				}
			},
			{
				boxId = 1210609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121060002
					}
				}
			}
		}
	},
	[1210611] = {
		bhEvent = "skill.1210611",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121060004,
						121061003
					}
				}
			},
			[101] = {
				state = {}
			},
			{
				unitDelay = 0.16,
				boxId = 1210609,
				flyCueId = 121060006,
				boxType = 1,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1210602
				},
				hitCue = {
					cueList = {
						121060005
					}
				}
			},
			{
				unitDelay = 0.16,
				boxId = 1210609,
				flyCueId = 121060007,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1210602
				},
				hitCue = {
					cueList = {
						121060005
					}
				}
			},
			[99] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210604
					}
				}
			}
		}
	},
	[1210629] = {
		skillTarget = 2,
		bhEvent = "skill.1210629",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 1.5,
					stateId = 1210605
				}
			},
			{
				boxId = 1210629,
				targetChoose = 9,
				state = {
					duration = -999,
					stateId = 1210602
				},
				hitCue = {
					cueList = {
						121060009
					}
				}
			},
			[1001] = {
				subEventSkill = 1210629,
				stunTime = 2,
				boxId = 1210630,
				subEventId = 1002,
				eventCondition = "1,1,1210601",
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210602
					}
				},
				hitCue = {
					cueList = {
						121060011,
						121060012,
						121061004
					}
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventSkill = 1210629,
				state = {
					duration = 2,
					stateId = 1210603
				}
			},
			[1003] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1210631
					},
					[3] = {
						boxId = 1210631
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				boxType = 1,
				delay = 0.1,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			[1005] = {
				boxType = 1,
				delay = 0.2,
				boxId = 1210632,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						121060010
					}
				}
			},
			[1006] = {
				controlTime = 1,
				targetArea = 2,
				controlAniName = "Float",
				targetChoose = 3,
				state = {}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						121066001
					}
				}
			},
			[12] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121066001
					}
				}
			},
			[101] = {
				targetChoose = 9,
				state = {},
				atkCue = {
					cueList = {
						121060008,
						121061005
					}
				}
			}
		}
	},
	[1210659] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 55,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1210659",
		atkEvents = {
			[100] = {
				targetChoose = 4,
				state = {},
				atkCue = {
					cueList = {
						121060015,
						121060017,
						121060018
					}
				}
			},
			{
				boxId = 1210659,
				targetChoose = 4,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						121060020
					}
				}
			},
			{
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				eventCondition = "1,1,1210653",
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				eventCondition = "1,1,1210654",
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				eventCondition = "1,1,1210655",
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1210651
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1210651
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1210651
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1210651
						}
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1210652
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1210652
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210653
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210654
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210655
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121060024,
						121065001,
						121061007
					}
				}
			},
			[30] = {
				state = {},
				hitCue = {
					cueList = {
						121060019
					}
				}
			},
			[21] = {
				state = {},
				atkCue = {
					cueList = {
						121066001
					}
				}
			},
			[22] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121060016
					}
				}
			},
			[23] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				121068001,
				121061006
			}
		}
	},
	[1210610] = {
		bhEvent = "skill.1210610",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121060003,
						121061002
					}
				}
			},
			{
				boxId = 1210609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121060002
					}
				}
			}
		}
	},
	[1210660] = {
		actTime = 85,
		hideEffect = 1,
		bhEvent = "skill.1210660",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				boxId = 1210659,
				targetChoose = 4,
				state = {}
			},
			{
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1210602
				}
			},
			{
				state = {}
			},
			[99] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121065001
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
