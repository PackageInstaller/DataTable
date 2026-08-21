-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33007.lua

local Data = {
	cueFile = "33007",
	[3300701] = {
		bhEvent = "skill.3300701",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070001,
						330071001
					}
				}
			},
			{
				boxId = 3300701,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330070003
					}
				}
			}
		}
	},
	[3300702] = {
		bhEvent = "skill.3300702",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070002,
						330071002
					}
				}
			},
			{
				boxId = 3300701,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						330070003
					}
				}
			}
		}
	},
	[3300721] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300721",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				summonMonsters = "70000412",
				state = {}
			},
			{
				summonLineChoose = 1,
				summonMonsters = "70000411",
				state = {}
			},
			{
				summonLineChoose = 3,
				summonMonsters = "70000411",
				state = {}
			},
			{
				summonLineChoose = 4,
				summonMonsters = "70000412",
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3300713
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3300715
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3300717
				}
			},
			[10] = {
				boxId = 3300721,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300712,
						3300713,
						3300714,
						3300715,
						3300716,
						3300717
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3300732
				}
			}
		}
	},
	[3300722] = {
		bhEvent = "skill.3300722",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070005,
						330071004
					}
				}
			},
			{
				boxId = 3300722,
				targetChoose = 12,
				state = {},
				hitCue = {
					cueList = {
						330070007,
						330071006
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxType = 1,
				delay = 0.6,
				randomRule = 4,
				recordSkillTargets = 1,
				flyCueId = 330070006,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						330071005
					}
				}
			}
		}
	},
	[3300751] = {
		hideEffect = 1,
		actTime = 91,
		skillTarget = 1,
		bhEvent = "skill.3300751",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070009,
						330070010,
						330071007
					}
				}
			},
			[2] = {
				weatherTime = 10,
				weatherFlag = 3300701,
				state = {}
			},
			{
				boxId = 3300751,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						330070001
					}
				},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1001] = {
				boxId = 3300752,
				targetArea = 3,
				state = {}
			}
		}
	},
	[3300771] = {
		skillTarget = 1,
		bhEvent = "skill.3300771"
	},
	[3300723] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300723",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				summonMonsters = "70000422",
				state = {}
			},
			{
				summonLineChoose = 1,
				summonMonsters = "70000421",
				state = {}
			},
			{
				summonLineChoose = 3,
				summonMonsters = "70000421",
				state = {}
			},
			{
				summonLineChoose = 4,
				summonMonsters = "70000422",
				state = {}
			},
			[10] = {
				boxId = 3300723,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300712,
						3300713,
						3300714,
						3300715,
						3300716,
						3300717
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			}
		}
	},
	[3300724] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300724",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				summonMonsters = "70000432",
				state = {}
			},
			{
				summonLineChoose = 1,
				summonMonsters = "70000431",
				state = {}
			},
			{
				summonLineChoose = 3,
				summonMonsters = "70000431",
				state = {}
			},
			{
				summonLineChoose = 4,
				summonMonsters = "70000432",
				state = {}
			},
			[10] = {
				boxId = 3300724,
				targetArea = 3,
				disablePassive = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300712,
						3300713,
						3300714,
						3300715,
						3300716,
						3300717
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			}
		}
	},
	[3300752] = {
		hideEffect = 1,
		actTime = 91,
		skillTarget = 1,
		bhEvent = "skill.3300752",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070009,
						330070010,
						330071007
					}
				}
			},
			[2] = {
				weatherTime = 10,
				weatherFlag = 3300702,
				state = {}
			},
			{
				boxId = 3300751,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						330070001
					}
				},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3300731] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300731",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				targetArea = 3,
				summonMonsters = "70000412",
				state = {}
			},
			{
				summonLineChoose = 4,
				targetArea = 3,
				summonMonsters = "70000412",
				state = {}
			},
			[10] = {
				boxId = 3300731,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300712,
						3300713,
						3300714,
						3300715,
						3300716,
						3300717
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			}
		}
	},
	[3300732] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300732",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				targetArea = 3,
				summonMonsters = "70000422",
				state = {}
			},
			{
				summonLineChoose = 4,
				targetArea = 3,
				summonMonsters = "70000422",
				state = {}
			},
			[10] = {
				boxId = 3300732,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300712,
						3300713,
						3300714,
						3300715,
						3300716,
						3300717
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			}
		}
	},
	[3300733] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300733",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 3300718
				},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 2,
				targetArea = 3,
				summonMonsters = "70000432",
				state = {}
			},
			{
				summonLineChoose = 4,
				targetArea = 3,
				summonMonsters = "70000432",
				state = {}
			},
			[10] = {
				boxId = 3300733,
				targetArea = 3,
				disablePassive = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			},
			{
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[3300725] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3300725",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						330070004,
						330071003
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "10701572",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "10701572",
				state = {}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300710
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3300711,
						3300731,
						3300732
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
