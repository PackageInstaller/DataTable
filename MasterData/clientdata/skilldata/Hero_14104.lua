-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14104.lua

local Data = {
	cueFile = "14104",
	[1410409] = {
		bhEvent = "skill.1410409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141040001,
						141041001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410409,
				flyCueId = 141040002,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 1410402
				},
				hitCue = {
					cueList = {
						141040003,
						141041002
					}
				}
			}
		}
	},
	[1410410] = {
		bhEvent = "skill.1410410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141040004,
						141041003
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410409,
				flyCueId = 141040005,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 1410402
				},
				hitCue = {
					cueList = {
						141040003,
						141041004
					}
				}
			}
		}
	},
	[1410429] = {
		bhEvent = "skill.1410429",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141040009,
						141041008
					}
				}
			},
			[1001] = {
				eventCondition = "1,2,1410401",
				targetChoose = 23,
				state = {
					duration = 1.1,
					stateId = 1410405
				}
			},
			[1002] = {
				targetChoose = 4,
				subEventId = 1008,
				subEventSkill = 1410429,
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1410406
				}
			},
			[1003] = {
				boxId = 1410429,
				targetArea = 3,
				state = {
					duration = 1.5,
					stateId = 1410407
				},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1005] = {
				disablePassive = 1,
				disableHpPassive = 1,
				eventType = 1,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1410430,
						hitCue = {
							cueList = {
								141040006,
								141041007
							}
						}
					},
					[4] = {
						boxId = 1410430,
						hitCue = {
							cueList = {
								141040006,
								141041007
							}
						}
					},
					[5] = {
						boxId = 1410430,
						hitCue = {
							cueList = {
								141040006,
								141041007
							}
						}
					},
					[6] = {
						boxId = 1410430,
						hitCue = {
							cueList = {
								141040006,
								141041007
							}
						}
					}
				}
			},
			{
				controlTime = 5,
				flyCueId = 141040010,
				boxType = 1,
				targetChoose = 23,
				unitDelay = 0.15,
				controlAniName = "idle",
				state = {
					duration = 5,
					stateId = 1410401
				},
				hitCue = {
					cueList = {
						141040011,
						141041009
					}
				}
			},
			[1006] = {
				targetChoose = 9,
				subEventType = 1,
				subEventSkill = 1410429,
				subEventId = 1007,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 8350420
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				targetChoose = 20,
				state = {
					duration = 5,
					stateId = 8350421
				}
			},
			[1008] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1410413
				}
			},
			[1009] = {
				targetChoose = 17,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82141041
				}
			},
			[1010] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 8791741
				}
			},
			[1011] = {
				controlTime = 4,
				controlAniName = "idle",
				eventCondition = "1,2,1410401,1",
				targetChoose = 23,
				state = {
					duration = 4,
					stateId = 1410401
				},
				hitCue = {
					cueList = {
						141040006,
						141041007
					}
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1410416
				}
			},
			[1015] = {
				targetChoose = 9,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21410411
				}
			},
			[1016] = {
				targetChoose = 9,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21410421
				}
			},
			[1017] = {
				targetChoose = 9,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21410431
				}
			}
		}
	},
	[1410459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 47,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 90,
		bhEvent = "skill.1410459",
		atkEvents = {
			[100] = {
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						141040012,
						141041011
					}
				}
			},
			[1001] = {
				targetArea = 3,
				boxId = 1410460,
				targetChoose = 4,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410459,
				flyCueId = 141040013,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141040014,
						141040015,
						141043001,
						141041012
					}
				}
			},
			{
				targetArea = 3,
				summonMonsters = "1620901",
				state = {},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620902"
					},
					[3] = {
						summonMonsters = "1620903"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				eventCondition = "1,2,1410401",
				targetChoose = 7,
				state = {
					duration = 1.1,
					stateId = 1410408
				}
			},
			[1003] = {
				targetChoose = 17,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410409
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141045001,
						141040016
					}
				}
			},
			[1004] = {
				targetArea = 3,
				summonMonsters = "1620903",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				141048001,
				141041010
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
