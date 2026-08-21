-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13006.lua

local Data = {
	cueFile = "13006",
	[1300609] = {
		bhEvent = "skill.1300609",
		atkEvents = {
			[0] = {
				flyCueId = 130060003,
				boxId = 1300609,
				unitDelay = 0.15,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				subEventSkill = 1300609,
				state = {
					duration = 3,
					stateId = 1300602
				},
				hitCue = {
					cueList = {
						130060004,
						130061005
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130060001,
						130060002,
						130061004
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1300609,
				unitDelay = 0.15,
				boxType = 1,
				excludeTarget = 1,
				subEventSkill = 1300609,
				eventType = 1,
				subEventId = 1002,
				flyCueId = 130060003,
				targetChoose = 7,
				state = {
					duration = 3,
					stateId = 1300602
				},
				hitCue = {
					cueList = {
						130060004,
						130061005
					}
				}
			},
			[1002] = {
				state = {
					duration = 0.1,
					stateId = 1300621
				}
			},
			[1003] = {
				boxId = 1300631,
				state = {}
			}
		}
	},
	[1300610] = {
		bhEvent = "skill.1300610",
		atkEvents = {
			[0] = {
				flyCueId = 130060003,
				boxId = 1300609,
				unitDelay = 0.15,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				subEventSkill = 1300609,
				state = {
					duration = 3,
					stateId = 1300602
				},
				hitCue = {
					cueList = {
						130060004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130060001,
						130060002
					}
				}
			}
		}
	},
	[1300659] = {
		hideTime = 10,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1300659",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1300601
				},
				atkCue = {
					cueList = {
						130060007
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxId = 1300659,
				flyCueId = 130060009,
				boxType = 1,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						130063001
					}
				},
				hitCue = {
					cueList = {
						130060008,
						10006003,
						130061003
					}
				}
			},
			[1001] = {
				boxId = 1300660,
				excludeTarget = 1,
				boxType = 1,
				eventType = 1,
				disablePassive = 1,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130060011
					}
				},
				baseCue = {
					cueList = {
						130060010
					}
				}
			},
			[1002] = {
				boxType = 1,
				delay = 0.2,
				boxId = 1300630,
				targetArea = 3,
				state = {
					chooseStateMode = 2
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				boxId = 1300661,
				disablePassive = 1,
				state = {}
			},
			[1004] = {
				controlTime = 1,
				targetChoose = 7,
				controlAniName = "freeze",
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130065001,
						130060012
					}
				}
			},
			[1005] = {
				state = {},
				baseCue = {
					cueList = {
						130060010
					}
				}
			},
			[33] = {
				state = {},
				hitCue = {
					cueList = {
						130061003
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130068001,
				130061001
			}
		}
	},
	[1300629] = {
		bhEvent = "skill.1300629",
		atkEvents = {
			[1001] = {
				delay = 0.1,
				boxId = 1300629,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						130060005
					}
				},
				hitCue = {
					cueList = {
						130060006,
						130060013
					}
				}
			},
			[1002] = {
				delay = 0.05,
				boxId = 1300630,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			}
		}
	},
	[1300691] = {
		bhEvent = "skill.1300691",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130060007
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxType = 1,
				flyCueId = 130060009,
				boxId = 1300659,
				state = {},
				hitCue = {
					cueList = {
						130060008
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
