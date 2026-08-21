-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12004.lua

local Data = {
	cueFile = "12004",
	[1200401] = {
		bhEvent = "skill.1200401",
		atkEvents = {
			[0] = {
				boxId = 1200409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040003
					}
				}
			},
			[100] = {
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateId = 1200404,
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200404
					}
				}
			}
		}
	},
	[1200402] = {
		bhEvent = "skill.1200402",
		atkEvents = {
			[0] = {
				boxId = 1200409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040003
					}
				}
			},
			[100] = {
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200404
					}
				}
			}
		}
	},
	[1200421] = {
		actTime = 57,
		skillTarget = 1,
		bhEvent = "skill.1200421",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						120040004
					}
				}
			},
			{
				boxId = 1200429,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040006
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 8,
							stateId = 1200402
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1200402
						}
					},
					[4] = {
						state = {
							duration = 8,
							stateId = 1200402
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				state = {},
				atkCue = {
					cueList = {
						120040005
					}
				}
			},
			[1001] = {
				delay = 0.6,
				boxId = 1200430,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040006
					}
				}
			}
		}
	},
	[1200451] = {
		hideTime = 10,
		videoActTime = 31,
		hideEffect = 1,
		skillTarget = 1,
		targetInherit = -30,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 76,
		bhEvent = "skill.1200451",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1200401
				}
			},
			[101] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 2,
							stateId = 1200403
						}
					},
					[3] = {
						state = {
							duration = 2,
							stateId = 1200403
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1200469,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040011
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						120040016,
						120040017,
						120040018
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120040014,
						120045001
					}
				}
			},
			[1002] = {
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						120040015
					}
				}
			},
			[45] = {
				state = {},
				atkCue = {
					cueList = {
						120041001
					}
				}
			},
			[1003] = {
				subEventId = 1004,
				subEventType = 1,
				subEventSkill = 1200451,
				eventCondition = "1,1,1200413",
				targetArea = 3,
				addManaNumber = -100,
				state = {
					chooseStateMode = 2
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200412,
						1200413
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120048002,
				120041003
			}
		}
	},
	[1200403] = {
		bhEvent = "skill.1200403",
		atkEvents = {
			[100] = {
				flyCueId = 120040009,
				unitDelay = 0.12,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						120041002
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxId = 1200459,
				flyCueId = 120040009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040010
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1200460,
				unitDelay = 0.12,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 120040009,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						120040010
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 2
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200404
					}
				}
			}
		}
	},
	[1200452] = {
		hideTime = 10,
		shortVideoActTime = 60,
		videoActTime = 120,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 40,
		bhEvent = "skill.1200452",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 90,
					stateId = 9900008
				},
				baseCue = {
					cueList = {
						120040012
					}
				}
			},
			[101] = {
				addManaNumber = 75,
				state = {}
			},
			[1001] = {
				boxId = 1200469,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						120040011
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120048001,
				120041001
			}
		},
		shortVideoActCue = {
			cueList = {
				120048002,
				120041003
			}
		}
	},
	[1200453] = {
		actTime = 70,
		skillTarget = 1,
		bhEvent = "skill.1200453",
		atkEvents = {
			[100] = {
				targetArea = 2,
				state = {}
			},
			[0] = {
				targetArea = 2,
				boxId = 1200470,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						120041002
					}
				}
			},
			[99] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						120040013
					}
				}
			}
		}
	},
	[1200411] = {
		bhEvent = "skill.1200411",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						120041002
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxType = 1,
				flyCueId = 120040009,
				boxId = 1200471,
				state = {},
				hitCue = {
					cueList = {
						120040010
					}
				}
			},
			{
				excludeTarget = 1,
				targetChoose = 4,
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
