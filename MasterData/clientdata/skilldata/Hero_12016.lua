-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12016.lua

local Data = {
	cueFile = "12016",
	[1201609] = {
		bhEvent = "skill.1201609",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120160001,
						120161001
					}
				}
			},
			[0] = {
				boxId = 1201609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120160002
					}
				}
			}
		}
	},
	[1201610] = {
		bhEvent = "skill.1201610",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120160003,
						120161002
					}
				}
			},
			[0] = {
				boxId = 1201609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120160002
					}
				}
			}
		}
	},
	[1201629] = {
		actTime = 58,
		skillTarget = 1,
		bhEvent = "skill.1201629",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120160004,
						120161003
					}
				}
			},
			[0] = {
				targetChoose = 9,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						120160005
					}
				}
			},
			{
				targetChoose = 9,
				subEventId = 1003,
				subEventSkill = 1201629,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1201601
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1201629,
				delay = 0.1,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				delay = 0.1,
				boxId = 1201630,
				boxType = 1,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1201602
				}
			},
			[1004] = {
				boxId = 1201631,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1005] = {
				boxId = 1201632,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21201621
				}
			},
			[1007] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21201631
				}
			}
		}
	},
	[1201659] = {
		hideEffect = 1,
		actTime = 90,
		videoActTime = 50,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1201659",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						120160007
					}
				}
			},
			[101] = {
				state = {},
				baseCue = {
					cueList = {
						120160008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120160010,
						120165001,
						120161005
					}
				}
			},
			[102] = {
				state = {},
				atkCue = {
					cueList = {
						120163001
					}
				},
				baseCue = {
					cueList = {
						120160009
					}
				}
			},
			[103] = {
				targetChoose = 3,
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						120163001
					}
				}
			},
			[104] = {
				hitedAnim = "Hit",
				targetChoose = 3,
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 3,
				state = {}
			},
			[91] = {
				hitedAnim = "Hit",
				targetChoose = 3,
				state = {}
			},
			[0] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201604
					}
				}
			},
			{
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			{
				boxId = 1201659,
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5.1,
							stateId = 1201603
						}
					},
					[3] = {
						subEventId = 1001,
						subEventSkill = 1201659,
						state = {
							duration = 5.1,
							stateId = 1201603
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
					duration = 6,
					stateId = 1201604
				}
			},
			[1002] = {
				boxId = 1201660,
				eventType = 1,
				state = {}
			},
			[1003] = {
				targetChoose = 7,
				state = {
					duration = 5.1,
					stateId = 1201603
				}
			},
			[1004] = {
				targetChoose = 7,
				targetArea = 3,
				eventCondition = "1,2,1201602",
				state = {
					duration = 5,
					stateId = 8791632
				}
			},
			[1005] = {
				targetArea = 3,
				boxId = 1201661,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1006] = {
				subEventId = 1007,
				targetChoose = 3,
				subEventSkill = 1201659,
				state = {}
			},
			[1007] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201608
				}
			},
			[1008] = {
				boxId = 1201662,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120168001,
				120161004
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
