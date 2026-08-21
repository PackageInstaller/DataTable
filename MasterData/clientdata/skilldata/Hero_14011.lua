-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14011.lua

local Data = {
	cueFile = "14011",
	[1401109] = {
		bhEvent = "skill.1401109",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140110001,
						140111001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401109,
				flyCueId = 140110003,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1401105
				},
				hitCue = {
					cueList = {
						140110006,
						140111002,
						140110023
					}
				}
			}
		}
	},
	[1401110] = {
		bhEvent = "skill.1401110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140110002,
						140111003
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401109,
				flyCueId = 140110003,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1401105
				},
				hitCue = {
					cueList = {
						140110006,
						140111004,
						140110023
					}
				}
			}
		}
	},
	[1401111] = {
		bhEvent = "skill.1401111",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140110004,
						140111005
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401109,
				flyCueId = 140110005,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1401105
				},
				hitCue = {
					cueList = {
						140110006,
						140111006,
						140110023
					}
				}
			}
		}
	},
	[1401129] = {
		skillTarget = 1,
		bhEvent = "skill.1401129",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140110007,
						140110018,
						140111007
					}
				}
			},
			{
				unitDelay = 0.12,
				targetChoose = 7,
				flyCueId = 140110008,
				boxType = 1,
				targetArea = 2,
				state = {
					duration = -999,
					stateId = 1401101
				},
				hitCue = {
					cueList = {
						140110009,
						140111008
					}
				}
			},
			[1002] = {
				boxId = 1401130,
				delay = 0.1,
				excludeTarget = 1,
				boxType = 1,
				eventCondition = "1,2,1401105",
				eventType = 1,
				targetChoose = 7,
				baseToTarget = 1,
				state = {
					duration = 1.5,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1401103
					}
				},
				hitCue = {
					cueList = {
						140110024
					}
				}
			},
			[1004] = {
				boxId = 1401131,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140110021
					}
				}
			},
			[1005] = {
				eventCondition = "1,2,1401105",
				unitDelay = 0.25,
				boxId = 1401131,
				eventType = 1,
				flyCueId = 140110021,
				targetChoose = 7,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						140110021
					}
				}
			},
			[1006] = {
				delay = 0.3,
				boxType = 1,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 3,
					stateId = 1401101
				}
			},
			[1007] = {
				boxId = 1401129,
				disablePassive = 1,
				state = {}
			},
			[1008] = {
				boxId = 1401132,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140110009
					}
				}
			}
		}
	},
	[1401159] = {
		hideEffect = 1,
		videoActTime = 70,
		hideEvent = 13,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 84,
		bhEvent = "skill.1401159",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140110012,
						140110016
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140110017,
						140115001,
						140111010
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						140110013
					}
				}
			},
			{
				hitedAnim = "Hit",
				state = {
					duration = 8,
					stateId = 1401103
				},
				atkCue = {
					cueList = {
						140113001
					}
				},
				hitCue = {
					cueList = {
						140110014,
						10006003
					}
				}
			},
			[1001] = {
				boxId = 1401159,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1401104
				}
			},
			[1002] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401104
					}
				}
			},
			{
				targetArea = 3,
				state = {}
			},
			[1004] = {
				targetChoose = 23,
				state = {
					stateId = 1401103,
					stateOperation = 3
				}
			},
			[1005] = {
				targetChoose = 23,
				state = {
					stateId = 1401104,
					stateOperation = 3
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401107
				}
			}
		},
		videoActCue = {
			cueList = {
				140118001,
				140111009
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
