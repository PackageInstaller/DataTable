-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33127.lua

local Data = {
	cueFile = "33127",
	[3312701] = {
		bhEvent = "skill.3312701",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270001,
						331271001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3312701,
				flyCueId = 331270002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331271002
					}
				}
			}
		}
	},
	[3312702] = {
		bhEvent = "skill.3312702",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270003,
						331271003
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3312702,
				unitDelay = 0.1,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331270004,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331270005,
						331271004
					}
				}
			}
		}
	},
	[3312721] = {
		skillTarget = 1,
		bhEvent = "skill.3312721",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270006,
						331271006
					}
				}
			},
			{
				targetArea = 3,
				addManaNumber = 15,
				state = {},
				hitCue = {
					cueList = {
						10000035,
						331270007
					}
				}
			}
		}
	},
	[3312722] = {
		skillTarget = 1,
		bhEvent = "skill.3312722",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270008,
						331271005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3312701
				}
			}
		}
	},
	[3312751] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3312751",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270009,
						331271007
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3312702
				}
			}
		}
	},
	[3312752] = {
		actTime = 50,
		bhEvent = "skill.3312752",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270011,
						331271008
					}
				}
			},
			{
				boxId = 3312752,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3312703
				},
				hitCue = {
					cueList = {
						331270012
					}
				}
			}
		}
	},
	[3312753] = {
		actTime = 50,
		bhEvent = "skill.3312753",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270013,
						331270014,
						331271009
					}
				}
			},
			{
				boxId = 3312753,
				unitDelay = 0.1,
				boxType = 1,
				targetChoose = 10,
				stunTime = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331270015
					}
				}
			}
		}
	},
	[3312754] = {
		actTime = 30,
		bhEvent = "skill.3312754",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331270016,
						331270017,
						331271010
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3312754,
				targetChoose = 21,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331270018
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
