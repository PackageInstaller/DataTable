-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15002.lua

local Data = {
	cueFile = "15002",
	[1500209] = {
		bhEvent = "skill.1500209",
		atkEvents = {
			[0] = {
				boxId = 1500209,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150020001,
						150021003
					}
				}
			},
			[100] = {
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						150020008
					}
				}
			}
		}
	},
	[1500210] = {
		bhEvent = "skill.1500210",
		atkEvents = {
			[0] = {
				boxId = 1500209,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150020001,
						150021003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150020007
					}
				}
			}
		}
	},
	[1500259] = {
		hideTime = 10,
		videoActTime = 50,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1500259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150020005,
						150020006
					}
				}
			},
			[0] = {
				targetArea = 3,
				boxId = 1500259,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						150020003,
						150021002
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1500202
				}
			},
			[10] = {
				state = {}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						150025001,
						150020004
					}
				}
			},
			{
				targetChoose = 16,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1500260,
						hitCue = {
							cueList = {
								150020003
							}
						}
					},
					[3] = {
						boxId = 1500260,
						hitCue = {
							cueList = {
								150020003
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 16,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1500201
						}
					},
					[3] = {
						state = {
							duration = 10,
							stateId = 1500201
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						150020004,
						150025001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				150021005,
				150028002
			}
		}
	},
	[1500229] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.1500229",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150020009
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500203
				},
				hitCue = {
					cueList = {
						150020002,
						150021004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1500229
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				boxType = 1,
				delay = 0.3,
				boxId = 1500230,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82150021
				}
			}
		}
	},
	[1500260] = {
		hideTime = 10,
		shortVideoActTime = 60,
		videoActTime = 140,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1500260",
		atkEvents = {
			[10] = {
				targetArea = 3,
				state = {
					duration = 90,
					stateId = 9900006
				}
			},
			[11] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						150029002
					}
				}
			},
			[0] = {
				targetArea = 3,
				boxId = 1500259,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						150021002
					}
				},
				hitCue = {
					cueList = {
						150020003
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				150028001,
				150021001
			}
		},
		shortVideoActCue = {
			cueList = {
				150028002,
				150021005
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
