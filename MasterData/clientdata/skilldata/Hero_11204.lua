-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11204.lua

local Data = {
	cueFile = "11204",
	[1120409] = {
		bhEvent = "skill.1120409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112040001,
						112041001
					}
				}
			},
			{
				boxId = 1120409,
				state = {},
				hitCue = {
					cueList = {
						112040002
					}
				}
			}
		}
	},
	[1120459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 65,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 110,
		bhEvent = "skill.1120459",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112040018,
						112045001,
						112041004
					}
				},
				hitCue = {
					cueList = {
						112040014,
						112040015
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						112045002,
						112040019,
						112041005
					}
				},
				hitCue = {
					cueList = {
						112040016
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						112043001
					}
				},
				hitCue = {
					cueList = {
						112040017
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {},
				atkCue = {
					cueList = {
						112040006
					}
				}
			},
			{
				hitedAnim = "Hit",
				subEventId = 1002,
				subEventSkill = 1120459,
				boxId = 1120459,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1120401
						}
					},
					[3] = {
						state = {
							duration = 10,
							stateId = 1120401
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1120460,
						hitCue = {
							cueList = {
								10000008
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1120462,
				eventCondition = "1,1,1120403",
				eventType = 1,
				state = {}
			},
			[1002] = {
				subEventId = 1001,
				subEventSkill = 1120459,
				boxId = 1120461,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				112048001,
				112041003
			}
		}
	},
	[1120410] = {
		bhEvent = "skill.1120410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112040003,
						112040005,
						112041002
					}
				}
			},
			{
				boxId = 1120409,
				state = {},
				hitCue = {
					cueList = {
						112040004
					}
				}
			}
		}
	},
	[1120429] = {
		bhEvent = "skill.1120429",
		atkEvents = {
			[1001] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112040006
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112040010
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxType = 1,
				unitDelay = 0.3,
				boxId = 1120429,
				targetArea = 3,
				randomRule = 3,
				excludeTarget = 1,
				subEventSkill = 1120429,
				subEventId = 1005,
				flyCueId = 112040008,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						112040009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				delay = 10,
				targetArea = 3,
				boxType = 1,
				state = {
					duration = 1,
					stateId = 1120402
				}
			},
			[1005] = {
				randomTargetNumber = 2,
				boxType = 1,
				unitDelay = 0.3,
				boxId = 1120429,
				targetArea = 3,
				eventCondition = "1,1,8791340",
				excludeTarget = 1,
				flyCueId = 112040008,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						112040009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				boxId = 1120430,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
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
