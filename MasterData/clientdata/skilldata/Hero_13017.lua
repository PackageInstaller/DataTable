-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13017.lua

local Data = {
	cueFile = "13017",
	[1301709] = {
		bhEvent = "skill.1301709",
		atkEvents = {
			{
				unitDelay = 0.16,
				boxId = 1301709,
				flyCueId = 130170002,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130170003,
						130171002
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130170001,
						130171001
					}
				}
			},
			[1001] = {
				boxId = 1301729,
				eventCondition = "1,1,1301714",
				eventType = 1,
				state = {}
			},
			[1002] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301709,
				subEventId = 1003,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301709,
				subEventId = 1004,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301709,
				subEventId = 1005,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301709,
				subEventId = 1006,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			}
		}
	},
	[1301710] = {
		bhEvent = "skill.1301710",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130170004,
						130171003
					}
				}
			},
			{
				unitDelay = 0.16,
				boxId = 1301709,
				flyCueId = 130170005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130170003,
						130171002
					}
				}
			}
		}
	},
	[1301729] = {
		bhEvent = "skill.1301729",
		atkEvents = {
			[100] = {
				state = {
					chooseStateMode = 2
				},
				atkCue = {
					cueList = {
						130170008,
						130171004
					}
				}
			},
			{
				unitDelay = 0.18,
				flyCueId = 130170010,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = 0.05,
					stateId = 1301707
				},
				hitCue = {
					cueList = {
						130170009
					}
				}
			},
			[1001] = {
				boxId = 1301729,
				eventCondition = "1,1,1301714,1",
				eventType = 1,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301701,
						1301702
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301702
				}
			},
			[1004] = {
				eventCondition = "1,1,1301702,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301701
				}
			},
			{
				unitDelay = 0.18,
				flyCueId = 130170011,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = 0.05,
					stateId = 1301707
				}
			},
			{
				unitDelay = 0.18,
				flyCueId = 130170012,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = 0.05,
					stateId = 1301707
				}
			},
			{
				unitDelay = 0.18,
				flyCueId = 130170013,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = 0.05,
					stateId = 1301707
				}
			},
			{
				boxType = 1,
				unitDelay = 0.18,
				flyCueId = 130170014,
				state = {
					duration = 0.05,
					stateId = 1301707
				}
			},
			[1005] = {
				unitDelay = 0.18,
				flyCueId = 130170021,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = 0.05,
					stateId = 1301707
				}
			},
			[1006] = {
				boxId = 1301770,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1007] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21301731
				}
			}
		}
	},
	[1301759] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 45,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1301759",
		atkEvents = {
			[1001] = {
				randomTargetNumber = 5,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			{
				boxId = 1301759,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130170018
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130170015,
						130170016
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1301711
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301759,
				subEventId = 1003,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301759,
				subEventId = 1004,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301759,
				subEventId = 1005,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				subEventSkill = 1301759,
				subEventId = 1006,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				delay = 0.3,
				boxId = 1301760,
				boxType = 1,
				eventType = 1,
				flyCueId = 130170006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130170007
					}
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = 8,
					stateId = 1000001
				}
			},
			[15] = {
				state = {},
				atkCue = {
					cueList = {
						130171006
					}
				},
				hitCue = {
					cueList = {
						130170017
					}
				}
			},
			[90] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130170019,
						130175001,
						130170001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130178001,
				130171005
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
