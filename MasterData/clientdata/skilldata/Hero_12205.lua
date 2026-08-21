-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12205.lua

local Data = {
	cueFile = "12205",
	[1220509] = {
		bhEvent = "skill.1220509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122050001,
						122051001
					}
				}
			},
			{
				boxId = 1220509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122050003
					}
				}
			},
			{
				randomTargetNumber = 1,
				targetChoose = 3,
				unitDelay = 0.15,
				boxType = 1,
				excludeTarget = 1,
				flyCueId = 122050002,
				filterChuyin = 1,
				state = {
					duration = 0.1,
					stateId = 1220511
				},
				hitCue = {
					cueList = {
						122050003
					}
				}
			},
			[1001] = {
				boxId = 1220510,
				eventCondition = "1,1,1220501,1",
				eventType = 1,
				state = {}
			},
			[1002] = {
				eventCondition = "1,1,1220501",
				boxId = 1220510,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						122050013
					}
				}
			},
			[1003] = {
				eventCondition = "1,1,1220501",
				boxId = 1220510,
				targetChoose = 3,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						122050014
					}
				}
			}
		}
	},
	[1220510] = {
		bhEvent = "skill.1220510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122050004,
						122051002
					}
				}
			},
			{
				boxId = 1220509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122050006
					}
				}
			},
			{
				randomTargetNumber = 1,
				filterChuyin = 1,
				unitDelay = 0.15,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 122050005,
				targetChoose = 3,
				state = {
					duration = 0.1,
					stateId = 1220512
				},
				hitCue = {
					cueList = {
						122050006
					}
				}
			}
		}
	},
	[1220559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 95,
		bhEvent = "skill.1220559",
		atkEvents = {
			[25] = {
				state = {},
				atkCue = {
					cueList = {
						122050010,
						122055001
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						122050008
					}
				}
			},
			{
				boxId = 1220559,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122050009
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 8,
							stateId = 1220523
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1220523
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[60] = {
				state = {},
				atkCue = {
					cueList = {
						122050012
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						122051004
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				filterChuyin = 1,
				targetChoose = 3,
				excludeTarget = 1,
				state = {
					duration = 0.3,
					stateId = 1220522
				},
				hitCue = {
					cueList = {
						122050015
					}
				}
			},
			[1002] = {
				eventCondition = "1,1,1220501,1",
				boxId = 1220560,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122050009
					}
				}
			},
			[1003] = {
				eventCondition = "1,1,1220501",
				boxId = 1220560,
				eventType = 1,
				state = {
					duration = 0.1,
					stateId = 1220524
				},
				hitCue = {
					cueList = {
						122050009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1220561
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				excludeTarget = 1,
				eventCondition = "1,1,1220501",
				boxId = 1220560,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1005] = {
				randomTargetNumber = 1,
				filterChuyin = 1,
				eventCondition = "1,1,1220532",
				targetChoose = 7,
				eventProbId = 1220501,
				state = {
					duration = 0.3,
					stateId = 1220531
				},
				hitCue = {
					cueList = {
						122050015
					}
				}
			},
			[1006] = {
				state = {
					duration = 8,
					stateId = 1220523
				}
			},
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						122050007
					}
				}
			},
			[1007] = {
				disablePassive = 1,
				boxId = 1220560,
				eventCondition = "1,1,1220501",
				eventType = 1,
				state = {
					duration = 0.1,
					stateId = 1220524
				},
				hitCue = {
					cueList = {
						122050009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1220561
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				122058001,
				122051003
			}
		}
	},
	[1220529] = {
		bhEvent = "skill.1220509",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetChoose = 23,
				state = {
					duration = 2,
					stateId = 1220503
				}
			},
			[1002] = {
				boxId = 1220529,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1220506
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1220504
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1220505
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					stateId = 1220505,
					chooseStateMode = 2,
					duration = -999,
					chooseStateIds = {
						1220504
					}
				}
			},
			[1007] = {
				disablePassive = 1,
				boxId = 1220569,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 0.1,
					stateId = 8791541
				}
			},
			[1008] = {
				disablePassive = 1,
				randomTargetNumber = 1,
				filterChuyin = 1,
				boxId = 1220569,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {}
			},
			[1009] = {
				targetChoose = 23,
				state = {
					duration = 0.5,
					stateId = 1220502
				}
			},
			[1010] = {
				randomTargetNumber = 1,
				targetChoose = 3,
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1220507
				}
			},
			[1011] = {
				targetChoose = 23,
				state = {
					duration = 0.5,
					stateId = 1220536
				}
			},
			[1012] = {
				randomTargetNumber = 1,
				targetChoose = 3,
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1220537
				}
			},
			[1013] = {
				targetChoose = 23,
				state = {
					duration = 0.5,
					stateId = 1220536
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
