-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12105.lua

local Data = {
	cueFile = "12105",
	[1210509] = {
		bhEvent = "skill.1210509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121050001,
						121051001,
						121051002
					}
				}
			},
			{
				boxId = 1210509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121050002
					}
				}
			}
		}
	},
	[1210510] = {
		bhEvent = "skill.1210510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121050003,
						121051003,
						121051004
					}
				}
			},
			{
				boxId = 1210509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121050002
					}
				}
			}
		}
	},
	[1210529] = {
		bhEvent = "skill.1210529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121050005,
						121051005
					}
				}
			},
			{
				boxId = 1210529,
				eventType = 1,
				state = {}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1210529,
				boxId = 1210530,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxId = 1210531,
				targetArea = 3,
				state = {}
			},
			[10] = {
				state = {},
				hitCue = {
					cueList = {
						121050006,
						121051006
					}
				}
			}
		}
	},
	[1210559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 38,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 95,
		bhEvent = "skill.1210559",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1210501
				}
			},
			{
				subEventId = 1001,
				eventCondition = "1,2,1000001",
				subEventSkill = 1210559,
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1210502
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1210502
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121050010,
						121050011,
						121050012,
						121050014,
						121055001
					}
				}
			},
			{
				subEventId = 1002,
				subEventSkill = 1210559,
				boxId = 1210559,
				eventType = 1,
				state = {}
			},
			[10] = {
				state = {},
				hitCue = {
					cueList = {
						121050013,
						121053001
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						121051009,
						121050015,
						121055002
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8350231
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				121058001,
				121051010
			}
		}
	},
	[1210530] = {
		actTime = 56,
		skillTarget = 1,
		bhEvent = "skill.1210530",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121050007,
						121051007
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1210510
				},
				atkCue = {
					cueList = {
						121050008
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210511
				},
				atkCue = {
					cueList = {
						121051008
					}
				}
			},
			[1002] = {
				boxId = 1210532,
				targetChoose = 3,
				state = {}
			},
			[1003] = {
				boxId = 1210533,
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
