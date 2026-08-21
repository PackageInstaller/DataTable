-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13112.lua

local Data = {
	cueFile = "13112",
	[1311209] = {
		bhEvent = "skill.1311209",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131120001,
						131121001
					}
				}
			},
			{
				randomTargetNumber = 1,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 0.1,
					stateId = 1311205
				},
				hitCue = {
					cueList = {
						131120002,
						131121002
					}
				}
			}
		}
	},
	[1311229] = {
		bhEvent = "skill.1311229",
		atkEvents = {
			{
				state = {}
			},
			[1001] = {
				targetArea = 3,
				eventCondition = "1,1,1311215",
				eventProbId = 1311202,
				state = {
					duration = -999,
					stateId = 1311216
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventSkill = 1311229,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1311213
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1311216
					}
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350430,
						8350431
					}
				}
			},
			[1005] = {
				boxId = 1311231,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				boxId = 1311229,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				addManaNumber = 2,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1311259] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 24,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 75,
		bhEvent = "skill.1311259",
		atkEvents = {
			[1001] = {
				boxId = 1311209,
				eventType = 1,
				state = {}
			},
			[1002] = {
				eventType = 1,
				boxId = 1311260,
				eventProbId = 1311203,
				state = {},
				hitCue = {
					cueList = {
						131120009,
						131121005
					}
				}
			},
			[1003] = {
				eventType = 1,
				eventCondition = "1,1,1311212",
				eventProbId = 1311204,
				state = {
					duration = 0.1,
					stateId = 1311211
				},
				hitCue = {
					cueList = {
						131120009,
						131121005
					}
				}
			},
			[1004] = {
				boxId = 1311259,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1311213
				}
			},
			[1005] = {
				eventCondition = "1,1,1311214",
				boxId = 1311230,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131120004,
						131121004
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				boxId = 1311230,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131120004,
						131121004
					}
				}
			},
			{
				randomTargetNumber = 2,
				targetChoose = 7,
				state = {
					duration = 0.1,
					stateId = 1311211
				},
				hitCue = {
					cueList = {
						131120009,
						131121005
					}
				}
			},
			[1007] = {
				randomTargetNumber = 2,
				targetChoose = 7,
				state = {
					duration = 0.1,
					stateId = 1311221
				},
				hitCue = {
					cueList = {
						131120009,
						131121005
					}
				}
			},
			[1008] = {
				state = {
					duration = 5,
					stateId = 1311222
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131120005,
						131120006,
						131120007,
						131121006
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131125001,
						131120010
					}
				}
			},
			[15] = {
				state = {},
				atkCue = {
					cueList = {
						131123001
					}
				},
				hitCue = {
					cueList = {
						131120008
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				131128001,
				131121007
			}
		}
	},
	[1311210] = {
		bhEvent = "skill.1311210",
		atkEvents = {
			{
				randomTargetNumber = 1,
				targetChoose = 7,
				state = {
					duration = 0.1,
					stateId = 1311205
				},
				hitCue = {
					cueList = {
						131120003,
						131121003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131120001,
						131121001
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
