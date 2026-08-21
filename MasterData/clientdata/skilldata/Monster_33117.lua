-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33117.lua

local Data = {
	cueFile = "33117",
	[3311701] = {
		bhEvent = "skill.3311701",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170002,
						331171001
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxId = 3311701,
				flyCueId = 331170004,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 10,
					stateId = 3311701
				},
				hitCue = {
					cueList = {
						331170006,
						331171002
					}
				}
			},
			[1001] = {
				state = {
					duration = 5,
					stateId = 3311702
				}
			}
		}
	},
	[3311702] = {
		bhEvent = "skill.3311702",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170003,
						331171003
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxId = 3311701,
				flyCueId = 331170005,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 10,
					stateId = 3311701
				},
				hitCue = {
					cueList = {
						331170006,
						331171004
					}
				}
			}
		}
	},
	[3311703] = {
		bhEvent = "skill.3311703",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170002,
						331171001
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxId = 3311702,
				flyCueId = 331170004,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331170006,
						331171002
					}
				}
			}
		}
	},
	[3311704] = {
		bhEvent = "skill.3311704",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170003,
						331171003
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxId = 3311702,
				flyCueId = 331170005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331170006,
						331171004
					}
				}
			}
		}
	},
	[3311752] = {
		actTime = 60,
		bhEvent = "skill.3311752",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170009,
						331170010,
						331171005
					}
				}
			},
			[0] = {
				delay = 0.3,
				flyCueId = 331170011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331170012
					}
				}
			},
			{
				boxId = 3311752,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 3311703
				},
				hitCue = {
					cueList = {
						331170013
					}
				}
			}
		}
	},
	[3311721] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3311721",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 3311704
				},
				atkCue = {
					cueList = {
						331170009,
						331170010,
						331171005,
						10005003
					}
				}
			},
			[0] = {
				randomTargetNumber = 1,
				boxId = 3311721,
				flyCueId = 331170011,
				boxType = 1,
				targetChoose = 7,
				delay = 0.3,
				state = {
					duration = 8,
					stateId = 3311703
				},
				hitCue = {
					cueList = {
						331170012
					}
				}
			},
			{
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				excludeTarget = 1,
				boxId = 3311721,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331170013
					}
				}
			}
		}
	},
	[3311751] = {
		actTime = 65,
		bhEvent = "skill.3311751",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331170014,
						331171006
					}
				}
			},
			[0] = {
				boxId = 3311751,
				targetChoose = 7,
				state = {
					duration = 8,
					stateId = 3311703
				}
			},
			[1001] = {
				boxId = 3311760,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			{
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331170015
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
