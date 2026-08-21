-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33110.lua

local Data = {
	cueFile = "33110",
	[3311001] = {
		bhEvent = "skill.3311001",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3311001,
				flyCueId = 331100012,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331101002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100011,
						331101001
					}
				}
			}
		}
	},
	[3311002] = {
		bhEvent = "skill.3311002",
		atkEvents = {
			{
				delay = 0.4,
				flyCueId = 331100015,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331100016
					}
				}
			},
			{
				boxId = 3311002,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331100026
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100014
					}
				}
			}
		}
	},
	[3311029] = {
		actTime = 70,
		skillTarget = 1,
		bhEvent = "skill.3311029",
		atkEvents = {
			{
				boxId = 3311029,
				delay = 0.1,
				boxType = 1,
				targetArea = 3,
				excludeTarget = 1,
				eventType = 1,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						10005008,
						10003001
					}
				},
				hitCue = {
					cueList = {
						331100002
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				atkCue = {
					cueList = {
						10006006
					}
				}
			},
			{
				boxId = 3311060,
				targetArea = 3,
				eventType = 1,
				state = {}
			},
			[1001] = {
				controlTime = 0.1,
				controlAniName = "idle",
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -100,
				state = {
					duration = -999,
					stateId = 1301402
				}
			},
			[100] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311001
					}
				},
				atkCue = {
					cueList = {
						10005003,
						331100001,
						331101003
					}
				}
			}
		}
	},
	[3311051] = {
		actTime = 16,
		bhEvent = "skill.3311051",
		atkEvents = {
			{
				boxId = 3311051,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						331100007,
						331101004
					}
				},
				hitCue = {
					cueList = {
						331100008,
						331100009
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100007
					}
				},
				hitCue = {
					cueList = {
						331100027
					}
				}
			},
			[90] = {
				state = {},
				atkCue = {
					cueList = {
						331100010
					}
				}
			}
		}
	},
	[3311052] = {
		actTime = 60,
		bhEvent = "skill.3311052",
		atkEvents = {
			{
				delay = 0.6,
				flyCueId = 331100018,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331100020,
						331101006
					}
				}
			},
			{
				boxId = 3311052,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331100021
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100017,
						331101005
					}
				},
				hitCue = {
					cueList = {
						331100019
					}
				}
			}
		}
	},
	[3311053] = {
		actTime = 40,
		bhEvent = "skill.3311053",
		atkEvents = {
			{
				boxId = 3311053,
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						331100005
					}
				},
				hitCue = {
					cueList = {
						331100006
					}
				}
			},
			{
				boxId = 3311060,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311001
					}
				},
				atkCue = {
					cueList = {
						10006006
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100003,
						331100004,
						331101007
					}
				}
			}
		}
	},
	[3311054] = {
		actTime = 40,
		bhEvent = "skill.3311054",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331100003,
						331100004,
						331101007
					}
				}
			},
			{
				boxId = 3311054,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						331100005
					}
				},
				hitCue = {
					cueList = {
						331100006
					}
				}
			},
			{
				boxId = 3311061,
				targetArea = 3,
				eventType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311001
					}
				},
				atkCue = {
					cueList = {
						10006006
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
