-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33120.lua

local Data = {
	cueFile = "33120",
	[3312001] = {
		bhEvent = "skill.3312001",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331200001,
						331201001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 3312001,
				flyCueId = 331200002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331201002
					}
				}
			}
		}
	},
	[3312002] = {
		bhEvent = "skill.3312002",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331200003,
						331201001
					}
				}
			},
			{
				flyCueId = 331200004,
				boxId = 3312001,
				unitDelay = 0.15,
				boxType = 1,
				subEventId = 1001,
				eventType = 1,
				subEventSkill = 3312002,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331201002
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 3312001,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				subEventSkill = 3312002,
				eventType = 1,
				subEventId = 1002,
				flyCueId = 331200005,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				boxId = 3312001,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				subEventSkill = 3312002,
				eventType = 1,
				subEventId = 1003,
				flyCueId = 331200005,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxId = 3312001,
				unitDelay = 0.24,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 331200005,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3312021] = {
		skillTarget = 1,
		bhEvent = "skill.3312021",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331200006,
						331201003
					}
				}
			},
			{
				targetArea = 3,
				summonMonsters = "3312010",
				state = {}
			},
			[1001] = {
				stunTime = 0.5,
				state = {
					duration = 0.5,
					stateId = 3312001
				}
			},
			[1002] = {
				targetArea = 3,
				stunTime = 3,
				boxId = 3312057,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 3312004
				},
				atkCue = {
					cueList = {
						10000090
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 3312005
				}
			}
		}
	},
	[3312051] = {
		actTime = 66,
		bhEvent = "skill.3312051",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331200007,
						331200008,
						331201004
					}
				}
			},
			{
				randomTargetNumber = 3,
				flyCueId = 10000067,
				unitDelay = 0.25,
				boxId = 3312051,
				randomRule = 2,
				eventType = 1,
				stunTime = 1,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331200010
					}
				}
			},
			{
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331200009
					}
				}
			}
		}
	},
	[3312052] = {
		actTime = 50,
		bhEvent = "skill.3312052",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331201005,
						331201006
					}
				}
			},
			{
				randomTargetNumber = 1,
				unitDelay = 0.12,
				boxType = 1,
				boxId = 3312052,
				eventType = 1,
				flyCueId = 331200012,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331200011
					}
				},
				hitCue = {
					cueList = {
						331200013,
						331201007
					}
				}
			}
		}
	},
	[3312053] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3312053",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331201005,
						331201006
					}
				}
			},
			{
				boxId = 3312053,
				unitDelay = 0.15,
				boxType = 1,
				eventType = 1,
				flyCueId = 331200012,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331200014
					}
				},
				hitCue = {
					cueList = {
						331200013,
						331201007
					}
				}
			}
		}
	},
	[3312054] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3312021",
		atkEvents = {
			[100] = {
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				targetArea = 3,
				subEventId = 1001,
				subEventSkill = 3312054,
				boxId = 3312054,
				targetChoose = 15,
				state = {}
			},
			[1001] = {
				subEventSkill = 3312054,
				boxId = 3312055,
				targetChoose = 7,
				subEventId = 1002,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						10003001
					}
				},
				hitCue = {
					cueList = {
						331201007
					}
				}
			},
			[1002] = {
				boxId = 3312056,
				targetArea = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[3312003] = {
		bhEvent = "skill.3312001",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331201005,
						331201006
					}
				}
			},
			{
				boxId = 3312003,
				unitDelay = 0.15,
				boxType = 1,
				eventType = 1,
				flyCueId = 331200012,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331200014
					}
				},
				hitCue = {
					cueList = {
						331200013,
						331201007
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
