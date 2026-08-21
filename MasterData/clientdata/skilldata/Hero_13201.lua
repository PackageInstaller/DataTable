-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13201.lua

local Data = {
	cueFile = "13201",
	[1320109] = {
		bhEvent = "skill.1320109",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132010001,
						132011001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxType = 1,
				flyCueId = 132010002,
				boxId = 1320109,
				state = {},
				hitCue = {
					cueList = {
						132010005,
						132011002
					}
				}
			}
		}
	},
	[1320110] = {
		bhEvent = "skill.1320110",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						132010003,
						132011003
					}
				}
			},
			{
				unitDelay = 0.12,
				boxType = 1,
				flyCueId = 132010004,
				boxId = 1320109,
				state = {},
				hitCue = {
					cueList = {
						132010005,
						132011004
					}
				}
			}
		}
	},
	[1320129] = {
		skillTarget = 2,
		bhEvent = "skill.1320129",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132010008,
						132011005
					}
				}
			},
			{
				controlTime = 8,
				boxType = 1,
				delay = 0.15,
				controlAniName = "timelock",
				state = {
					duration = 3,
					stateId = 1320101
				},
				hitCue = {
					cueList = {
						132010009,
						132011006
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 10,
						state = {
							duration = 8,
							stateId = 1320101
						}
					},
					[4] = {
						controlTime = 6,
						state = {
							duration = 6,
							stateId = 1320101
						}
					},
					[5] = {
						controlTime = 6,
						state = {
							duration = 6,
							stateId = 1320101
						}
					},
					[6] = {
						controlTime = 6,
						state = {
							duration = 6,
							stateId = 1320101
						}
					}
				}
			},
			[1001] = {
				controlTime = 6,
				boxType = 1,
				delay = 0.5,
				controlAniName = "timelock",
				state = {
					duration = 4,
					stateId = 1320101
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 8,
						state = {
							duration = 6,
							stateId = 1320101
						}
					},
					[4] = {
						controlTime = 4
					},
					[5] = {
						controlTime = 4
					},
					[6] = {
						controlTime = 4
					}
				}
			},
			[1003] = {
				boxId = 1320130,
				state = {}
			},
			[1004] = {
				addManaNumber = 6,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 8
					},
					[3] = {
						addManaNumber = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				randomTargetNumber = 1,
				delay = 0.15,
				boxType = 1,
				controlTime = 8,
				subEventId = 1005,
				excludeTarget = 1,
				eventCondition = "1,1,1320111",
				subEventSkill = 1320129,
				controlAniName = "timelock",
				targetChoose = 20,
				state = {
					duration = 3,
					stateId = 1320101
				},
				hitCue = {
					cueList = {
						132010009,
						132011006
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 10,
						state = {
							duration = 8,
							stateId = 1320101
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1320102
				}
			}
		}
	},
	[1320159] = {
		hideTime = 10,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 85,
		bhEvent = "skill.1320159",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						132010011
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1320105
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {
					duration = 1,
					stateId = 1320106
				},
				hitCue = {
					cueList = {
						132010013,
						132010012,
						132010015
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320103
					}
				}
			},
			[0] = {
				boxId = 1320159,
				targetChoose = 7,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						10006003
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						132015001,
						132010014,
						132011008
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320106
					}
				}
			},
			[1002] = {
				state = {
					duration = 2,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1320101
					}
				}
			},
			[3] = {
				targetChoose = 7,
				eventCondition = "1,3,1320106,1",
				state = {},
				hitCue = {
					cueList = {
						132010012,
						132010013,
						132010015
					}
				}
			},
			{
				randomTargetNumber = 2,
				targetChoose = 7,
				excludeTarget = 1,
				state = {
					duration = 1,
					stateId = 1320106
				},
				hitCue = {
					cueList = {
						132010012,
						132010013,
						132010015
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				132018001,
				132011007
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
