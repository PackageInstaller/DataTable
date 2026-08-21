-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11014.lua

local Data = {
	cueFile = "11014",
	[1101409] = {
		bhEvent = "skill.1101409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110140001,
						110141001
					}
				}
			},
			{
				boxId = 1101401,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110140003
					}
				}
			}
		}
	},
	[1101421] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1101421",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110140004,
						110141003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101401
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101402
				}
			},
			[1001] = {
				boxId = 1101421,
				targetArea = 3,
				eventCondition = "1,1,1101402",
				state = {
					delLayer = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101403
				},
				levelAtkEvents = {
					[2] = {
						boxId = 1101422
					},
					[3] = {
						boxId = 1101422
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				boxId = 1101423,
				targetArea = 3,
				state = {}
			},
			{
				state = {}
			},
			[1003] = {
				delay = 0.2,
				targetArea = 3,
				boxType = 1,
				state = {
					stateOperation = 4,
					stateId = 1101402,
					chooseStateMode = 2,
					delLayer = 1,
					chooseStateIds = {
						1101402
					}
				}
			},
			[1004] = {
				boxId = 1101427,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				boxId = 1101428,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 15,
					stateId = 1101402
				}
			},
			[1007] = {
				targetArea = 3,
				eventCondition = "1,1,1101402",
				boxId = 1101429,
				targetChoose = 9,
				excludeTarget = 1,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				boxId = 1101429,
				targetChoose = 9,
				excludeTarget = 1,
				state = {}
			}
		}
	},
	[1101422] = {
		bhEvent = "skill.1101422",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110140006,
						110141004
					}
				}
			},
			[1001] = {
				targetChoose = 23,
				stunTime = 5,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101451
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101452
				}
			},
			{
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1101453
				}
			},
			[1003] = {
				subEventId = 1004,
				subEventSkill = 1101422,
				boxId = 1101424,
				targetChoose = 23,
				state = {}
			},
			[1004] = {
				boxId = 1101425,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				boxId = 1101426,
				targetChoose = 23,
				disablePassive = 1,
				state = {}
			}
		}
	},
	[1101459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 50,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 120,
		bhEvent = "skill.1101459",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110140010
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101402
				}
			},
			{
				boxId = 1101422,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110143001
					}
				},
				hitCue = {
					cueList = {
						110140011
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110140012,
						110145001,
						110141006
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101421
				}
			}
		},
		videoActCue = {
			cueList = {
				110148001,
				110141005
			}
		}
	},
	[1101410] = {
		bhEvent = "skill.1101410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110140002,
						110141002
					}
				}
			},
			{
				boxId = 1101401,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110140003
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
