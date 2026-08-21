-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32106.lua

local Data = {
	cueFile = "32106",
	[3210601] = {
		bhEvent = "skill.3210601",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060001,
						321061001
					}
				}
			},
			{
				boxId = 3210601,
				state = {},
				hitCue = {
					cueList = {
						321060004
					}
				}
			}
		}
	},
	[3210602] = {
		bhEvent = "skill.3210602",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060002,
						321061002
					}
				}
			},
			{
				boxId = 3210601,
				state = {},
				hitCue = {
					cueList = {
						321060005
					}
				}
			}
		}
	},
	[3210603] = {
		bhEvent = "skill.3210603",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3210604
				},
				atkCue = {
					cueList = {
						321060003,
						321061003
					}
				}
			},
			{
				boxId = 3210603,
				state = {},
				hitCue = {
					cueList = {
						321060006
					}
				}
			}
		}
	},
	[3210621] = {
		bhEvent = "skill.3210621",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060008,
						321061004
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210621,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						321060009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210601
				}
			}
		}
	},
	[3210622] = {
		bhEvent = "skill.3210622",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060008,
						321061004
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210622,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						321060009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210601
				}
			}
		}
	},
	[3210651] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3210651",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3210613
				},
				atkCue = {
					cueList = {
						321060010,
						321061005
					}
				}
			},
			[2] = {
				boxId = 3210660,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				boxId = 3210651,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210602
				}
			},
			[1001] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						10000057
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3210607
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3210608
				}
			},
			[3] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3210609
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3210611
				}
			}
		}
	},
	[3210652] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.3210652",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060012,
						321060013,
						321061006
					}
				}
			},
			[2] = {
				controlTime = 5,
				targetArea = 2,
				controlAniName = "timelock",
				targetChoose = 7,
				state = {}
			},
			[3] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3210611
					}
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210612
				}
			},
			{
				boxId = 3210652,
				targetChoose = 7,
				state = {}
			}
		}
	},
	[3210653] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3210653",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060015,
						321061007
					}
				}
			},
			{
				eventCondition = "1,2,3210610",
				unitDelay = 0.12,
				boxId = 3210653,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						321061008
					}
				}
			},
			{
				controlTime = 5,
				unitDelay = 0.12,
				boxType = 1,
				eventCondition = "1,2,3210610",
				flyCueId = 321060016,
				controlAniName = "timelock",
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						321060017
					}
				}
			},
			[10] = {
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 3210610
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3210611
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210612
				}
			}
		}
	},
	[3210654] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3210654",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						321060010,
						321061005
					}
				}
			},
			{
				boxId = 3210655,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210615
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 3210618
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3210618
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3210617
				}
			}
		}
	},
	[3210604] = {
		bhEvent = "skill.3210604",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060001,
						321061001
					}
				}
			},
			{
				boxId = 3210604,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321060004
					}
				}
			}
		}
	},
	[3210605] = {
		bhEvent = "skill.3210605",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060002,
						321061002
					}
				}
			},
			{
				boxId = 3210604,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321060005
					}
				}
			}
		}
	},
	[3210623] = {
		bhEvent = "skill.3210623",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060008,
						321061004
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210623,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321060009
					}
				}
			}
		}
	},
	[3210655] = {
		actTime = 40,
		bhEvent = "skill.3210655",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321060012,
						321060013,
						321061006
					}
				}
			},
			{
				boxId = 3210654,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			{
				controlTime = 1,
				targetChoose = 7,
				controlAniName = "timelock",
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
