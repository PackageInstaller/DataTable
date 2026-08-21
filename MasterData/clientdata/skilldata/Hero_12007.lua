-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12007.lua

local Data = {
	cueFile = "12007",
	[1200709] = {
		bhEvent = "skill.1200709",
		atkEvents = {
			[0] = {
				boxId = 1200709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120070003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120070001,
						120071003
					}
				}
			}
		}
	},
	[1200710] = {
		bhEvent = "skill.1200710",
		atkEvents = {
			[0] = {
				boxId = 1200709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120070003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120070002,
						120071004
					}
				}
			}
		}
	},
	[1200759] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 75,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 45,
		actTime = 65,
		bhEvent = "skill.1200759",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120070006,
						120070007,
						10005010
					}
				}
			},
			[0] = {
				hitedAnim = "Hit",
				boxId = 1200759,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				},
				atkCue = {
					cueList = {
						120073001
					}
				},
				hitCue = {
					cueList = {
						120070008,
						10006003
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1200703
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120075001,
						120070009
					}
				}
			},
			[33] = {
				state = {},
				hitCue = {
					cueList = {
						120071002
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120078001,
				120071001
			}
		}
	},
	[1200729] = {
		bhEvent = "skill.1200729",
		atkEvents = {
			[0] = {
				boxId = 1200729,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120070005
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1200701
				},
				atkCue = {
					cueList = {
						120070004,
						120071005
					}
				}
			},
			[101] = {
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1200730,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1002] = {
				boxId = 1200731,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1003] = {
				controlTime = 2,
				controlAniName = "freeze",
				eventProbId = 1200702,
				state = {}
			},
			[2] = {
				eventCondition = "1,1,1200711",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1000004,
						1500101
					}
				}
			},
			{
				eventCondition = "1,1,1200711",
				targetArea = 3,
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
