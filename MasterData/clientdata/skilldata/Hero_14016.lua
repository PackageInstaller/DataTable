-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14016.lua

local Data = {
	cueFile = "14016",
	[1401609] = {
		bhEvent = "skill.1401609",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140160001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1401609,
				flyCueId = 140160002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140160003
					}
				}
			}
		}
	},
	[1401610] = {
		bhEvent = "skill.1401610",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1401629] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1401629",
		atkEvents = {
			[100] = {
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						140160004
					}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1401601
				}
			},
			[1001] = {
				boxId = 1401629,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxId = 1401630,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				subEventId = 1005,
				subEventSkill = 1401629,
				boxId = 1401629,
				eventType = 1,
				state = {}
			},
			[1004] = {
				boxId = 1401630,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1005] = {
				eventCondition = "1,1,1401602",
				state = {},
				levelAtkEvents = {
					[2] = {
						controlTime = 2,
						controlAniName = "freeze"
					},
					[3] = {
						controlTime = 2,
						controlAniName = "freeze"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				boxId = 1401631,
				targetArea = 1,
				disablePassive = 1,
				state = {}
			},
			[1007] = {
				targetChoose = 8,
				state = {
					duration = 8.1,
					stateId = 21401611
				}
			},
			[1008] = {
				boxId = 1401632,
				eventType = 1,
				state = {}
			},
			[1009] = {
				targetChoose = 9,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21401621
				}
			},
			[1010] = {
				randomTargetNumber = 1,
				targetArea = 3,
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 21401631
				}
			}
		}
	},
	[1401659] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 20,
		prepareCamera = 1,
		prepareCamDruation = 55,
		actTime = 70,
		bhEvent = "skill.1401659",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						140160006
					}
				}
			},
			{
				subEventId = 1003,
				targetChoose = 23,
				subEventSkill = 1401659,
				state = {}
			},
			[1001] = {
				targetChoose = 23,
				state = {
					duration = 4,
					stateId = 1400001
				},
				hitCue = {
					cueList = {
						10000037
					}
				}
			},
			[1002] = {
				targetChoose = 23,
				state = {
					duration = 4,
					stateId = 1400002
				},
				hitCue = {
					cueList = {
						10000037
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {
					duration = 20,
					stateId = 1401611
				},
				atkCue = {
					cueList = {
						140160007
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						140160008
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						140160012
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140160013
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						140160008
					}
				}
			},
			[15] = {
				state = {},
				atkCue = {
					cueList = {
						140160012
					}
				}
			},
			[16] = {
				state = {},
				atkCue = {
					cueList = {
						140160013
					}
				}
			},
			[17] = {
				state = {},
				atkCue = {
					cueList = {
						140160008
					}
				}
			},
			[18] = {
				state = {},
				atkCue = {
					cueList = {
						140160012
					}
				}
			},
			[19] = {
				state = {},
				atkCue = {
					cueList = {
						140160013
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						140165001,
						140160011
					}
				}
			},
			[1003] = {
				boxId = 1401659,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140160010
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 20,
					stateId = 1401602
				}
			},
			[1004] = {
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1005] = {
				boxId = 1401660,
				targetArea = 3,
				targetChoose = 4,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140168001
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
