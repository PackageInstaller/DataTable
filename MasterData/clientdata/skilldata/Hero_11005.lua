-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11005.lua

local Data = {
	cueFile = "11005",
	[1100509] = {
		bhEvent = "skill.1100509",
		atkEvents = {
			[0] = {
				boxId = 1100509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110050001
					}
				}
			},
			{
				boxId = 1100509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110050011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110050009,
						110051001
					}
				}
			}
		}
	},
	[1100510] = {
		bhEvent = "skill.1100510",
		atkEvents = {
			{
				boxId = 1100509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110050011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110050010,
						110051002
					}
				}
			}
		}
	},
	[1100529] = {
		bhEvent = "skill.1100529",
		atkEvents = {
			{
				targetArea = 2,
				stunTime = 3,
				boxId = 1100529,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110050013
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110050012,
						110051003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateCondition = 1
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 40
					},
					[3] = {
						addManaNumber = 40,
						hitCue = {
							cueList = {
								10000035
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1100502
				}
			},
			[1001] = {
				state = {
					duration = 0.05,
					stateId = 1100503
				}
			},
			[1002] = {
				stunTime = 3,
				state = {}
			},
			[1003] = {
				targetArea = 3,
				boxId = 1100530,
				targetChoose = 11,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1004] = {
				targetArea = 2,
				stunTime = 1.5,
				boxId = 1100532,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1005] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 1100521
				}
			},
			[1007] = {
				targetChoose = 7,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1100522
					}
				}
			},
			[1008] = {
				targetChoose = 3,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 1100522
				}
			},
			[1009] = {
				stunTime = 2,
				state = {}
			}
		}
	},
	[1100559] = {
		hideEffect = 1,
		videoActTime = 50,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 60,
		bhEvent = "skill.1100559",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 8.5,
					stateId = 1100501
				},
				atkCue = {
					cueList = {
						110050014,
						110051004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {}
					},
					[5] = {
						state = {}
					},
					[6] = {
						state = {}
					}
				}
			},
			[0] = {
				targetArea = 2,
				boxId = 1100559,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110050016
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						110050015,
						110051005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						8540341,
						8540351,
						8540361,
						8813101
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110055001,
						110050018
					}
				}
			},
			[1001] = {
				controlTime = 2,
				controlAniName = "Float",
				state = {}
			},
			[1002] = {
				delay = 0.2,
				boxType = 1,
				boxId = 1100560,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110058001,
				110051006
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
